Received: from eggs.gnu.org ([2001:4830:134:3::10]:59993)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dovgaluk@ispras.ru>) id 1gClks-0006uZ-JB
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 09:20:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dovgaluk@ispras.ru>) id 1gClkp-00083r-TJ
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 09:20:54 -0400
Received: from mail.ispras.ru ([83.149.199.45]:40552)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dovgaluk@ispras.ru>) id 1gClkp-00082g-Fm
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 09:20:51 -0400
From: "Pavel Dovgalyuk" <dovgaluk@ispras.ru>
References: <20181017090750.4378-1-pbonzini@redhat.com>
	<001f01d465fd$01af8b80$050ea280$@ru>
	<CANzW0ms5DMhjYqBUS3EHfhVRp9Li+Dk=WH9RRpO=jbfOgctkCg@mail.gmail.com>
	<0817e2fe-5a97-a4ed-9ae2-2e8dee6c9a43@redhat.com>
	<004201d4660d$e86ef1e0$b94cd5a0$@ru>
	<a29da0a1-85d7-c57c-5c42-27594a7849ac@redhat.com>
In-Reply-To: <a29da0a1-85d7-c57c-5c42-27594a7849ac@redhat.com>
Date: Wed, 17 Oct 2018 16:20:52 +0300
Message-ID: <005c01d4661c$3a9cd0a0$afd671e0$@ru>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Content-Language: ru
Subject: Re: [Qemu-devel] [PATCH] Revert "icount: remove obsolete warp call"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: 'Paolo Bonzini' <pbonzini@redhat.com>, 'Artem Pisarenko' <artem.k.pisarenko@gmail.com>, 'Clement Deschamps' <clement.deschamps@greensocs.com>
Cc: qemu-devel@nongnu.org, 'Pavel Dovgalyuk' <Pavel.Dovgaluk@ispras.ru>

> From: Paolo Bonzini [mailto:pbonzini@redhat.com]
> On 17/10/2018 13:38, Pavel Dovgalyuk wrote:
> >> From: Paolo Bonzini [mailto:pbonzini@redhat.com]
> >> On 17/10/2018 11:53, Artem Pisarenko wrote:
> >>> See my last comment in bug report. This kind of modification, even
> >>> adapted to changed function name, doesn't solve issue.
> >>> I thought long time that it does, but once I catched qemu with a =
hang.
> >>> And of course, I wasn't able to reproduce it. So it just better =
hides issue.
> >>> Take a look at alternative solution from
> >>> QBox: =
https://git.greensocs.com/qemu/qbox/commit/a8ed106032e375e715a531d6e93e4d=
9ec295dbdb
> >>> I didn't catched fail with it (yet).
> >
> > Tried to test it, but rr seems to be broken again.
> > I'll try to bisect now.
>=20
> Can we add a test that runs with "make check" and covers the basics of
> record/replay's cpus.c bits?
>=20
> rr is very cool, and we fixed/understood a lot of stuff when getting =
it
> ready for inclusion.  But now it's constantly broken and every time we
> change rr we also risk breaking icount.

I found the source of the bug. As QEMU becomes more multi-threaded and =
non-synchronized,
checkpoints move from thread to thread.
And the event queue that processed at checkpoints should belong to the =
same thread
in both record and replay executions.

Current problem was with the checkpoint for virtual timers. They are =
processed from different threads:
from vCPU and from aio_dispatch function.

Therefore the following patch fixes the problem, but I think that this =
part has to be refactored.
There should be nailed-to-thread events that process the event queue. =
Then checkpoints can become
just synchronization events and therefore omitted for empty timer lists, =
for example.


diff --git a/replay/replay-events.c b/replay/replay-events.c
index 83a7d81..60e8c21 100644
--- a/replay/replay-events.c
+++ b/replay/replay-events.c
@@ -205,6 +205,7 @@ void replay_save_events(int checkpoint)
 {
     g_assert(replay_mutex_locked());
     g_assert(checkpoint !=3D CHECKPOINT_CLOCK_WARP_START);
+    g_assert(checkpoint !=3D CHECKPOINT_CLOCK_VIRTUAL);
     while (!QTAILQ_EMPTY(&events_list)) {
         Event *event =3D QTAILQ_FIRST(&events_list);
         replay_save_event(event, checkpoint);
diff --git a/replay/replay.c b/replay/replay.c
index 93d2573..79b8485 100644
--- a/replay/replay.c
+++ b/replay/replay.c
@@ -231,7 +231,8 @@ bool replay_checkpoint(ReplayCheckpoint checkpoint)
         /* This checkpoint belongs to several threads.
            Processing events from different threads is
            non-deterministic */
-        if (checkpoint !=3D CHECKPOINT_CLOCK_WARP_START) {
+        if (checkpoint !=3D CHECKPOINT_CLOCK_WARP_START
+            && checkpoint !=3D CHECKPOINT_CLOCK_VIRTUAL) {
             replay_save_events(checkpoint);
         }
         res =3D true;

Pavel Dovgalyuk
