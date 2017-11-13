Received: from eggs.gnu.org ([2001:4830:134:3::10]:55647)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1eEFqT-0006jj-ST
	for qemu-devel@nongnu.org; Mon, 13 Nov 2017 09:36:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1eEFqS-0000Mz-PL
	for qemu-devel@nongnu.org; Mon, 13 Nov 2017 09:36:17 -0500
Received: from mx1.redhat.com ([209.132.183.28]:48022)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1eEFqS-0000LV-HD
	for qemu-devel@nongnu.org; Mon, 13 Nov 2017 09:36:16 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <20171110173421.17904-1-lprosek@redhat.com>
	<20171110173421.17904-3-lprosek@redhat.com>
Date: Mon, 13 Nov 2017 15:36:10 +0100
In-Reply-To: <20171110173421.17904-3-lprosek@redhat.com> (Ladi Prosek's
	message of "Fri, 10 Nov 2017 18:34:20 +0100")
Message-ID: <87375i2qlh.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 2/3] ivshmem: Always remove irqfd notifiers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Ladi Prosek <lprosek@redhat.com>
Cc: qemu-devel@nongnu.org, geoff@hostfission.com, pbonzini@redhat.com, marcandre.lureau@redhat.com

Ladi Prosek <lprosek@redhat.com> writes:

> As of commit 660c97eef6f8 ("ivshmem: use kvm irqfd for msi notifications"),
> QEMU crashes with:
>
> ivshmem: msix_set_vector_notifiers failed
> msix_unset_vector_notifiers: Assertion `dev->msix_vector_use_notifier && dev->msix_vector_release_notifier' failed.
>
> if MSI-X is repeatedly enabled and disabled on the ivshmem device, for example
> by loading and unloading the Windows ivshmem driver. This is because
> msix_unset_vector_notifiers() doesn't call any of the release notifier callbacks
> since MSI-X is already disabled at that point (msix_enabled() returning false
> is how this transition is detected in the first place). Thus ivshmem_vector_mask()
> doesn't run and when MSI-X is subsequently enabled again ivshmem_vector_unmask()
> fails.
>
> This is fixed by keeping track of unmasked vectors and making sure that
> ivshmem_vector_mask() always runs on MSI-X disable.
>
> Fixes: 660c97eef6f8 ("ivshmem: use kvm irqfd for msi notifications")
> Signed-off-by: Ladi Prosek <lprosek@redhat.com>
> ---
>  hw/misc/ivshmem.c | 30 ++++++++++++++++++++++++------
>  1 file changed, 24 insertions(+), 6 deletions(-)
>
> diff --git a/hw/misc/ivshmem.c b/hw/misc/ivshmem.c
> index 6e46669744..493a5030a1 100644
> --- a/hw/misc/ivshmem.c
> +++ b/hw/misc/ivshmem.c
> @@ -77,6 +77,7 @@ typedef struct Peer {
>  typedef struct MSIVector {
>      PCIDevice *pdev;
>      int virq;
> +    bool unmasked;
>  } MSIVector;
>  
>  typedef struct IVShmemState {
> @@ -321,6 +322,7 @@ static int ivshmem_vector_unmask(PCIDevice *dev, unsigned vector,
>          error_report("ivshmem: vector %d route does not exist", vector);
>          return -EINVAL;
>      }
> +    assert(!v->unmasked);
>  
>      ret = kvm_irqchip_update_msi_route(kvm_state, v->virq, msg, dev);
>      if (ret < 0) {
> @@ -328,7 +330,11 @@ static int ivshmem_vector_unmask(PCIDevice *dev, unsigned vector,
>      }
>      kvm_irqchip_commit_routes(kvm_state);
>  
> -    return kvm_irqchip_add_irqfd_notifier_gsi(kvm_state, n, NULL, v->virq);
> +    ret = kvm_irqchip_add_irqfd_notifier_gsi(kvm_state, n, NULL, v->virq);
> +    if (ret == 0) {
> +        v->unmasked = true;
> +    }
> +    return ret;
>  }
>  
>  static void ivshmem_vector_mask(PCIDevice *dev, unsigned vector)
> @@ -343,9 +349,12 @@ static void ivshmem_vector_mask(PCIDevice *dev, unsigned vector)
>          error_report("ivshmem: vector %d route does not exist", vector);
>          return;
>      }
> +    assert(v->unmasked);
>  
>      ret = kvm_irqchip_remove_irqfd_notifier_gsi(kvm_state, n, v->virq);
> -    if (ret != 0) {
> +    if (ret == 0) {
> +        v->unmasked = false;
> +    } else {
>          error_report("remove_irqfd_notifier_gsi failed");
>      }
>  }

I generally prefer to put the error case in the conditional, and keep
the normal case out of it, like this:

       ret = kvm_irqchip_remove_irqfd_notifier_gsi(kvm_state, n, v->virq);
       if (ret < 0) {
           error_report("remove_irqfd_notifier_gsi failed");
       }
       v->unmasked = false;

However, that makes ivshmem_vector_mask() and ivshmem_vector_unmask()
even more asymmetric.  Hmm.

> @@ -817,11 +826,20 @@ static void ivshmem_disable_irqfd(IVShmemState *s)
>      PCIDevice *pdev = PCI_DEVICE(s);
>      int i;
>  
> -    for (i = 0; i < s->peers[s->vm_id].nb_eventfds; i++) {
> -        ivshmem_remove_kvm_msi_virq(s, i);
> -    }
> -
>      msix_unset_vector_notifiers(pdev);
> +
> +    for (i = 0; i < s->peers[s->vm_id].nb_eventfds; i++) {
> +        /*
> +         * MSI-X is already disabled here so msix_unset_vector_notifiers
> +         * didn't call our release notifier. Do it now to keep our masks and
> +         * unmasks balanced.
> +         */

For consistency with other comments in this file, put () after the
function name, and two spaces after the sentence-ending period.

> +        if (s->msi_vectors[i].unmasked) {
> +            ivshmem_vector_mask(pdev, i);
> +        }
> +        ivshmem_remove_kvm_msi_virq(s, i);
> +    }
> +
>  }
>  
>  static void ivshmem_write_config(PCIDevice *pdev, uint32_t address,

Only nit-picking, so:
Reviewed-by: Markus Armbruster <armbru@redhat.com>
