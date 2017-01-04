Received: from eggs.gnu.org ([2001:4830:134:3::10]:37389)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liq3ea@gmail.com>) id 1cOhAQ-0004hy-AU
	for qemu-devel@nongnu.org; Wed, 04 Jan 2017 03:43:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liq3ea@gmail.com>) id 1cOhAL-0003kZ-F6
	for qemu-devel@nongnu.org; Wed, 04 Jan 2017 03:43:30 -0500
Received: from mail-oi0-x241.google.com ([2607:f8b0:4003:c06::241]:33059)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <liq3ea@gmail.com>) id 1cOhAL-0003kN-Aa
	for qemu-devel@nongnu.org; Wed, 04 Jan 2017 03:43:25 -0500
Received: by mail-oi0-x241.google.com with SMTP id f201so73819922oib.0
	for <qemu-devel@nongnu.org>; Wed, 04 Jan 2017 00:43:25 -0800 (PST)
Message-ID: <586cb5ab.f31d9d0a.38ac3.acf2@mx.google.com>
From: Li Qiang <liq3ea@gmail.com>
Date: Wed,  4 Jan 2017 00:43:16 -0800
Subject: [Qemu-devel] [PATCH] serial: fix memory leak in serial exit
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: mst@redhat.com, pbonzini@redhat.com, qemu-devel@nongnu.org
Cc: Li Qiang <liqiang6-s@360.cn>

From: Li Qiang <liqiang6-s@360.cn>

The serial_exit_core function doesn't free some resources.
This can lead memory leak when hotplug and unplug. This
patch avoid this.

Signed-off-by: Li Qiang <liqiang6-s@360.cn>
---
 hw/char/serial.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/hw/char/serial.c b/hw/char/serial.c
index ffbacd8..67b18ed 100644
--- a/hw/char/serial.c
+++ b/hw/char/serial.c
@@ -906,6 +906,16 @@ void serial_realize_core(SerialState *s, Error **errp)
 void serial_exit_core(SerialState *s)
 {
     qemu_chr_fe_deinit(&s->chr);
+
+    timer_del(s->modem_status_poll);
+    timer_free(s->modem_status_poll);
+
+    timer_del(s->fifo_timeout_timer);
+    timer_free(s->fifo_timeout_timer);
+
+    fifo8_destroy(&s->recv_fifo);
+    fifo8_destroy(&s->xmit_fifo);
+
     qemu_unregister_reset(serial_reset, s);
 }
 
-- 
1.8.3.1
