Received: from eggs.gnu.org ([2001:4830:134:3::10]:54247)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1dagq3-0007kl-6I
	for qemu-devel@nongnu.org; Thu, 27 Jul 2017 07:20:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1dagpz-00013E-SI
	for qemu-devel@nongnu.org; Thu, 27 Jul 2017 07:20:19 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:58188
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pasic@linux.vnet.ibm.com>)
	id 1dagpz-000122-Mc
	for qemu-devel@nongnu.org; Thu, 27 Jul 2017 07:20:15 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v6RBJuxm178584
	for <qemu-devel@nongnu.org>; Thu, 27 Jul 2017 07:20:14 -0400
Received: from e06smtp11.uk.ibm.com (e06smtp11.uk.ibm.com [195.75.94.107])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2bycygeej2-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 27 Jul 2017 07:20:13 -0400
Received: from localhost
	by e06smtp11.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pasic@linux.vnet.ibm.com>;
	Thu, 27 Jul 2017 12:18:53 +0100
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com
	[9.149.105.59])
	by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with
	ESMTP id v6RBIos538797328
	for <qemu-devel@nongnu.org>; Thu, 27 Jul 2017 11:18:50 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D79C7A4053
	for <qemu-devel@nongnu.org>; Thu, 27 Jul 2017 12:15:55 +0100 (BST)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BE41AA4051
	for <qemu-devel@nongnu.org>; Thu, 27 Jul 2017 12:15:55 +0100 (BST)
Received: from oc3836556865.ibm.com (unknown [9.152.224.141])
	by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP
	for <qemu-devel@nongnu.org>; Thu, 27 Jul 2017 12:15:55 +0100 (BST)
References: <20170725224442.13383-1-pasic@linux.vnet.ibm.com>
	<20170725224442.13383-3-pasic@linux.vnet.ibm.com>
	<20170727100138.74ad2ad4@gondolin>
From: Halil Pasic <pasic@linux.vnet.ibm.com>
Date: Thu, 27 Jul 2017 13:18:49 +0200
MIME-Version: 1.0
In-Reply-To: <20170727100138.74ad2ad4@gondolin>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <fc4e9602-64ad-f010-b5f8-a0b2d19732a6@linux.vnet.ibm.com>
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
To: qemu-devel@nongnu.org



On 07/27/2017 10:01 AM, Cornelia Huck wrote:
> On Wed, 26 Jul 2017 00:44:42 +0200
> Halil Pasic <pasic@linux.vnet.ibm.com> wrote:
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
> 
> I'd tweak that to
> 
> /* We have already sanitized these if converted from fmt 0. */
> 

Fine with me.

> Seems less confusing.
> 
>>              ret = -EINVAL;
>>              break;
>>          }
> 
> I'm inclined to pick this as a 2.10 bugfix. Patch 1 still needs work
> from what I've seen.
> 

Hm. The commit message becomes inaccurate if this goes in before
patch 1. We still have must be zero bits which should be handled
by the address (ccw.cda) checking. I think I can fix patch 1 today.
