Received: from eggs.gnu.org ([2001:4830:134:3::10]:58073)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cTAdB-0000xo-6O
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 11:59:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cTAd9-00007P-MB
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 11:59:41 -0500
Received: from mx1.redhat.com ([209.132.183.28]:59350)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1cTAd9-00007I-GO
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 11:59:39 -0500
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon, 16 Jan 2017 17:59:03 +0100
Message-Id: <20170116165916.8575-20-pbonzini@redhat.com>
In-Reply-To: <20170116165916.8575-1-pbonzini@redhat.com>
References: <20170116165916.8575-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 19/32] serial: fix memory leak in serial exit
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Li Qiang <liqiang6-s@360.cn>

From: Li Qiang <liqiang6-s@360.cn>

The serial_exit_core function doesn't free some resources.
This can lead memory leak when hotplug and unplug. This
patch avoid this.

Signed-off-by: Li Qiang <liqiang6-s@360.cn>
Message-Id: <586cb5ab.f31d9d0a.38ac3.acf2@mx.google.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
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
2.9.3
