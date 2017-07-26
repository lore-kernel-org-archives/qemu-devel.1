Received: from eggs.gnu.org ([2001:4830:134:3::10]:47495)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1daKeK-0004Cv-1Z
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 07:38:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1daKeF-0002Ua-Ta
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 07:38:44 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:54453
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pasic@linux.vnet.ibm.com>)
	id 1daKeF-0002UR-OZ
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 07:38:39 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v6QBYYOB030507
	for <qemu-devel@nongnu.org>; Wed, 26 Jul 2017 07:38:39 -0400
Received: from e06smtp10.uk.ibm.com (e06smtp10.uk.ibm.com [195.75.94.106])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2bxpk2bh5y-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 26 Jul 2017 07:38:39 -0400
Received: from localhost
	by e06smtp10.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pasic@linux.vnet.ibm.com>;
	Wed, 26 Jul 2017 12:38:37 +0100
References: <20170725224442.13383-1-pasic@linux.vnet.ibm.com>
	<20170725224442.13383-3-pasic@linux.vnet.ibm.com>
	<20170726030125.GO7483@bjsdjshi@linux.vnet.ibm.com>
From: Halil Pasic <pasic@linux.vnet.ibm.com>
Date: Wed, 26 Jul 2017 13:38:33 +0200
MIME-Version: 1.0
In-Reply-To: <20170726030125.GO7483@bjsdjshi@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Message-Id: <cf37838e-d92e-408e-2cc1-662ad5c89b29@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH 2/2] s390x/css: fix bits must be zero check
 for TIC
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cohuck@redhat.com>, Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>, qemu-devel@nongnu.org



On 07/26/2017 05:01 AM, Dong Jia Shi wrote:
> Hello Halil,
> 
> * Halil Pasic <pasic@linux.vnet.ibm.com> [2017-07-26 00:44:42 +0200]:
> 
>> According to the PoP bit positions 0-3 and 8-32 of the format-1 CCW must
>> contain zeros.  Bits 0-3 are already covered by cmd_code validity
>> checking, and bit 32 is covered by the CCW address checking.
>>
>> Bits 8-31 correspond to CCW1.flags and CCW1.count.  Currently we only
>> check for the absence of certain flags.  Let's fix this.
>>
>> Signed-off-by: Halil Pasic <pasic@linux.vnet.ibm.com>
>> ---
>>  hw/s390x/css.c | 3 ++-
>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/hw/s390x/css.c b/hw/s390x/css.c
>> index d17e21b7af..1f04ce4a1b 100644
>> --- a/hw/s390x/css.c
>> +++ b/hw/s390x/css.c
>> @@ -884,7 +884,8 @@ static int css_interpret_ccw(SubchDev *sch, hwaddr ccw_addr,
>>              ret = -EINVAL;
>>              break;
>>          }
>> -        if (ccw.flags & (CCW_FLAG_CC | CCW_FLAG_DC)) {
>> +        if (ccw.flags || ccw.count) {
>> +            /* We have already sanitized these if fmt 0. */
> ccw0 does not have the same restrictions as ccw1. We don't sanitize
> these for ccw0.
> 

Yes you have misunderstood. For fmt 1 these bits have to be zero
otherwise a program-check condition is to be recognized. Thus we don't
sanitize for fmt 1.

For fmt 0 these bits are ignored. We sanitize them in
for some time now by setting them to zero when making a CCW1
out of an CCW0. If we would recognize a program-check for
fmt 0 that would be wrong.

The comment tells us why this code is good for CCW0 too,
and why can we omit sch->ccw_fmt_1 from the conditon.

Regards,
Halil

> (This comment is still here. Did I misunderstand things? :)
> 
>>              ret = -EINVAL;
>>              break;
>>          }
>> -- 
>> 2.11.2
>>
> 
> With the comment removed:
> Reviewed-by: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
> 
