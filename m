Received: from eggs.gnu.org ([2001:4830:134:3::10]:47299)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1d69fG-0005CJ-36
	for qemu-devel@nongnu.org; Thu, 04 May 2017 01:50:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1d69fE-0005RK-KO
	for qemu-devel@nongnu.org; Thu, 04 May 2017 01:50:58 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59196)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1d69fE-0005Qr-Dz
	for qemu-devel@nongnu.org; Thu, 04 May 2017 01:50:56 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 30E2561D0F
	for <qemu-devel@nongnu.org>; Thu,  4 May 2017 05:50:55 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Thu,  4 May 2017 07:50:39 +0200
Message-Id: <20170504055040.31904-3-kraxel@redhat.com>
In-Reply-To: <20170504055040.31904-1-kraxel@redhat.com>
References: <20170504055040.31904-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 2/3] input: don't queue delay if paused
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>

From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

qemu_input_event_send() discards key event when the guest is paused,
but not the delay.

The delay ends up in the input queue, and qemu_input_event_send_key()
will further fill the queue with upcoming events.

VNC uses qemu_input_event_send_key_delay(), not SPICE, which results
in a different input behaviour on pause: VNC will queue the events
(except the first that is discarded), SPICE will discard all events.

Don't queue delay if paused, and provide same behaviour on SPICE and
VNC clients on resume (and potentially avoid over-allocating the
buffer queue)

Fixes:
https://bugzilla.redhat.com/show_bug.cgi?id=3D1444326

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Message-id: 20170425130520.31819-1-marcandre.lureau@redhat.com
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 ui/input.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/ui/input.c b/ui/input.c
index fb1f404095..830f912f99 100644
--- a/ui/input.c
+++ b/ui/input.c
@@ -411,6 +411,10 @@ void qemu_input_event_send_key_qcode(QemuConsole *sr=
c, QKeyCode q, bool down)
=20
 void qemu_input_event_send_key_delay(uint32_t delay_ms)
 {
+    if (!runstate_is_running() && !runstate_check(RUN_STATE_SUSPENDED)) =
{
+        return;
+    }
+
     if (!kbd_timer) {
         kbd_timer =3D timer_new_ms(QEMU_CLOCK_VIRTUAL, qemu_input_queue_=
process,
                                  &kbd_queue);
--=20
2.9.3
