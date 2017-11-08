Received: from eggs.gnu.org ([2001:4830:134:3::10]:35737)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1eCJQz-0007xj-Uk
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 01:01:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1eCJQv-0006S6-VY
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 01:01:58 -0500
Received: from mx1.redhat.com ([209.132.183.28]:46238)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1eCJQv-0006NJ-NY
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 01:01:53 -0500
From: Peter Xu <peterx@redhat.com>
Date: Wed,  8 Nov 2017 14:00:58 +0800
Message-Id: <20171108060130.3772-1-peterx@redhat.com>
Subject: [Qemu-devel] [PATCH v4 00/32] Migration: postcopy failure recovery
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Alexey Perevalov <a.perevalov@samsung.com>, "Daniel P . Berrange" <berrange@redhat.com>, Juan Quintela <quintela@redhat.com>, Andrea Arcangeli <aarcange@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, peterx@redhat.com

Tree is pushed here for better reference and testing:
  github.com/xzpeter postcopy-recovery-support

Please review, thanks.

v4:
- fix two compile errors that patchew reported
- for QMP: do s/2.11/2.12/g
- fix migrate-incoming logic to be more strict

v3:
- add r-bs correspondingly
- in ram_load_postcopy() capture error if postcopy_place_page() failed
  [Dave]
- remove "break" if there is a "goto" before that [Dave]
- ram_dirty_bitmap_reload(): use PRIx64 where needed, add some more
  print sizes [Dave]
- remove RAMState.ramblock_to_sync, instead use local counter [Dave]
- init tag in tcp_start_incoming_migration() [Dave]
- more traces when transmiting the recv bitmap [Dave]
- postcopy_pause_incoming(): do shutdown before taking rp lock [Dave]
- add one more patch to postpone the state switch of postcopy-active [Dave]
- refactor the migrate_incoming handling according to the email
  discussion [Dave]
- add manual trigger to pause postcopy (two new patches added to
  introduce "migrate-pause" command for QMP/HMP). [Dave]

v2 note (the coarse-grained changelog):

- I appended the migrate-incoming re-use series into this one, since
  that one depends on this one, and it's really for the recovery

- I haven't yet added (actually I just added them but removed) the
  per-monitor thread related patches into this one, basically to setup
  "need-bql"="false" patches - the solution for the monitor hang issue
  is still during discussion in the other thread.  I'll add them in
  when settled.

- Quite a lot of other changes and additions regarding to v1 review
  comments.  I think I settled all the comments, but the God knows
  better.

Feel free to skip this ugly longer changelog (it's too long to be
meaningful I'm afraid).

Tree: github.com/xzpeter postcopy-recovery-support

v2:
- rebased to alexey's received bitmap v9
- add Dave's r-bs for patches: 2/5/6/8/9/13/14/15/16/20/21
- patch 1: use target page size to calc bitmap [Dave]
- patch 3: move trace_*() after EINTR check [Dave]
- patch 4: dropped since I can use bitmap_complement() [Dave]
- patch 7: check file error right after data is read in both
  qemu_loadvm_section_start_full() and qemu_loadvm_section_part_end(),
  meanwhile also check in check_section_footer() [Dave]
- patch 8/9: fix error_report/commit message in both patches [Dave]
- patch 10: dropped (new parameter "x-postcopy-fast")
- patch 11: split the "postcopy-paused" patch into two, one to
  introduce the new state, the other to implement the logic. Also,
  print something when paused [Dave]
- patch 17: removed do_resume label, introduced migration_prepare()
  [Dave]
- patch 18: removed do_pause label using a new loop [Dave]
- patch 20: removed incorrect comment [Dave]
- patch 21: use 256B buffer in qemu_savevm_send_recv_bitmap(), add
  trace in loadvm_handle_recv_bitmap() [Dave]
- patch 22: fix MIG_RP_MSG_RECV_BITMAP for (1) endianess (2) 32/64bit
  machines. More info in the commit message update.
- patch 23: add one check on migration state [Dave]
- patch 24: use macro instead of magic 1 [Dave]
- patch 26: use more trace_*() instead of one, and use one sem to
  replace mutex+cond. [Dave]
- move sem init/destroy into migration_instance_init() and
  migration_instance_finalize (new function after rebase).
- patch 29: squashed this patch most into:
  "migration: implement "postcopy-pause" src logic" [Dave]
- split the two fix patches out of the series
- fixed two places where I misused "wake/woke/woken". [Dave]
- add new patch "bitmap: provide to_le/from_le helpers" to solve the
  bitmap endianess issue [Dave]
- appended migrate_incoming series to this series, since that one is
  depending on the paused state.  Using explicit g_source_remove() for
  listening ports [Dan]

FUTURE TODO LIST
- support migrate_cancel during PAUSED/RECOVER state
- when anything wrong happens during PAUSED/RECOVER, switching back to
  PAUSED state on both sides

As we all know that postcopy migration has a potential risk to lost
the VM if the network is broken during the migration. This series
tries to solve the problem by allowing the migration to pause at the
failure point, and do recovery after the link is reconnected.

There was existing work on this issue from Md Haris Iqbal:

https://lists.nongnu.org/archive/html/qemu-devel/2016-08/msg03468.html

This series is a totally re-work of the issue, based on Alexey
Perevalov's recved bitmap v8 series:

https://lists.gnu.org/archive/html/qemu-devel/2017-07/msg06401.html

Two new status are added to support the migration (used on both
sides):

  MIGRATION_STATUS_POSTCOPY_PAUSED
  MIGRATION_STATUS_POSTCOPY_RECOVER

The MIGRATION_STATUS_POSTCOPY_PAUSED state will be set when the
network failure is detected. It is a phase that we'll be in for a long
time as long as the failure is detected, and we'll be there until a
recovery is triggered.  In this state, all the threads (on source:
send thread, return-path thread; destination: ram-load thread,
page-fault thread) will be halted.

The MIGRATION_STATUS_POSTCOPY_RECOVER state is short. If we triggered
a recovery, both source/destination VM will jump into this stage, do
whatever it needs to prepare the recovery (e.g., currently the most
important thing is to synchronize the dirty bitmap, please see commit
messages for more information). After the preparation is ready, the
source will do the final handshake with destination, then both sides
will switch back to MIGRATION_STATUS_POSTCOPY_ACTIVE again.

New commands/messages are defined as well to satisfy the need:

MIG_CMD_RECV_BITMAP & MIG_RP_MSG_RECV_BITMAP are introduced for
delivering received bitmaps

MIG_CMD_RESUME & MIG_RP_MSG_RESUME_ACK are introduced to do the final
handshake of postcopy recovery.

Here's some more details on how the whole failure/recovery routine is
happened:

- start migration
- ... (switch from precopy to postcopy)
- both sides are in "postcopy-active" state
- ... (failure happened, e.g., network unplugged)
- both sides switch to "postcopy-paused" state
  - all the migration threads are stopped on both sides
- ... (both VMs hanged)
- ... (user triggers recovery using "migrate -r -d tcp:HOST:PORT" on
  source side, "-r" means "recover")
- both sides switch to "postcopy-recover" state
  - on source: send-thread, return-path-thread will be waked up
  - on dest: ram-load-thread waked up, fault-thread still paused
- source calls new savevmhandler hook resume_prepare() (currently,
  only ram is providing the hook):
  - ram_resume_prepare(): for each ramblock, fetch recved bitmap by:
    - src sends MIG_CMD_RECV_BITMAP to dst
    - dst replies MIG_RP_MSG_RECV_BITMAP to src, with bitmap data
      - src uses the recved bitmap to rebuild dirty bitmap
- source do final handshake with destination
  - src sends MIG_CMD_RESUME to dst, telling "src is ready"
    - when dst receives the command, fault thread will be waked up,
      meanwhile, dst switch back to "postcopy-active"
  - dst sends MIG_RP_MSG_RESUME_ACK to src, telling "dst is ready"
    - when src receives the ack, state switch to "postcopy-active"
- postcopy migration continued

Testing:

As I said, it's still an extremely simple test. I used socat to create
a socket bridge:

  socat tcp-listen:6666 tcp-connect:localhost:5555 &

Then do the migration via the bridge. I emulated the network failure
by killing the socat process (bridge down), then tries to recover the
migration using the other channel (default dst channel). It looks
like:

        port:6666    +------------------+
        +----------> | socat bridge [1] |-------+
        |            +------------------+       |
        |         (Original channel)            |
        |                                       | port: 5555
     +---------+  (Recovery channel)            +--->+---------+
     | src VM  |------------------------------------>| dst VM  |
     +---------+                                     +---------+

Known issues/notes:

- currently destination listening port still cannot change. E.g., the
  recovery should be using the same port on destination for
  simplicity. (on source, we can specify new URL)

- the patch: "migration: let dst listen on port always" is still
  hacky, it just kept the incoming accept open forever for now...

- some migration numbers might still be inaccurate, like total
  migration time, etc. (But I don't really think that matters much
  now)

- the patches are very lightly tested.

- Dave reported one problem that may hang destination main loop thread
  (one vcpu thread holds the BQL) and the rest. I haven't encountered
  it yet, but it does not mean this series can survive with it.

- other potential issues that I may have forgotten or unnoticed...

Anyway, the work is still in preliminary stage. Any suggestions and
comments are greatly welcomed.  Thanks.

Peter Xu (32):
  migration: better error handling with QEMUFile
  migration: reuse mis->userfault_quit_fd
  migration: provide postcopy_fault_thread_notify()
  migration: new postcopy-pause state
  migration: implement "postcopy-pause" src logic
  migration: allow dst vm pause on postcopy
  migration: allow src return path to pause
  migration: allow send_rq to fail
  migration: allow fault thread to pause
  qmp: hmp: add migrate "resume" option
  migration: pass MigrationState to migrate_init()
  migration: rebuild channel on source
  migration: new state "postcopy-recover"
  migration: wakeup dst ram-load-thread for recover
  migration: new cmd MIG_CMD_RECV_BITMAP
  migration: new message MIG_RP_MSG_RECV_BITMAP
  migration: new cmd MIG_CMD_POSTCOPY_RESUME
  migration: new message MIG_RP_MSG_RESUME_ACK
  migration: introduce SaveVMHandlers.resume_prepare
  migration: synchronize dirty bitmap for resume
  migration: setup ramstate for resume
  migration: final handshake for the resume
  migration: free SocketAddress where allocated
  migration: return incoming task tag for sockets
  migration: return incoming task tag for exec
  migration: return incoming task tag for fd
  migration: store listen task tag
  migration: allow migrate_incoming for paused VM
  migration: init dst in migration_object_init too
  migration: delay the postcopy-active state switch
  migration, qmp: new command "migrate-pause"
  migration, hmp: new command "migrate_pause"

 hmp-commands.hx              |  21 +-
 hmp.c                        |  13 +-
 hmp.h                        |   1 +
 include/migration/register.h |   2 +
 migration/exec.c             |  20 +-
 migration/exec.h             |   2 +-
 migration/fd.c               |  20 +-
 migration/fd.h               |   2 +-
 migration/migration.c        | 609 ++++++++++++++++++++++++++++++++++++++-----
 migration/migration.h        |  26 +-
 migration/postcopy-ram.c     | 110 ++++++--
 migration/postcopy-ram.h     |   2 +
 migration/ram.c              | 252 +++++++++++++++++-
 migration/ram.h              |   3 +
 migration/savevm.c           | 240 ++++++++++++++++-
 migration/savevm.h           |   3 +
 migration/socket.c           |  44 ++--
 migration/socket.h           |   4 +-
 migration/trace-events       |  23 ++
 qapi/migration.json          |  34 ++-
 20 files changed, 1283 insertions(+), 148 deletions(-)

-- 
2.13.6
