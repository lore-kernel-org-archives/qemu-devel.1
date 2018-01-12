Received: from eggs.gnu.org ([2001:4830:134:3::10]:35560)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1eZyR6-000052-TT
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 07:27:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1eZyR4-0004yJ-Uf
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 07:27:52 -0500
Received: from mx1.redhat.com ([209.132.183.28]:34188)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1eZyR4-0004wj-KR
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 07:27:50 -0500
Date: Fri, 12 Jan 2018 12:27:42 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20180112122740.GA2247@work-vm>
References: <20171205065307.21853-1-peterx@redhat.com>
	<20180111165930.GE2669@work-vm> <20180112092728.GP2551@xz-mi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180112092728.GP2551@xz-mi>
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
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Andrea Arcangeli <aarcange@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>, Juan Quintela <quintela@redhat.com>, Alexey Perevalov <a.perevalov@samsung.com>

* Peter Xu (peterx@redhat.com) wrote:
> On Thu, Jan 11, 2018 at 04:59:32PM +0000, Dr. David Alan Gilbert wrote:
> > * Peter Xu (peterx@redhat.com) wrote:
> > > Tree is pushed here for better reference and testing (online tree
> > > includes monitor OOB series):
> > > 
> > >   https://github.com/xzpeter/qemu/tree/postcopy-recover-all
> > > 
> > > This version removed quite a few patches related to migrate-incoming,
> > > instead I introduced a new command "migrate-recover" to trigger the
> > > recovery channel on destination side to simplify the code.
> > 
> > I've got this setup on a couple of my test hosts, and I'm using
> > iptables to try breaking the connection.
> > 
> > See below for where I got stuck.
> > 
> > > To test this two series altogether, please checkout above tree and
> > > build.  Note: to test on small and single host, one need to disable
> > > full bandwidth postcopy migration otherwise it'll complete very fast.
> > > Basically a simple patch like this would help:
> > > 
> > > diff --git a/migration/migration.c b/migration/migration.c
> > > index 4de3b551fe..c0206023d7 100644
> > > --- a/migration/migration.c
> > > +++ b/migration/migration.c
> > > @@ -1904,7 +1904,7 @@ static int postcopy_start(MigrationState *ms, bool *old_vm_running)
> > >       * will notice we're in POSTCOPY_ACTIVE and not actually
> > >       * wrap their state up here
> > >       */
> > > -    qemu_file_set_rate_limit(ms->to_dst_file, INT64_MAX);
> > > +    // qemu_file_set_rate_limit(ms->to_dst_file, INT64_MAX);
> > >      if (migrate_postcopy_ram()) {
> > >          /* Ping just for debugging, helps line traces up */
> > >          qemu_savevm_send_ping(ms->to_dst_file, 2);
> > > 
> > > This patch is included already in above github tree.  Please feel free
> > > to drop this patch when want to test on big machines and between real
> > > hosts.
> > > 
> > > Detailed Test Procedures (QMP only)
> > > ===================================
> > > 
> > > 1. start source QEMU.
> > > 
> > > $qemu -M q35,kernel-irqchip=split -enable-kvm -snapshot \
> > >      -smp 4 -m 1G -qmp stdio \
> > >      -name peter-vm,debug-threads=on \
> > >      -netdev user,id=net0 \
> > >      -device e1000,netdev=net0 \
> > >      -global migration.x-max-bandwidth=4096 \
> > >      -global migration.x-postcopy-ram=on \
> > >      /images/fedora-25.qcow2
> > >
> > > 2. start destination QEMU.
> > > 
> > > $qemu -M q35,kernel-irqchip=split -enable-kvm -snapshot \
> > >      -smp 4 -m 1G -qmp stdio \
> > >      -name peter-vm,debug-threads=on \
> > >      -netdev user,id=net0 \
> > >      -device e1000,netdev=net0 \
> > >      -global migration.x-max-bandwidth=4096 \
> > >      -global migration.x-postcopy-ram=on \
> > >      -incoming tcp:0.0.0.0:5555 \
> > >      /images/fedora-25.qcow2
> > 
> > I'm using:
> > ./x86_64-softmmu/qemu-system-x86_64 -nographic -M pc,accel=kvm -smp 4 -m 16G -drive file=/home/vms/rhel71.qcow2,id=d,cache=none,if=none -device virtio-blk,drive=d -vnc 0:0 -incoming tcp:0:8888 -chardev socket,port=4000,host=0,id=mon,server,nowait,telnet -mon chardev=mon,id=mon,mode=control -nographic -chardev stdio,mux=on,id=monh -mon chardev=monh,mode=readline --device isa-serial,chardev=monh
> > and I've got both the HMP on the stdio, and the QMP via a telnet
> > 
> > > 
> > > 3. On source, do QMP handshake as normal:
> > > 
> > >   {"execute": "qmp_capabilities"}
> > >   {"return": {}}
> > > 
> > > 4. On destination, do QMP handshake to enable OOB:
> > > 
> > >   {"execute": "qmp_capabilities", "arguments": { "enable": [ "oob" ] } }
> > >   {"return": {}}
> > > 
> > > 5. On source, trigger initial migrate command, switch to postcopy:
> > > 
> > >   {"execute": "migrate", "arguments": { "uri": "tcp:localhost:5555" } }
> > >   {"return": {}}
> > >   {"execute": "query-migrate"}
> > >   {"return": {"expected-downtime": 300, "status": "active", ...}}
> > >   {"execute": "migrate-start-postcopy"}
> > >   {"return": {}}
> > >   {"timestamp": {"seconds": 1512454728, "microseconds": 768096}, "event": "STOP"}
> > >   {"execute": "query-migrate"}
> > >   {"return": {"expected-downtime": 44472, "status": "postcopy-active", ...}}
> > > 
> > > 6. On source, manually trigger a "fake network down" using
> > >    "migrate-cancel" command:
> > > 
> > >   {"execute": "migrate_cancel"}
> > >   {"return": {}}
> > 
> > Before I do that, I'm breaking the network connection by running on the
> > source:
> > iptables -A INPUT -p tcp --source-port 8888 -j DROP
> > iptables -A INPUT -p tcp --destination-port 8888 -j DROP
> 
> This is tricky... I think tcp keepalive may help, but for sure I
> think we do need a way to cancel the migration on both side.  Please
> see below comment.
> 
> > 
> > >   During postcopy, it'll not really cancel the migration, but pause
> > >   it.  On both sides, we should see this on stderr:
> > > 
> > >   qemu-system-x86_64: Detected IO failure for postcopy. Migration paused.
> > > 
> > >   It means now both sides are in postcopy-pause state.
> > 
> > Now, here we start to have a problem; I do the migrate-cancel on the
> > source, that works and goes into pause; but remember the network is
> > broken, so the destination hasn't received the news.
> > 
> > > 7. (Optional) On destination side, let's try to hang the main thread
> > >    using the new x-oob-test command, providing a "lock=true" param:
> > > 
> > >    {"execute": "x-oob-test", "id": "lock-dispatcher-cmd",
> > >     "arguments": { "lock": true } }
> > > 
> > >    After sending this command, we should not see any "return", because
> > >    main thread is blocked already.  But we can still use the monitor
> > >    since the monitor now has dedicated IOThread.
> > > 
> > > 8. On destination side, provide a new incoming port using the new
> > >    command "migrate-recover" (note that if step 7 is carried out, we
> > >    _must_ use OOB form, otherwise the command will hang.  With OOB,
> > >    this command will return immediately):
> > > 
> > >   {"execute": "migrate-recover", "id": "recover-cmd",
> > >    "arguments": { "uri": "tcp:localhost:5556" },
> > >    "control": { "run-oob": true } }
> > >   {"timestamp": {"seconds": 1512454976, "microseconds": 186053},
> > >    "event": "MIGRATION", "data": {"status": "setup"}}
> > >   {"return": {}, "id": "recover-cmd"}
> > > 
> > >    We can see that the command will success even if main thread is
> > >    locked up.
> > 
> > Because the destination didn't get the news of the pause, I get:
> > {"id": "recover-cmd", "error": {"class": "GenericError", "desc": "Migrate recover can only be run when postcopy is paused."}}
> 
> This is normal since we didn't fail on destination, while...
> 
> > 
> > and I can't explicitly cause a cancel on the destination:
> > {"id": "cancel-cmd", "error": {"class": "GenericError", "desc": "The command migrate_cancel does not support OOB"}}
> 
> ... this is not normal.  I have two questions:
> 
> 1. Have you provided
> 
>   "control": {"run-oob": true}
> 
>   field when sending command "migrate_cancel"?  Just to mention that
>   we shouldn't do it in oob way for migrate_cancel.  Or it can be a
>   monitor-oob bug.

Yes, I probably did and probably shouldn't have.

> 2. Do we need to support "migrate_cancel" on destination?
> 
> For (2), I think we need it, but for now it only works on source for
> sure.  So I think maybe I should add that support.
> 
> > 
> > So I think we need a way out of this on the destination.
> 
> So that's my 2nd question.  How about we do this: migrate_cancel will
> cancel incoming migration if:
> 
>         a. there is one incoming migration in progress, and
>         b. postcopy is enabled

Yes, I think that should work; but it should only 'cancel' in the same
way that it causes it to go to 'paused' mode.

One other problem I've hit is that it seems easy to 'upset' the OOB
monitor; for example if I do:

{"execute": "qmp_capabilities", "arguments": { "enable": [ "oob" ] } }
and repeat it:
{"execute": "qmp_capabilities", "arguments": { "enable": [ "oob" ] } }

it gives me an error, that's OK but then if I discounnect and reconnect the monitor a few
times it's really upset;  I've had it:
  a) Disconnect immediately when the telnet connects
  b) I've also had it not respond to any commands
  c) I've also seen a hang at system_powerdown where:

    the main thread is in:
        #0  0x00007f37aa4d3ef7 in pthread_join (threadid=139876803868416, thread_return=thread_return@entry=0x7ffc174367b0) at pthread_join.c:92
        #1  0x000055644e5c1f5f in qemu_thread_join (thread=<optimized out>) at /home/dgilbert/peter/qemu/util/qemu-thread-posix.c:547
        #2  0x000055644e30c688 in iothread_stop (iothread=<optimized out>) at /home/dgilbert/peter/qemu/iothread.c:91
        #3  0x000055644e21f122 in monitor_cleanup () at /home/dgilbert/peter/qemu/monitor.c:4517
        #4  0x000055644e1e1925 in main (argc=<optimized out>, argv=<optimized out>, envp=<optimized out>) at /home/dgilbert/peter/qemu/vl.c:4924

    and the monitor thread is in:
        #0  0x00007fdd93de871f in accept4 (fd=fd@entry=10, addr=..., addr@entry=..., addr_len=addr_len@entry=0x7fdd80004430, flags=flags@entry=524288)
            at ../sysdeps/unix/sysv/linux/accept4.c:37
        #1  0x000055645f42d9ec in qemu_accept (s=10, addr=addr@entry=0x7fdd800043b0, addrlen=addrlen@entry=0x7fdd80004430)
            at /home/dgilbert/peter/qemu/util/osdep.c:431
        #2  0x000055645f3ea7a1 in qio_channel_socket_accept (ioc=0x556460610f10, errp=errp@entry=0x0) at /home/dgilbert/peter/qemu/io/channel-socket.c:340
        #3  0x000055645f3db6aa in tcp_chr_accept (channel=0x556460610f10, cond=<optimized out>, opaque=<optimized out>)
            at /home/dgilbert/peter/qemu/chardev/char-socket.c:746
        #4  0x00007fdd94b2479a in g_main_context_dispatch () at /lib64/libglib-2.0.so.0
        #5  0x00007fdd94b24ae8 in g_main_context_iterate.isra.24 () at /lib64/libglib-2.0.so.0
        #6  0x00007fdd94b24dba in g_main_loop_run () at /lib64/libglib-2.0.so.0
        #7  0x000055645f17f516 in iothread_run (opaque=0x55646063e8c0) at /home/dgilbert/peter/qemu/iothread.c:69
        #8  0x00007fdd9c0fcdc5 in start_thread (arg=0x7fdd8cf79700) at pthread_create.c:308

Dave

> Thanks,
> 
> -- 
> Peter Xu
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
