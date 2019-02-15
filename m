Received: from eggs.gnu.org ([209.51.188.92]:39426)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1gud63-0004jN-0L
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 08:00:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1gud60-0007Xz-VF
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 08:00:02 -0500
Received: from 7.mo69.mail-out.ovh.net ([46.105.50.32]:57161)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1gud5y-0006bm-Qt
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 08:00:00 -0500
Received: from player729.ha.ovh.net (unknown [10.109.159.7])
	by mo69.mail-out.ovh.net (Postfix) with ESMTP id 769C843CD0
	for <qemu-devel@nongnu.org>; Fri, 15 Feb 2019 13:59:40 +0100 (CET)
References: <155023078266.1011724.5995737218088270486.stgit@bahia.lan>
	<155023082996.1011724.16237920586343905010.stgit@bahia.lan>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <2dea9d93-8662-2a32-deef-c45add6d87cd@kaod.org>
Date: Fri, 15 Feb 2019 13:59:36 +0100
MIME-Version: 1.0
In-Reply-To: <155023082996.1011724.16237920586343905010.stgit@bahia.lan>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 08/10] xics: Handle KVM interrupt
 presentation from "simple" ICS code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>, David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org

On 2/15/19 12:40 PM, Greg Kurz wrote:
> We want to use the "simple" ICS type in both KVM and non-KVM setups.
> Teach the "simple" ICS how to present interrupts to KVM and adapt
> sPAPR accordingly.

I don't see the benefits of this change.

C.


> Signed-off-by: Greg Kurz <groug@kaod.org>
> ---
>  hw/intc/xics.c        |    5 +++++
>  hw/intc/xics_kvm.c    |    3 +--
>  hw/ppc/spapr_irq.c    |    7 +------
>  include/hw/ppc/xics.h |    2 +-
>  4 files changed, 8 insertions(+), 9 deletions(-)
> 
> diff --git a/hw/intc/xics.c b/hw/intc/xics.c
> index 49401745c410..3009fa747277 100644
> --- a/hw/intc/xics.c
> +++ b/hw/intc/xics.c
> @@ -466,6 +466,11 @@ void ics_simple_set_irq(void *opaque, int srcno, int val)
>  {
>      ICSState *ics = (ICSState *)opaque;
>  
> +    if (kvm_irqchip_in_kernel()) {
> +        ics_kvm_set_irq(ics, srcno, val);
> +        return;
> +    }
> +
>      if (ics->irqs[srcno].flags & XICS_FLAGS_IRQ_LSI) {
>          ics_simple_set_irq_lsi(ics, srcno, val);
>      } else {
> diff --git a/hw/intc/xics_kvm.c b/hw/intc/xics_kvm.c
> index e7b8d4c29ce6..f34eacda03e7 100644
> --- a/hw/intc/xics_kvm.c
> +++ b/hw/intc/xics_kvm.c
> @@ -259,9 +259,8 @@ int ics_set_kvm_state(ICSState *ics)
>      return 0;
>  }
>  
> -void ics_kvm_set_irq(void *opaque, int srcno, int val)
> +void ics_kvm_set_irq(ICSState *ics, int srcno, int val)
>  {
> -    ICSState *ics = opaque;
>      struct kvm_irq_level args;
>      int rc;
>  
> diff --git a/hw/ppc/spapr_irq.c b/hw/ppc/spapr_irq.c
> index e6893df61e76..9f43b7b3bf16 100644
> --- a/hw/ppc/spapr_irq.c
> +++ b/hw/ppc/spapr_irq.c
> @@ -222,13 +222,8 @@ static int spapr_irq_post_load_xics(sPAPRMachineState *spapr, int version_id)
>  static void spapr_irq_set_irq_xics(void *opaque, int srcno, int val)
>  {
>      sPAPRMachineState *spapr = opaque;
> -    MachineState *machine = MACHINE(opaque);
>  
> -    if (kvm_enabled() && machine_kernel_irqchip_allowed(machine)) {
> -        ics_kvm_set_irq(spapr->ics, srcno, val);
> -    } else {
> -        ics_simple_set_irq(spapr->ics, srcno, val);
> -    }
> +    ics_simple_set_irq(spapr->ics, srcno, val);
>  }
>  
>  static void spapr_irq_reset_xics(sPAPRMachineState *spapr, Error **errp)
> diff --git a/include/hw/ppc/xics.h b/include/hw/ppc/xics.h
> index 06e87128f88e..61bd0fb9784f 100644
> --- a/include/hw/ppc/xics.h
> +++ b/include/hw/ppc/xics.h
> @@ -180,7 +180,6 @@ void icp_eoi(ICPState *icp, uint32_t xirr);
>  void ics_simple_write_xive(ICSState *ics, int nr, int server,
>                             uint8_t priority, uint8_t saved_priority);
>  void ics_simple_set_irq(void *opaque, int srcno, int val);
> -void ics_kvm_set_irq(void *opaque, int srcno, int val);
>  
>  void ics_set_irq_type(ICSState *ics, int srcno, bool lsi);
>  void icp_pic_print_info(ICPState *icp, Monitor *mon);
> @@ -201,5 +200,6 @@ void icp_kvm_realize(DeviceState *dev, Error **errp);
>  void ics_get_kvm_state(ICSState *ics);
>  int ics_set_kvm_state(ICSState *ics);
>  void ics_synchronize_state(ICSState *ics);
> +void ics_kvm_set_irq(ICSState *ics, int srcno, int val);
>  
>  #endif /* XICS_H */
> 
