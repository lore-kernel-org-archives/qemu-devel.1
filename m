Received: from eggs.gnu.org ([2001:4830:134:3::10]:38895)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1eZgCq-0007Wx-Fm
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 11:59:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1eZgCm-000355-FX
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 11:59:56 -0500
Received: from mx1.redhat.com ([209.132.183.28]:40028)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1eZgCm-00033v-54
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 11:59:52 -0500
Date: Thu, 11 Jan 2018 16:59:32 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20180111165930.GE2669@work-vm>
References: <20171205065307.21853-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171205065307.21853-1-peterx@redhat.com>
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
> Tree is pushed here for better reference and testing (online tree
> includes monitor OOB series):
> 
>   https://github.com/xzpeter/qemu/tree/postcopy-recover-all
> 
> This version removed quite a few patches related to migrate-incoming,
> instead I introduced a new command "migrate-recover" to trigger the
> recovery channel on destination side to simplify the code.

I've got this setup on a couple of my test hosts, and I'm using
iptables to try breaking the connection.

See below for where I got stuck.

> To test this two series altogether, please checkout above tree and
> build.  Note: to test on small and single host, one need to disable
> full bandwidth postcopy migration otherwise it'll complete very fast.
> Basically a simple patch like this would help:
> 
> diff --git a/migration/migration.c b/migration/migration.c
> index 4de3b551fe..c0206023d7 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -1904,7 +1904,7 @@ static int postcopy_start(MigrationState *ms, bool *old_vm_running)
>       * will notice we're in POSTCOPY_ACTIVE and not actually
>       * wrap their state up here
>       */
> -    qemu_file_set_rate_limit(ms->to_dst_file, INT64_MAX);
> +    // qemu_file_set_rate_limit(ms->to_dst_file, INT64_MAX);
>      if (migrate_postcopy_ram()) {
>          /* Ping just for debugging, helps line traces up */
>          qemu_savevm_send_ping(ms->to_dst_file, 2);
> 
> This patch is included already in above github tree.  Please feel free
> to drop this patch when want to test on big machines and between real
> hosts.
> 
> Detailed Test Procedures (QMP only)
> ===================================
> 
> 1. start source QEMU.
> 
> $qemu -M q35,kernel-irqchip=split -enable-kvm -snapshot \
>      -smp 4 -m 1G -qmp stdio \
>      -name peter-vm,debug-threads=on \
>      -netdev user,id=net0 \
>      -device e1000,netdev=net0 \
>      -global migration.x-max-bandwidth=4096 \
>      -global migration.x-postcopy-ram=on \
>      /images/fedora-25.qcow2
>
> 2. start destination QEMU.
> 
> $qemu -M q35,kernel-irqchip=split -enable-kvm -snapshot \
>      -smp 4 -m 1G -qmp stdio \
>      -name peter-vm,debug-threads=on \
>      -netdev user,id=net0 \
>      -device e1000,netdev=net0 \
>      -global migration.x-max-bandwidth=4096 \
>      -global migration.x-postcopy-ram=on \
>      -incoming tcp:0.0.0.0:5555 \
>      /images/fedora-25.qcow2

I'm using:
./x86_64-softmmu/qemu-system-x86_64 -nographic -M pc,accel=kvm -smp 4 -m 16G -drive file=/home/vms/rhel71.qcow2,id=d,cache=none,if=none -device virtio-blk,drive=d -vnc 0:0 -incoming tcp:0:8888 -chardev socket,port=4000,host=0,id=mon,server,nowait,telnet -mon chardev=mon,id=mon,mode=control -nographic -chardev stdio,mux=on,id=monh -mon chardev=monh,mode=readline --device isa-serial,chardev=monh
and I've got both the HMP on the stdio, and the QMP via a telnet

> 
> 3. On source, do QMP handshake as normal:
> 
>   {"execute": "qmp_capabilities"}
>   {"return": {}}
> 
> 4. On destination, do QMP handshake to enable OOB:
> 
>   {"execute": "qmp_capabilities", "arguments": { "enable": [ "oob" ] } }
>   {"return": {}}
> 
> 5. On source, trigger initial migrate command, switch to postcopy:
> 
>   {"execute": "migrate", "arguments": { "uri": "tcp:localhost:5555" } }
>   {"return": {}}
>   {"execute": "query-migrate"}
>   {"return": {"expected-downtime": 300, "status": "active", ...}}
>   {"execute": "migrate-start-postcopy"}
>   {"return": {}}
>   {"timestamp": {"seconds": 1512454728, "microseconds": 768096}, "event": "STOP"}
>   {"execute": "query-migrate"}
>   {"return": {"expected-downtime": 44472, "status": "postcopy-active", ...}}
> 
> 6. On source, manually trigger a "fake network down" using
>    "migrate-cancel" command:
> 
>   {"execute": "migrate_cancel"}
>   {"return": {}}

Before I do that, I'm breaking the network connection by running on the
source:
iptables -A INPUT -p tcp --source-port 8888 -j DROP
iptables -A INPUT -p tcp --destination-port 8888 -j DROP

>   During postcopy, it'll not really cancel the migration, but pause
>   it.  On both sides, we should see this on stderr:
> 
>   qemu-system-x86_64: Detected IO failure for postcopy. Migration paused.
> 
>   It means now both sides are in postcopy-pause state.

Now, here we start to have a problem; I do the migrate-cancel on the
source, that works and goes into pause; but remember the network is
broken, so the destination hasn't received the news.

> 7. (Optional) On destination side, let's try to hang the main thread
>    using the new x-oob-test command, providing a "lock=true" param:
> 
>    {"execute": "x-oob-test", "id": "lock-dispatcher-cmd",
>     "arguments": { "lock": true } }
> 
>    After sending this command, we should not see any "return", because
>    main thread is blocked already.  But we can still use the monitor
>    since the monitor now has dedicated IOThread.
> 
> 8. On destination side, provide a new incoming port using the new
>    command "migrate-recover" (note that if step 7 is carried out, we
>    _must_ use OOB form, otherwise the command will hang.  With OOB,
>    this command will return immediately):
> 
>   {"execute": "migrate-recover", "id": "recover-cmd",
>    "arguments": { "uri": "tcp:localhost:5556" },
>    "control": { "run-oob": true } }
>   {"timestamp": {"seconds": 1512454976, "microseconds": 186053},
>    "event": "MIGRATION", "data": {"status": "setup"}}
>   {"return": {}, "id": "recover-cmd"}
> 
>    We can see that the command will success even if main thread is
>    locked up.

Because the destination didn't get the news of the pause, I get:
{"id": "recover-cmd", "error": {"class": "GenericError", "desc": "Migrate recover can only be run when postcopy is paused."}}

and I can't explicitly cause a cancel on the destination:
{"id": "cancel-cmd", "error": {"class": "GenericError", "desc": "The command migrate_cancel does not support OOB"}}

So I think we need a way out of this on the destination.

Dave

> 9. (Optional) This step is only needed if step 7 is carried out. On
>    destination, let's unlock the main thread before resuming the
>    migration, this time with "lock=false" to unlock the main thread
>    (since system running needs the main thread). Note that we _must_
>    use OOB command here too:
> 
>   {"execute": "x-oob-test", "id": "unlock-dispatcher",
>    "arguments": { "lock": false }, "control": { "run-oob": true } }
>   {"return": {}, "id": "unlock-dispatcher"}
>   {"return": {}, "id": "lock-dispatcher-cmd"}
> 
>   Here the first "return" is the reply to the unlock command, the
>   second "return" is the reply to the lock command.  After this
>   command, main thread is released.
> 
> 10. On source, resume the postcopy migration:
> 
>   {"execute": "migrate", "arguments": { "uri": "tcp:localhost:5556", "resume": true }}
>   {"return": {}}
>   {"execute": "query-migrate"}
>   {"return": {"status": "completed", ...}}
> 
> Here's the change log:
> 
> v5:
> - add some more r-bs
> - fix error path in ram_load_postcopy to always check on "ret" [Dave]
> - move init/destroy of three new sems into migration object
>   init/finalize functions
> - dropped patch "migration: delay the postcopy-active state switch",
>   meanwhile touch up patch 6 to check against
>   POSTCOPY_INCOMING_RUNNING state when trying to switch to
>   postcopy-pause state. [Dave]
> - drop two patches that introduce qmp/hmp of migrate-pause, instead
>   re-use migrate-cancel to do manual trigger of postcopy recovery.
> - add a new patch to let migrate_cancel to pause migration if it's
>   already in postcopy phase.
> - add a new command "migrate-recover" to re-assign the incoming port,
>   instead of reusing migrate-incoming.
> - since now I used migrate-recover command instead of migrate-incoming
>   itself, I dropped quite a few patches that are not really relevant
>   now, so the series got smaller:
>         migration: return incoming task tag for sockets
>         migration: return incoming task tag for exec
>         migration: return incoming task tag for fd
>         migration: store listen task tag
>         migration: allow migrate_incoming for paused VM
> 
> v4:
> - fix two compile errors that patchew reported
> - for QMP: do s/2.11/2.12/g
> - fix migrate-incoming logic to be more strict
> 
> v3:
> - add r-bs correspondingly
> - in ram_load_postcopy() capture error if postcopy_place_page() failed
>   [Dave]
> - remove "break" if there is a "goto" before that [Dave]
> - ram_dirty_bitmap_reload(): use PRIx64 where needed, add some more
>   print sizes [Dave]
> - remove RAMState.ramblock_to_sync, instead use local counter [Dave]
> - init tag in tcp_start_incoming_migration() [Dave]
> - more traces when transmiting the recv bitmap [Dave]
> - postcopy_pause_incoming(): do shutdown before taking rp lock [Dave]
> - add one more patch to postpone the state switch of postcopy-active [Dave]
> - refactor the migrate_incoming handling according to the email
>   discussion [Dave]
> - add manual trigger to pause postcopy (two new patches added to
>   introduce "migrate-pause" command for QMP/HMP). [Dave]
> 
> v2:
> - rebased to alexey's received bitmap v9
> - add Dave's r-bs for patches: 2/5/6/8/9/13/14/15/16/20/21
> - patch 1: use target page size to calc bitmap [Dave]
> - patch 3: move trace_*() after EINTR check [Dave]
> - patch 4: dropped since I can use bitmap_complement() [Dave]
> - patch 7: check file error right after data is read in both
>   qemu_loadvm_section_start_full() and qemu_loadvm_section_part_end(),
>   meanwhile also check in check_section_footer() [Dave]
> - patch 8/9: fix error_report/commit message in both patches [Dave]
> - patch 10: dropped (new parameter "x-postcopy-fast")
> - patch 11: split the "postcopy-paused" patch into two, one to
>   introduce the new state, the other to implement the logic. Also,
>   print something when paused [Dave]
> - patch 17: removed do_resume label, introduced migration_prepare()
>   [Dave]
> - patch 18: removed do_pause label using a new loop [Dave]
> - patch 20: removed incorrect comment [Dave]
> - patch 21: use 256B buffer in qemu_savevm_send_recv_bitmap(), add
>   trace in loadvm_handle_recv_bitmap() [Dave]
> - patch 22: fix MIG_RP_MSG_RECV_BITMAP for (1) endianess (2) 32/64bit
>   machines. More info in the commit message update.
> - patch 23: add one check on migration state [Dave]
> - patch 24: use macro instead of magic 1 [Dave]
> - patch 26: use more trace_*() instead of one, and use one sem to
>   replace mutex+cond. [Dave]
> - move sem init/destroy into migration_instance_init() and
>   migration_instance_finalize (new function after rebase).
> - patch 29: squashed this patch most into:
>   "migration: implement "postcopy-pause" src logic" [Dave]
> - split the two fix patches out of the series
> - fixed two places where I misused "wake/woke/woken". [Dave]
> - add new patch "bitmap: provide to_le/from_le helpers" to solve the
>   bitmap endianess issue [Dave]
> - appended migrate_incoming series to this series, since that one is
>   depending on the paused state.  Using explicit g_source_remove() for
>   listening ports [Dan]
> 
> FUTURE TODO LIST
> - support migrate_cancel during PAUSED/RECOVER state
> - when anything wrong happens during PAUSED/RECOVER, switching back to
>   PAUSED state on both sides
> 
> As we all know that postcopy migration has a potential risk to lost
> the VM if the network is broken during the migration. This series
> tries to solve the problem by allowing the migration to pause at the
> failure point, and do recovery after the link is reconnected.
> 
> There was existing work on this issue from Md Haris Iqbal:
> 
> https://lists.nongnu.org/archive/html/qemu-devel/2016-08/msg03468.html
> 
> This series is a totally re-work of the issue, based on Alexey
> Perevalov's recved bitmap v8 series:
> 
> https://lists.gnu.org/archive/html/qemu-devel/2017-07/msg06401.html
> 
> Two new status are added to support the migration (used on both
> sides):
> 
>   MIGRATION_STATUS_POSTCOPY_PAUSED
>   MIGRATION_STATUS_POSTCOPY_RECOVER
> 
> The MIGRATION_STATUS_POSTCOPY_PAUSED state will be set when the
> network failure is detected. It is a phase that we'll be in for a long
> time as long as the failure is detected, and we'll be there until a
> recovery is triggered.  In this state, all the threads (on source:
> send thread, return-path thread; destination: ram-load thread,
> page-fault thread) will be halted.
> 
> The MIGRATION_STATUS_POSTCOPY_RECOVER state is short. If we triggered
> a recovery, both source/destination VM will jump into this stage, do
> whatever it needs to prepare the recovery (e.g., currently the most
> important thing is to synchronize the dirty bitmap, please see commit
> messages for more information). After the preparation is ready, the
> source will do the final handshake with destination, then both sides
> will switch back to MIGRATION_STATUS_POSTCOPY_ACTIVE again.
> 
> New commands/messages are defined as well to satisfy the need:
> 
> MIG_CMD_RECV_BITMAP & MIG_RP_MSG_RECV_BITMAP are introduced for
> delivering received bitmaps
> 
> MIG_CMD_RESUME & MIG_RP_MSG_RESUME_ACK are introduced to do the final
> handshake of postcopy recovery.
> 
> Here's some more details on how the whole failure/recovery routine is
> happened:
> 
> - start migration
> - ... (switch from precopy to postcopy)
> - both sides are in "postcopy-active" state
> - ... (failure happened, e.g., network unplugged)
> - both sides switch to "postcopy-paused" state
>   - all the migration threads are stopped on both sides
> - ... (both VMs hanged)
> - ... (user triggers recovery using "migrate -r -d tcp:HOST:PORT" on
>   source side, "-r" means "recover")
> - both sides switch to "postcopy-recover" state
>   - on source: send-thread, return-path-thread will be waked up
>   - on dest: ram-load-thread waked up, fault-thread still paused
> - source calls new savevmhandler hook resume_prepare() (currently,
>   only ram is providing the hook):
>   - ram_resume_prepare(): for each ramblock, fetch recved bitmap by:
>     - src sends MIG_CMD_RECV_BITMAP to dst
>     - dst replies MIG_RP_MSG_RECV_BITMAP to src, with bitmap data
>       - src uses the recved bitmap to rebuild dirty bitmap
> - source do final handshake with destination
>   - src sends MIG_CMD_RESUME to dst, telling "src is ready"
>     - when dst receives the command, fault thread will be waked up,
>       meanwhile, dst switch back to "postcopy-active"
>   - dst sends MIG_RP_MSG_RESUME_ACK to src, telling "dst is ready"
>     - when src receives the ack, state switch to "postcopy-active"
> - postcopy migration continued
> 
> Testing:
> 
> As I said, it's still an extremely simple test. I used socat to create
> a socket bridge:
> 
>   socat tcp-listen:6666 tcp-connect:localhost:5555 &
> 
> Then do the migration via the bridge. I emulated the network failure
> by killing the socat process (bridge down), then tries to recover the
> migration using the other channel (default dst channel). It looks
> like:
> 
>         port:6666    +------------------+
>         +----------> | socat bridge [1] |-------+
>         |            +------------------+       |
>         |         (Original channel)            |
>         |                                       | port: 5555
>      +---------+  (Recovery channel)            +--->+---------+
>      | src VM  |------------------------------------>| dst VM  |
>      +---------+                                     +---------+
> 
> Known issues/notes:
> 
> - currently destination listening port still cannot change. E.g., the
>   recovery should be using the same port on destination for
>   simplicity. (on source, we can specify new URL)
> 
> - the patch: "migration: let dst listen on port always" is still
>   hacky, it just kept the incoming accept open forever for now...
> 
> - some migration numbers might still be inaccurate, like total
>   migration time, etc. (But I don't really think that matters much
>   now)
> 
> - the patches are very lightly tested.
> 
> - Dave reported one problem that may hang destination main loop thread
>   (one vcpu thread holds the BQL) and the rest. I haven't encountered
>   it yet, but it does not mean this series can survive with it.
> 
> - other potential issues that I may have forgotten or unnoticed...
> 
> Anyway, the work is still in preliminary stage. Any suggestions and
> comments are greatly welcomed.  Thanks.
> 
> Peter Xu (28):
>   migration: better error handling with QEMUFile
>   migration: reuse mis->userfault_quit_fd
>   migration: provide postcopy_fault_thread_notify()
>   migration: new postcopy-pause state
>   migration: implement "postcopy-pause" src logic
>   migration: allow dst vm pause on postcopy
>   migration: allow src return path to pause
>   migration: allow send_rq to fail
>   migration: allow fault thread to pause
>   qmp: hmp: add migrate "resume" option
>   migration: pass MigrationState to migrate_init()
>   migration: rebuild channel on source
>   migration: new state "postcopy-recover"
>   migration: wakeup dst ram-load-thread for recover
>   migration: new cmd MIG_CMD_RECV_BITMAP
>   migration: new message MIG_RP_MSG_RECV_BITMAP
>   migration: new cmd MIG_CMD_POSTCOPY_RESUME
>   migration: new message MIG_RP_MSG_RESUME_ACK
>   migration: introduce SaveVMHandlers.resume_prepare
>   migration: synchronize dirty bitmap for resume
>   migration: setup ramstate for resume
>   migration: final handshake for the resume
>   migration: free SocketAddress where allocated
>   migration: init dst in migration_object_init too
>   io: let watcher of the channel run in same ctx
>   migration: allow migrate_cancel to pause postcopy
>   qmp/migration: new command migrate-recover
>   hmp/migration: add migrate_recover command
> 
>  hmp-commands.hx              |  28 ++-
>  hmp.c                        |  14 +-
>  hmp.h                        |   1 +
>  include/migration/register.h |   2 +
>  io/channel.c                 |   2 +-
>  migration/migration.c        | 549 ++++++++++++++++++++++++++++++++++++++-----
>  migration/migration.h        |  24 +-
>  migration/postcopy-ram.c     | 110 +++++++--
>  migration/postcopy-ram.h     |   2 +
>  migration/ram.c              | 247 ++++++++++++++++++-
>  migration/ram.h              |   3 +
>  migration/savevm.c           | 233 +++++++++++++++++-
>  migration/savevm.h           |   3 +
>  migration/socket.c           |   4 +-
>  migration/trace-events       |  21 ++
>  qapi/migration.json          |  35 ++-
>  16 files changed, 1172 insertions(+), 106 deletions(-)
> 
> -- 
> 2.14.3
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
