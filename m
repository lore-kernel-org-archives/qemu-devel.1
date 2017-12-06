Received: from eggs.gnu.org ([2001:4830:134:3::10]:35188)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1eMPcr-0007AE-LV
	for qemu-devel@nongnu.org; Tue, 05 Dec 2017 21:39:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1eMPco-0004tb-AK
	for qemu-devel@nongnu.org; Tue, 05 Dec 2017 21:39:57 -0500
Received: from mx1.redhat.com ([209.132.183.28]:38228)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1eMPcn-0004sq-V9
	for qemu-devel@nongnu.org; Tue, 05 Dec 2017 21:39:54 -0500
Date: Wed, 6 Dec 2017 10:39:45 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20171206023945.GC2797@xz-mi>
References: <20171205065307.21853-1-peterx@redhat.com>
	<20171205184341.GF2405@work-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20171205184341.GF2405@work-vm>
Subject: Re: [Qemu-devel] [PATCH v5 00/28] Migration: postcopy failure
 recovery
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: qemu-devel@nongnu.org, Andrea Arcangeli <aarcange@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>, Juan Quintela <quintela@redhat.com>, Alexey Perevalov <a.perevalov@samsung.com>

On Tue, Dec 05, 2017 at 06:43:42PM +0000, Dr. David Alan Gilbert wrote:
> * Peter Xu (peterx@redhat.com) wrote:
> > Tree is pushed here for better reference and testing (online tree
> > includes monitor OOB series):
> > 
> >   https://github.com/xzpeter/qemu/tree/postcopy-recover-all
> > 
> > This version removed quite a few patches related to migrate-incoming,
> > instead I introduced a new command "migrate-recover" to trigger the
> > recovery channel on destination side to simplify the code.
> > 
> > To test this two series altogether, please checkout above tree and
> > build.  Note: to test on small and single host, one need to disable
> > full bandwidth postcopy migration otherwise it'll complete very fast.
> > Basically a simple patch like this would help:
> > 
> > diff --git a/migration/migration.c b/migration/migration.c
> > index 4de3b551fe..c0206023d7 100644
> > --- a/migration/migration.c
> > +++ b/migration/migration.c
> > @@ -1904,7 +1904,7 @@ static int postcopy_start(MigrationState *ms, bool *old_vm_running)
> >       * will notice we're in POSTCOPY_ACTIVE and not actually
> >       * wrap their state up here
> >       */
> > -    qemu_file_set_rate_limit(ms->to_dst_file, INT64_MAX);
> > +    // qemu_file_set_rate_limit(ms->to_dst_file, INT64_MAX);
> >      if (migrate_postcopy_ram()) {
> >          /* Ping just for debugging, helps line traces up */
> >          qemu_savevm_send_ping(ms->to_dst_file, 2);
> > 
> > This patch is included already in above github tree.  Please feel free
> > to drop this patch when want to test on big machines and between real
> > hosts.
> > 
> > Detailed Test Procedures (QMP only)
> > ===================================
> > 
> > 1. start source QEMU.
> > 
> > $qemu -M q35,kernel-irqchip=split -enable-kvm -snapshot \
> >      -smp 4 -m 1G -qmp stdio \
> >      -name peter-vm,debug-threads=on \
> >      -netdev user,id=net0 \
> >      -device e1000,netdev=net0 \
> >      -global migration.x-max-bandwidth=4096 \
> >      -global migration.x-postcopy-ram=on \
> >      /images/fedora-25.qcow2
> 
> I suspect -snapshot isn't doing the right thing to the storage when
> combined with the migration - I'm assuming the destination isn't using
> the same temporary file.
> (Also any reason for specifying split irqchip?)

Ah yes.  Sorry we should not use "-snapshot" here.  Please remove it.

I think my smoke test just didn't try to fetch anything on that temp
storage so nothing went wrong.

And, no reason for split irqchip - I just fetched this command line
somewhere where I was testing IOMMUs. :-) Please feel free to remove
it too if you want.

(so basically I was just pasting my smoke test command lines, not
 really command line required to run the tests)

> 
> > 2. start destination QEMU.
> > 
> > $qemu -M q35,kernel-irqchip=split -enable-kvm -snapshot \
> >      -smp 4 -m 1G -qmp stdio \
> >      -name peter-vm,debug-threads=on \
> >      -netdev user,id=net0 \
> >      -device e1000,netdev=net0 \
> >      -global migration.x-max-bandwidth=4096 \
> >      -global migration.x-postcopy-ram=on \
> >      -incoming tcp:0.0.0.0:5555 \
> >      /images/fedora-25.qcow2
> > 
> > 3. On source, do QMP handshake as normal:
> > 
> >   {"execute": "qmp_capabilities"}
> >   {"return": {}}
> > 
> > 4. On destination, do QMP handshake to enable OOB:
> > 
> >   {"execute": "qmp_capabilities", "arguments": { "enable": [ "oob" ] } }
> >   {"return": {}}
> > 
> > 5. On source, trigger initial migrate command, switch to postcopy:
> > 
> >   {"execute": "migrate", "arguments": { "uri": "tcp:localhost:5555" } }
> >   {"return": {}}
> >   {"execute": "query-migrate"}
> >   {"return": {"expected-downtime": 300, "status": "active", ...}}
> >   {"execute": "migrate-start-postcopy"}
> >   {"return": {}}
> >   {"timestamp": {"seconds": 1512454728, "microseconds": 768096}, "event": "STOP"}
> >   {"execute": "query-migrate"}
> >   {"return": {"expected-downtime": 44472, "status": "postcopy-active", ...}}
> > 
> > 6. On source, manually trigger a "fake network down" using
> >    "migrate-cancel" command:
> > 
> >   {"execute": "migrate_cancel"}
> >   {"return": {}}
> > 
> >   During postcopy, it'll not really cancel the migration, but pause
> >   it.  On both sides, we should see this on stderr:
> > 
> >   qemu-system-x86_64: Detected IO failure for postcopy. Migration paused.
> > 
> >   It means now both sides are in postcopy-pause state.
> > 
> > 7. (Optional) On destination side, let's try to hang the main thread
> >    using the new x-oob-test command, providing a "lock=true" param:
> > 
> >    {"execute": "x-oob-test", "id": "lock-dispatcher-cmd",
> >     "arguments": { "lock": true } }
> > 
> >    After sending this command, we should not see any "return", because
> >    main thread is blocked already.  But we can still use the monitor
> >    since the monitor now has dedicated IOThread.
> > 
> > 8. On destination side, provide a new incoming port using the new
> >    command "migrate-recover" (note that if step 7 is carried out, we
> >    _must_ use OOB form, otherwise the command will hang.  With OOB,
> >    this command will return immediately):
> > 
> >   {"execute": "migrate-recover", "id": "recover-cmd",
> >    "arguments": { "uri": "tcp:localhost:5556" },
> >    "control": { "run-oob": true } }
> >   {"timestamp": {"seconds": 1512454976, "microseconds": 186053},
> >    "event": "MIGRATION", "data": {"status": "setup"}}
> >   {"return": {}, "id": "recover-cmd"}
> > 
> >    We can see that the command will success even if main thread is
> >    locked up.
> > 
> > 9. (Optional) This step is only needed if step 7 is carried out. On
> >    destination, let's unlock the main thread before resuming the
> >    migration, this time with "lock=false" to unlock the main thread
> >    (since system running needs the main thread). Note that we _must_
> >    use OOB command here too:
> > 
> >   {"execute": "x-oob-test", "id": "unlock-dispatcher",
> >    "arguments": { "lock": false }, "control": { "run-oob": true } }
> >   {"return": {}, "id": "unlock-dispatcher"}
> >   {"return": {}, "id": "lock-dispatcher-cmd"}
> > 
> >   Here the first "return" is the reply to the unlock command, the
> >   second "return" is the reply to the lock command.  After this
> >   command, main thread is released.
> > 
> > 10. On source, resume the postcopy migration:
> > 
> >   {"execute": "migrate", "arguments": { "uri": "tcp:localhost:5556", "resume": true }}
> >   {"return": {}}
> >   {"execute": "query-migrate"}
> >   {"return": {"status": "completed", ...}}
> 
> The use of x-oob-test to lock things is a bit different to reality
> and that means the ordering is different.
> When the destination is blocked by a page request, that page won't
> become unstuck until sometime after (10) happens and delivers the page
> to the target.
> 
> You could try an 'info cpu' on the destination at (7) - although it's
> not guaranteed to lock, depending whether the page needed has arrived.

Yes info cpus (or say "query-cpus", in QMP) would work too.  The
"return" will be delayed until sending the resuming command, but it's
the same thing - here I just want to make sure main thread is totally
hang death, so I can know whether the new accept() port and the whole
workflow will work even with that.

Btw, IMHO "info cpus" should guarantee a block, if not, we just do
something in guest to make sure guest hangs, then at least one vcpu
must be waiting for a page.  Thanks!

-- 
Peter Xu
