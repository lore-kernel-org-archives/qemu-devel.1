Received: from eggs.gnu.org ([2001:4830:134:3::10]:59595)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ePoCD-00068c-G3
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 06:30:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ePoC8-0003qo-IO
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 06:30:29 -0500
Received: from mail-qt0-x243.google.com ([2607:f8b0:400d:c0d::243]:46147)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ePoC8-0003qP-CI
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 06:30:24 -0500
Received: by mail-qt0-x243.google.com with SMTP id r39so11589771qtr.13
	for <qemu-devel@nongnu.org>; Fri, 15 Dec 2017 03:30:24 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20171210063819.14892-1-peterx@redhat.com>
	<20171210063819.14892-5-peterx@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <3539ed3f-eba4-2e27-c9e8-74db9812ba15@amsat.org>
Date: Fri, 15 Dec 2017 08:30:20 -0300
MIME-Version: 1.0
In-Reply-To: <20171210063819.14892-5-peterx@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 4/5] kvm-i8259: support "info pic" and
 "info irq"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>

On 12/10/2017 03:38 AM, Peter Xu wrote:
> Let's leverage the i8259 common code for kvm-i8259 too.
> 
> I think it's still possible that stats can lost when i8259 is in kernel
> and meanwhile when irqfd is used, e.g., by vfio or vhost devices.
> However that should be rare IMHO since they should be using MSIs mostly
> if they really want performance (that's why people use vhost and device
> assignment), and no old INTx should be used.  As long as the INTx users
> are emulated in QEMU the stats will be correct.
> 
> For "info pic", it should be always accurate since we fetch kvm regs
> before dump.
> 
> More importantly, it's just too simple to do this now - it's only 10+
> LOC to gain this feature.
> 
> Signed-off-by: Peter Xu <peterx@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  hw/i386/kvm/i8259.c    | 8 ++++++++
>  hw/intc/i8259_common.c | 1 +
>  2 files changed, 9 insertions(+)
> 
> diff --git a/hw/i386/kvm/i8259.c b/hw/i386/kvm/i8259.c
> index 11d1b726b6..57abe091b0 100644
> --- a/hw/i386/kvm/i8259.c
> +++ b/hw/i386/kvm/i8259.c
> @@ -111,6 +111,7 @@ static void kvm_pic_set_irq(void *opaque, int irq, int level)
>  {
>      int delivered;
>  
> +    pic_stat_update_irq(irq, level);
>      delivered = kvm_set_irq(kvm_state, irq, level);
>      apic_report_irq_delivered(delivered);
>  }
> @@ -139,12 +140,15 @@ static void kvm_i8259_class_init(ObjectClass *klass, void *data)
>      KVMPICClass *kpc = KVM_PIC_CLASS(klass);
>      PICCommonClass *k = PIC_COMMON_CLASS(klass);
>      DeviceClass *dc = DEVICE_CLASS(klass);
> +    InterruptStatsProviderClass *ic = INTERRUPT_STATS_PROVIDER_CLASS(klass);
>  
>      dc->reset     = kvm_pic_reset;
>      kpc->parent_realize = dc->realize;
>      dc->realize   = kvm_pic_realize;
>      k->pre_save   = kvm_pic_get;
>      k->post_load  = kvm_pic_put;
> +    ic->get_statistics = pic_get_statistics;
> +    ic->print_info = pic_print_info;
>  }
>  
>  static const TypeInfo kvm_i8259_info = {
> @@ -153,6 +157,10 @@ static const TypeInfo kvm_i8259_info = {
>      .instance_size = sizeof(PICCommonState),
>      .class_init = kvm_i8259_class_init,
>      .class_size = sizeof(KVMPICClass),
> +    .interfaces = (InterfaceInfo[]) {
> +        { TYPE_INTERRUPT_STATS_PROVIDER },
> +        { }
> +    },
>  };
>  
>  static void kvm_pic_register_types(void)
> diff --git a/hw/intc/i8259_common.c b/hw/intc/i8259_common.c
> index a3caddeefb..7efd2e8012 100644
> --- a/hw/intc/i8259_common.c
> +++ b/hw/intc/i8259_common.c
> @@ -132,6 +132,7 @@ void pic_print_info(InterruptStatsProvider *obj, Monitor *mon)
>  {
>      PICCommonState *s = PIC_COMMON(obj);
>  
> +    pic_dispatch_pre_save(s);
>      monitor_printf(mon, "pic%d: irr=%02x imr=%02x isr=%02x hprio=%d "
>                     "irq_base=%02x rr_sel=%d elcr=%02x fnm=%d\n",
>                     s->master ? 0 : 1, s->irr, s->imr, s->isr, s->priority_add,
> 
