Received: from eggs.gnu.org ([2001:4830:134:3::10]:42717)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1clwpI-0003nz-Bw
	for qemu-devel@nongnu.org; Thu, 09 Mar 2017 07:05:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1clwpF-0006dN-86
	for qemu-devel@nongnu.org; Thu, 09 Mar 2017 07:05:48 -0500
References: <20170309115830.3860-1-pbonzini@redhat.com>
From: Laurent Vivier <lvivier@redhat.com>
Message-ID: <a74b9e2a-dd72-8179-c2e2-c215093e8fef@redhat.com>
Date: Thu, 9 Mar 2017 13:05:40 +0100
MIME-Version: 1.0
In-Reply-To: <20170309115830.3860-1-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] e1000e: correctly tear down MSI-X memory
 regions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: Jason Wang <jasowang@redhat.com>, dgilbert@redhat.com, qemu-stable@nongnu.org

On 09/03/2017 12:58, Paolo Bonzini wrote:
> MSI-X has been disabled by the time the e1000e device is unrealized, hence
> msix_uninit is never called.  This causes the object to be leaked, which
> shows up as a RAMBlock with empty name when attempting migration.
> 
> Reported-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> Cc: Jason Wang <jasowang@redhat.com>
> Cc: qemu-stable@nongnu.org
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  hw/net/e1000e.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/net/e1000e.c b/hw/net/e1000e.c
> index b0f429b..6e23493 100644
> --- a/hw/net/e1000e.c
> +++ b/hw/net/e1000e.c
> @@ -306,7 +306,7 @@ e1000e_init_msix(E1000EState *s)
>  static void
>  e1000e_cleanup_msix(E1000EState *s)
>  {
> -    if (msix_enabled(PCI_DEVICE(s))) {
> +    if (msix_present(PCI_DEVICE(s))) {
>          e1000e_unuse_msix_vectors(s, E1000E_MSIX_VEC_NUM);
>          msix_uninit(PCI_DEVICE(s), &s->msix, &s->msix);
>      }
> 

Tested-by: Laurent Vivier <lvivier@redhat.com>
