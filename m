Received: from eggs.gnu.org ([2001:4830:134:3::10]:37340)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1fLSa6-00058N-Rc
	for qemu-devel@nongnu.org; Wed, 23 May 2018 08:09:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1fLSa3-0005Fc-MS
	for qemu-devel@nongnu.org; Wed, 23 May 2018 08:09:26 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:46558 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eric.auger@redhat.com>)
	id 1fLSa3-0005EW-Hh
	for qemu-devel@nongnu.org; Wed, 23 May 2018 08:09:23 -0400
References: <1527070950-208350-1-git-send-email-imammedo@redhat.com>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <99505ab5-d5fe-11ba-7f85-ea24c6f39ae2@redhat.com>
Date: Wed, 23 May 2018 14:09:20 +0200
MIME-Version: 1.0
In-Reply-To: <1527070950-208350-1-git-send-email-imammedo@redhat.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] arm: fix qemu crash on startup with -bios
 option
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org
Cc: Andrew Jones <drjones@redhat.com>, Peter Maydell <peter.maydell@linaro.org>

Hi Igor,

On 05/23/2018 12:22 PM, Igor Mammedov wrote:
> When QEMU is started with following CLI
>  -machine virt,gic-version=3,accel=kvm -cpu host -bios AAVMF_CODE.fd
> it crashes with abort at
>  accel/kvm/kvm-all.c:2164:
>  KVM_SET_DEVICE_ATTR failed: Group 6 attr 0x000000000000c665: Invalid argument
> 
> Which is caused by implicit dependecy of kvm_arm_gicv3_reset() on
dependency
> arm_gicv3_icc_reset() where the later is called by CPU reset
> reset callback.
> 
> However commit:
>  3b77f6c arm/boot: split load_dtb() from arm_load_kernel()
> broke CPU reset callback registration in case
> 
>   arm_load_kernel()
>       ...
>       if (!info->kernel_filename || info->firmware_loaded)
> 
> branch is taken, i.e. it's sufficient to provide a firmware
> or do not provide kernel on CLI to skip cpu reset callback
> registration, where before offending commit the callback
> has been registered unconditionally.
> 
> Fix it by registering the callback right at the begging of
beginning
> arm_load_kernel() unconditionally instead of doing it at the end.
> 
> NOTE:
>  we probably should eleminate that dependency anyways as well as
eliminate, anyway?
>  separate arch CPU reset parts from arm_load_kernel() into CPU
>  itself, but that refactoring that I probably would have to do
>  anyways later for CPU hotplug to work.
may deserve some rewording.
> 
> Reported-by: Auger Eric <eric.auger@redhat.com>
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>

Thank you for the quick fix. It fixes the reported issue.

Reviewed-by: Eric Auger <eric.auger@redhat.com>
Tested-by: Eric Auger <eric.auger@redhat.com>

Thanks

Eric
> ---
>  Thanks Andrew Jones <drjones@redhat.com> for host with reproducer.
> ---
>  hw/arm/boot.c | 18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)
> 
> diff --git a/hw/arm/boot.c b/hw/arm/boot.c
> index 9496f33..1e48166 100644
> --- a/hw/arm/boot.c
> +++ b/hw/arm/boot.c
> @@ -926,6 +926,15 @@ void arm_load_kernel(ARMCPU *cpu, struct arm_boot_info *info)
>      static const ARMInsnFixup *primary_loader;
>      AddressSpace *as = arm_boot_address_space(cpu, info);
>  
> +    /* CPU objects (unlike devices) are not automatically reset on system
> +     * reset, so we must always register a handler to do so. If we're
> +     * actually loading a kernel, the handler is also responsible for
> +     * arranging that we start it correctly.
> +     */
> +    for (cs = first_cpu; cs; cs = CPU_NEXT(cs)) {
> +        qemu_register_reset(do_cpu_reset, ARM_CPU(cs));
> +    }
> +
>      /* The board code is not supposed to set secure_board_setup unless
>       * running its code in secure mode is actually possible, and KVM
>       * doesn't support secure.
> @@ -1143,15 +1152,6 @@ void arm_load_kernel(ARMCPU *cpu, struct arm_boot_info *info)
>          ARM_CPU(cs)->env.boot_info = info;
>      }
>  
> -    /* CPU objects (unlike devices) are not automatically reset on system
> -     * reset, so we must always register a handler to do so. If we're
> -     * actually loading a kernel, the handler is also responsible for
> -     * arranging that we start it correctly.
> -     */
> -    for (cs = first_cpu; cs; cs = CPU_NEXT(cs)) {
> -        qemu_register_reset(do_cpu_reset, ARM_CPU(cs));
> -    }
> -
>      if (!info->skip_dtb_autoload && have_dtb(info)) {
>          if (arm_load_dtb(info->dtb_start, info, info->dtb_limit, as) < 0) {
>              exit(1);
> 
