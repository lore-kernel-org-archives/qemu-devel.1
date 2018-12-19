Received: from eggs.gnu.org ([2001:4830:134:3::10]:42130)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gZeA7-0000aq-F3
	for qemu-devel@nongnu.org; Wed, 19 Dec 2018 10:53:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gZeA6-0006x8-38
	for qemu-devel@nongnu.org; Wed, 19 Dec 2018 10:53:31 -0500
Received: from mx1.redhat.com ([209.132.183.28]:58220)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1gZeA5-0006w7-S2
	for qemu-devel@nongnu.org; Wed, 19 Dec 2018 10:53:30 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
	[10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 2816537E8E
	for <qemu-devel@nongnu.org>; Wed, 19 Dec 2018 15:53:29 +0000 (UTC)
Date: Wed, 19 Dec 2018 10:53:25 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20181219105308-mutt-send-email-mst@kernel.org>
References: <20181219085038.7729-1-peterx@redhat.com>
	<20181219085038.7729-2-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181219085038.7729-2-peterx@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 1/4] kvm: let split be optional for
 kvm_arch_irqchip_create
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

On Wed, Dec 19, 2018 at 04:50:35PM +0800, Peter Xu wrote:
> This patch allows the kvm_arch_irqchip_create() to return 0 if the
> split irqchip is specified but not forced by the user.  Also, modify
> kvm_irqchip_create() similiarly.
> 
> This patch should have no functional change for existing code since
> currently if split is specified it must be forced by the user so we'll
> always have machine_kernel_irqchip_required() returns true. However it
> could potentially be used in follow up patches when we want to turn
> split kernel irqchip as default for QEMU 4.0 which could trigger the
> case that kernel_irqchip_required=N while kernel_irqchip_split=Y. When
> with that, we'll first try with split irqchip, and falls back to
> normal kernel irqchip when split capability is not provided by the
> kernel.
> 
> This brings us benefit that we can even run a default QEMU 4.0 on old
> kernels that does not support split irqchip (<4.4) but at the same
> time enable split irqchip for new kernels (>=4.4) as default.
> 
> Signed-off-by: Peter Xu <peterx@redhat.com>

Paolo, if you can ack this one, I can merge the rest.

> ---
>  accel/kvm/kvm-all.c | 3 ++-
>  target/i386/kvm.c   | 6 +++---
>  2 files changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
> index 4880a05399..b008364041 100644
> --- a/accel/kvm/kvm-all.c
> +++ b/accel/kvm/kvm-all.c
> @@ -1468,7 +1468,8 @@ static void kvm_irqchip_create(MachineState *machine, KVMState *s)
>       * in-kernel irqchip for us */
>      ret = kvm_arch_irqchip_create(machine, s);
>      if (ret == 0) {
> -        if (machine_kernel_irqchip_split(machine)) {
> +        if (machine_kernel_irqchip_required(machine) &&
> +            machine_kernel_irqchip_split(machine)) {
>              perror("Split IRQ chip mode not supported.");
>              exit(1);
>          } else {
> diff --git a/target/i386/kvm.c b/target/i386/kvm.c
> index 739cf8c8ea..8f919f8f9f 100644
> --- a/target/i386/kvm.c
> +++ b/target/i386/kvm.c
> @@ -3685,9 +3685,9 @@ int kvm_arch_irqchip_create(MachineState *ms, KVMState *s)
>      if (machine_kernel_irqchip_split(ms)) {
>          ret = kvm_vm_enable_cap(s, KVM_CAP_SPLIT_IRQCHIP, 0, 24);
>          if (ret) {
> -            error_report("Could not enable split irqchip mode: %s",
> -                         strerror(-ret));
> -            exit(1);
> +            assert(ret < 0);
> +            /* If split not required, return 0 instead to retry */
> +            return machine_kernel_irqchip_required(ms) ? ret : 0;
>          } else {
>              DPRINTF("Enabled KVM_CAP_SPLIT_IRQCHIP\n");
>              kvm_split_irqchip = true;
> -- 
> 2.17.1
