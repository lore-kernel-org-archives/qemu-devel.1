Received: from eggs.gnu.org ([2001:4830:134:3::10]:34980)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ejNU7-00027f-Le
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 06:01:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ejNU1-0008KD-Pd
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 06:01:51 -0500
Received: from mail-wr0-f196.google.com ([209.85.128.196]:44139)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1ejNU1-0008Jq-II
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 06:01:45 -0500
Received: by mail-wr0-f196.google.com with SMTP id v31so518141wrc.11
	for <qemu-devel@nongnu.org>; Wed, 07 Feb 2018 03:01:45 -0800 (PST)
References: <20180206203048.11096-1-rkagan@virtuozzo.com>
	<20180206203048.11096-19-rkagan@virtuozzo.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <4d74329a-8797-a476-60ff-539f95245131@redhat.com>
Date: Wed, 7 Feb 2018 12:01:41 +0100
MIME-Version: 1.0
In-Reply-To: <20180206203048.11096-19-rkagan@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC PATCH 18/34] hyperv: add support for
 KVM_HYPERV_EVENTFD
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Roman Kagan <rkagan@virtuozzo.com>, qemu-devel@nongnu.org
Cc: Ben Warren <ben@skyportsystems.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Krish Sadhukhan <krish.sadhukhan@oracle.com>, "Marcos E. Matsunaga" <Marcos.Matsunaga@oracle.com>, Jan Dakinevich <jan.dakinevich@virtuozzo.com>, Vadim Rozenfeld <vrozenfe@redhat.com>, "Denis V. Lunev" <den@openvz.org>, si-wei liu <si-wei.liu@oracle.com>, Vitaly Kuznetsov <vkuznets@redhat.com>, Cathy Avery <cavery@redhat.com>

On 06/02/2018 21:30, Roman Kagan wrote:
> When setting up a notifier for Hyper-V event connection, attempt to use
> the KVM-assisted one first, and fall back to userspace handling of the
> hypercall if the kernel doesn't provide the requested feature.
> 
> Signed-off-by: Roman Kagan <rkagan@virtuozzo.com>

As before, I wouldn't mind dropping userspace SIGNAL_EVENT altogether.
It would probably end up in bitrot.

Thanks,

Paolo

> ---
>  include/sysemu/kvm.h |  1 +
>  accel/kvm/kvm-all.c  | 15 +++++++++++++++
>  target/i386/hyperv.c | 21 ++++++++++++++++++++-
>  3 files changed, 36 insertions(+), 1 deletion(-)
> 
> diff --git a/include/sysemu/kvm.h b/include/sysemu/kvm.h
> index bbf12a1723..70ad0a54b7 100644
> --- a/include/sysemu/kvm.h
> +++ b/include/sysemu/kvm.h
> @@ -496,6 +496,7 @@ void kvm_irqchip_set_qemuirq_gsi(KVMState *s, qemu_irq irq, int gsi);
>  void kvm_pc_gsi_handler(void *opaque, int n, int level);
>  void kvm_pc_setup_irq_routing(bool pci_enabled);
>  void kvm_init_irq_routing(KVMState *s);
> +int kvm_set_hv_event_notifier(KVMState *s, uint32_t conn_id, EventNotifier *n);
>  
>  /**
>   * kvm_arch_irqchip_create:
> diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
> index f290f487a5..c3ba87b701 100644
> --- a/accel/kvm/kvm-all.c
> +++ b/accel/kvm/kvm-all.c
> @@ -1423,6 +1423,21 @@ static void kvm_irqchip_create(MachineState *machine, KVMState *s)
>      s->gsimap = g_hash_table_new(g_direct_hash, g_direct_equal);
>  }
>  
> +int kvm_set_hv_event_notifier(KVMState *s, uint32_t conn_id, EventNotifier *n)
> +{
> +    struct kvm_hyperv_eventfd hvevfd = {
> +        .conn_id = conn_id,
> +        .fd = n ? event_notifier_get_fd(n) : -1,
> +        .flags = n ? 0 : KVM_HYPERV_EVENTFD_DEASSIGN,
> +    };
> +
> +    if (!kvm_check_extension(s, KVM_CAP_HYPERV_EVENTFD)) {
> +        return -ENOSYS;
> +    }
> +
> +    return kvm_vm_ioctl(s, KVM_HYPERV_EVENTFD, &hvevfd);
> +}
> +
>  /* Find number of supported CPUs using the recommended
>   * procedure from the kernel API documentation to cope with
>   * older kernels that may be missing capabilities.
> diff --git a/target/i386/hyperv.c b/target/i386/hyperv.c
> index e43cbb9322..63dcb23fa8 100644
> --- a/target/i386/hyperv.c
> +++ b/target/i386/hyperv.c
> @@ -313,7 +313,8 @@ unlock:
>      return ret;
>  }
>  
> -int hyperv_set_evt_notifier(uint32_t conn_id, EventNotifier *notifier)
> +static int hyperv_set_evt_notifier_userspace(uint32_t conn_id,
> +                                             EventNotifier *notifier)
>  {
>      int ret;
>      EvtHandler *eh;
> @@ -346,6 +347,24 @@ unlock:
>      return ret;
>  }
>  
> +static bool hv_evt_notifier_userspace;
> +
> +int hyperv_set_evt_notifier(uint32_t conn_id, EventNotifier *notifier)
> +{
> +    if (!hv_evt_notifier_userspace) {
> +        int ret = kvm_set_hv_event_notifier(kvm_state, conn_id, notifier);
> +        if (ret != -ENOSYS) {
> +            return ret;
> +        }
> +
> +        hv_evt_notifier_userspace = true;
> +        warn_report("Hyper-V event signaling in KVM not supported; "
> +                    "using slower userspace hypercall processing");
> +    }
> +
> +    return hyperv_set_evt_notifier_userspace(conn_id, notifier);
> +}
> +
>  static uint64_t hvcall_post_message(uint64_t param, bool fast)
>  {
>      uint64_t ret;
> 
