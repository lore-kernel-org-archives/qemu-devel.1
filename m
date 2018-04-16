Received: from eggs.gnu.org ([2001:4830:134:3::10]:57492)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1f881w-000113-Vd
	for qemu-devel@nongnu.org; Mon, 16 Apr 2018 13:35:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1f881w-0006zR-0f
	for qemu-devel@nongnu.org; Mon, 16 Apr 2018 13:35:04 -0400
Received: from mail-ot0-x243.google.com ([2607:f8b0:4003:c0f::243]:46537)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1f881v-0006z6-Qd
	for qemu-devel@nongnu.org; Mon, 16 Apr 2018 13:35:03 -0400
Received: by mail-ot0-x243.google.com with SMTP id v64-v6so18302181otb.13
	for <qemu-devel@nongnu.org>; Mon, 16 Apr 2018 10:35:03 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1523551221-11612-5-git-send-email-imammedo@redhat.com>
References: <1523551221-11612-1-git-send-email-imammedo@redhat.com>
	<1523551221-11612-5-git-send-email-imammedo@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 16 Apr 2018 18:34:42 +0100
Message-ID: <CAFEAcA94GLNWcG=cMkg93hfqMZ7UdE9Vsx01FP_o6J5a_jRzBQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH for-2.13 4/4] arm/boot: split load_dtb()
 from arm_load_kernel()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>, Eric Auger <eric.auger@redhat.com>

On 12 April 2018 at 17:40, Igor Mammedov <imammedo@redhat.com> wrote:
> load_dtb() depends on arm_load_kernel() to figure out place
> in RAM where it should be loaded, but it's not required for
> arm_load_kernel() to work. Sometimes it's neccesary for
> devices added with -device/device_add to be enumerated in
> DTB as well, which's lead to [1] and surrounding commits to
> add 2 more machine_done notifiers with non obvious ordering
> to make dynamic sysbus devices initialization happen in
> the right order.
>
> However instead of moving whole arm_load_kernel() in to
> machine_done, it's sufficient to move only load_dtb() into
> virt_machine_done() notifier and remove ArmLoadKernelNotifier/
> /PlatformBusFDTNotifierParams notifiers, which saves us ~90LOC
> and simplifies code flow quite a bit.
> Later would allow to consolidate DTB generation within one
> function for 'mach-virt' board and make it reentrant so it
> could generate updated DTB in device hotplug secenarios.
>
> While at it rename load_dtb() to arm_load_dtb() since it's
> public now.
>
> Add additional field skip_dtb_autoload to struct arm_boot_info
> to allow manual DTB load later in mach-virt and to avoid touching
> all other boards to explicitly call arm_load_dtb().
>
>  1) (ac9d32e hw/arm/boot: arm_load_kernel implemented as a machine init done notifier)
>
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> ---
>  include/hw/arm/arm.h        | 37 ++++++++++++++++++-------
>  include/hw/arm/sysbus-fdt.h | 37 +++++--------------------
>  hw/arm/boot.c               | 67 +++++++++++----------------------------------
>  hw/arm/sysbus-fdt.c         | 64 ++++---------------------------------------
>  hw/arm/virt.c               | 64 ++++++++++++++++++++-----------------------
>  5 files changed, 86 insertions(+), 183 deletions(-)
>
> diff --git a/include/hw/arm/arm.h b/include/hw/arm/arm.h
> index 188d18b..312e533 100644
> --- a/include/hw/arm/arm.h
> +++ b/include/hw/arm/arm.h
> @@ -39,15 +39,6 @@ DeviceState *armv7m_init(MemoryRegion *system_memory, int mem_size, int num_irq,
>   */
>  void armv7m_load_kernel(ARMCPU *cpu, const char *kernel_filename, int mem_size);
>
> -/*
> - * struct used as a parameter of the arm_load_kernel machine init
> - * done notifier
> - */
> -typedef struct {
> -    Notifier notifier; /* actual notifier */
> -    ARMCPU *cpu; /* handle to the first cpu object */
> -} ArmLoadKernelNotifier;
> -
>  /* arm_boot.c */
>  struct arm_boot_info {
>      uint64_t ram_size;
> @@ -56,6 +47,9 @@ struct arm_boot_info {
>      const char *initrd_filename;
>      const char *dtb_filename;
>      hwaddr loader_start;
> +    hwaddr dtb_start;
> +    hwaddr dtb_limit;
> +    bool skip_dtb_autoload;

skip_dtb_autoload is a flag that the board code needs to set, so can
we have a comment documenting what it does, please?

>      /* multicore boards that use the default secondary core boot functions
>       * need to put the address of the secondary boot code, the boot reg,
>       * and the GIC address in the next 3 values, respectively. boards that

Otherwise this looks good, especially the diffstat :-)
I'm assuming Eric will check the platform-bus/sysbus-fdt parts
of this patch.

thanks
-- PMM
