Received: from eggs.gnu.org ([2001:4830:134:3::10]:40584)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1dJ0JV-0007AQ-Mk
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 12:29:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1dJ0JU-0005U6-Md
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 12:29:37 -0400
MIME-Version: 1.0
Sender: alistair23@gmail.com
In-Reply-To: <20170608133906.12737-2-ehabkost@redhat.com>
References: <20170608133906.12737-1-ehabkost@redhat.com>
	<20170608133906.12737-2-ehabkost@redhat.com>
From: Alistair Francis <alistair.francis@xilinx.com>
Date: Thu, 8 Jun 2017 09:29:04 -0700
Message-ID: <CAKmqyKN==edon2NC4wBNidsHChzbJ8CMvWgjvT2+LbjXOgwrOA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 1/5] xilinx: Fix error handling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Jason Wang <jasowang@redhat.com>, qemu-arm <qemu-arm@nongnu.org>, Markus Armbruster <armbru@redhat.com>, Alistair Francis <alistair.francis@xilinx.com>

On Thu, Jun 8, 2017 at 6:39 AM, Eduardo Habkost <ehabkost@redhat.com> wrote:
> Assigning directly to *errp is not valid, as errp may be NULL,
> &error_fatal, or &error_abort.  Use error_propagate() instead.
>
> error_propagate() handles non-NULL *errp correctly, so the
> "if (!*errp)" check can be removed.
>
> Cc: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
> Cc: Alistair Francis <alistair.francis@xilinx.com>
> Cc: Jason Wang <jasowang@redhat.com>
> Cc: qemu-arm@nongnu.org
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>

Reviewed-by: Alistair Francis <alistair.francis@xilinx.com>

Thanks,
Alistair

> ---
>  hw/dma/xilinx_axidma.c  | 4 +---
>  hw/net/xilinx_axienet.c | 4 +---
>  2 files changed, 2 insertions(+), 6 deletions(-)
>
> diff --git a/hw/dma/xilinx_axidma.c b/hw/dma/xilinx_axidma.c
> index 6065689ad1..3987b5ff96 100644
> --- a/hw/dma/xilinx_axidma.c
> +++ b/hw/dma/xilinx_axidma.c
> @@ -554,9 +554,7 @@ static void xilinx_axidma_realize(DeviceState *dev, Error **errp)
>      return;
>
>  xilinx_axidma_realize_fail:
> -    if (!*errp) {
> -        *errp = local_err;
> -    }
> +    error_propagate(errp, local_err);
>  }
>
>  static void xilinx_axidma_init(Object *obj)
> diff --git a/hw/net/xilinx_axienet.c b/hw/net/xilinx_axienet.c
> index b6701844d3..5ffa739f68 100644
> --- a/hw/net/xilinx_axienet.c
> +++ b/hw/net/xilinx_axienet.c
> @@ -981,9 +981,7 @@ static void xilinx_enet_realize(DeviceState *dev, Error **errp)
>      return;
>
>  xilinx_enet_realize_fail:
> -    if (!*errp) {
> -        *errp = local_err;
> -    }
> +    error_propagate(errp, local_err);
>  }
>
>  static void xilinx_enet_init(Object *obj)
> --
> 2.11.0.259.g40922b1
>
>
