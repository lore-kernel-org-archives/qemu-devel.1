Received: from eggs.gnu.org ([2001:4830:134:3::10]:39117)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dovgaluk@ispras.ru>) id 1evKkm-0004iJ-1B
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 06:32:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dovgaluk@ispras.ru>) id 1evKki-0004RE-Nv
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 06:32:28 -0400
Received: from mail.ispras.ru ([83.149.199.45]:47128)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dovgaluk@ispras.ru>) id 1evKki-0004PP-C1
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 06:32:24 -0400
From: "Pavel Dovgalyuk" <dovgaluk@ispras.ru>
References: <20180227095135.1060.36549.stgit@pasha-VirtualBox>
In-Reply-To: <20180227095135.1060.36549.stgit@pasha-VirtualBox>
Date: Mon, 12 Mar 2018 13:32:21 +0300
Message-ID: <000a01d3b9ed$67e75d40$37b617c0$@ru>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Content-Language: ru
Subject: Re: [Qemu-devel] [ PATCH v7 00/22] replay additions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: 'Pavel Dovgalyuk' <Pavel.Dovgaluk@ispras.ru>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, peter.maydell@linaro.org, war2jordan@live.com, boost.lists@gmail.com, quintela@redhat.com, ciro.santilli@gmail.com, jasowang@redhat.com, mst@redhat.com, zuban32s@gmail.com, maria.klimushenkova@ispras.ru, kraxel@redhat.com, thomas.dullien@googlemail.com, pbonzini@redhat.com, alex.bennee@linaro.org, rth@twiddle.net, crosthwaite.peter@gmail.com

Ping.

Pavel Dovgalyuk


> -----Original Message-----
> From: Pavel Dovgalyuk [mailto:Pavel.Dovgaluk@ispras.ru]
> Sent: Tuesday, February 27, 2018 12:52 PM
> To: qemu-devel@nongnu.org
> Cc: kwolf@redhat.com; peter.maydell@linaro.org; war2jordan@live.com; =
boost.lists@gmail.com;
> quintela@redhat.com; ciro.santilli@gmail.com; jasowang@redhat.com; =
mst@redhat.com;
> zuban32s@gmail.com; maria.klimushenkova@ispras.ru; dovgaluk@ispras.ru; =
kraxel@redhat.com;
> pavel.dovgaluk@ispras.ru; thomas.dullien@googlemail.com; =
pbonzini@redhat.com;
> alex.bennee@linaro.org
> Subject: [ PATCH v7 00/22] replay additions
>=20
> This set of patches moves replay lock upper in the function call tree.
> Now replay lock functions similar to BQL in older version and allows
> deterministic execution of the threads in icount mode.
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
> v6 patches with updates for v7 are available in the repository:
> https://github.com/ispras/qemu/tree/rr-180207
>=20
> v7 changes:
>  - updated record/replay documentation
>  - removed abort() from mutex stub functions
>  - fixed cpu_io_recompile function
>=20
> v6 changes:
>  - removed BQL optimization at all
>  - refined replay lock patches
>  - removed lock/unlock from replay-audio
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
> Alex Benn=C3=A9e (5):
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
>       replay: don't destroy mutex at exit
>       replay: check return values of fwrite
>       replay: avoid recursive call of checkpoints
>       replay: don't process async events when warping the clock
>       replay: save vmstate of the asynchronous events
>       replay: don't drain/flush bdrv queue while RR is working
>       replay: update documentation
>       tcg: fix cpu_io_recompile
>=20
>=20
>  accel/tcg/cpu-exec.c      |    5 +
>  accel/tcg/translate-all.c |   18 ++-
>  block/blkreplay.c         |   75 +++++++++++
>  block/io.c                |   22 +++
>  cpus.c                    |   26 +++-
>  docs/replay.txt           |  163 +++++++++++++++++++++---
>  include/qemu/timer.h      |   14 ++
>  include/sysemu/replay.h   |   18 +++
>  migration/savevm.c        |   13 ++
>  replay/replay-audio.c     |   14 +-
>  replay/replay-char.c      |   21 +--
>  replay/replay-events.c    |   75 +++++------
>  replay/replay-internal.c  |   47 ++++++-
>  replay/replay-internal.h  |   16 ++
>  replay/replay-snapshot.c  |   12 ++
>  replay/replay-time.c      |   10 +
>  replay/replay.c           |   62 ++++++---
>  scripts/replay-dump.py    |  308 =
+++++++++++++++++++++++++++++++++++++++++++++
>  stubs/replay.c            |    9 +
>  util/main-loop.c          |   15 ++
>  util/qemu-timer.c         |   12 ++
>  vl.c                      |   12 +-
>  22 files changed, 831 insertions(+), 136 deletions(-)
>  create mode 100755 scripts/replay-dump.py
>=20
> --
> Pavel Dovgalyuk
