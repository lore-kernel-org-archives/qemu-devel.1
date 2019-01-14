Received: from eggs.gnu.org ([209.51.188.92]:51761)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1gixTx-00006C-1x
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 03:20:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1gixTv-0006h4-48
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 03:20:29 -0500
Received: from 6.mo173.mail-out.ovh.net ([46.105.43.93]:56460)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1gixTt-0006g8-KS
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 03:20:27 -0500
Received: from player732.ha.ovh.net (unknown [10.109.159.224])
	by mo173.mail-out.ovh.net (Postfix) with ESMTP id 05541E9375
	for <qemu-devel@nongnu.org>; Mon, 14 Jan 2019 09:20:22 +0100 (CET)
References: <154724039526.525985.3172545257507998890.stgit@bahia.lan>
	<154724066386.525985.7102226604937744914.stgit@bahia.lan>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <cdbc7f08-f0f7-725e-8511-6a303696c1ef@kaod.org>
Date: Mon, 14 Jan 2019 09:19:50 +0100
MIME-Version: 1.0
In-Reply-To: <154724066386.525985.7102226604937744914.stgit@bahia.lan>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 11/13] spapr_irq: Allow synchronization
 of a single irq state to KVM
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>, David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, qemu-s390x@nongnu.org, Alexey Kardashevskiy <aik@ozlabs.ru>, Michael Roth <mdroth@linux.vnet.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, David Hildenbrand <david@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Dmitry Fleytman <dmitry.fleytman@gmail.com>, Thomas Huth <thuth@redhat.com>

On 1/11/19 10:04 PM, Greg Kurz wrote:
> When using the in-kernel interrupt controller, the state of all irqs is
> synchronized to KVM at machine reset time. In the case of PHB hotplug, we
> will need to synchronize LSIs manually.

Yes. This is because the interrupt sources in the KVM XICS device have 
already been initialized as MSIs. 

Can not we reset the source when it is claimed ? 

An alternative solution would be to initialize the SPAPR_IRQ_PCI_LSI range 
as LSIs at a KVM level.

Thanks,

C.

> Do this for the existing KVM XICS implementation and put a placeholder for
> the upcoming KVM XIVE.> 
> Signed-off-by: Greg Kurz <groug@kaod.org>
> ---
>  hw/intc/xics_kvm.c         |   67 +++++++++++++++++++++++++-------------------
>  hw/ppc/spapr_irq.c         |   31 ++++++++++++++++++++
>  include/hw/ppc/spapr_irq.h |    2 +
>  include/hw/ppc/xics.h      |    2 +
>  4 files changed, 73 insertions(+), 29 deletions(-)
> 
> diff --git a/hw/intc/xics_kvm.c b/hw/intc/xics_kvm.c
> index dff13300504c..d3bbb2bcf19c 100644
> --- a/hw/intc/xics_kvm.c
> +++ b/hw/intc/xics_kvm.c
> @@ -253,43 +253,52 @@ static void ics_synchronize_state(ICSState *ics)
>      ics_get_kvm_state(ics);
>  }
>  
> -static int ics_set_kvm_state(ICSState *ics, int version_id)
> +int ics_set_kvm_state_one(ICSState *ics, unsigned srcno, Error **errp)
>  {
> +    ICSIRQState *irq;
>      uint64_t state;
> -    int i;
> -    Error *local_err = NULL;
>  
> -    for (i = 0; i < ics->nr_irqs; i++) {
> -        ICSIRQState *irq = &ics->irqs[i];
> -        int ret;
> +    assert(srcno < ics->nr_irqs);
>  
> -        state = irq->server;
> -        state |= (uint64_t)(irq->saved_priority & KVM_XICS_PRIORITY_MASK)
> -            << KVM_XICS_PRIORITY_SHIFT;
> -        if (irq->priority != irq->saved_priority) {
> -            assert(irq->priority == 0xff);
> -            state |= KVM_XICS_MASKED;
> -        }
> +    irq = &ics->irqs[srcno];
> +    state = irq->server;
> +    state |= (uint64_t)(irq->saved_priority & KVM_XICS_PRIORITY_MASK)
> +        << KVM_XICS_PRIORITY_SHIFT;
> +    if (irq->priority != irq->saved_priority) {
> +        assert(irq->priority == 0xff);
> +        state |= KVM_XICS_MASKED;
> +    }
>  
> -        if (ics->irqs[i].flags & XICS_FLAGS_IRQ_LSI) {
> -            state |= KVM_XICS_LEVEL_SENSITIVE;
> -            if (irq->status & XICS_STATUS_ASSERTED) {
> -                state |= KVM_XICS_PENDING;
> -            }
> -        } else {
> -            if (irq->status & XICS_STATUS_MASKED_PENDING) {
> -                state |= KVM_XICS_PENDING;
> -            }
> -        }
> -        if (irq->status & XICS_STATUS_PRESENTED) {
> -                state |= KVM_XICS_PRESENTED;
> +    if (ics->irqs[srcno].flags & XICS_FLAGS_IRQ_LSI) {
> +        state |= KVM_XICS_LEVEL_SENSITIVE;
> +        if (irq->status & XICS_STATUS_ASSERTED) {
> +            state |= KVM_XICS_PENDING;
>          }
> -        if (irq->status & XICS_STATUS_QUEUED) {
> -                state |= KVM_XICS_QUEUED;
> +    } else {
> +        if (irq->status & XICS_STATUS_MASKED_PENDING) {
> +            state |= KVM_XICS_PENDING;
>          }
> +    }
> +    if (irq->status & XICS_STATUS_PRESENTED) {
> +        state |= KVM_XICS_PRESENTED;
> +    }
> +    if (irq->status & XICS_STATUS_QUEUED) {
> +        state |= KVM_XICS_QUEUED;
> +    }
> +
> +    return kvm_device_access(kernel_xics_fd, KVM_DEV_XICS_GRP_SOURCES,
> +                             srcno + ics->offset, &state, true, errp);
> +}
> +
> +static int ics_set_kvm_state(ICSState *ics, int version_id)
> +{
> +    int i;
> +    Error *local_err = NULL;
> +
> +    for (i = 0; i < ics->nr_irqs; i++) {
> +        int ret;
>  
> -        ret = kvm_device_access(kernel_xics_fd, KVM_DEV_XICS_GRP_SOURCES,
> -                                i + ics->offset, &state, true, &local_err);
> +        ret = ics_set_kvm_state_one(ics, i, &local_err);
>          if (local_err) {
>              error_report_err(local_err);
>              return ret;
> diff --git a/hw/ppc/spapr_irq.c b/hw/ppc/spapr_irq.c
> index ba0df9ae2e1b..2cf666c2ebc5 100644
> --- a/hw/ppc/spapr_irq.c
> +++ b/hw/ppc/spapr_irq.c
> @@ -236,6 +236,17 @@ static void spapr_irq_reset_xics(sPAPRMachineState *spapr, Error **errp)
>      /* TODO: create the KVM XICS device */
>  }
>  
> +static void spapr_irq_sync_to_kvm_xics(sPAPRMachineState *spapr, int irq,
> +                                       Error **errp)
> +{
> +    MachineState *machine = MACHINE(spapr);
> +    ICSState *ics = spapr->ics;
> +
> +    if (kvm_enabled() && machine_kernel_irqchip_allowed(machine)) {
> +        ics_set_kvm_state_one(ics, irq - ics->offset, errp);
> +    }
> +}
> +
>  #define SPAPR_IRQ_XICS_NR_IRQS     0x1000
>  #define SPAPR_IRQ_XICS_NR_MSIS     \
>      (XICS_IRQ_BASE + SPAPR_IRQ_XICS_NR_IRQS - SPAPR_IRQ_MSI)
> @@ -256,6 +267,7 @@ sPAPRIrq spapr_irq_xics = {
>      .reset       = spapr_irq_reset_xics,
>      .set_irq     = spapr_irq_set_irq_xics,
>      .get_phandle = spapr_get_phandle_xics,
> +    .sync_to_kvm = spapr_irq_sync_to_kvm_xics,
>  };
>  
>  /*
> @@ -389,6 +401,12 @@ static void spapr_irq_set_irq_xive(void *opaque, int srcno, int val)
>      xive_source_set_irq(&spapr->xive->source, srcno, val);
>  }
>  
> +static void spapr_irq_sync_to_kvm_xive(sPAPRMachineState *spapr, int irq,
> +                                       Error **errp)
> +{
> +    /* TODO: to be implemented when adding KVM XIVE support */
> +}
> +
>  /*
>   * XIVE uses the full IRQ number space. Set it to 8K to be compatible
>   * with XICS.
> @@ -413,6 +431,7 @@ sPAPRIrq spapr_irq_xive = {
>      .reset       = spapr_irq_reset_xive,
>      .set_irq     = spapr_irq_set_irq_xive,
>      .get_phandle = spapr_get_phandle_xive,
> +    .sync_to_kvm = spapr_irq_sync_to_kvm_xive,
>  };
>  
>  /*
> @@ -577,6 +596,11 @@ static uint32_t spapr_irq_get_phandle_dual(sPAPRMachineState *spapr, void *fdt,
>      return spapr_irq_current(spapr)->get_phandle(spapr, fdt, errp);
>  }
>  
> +static void spapr_irq_sync_to_kvm_dual(sPAPRMachineState *spapr, int irq,
> +                                       Error **errp)
> +{
> +    spapr_irq_current(spapr)->sync_to_kvm(spapr, irq, errp);
> +}
>  
>  /*
>   * Define values in sync with the XIVE and XICS backend
> @@ -600,6 +624,7 @@ sPAPRIrq spapr_irq_dual = {
>      .reset       = spapr_irq_reset_dual,
>      .set_irq     = spapr_irq_set_irq_dual,
>      .get_phandle = spapr_irq_get_phandle_dual,
> +    .sync_to_kvm = spapr_irq_sync_to_kvm_dual,
>  };
>  
>  /*
> @@ -645,6 +670,11 @@ void spapr_irq_reset(sPAPRMachineState *spapr, Error **errp)
>      }
>  }
>  
> +void spapr_irq_sync_to_kvm(sPAPRMachineState *spapr, int irq, Error **errp)
> +{
> +    spapr->irq->sync_to_kvm(spapr, irq, errp);
> +}
> +
>  /*
>   * XICS legacy routines - to deprecate one day
>   */
> @@ -717,4 +747,5 @@ sPAPRIrq spapr_irq_xics_legacy = {
>      .post_load   = spapr_irq_post_load_xics,
>      .set_irq     = spapr_irq_set_irq_xics,
>      .get_phandle = spapr_get_phandle_xics,
> +    .sync_to_kvm = spapr_irq_sync_to_kvm_xics,
>  };
> diff --git a/include/hw/ppc/spapr_irq.h b/include/hw/ppc/spapr_irq.h
> index 990743a23582..9c111f3211b3 100644
> --- a/include/hw/ppc/spapr_irq.h
> +++ b/include/hw/ppc/spapr_irq.h
> @@ -48,6 +48,7 @@ typedef struct sPAPRIrq {
>      void (*reset)(sPAPRMachineState *spapr, Error **errp);
>      void (*set_irq)(void *opaque, int srcno, int val);
>      uint32_t (*get_phandle)(sPAPRMachineState *spapr, void *fdt, Error **errp);
> +    void (*sync_to_kvm)(sPAPRMachineState *spapr, int irq, Error **errp);
>  } sPAPRIrq;
>  
>  extern sPAPRIrq spapr_irq_xics;
> @@ -61,6 +62,7 @@ void spapr_irq_free(sPAPRMachineState *spapr, int irq, int num);
>  qemu_irq spapr_qirq(sPAPRMachineState *spapr, int irq);
>  int spapr_irq_post_load(sPAPRMachineState *spapr, int version_id);
>  void spapr_irq_reset(sPAPRMachineState *spapr, Error **errp);
> +void spapr_irq_sync_to_kvm(sPAPRMachineState *spapr, int irq, Error **errp);
>  
>  /*
>   * XICS legacy routines
> diff --git a/include/hw/ppc/xics.h b/include/hw/ppc/xics.h
> index fad786e8b22d..52de166a2982 100644
> --- a/include/hw/ppc/xics.h
> +++ b/include/hw/ppc/xics.h
> @@ -203,4 +203,6 @@ void icp_resend(ICPState *ss);
>  Object *icp_create(Object *cpu, const char *type, XICSFabric *xi,
>                     Error **errp);
>  
> +int ics_set_kvm_state_one(ICSState *ics, unsigned srcno, Error **errp);
> +
>  #endif /* XICS_H */
> 
