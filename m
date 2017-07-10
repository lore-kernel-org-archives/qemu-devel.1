Received: from eggs.gnu.org ([2001:4830:134:3::10]:51310)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peng.hao2@zte.com.cn>) id 1dUUAG-0004IU-Mf
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 04:35:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peng.hao2@zte.com.cn>) id 1dUUAD-0005Bj-KV
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 04:35:32 -0400
Received: from mx7.zte.com.cn ([202.103.147.169]:42104)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peng.hao2@zte.com.cn>) id 1dUUAB-00058y-QT
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 04:35:29 -0400
From: Peng Hao <peng.hao2@zte.com.cn>
Date: Tue, 11 Jul 2017 00:45:21 +0800
Message-Id: <1499705121-71730-1-git-send-email-peng.hao2@zte.com.cn>
Subject: [Qemu-devel] [PATCH] chardev: fix parallel device can't be
 reconnect.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: pbonzini@redhat.com, marcandre.lureau@redhat.com
Cc: qemu-devel@nongnu.org, wang.yechao255@zte.com.cn, Peng Hao <peng.hao2@zte.com.cn>

Parallel device don't register be->chr_can_read function, but remote disconnect event is handled in chr_read.
So connected parallel device can not detect remote disconnect event.

Signed-off-by: Peng Hao <peng.hao2@zte.com.cn>
Reviewed-by: Wang Yechao <wang.yechao255@zte.com.cn>
---
 chardev/char-socket.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/chardev/char-socket.c b/chardev/char-socket.c
index ccc499c..59509d4 100644
--- a/chardev/char-socket.c
+++ b/chardev/char-socket.c
@@ -131,6 +131,14 @@ static int tcp_chr_write(Chardev *chr, const uint8_t *buf, int len)
     }
 }
 
+static gboolean is_parallel_device(Chardev *chr)
+{
+    if (chr && chr->label && strstr(chr->label, "charparallel")) {
+        return TRUE;
+    }
+    return FALSE;
+}
+
 static int tcp_chr_read_poll(void *opaque)
 {
     Chardev *chr = CHARDEV(opaque);
@@ -138,6 +146,8 @@ static int tcp_chr_read_poll(void *opaque)
     if (!s->connected) {
         return 0;
     }
+    if (is_parallel_device(chr)) {
+        return 1;
+    }
     s->max_size = qemu_chr_be_can_write(chr);
     return s->max_size;
 }
@@ -422,6 +432,15 @@ static gboolean tcp_chr_read(QIOChannel *chan, GIOCondition cond, void *opaque)
     uint8_t buf[CHR_READ_BUF_LEN];
     int len, size;
 
+    /* for parallel-device handle the socket close event here*/
+    if (!s->max_size && is_parallel_device(chr)) {
+        size = tcp_chr_recv(chr, (void *)buf, CHR_READ_BUF_LEN);
+        if (size == 0 || size == -1) {
+            tcp_chr_disconnect(chr);
+        }
+        return TRUE;
+    }
+
     if (!s->connected || s->max_size <= 0) {
         return TRUE;
     }
-- 
1.8.3.1
