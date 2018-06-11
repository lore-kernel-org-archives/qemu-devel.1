Received: from eggs.gnu.org ([2001:4830:134:3::10]:57295)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1fSKS2-0005EI-Th
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 06:53:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1fSKRy-0002ub-2H
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 06:53:30 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:42920
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1fSKRx-0002uC-Sh
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 06:53:25 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w5BAnh4A050502
	for <qemu-devel@nongnu.org>; Mon, 11 Jun 2018 06:53:25 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2jhp7puw1d-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 11 Jun 2018 06:53:24 -0400
Received: from localhost
	by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Mon, 11 Jun 2018 11:53:23 +0100
References: <1528636325-4237-1-git-send-email-thuth@redhat.com>
	<3a7d6318-c827-3aa3-2799-7e383132beb3@de.ibm.com>
	<20180611112410.4e2eb406.cohuck@redhat.com>
	<13aab353-a21e-586d-53b2-27c8bd40fa32@redhat.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Mon, 11 Jun 2018 12:53:19 +0200
MIME-Version: 1.0
In-Reply-To: <13aab353-a21e-586d-53b2-27c8bd40fa32@redhat.com>
Content-Language: en-US
Message-Id: <1e2b315a-62d7-2e9b-5636-f29494876772@de.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] hw/s390x/ipl: Fix crash that occurs when
 -kernel is used with small images
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, Cornelia Huck <cohuck@redhat.com>
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org



On 06/11/2018 12:08 PM, Thomas Huth wrote:
> On 11.06.2018 11:24, Cornelia Huck wrote:
>> On Mon, 11 Jun 2018 09:49:39 +0200
>> Christian Borntraeger <borntraeger@de.ibm.com> wrote:
>>
>>> On 06/10/2018 03:12 PM, Thomas Huth wrote:
>>>> Add a sanity check to fix the following crash:
>>>>
>>>> $ echo "Insane in the mainframe" > /tmp/test.txt
>>>> $ s390x-softmmu/qemu-system-s390x -nographic -kernel /tmp/test.txt
>>>> Segmentation fault (core dumped)
>>>>
>>>> Signed-off-by: Thomas Huth <thuth@redhat.com>  
>>>
>>> Reviewed-by: Christian Borntraeger <borntraeger@de.ibm.com>
>>>
>>> I think a similar problem exists for INITRD_PARM_START and INITRD_PARM_SIZE. No?
>>
>> I think so as well.
> 
> You're right:
> 
> $ s390x-softmmu/qemu-system-s390x -kernel /tmp/test.txt \
>                                   -initrd /tmp/test.txt
> Segmentation fault (core dumped)
> 
> Shall I sent a v2 of this patch, or do you prefer a separate patch for
> that issue?

Whatever is easier for you.

> 
>>>> ---
>>>>  hw/s390x/ipl.c | 3 ++-
>>>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/hw/s390x/ipl.c b/hw/s390x/ipl.c
>>>> index 04245b5..9bb9b50 100644
>>>> --- a/hw/s390x/ipl.c
>>>> +++ b/hw/s390x/ipl.c
>>>> @@ -168,7 +168,8 @@ static void s390_ipl_realize(DeviceState *dev, Error **errp)
>>>>           * we can not rely on the ELF entry point - it was 0x800 (the SALIPL
>>>>           * loader) and it won't work. For this case we force it to 0x10000, too.
>>>>           */
>>>> -        if (pentry == KERN_IMAGE_START || pentry == 0x800) {
>>>> +        if ((pentry == KERN_IMAGE_START || pentry == 0x800) &&
>>>> +            kernel_size > KERN_PARM_AREA + strlen(ipl->cmdline)) {
>>>>              ipl->start_addr = KERN_IMAGE_START;
>>>>              /* Overwrite parameters in the kernel image, which are "rom" */
>>>>              strcpy(rom_ptr(KERN_PARM_AREA), ipl->cmdline);
>>
>> The outcome of this is that we don't write into areas we must not write
>> into, but we still have a broken "kernel" and will simply fail if the
>> thing we're pointing to isn't a valid PSW. I guess that's what we want
>> ("crap in, crap out"), i.e. no fallback to the bios or something like
>> that?
> 
> Yes, I think "crap in, crap out" is ok here. Theoretically, the user
> could also have a self-made micro-kernel that is just one byte smaller
> than KERN_PARM_AREA, and this would still work with this patch, so no
> need for an extra error message in that case.
