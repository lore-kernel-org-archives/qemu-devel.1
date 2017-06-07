Received: from eggs.gnu.org ([2001:4830:134:3::10]:42271)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dIRet-00039r-Hl
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 23:29:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dIRes-0007Av-IY
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 23:29:23 -0400
Date: Wed, 7 Jun 2017 11:29:08 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20170607032908.GB6479@pxdev.xzpeter.org>
References: <20170606052438.35405-1-haoqf@linux.vnet.ibm.com>
	<20170606052438.35405-2-haoqf@linux.vnet.ibm.com>
	<20170606124953.GD5448@noname.redhat.com>
	<20170606174218.GA2411@work-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170606174218.GA2411@work-vm>
Subject: Re: [Qemu-devel] [PATCH v2 1/1] qemu/migration: fix the double free
 problem on from_src_file
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>, quintela@redhat.com, QingFeng Hao <haoqf@linux.vnet.ibm.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org, borntraeger@de.ibm.com, cornelia.huck@de.ibm.com, liujbjl@linux.vnet.ibm.com, famz@redhat.com

On Tue, Jun 06, 2017 at 06:42:18PM +0100, Dr. David Alan Gilbert wrote:
> * Kevin Wolf (kwolf@redhat.com) wrote:
> > Am 06.06.2017 um 07:24 hat QingFeng Hao geschrieben:
> > > In load_snapshot, mis->from_src_file is freed twice, the first free is by
> > > qemu_fclose, the second is by migration_incoming_state_destroy and
> > > it causes Illegal instruction exception. The fix is just to remove the
> > > first free.
> > > 
> > > This problem is found by qemu-iotests case 068 since commit
> > > "660819b migration: shut src return path unconditionally". The error is:
> > > 068 1s ... - output mismatch (see 068.out.bad)
> > >     --- tests/qemu-iotests/068.out	2017-05-06 01:00:26.417270437 +0200
> > >     +++ 068.out.bad	2017-06-03 13:59:55.360274640 +0200
> > >     @@ -6,6 +6,8 @@
> > >      QEMU X.Y.Z monitor - type 'help' for more information
> > >      (qemu) savevm 0
> > >      (qemu) quit
> > >     +./common.config: line 107: 242472 Illegal instruction     (core dumped) ( if [ -n "${QEMU_NEED_PID}" ]; then
> > >     +    echo $BASHPID > "${QEMU_TEST_DIR}/qemu-${_QEMU_HANDLE}.pid";
> > >     +fi; exec "$QEMU_PROG" $QEMU_OPTIONS "$@" )
> > >      QEMU X.Y.Z monitor - type 'help' for more information
> > >     -(qemu) quit
> > >     -*** done
> > >     +(qemu) *** done
> > > 
> > > Signed-off-by: QingFeng Hao <haoqf@linux.vnet.ibm.com>
> > > Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> > > Reviewed-by: Peter Xu <peterx@redhat.com>
> > 
> > Dave, as you only gave R-b rather than merging the patch, should this be
> > merged through the block tree?
> 
> I'm happy for it to go via block but also happy for it to go via
> migration; Juan is mostly doing the migration set at the moment since
> they're dominated by his cleanups.
> 
> > > diff --git a/migration/savevm.c b/migration/savevm.c
> > > index 9c320f59d0..853e14e34e 100644
> > > --- a/migration/savevm.c
> > > +++ b/migration/savevm.c
> > > @@ -2290,7 +2290,6 @@ int load_snapshot(const char *name, Error **errp)
> > >  
> > >      aio_context_acquire(aio_context);
> > >      ret = qemu_loadvm_state(f);
> > > -    qemu_fclose(f);
> > >      aio_context_release(aio_context);
> > >  
> > >      migration_incoming_state_destroy();
> > 
> > Did we check other callers of migration_incoming_state_destroy()?
> > 
> > For example, qmp_xen_load_devices_state() looks suspicious, too.
> 
> Hmm, it looks suspicious in the opposite direction; it never sets
> mis->from_src_file as was added by b4b076da into the load_snapshot path.

Agree.

Does qmp_xen_load_devices_state() needs to call
migration_incoming_state_destroy() after all? Since the latter
function only cleanups MigrationIncomingState and looks like the
former xen code didn't really use it at all.

> 
> > I can't tell for postcopy_ram_listen_thread() - commit 660819b didn't
> > seem to remove a qemu_fclose() call there, but I can't see one left
> > behind either. Was the file leaked before commit 660819b or am I
> > missing something?
> 
> I don't think there's a problem in the postcopy path, although hmm was
> I missing a close before?
> 
> Dave
> > 
> > Kevin
> --
> Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK

-- 
Peter Xu
