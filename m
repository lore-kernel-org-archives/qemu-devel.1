Received: from eggs.gnu.org ([2001:4830:134:3::10]:45819)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dpAAq-0007Ip-9W
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 05:29:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dpAAg-0007Hi-Ku
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 05:29:36 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52542)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1dpAAg-0007HG-Em
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 05:29:26 -0400
Date: Tue, 5 Sep 2017 11:29:21 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20170905112921.3e7c1a6c.cohuck@redhat.com>
In-Reply-To: <1504239778-29893-3-git-send-email-zyimin@linux.vnet.ibm.com>
References: <1504239778-29893-1-git-send-email-zyimin@linux.vnet.ibm.com>
	<1504239778-29893-3-git-send-email-zyimin@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 2/3] s390x/pci: fixup ind_offset of msix
 routing entry
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Yi Min Zhao <zyimin@linux.vnet.ibm.com>
Cc: qemu-devel@nongnu.org, borntraeger@de.ibm.com, pasic@linux.vnet.ibm.com, pmorel@linux.vnet.ibm.com, agraf@suse.de, richard.henderson@linaro.org

On Fri,  1 Sep 2017 06:22:57 +0200
Yi Min Zhao <zyimin@linux.vnet.ibm.com> wrote:

> The guest uses the mpcifc instruction to register the aibvo of a zpci
> device, which is the starting offset of indicators in the indicator
> area and thus remains constant. Each msix vector is an offset from the
> aibvo. When we map a msix route to an adapter route, we should not
> modify the starting offset, but instead add the vector to the starting
> offset to get the absolute offset in the specific route.
> 
> Signed-off-by: Yi Min Zhao <zyimin@linux.vnet.ibm.com>
> ---
>  target/s390x/kvm.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/target/s390x/kvm.c b/target/s390x/kvm.c
> index 3d490c5e4b..21ce06966c 100644
> --- a/target/s390x/kvm.c
> +++ b/target/s390x/kvm.c
> @@ -2545,14 +2545,12 @@ int kvm_arch_fixup_msi_route(struct kvm_irq_routing_entry *route,
>          return -ENODEV;
>      }
>  
> -    pbdev->routes.adapter.ind_offset = vec;
> -
>      route->type = KVM_IRQ_ROUTING_S390_ADAPTER;
>      route->flags = 0;
>      route->u.adapter.summary_addr = pbdev->routes.adapter.summary_addr;
>      route->u.adapter.ind_addr = pbdev->routes.adapter.ind_addr;
>      route->u.adapter.summary_offset = pbdev->routes.adapter.summary_offset;
> -    route->u.adapter.ind_offset = pbdev->routes.adapter.ind_offset;
> +    route->u.adapter.ind_offset = pbdev->routes.adapter.ind_offset + vec;
>      route->u.adapter.adapter_id = pbdev->routes.adapter.adapter_id;
>      return 0;
>  }

Looks good. I assume you'll send a v3, so I'll hold off on applying for
now.
