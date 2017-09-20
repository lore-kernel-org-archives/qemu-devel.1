Received: from eggs.gnu.org ([2001:4830:134:3::10]:45910)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1duesY-0003tU-Bp
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 09:17:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1duesU-0001cS-D7
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 09:17:26 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:35740)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pasic@linux.vnet.ibm.com>)
	id 1duesU-0001c1-3f
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 09:17:22 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v8KBZ28B091960
	for <qemu-devel@nongnu.org>; Wed, 20 Sep 2017 07:35:08 -0400
Received: from e06smtp12.uk.ibm.com (e06smtp12.uk.ibm.com [195.75.94.108])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2d3n781a1g-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 20 Sep 2017 07:35:07 -0400
Received: from localhost
	by e06smtp12.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pasic@linux.vnet.ibm.com>;
	Wed, 20 Sep 2017 12:34:24 +0100
References: <20170919182745.90280-1-pasic@linux.vnet.ibm.com>
	<20170919182745.90280-5-pasic@linux.vnet.ibm.com>
	<20170920100640.79900c9f.cohuck@redhat.com>
From: Halil Pasic <pasic@linux.vnet.ibm.com>
Date: Wed, 20 Sep 2017 13:34:21 +0200
MIME-Version: 1.0
In-Reply-To: <20170920100640.79900c9f.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Message-Id: <1f526c43-6967-e30c-25c7-3b079e0598d3@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v3 4/5] 390x/css: introduce maximum data
 address checking
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



On 09/20/2017 10:06 AM, Cornelia Huck wrote:
> On Tue, 19 Sep 2017 20:27:44 +0200
> Halil Pasic <pasic@linux.vnet.ibm.com> wrote:
> 
>> The architecture mandates the addresses to be  accessed on the first
>> indirection level (that is, the data addresses without IDA, and the
>> (M)IDAW addresses with (M)IDA) to be checked against an CCW format
>> dependent limit maximum address.  If a violation is detected, the storage
>> access is not to be performed and a channel program check needs to be
>> generated. As of today, we fail to do this check.
>>
>> Let us stick even closer to the architecture specification.
>>
>> Signed-off-by: Halil Pasic <pasic@linux.vnet.ibm.com>
>> ---
>>  hw/s390x/css.c         | 10 ++++++++++
>>  include/hw/s390x/css.h |  1 +
>>  2 files changed, 11 insertions(+)
>>
>> diff --git a/hw/s390x/css.c b/hw/s390x/css.c
>> index 6b0cd8861b..2d37a9ddde 100644
>> --- a/hw/s390x/css.c
>> +++ b/hw/s390x/css.c
>> @@ -795,6 +795,11 @@ static inline int cds_check_len(CcwDataStream *cds, int len)
>>      return cds->flags & CDS_F_STREAM_BROKEN ? -EINVAL : len;
>>  }
>>  
>> +static inline bool cds_ccw_addrs_ok(hwaddr addr, int len, bool ccw_fmt1)
> 
> cds_cda_limit_ok?
> 

I use cda to point to the 2 level in case of IDA. This is about
level 1 (addressed by the ccw directly). That's why I used ccw_addrs
but if you think cds_cda_limit_ok is better I can live with that.

We could also think about renaming cds->cda. Btw what does cda stand
for (channel data address is my guess)?

Regards,
Halil

>> +{
>> +    return (addr + len) < (ccw_fmt1 ? (1UL << 31) : (1UL << 24));
>> +}
>> +
>>  static int ccw_dstream_rw_noflags(CcwDataStream *cds, void *buff, int len,
>>                                    CcwDataStreamOp op)
>>  {
> 
> Looks good.
> 
