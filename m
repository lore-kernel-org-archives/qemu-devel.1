Received: from eggs.gnu.org ([2001:4830:134:3::10]:49869)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Pavel.Dovgaluk@ispras.ru>) id 1ejOSF-0008DQ-4G
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 07:04:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Pavel.Dovgaluk@ispras.ru>) id 1ejOSA-0003SA-3U
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 07:03:59 -0500
Received: from mail.ispras.ru ([83.149.199.45]:47248)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Pavel.Dovgaluk@ispras.ru>) id 1ejOS9-0003Og-N4
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 07:03:54 -0500
From: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>
Date: Wed, 07 Feb 2018 15:03:53 +0300
Message-ID: <20180207120353.5389.54531.stgit@pasha-VirtualBox>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [RFC PATCH v6 00/20] replay additions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: kwolf@redhat.com, peter.maydell@linaro.org, war2jordan@live.com, boost.lists@gmail.com, quintela@redhat.com, ciro.santilli@gmail.com, jasowang@redhat.com, mst@redhat.com, zuban32s@gmail.com, maria.klimushenkova@ispras.ru, dovgaluk@ispras.ru, kraxel@redhat.com, pavel.dovgaluk@ispras.ru, thomas.dullien@googlemail.com, pbonzini@redhat.com, alex.bennee@linaro.org

This set of patches moves replay lock upper in the function call tree.
Now replay lock functions similar to BQL in older version and allows
deterministic execution of the threads in icount mode.
It is also fixes some vmstate creation (and loading) issues
in record/replay modes:
 - VM start/stop fixes in replay mode
 - overlay creation for blkreplay filter
 - fixes for vmstate save/load in record/replay mode
 - fixes for host clock vmstate

There is also a set of helper scripts written by Alex Benn=C3=A9e
for debugging the record/replay code.

v6 changes:
 - removed BQL optimization at all
 - refined replay lock patches
 - removed lock/unlock from replay-audio

v5 changes:
 - removed patch for narrowing BQL-protected code
 - disabled bdrv_(drain/flush)_all for record/replay mode

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

Alex Benn=C3=A9e (5):
      replay/replay.c: bump REPLAY_VERSION again
      replay/replay-internal.c: track holding of replay_lock
      replay: make locking visible outside replay code
      replay: push replay_mutex_lock up the call tree
      scripts/replay-dump.py: replay log dumper

Pavel Dovgalyuk (15):
      cpu-exec: fix exception_index handling
      block: implement bdrv_snapshot_goto for blkreplay
      blkreplay: create temporary overlay for underlaying devices
      replay: disable default snapshot for record/replay
      replay: fix processing async events
      replay: fixed replay_enable_events
      replay: fix save/load vm for non-empty queue
      replay: added replay log format description
      replay: save prior value of the host clock
      replay: don't destroy mutex at exit
      replay: check return values of fwrite
      replay: avoid recursive call of checkpoints
      replay: don't process async events when warping the clock
      replay: save vmstate of the asynchronous events
      replay: don't drain/flush bdrv queue while RR is working


 accel/tcg/cpu-exec.c     |    5 +
 block/blkreplay.c        |   73 +++++++++++
 block/io.c               |   22 +++
 cpus.c                   |   26 +++-
 docs/replay.txt          |   91 ++++++++++++++
 include/qemu/timer.h     |   14 ++
 include/sysemu/replay.h  |   19 +++
 migration/savevm.c       |   13 ++
 replay/replay-audio.c    |   14 +-
 replay/replay-char.c     |   21 +--
 replay/replay-events.c   |   75 +++++------
 replay/replay-internal.c |   47 ++++++-
 replay/replay-internal.h |   15 ++
 replay/replay-snapshot.c |   12 ++
 replay/replay-time.c     |   10 +
 replay/replay.c          |   62 ++++++---
 scripts/replay-dump.py   |  308 ++++++++++++++++++++++++++++++++++++++++=
++++++
 stubs/replay.c           |   16 ++
 util/main-loop.c         |   15 ++
 util/qemu-timer.c        |   12 ++
 vl.c                     |   12 +-
 21 files changed, 769 insertions(+), 113 deletions(-)
 create mode 100755 scripts/replay-dump.py

--=20
Pavel Dovgalyuk
