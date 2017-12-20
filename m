Received: from eggs.gnu.org ([2001:4830:134:3::10]:55168)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1eRcOS-0005cw-2j
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 06:18:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1eRcOR-0002mf-37
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 06:18:36 -0500
Date: Wed, 20 Dec 2017 12:18:22 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20171220111822.GA6374@localhost.localdomain>
References: <20171220103412.13048-1-kwolf@redhat.com>
	<20171220103412.13048-17-kwolf@redhat.com>
	<974e7f62-412a-21e8-d502-a0e7a99015cc@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <974e7f62-412a-21e8-d502-a0e7a99015cc@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 16/19] block: Allow graph changes in
 subtree drained section
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-block@nongnu.org, famz@redhat.com, qemu-devel@nongnu.org

Am 20.12.2017 um 11:51 hat Paolo Bonzini geschrieben:
> On 20/12/2017 11:34, Kevin Wolf wrote:
> >      .inherit_options = bdrv_inherited_options,
> >      .drained_begin   = bdrv_child_cb_drained_begin,
> >      .drained_end     = bdrv_child_cb_drained_end,
> > +    .attach          = bdrv_child_cb_attach,
> > +    .detach          = bdrv_child_cb_detach,
> >      .inactivate      = bdrv_child_cb_inactivate,
> >  };
> >  
> > @@ -911,6 +933,8 @@ const BdrvChildRole child_format = {
> >      .inherit_options = bdrv_inherited_fmt_options,
> >      .drained_begin   = bdrv_child_cb_drained_begin,
> >      .drained_end     = bdrv_child_cb_drained_end,
> > +    .attach          = bdrv_child_cb_attach,
> > +    .detach          = bdrv_child_cb_detach,
> >      .inactivate      = bdrv_child_cb_inactivate,
> 
> Is there any case of a BdrvChildRole that doesn't want these callbacks?
> Maybe the functions should be called after ->attach and before ->detach
> (e.g. bdrv_{,un}apply_subtree_drain), rather than modifying the
> BdrvChildRole implementations.

At first I intended to implement it directly in
bdrv_replace_child_noperm(), but the thing is that you need the
bs->recursive_quiesce_counter of the parent BDS - but not all parents of
a BdrvChild are even a BDS. It could also be a BB root child or a block
job child. This is why we only have a void *opaque rather than a BDS
pointer for the parent.

The other option would be an additional BdrvChildRole callback like
.get_recursive_quiesce_counter, but compared to that, I like some code
in .attach/.detach better.

> Then they can be put in block/io.c, and bdrv_do_drained_* can remain
> static.  (I would also consider extracting block/drain.c, but it is
> painful to do it now that you have this nice series---so let's do it after).

I can keep that in mind for part 3 (or 4, whatever it may become).

Kevin
