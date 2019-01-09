Received: from eggs.gnu.org ([209.51.188.92]:44762)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1ghBcV-0001EF-Ru
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 06:02:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1ghBcT-0003TY-TT
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 06:01:59 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Wed,  9 Jan 2019 11:01:44 +0000
Message-Id: <20190109110144.18633-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH] throttle-groups: fix restart coroutine
 iothread race
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org, Alberto Garcia <berto@igalia.com>, Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

The following QMP command leads to a crash when iothreads are used:

  { 'execute': 'device_del', 'arguments': {'id': 'data'} }

The backtrace involves the queue restart coroutine where
tgm->throttle_state is a NULL pointer because
throttle_group_unregister_tgm() has already been called:

  (gdb) bt full
  #0  0x00005585a7a3b378 in qemu_mutex_lock_impl (mutex=3D0xfffffffffffff=
fd0, file=3D0x5585a7bb3d54 "block/throttle-groups.c", line=3D412) at util=
/qemu-thread-posix.c:64
        err =3D <optimized out>
        __PRETTY_FUNCTION__ =3D "qemu_mutex_lock_impl"
        __func__ =3D "qemu_mutex_lock_impl"
  #1  0x00005585a79be074 in throttle_group_restart_queue_entry (opaque=3D=
0x5585a9de4eb0) at block/throttle-groups.c:412
        _f =3D <optimized out>
        data =3D 0x5585a9de4eb0
        tgm =3D 0x5585a9079440
        ts =3D 0x0
        tg =3D 0xffffffffffffff98
        is_write =3D false
        empty_queue =3D 255

This coroutine should not execute in the iothread after the throttle
group member has been unregistered!

The root cause is that the device_del code path schedules the restart
coroutine in the iothread while holding the AioContext lock.  Therefore
the iothread cannot execute the coroutine until after device_del
releases the lock - by this time it's too late.

This patch adds a reference count to ThrottleGroupMember so we can
synchronously wait for restart coroutines to complete.  Once they are
done it is safe to unregister the ThrottleGroupMember.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
I'm unhappy about adding another synchronous point but haven't found a
nicer solution.  Only the main loop calls
throttle_group_unregister_tgm() and the AioContext lock is held, so
using AIO_WAIT_WHILE() is safe.

Both iothread and non-iothread mode have been tested.  I also tested 2
scsi-hd instances in the same throttling group to make sure that hot
unplugging one drive doesn't interfere with the remaining drive in the
throttling group.

 include/block/throttle-groups.h | 5 +++++
 block/throttle-groups.c         | 9 +++++++++
 2 files changed, 14 insertions(+)

diff --git a/include/block/throttle-groups.h b/include/block/throttle-gro=
ups.h
index e2fd0513c4..7492bbc8a8 100644
--- a/include/block/throttle-groups.h
+++ b/include/block/throttle-groups.h
@@ -43,6 +43,11 @@ typedef struct ThrottleGroupMember {
      */
     unsigned int io_limits_disabled;
=20
+    /* Number of pending throttle_group_restart_queue_entry() coroutines=
.
+     * Accessed under aio_context lock.
+     */
+    unsigned int restart_pending;
+
     /* The following fields are protected by the ThrottleGroup lock.
      * See the ThrottleGroup documentation for details.
      * throttle_state tells us if I/O limits are configured. */
diff --git a/block/throttle-groups.c b/block/throttle-groups.c
index 5d8213a443..a4b15ea428 100644
--- a/block/throttle-groups.c
+++ b/block/throttle-groups.c
@@ -415,6 +415,9 @@ static void coroutine_fn throttle_group_restart_queue=
_entry(void *opaque)
     }
=20
     g_free(data);
+
+    tgm->restart_pending--;
+    aio_wait_kick();
 }
=20
 static void throttle_group_restart_queue(ThrottleGroupMember *tgm, bool =
is_write)
@@ -430,6 +433,8 @@ static void throttle_group_restart_queue(ThrottleGrou=
pMember *tgm, bool is_write
      * be no timer pending on this tgm at this point */
     assert(!timer_pending(tgm->throttle_timers.timers[is_write]));
=20
+    tgm->restart_pending++;
+
     co =3D qemu_coroutine_create(throttle_group_restart_queue_entry, rd)=
;
     aio_co_enter(tgm->aio_context, co);
 }
@@ -538,6 +543,7 @@ void throttle_group_register_tgm(ThrottleGroupMember =
*tgm,
=20
     tgm->throttle_state =3D ts;
     tgm->aio_context =3D ctx;
+    tgm->restart_pending =3D 0;
=20
     qemu_mutex_lock(&tg->lock);
     /* If the ThrottleGroup is new set this ThrottleGroupMember as the t=
oken */
@@ -584,6 +590,9 @@ void throttle_group_unregister_tgm(ThrottleGroupMembe=
r *tgm)
         return;
     }
=20
+    /* Wait for throttle_group_restart_queue_entry() coroutines to finis=
h */
+    AIO_WAIT_WHILE(tgm->aio_context, tgm->restart_pending > 0);
+
     qemu_mutex_lock(&tg->lock);
     for (i =3D 0; i < 2; i++) {
         assert(tgm->pending_reqs[i] =3D=3D 0);
--=20
2.20.1
