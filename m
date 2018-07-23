Received: from eggs.gnu.org ([2001:4830:134:3::10]:42148)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <flukshun@gmail.com>) id 1fhhJk-0002we-D5
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 16:20:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <flukshun@gmail.com>) id 1fhhJh-0004ht-3i
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 16:20:28 -0400
Sender: fluxion <flukshun@gmail.com>
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Mon, 23 Jul 2018 15:17:01 -0500
Message-Id: <20180723201748.25573-53-mdroth@linux.vnet.ibm.com>
In-Reply-To: <20180723201748.25573-1-mdroth@linux.vnet.ibm.com>
References: <20180723201748.25573-1-mdroth@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 52/99] vnc: fix use-after-free
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>

From: Gerd Hoffmann <kraxel@redhat.com>

When vnc_client_read() return value is -1
vs is not valid any more.

Fixes: d49b87f0d1e0520443a990fc610d0f02bc63c556
Reported-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Tested-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Tested-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Message-id: 20180420084820.3873-1-kraxel@redhat.com
(cherry picked from commit 1bc3117abad28d6465ecdb2c944b22943df0e4f3)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 ui/vnc.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/ui/vnc.c b/ui/vnc.c
index e164eb798c..5526e54f48 100644
--- a/ui/vnc.c
+++ b/ui/vnc.c
@@ -1539,13 +1539,14 @@ gboolean vnc_client_io(QIOChannel *ioc G_GNUC_UNUSED,
     VncState *vs = opaque;
     if (condition & G_IO_IN) {
         if (vnc_client_read(vs) < 0) {
-            goto end;
+            /* vs is free()ed here */
+            return TRUE;
         }
     }
     if (condition & G_IO_OUT) {
         vnc_client_write(vs);
     }
-end:
+
     if (vs->disconnecting) {
         if (vs->ioc_tag != 0) {
             g_source_remove(vs->ioc_tag);
-- 
2.17.1
