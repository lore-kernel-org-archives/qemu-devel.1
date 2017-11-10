Received: from eggs.gnu.org ([2001:4830:134:3::10]:50407)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <geoff@hostfission.com>) id 1eDFXY-0003gK-Kc
	for qemu-devel@nongnu.org; Fri, 10 Nov 2017 15:04:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <geoff@hostfission.com>) id 1eDFXS-000382-It
	for qemu-devel@nongnu.org; Fri, 10 Nov 2017 15:04:36 -0500
Received: from mail1.hostfission.com ([139.99.139.48]:58022)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <geoff@hostfission.com>) id 1eDFXS-00036T-5T
	for qemu-devel@nongnu.org; Fri, 10 Nov 2017 15:04:30 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date: Sat, 11 Nov 2017 07:04:24 +1100
From: geoff@hostfission.com
In-Reply-To: <20171110173421.17904-2-lprosek@redhat.com>
References: <20171110173421.17904-1-lprosek@redhat.com>
	<20171110173421.17904-2-lprosek@redhat.com>
Message-ID: <cc9adda448cfb90fafe69c03166738e3@hostfission.com>
Subject: Re: [Qemu-devel] [PATCH 1/3] ivshmem: Don't update non-existent MSI
 routes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Ladi Prosek <lprosek@redhat.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, armbru@redhat.com, marcandre.lureau@redhat.com

Thanks Ladi, I had not yet had time to dig into these, this patch set 
resolves all issues I was aware of.

Tested-by: Geoffrey McRae <geoff@hostfission.com>

On 2017-11-11 04:34, Ladi Prosek wrote:
> As of commit 660c97eef6f8 ("ivshmem: use kvm irqfd for msi 
> notifications"),
> QEMU crashes with:
> 
>   kvm_irqchip_commit_routes: Assertion `ret == 0' failed.
> 
> if the ivshmem device is configured with more vectors than what the 
> server
> supports. This is caused by the ivshmem_vector_unmask() being called on
> vectors that have not been initialized by ivshmem_add_kvm_msi_virq().
> 
> This commit fixes it by adding a simple check to the mask and unmask
> callbacks.
> 
> Note that the opposite mismatch, if the server supplies more vectors 
> than
> what the device is configured for, is already handled and leads to 
> output
> like:
> 
>   Too many eventfd received, device has 1 vectors
> 
> Fixes: 660c97eef6f8 ("ivshmem: use kvm irqfd for msi notifications")
> Signed-off-by: Ladi Prosek <lprosek@redhat.com>
> ---
>  hw/misc/ivshmem.c | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/misc/ivshmem.c b/hw/misc/ivshmem.c
> index a5a46827fe..6e46669744 100644
> --- a/hw/misc/ivshmem.c
> +++ b/hw/misc/ivshmem.c
> @@ -317,6 +317,10 @@ static int ivshmem_vector_unmask(PCIDevice *dev,
> unsigned vector,
>      int ret;
> 
>      IVSHMEM_DPRINTF("vector unmask %p %d\n", dev, vector);
> +    if (!v->pdev) {
> +        error_report("ivshmem: vector %d route does not exist", 
> vector);
> +        return -EINVAL;
> +    }
> 
>      ret = kvm_irqchip_update_msi_route(kvm_state, v->virq, msg, dev);
>      if (ret < 0) {
> @@ -331,12 +335,16 @@ static void ivshmem_vector_mask(PCIDevice *dev,
> unsigned vector)
>  {
>      IVShmemState *s = IVSHMEM_COMMON(dev);
>      EventNotifier *n = &s->peers[s->vm_id].eventfds[vector];
> +    MSIVector *v = &s->msi_vectors[vector];
>      int ret;
> 
>      IVSHMEM_DPRINTF("vector mask %p %d\n", dev, vector);
> +    if (!v->pdev) {
> +        error_report("ivshmem: vector %d route does not exist", 
> vector);
> +        return;
> +    }
> 
> -    ret = kvm_irqchip_remove_irqfd_notifier_gsi(kvm_state, n,
> -                                                
> s->msi_vectors[vector].virq);
> +    ret = kvm_irqchip_remove_irqfd_notifier_gsi(kvm_state, n, 
> v->virq);
>      if (ret != 0) {
>          error_report("remove_irqfd_notifier_gsi failed");
>      }
