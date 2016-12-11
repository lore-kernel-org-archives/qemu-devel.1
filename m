Received: from eggs.gnu.org ([2001:4830:134:3::10]:38889)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <christoffer.dall@linaro.org>) id 1cG76k-0005sz-D5
	for qemu-devel@nongnu.org; Sun, 11 Dec 2016 11:36:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <christoffer.dall@linaro.org>) id 1cG76h-0005nG-02
	for qemu-devel@nongnu.org; Sun, 11 Dec 2016 11:36:14 -0500
Received: from mail-wm0-f46.google.com ([74.125.82.46]:36451)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <christoffer.dall@linaro.org>)
	id 1cG76g-0005hU-GT
	for qemu-devel@nongnu.org; Sun, 11 Dec 2016 11:36:10 -0500
Received: by mail-wm0-f46.google.com with SMTP id g23so30431073wme.1
	for <qemu-devel@nongnu.org>; Sun, 11 Dec 2016 08:35:49 -0800 (PST)
Date: Sun, 11 Dec 2016 17:35:02 +0100
From: Christoffer Dall <christoffer.dall@linaro.org>
Message-ID: <20161211163502.GB6352@cbox>
References: <1481301020-21777-1-git-send-email-peter.maydell@linaro.org>
	<1481301020-21777-5-git-send-email-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1481301020-21777-5-git-send-email-peter.maydell@linaro.org>
Subject: Re: [Qemu-devel] [PATCH 4/4] hw/arm/virt: Don't incorrectly claim
 architectural timer to be edge-triggered
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, Andrew Jones <drjones@redhat.com>, Marc Zyngier <marc.zyngier@arm.com>

On Fri, Dec 09, 2016 at 04:30:20PM +0000, Peter Maydell wrote:
> The architectural timers in ARM CPUs all have level triggered interrupts
> (unless you're using KVM on a host kernel before 4.4, which misimplemented
> them as edge-triggered).
> 
> We were incorrectly describing them in the device tree as edge triggered.
> This can cause problems for guest kernels in 4.8 before rc6:
>  * pre-4.8 kernels ignore the values in the DT
>  * 4.8 before rc6 write the DT values to the GIC config registers
>  * newer than rc6 ignore the DT and insist that the timer interrupts
>    are level triggered regardless
> 
> Fix the DT so we're describing reality. For backwards-compatibility
> purposes, only do this for the virt-2.9 machine onward.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  hw/arm/virt.c | 34 ++++++++++++++++++++++++++++++----
>  1 file changed, 30 insertions(+), 4 deletions(-)
> 
> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
> index 54498ea..2ca9527 100644
> --- a/hw/arm/virt.c
> +++ b/hw/arm/virt.c
> @@ -71,6 +71,7 @@ typedef struct {
>      bool disallow_affinity_adjustment;
>      bool no_its;
>      bool no_pmu;
> +    bool claim_edge_triggered_timers;
>  } VirtMachineClass;
>  
>  typedef struct {
> @@ -309,12 +310,31 @@ static void fdt_add_psci_node(const VirtMachineState *vms)
>  
>  static void fdt_add_timer_nodes(const VirtMachineState *vms, int gictype)
>  {
> -    /* Note that on A15 h/w these interrupts are level-triggered,
> -     * but for the GIC implementation provided by both QEMU and KVM
> -     * they are edge-triggered.
> +    /* On real hardware these interrupts are level-triggered.
> +     * On KVM they were edge-triggered before host kernel version 4.4,
> +     * and level-triggered afterwards.
> +     * On emulated QEMU they are level-triggered.
> +     *
> +     * Getting the DTB info about them wrong is awkward for some
> +     * guest kernels:
> +     *  pre-4.8 ignore the DT and leave the interrupt configured
> +     *   with whatever the GIC reset value (or the bootloader) left it at
> +     *  4.8 before rc6 honour the incorrect data by programming it back
> +     *   into the GIC, causing problems
> +     *  4.8rc6 and later ignore the DT and always write "level triggered"
> +     *   into the GIC
> +     *
> +     * For backwards-compatibility, virt-2.8 and earlier will continue
> +     * to say these are edge-triggered, but later machines will report
> +     * the correct information.
>       */

Is this really necessary?

I don't think the KVM GIC implementation ever listened to the guest in
terms of how to configure PPIs, but instead ignores writes to the config
registers for these interrupts (which I think the GIC architecture
allows).

So this would only be a matter of how the guest kernel between v4.8-rc1
and v4.8-rc6 expects the behavior to be.  Does the arch timer driver
really do something different in how it deals with interrupts based on
this DT value?

Of course, I suppose we could also be running other guests (UEFI?) but
again, if the KVM GIC doesn't care about how the guest tries to program
it, can it make a difference?

>      ARMCPU *armcpu;
> -    uint32_t irqflags = GIC_FDT_IRQ_FLAGS_EDGE_LO_HI;
> +    VirtMachineClass *vmc = VIRT_MACHINE_GET_CLASS(vms);
> +    uint32_t irqflags = GIC_FDT_IRQ_FLAGS_LEVEL_HI;
> +
> +    if (vmc->claim_edge_triggered_timers) {
> +        irqflags = GIC_FDT_IRQ_FLAGS_EDGE_LO_HI;
> +    }
>  
>      if (gictype == 2) {
>          irqflags = deposit32(irqflags, GIC_FDT_IRQ_PPI_CPU_START,
> @@ -1556,8 +1576,14 @@ static void virt_2_8_instance_init(Object *obj)
>  
>  static void virt_machine_2_8_options(MachineClass *mc)
>  {
> +    VirtMachineClass *vmc = VIRT_MACHINE_CLASS(OBJECT_CLASS(mc));
> +
>      virt_machine_2_9_options(mc);
>      SET_MACHINE_COMPAT(mc, VIRT_COMPAT_2_8);
> +    /* For 2.8 and earlier we falsely claimed in the DT that
> +     * our timers were edge-triggered, not level-triggered.
> +     */
> +    vmc->claim_edge_triggered_timers = true;
>  }
>  DEFINE_VIRT_MACHINE(2, 8)
>  
I don't understand this virt machine class version stuff.  In which case
is the claim_edge_triggered_timers set to true?  (ok, appears to be when
a 2.8 machine is created, but does that happen automatically or does the
user specifically have to ask for it?)

Thanks,
-Christoffer
