Received: from eggs.gnu.org ([2001:4830:134:3::10]:51684)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dVf48-0001d1-AW
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 10:26:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dVf42-0003d7-MG
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 10:26:04 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:34803)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1dVf42-0003Zi-FL
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 10:25:58 -0400
Received: by mail-wr0-f195.google.com with SMTP id k67so9397089wrc.1
	for <qemu-devel@nongnu.org>; Thu, 13 Jul 2017 07:25:58 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 13 Jul 2017 16:24:04 +0200
Message-Id: <1499955874-10954-12-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1499955874-10954-1-git-send-email-pbonzini@redhat.com>
References: <1499955874-10954-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 11/41] char: forbid direct chardevice access for
 hotswap devices
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Anton Nefedov <anton.nefedov@virtuozzo.com>

From: Anton Nefedov <anton.nefedov@virtuozzo.com>

qemu_chr_fe_get_driver() is unsafe, frontends with hotswap support
should not access CharDriver ptr directly as CharDriver might change.

Signed-off-by: Anton Nefedov <anton.nefedov@virtuozzo.com>
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-Id: <1499342940-56739-5-git-send-email-anton.nefedov@virtuozzo.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 chardev/char-fe.c         |  7 +++++++
 include/chardev/char-fe.h | 10 ++++++++++
 2 files changed, 17 insertions(+)

diff --git a/chardev/char-fe.c b/chardev/char-fe.c
index 7054863..de5ba3c 100644
--- a/chardev/char-fe.c
+++ b/chardev/char-fe.c
@@ -179,9 +179,16 @@ void qemu_chr_fe_printf(CharBackend *be, const char *fmt, ...)
 
 Chardev *qemu_chr_fe_get_driver(CharBackend *be)
 {
+    /* this is unsafe for the users that support chardev hotswap */
+    assert(be->chr_be_change == NULL);
     return be->chr;
 }
 
+bool qemu_chr_fe_backend_connected(CharBackend *be)
+{
+    return !!be->chr;
+}
+
 bool qemu_chr_fe_init(CharBackend *b, Chardev *s, Error **errp)
 {
     int tag = 0;
diff --git a/include/chardev/char-fe.h b/include/chardev/char-fe.h
index 9f38060..588abed 100644
--- a/include/chardev/char-fe.h
+++ b/include/chardev/char-fe.h
@@ -46,10 +46,20 @@ void qemu_chr_fe_deinit(CharBackend *b, bool del);
  *
  * Returns the driver associated with a CharBackend or NULL if no
  * associated Chardev.
+ * Note: avoid this function as the driver should never be accessed directly,
+ *       especially by the frontends that support chardevice hotswap.
+ *       Consider qemu_chr_fe_backend_connected() to check for driver existence
  */
 Chardev *qemu_chr_fe_get_driver(CharBackend *be);
 
 /**
+ * @qemu_chr_fe_backend_connected:
+ *
+ * Returns true if there is a chardevice associated with @be.
+ */
+bool qemu_chr_fe_backend_connected(CharBackend *be);
+
+/**
  * @qemu_chr_fe_set_handlers:
  * @b: a CharBackend
  * @fd_can_read: callback to get the amount of data the frontend may
-- 
1.8.3.1
