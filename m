Received: from eggs.gnu.org ([2001:4830:134:3::10]:53765)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1eZvci-0001W9-De
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 04:27:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1eZvcf-0003DI-2p
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 04:27:40 -0500
Received: from mx1.redhat.com ([209.132.183.28]:47208)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1eZvce-0003BU-Mg
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 04:27:36 -0500
Date: Fri, 12 Jan 2018 17:27:28 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20180112092728.GP2551@xz-mi>
References: <20171205065307.21853-1-peterx@redhat.com>
	<20180111165930.GE2669@work-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180111165930.GE2669@work-vm>
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

On Thu, Jan 11, 2018 at 04:59:32PM +0000, Dr. David Alan Gilbert wrote:
> * Peter Xu (peterx@redhat.com) wrote:
> > Tree is pushed here for better reference and testing (online tree
> > includes monitor OOB series):
> > 
> >   https://github.com/xzpeter/qemu/tree/postcopy-recover-all
> > 
> > This version removed quite a few patches related to migrate-incoming,
> > instead I introduced a new command "migrate-recover" to trigger the
> > recovery channel on destination side to simplify the code.
> 
> I've got this setup on a couple of my test hosts, and I'm using
> iptables to try breaking the connection.
> 
> See below for where I got stuck.
> 
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
> >
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
> 
> I'm using:
> ./x86_64-softmmu/qemu-system-x86_64 -nographic -M pc,accel=kvm -smp 4 -m 16G -drive file=/home/vms/rhel71.qcow2,id=d,cache=none,if=none -device virtio-blk,drive=d -vnc 0:0 -incoming tcp:0:8888 -chardev socket,port=4000,host=0,id=mon,server,nowait,telnet -mon chardev=mon,id=mon,mode=control -nographic -chardev stdio,mux=on,id=monh -mon chardev=monh,mode=readline --device isa-serial,chardev=monh
> and I've got both the HMP on the stdio, and the QMP via a telnet
> 
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
> 
> Before I do that, I'm breaking the network connection by running on the
> source:
> iptables -A INPUT -p tcp --source-port 8888 -j DROP
> iptables -A INPUT -p tcp --destination-port 8888 -j DROP

This is tricky... I think tcp keepalive may help, but for sure I
think we do need a way to cancel the migration on both side.  Please
see below comment.

> 
> >   During postcopy, it'll not really cancel the migration, but pause
> >   it.  On both sides, we should see this on stderr:
> > 
> >   qemu-system-x86_64: Detected IO failure for postcopy. Migration paused.
> > 
> >   It means now both sides are in postcopy-pause state.
> 
> Now, here we start to have a problem; I do the migrate-cancel on the
> source, that works and goes into pause; but remember the network is
> broken, so the destination hasn't received the news.
> 
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
> 
> Because the destination didn't get the news of the pause, I get:
> {"id": "recover-cmd", "error": {"class": "GenericError", "desc": "Migrate recover can only be run when postcopy is paused."}}

This is normal since we didn't fail on destination, while...

> 
> and I can't explicitly cause a cancel on the destination:
> {"id": "cancel-cmd", "error": {"class": "GenericError", "desc": "The command migrate_cancel does not support OOB"}}

... this is not normal.  I have two questions:

1. Have you provided

  "control": {"run-oob": true}

  field when sending command "migrate_cancel"?  Just to mention that
  we shouldn't do it in oob way for migrate_cancel.  Or it can be a
  monitor-oob bug.

2. Do we need to support "migrate_cancel" on destination?

For (2), I think we need it, but for now it only works on source for
sure.  So I think maybe I should add that support.

> 
> So I think we need a way out of this on the destination.

So that's my 2nd question.  How about we do this: migrate_cancel will
cancel incoming migration if:

        a. there is one incoming migration in progress, and
        b. postcopy is enabled

Thanks,

-- 
Peter Xu
