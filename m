Received: from eggs.gnu.org ([2001:4830:134:3::10]:34235)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1cnzGP-0000fY-Gn
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 23:06:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1cnzGO-0004dd-KC
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 23:06:13 -0400
Date: Wed, 15 Mar 2017 11:06:04 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170315030604.GB3088@lemon.lan>
References: <20170314023050.32756-1-famz@redhat.com>
	<02221132-c55f-e7af-67f2-5f7da67f30a0@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <02221132-c55f-e7af-67f2-5f7da67f30a0@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] block: Always call bdrv_child_check_perm
 first
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>

On Tue, 03/14 08:28, Eric Blake wrote:
> On 03/13/2017 09:30 PM, Fam Zheng wrote:
> > bdrv_child_set_perm alone is not very usable because the caller must
> > call bdrv_child_check_perm first. This is already encapsulated
> > conveniently in bdrv_child_try_set_perm, so remove the other prototypes
> > from the header and fix the one wrong caller, block/mirror.c.
> > 
> > Signed-off-by: Fam Zheng <famz@redhat.com>
> > ---
> >  block.c                   | 13 +++++++++----
> >  block/mirror.c            |  6 ++++--
> >  include/block/block_int.h |  4 ----
> >  3 files changed, 13 insertions(+), 10 deletions(-)
> > 
> > diff --git a/block.c b/block.c
> > index cb57370..a77e8a0 100644
> > --- a/block.c
> > +++ b/block.c
> > @@ -1393,6 +1393,11 @@ static int bdrv_fill_options(QDict **options, const char *filename,
> >      return 0;
> >  }
> >  
> > +static int bdrv_child_check_perm(BdrvChild *c, uint64_t perm, uint64_t shared,
> > +                                 GSList *ignore_children, Error **errp);
> > +static void bdrv_child_abort_perm_update(BdrvChild *c);
> > +static void bdrv_child_set_perm(BdrvChild *c, uint64_t perm, uint64_t shared);
> > +
> 
> Now that you have static prototypes, is it worth rearranging the file
> (in a followup) to sort the function implementations into topological
> order so that a prototype is not necessary?  [In general, I try to code
> so that static prototypes are only necessary if I am implementing
> mutually-referencing recursive code. But it's not a strict requirement]

Yes, thanks for pointing out, but it does have a recursion here:

bdrv_check_update_perm
    -> bdrv_check_perm
        -> bdrv_child_check_perm
            -> bdrv_check_update_perm

Fam

> 
> Reviewed-by: Eric Blake <eblake@redhat.com>
> 
> -- 
> Eric Blake   eblake redhat com    +1-919-301-3266
> Libvirt virtualization library http://libvirt.org
> 
