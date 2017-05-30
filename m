Received: from eggs.gnu.org ([2001:4830:134:3::10]:45888)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <anton.nefedov@virtuozzo.com>) id 1dFhfP-0004wu-GU
	for qemu-devel@nongnu.org; Tue, 30 May 2017 09:58:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <anton.nefedov@virtuozzo.com>) id 1dFhfL-0007Dq-0G
	for qemu-devel@nongnu.org; Tue, 30 May 2017 09:58:35 -0400
Received: from mail-he1eur01on0114.outbound.protection.outlook.com
	([104.47.0.114]:16853
	helo=EUR01-HE1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <anton.nefedov@virtuozzo.com>)
	id 1dFhfK-0007DL-KU
	for qemu-devel@nongnu.org; Tue, 30 May 2017 09:58:30 -0400
From: Anton Nefedov <anton.nefedov@virtuozzo.com>
Date: Tue, 30 May 2017 16:57:54 +0300
Message-ID: <1496152683-102751-5-git-send-email-anton.nefedov@virtuozzo.com>
In-Reply-To: <1496152683-102751-1-git-send-email-anton.nefedov@virtuozzo.com>
References: <1496152683-102751-1-git-send-email-anton.nefedov@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v3 04/13] char: forbid direct chardevice access
 for hotswap devices
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: den@virtuozzo.com, pbonzini@redhat.com, marcandre.lureau@redhat.com, Anton Nefedov <anton.nefedov@virtuozzo.com>

qemu_chr_fe_get_driver() is unsafe, frontends with hotswap support
should not access CharDriver ptr directly as CharDriver might change.

Signed-off-by: Anton Nefedov <anton.nefedov@virtuozzo.com>
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 chardev/char.c        |  7 +++++++
 include/sysemu/char.h | 10 ++++++++++
 2 files changed, 17 insertions(+)

diff --git a/chardev/char.c b/chardev/char.c
index ba1a5f5..1eed934 100644
--- a/chardev/char.c
+++ b/chardev/char.c
@@ -484,9 +484,16 @@ static Notifier muxes_realize_notify = {
 
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
 static bool qemu_chr_fe_connect(CharBackend *b, Chardev *s, Error **errp)
 {
     int tag = 0;
diff --git a/include/sysemu/char.h b/include/sysemu/char.h
index 014ebbc..117d628 100644
--- a/include/sysemu/char.h
+++ b/include/sysemu/char.h
@@ -391,10 +391,20 @@ bool qemu_chr_fe_init(CharBackend *b, Chardev *s, Error **errp);
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
  * @qemu_chr_fe_deinit:
  *
  * Dissociate the CharBackend from the Chardev.
-- 
2.7.4
