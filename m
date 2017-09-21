Received: from eggs.gnu.org ([2001:4830:134:3::10]:37554)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dvAie-00056r-V4
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 19:17:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dvAid-0004eM-U8
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 19:17:20 -0400
Received: from mail-wr0-x242.google.com ([2a00:1450:400c:c0c::242]:33037)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1dvAid-0004dF-Op
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 19:17:19 -0400
Received: by mail-wr0-x242.google.com with SMTP id b9so3866750wra.0
	for <qemu-devel@nongnu.org>; Thu, 21 Sep 2017 16:17:19 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 22 Sep 2017 01:16:37 +0200
Message-Id: <1506035800-30509-30-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1506035800-30509-1-git-send-email-pbonzini@redhat.com>
References: <1506035800-30509-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 29/32] chardev: new
 qemu_chr_be_update_read_handlers()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>

From: Peter Xu <peterx@redhat.com>

Add a wrapper for the chr_update_read_handler().

Signed-off-by: Peter Xu <peterx@redhat.com>
Message-Id: <1505975754-21555-2-git-send-email-peterx@redhat.com>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 chardev/char-fe.c      |  7 ++-----
 chardev/char.c         | 10 ++++++++++
 include/chardev/char.h | 10 ++++++++++
 3 files changed, 22 insertions(+), 5 deletions(-)

diff --git a/chardev/char-fe.c b/chardev/char-fe.c
index f3af6ae..ee6d596 100644
--- a/chardev/char-fe.c
+++ b/chardev/char-fe.c
@@ -253,7 +253,6 @@ void qemu_chr_fe_set_handlers(CharBackend *b,
                               bool set_open)
 {
     Chardev *s;
-    ChardevClass *cc;
     int fe_open;
 
     s = b->chr;
@@ -261,7 +260,6 @@ void qemu_chr_fe_set_handlers(CharBackend *b,
         return;
     }
 
-    cc = CHARDEV_GET_CLASS(s);
     if (!opaque && !fd_can_read && !fd_read && !fd_event) {
         fe_open = 0;
         remove_fd_in_watch(s);
@@ -273,9 +271,8 @@ void qemu_chr_fe_set_handlers(CharBackend *b,
     b->chr_event = fd_event;
     b->chr_be_change = be_change;
     b->opaque = opaque;
-    if (cc->chr_update_read_handler) {
-        cc->chr_update_read_handler(s, context);
-    }
+
+    qemu_chr_be_update_read_handlers(s, context);
 
     if (set_open) {
         qemu_chr_fe_set_open(b, fe_open);
diff --git a/chardev/char.c b/chardev/char.c
index b6fd5eb..e090dd5 100644
--- a/chardev/char.c
+++ b/chardev/char.c
@@ -180,6 +180,16 @@ void qemu_chr_be_write(Chardev *s, uint8_t *buf, int len)
     }
 }
 
+void qemu_chr_be_update_read_handlers(Chardev *s,
+                                      GMainContext *context)
+{
+    ChardevClass *cc = CHARDEV_GET_CLASS(s);
+
+    if (cc->chr_update_read_handler) {
+        cc->chr_update_read_handler(s, context);
+    }
+}
+
 int qemu_chr_add_client(Chardev *s, int fd)
 {
     return CHARDEV_GET_CLASS(s)->chr_add_client ?
diff --git a/include/chardev/char.h b/include/chardev/char.h
index 66dde46..2068ea4 100644
--- a/include/chardev/char.h
+++ b/include/chardev/char.h
@@ -169,6 +169,16 @@ void qemu_chr_be_write(Chardev *s, uint8_t *buf, int len);
 void qemu_chr_be_write_impl(Chardev *s, uint8_t *buf, int len);
 
 /**
+ * @qemu_chr_be_update_read_handlers:
+ *
+ * Invoked when frontend read handlers are setup
+ *
+ * @context the gcontext that will be used to attach the watch sources
+ */
+void qemu_chr_be_update_read_handlers(Chardev *s,
+                                      GMainContext *context);
+
+/**
  * @qemu_chr_be_event:
  *
  * Send an event from the back end to the front end.
-- 
1.8.3.1
