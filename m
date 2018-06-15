Received: from eggs.gnu.org ([2001:4830:134:3::10]:47926)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fTj7q-0002nv-0M
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 03:26:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fTj7m-0008Fp-1L
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 03:26:26 -0400
References: <1528738007-29122-1-git-send-email-thuth@redhat.com>
	<d4a53d7a-60c0-b98a-bd2a-fd06b2f0e822@redhat.com>
	<20180615091350.73bcc26f.cohuck@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <380c533c-de45-8f35-8bad-a41d28b7e222@redhat.com>
Date: Fri, 15 Jun 2018 09:26:17 +0200
MIME-Version: 1.0
In-Reply-To: <20180615091350.73bcc26f.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [qemu-s390x] [PATCH v2] hw/s390x/ipl: Fix crashes
 that occurs when -kernel is used with small images
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org, qemu-devel@nongnu.org

On 15.06.2018 09:13, Cornelia Huck wrote:
> On Thu, 14 Jun 2018 21:08:43 +0200
> Thomas Huth <thuth@redhat.com> wrote:
> 
>> On 11.06.2018 19:26, Thomas Huth wrote:
>>> Add a sanity checks to fix the following two crashes:
>>>
>>> $ echo "Insane in the mainframe" > /tmp/test.txt
>>> $ s390x-softmmu/qemu-system-s390x -kernel /tmp/test.txt -append xyz
>>> Segmentation fault (core dumped)
>>> $ s390x-softmmu/qemu-system-s390x -kernel /tmp/test.txt -initrd /tmp/test.txt
>>> Segmentation fault (core dumped)
>>>
>>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>>> ---
>>>  v2: Fixed 2nd crash with -initrd
>>>
>>>  hw/s390x/ipl.c | 9 ++++++---
>>>  1 file changed, 6 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/hw/s390x/ipl.c b/hw/s390x/ipl.c
>>> index 04245b5..2ff8f20 100644
>>> --- a/hw/s390x/ipl.c
>>> +++ b/hw/s390x/ipl.c
>>> @@ -168,7 +168,8 @@ static void s390_ipl_realize(DeviceState *dev, Error **errp)
>>>           * we can not rely on the ELF entry point - it was 0x800 (the SALIPL
>>>           * loader) and it won't work. For this case we force it to 0x10000, too.
>>>           */
>>> -        if (pentry == KERN_IMAGE_START || pentry == 0x800) {
>>> +        if ((pentry == KERN_IMAGE_START || pentry == 0x800) &&
>>> +            kernel_size > KERN_PARM_AREA + strlen(ipl->cmdline)) {
>>>              ipl->start_addr = KERN_IMAGE_START;
>>>              /* Overwrite parameters in the kernel image, which are "rom" */
>>>              strcpy(rom_ptr(KERN_PARM_AREA), ipl->cmdline);
>>> @@ -195,8 +196,10 @@ static void s390_ipl_realize(DeviceState *dev, Error **errp)
>>>               * we have to overwrite values in the kernel image,
>>>               * which are "rom"
>>>               */
>>> -            stq_p(rom_ptr(INITRD_PARM_START), initrd_offset);
>>> -            stq_p(rom_ptr(INITRD_PARM_SIZE), initrd_size);
>>> +            if (kernel_size > INITRD_PARM_SIZE + 8) {
>>> +                stq_p(rom_ptr(INITRD_PARM_START), initrd_offset);
>>> +                stq_p(rom_ptr(INITRD_PARM_SIZE), initrd_size);
>>> +            }
>>>          }
>>>      }
>>>      /*  
>>
>> I just had to discover that this breaks the argv handling in
>> kvm-unit-tests. Cornelia, could you please unqueue this patch again?
>> I'll try to come up with a better solution...
> 
> Argh. I wonder why?

kvm-unit-tests are ELF files which are not loaded to address 0, but
still use the same entry point as Linux (0x10000) to be able to use the
"--append" option of QEMU. Thus the check "kernel_size > KERN_PARM_AREA
+ strlen(ipl->cmdline)" does not work here. We'd need something like
"start_addr + kernel_size > KERN_PARM_AREA + strlen(ipl->cmdline)"
instead - but this does not make too much sense with ELF files that have
multiple segments either.

The correct fix is to check the size when calling rom_ptr() instead. I
just sent a patch that does this.

 Thomas
