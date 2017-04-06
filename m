Received: from eggs.gnu.org ([2001:4830:134:3::10]:48674)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cw5dd-0004Xe-Ho
	for qemu-devel@nongnu.org; Thu, 06 Apr 2017 07:31:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cw5dc-00015F-Ct
	for qemu-devel@nongnu.org; Thu, 06 Apr 2017 07:31:41 -0400
Date: Thu, 6 Apr 2017 12:31:27 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170406113103.GG11940@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <1491320156-4629-1-git-send-email-kwolf@redhat.com>
	<d74fad45-9f89-6f34-020f-87e6b20ea59b@redhat.com>
	<20170406112256.GF4341@noname.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170406112256.GF4341@noname.redhat.com>
Subject: Re: [Qemu-devel] [RFC PATCH for-2.9] block: Ignore guest dev
 permissions during incoming migration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org, armband@enea.com, jcody@redhat.com, Ciprian.Barbu@enea.com, qemu-devel@nongnu.org, Alexandru.Avadanii@enea.com, pbonzini@redhat.com

On Thu, Apr 06, 2017 at 01:22:56PM +0200, Kevin Wolf wrote:
> Am 05.04.2017 um 15:22 hat Max Reitz geschrieben:
> > On 04.04.2017 17:35, Kevin Wolf wrote:
> > > Usually guest devices don't like other writers to the same image, so
> > > they use blk_set_perm() to prevent this from happening. In the migration
> > > phase before the VM is actually running, though, they don't have a
> > > problem with writes to the image. On the other hand, storage migration
> > > needs to be able to write to the image in this phase, so the restrictive
> > > blk_set_perm() call of qdev devices breaks it.
> > > 
> > > This patch flags all BlockBackends with a qdev device as
> > > blk->disable_perm during incoming migration, which means that the
> > > requested permissions are stored in the BlockBackend, but not actually
> > > applied to its root node yet.
> > > 
> > > Once migration has finished and the VM should be resumed, the
> > > permissions are applied. If they cannot be applied (e.g. because the NBD
> > > server used for block migration hasn't been shut down), resuming the VM
> > > fails.
> > > 
> > > Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> > > ---
> > >  block/block-backend.c | 40 +++++++++++++++++++++++++++++++++++++++-
> > >  include/block/block.h |  2 ++
> > >  migration/migration.c |  8 ++++++++
> > >  qmp.c                 |  6 ++++++
> > >  4 files changed, 55 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/block/block-backend.c b/block/block-backend.c
> > > index 0b63773..f817040 100644
> > > --- a/block/block-backend.c
> > > +++ b/block/block-backend.c
> > 
> > [...]
> > 
> > > @@ -597,15 +598,52 @@ void blk_get_perm(BlockBackend *blk, uint64_t *perm, uint64_t *shared_perm)
> > >      *shared_perm = blk->shared_perm;
> > >  }
> > >  
> > > +/*
> > > + * Notifies the user of all BlockBackends that migration has completed. qdev
> > > + * devices can tighten their permissions in response (specifically revoke
> > > + * shared write permissions that we needed for storage migration).
> > > + *
> > > + * If an error is returned, the VM cannot be allowed to be resumed.
> > > + */
> > > +void blk_resume_after_migration(Error **errp)
> > > +{
> > > +    BlockBackend *blk;
> > > +    Error *local_err = NULL;
> > > +
> > > +    for (blk = blk_next(NULL); blk; blk = blk_next(blk)) {
> > 
> > Shouldn't we use blk_all_next()?
> 
> Good catch, thanks.
> 
> At first I added it into the loop in qmp_cont() and then copied it here
> without noticing the resetting the iostatus is really only needed for
> monitor-owned BBs at the moment, but this one is different.
> 
> Of course, as soon as we improve query-block to work reasonably well
> with -device drive=<node-name>, qmp_cont() needs to use blk_all_next(),
> too.
> 
> > Trusting you that silently disabling autostart is something the upper
> > layers can deal with, the rest looks good to me.
> > 
> > (The only other runtime changes of autostart apart from stop/cont appear
> > to be in blockdev_init() (if (bdrv_key_required()), but I don't think
> > that can happen anymore) and in migration/colo.c (which enables it and
> > emits an error message).)
> 
> I think in practice libvirt always sets -S on the destination anyway.

Libvirt uses -S for *all* QEMU instances it starts, regardless of use of
migration, since we need todo things after qemu starts, but before CPUs
are run.


Regards,
Daniel
-- 
|: http://berrange.com      -o-    http://www.flickr.com/photos/dberrange/ :|
|: http://libvirt.org              -o-             http://virt-manager.org :|
|: http://entangle-photo.org       -o-    http://search.cpan.org/~danberr/ :|
