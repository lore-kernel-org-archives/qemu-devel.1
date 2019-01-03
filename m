Received: from eggs.gnu.org ([208.118.235.92]:60714)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <nicholas.a.hudson@gmail.com>) id 1gf6CJ-000111-Qp
	for qemu-devel@nongnu.org; Thu, 03 Jan 2019 11:50:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <nicholas.a.hudson@gmail.com>) id 1gf6CI-0004SQ-EK
	for qemu-devel@nongnu.org; Thu, 03 Jan 2019 11:50:19 -0500
References: <975b9131-9937-cfea-3b5d-ef36d0c2b761@gmail.com>
	<CAFEAcA-2tWtEqd-Z0xqNMeocf4rns+FihrAPudiQGz+85HFjJg@mail.gmail.com>
From: Nick Hudson <nicholas.a.hudson@gmail.com>
Message-ID: <7b61db39-7059-6286-2282-b90f45a85faf@gmail.com>
Date: Thu, 3 Jan 2019 16:50:05 +0000
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-2tWtEqd-Z0xqNMeocf4rns+FihrAPudiQGz+85HFjJg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3] Support u-boot noload images for arm as
 used by, NetBSD/evbarm GENERIC kernel.
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



On 03/01/2019 16:20, Peter Maydell wrote:
> On Tue, 11 Dec 2018 at 12:27, Nick Hudson <nicholas.a.hudson@gmail.com> wrote:
>>
>>
>> noload kernels are loaded with the u-boot image header and as a result
>> the header size needs adding to the entry point.  Fake up a hdr so the
>> kernel image is loaded at the right address and the entry point is
>> adjusted appropriately.
>>
>> The bootloader fits in the space that the uboot header would have occupied.
>>
>> Clarify the load_uimage API to state the passing of a load address when an
>> image doesn't specify one, or when loading a ramdisk is expected.
>>
>> Adjust callers of load_uimage, etc.
>>
>> Signed-off-by: Nick Hudson<skrll@netbsd.org>
>>
>> ---
>>    hw/arm/boot.c          |  8 +++++---
>>    hw/core/loader.c       | 19 ++++++++++++++++---
>>    hw/core/uboot_image.h  |  1 +
>>    hw/microblaze/boot.c   |  2 +-
>>    hw/nios2/boot.c        |  2 +-
>>    hw/ppc/e500.c          |  1 +
>>    hw/ppc/ppc440_bamboo.c |  2 +-
>>    hw/ppc/sam460ex.c      |  2 +-
>>    include/hw/loader.h    |  7 ++++++-
>>    9 files changed, 33 insertions(+), 11 deletions(-)
> 
> Hi; I tried applying your patch, but unfortunately it looks like
> your email client has mangled it to the point that it can't
> be applied:
>   * it is format=flowed, so long lines have been wrapped
>   * some whitespace has been turned into UTF-8 non-breaking space characters
> I tried to manually fix these up, but didn't succeed.
> 
> It looks like you're using Thunderbird -- the kernel docs
> have some config setting suggestions that might help:
> https://www.kernel.org/doc/html/v4.11/process/email-clients.html#thunderbird-gui
> or you could try switching to 'git send-email'.
> 
> I've reviewed the patch for content and it's mostly good:
> I just have a couple more questions below.
> 
>> diff --git a/hw/arm/boot.c b/hw/arm/boot.c
>> index 586baa9b64..450267566a 100644
>> --- a/hw/arm/boot.c
>> +++ b/hw/arm/boot.c
>> @@ -30,8 +30,9 @@
>>     * Documentation/arm/Booting and Documentation/arm64/booting.txt
>>     * They have different preferred image load offsets from system RAM base.
>>     */
>> -#define KERNEL_ARGS_ADDR 0x100
>> -#define KERNEL_LOAD_ADDR 0x00010000
>> +#define KERNEL_ARGS_ADDR   0x100
>> +#define KERNEL_NOLOAD_ADDR 0x00000000
> 
> If I'm reading the code right, this requests that noload images
> are loaded at offset zero into RAM, yes ?

Not quite.

They're loaded as if the full noload image (including uboot header)
was loaded at offset zero, but as load_uboot_image doesn't load the 
header then the image body (minus the header) is loaded at offset
zero + the size of the u-boot header, i.e. 0x40. 

> That's not a great
> choice, because we put our little mini bootloader at offset 0,
> and so the two will clash.

Fortuntately, the bootloader fits in the space that the uboot header would
have occupied.

My commit message has 

"The bootloader fits in the space that the uboot header would have occupied."

to try and described this. I could add more of a description if required?

> Can we put them somewhere else
> (above BOOTLOADER_MAX_SIZE, probably at a 64K page boundary) ?

I don't think this is necessary.

> If they must go at offset 0 then we'd need to refuse to load
> noload images if they set is_linux to true. (We only load the
> mini bootloader if is_linux is true, so that's the only case where
> there's a clash.)

Nor this.


> 
>> +#define KERNEL_LOAD_ADDR   0x00010000
>>    #define KERNEL64_LOAD_ADDR 0x00080000
>>
>>    #define ARM64_TEXT_OFFSET_OFFSET    8
>> @@ -1078,7 +1079,8 @@ void arm_load_kernel(ARMCPU *cpu, struct
>> arm_boot_info *info)
>>        }
>>        entry = elf_entry;
>>        if (kernel_size < 0) {
>> -        kernel_size = load_uimage_as(info->kernel_filename, &entry, NULL,
>> +        uint64_t loadaddr = info->loader_start + KERNEL_NOLOAD_ADDR;
>> +        kernel_size = load_uimage_as(info->kernel_filename, &entry,
>> &loadaddr,
>>                                         &is_linux, NULL, NULL, as);
>>        }
>>        if (arm_feature(&cpu->env, ARM_FEATURE_AARCH64) && kernel_size < 0) {
>> diff --git a/hw/core/loader.c b/hw/core/loader.c
>> index aa0b3fc867..7362197162 100644
>> --- a/hw/core/loader.c
>> +++ b/hw/core/loader.c
>> @@ -638,13 +638,26 @@ static int load_uboot_image(const char *filename,
>> hwaddr *ep, hwaddr *loadaddr,
>>            goto out;
>>
>>        if (hdr->ih_type != image_type) {
>> -        fprintf(stderr, "Wrong image type %d, expected %d\n", hdr->ih_type,
>> -                image_type);
>> -        goto out;
>> +        if (image_type != IH_TYPE_KERNEL &&
>> +            hdr->ih_type != IH_TYPE_KERNEL_NOLOAD) {
> 
> I think you have this condition wrong. Suppose we are
> trying to load image_type == IH_TYPE_KERNEL and we are
> passed a hdr->ih_type == IH_TYPE_RAMDISK. With this change
> we'll stop rejecting that as an error.
> I think you want:
>      if (!(image_type == IH_TYPE_KERNEL &&
>            hdr->ih_type == IH_TYPE_KERNEL_NOLOAD)) {
> 
> because the only kind of mismatch we want to accept is
> "we're looking for KERNEL and we got KERNEL_NOLOAD".

yeah, thanks.

[snip]


> 
> thanks
> -- PMM
> 

thanks for the review.

I'll send v4 with only the condition fixed and more descritive commit 
message (and correct formatting). ok?

Nick
