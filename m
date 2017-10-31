Received: from eggs.gnu.org ([2001:4830:134:3::10]:49887)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Pavel.Dovgaluk@ispras.ru>) id 1e9UfG-0002W4-2N
	for qemu-devel@nongnu.org; Tue, 31 Oct 2017 07:25:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Pavel.Dovgaluk@ispras.ru>) id 1e9UfC-0006Tk-Sa
	for qemu-devel@nongnu.org; Tue, 31 Oct 2017 07:25:02 -0400
Received: from mail.ispras.ru ([83.149.199.45]:44858)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Pavel.Dovgaluk@ispras.ru>) id 1e9UfC-0006SL-GZ
	for qemu-devel@nongnu.org; Tue, 31 Oct 2017 07:24:58 -0400
From: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>
Date: Tue, 31 Oct 2017 14:24:57 +0300
Message-ID: <20171031112457.10516.8971.stgit@pasha-VirtualBox>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [RFC PATCH 00/26] replay additions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: kwolf@redhat.com, peter.maydell@linaro.org, boost.lists@gmail.com, quintela@redhat.com, jasowang@redhat.com, mst@redhat.com, zuban32s@gmail.com, maria.klimushenkova@ispras.ru, dovgaluk@ispras.ru, kraxel@redhat.com, pavel.dovgaluk@ispras.ru, pbonzini@redhat.com, alex.bennee@linaro.org

Accidentally sent draft version of patches to the mailing list.
Please consider this one as the correct one.

This set of patches includex fixes from Alex Benn=C3=A9e for fixing
BQL and replay locks after inventing the MTTCG. It also includes some
additional replay patches that makes this set of fixes working.
It is also fixes some vmstate creation (and loading) issues
in record/replay modes:
 - VM start/stop fixes in replay mode
 - overlay creation for blkreplay filter
 - fixes for vmstate save/load in record/replay mode
 - fixes for host clock vmstate
 - fixes for icount timers vmstate

There is also a set of helper scripts written by Alex Benn=C3=A9e
for debugging the record/replay code.

---

Alex Benn=C3=A9e (12):
      target/arm/arm-powertctl: drop BQL assertions
      cpus: push BQL lock to qemu_*_wait_io_event
      cpus: only take BQL for sleeping threads
      replay/replay.c: bump REPLAY_VERSION again
      replay/replay-internal.c: track holding of replay_lock
      replay: make locking visible outside replay code
      replay: push replay_mutex_lock up the call tree
      scripts/qemu-gdb: add simple tcg lock status helper
      util/qemu-thread-*: add qemu_lock, locked and unlock trace events
      scripts/analyse-locks-simpletrace.py: script to analyse lock times
      scripts/replay-dump.py: replay log dumper
      scripts/qemu-gdb/timers.py: new helper to dump timer state

Pavel Dovgalyuk (14):
      block: implement bdrv_snapshot_goto for blkreplay
      blkreplay: create temporary overlay for underlaying devices
      replay: disable default snapshot for record/replay
      replay: fix processing async events
      replay: fixed replay_enable_events
      replay: fix save/load vm for non-empty queue
      replay: added replay log format description
      replay: make safe vmstop at record/replay
      replay: save prior value of the host clock
      icount: fixed saving/restoring of icount warp timers
      cpu-exec: don't overwrite exception_index
      cpu-exec: reset exit flag before calling cpu_exec_nocache
      replay: don't destroy mutex at exit
      replay: check return values of fwrite


 accel/kvm/kvm-all.c                  |    4=20
 accel/tcg/cpu-exec.c                 |    5 -
 block/blkreplay.c                    |   73 ++++++++
 cpus-common.c                        |   13 +
 cpus.c                               |  149 +++++++++++++---
 docs/replay.txt                      |   88 ++++++++++
 include/qemu/thread.h                |   14 +-
 include/qemu/timer.h                 |   14 ++
 include/sysemu/replay.h              |   19 ++
 migration/savevm.c                   |   13 +
 replay/replay-char.c                 |   21 +-
 replay/replay-events.c               |   30 +--
 replay/replay-internal.c             |   26 +++
 replay/replay-internal.h             |    9 +
 replay/replay-snapshot.c             |    9 +
 replay/replay-time.c                 |   10 +
 replay/replay.c                      |   43 ++---
 scripts/analyse-locks-simpletrace.py |   99 +++++++++++
 scripts/qemu-gdb.py                  |    4=20
 scripts/qemugdb/tcg.py               |   46 +++++
 scripts/qemugdb/timers.py            |   54 ++++++
 scripts/replay-dump.py               |  308 ++++++++++++++++++++++++++++=
++++++
 stubs/replay.c                       |   16 ++
 target/arm/arm-powerctl.c            |    8 -
 target/i386/hax-all.c                |    3=20
 util/main-loop.c                     |   23 ++-
 util/qemu-thread-posix.c             |   21 +-
 util/qemu-timer.c                    |   12 +
 util/trace-events                    |    7 -
 vl.c                                 |   12 +
 30 files changed, 1014 insertions(+), 139 deletions(-)
 create mode 100755 scripts/analyse-locks-simpletrace.py
 create mode 100644 scripts/qemugdb/tcg.py
 create mode 100644 scripts/qemugdb/timers.py
 create mode 100755 scripts/replay-dump.py

--=20
Pavel Dovgalyuk
