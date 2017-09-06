Received: from eggs.gnu.org ([2001:4830:134:3::10]:48740)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1dpZdi-0006nQ-Kr
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 08:41:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1dpZdZ-0007PP-2y
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 08:41:06 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:38847)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pasic@linux.vnet.ibm.com>)
	id 1dpZdY-0007Ov-QO
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 08:40:57 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v86CdHFB112573
	for <qemu-devel@nongnu.org>; Wed, 6 Sep 2017 08:40:55 -0400
Received: from e06smtp14.uk.ibm.com (e06smtp14.uk.ibm.com [195.75.94.110])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2ctbwfrt87-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 06 Sep 2017 08:40:54 -0400
Received: from localhost
	by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pasic@linux.vnet.ibm.com>;
	Wed, 6 Sep 2017 13:40:52 +0100
References: <20170905111645.18068-1-pasic@linux.vnet.ibm.com>
	<20170905111645.18068-2-pasic@linux.vnet.ibm.com>
	<20170906141846.0be413fb.cohuck@redhat.com>
From: Halil Pasic <pasic@linux.vnet.ibm.com>
Date: Wed, 6 Sep 2017 14:40:48 +0200
MIME-Version: 1.0
In-Reply-To: <20170906141846.0be413fb.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Message-Id: <bd30a18f-6d22-e5a7-6e8c-08f628466cc4@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH 1/5] s390x/css: introduce css data stream
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



On 09/06/2017 02:18 PM, Cornelia Huck wrote:
> On Tue,  5 Sep 2017 13:16:41 +0200
> Halil Pasic <pasic@linux.vnet.ibm.com> wrote:
> 
>> This is a preparation for introducing handling for indirect data
>> addressing and modified indirect data addressing (CCW). Here we introduce
>> an interface which should make the addressing scheme transparent for the
>> client code. Here we implement only basic scheme (no IDA or MIDA).
> 
> s/basic scheme/the basic scheme/
> 

Nod.

>>
>> Signed-off-by: Halil Pasic <pasic@linux.vnet.ibm.com>
>> ---
>>  hw/s390x/css.c         | 55 +++++++++++++++++++++++++++++++++++++++++
>>  include/hw/s390x/css.h | 67 ++++++++++++++++++++++++++++++++++++++++++++++++++
>>  2 files changed, 122 insertions(+)
>>
>> diff --git a/hw/s390x/css.c b/hw/s390x/css.c
>> index 1880b1a0ff..87d913f81c 100644
>> --- a/hw/s390x/css.c
>> +++ b/hw/s390x/css.c
>> @@ -783,6 +783,61 @@ static CCW1 copy_ccw_from_guest(hwaddr addr, bool fmt1)
>>      }
>>      return ret;
>>  }
>> +/**
>> + * If out of bounds marks the stream broken. If broken returns -EINVAL,
>> + * otherwise the requested  length (may be zero)
> 
> s/requested  length/requested length/
> 

Nod.

>> + */
>> +static inline int cds_check_len(CcwDataStream *cds, int len)
>> +{
>> +    if (cds->at_byte + len > cds->count) {
>> +        cds->flags |= CDS_F_STREAM_BROKEN;
>> +    }
>> +    return cds->flags & CDS_F_STREAM_BROKEN ? -EINVAL : len;
>> +}
>> +
>> +static int ccw_dstream_rw_noflags(CcwDataStream *cds, void *buff, int len,
>> +                                  CcwDataStreamOp op)
>> +{
>> +    int ret;
>> +
>> +    ret = cds_check_len(cds, len);
>> +    if (ret <= 0) {
>> +        return ret;
>> +    }
>> +    if (op == CDS_OP_A) {
>> +        goto incr;
>> +    }
>> +    ret = address_space_rw(&address_space_memory, cds->cda,
>> +                           MEMTXATTRS_UNSPECIFIED, buff, len, op);
>> +    if (ret != MEMTX_OK) {
>> +        cds->flags |= CDS_F_STREAM_BROKEN;
> 
> Do we want to distinguish between different reasons for the stream
> being broken? I.e, is there a case where we want to signal different
> errors back to the caller?
> 

Hm, after I've done the error handling it seems that basically
everything is to be handled with a program check. The stream
records the place where the problem was encountered, so for debug
we would not have to search for long.

There seems to be no need to distinguish.

>> +        return -EINVAL;
>> +    }
>> +incr:
>> +    cds->at_byte += len;
>> +    cds->cda += len;
>> +    return 0;
>> +}
>> +
>> +void ccw_dstream_init(CcwDataStream *cds, CCW1 const *ccw, ORB const *orb)
>> +{
>> +    /*
>> +     * We don't support MIDA (an optional facility) yet and we
>> +     * catch this earlier. Just for expressing the precondition.
>> +     */
>> +    assert(!(orb->ctrl1 & ORB_CTRL1_MASK_MIDAW));
> 
> I don't know, this is infrastructure, should it trust its callers? If
> you keep the assert, please make it g_assert().


Why g_assert? I think g_assert comes form a test framework, this is not
test code.

I feel more comfortable having this assert around.

> 
>> +    cds->flags = (orb->ctrl0 & ORB_CTRL0_MASK_I2K ? CDS_F_I2K : 0) |
>> +                 (orb->ctrl0 & ORB_CTRL0_MASK_C64 ? CDS_F_C64 : 0) |
>> +                 (ccw->flags & CCW_FLAG_IDA ? CDS_F_IDA : 0);
>> +    cds->count = ccw->count;
>> +    cds->cda_orig = ccw->cda;
>> +    ccw_dstream_rewind(cds);
>> +    if (!(cds->flags & CDS_F_IDA)) {
>> +        cds->op_handler = ccw_dstream_rw_noflags;
>> +    } else {
>> +        assert(false);
> 
> Same here.
> 
> Or should we make this return an error and have the callers deal with
> that? (I still need to look at the users.)
> 

This assert is going away soon (patch 4). I'm not sure doing much more here
is justified.

>> +    }
>> +}
>>  
>>  static int css_interpret_ccw(SubchDev *sch, hwaddr ccw_addr,
>>                               bool suspend_allowed)
> 
