Received: from eggs.gnu.org ([2001:4830:134:3::10]:46861)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dIxem-0001ji-Bq
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 09:39:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dIxel-0005VH-7r
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 09:39:24 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43844)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1dIxek-0005Uf-Vn
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 09:39:23 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C988342BC9
	for <qemu-devel@nongnu.org>; Thu,  8 Jun 2017 13:39:21 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Thu,  8 Jun 2017 10:39:06 -0300
Message-Id: <20170608133906.12737-6-ehabkost@redhat.com>
In-Reply-To: <20170608133906.12737-1-ehabkost@redhat.com>
References: <20170608133906.12737-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PATCH 5/5] vnc: No need for Error** parameter at
 vnc_client_io_error()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>

The only callers of vnc_client_io_error() with non-NULL errp don't use
*errp after the function gets called, so there's no need to use an
Error** argument.  Change parameter to Error* and simplify the code.

Cc: Gerd Hoffmann <kraxel@redhat.com>
Cc: Daniel P. Berrange <berrange@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 ui/vnc.h |  2 +-
 ui/vnc.c | 13 +++++--------
 2 files changed, 6 insertions(+), 9 deletions(-)

diff --git a/ui/vnc.h b/ui/vnc.h
index 694cf32ca9..52f65bbd86 100644
--- a/ui/vnc.h
+++ b/ui/vnc.h
@@ -526,7 +526,7 @@ uint32_t read_u32(uint8_t *data, size_t offset);
 
 /* Protocol stage functions */
 void vnc_client_error(VncState *vs);
-ssize_t vnc_client_io_error(VncState *vs, ssize_t ret, Error **errp);
+ssize_t vnc_client_io_error(VncState *vs, ssize_t ret, Error *err);
 
 void start_client_init(VncState *vs);
 void start_auth_vnc(VncState *vs);
diff --git a/ui/vnc.c b/ui/vnc.c
index 47b49c7318..51f13f0c29 100644
--- a/ui/vnc.c
+++ b/ui/vnc.c
@@ -1180,7 +1180,7 @@ void vnc_disconnect_finish(VncState *vs)
     g_free(vs);
 }
 
-ssize_t vnc_client_io_error(VncState *vs, ssize_t ret, Error **errp)
+ssize_t vnc_client_io_error(VncState *vs, ssize_t ret, Error *err)
 {
     if (ret <= 0) {
         if (ret == 0) {
@@ -1188,14 +1188,11 @@ ssize_t vnc_client_io_error(VncState *vs, ssize_t ret, Error **errp)
             vnc_disconnect_start(vs);
         } else if (ret != QIO_CHANNEL_ERR_BLOCK) {
             VNC_DEBUG("Closing down client sock: ret %zd (%s)\n",
-                      ret, errp ? error_get_pretty(*errp) : "Unknown");
+                      ret, err ? error_get_pretty(err) : "Unknown");
             vnc_disconnect_start(vs);
         }
 
-        if (errp) {
-            error_free(*errp);
-            *errp = NULL;
-        }
+        error_free(err);
         return 0;
     }
     return ret;
@@ -1231,7 +1228,7 @@ ssize_t vnc_client_write_buf(VncState *vs, const uint8_t *data, size_t datalen)
     ret = qio_channel_write(
         vs->ioc, (const char *)data, datalen, &err);
     VNC_DEBUG("Wrote wire %p %zd -> %ld\n", data, datalen, ret);
-    return vnc_client_io_error(vs, ret, &err);
+    return vnc_client_io_error(vs, ret, err);
 }
 
 
@@ -1344,7 +1341,7 @@ ssize_t vnc_client_read_buf(VncState *vs, uint8_t *data, size_t datalen)
     ret = qio_channel_read(
         vs->ioc, (char *)data, datalen, &err);
     VNC_DEBUG("Read wire %p %zd -> %ld\n", data, datalen, ret);
-    return vnc_client_io_error(vs, ret, &err);
+    return vnc_client_io_error(vs, ret, err);
 }
 
 
-- 
2.11.0.259.g40922b1
