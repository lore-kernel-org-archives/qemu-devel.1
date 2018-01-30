Received: from eggs.gnu.org ([2001:4830:134:3::10]:40940)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dovgaluk@ispras.ru>) id 1egOus-00073P-Mr
	for qemu-devel@nongnu.org; Tue, 30 Jan 2018 00:57:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dovgaluk@ispras.ru>) id 1egOuo-00010T-1J
	for qemu-devel@nongnu.org; Tue, 30 Jan 2018 00:57:10 -0500
Received: from mail.ispras.ru ([83.149.199.45]:53756)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dovgaluk@ispras.ru>) id 1egOun-0000vA-LP
	for qemu-devel@nongnu.org; Tue, 30 Jan 2018 00:57:05 -0500
From: "Pavel Dovgalyuk" <dovgaluk@ispras.ru>
References: <20180123085319.3419.97865.stgit@pasha-VirtualBox>
In-Reply-To: <20180123085319.3419.97865.stgit@pasha-VirtualBox>
Date: Tue, 30 Jan 2018 08:57:03 +0300
Message-ID: <001801d3998f$27190300$754b0900$@ru>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Content-Language: ru
Subject: Re: [Qemu-devel] [RFC PATCH v5 00/24] replay additions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: 'Pavel Dovgalyuk' <Pavel.Dovgaluk@ispras.ru>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, peter.maydell@linaro.org, boost.lists@gmail.com, quintela@redhat.com, jasowang@redhat.com, mst@redhat.com, zuban32s@gmail.com, maria.klimushenkova@ispras.ru, kraxel@redhat.com, pbonzini@redhat.com, alex.bennee@linaro.org

Ping?

Pavel Dovgalyuk


> -----Original Message-----
> From: Pavel Dovgalyuk [mailto:Pavel.Dovgaluk@ispras.ru]
> Sent: Tuesday, January 23, 2018 11:53 AM
> To: qemu-devel@nongnu.org
> Cc: kwolf@redhat.com; peter.maydell@linaro.org; boost.lists@gmail.com; =
quintela@redhat.com;
> jasowang@redhat.com; mst@redhat.com; zuban32s@gmail.com; =
maria.klimushenkova@ispras.ru;
> dovgaluk@ispras.ru; kraxel@redhat.com; pavel.dovgaluk@ispras.ru; =
pbonzini@redhat.com;
> alex.bennee@linaro.org
> Subject: [RFC PATCH v5 00/24] replay additions
>=20
> This set of patches includex fixes from Alex Benn=C3=A9e for fixing
> BQL and replay locks after inventing the MTTCG. It also includes some
> additional replay patches that makes this set of fixes working.
> It is also fixes some vmstate creation (and loading) issues
> in record/replay modes:
>  - VM start/stop fixes in replay mode
>  - overlay creation for blkreplay filter
>  - fixes for vmstate save/load in record/replay mode
>  - fixes for host clock vmstate
>=20
> There is also a set of helper scripts written by Alex Benn=C3=A9e
> for debugging the record/replay code.
>=20
> v5 changes:
>  - removed patch for narrowing BQL-protected code
>  - disabled bdrv_(drain/flush)_all for record/replay mode
>=20
> v4 changes:
>  - removed upstreamed patches
>  - added patch for saving async queue state in replay
>  - minor fixes
>=20
> v3 changes:
>  - removed upstreamed patches
>  - fixed bug with recursive checkpoints
>  - fixed bug with icount warp checkpoint
>=20
> v2 changes:
>  - updated lock/unlock logic (as suggested by Paolo Bonzini)
>  - updated cpu execution loop to avoid races in setting/resetting exit =
request (as suggested
> by Paolo Bonzini)
>  - minor changes
>=20
> ---
>=20
> Alex Benn=C3=A9e (7):
>       target/arm/arm-powertctl: drop BQL assertions
>       cpus: push BQL lock to qemu_*_wait_io_event
>       replay/replay.c: bump REPLAY_VERSION again
>       replay/replay-internal.c: track holding of replay_lock
>       replay: make locking visible outside replay code
>       replay: push replay_mutex_lock up the call tree
>       scripts/replay-dump.py: replay log dumper
>=20
> Pavel Dovgalyuk (17):
>       cpu-exec: fix exception_index handling
>       block: implement bdrv_snapshot_goto for blkreplay
>       blkreplay: create temporary overlay for underlaying devices
>       replay: disable default snapshot for record/replay
>       replay: fix processing async events
>       replay: fixed replay_enable_events
>       replay: fix save/load vm for non-empty queue
>       replay: added replay log format description
>       replay: save prior value of the host clock
>       hax: remove BQL lock/unlock
>       kvm: remove BQL lock/unlock
>       replay: don't destroy mutex at exit
>       replay: check return values of fwrite
>       replay: avoid recursive call of checkpoints
>       replay: don't process async events when warping the clock
>       replay: save vmstate of the asynchronous events
>       replay: don't drain/flush bdrv queue while RR is working
>=20
>=20
>  accel/kvm/kvm-all.c       |    3
>  accel/tcg/cpu-exec.c      |    5 +
>  block/blkreplay.c         |   73 +++++++++++
>  block/io.c                |   22 +++
>  cpus.c                    |   47 +++++--
>  docs/replay.txt           |   91 +++++++++++++
>  include/qemu/timer.h      |   14 ++
>  include/sysemu/replay.h   |   19 +++
>  migration/savevm.c        |   13 ++
>  replay/replay-char.c      |   21 +--
>  replay/replay-events.c    |   73 +++++------
>  replay/replay-internal.c  |   48 ++++++-
>  replay/replay-internal.h  |   15 ++
>  replay/replay-snapshot.c  |   12 ++
>  replay/replay-time.c      |   10 +
>  replay/replay.c           |   62 ++++++---
>  scripts/replay-dump.py    |  308 =
+++++++++++++++++++++++++++++++++++++++++++++
>  stubs/replay.c            |   16 ++
>  target/arm/arm-powerctl.c |    8 -
>  target/i386/hax-all.c     |    2
>  util/main-loop.c          |   17 ++
>  util/qemu-timer.c         |   12 ++
>  vl.c                      |   12 +-
>  23 files changed, 777 insertions(+), 126 deletions(-)
>  create mode 100755 scripts/replay-dump.py
>=20
> --
> Pavel Dovgalyuk
