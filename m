Received: from eggs.gnu.org ([2001:4830:134:3::10]:55459)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1d8eHl-0002We-Cg
	for qemu-devel@nongnu.org; Wed, 10 May 2017 22:57:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1d8eHj-0003fQ-5T
	for qemu-devel@nongnu.org; Wed, 10 May 2017 22:57:01 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35944)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1d8eHi-0003fI-Sq
	for qemu-devel@nongnu.org; Wed, 10 May 2017 22:56:59 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id DE67F80467
	for <qemu-devel@nongnu.org>; Thu, 11 May 2017 02:56:57 +0000 (UTC)
Date: Thu, 11 May 2017 10:56:49 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20170511025649.GC28293@pxdev.xzpeter.org>
References: <1494309644-18743-1-git-send-email-peterx@redhat.com>
	<1494309644-18743-4-git-send-email-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1494309644-18743-4-git-send-email-peterx@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 3/3] kvm: irqchip: skip update msi when
 disabled
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>

On Tue, May 09, 2017 at 02:00:44PM +0800, Peter Xu wrote:
> It's possible that one device kept its irqfd/virq there even when
> MSI/MSIX was disabled globally for that device. One example is
> virtio-net-pci (see commit f1d0f15a6 and virtio_pci_vq_vector_mask()).
> It is used as a fast path to avoid allocate/release irqfd/virq
> frequently when guest enables/disables MSIX.
> 
> However, this fast path brought a problem to msi_route_list, that the
> device MSIRouteEntry is still dangling there even if MSIX disabled -
> then we cannot know which message to fetch, even if we can, the messages
> are meaningless. In this case, we can just simply ignore this entry.
> 
> It's safe, since when MSIX is enabled again, we'll rebuild them no
> matter what.
> 
> Fixes: https://bugzilla.redhat.com/show_bug.cgi?id=1448813
> 
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  target/i386/kvm.c | 13 +++++++++----
>  1 file changed, 9 insertions(+), 4 deletions(-)
> 
> diff --git a/target/i386/kvm.c b/target/i386/kvm.c
> index 55865db..554950d 100644
> --- a/target/i386/kvm.c
> +++ b/target/i386/kvm.c
> @@ -43,6 +43,7 @@
>  #include "standard-headers/asm-x86/hyperv.h"
>  #include "hw/pci/pci.h"
>  #include "hw/pci/msi.h"
> +#include "hw/pci/msix.h"
>  #include "migration/migration.h"
>  #include "exec/memattrs.h"
>  #include "trace.h"
> @@ -3510,12 +3511,16 @@ static void kvm_update_msi_routes_all(void *private, bool global,
>      int cnt = 0;
>      MSIRouteEntry *entry;
>      MSIMessage msg;
> +    PCIDevice *dev;
> +
>      /* TODO: explicit route update */
>      QLIST_FOREACH(entry, &msi_route_list, list) {
> -        cnt++;

Oops, I think this line should be kept. It does not affect too much,
only the trace below. But still, no reason to remove it.

Paolo, would it still possible to touch it up in your queue?

Sorry for the inconvenience!

> -        msg = pci_get_msi_message(entry->dev, entry->vector);
> -        kvm_irqchip_update_msi_route(kvm_state, entry->virq,
> -                                     msg, entry->dev);
> +        dev = entry->dev;
> +        if (!msix_enabled(dev) && !msi_enabled(dev)) {
> +            continue;
> +        }
> +        msg = pci_get_msi_message(dev, entry->vector);
> +        kvm_irqchip_update_msi_route(kvm_state, entry->virq, msg, dev);
>      }
>      kvm_irqchip_commit_routes(kvm_state);
>      trace_kvm_x86_update_msi_routes(cnt);
> -- 
> 2.7.4
> 

-- 
Peter Xu
