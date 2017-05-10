Received: from eggs.gnu.org ([2001:4830:134:3::10]:44977)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dovgaluk@ispras.ru>) id 1d8S1R-0005z4-TY
	for qemu-devel@nongnu.org; Wed, 10 May 2017 09:51:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dovgaluk@ispras.ru>) id 1d8S1O-00053a-Pq
	for qemu-devel@nongnu.org; Wed, 10 May 2017 09:51:21 -0400
Received: from mail.ispras.ru ([83.149.199.45]:51562)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dovgaluk@ispras.ru>) id 1d8S1O-00053N-CR
	for qemu-devel@nongnu.org; Wed, 10 May 2017 09:51:18 -0400
From: "Pavel Dovgalyuk" <dovgaluk@ispras.ru>
References: <20170505103822.20641-1-alex.bennee@linaro.org>
In-Reply-To: <20170505103822.20641-1-alex.bennee@linaro.org>
Date: Wed, 10 May 2017 16:51:11 +0300
Message-ID: <006301d2c994$7bd42850$737c78f0$@ru>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Language: ru
Subject: Re: [Qemu-devel] [RFC PATCH v1 0/9] BQL and Replay Lock changes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?'Alex_Benn=C3=A9e'?= <alex.bennee@linaro.org>, pbonzini@redhat.com, boost.lists@gmail.com, pavel.dovgaluk@ispras.ru
Cc: cota@braap.org, qemu-devel@nongnu.org

Guest Windows XP doesn't boot with these patches.

Pavel Dovgalyuk


> -----Original Message-----
> From: Alex Benn=C3=A9e [mailto:alex.bennee@linaro.org]
> Sent: Friday, May 05, 2017 1:38 PM
> To: pbonzini@redhat.com; boost.lists@gmail.com; =
pavel.dovgaluk@ispras.ru
> Cc: cota@braap.org; qemu-devel@nongnu.org; Alex Benn=C3=A9e
> Subject: [RFC PATCH v1 0/9] BQL and Replay Lock changes
>=20
> Hi,
>=20
> This RFC does two principle things. It continues the push to reduce
> the BQL lock contention to a minimum by dropping the BQL for most of
> the run loop - eventually only holding it for timer processing and
> sleeping. The second part is an attempt to fix the breakage caused to
> record/replay by the previous work reducing the BQL in 2.9.
>=20
> The patch breakdown is as follows:
>=20
>  - target/arm/arm-powertctl: drop BQL assertions
>=20
> This just fixes a bogus assert. The async work doesn't need BQL
> protection as it is all done in the context of the vCPU (meaning
> nothing else should be messing with it). However going forward we will
> need to audit all the async work calls to make sure they are fine to
> run outside of the BQL.
>=20
>  - cpus: push BQL lock to qemu_*_wait_io_event
>  - cpus: only take BQL for sleeping threads
>=20
> The BQL reduction is done in two stages, mainly to make bisection
> easier.
>=20
>  - replay/replay-internal.c: track holding of replay_lock
>  - replay: make locking visible outside replay code
>  - replay: push replay_mutex_lock up the call tree
>=20
> There is still more work to do here but essentially replay_lock now
> replaces the BQL in keeping synchronisation between main-loop and the
> TCG thread - it is no longer a fine lock for the replay log but a
> gross lock that keeps batches of updates together. So far I have been
> testing with the simple testcase:
>=20
>   ./arm-softmmu/qemu-system-arm -machine type=3Dvexpress-a9 -m 1024 \
>     -display none -smp 1 -kernel ../images/vexpress-kernel.img \
>     -dtb ../images/vexpress-v2p-ca9.dtb  \
>     -append "console=3DttyAMA0" -serial mon:stdio \
>     -icount shift=3D7,rr=3Drecord,rrfile=3Dreplay.bin
>=20
> ..and that works fine. However more complex testing with more devices
> to exercise the async events code is needed here. One change that
> needs some careful care is we are now not dropping the replay_mutex
> lock between events.
>=20
> And finally:
>=20
>  - scripts/qemu-gdb: add simple tcg lock status helper
>  - util/qemu-thread-*: add qemu_lock, locked and unlock trace events
>  - scripts/analyse-locks-simpletrace.py: script to analyse lock times
>=20
> These are helpers I wrote while debugging the locking. The GDB helper
> is fairly dump but does attempt to show where locks are held. The
> qemu-lock tracing is a little hacky but could prove useful in doing
> more detailed lock analysis.
>=20
> Any thoughts/comments? Does this seem like a reasonable direction to
> go?
>=20
> Alex Benn=C3=A9e (9):
>   target/arm/arm-powertctl: drop BQL assertions
>   cpus: push BQL lock to qemu_*_wait_io_event
>   cpus: only take BQL for sleeping threads
>   replay/replay-internal.c: track holding of replay_lock
>   replay: make locking visible outside replay code
>   replay: push replay_mutex_lock up the call tree
>   scripts/qemu-gdb: add simple tcg lock status helper
>   util/qemu-thread-*: add qemu_lock, locked and unlock trace events
>   scripts/analyse-locks-simpletrace.py: script to analyse lock times
>=20
>  cpus-common.c                        | 13 ++---
>  cpus.c                               | 57 ++++++++++++++++++---
>  docs/replay.txt                      | 19 +++++++
>  include/qemu/thread.h                |  7 ++-
>  include/sysemu/replay.h              | 16 ++++++
>  kvm-all.c                            |  4 --
>  replay/replay-char.c                 | 21 +++-----
>  replay/replay-events.c               | 18 ++-----
>  replay/replay-internal.c             | 22 +++++++-
>  replay/replay-internal.h             |  5 +-
>  replay/replay-time.c                 | 10 ++--
>  replay/replay.c                      | 40 +++++++--------
>  scripts/analyse-locks-simpletrace.py | 99 =
++++++++++++++++++++++++++++++++++++
>  scripts/qemu-gdb.py                  |  3 +-
>  scripts/qemugdb/tcg.py               | 46 +++++++++++++++++
>  stubs/replay.c                       | 15 ++++++
>  target/arm/arm-powerctl.c            |  8 ---
>  target/i386/hax-all.c                |  2 -
>  util/main-loop.c                     | 23 +++++++--
>  util/qemu-thread-posix.c             | 11 +++-
>  util/trace-events                    |  5 ++
>  vl.c                                 |  2 +
>  22 files changed, 353 insertions(+), 93 deletions(-)
>  create mode 100755 scripts/analyse-locks-simpletrace.py
>  create mode 100644 scripts/qemugdb/tcg.py
>=20
> --
> 2.11.0
