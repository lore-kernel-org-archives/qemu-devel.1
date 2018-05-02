Received: from eggs.gnu.org ([2001:4830:134:3::10]:34687)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fDpIk-0006D9-QN
	for qemu-devel@nongnu.org; Wed, 02 May 2018 06:48:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fDpIh-0002gf-Mo
	for qemu-devel@nongnu.org; Wed, 02 May 2018 06:47:58 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:42470 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1fDpIh-0002gC-DA
	for qemu-devel@nongnu.org; Wed, 02 May 2018 06:47:55 -0400
From: Peter Xu <peterx@redhat.com>
Date: Wed,  2 May 2018 18:47:16 +0800
Message-Id: <20180502104740.12123-1-peterx@redhat.com>
Subject: [Qemu-devel] [PATCH v8 00/24] Migration: postcopy failure recovery
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

  https://github.com/xzpeter/qemu/tree/postcopy-recovery-support

Note that now OOB is still off by default; we need this extra line
applied to the old test scripts to allow OOB to work (instead of "-qmp
stdio"):

  -chardev stdio,id=char0 -mon chardev=char0,mode=control,x-oob=on

After Dave's postcopy shared memory work, we'll need extra work to
allow the postcopy recovery series to work with shared memories (e.g.,
DPDK).  That will be a TODO item as a follow-up work of this series.

Please review.  Thanks.

v8:
- rebase to master
- fix trace_ram_state_resume_prepare() to take uint64_t [Dave]
- add a patch to introduce mgmt_lock, then take it in migrate-pause
  command to protect the QEMUFile [Dave]

Detailed Test Procedures (QMP only)
===================================

1. start source QEMU.

$qemu -M q35,kernel-irqchip=split -enable-kvm -snapshot \
     -smp 4 -m 1G \
     -chardev stdio,id=char0 -mon chardev=char0,mode=control,x-oob=on \
     -name peter-vm,debug-threads=on \
     -netdev user,id=net0 \
     -device e1000,netdev=net0 \
     -global migration.x-max-bandwidth=4096 \
     -global migration.x-postcopy-ram=on \
     /images/fedora-25.qcow2

2. start destination QEMU.

$qemu -M q35,kernel-irqchip=split -enable-kvm -snapshot \
     -smp 4 -m 1G \
     -chardev stdio,id=char0 -mon chardev=char0,mode=control,x-oob=on \
     -name peter-vm,debug-threads=on \
     -netdev user,id=net0 \
     -device e1000,netdev=net0 \
     -global migration.x-max-bandwidth=4096 \
     -global migration.x-postcopy-ram=on \
     -incoming tcp:0.0.0.0:5555 \
     /images/fedora-25.qcow2

3. On source, do QMP handshake as normal:

  {"execute": "qmp_capabilities"}
  {"return": {}}

4. On destination, do QMP handshake to enable OOB:

  {"execute": "qmp_capabilities", "arguments": { "enable": [ "oob" ] } }
  {"return": {}}

5. On source, trigger initial migrate command, switch to postcopy:

  {"execute": "migrate", "arguments": { "uri": "tcp:localhost:5555" } }
  {"return": {}}
  {"execute": "query-migrate"}
  {"return": {"expected-downtime": 300, "status": "active", ...}}
  {"execute": "migrate-start-postcopy"}
  {"return": {}}
  {"timestamp": {"seconds": 1512454728, "microseconds": 768096}, "event": "STOP"}
  {"execute": "query-migrate"}
  {"return": {"expected-downtime": 44472, "status": "postcopy-active", ...}}

6. On source, manually trigger a "fake network down" using
   "migrate-cancel" command:

  {"execute": "migrate_cancel"}
  {"return": {}}

  During postcopy, it'll not really cancel the migration, but pause
  it.  On both sides, we should see this on stderr:

  qemu-system-x86_64: Detected IO failure for postcopy. Migration paused.

  It means now both sides are in postcopy-pause state.

7. (Optional) On destination side, let's try to hang the main thread
   using the new x-oob-test command, providing a "lock=true" param:

   {"execute": "x-oob-test", "id": "lock-dispatcher-cmd",
    "arguments": { "lock": true } }

   After sending this command, we should not see any "return", because
   main thread is blocked already.  But we can still use the monitor
   since the monitor now has dedicated IOThread.

8. On destination side, provide a new incoming port using the new
   command "migrate-recover" (note that if step 7 is carried out, we
   _must_ use OOB form, otherwise the command will hang.  With OOB,
   this command will return immediately):

  {"execute": "migrate-recover", "id": "recover-cmd",
   "arguments": { "uri": "tcp:localhost:5556" },
   "control": { "run-oob": true } }
  {"timestamp": {"seconds": 1512454976, "microseconds": 186053},
   "event": "MIGRATION", "data": {"status": "setup"}}
  {"return": {}, "id": "recover-cmd"}

   We can see that the command will success even if main thread is
   locked up.

9. (Optional) This step is only needed if step 7 is carried out. On
   destination, let's unlock the main thread before resuming the
   migration, this time with "lock=false" to unlock the main thread
   (since system running needs the main thread). Note that we _must_
   use OOB command here too:

  {"execute": "x-oob-test", "id": "unlock-dispatcher",
   "arguments": { "lock": false }, "control": { "run-oob": true } }
  {"return": {}, "id": "unlock-dispatcher"}
  {"return": {}, "id": "lock-dispatcher-cmd"}

  Here the first "return" is the reply to the unlock command, the
  second "return" is the reply to the lock command.  After this
  command, main thread is released.

10. On source, resume the postcopy migration:

  {"execute": "migrate", "arguments": { "uri": "tcp:localhost:5556", "resume": true }}
  {"return": {}}
  {"execute": "query-migrate"}
  {"return": {"status": "completed", ...}}

==================

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

Peter Xu (24):
  migration: let incoming side use thread context
  migration: new postcopy-pause state
  migration: implement "postcopy-pause" src logic
  migration: allow dst vm pause on postcopy
  migration: allow src return path to pause
  migration: allow fault thread to pause
  qmp: hmp: add migrate "resume" option
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
  migration: init dst in migration_object_init too
  qmp/migration: new command migrate-recover
  hmp/migration: add migrate_recover command
  migration: introduce lock for to_dst_file
  migration/qmp: add command migrate-pause
  migration/hmp: add migrate_pause command

 qapi/migration.json          |  48 +++-
 hmp.h                        |   2 +
 include/migration/register.h |   2 +
 migration/migration.h        |  21 ++
 migration/ram.h              |   3 +
 migration/savevm.h           |   3 +
 hmp.c                        |  23 +-
 migration/channel.c          |   3 +-
 migration/exec.c             |   9 +-
 migration/fd.c               |   9 +-
 migration/migration.c        | 546 +++++++++++++++++++++++++++++++++++++++----
 migration/postcopy-ram.c     |  54 ++++-
 migration/ram.c              | 234 +++++++++++++++++++
 migration/savevm.c           | 191 ++++++++++++++-
 migration/socket.c           |   7 +-
 hmp-commands.hx              |  34 ++-
 migration/trace-events       |  21 ++
 17 files changed, 1136 insertions(+), 74 deletions(-)

-- 
2.14.3
