Received: from eggs.gnu.org ([2001:4830:134:3::10]:57291)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Pavel.Dovgaluk@ispras.ru>) id 1e9U5H-0005TG-Aq
	for qemu-devel@nongnu.org; Tue, 31 Oct 2017 06:47:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Pavel.Dovgaluk@ispras.ru>) id 1e9U5B-0003P1-Cw
	for qemu-devel@nongnu.org; Tue, 31 Oct 2017 06:47:51 -0400
Received: from mail.ispras.ru ([83.149.199.45]:39768)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Pavel.Dovgaluk@ispras.ru>) id 1e9U5B-0003KE-5W
	for qemu-devel@nongnu.org; Tue, 31 Oct 2017 06:47:45 -0400
From: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>
Date: Tue, 31 Oct 2017 13:47:41 +0300
Message-ID: <20171031104741.3079.26584.stgit@pasha-VirtualBox>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [RFCPATCH00/20] replay additions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: dovgaluk@ispras.ru

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

---

Alex Benn=C3=A9e (7):
      target/arm/arm-powertctl: drop BQL assertions
      cpus: push BQL lock to qemu_*_wait_io_event
      cpus: only take BQL for sleeping threads
      replay/replay.c: bump REPLAY_VERSION again
      replay/replay-internal.c: track holding of replay_lock
      replay: make locking visible outside replay code
      replay: push replay_mutex_lock up the call tree

Pavel Dovgalyuk (13):
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


 accel/kvm/kvm-all.c       |    4 -
 accel/tcg/cpu-exec.c      |    5 +-
 block/blkreplay.c         |   73 ++++++++++++++++++++++
 cpus-common.c             |   13 ++--
 cpus.c                    |  149 ++++++++++++++++++++++++++++++++++++---=
------
 docs/replay.txt           |   88 +++++++++++++++++++++++++++
 include/qemu/timer.h      |   14 ++++
 include/sysemu/replay.h   |   19 ++++++
 migration/savevm.c        |   13 ++++
 replay/replay-char.c      |   21 ++----
 replay/replay-events.c    |   30 ++++-----
 replay/replay-internal.c  |   22 ++++++-
 replay/replay-internal.h  |    9 ++-
 replay/replay-snapshot.c  |    9 +++
 replay/replay-time.c      |   10 ++-
 replay/replay.c           |   43 ++++++-------
 stubs/replay.c            |   16 +++++
 target/arm/arm-powerctl.c |    8 --
 target/i386/hax-all.c     |    3 -
 util/main-loop.c          |   23 ++++++-
 util/qemu-timer.c         |   12 ++++
 vl.c                      |   12 +++-
 22 files changed, 475 insertions(+), 121 deletions(-)

--=20
Pavel Dovgalyuk
