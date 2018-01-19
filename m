Received: from eggs.gnu.org ([2001:4830:134:3::10]:53525)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Pavel.Dovgaluk@ispras.ru>) id 1ecSFy-0008Ug-02
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 03:42:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Pavel.Dovgaluk@ispras.ru>) id 1ecSFu-000477-T6
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 03:42:38 -0500
Received: from mail.ispras.ru ([83.149.199.45]:53364)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Pavel.Dovgaluk@ispras.ru>) id 1ecSFu-00045K-GU
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 03:42:34 -0500
From: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>
Date: Fri, 19 Jan 2018 11:42:36 +0300
Message-ID: <20180119084235.7100.98318.stgit@pasha-VirtualBox>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [RFC PATCH v4 00/23] replay additions
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

There is also a set of helper scripts written by Alex Benn=C3=A9e
for debugging the record/replay code.

v4 changes:
 - removed upstreamed patches
 - added patch for saving async queue state in replay
 - minor fixes

v3 changes:
 - removed upstreamed patches
 - fixed bug with recursive checkpoints
 - fixed bug with icount warp checkpoint

v2 changes:
 - updated lock/unlock logic (as suggested by Paolo Bonzini)
 - updated cpu execution loop to avoid races in setting/resetting exit re=
quest (as suggested by Paolo Bonzini)
 - minor changes

---

Alex Benn=C3=A9e (8):
      target/arm/arm-powertctl: drop BQL assertions
      cpus: push BQL lock to qemu_*_wait_io_event
      cpus: only take BQL for sleeping threads
      replay/replay.c: bump REPLAY_VERSION again
      replay/replay-internal.c: track holding of replay_lock
      replay: make locking visible outside replay code
      replay: push replay_mutex_lock up the call tree
      scripts/replay-dump.py: replay log dumper

Pavel Dovgalyuk (15):
      This patch adds a condition before overwriting exception_index fiel=
ds.
      block: implement bdrv_snapshot_goto for blkreplay
      blkreplay: create temporary overlay for underlaying devices
      replay: disable default snapshot for record/replay
      replay: fix processing async events
      replay: fixed replay_enable_events
      replay: fix save/load vm for non-empty queue
      replay: added replay log format description
      replay: make safe vmstop at record/replay
      replay: save prior value of the host clock
      replay: don't destroy mutex at exit
      replay: check return values of fwrite
      replay: avoid recursive call of checkpoints
      replay: don't process async events when warping the clock
      replay: save vmstate of the asynchronous events


 accel/kvm/kvm-all.c       |    4 -
 accel/tcg/cpu-exec.c      |    5 +
 block/blkreplay.c         |   73 +++++++++++
 cpus-common.c             |   13 +-
 cpus.c                    |   46 +++++--
 docs/replay.txt           |   91 +++++++++++++
 dtc                       |    2=20
 include/qemu/timer.h      |   14 ++
 include/sysemu/replay.h   |   19 +++
 migration/savevm.c        |   13 ++
 replay/replay-char.c      |   21 +--
 replay/replay-events.c    |   73 +++++------
 replay/replay-internal.c  |   48 ++++++-
 replay/replay-internal.h  |   15 ++
 replay/replay-snapshot.c  |   12 ++
 replay/replay-time.c      |   10 +
 replay/replay.c           |   62 ++++++---
 scripts/replay-dump.py    |  308 +++++++++++++++++++++++++++++++++++++++=
++++++
 stubs/replay.c            |   16 ++
 target/arm/arm-powerctl.c |    8 -
 target/i386/hax-all.c     |    2=20
 util/main-loop.c          |   17 ++
 util/qemu-timer.c         |   12 ++
 vl.c                      |   12 +-
 24 files changed, 764 insertions(+), 132 deletions(-)
 create mode 100755 scripts/replay-dump.py

--=20
Pavel Dovgalyuk
