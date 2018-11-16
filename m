Received: from eggs.gnu.org ([2001:4830:134:3::10]:45483)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <nicholas.a.hudson@gmail.com>) id 1gNhLS-0000dv-Gt
	for qemu-devel@nongnu.org; Fri, 16 Nov 2018 11:51:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <nicholas.a.hudson@gmail.com>) id 1gNhLQ-0000oL-Bb
	for qemu-devel@nongnu.org; Fri, 16 Nov 2018 11:51:50 -0500
References: <d9876015-2126-79fe-415f-ca7427ab3059@gmail.com>
	<CAFEAcA84aoWNdu1T90iR0uw7emfF1SRF09FjL+gu12yrdAr2yA@mail.gmail.com>
From: Nick Hudson <nicholas.a.hudson@gmail.com>
Message-ID: <327575eb-cb88-8ba2-d61a-c133f1c0d30c@gmail.com>
Date: Fri, 16 Nov 2018 16:51:28 +0000
MIME-Version: 1.0
In-Reply-To: <CAFEAcA84aoWNdu1T90iR0uw7emfF1SRF09FjL+gu12yrdAr2yA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH] Support u-boot noload images for arm as
 used by NetBSD/evbarm GENERIC kernel.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>


On 16/11/2018 14:34, Peter Maydell wrote:
> On 7 November 2018 at 13:19, Nick Hudson <nicholas.a.hudson@gmail.com> wrote:
>> noload kernels are loaded with the u-boot image header and as a result
>> the header size needs adding to the entry point.  Fake up a hdr so the
>> kernel image is loaded at the right address and the entry point is
>> adjusted appropriately
>>
>> Signed-off-by: Nick Hudson <skrll@netbsd.org>
> Hi; thanks for this patch.


Thanks for reviewing.

>
>> ---
>>   hw/arm/boot.c         |  8 +++++---
>>   hw/core/loader.c      | 12 +++++++++---
>>   hw/core/uboot_image.h |  1 +
>>   3 files changed, 15 insertions(+), 6 deletions(-)
>>
>> diff --git a/hw/arm/boot.c b/hw/arm/boot.c
>> index 586baa9b64..450267566a 100644
>> --- a/hw/arm/boot.c
>> +++ b/hw/arm/boot.c
>> @@ -30,8 +30,9 @@
>>    * Documentation/arm/Booting and Documentation/arm64/booting.txt
>>    * They have different preferred image load offsets from system RAM base.
>>    */
>> -#define KERNEL_ARGS_ADDR 0x100
>> -#define KERNEL_LOAD_ADDR 0x00010000
>> +#define KERNEL_ARGS_ADDR   0x100
>> +#define KERNEL_NOLOAD_ADDR 0x00000000
>> +#define KERNEL_LOAD_ADDR   0x00010000
>>   #define KERNEL64_LOAD_ADDR 0x00080000
>>
>>   #define ARM64_TEXT_OFFSET_OFFSET    8
>> @@ -1078,7 +1079,8 @@ void arm_load_kernel(ARMCPU *cpu, struct arm_boot_info
>> *info)
>>       }
>>       entry = elf_entry;
>>       if (kernel_size < 0) {
>> -        kernel_size = load_uimage_as(info->kernel_filename, &entry, NULL,
>> +        uint64_t loadaddr = info->loader_start + KERNEL_NOLOAD_ADDR;
>> +        kernel_size = load_uimage_as(info->kernel_filename, &entry,
>> &loadaddr,
>>                                        &is_linux, NULL, NULL, as);
> I don't really understand this change. The API for load_uimage_as()
> says that the loadaddr argument is an output, not an input, and that
> it is ignored if it is NULL. If we're changing the API here then
> we need to (a) document that change and (b) check all the callers
> can handle it. It would be better if we can avoid having to do that.


I chose to pass where the noload kernel should be loaded via loadaddr as 
arm_load_kernel knows where RAM is. Perhaps there's a better way?

BTW, I should have mentioned that I pass the same address that is used 
for the bootloader. This address is adjusted in load_uboot_image by the 
size of the uboot header. As the bootloader is smaller than the uboot 
header it all works. uboot loads the whole image including header and 
adjusts the entry point by the header size.

>
>>       }
>>       if (arm_feature(&cpu->env, ARM_FEATURE_AARCH64) && kernel_size < 0) {
>> diff --git a/hw/core/loader.c b/hw/core/loader.c
>> index aa0b3fc867..952562c2da 100644
>> --- a/hw/core/loader.c
>> +++ b/hw/core/loader.c
>> @@ -638,13 +638,19 @@ static int load_uboot_image(const char *filename,
>> hwaddr *ep, hwaddr *loadaddr,
>>           goto out;
>>
>>       if (hdr->ih_type != image_type) {
>> -        fprintf(stderr, "Wrong image type %d, expected %d\n", hdr->ih_type,
>> -                image_type);
>> -        goto out;
>> +        if (image_type != IH_TYPE_KERNEL && hdr->ih_type !=
>> IH_TYPE_KERNEL_NOLOAD) {
>> +            fprintf(stderr, "Wrong image type %d, expected %d\n",
>> hdr->ih_type,
>> +                    image_type);
>> +            goto out;
>> +        }
>>       }
>>
>>       /* TODO: Implement other image types.  */
>>       switch (hdr->ih_type) {
>> +    case IH_TYPE_KERNEL_NOLOAD:
>> +        hdr->ih_load = *loadaddr + sizeof(*hdr);
> This will segfault if the user passed in NULL for loadaddr,
> as they are allowed to do by the API.


I can update the header with this API change and update callers if 
that's ok?


>
>> +        hdr->ih_ep += hdr->ih_load;
>> +
> Cases which fall through need a specific
>       /* fall through */
>
> comment. This tells human readers and static analysis tools that
> it was intentional.


Sure, I did wonder if this was expected.


Thanks,

Nick
