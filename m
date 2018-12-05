Received: from eggs.gnu.org ([2001:4830:134:3::10]:47051)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gUdwY-0007uV-C4
	for qemu-devel@nongnu.org; Wed, 05 Dec 2018 15:38:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gUdwV-0002nY-85
	for qemu-devel@nongnu.org; Wed, 05 Dec 2018 15:38:50 -0500
Received: from mx1.redhat.com ([209.132.183.28]:55302)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1gUdwU-0002mF-Rv
	for qemu-devel@nongnu.org; Wed, 05 Dec 2018 15:38:47 -0500
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Thu,  6 Dec 2018 00:37:37 +0400
Message-Id: <20181205203737.9011-8-marcandre.lureau@redhat.com>
In-Reply-To: <20181205203737.9011-1-marcandre.lureau@redhat.com>
References: <20181205203737.9011-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH for-4.0 v4 7/7] monitor: avoid potential
 dead-lock when cleaning up
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Zhang Chen <zhangckid@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, peterx@redhat.com, Jason Wang <jasowang@redhat.com>, Li Zhijian <lizhijian@cn.fujitsu.com>, Markus Armbruster <armbru@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>

When a monitor is connected to a Spice chardev, the monitor cleanup
can dead-lock:

 #0  0x00007f43446637fd in __lll_lock_wait () at /lib64/libpthread.so.0
 #1  0x00007f434465ccf4 in pthread_mutex_lock () at /lib64/libpthread.so.=
0
 #2  0x0000556dd79f22ba in qemu_mutex_lock_impl (mutex=3D0x556dd81c9220 <=
monitor_lock>, file=3D0x556dd7ae3648 "/home/elmarco/src/qq/monitor.c", li=
ne=3D645) at /home/elmarco/src/qq/util/qemu-thread-posix.c:66
 #3  0x0000556dd7431bd5 in monitor_qapi_event_queue (event=3DQAPI_EVENT_S=
PICE_DISCONNECTED, qdict=3D0x556dd9abc850, errp=3D0x7fffb7bbddd8) at /hom=
e/elmarco/src/qq/monitor.c:645
 #4  0x0000556dd79d476b in qapi_event_send_spice_disconnected (server=3D0=
x556dd98ee760, client=3D0x556ddaaa8560, errp=3D0x556dd82180d0 <error_abor=
t>) at qapi/qapi-events-ui.c:149
 #5  0x0000556dd7870fc1 in channel_event (event=3D3, info=3D0x556ddad1b59=
0) at /home/elmarco/src/qq/ui/spice-core.c:235
 #6  0x00007f434560a6bb in reds_handle_channel_event (reds=3D<optimized o=
ut>, event=3D3, info=3D0x556ddad1b590) at reds.c:316
 #7  0x00007f43455f393b in main_dispatcher_self_handle_channel_event (inf=
o=3D0x556ddad1b590, event=3D3, self=3D0x556dd9a7d8c0) at main-dispatcher.=
c:197
 #8  0x00007f43455f393b in main_dispatcher_channel_event (self=3D0x556dd9=
a7d8c0, event=3Devent@entry=3D3, info=3D0x556ddad1b590) at main-dispatche=
r.c:197
 #9  0x00007f4345612833 in red_stream_push_channel_event (s=3Ds@entry=3D0=
x556ddae2ef40, event=3Devent@entry=3D3) at red-stream.c:414
 #10 0x00007f434561286b in red_stream_free (s=3D0x556ddae2ef40) at red-st=
ream.c:388
 #11 0x00007f43455f9ddc in red_channel_client_finalize (object=3D0x556dd9=
bb21a0) at red-channel-client.c:347
 #12 0x00007f434b5f9fb9 in g_object_unref () at /lib64/libgobject-2.0.so.=
0
 #13 0x00007f43455fc212 in red_channel_client_push (rcc=3D0x556dd9bb21a0)=
 at red-channel-client.c:1341
 #14 0x0000556dd76081ba in spice_port_set_fe_open (chr=3D0x556dd9925e20, =
fe_open=3D0) at /home/elmarco/src/qq/chardev/spice.c:241
 #15 0x0000556dd796d74a in qemu_chr_fe_set_open (be=3D0x556dd9a37c00, fe_=
open=3D0) at /home/elmarco/src/qq/chardev/char-fe.c:340
 #16 0x0000556dd796d4d9 in qemu_chr_fe_set_handlers (b=3D0x556dd9a37c00, =
fd_can_read=3D0x0, fd_read=3D0x0, fd_event=3D0x0, be_change=3D0x0, opaque=
=3D0x0, context=3D0x0, set_open=3Dtrue) at /home/elmarco/src/qq/chardev/c=
har-fe.c:280
 #17 0x0000556dd796d359 in qemu_chr_fe_deinit (b=3D0x556dd9a37c00, del=3D=
false) at /home/elmarco/src/qq/chardev/char-fe.c:233
 #18 0x0000556dd7432240 in monitor_data_destroy (mon=3D0x556dd9a37c00) at=
 /home/elmarco/src/qq/monitor.c:786
 #19 0x0000556dd743b968 in monitor_cleanup () at /home/elmarco/src/qq/mon=
itor.c:4683
 #20 0x0000556dd75ce776 in main (argc=3D3, argv=3D0x7fffb7bbe458, envp=3D=
0x7fffb7bbe478) at /home/elmarco/src/qq/vl.c:4660

Because spice code tries to emit a "disconnected" signal on the
monitors. Fix this dead-lock by releasing the monitor lock for
flush/destroy.

monitor_lock protects mon_list, monitor_qapi_event_state and
monitor_destroyed. monitor_flush() and monitor_data_destroy() don't
access any of those variables.

monitor_cleanup()'s loop is safe because it uses
QTAILQ_FOREACH_SAFE(), and no further monitor can be added after
calling monitor_cleanup() thanks to monitor_destroyed check in
monitor_list_append().

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
---
 monitor.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/monitor.c b/monitor.c
index f0256bdec5..936c040b2d 100644
--- a/monitor.c
+++ b/monitor.c
@@ -4652,8 +4652,11 @@ void monitor_cleanup(void)
     monitor_destroyed =3D true;
     QTAILQ_FOREACH_SAFE(mon, &mon_list, entry, next) {
         QTAILQ_REMOVE(&mon_list, mon, entry);
+        /* Permit QAPI event emission from character frontend release */
+        qemu_mutex_unlock(&monitor_lock);
         monitor_flush(mon);
         monitor_data_destroy(mon);
+        qemu_mutex_lock(&monitor_lock);
         g_free(mon);
     }
     qemu_mutex_unlock(&monitor_lock);
--=20
2.20.0.rc1
