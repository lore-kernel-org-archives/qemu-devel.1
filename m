Received: from eggs.gnu.org ([2001:4830:134:3::10]:34150)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1duhL3-0003CH-RZ
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 11:55:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1duhKy-0004Uj-62
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 11:55:01 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:35636
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pasic@linux.vnet.ibm.com>)
	id 1duhKx-0004Sq-QY
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 11:54:55 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v8KAxPxB134688
	for <qemu-devel@nongnu.org>; Wed, 20 Sep 2017 07:01:57 -0400
Received: from e06smtp14.uk.ibm.com (e06smtp14.uk.ibm.com [195.75.94.110])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2d3phjt8cm-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 20 Sep 2017 07:01:57 -0400
Received: from localhost
	by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pasic@linux.vnet.ibm.com>;
	Wed, 20 Sep 2017 12:01:55 +0100
References: <20170919182745.90280-1-pasic@linux.vnet.ibm.com>
	<20170919182745.90280-6-pasic@linux.vnet.ibm.com>
	<20170920101159.0aaff3d6.cohuck@redhat.com>
From: Halil Pasic <pasic@linux.vnet.ibm.com>
Date: Wed, 20 Sep 2017 13:01:51 +0200
MIME-Version: 1.0
In-Reply-To: <20170920101159.0aaff3d6.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <64127cd2-bb90-650d-0f55-149a811edcf5@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v3 5/5] s390x/css: support ccw IDA
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>
Cc: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>, Pierre Morel <pmorel@linux.vnet.ibm.com>, qemu-devel@nongnu.org



On 09/20/2017 10:11 AM, Cornelia Huck wrote:
> On Tue, 19 Sep 2017 20:27:45 +0200
> Halil Pasic <pasic@linux.vnet.ibm.com> wrote:
> 
>> Let's add indirect data addressing support for our virtual channel
>> subsystem. This implementation does not bother with any kind of
>> prefetching. We simply step through the IDAL on demand.
>>
>> Signed-off-by: Halil Pasic <pasic@linux.vnet.ibm.com>
>> Signed-off-by: Cornelia Huck <cohuck@redhat.com>
> 
> My s-o-b is a bit preliminary ;)
> 
>> ---
>>  hw/s390x/css.c | 117 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
>>  1 file changed, 116 insertions(+), 1 deletion(-)
>>
>> diff --git a/hw/s390x/css.c b/hw/s390x/css.c
>> index 2d37a9ddde..a3ce6d89b6 100644
>> --- a/hw/s390x/css.c
>> +++ b/hw/s390x/css.c
>> @@ -827,6 +827,121 @@ incr:
>>      return 0;
>>  }
>>  
>> +/* returns values between 1 and bsz, where bsz is a power of 2 */
>> +static inline uint16_t ida_continuous_left(hwaddr cda, uint64_t bsz)
>> +{
>> +    return bsz - (cda & (bsz - 1));
>> +}
>> +
>> +static inline uint64_t ccw_ida_block_size(uint8_t flags)
>> +{
>> +    if ((flags & CDS_F_C64) && !(flags & CDS_F_I2K)) {
>> +        return 1ULL << 12;
>> +    }
>> +    return 1ULL << 11;
>> +}
>> +
>> +static inline int ida_read_next_idaw(CcwDataStream *cds, bool ccw_fmt1,
>> +                                     bool idaw_fmt_2)
>> +{
>> +    union {uint64_t fmt2; uint32_t fmt1; } idaw;
>> +    int ret;
>> +    hwaddr idaw_addr;
>> +
>> +    if (idaw_fmt_2) {
>> +        idaw_addr = cds->cda_orig + sizeof(idaw.fmt2) * cds->at_idaw;
>> +        if (idaw_addr & 0x07 && cds_ccw_addrs_ok(idaw_addr, 0, ccw_fmt1)) {
> 
> So, what is supposed to happen if the idaw_addr is not aligned
> correctly _and_ is violating the limits?

You are right this is obviously wrong.

Should have been 
if (idaw_addr & 0x07 || !cds_ccw_addrs_ok(idaw_addr, 0, ccw_fmt1)) {

> 
>> +            return -EINVAL; /* channel program check */
>> +        }
>> +        ret = address_space_rw(&address_space_memory, idaw_addr,
>> +                               MEMTXATTRS_UNSPECIFIED, (void *) &idaw.fmt2,
>> +                               sizeof(idaw.fmt2), false);
>> +        cds->cda = be64_to_cpu(idaw.fmt2);
>> +    } else {
>> +        idaw_addr = cds->cda_orig + sizeof(idaw.fmt1) * cds->at_idaw;
>> +        if (idaw_addr & 0x03 && cds_ccw_addrs_ok(idaw_addr, 0, ccw_fmt1)) {

Same here.

>> +            return -EINVAL; /* channel program check */
>> +        }
>> +        ret = address_space_rw(&address_space_memory, idaw_addr,
>> +                               MEMTXATTRS_UNSPECIFIED, (void *) &idaw.fmt1,
>> +                               sizeof(idaw.fmt1), false);
>> +        cds->cda = be64_to_cpu(idaw.fmt1);
>> +    }
>> +    ++(cds->at_idaw);
>> +    if (ret != MEMTX_OK) {
>> +        /* assume inaccessible address */
>> +        return -EINVAL; /* channel program check */
>> +
>> +    }
>> +    return 0;
>> +}
> 
