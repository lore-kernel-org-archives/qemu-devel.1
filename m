Received: from eggs.gnu.org ([2001:4830:134:3::10]:37922)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dT7SZ-00069Y-PD
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 10:08:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dT7SY-0003mF-G2
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 10:08:47 -0400
Date: Thu, 6 Jul 2017 11:08:37 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20170706140837.GE12152@localhost.localdomain>
References: <20170608133906.12737-1-ehabkost@redhat.com>
	<20170608133906.12737-2-ehabkost@redhat.com>
	<87fuebrtuk.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87fuebrtuk.fsf@dusky.pond.sub.org>
Subject: Re: [Qemu-devel] [PATCH 1/5] xilinx: Fix error handling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Jason Wang <jasowang@redhat.com>, qemu-arm@nongnu.org, Alistair Francis <alistair.francis@xilinx.com>

On Wed, Jul 05, 2017 at 01:44:35PM +0200, Markus Armbruster wrote:
> Eduardo Habkost <ehabkost@redhat.com> writes:
> 
> > Assigning directly to *errp is not valid, as errp may be NULL,
> > &error_fatal, or &error_abort.  Use error_propagate() instead.
> >
> > error_propagate() handles non-NULL *errp correctly, so the
> > "if (!*errp)" check can be removed.
> >
> > Cc: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
> > Cc: Alistair Francis <alistair.francis@xilinx.com>
> > Cc: Jason Wang <jasowang@redhat.com>
> > Cc: qemu-arm@nongnu.org
> > Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
> > ---
> >  hw/dma/xilinx_axidma.c  | 4 +---
> >  hw/net/xilinx_axienet.c | 4 +---
> >  2 files changed, 2 insertions(+), 6 deletions(-)
> >
> > diff --git a/hw/dma/xilinx_axidma.c b/hw/dma/xilinx_axidma.c
> > index 6065689ad1..3987b5ff96 100644
> > --- a/hw/dma/xilinx_axidma.c
> > +++ b/hw/dma/xilinx_axidma.c
> > @@ -554,9 +554,7 @@ static void xilinx_axidma_realize(DeviceState *dev, Error **errp)
> >      return;
> >  
> >  xilinx_axidma_realize_fail:
> > -    if (!*errp) {
> > -        *errp = local_err;
> > -    }
> > +    error_propagate(errp, local_err);
> >  }
> >  
> >  static void xilinx_axidma_init(Object *obj)
> > diff --git a/hw/net/xilinx_axienet.c b/hw/net/xilinx_axienet.c
> > index b6701844d3..5ffa739f68 100644
> > --- a/hw/net/xilinx_axienet.c
> > +++ b/hw/net/xilinx_axienet.c
> > @@ -981,9 +981,7 @@ static void xilinx_enet_realize(DeviceState *dev, Error **errp)
> >      return;
> >  
> >  xilinx_enet_realize_fail:
> > -    if (!*errp) {
> > -        *errp = local_err;
> > -    }
> > +    error_propagate(errp, local_err);
> >  }
> >  
> >  static void xilinx_enet_init(Object *obj)
> 
> The qdev core always passes &err.  So this is "merely" a fix for a
> latent bug.
> 
> If it could pass null, you'd fix a crash bug.
> 
> If it could pass pointer to non-null (&error_fatal, &error_abort), you'd
> plug a memory leak.
> 
> Suggest to rephrase the commit message:
> 
>     xilinx: Fix latent error handling bug
> 
>     Assigning directly to *errp is not valid, as errp may be null,
>     &error_fatal, or &error_abort.  The !*errp conditional protects
>     against the latter two, but we then leak @local_err.  Fortunately,
>     the qdev core always passes pointer to null, so this is "merely" a
>     latent bug.
> 
>     Use error_propagate() instead.
> 
> What do you think?

Looks good to me.  Do you want to fix it when applying?

> 
> With something like that:
> Reviewed-by: Markus Armbruster <armbru@redhat.com>

Thanks!

-- 
Eduardo
