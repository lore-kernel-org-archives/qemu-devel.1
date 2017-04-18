Received: from eggs.gnu.org ([2001:4830:134:3::10]:37618)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1d0PNI-0006zK-KG
	for qemu-devel@nongnu.org; Tue, 18 Apr 2017 05:24:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1d0PNH-0003Lc-EM
	for qemu-devel@nongnu.org; Tue, 18 Apr 2017 05:24:40 -0400
Date: Tue, 18 Apr 2017 17:24:28 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170418092428.GB490@lemon.lan>
References: <20170321031635.22123-1-famz@redhat.com>
	<20170321031635.22123-5-famz@redhat.com>
	<20170410085728.GB2567@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170410085728.GB2567@stefanha-x1.localdomain>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH RFC 04/16] block: Propagate
 BLK_PERM_AIO_CONTEXT_CHANGE down the graph
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, qemu-block@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>, Max Reitz <mreitz@redhat.com>

On Mon, 04/10 09:57, Stefan Hajnoczi wrote:
> On Tue, Mar 21, 2017 at 11:16:23AM +0800, Fam Zheng wrote:
> > @@ -1713,21 +1714,22 @@ void bdrv_format_default_perms(BlockDriverState *bs, BdrvChild *c,
> >          perm |= BLK_PERM_CONSISTENT_READ;
> >          shared &= ~(BLK_PERM_WRITE | BLK_PERM_RESIZE);
> >      } else {
> > -        /* We want consistent read from backing files if the parent needs it.
> > +        /* We want consistent read and aio context change from backing files if
> > +         * the parent needs it.
> >           * No other operations are performed on backing files. */
> > -        perm &= BLK_PERM_CONSISTENT_READ;
> > +        perm &= BLK_PERM_CONSISTENT_READ | BLK_PERM_AIO_CONTEXT_CHANGE;
> >  
> > -        /* If the parent can deal with changing data, we're okay with a
> > +        /* If the parent can deal with changing aio context, we're okay too;
> > +         * If the parent can deal with changing data, we're okay with a
> >           * writable and resizable backing file. */
> >          /* TODO Require !(perm & BLK_PERM_CONSISTENT_READ), too? */
> > +        shared &= BLK_PERM_AIO_CONTEXT_CHANGE | BLK_PERM_WRITE;
> >          if (shared & BLK_PERM_WRITE) {
> > -            shared = BLK_PERM_WRITE | BLK_PERM_RESIZE;
> > -        } else {
> > -            shared = 0;
> > +            shared |= BLK_PERM_WRITE | BLK_PERM_RESIZE;
> 
> We already have BLK_PERM_WRITE so we're just adding BLK_PERM_RESIZE.
> The following is clearer:
> 
>   shared |= BLK_PERM_RESIZE;
> 
> >          }
> >  
> >          shared |= BLK_PERM_CONSISTENT_READ | BLK_PERM_GRAPH_MOD |
> > -                  BLK_PERM_WRITE_UNCHANGED;
> > +                  BLK_PERM_WRITE_UNCHANGED | BLK_PERM_AIO_CONTEXT_CHANGE;
> 
> Why was shared &= BLK_PERM_AIO_CONTEXT_CHANGE necessary above if we
> unconditionally OR it here?

It's redundant. Will fix both.

Fam
