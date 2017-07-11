Received: from eggs.gnu.org ([2001:4830:134:3::10]:40169)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peng.hao2@zte.com.cn>) id 1dUmtw-0001TZ-4g
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 00:35:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peng.hao2@zte.com.cn>) id 1dUmts-0006aX-TQ
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 00:35:56 -0400
Received: from mx7.zte.com.cn ([202.103.147.169]:37968)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peng.hao2@zte.com.cn>) id 1dUmts-0006Za-Ad
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 00:35:52 -0400
From: Peng Hao <peng.hao2@zte.com.cn>
Date: Tue, 11 Jul 2017 19:47:25 +0800
Message-Id: <1499773645-120137-1-git-send-email-peng.hao2@zte.com.cn>
Subject: [Qemu-devel] [PATCH V2] chardev: fix parallel device can't be
 reconnect
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

Parallel device don't register be->chr_can_read function, but remote
disconnect event is handled in chr_read.So connected parallel device
can not detect remote disconnect event. The chardevs with chr_can_read=NULL
has the same problem.

Signed-off-by: Peng Hao <peng.hao2@zte.com.cn>
Reviewed-by: Wang Yechao <wang.yechao255@zte.com.cn>
---
 chardev/char-socket.c  | 11 +++++++++++
 chardev/char.c         | 10 ++++++++++
 include/chardev/char.h |  9 +++++++++
 3 files changed, 30 insertions(+)

diff --git a/chardev/char-socket.c b/chardev/char-socket.c
index ccc499c..aa44f8f 100644
--- a/chardev/char-socket.c
+++ b/chardev/char-socket.c
@@ -139,6 +139,9 @@ static int tcp_chr_read_poll(void *opaque)
         return 0;
     }
     s->max_size = qemu_chr_be_can_write(chr);
+    if (qemu_chr_null_be_can_read(chr)) {
+        return 1;
+    }
     return s->max_size;
 }
 
@@ -422,6 +425,14 @@ static gboolean tcp_chr_read(QIOChannel *chan, GIOCondition cond, void *opaque)
     uint8_t buf[CHR_READ_BUF_LEN];
     int len, size;
 
+    if (qemu_chr_null_be_can_read(chr)) {
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
diff --git a/chardev/char.c b/chardev/char.c
index 2b679a2..7f7f486 100644
--- a/chardev/char.c
+++ b/chardev/char.c
@@ -148,6 +148,16 @@ int qemu_chr_write(Chardev *s, const uint8_t *buf, int len, bool write_all)
     return offset;
 }
 
+int qemu_chr_null_be_can_read(Chardev *s)
+{
+    CharBackend *be = s->be;
+
+    if (!be || !be->chr_can_read) {
+        return 1;
+    }
+    return 0;
+}
+
 int qemu_chr_be_can_write(Chardev *s)
 {
     CharBackend *be = s->be;
diff --git a/include/chardev/char.h b/include/chardev/char.h
index 8a9ade4..8dd28a8 100644
--- a/include/chardev/char.h
+++ b/include/chardev/char.h
@@ -114,6 +114,15 @@ void qemu_chr_cleanup(void);
 Chardev *qemu_chr_new_noreplay(const char *label, const char *filename);
 
 /**
+ * @qemu_chr_null_be_can_read:
+ *
+ * Check if Chardev's chr_can_read is registered.
+ *
+ * Returns: 1 if Chardev's chr_can_read is null.
+ */
+int qemu_chr_null_be_can_read(Chardev *s);
+
+/**
  * @qemu_chr_be_can_write:
  *
  * Determine how much data the front end can currently accept.  This function
-- 
1.8.3.1
