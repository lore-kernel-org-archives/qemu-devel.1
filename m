Received: from eggs.gnu.org ([2001:4830:134:3::10]:38948)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1cw3Kk-000419-Tl
	for qemu-devel@nongnu.org; Thu, 06 Apr 2017 05:04:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1cw3Kh-0004zV-Np
	for qemu-devel@nongnu.org; Thu, 06 Apr 2017 05:04:02 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57340)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1cw3Kh-0004z0-Fu
	for qemu-devel@nongnu.org; Thu, 06 Apr 2017 05:03:59 -0400
Date: Thu, 6 Apr 2017 11:03:47 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20170406090347.GD4341@noname.redhat.com>
References: <33ced3d3-acd7-2945-518d-465a4621b151@redhat.com>
	<20170403130041.GD5036@noname.str.redhat.com>
	<20170403135012.GY26598@andariel.pipo.sk>
	<20170404121624.GA4536@noname.str.redhat.com>
	<d270f1a4-5814-9b23-61f6-745c73ecaadd@redhat.com>
	<20170404145348.GD4536@noname.str.redhat.com>
	<b58edec8-b383-5079-77f2-6f194701ce52@redhat.com>
	<20170405110131.GA5161@noname.redhat.com>
	<1556fcc9-50ab-7458-74fe-41756f1dd451@redhat.com>
	<20170406084824.GA4341@noname.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170406084824.GA4341@noname.redhat.com>
Subject: Re: [Qemu-devel] nbd: Possible regression in 2.9 RCs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Peter Krempa <pkrempa@redhat.com>, svc-armband <armband@enea.com>, Markus Armbruster <armbru@redhat.com>, Jeff Cody <jcody@redhat.com>, Ciprian Barbu <Ciprian.Barbu@enea.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Max Reitz <mreitz@redhat.com>, Alexandru Avadanii <Alexandru.Avadanii@enea.com>

Am 06.04.2017 um 10:48 hat Kevin Wolf geschrieben:
> Am 05.04.2017 um 23:13 hat Paolo Bonzini geschrieben:
> > On 05/04/2017 13:01, Kevin Wolf wrote:
> > > Am 04.04.2017 um 17:09 hat Paolo Bonzini geschrieben:
> > >> On 04/04/2017 16:53, Kevin Wolf wrote:
> > >>>> The big question is how this fits into release management.  We have
> > >>>> another important regression from the op blocker work and only a week
> > >>>> to go before the last rc.  Are we going to delay 2.9 arbitrarily?  Are
> > >>>> we going to shorten the 2.10 development period correspondingly?  (I
> > >>>> vote yes and yes, FWIW).
> > >>> Which is the other regression?
> > >>
> > >> The assertion failure for snapshot_blkdev with iothreads.
> > > 
> > > Ah, right, I keep forgetting that this started appearing with the op
> > > blocker series because the failure mode is completely different, so it
> > > seems to have been a latent bug somewhere else that was uncovered by it.
> > > 
> > > If we're sure that the change of the order in bdrv_append() is what
> > > caused the bug to appear, we can just undo that for 2.9, at the cost of
> > > a messed up graph in the error case when bdrv_set_backing_hd() fails
> > > (because we have no way to undo bdrv_replace_node()).
> > 
> > I don't know if that is enough to fix all of the issues, but the bug is
> > easy to reproduce.
> > 
> > The issue is the lack of understanding of what node movement does to
> > quiesce_counter.  The invariant is that children cannot have a lower
> > quiesce_counter than parents, I think (paths in the graph can only join
> > in the children direction, right?).
> 
> Maybe I'm missing something, but I think this isn't true at all. Drains
> are propagated to the parents, so that this specific node doesn't
> receive new requests, but not to the children. The assumption is that
> children don't do anything anyway without requests from their parents,
> so they are effectively quiesced even with quiesce_counter == 0.
> 
> So if anything, the invariant should be the exact opposite: Parents
> cannot have a lower quiesce_counter than their children.
> 
> I think the exact thing that the quiesce_counter of a node is expected
> to be is the number of paths from itself to an explicitly drained node
> in the directed block driver graph (counting one path if it is
> explicitly drained itself). A path counts multiple times if a node is
> explicitly drained multiple times.
> 
> > Is it checked, and are there violations already?  Maybe we need a
> > get_quiesce_counter method in BdrvChildRole, to cover BlockBackend's
> > quiesce_counter?  Then we can use that information to adjust the
> > quiesce_counter when nodes move in the graph.
> 
> We would need that if we had a downwards propagation and if a
> BlockBackend could be drained, but as it stands, I don't see what could
> be missing from bdrv_replace_child_noperm() (well, except that I think
> your patch is right to avoid calling drained_end/begin if both nodes
> were drained because new requests could sneak in this way in theory).

Actually, to get this part completely right, we also need to drain the
BlockBackend _before_ attaching the new BDS. Otherwise, if the old BDS
wasn't quiesced, but the new one is, the BdrvChildRole.drained_begin()
callback could send requests to the already drained new BDS.

Kevin

> > The block layer has good tests, but as the internal logic grows more
> > complex we should probably have more C level tests.  I'm constantly
> > impressed by the amount of tricky cases that test-replication.c catches
> > in the block job code.
> 
> Never really noticed test-replication specifically catching things when
> I worked on the op blockers code which changed a lot around block jobs,
> but that we should consider this type of tests more often is probably a
> good point.
> 
> Kevin
