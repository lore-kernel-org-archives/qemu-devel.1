Received: from eggs.gnu.org ([2001:4830:134:3::10]:45412)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cROgd-0003L1-UD
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 14:35:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cROgd-0003OO-2i
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 14:35:55 -0500
Received: from mail-wm0-x242.google.com ([2a00:1450:400c:c09::242]:36175)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1cROgc-0003OA-SV
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 14:35:55 -0500
Received: by mail-wm0-x242.google.com with SMTP id r126so313062wmr.3
	for <qemu-devel@nongnu.org>; Wed, 11 Jan 2017 11:35:54 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 11 Jan 2017 20:35:14 +0100
Message-Id: <1484163327-111841-21-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1484163327-111841-1-git-send-email-pbonzini@redhat.com>
References: <1484163327-111841-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 20/33] serial: fix memory leak in serial exit
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
1.8.3.1
