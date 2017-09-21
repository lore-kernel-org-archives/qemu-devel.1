Received: from eggs.gnu.org ([2001:4830:134:3::10]:34027)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1duukF-0005qL-E6
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 02:13:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1duukD-0007jm-HI
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 02:13:55 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45416)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1duukD-0007i8-8e
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 02:13:53 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 5795481DF3
	for <qemu-devel@nongnu.org>; Thu, 21 Sep 2017 06:13:52 +0000 (UTC)
From: Peter Xu <peterx@redhat.com>
Date: Thu, 21 Sep 2017 14:13:31 +0800
Message-Id: <1505974414-6033-2-git-send-email-peterx@redhat.com>
In-Reply-To: <1505974414-6033-1-git-send-email-peterx@redhat.com>
References: <1505974414-6033-1-git-send-email-peterx@redhat.com>
Subject: [Qemu-devel] [PATCH 1/4] chardev: new
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>, Juan Quintela <quintela@redhat.com>, peterx@redhat.com, Eric Blake <eblake@redhat.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

Add a wrapper for the chr_update_read_handler().

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 chardev/char-fe.c      |  7 ++-----
 chardev/char.c         | 10 ++++++++++
 include/chardev/char.h | 10 ++++++++++
 3 files changed, 22 insertions(+), 5 deletions(-)

diff --git a/chardev/char-fe.c b/chardev/char-fe.c
index f3af6ae..5f76e7e 100644
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
+    qemu_chr_be_update_read_handlers(s);
 
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
2.7.4
