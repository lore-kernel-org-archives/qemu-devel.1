Received: from eggs.gnu.org ([2001:4830:134:3::10]:47955)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1fXMsp-0004aR-I5
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 04:30:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1fXMsk-00054F-Kc
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 04:29:59 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:37408
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1fXMsk-00053p-Ek
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 04:29:54 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w5P8Swan125588
	for <qemu-devel@nongnu.org>; Mon, 25 Jun 2018 04:29:53 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2jtus62tg3-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 25 Jun 2018 04:29:53 -0400
Received: from localhost
	by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Mon, 25 Jun 2018 09:29:51 +0100
References: <20180622194736.GA5794@roeck-us.net>
	<126ac556-0602-b927-58f5-cb5f65a5e0ec@de.ibm.com>
	<88d9afed-f91d-c320-13c8-9a93fc52b700@de.ibm.com>
	<20180625100548.64222dad.cohuck@redhat.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Mon, 25 Jun 2018 10:29:46 +0200
MIME-Version: 1.0
In-Reply-To: <20180625100548.64222dad.cohuck@redhat.com>
Content-Language: en-US
Message-Id: <d56829a3-fecf-b812-d002-8ee22ae08da2@de.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] s390 qemu boot failure in -next
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>
Cc: Guenter Roeck <linux@roeck-us.net>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, qemu-s390x <qemu-s390x@nongnu.org>, qemu-devel <qemu-devel@nongnu.org>, Thomas Huth <thuth@redhat.com>



On 06/25/2018 10:05 AM, Cornelia Huck wrote:
> On Mon, 25 Jun 2018 09:27:59 +0200
> Christian Borntraeger <borntraeger@de.ibm.com> wrote:
> 
>> Also adding QEMU.
>>
>> On 06/25/2018 09:10 AM, Christian Borntraeger wrote:
>>>
>>>
>>> On 06/22/2018 09:47 PM, Guenter Roeck wrote:  
>>>> Hi,
>>>>
>>>> starting with commit 's390/boot: make head.S and als.c be part of the
>>>> decompressor only' in -next, s390 immages no longer boot in qemu.
>>>> As far as I can see, the reason is that the command line is no longer
>>>> passed from qemu to the kernel, which results in a panic because the
>>>> root file system can not be mounted.
>>>>
>>>> Was this change made on purpose ? If so, is there a way to get qemu
>>>> back to working ?  
>>>
>>> Certainly not on purpose.
>>>
>>> Vasily, I can reproduce this with KVM and an external kernel boot of the vmlinux file (the elf file)
>>>
>>> e.g.
>>>
>>> qemu-system-s390 -enable-kvm -nographic -kernel vmlinux -append "this string no longer is command line"
>>>
>>> The compressed image (bzImage) seems to work fine though.
>>>
>>> This seems to be an unfortunate side effect of QEMUs ways to "guess" its Linux (checking for start
>>> address 0x10000, which is no longer true for the vmlinux file). With the pure vmlinux elf file
>>> the load address is 0x100000 as there is no unpacker.
> 
> Do we consider these locations to be an exported interface, or is it
> just QEMU guessing?

It is using  what zipl has hardcoded. This works fine for the final image (with the 
unpacker), but being able to boot the elf file was just a very nice feature of QEMU.

> 
>>>
>>> Guenter, can you check if arch/s390/boot/bzImage works for you as a workaround?  
>>
>> Something like this in QEMU 
>>
>> diff --git a/hw/s390x/ipl.c b/hw/s390x/ipl.c
>> index f278036fa7..14153ce880 100644
>> --- a/hw/s390x/ipl.c
>> +++ b/hw/s390x/ipl.c
>> @@ -187,11 +187,13 @@ static void s390_ipl_realize(DeviceState *dev, Error **errp)
>>           */
>>          if (pentry == KERN_IMAGE_START || pentry == 0x800) {
>>              ipl->start_addr = KERN_IMAGE_START;
>> -            /* Overwrite parameters in the kernel image, which are "rom" */
>> -            strcpy(rom_ptr(KERN_PARM_AREA), ipl->cmdline);
>>          } else {
>>              ipl->start_addr = pentry;
>>          }
>> +       if (ipl->cmdline) {
>> +            /* If there is a command line, put it in the right place */
>> +            strcpy(rom_ptr(KERN_PARM_AREA), ipl->cmdline);
>> +       }
> 
> Check for the magic Linux string (like in the non-elf case) first?

Even that does not exists in vmlinux but only in bzImage with the latest patchset
(in next, but not upstream yet)
> 
>>  
>>          if (ipl->initrd) {
>>              ram_addr_t initrd_offset;
>>
>> would put the command line in no matter what the start address is.
> 
> I'm for putting that one in (and backporting it to qemu-stable). It's a
> bit worrying, though, that our ipl code is so fragile...

We actually have to combine this with Thomas fix (to check for rom_ptr returning
something sane). It seems that ipl->commandline is always there, so we have to
check for strlen!=0 it seems..

I mean if somebody ask for "-append something" we can certainly always write something
if there is rom/ram.
