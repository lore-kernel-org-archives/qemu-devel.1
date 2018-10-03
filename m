Received: from eggs.gnu.org ([2001:4830:134:3::10]:57159)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1g7kXk-0001aE-8y
	for qemu-devel@nongnu.org; Wed, 03 Oct 2018 13:02:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1g7kXh-0001dw-2b
	for qemu-devel@nongnu.org; Wed, 03 Oct 2018 13:02:36 -0400
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Wed,  3 Oct 2018 20:02:27 +0300
Message-Id: <20181003170228.95973-2-vsementsov@virtuozzo.com>
In-Reply-To: <20181003170228.95973-1-vsementsov@virtuozzo.com>
References: <20181003170228.95973-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH 1/2] qemu-nbd: drop old-style negotiation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: pbonzini@redhat.com, eblake@redhat.com, mreitz@redhat.com, kwolf@redhat.com, vsementsov@virtuozzo.com, den@virtuozzo.com, rjones@redhat.com, berrange@redhat.com

Use new-style negotiation always, with default "" (empty) export name
if it is not specified with '-x' option.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 qemu-nbd.c | 25 ++++++-------------------
 1 file changed, 6 insertions(+), 19 deletions(-)

diff --git a/qemu-nbd.c b/qemu-nbd.c
index 51b9d38c72..57e79e30ea 100644
--- a/qemu-nbd.c
+++ b/qemu-nbd.c
@@ -56,7 +56,6 @@
 #define MBR_SIZE 512
 
 static NBDExport *exp;
-static bool newproto;
 static int verbose;
 static char *srcpath;
 static SocketAddress *saddr;
@@ -84,8 +83,8 @@ static void usage(const char *name)
 "  -e, --shared=NUM          device can be shared by NUM clients (default '1')\n"
 "  -t, --persistent          don't exit on the last connection\n"
 "  -v, --verbose             display extra debugging information\n"
-"  -x, --export-name=NAME    expose export by name\n"
-"  -D, --description=TEXT    with -x, also export a human-readable description\n"
+"  -x, --export-name=NAME    expose export by name (default is empty string)\n"
+"  -D, --description=TEXT    export a human-readable description\n"
 "\n"
 "Exposing part of the image:\n"
 "  -o, --offset=OFFSET       offset into the image\n"
@@ -354,8 +353,7 @@ static void nbd_accept(QIONetListener *listener, QIOChannelSocket *cioc,
 
     nb_fds++;
     nbd_update_server_watch();
-    nbd_client_new(newproto ? NULL : exp, cioc,
-                   tlscreds, NULL, nbd_client_closed);
+    nbd_client_new(NULL, cioc, tlscreds, NULL, nbd_client_closed);
 }
 
 static void nbd_update_server_watch(void)
@@ -549,7 +547,7 @@ int main(int argc, char **argv)
     Error *local_err = NULL;
     BlockdevDetectZeroesOptions detect_zeroes = BLOCKDEV_DETECT_ZEROES_OPTIONS_OFF;
     QDict *options = NULL;
-    const char *export_name = NULL;
+    const char *export_name = ""; /* Default export name */
     const char *export_description = NULL;
     const char *tlscredsid = NULL;
     bool imageOpts = false;
@@ -808,11 +806,6 @@ int main(int argc, char **argv)
             error_report("TLS is not supported with a host device");
             exit(EXIT_FAILURE);
         }
-        if (!export_name) {
-            /* Set the default NBD protocol export name, since
-             * we *must* use new style protocol for TLS */
-            export_name = "";
-        }
         tlscreds = nbd_get_tls_creds(tlscredsid, &local_err);
         if (local_err) {
             error_report("Failed to get TLS creds %s",
@@ -1013,14 +1006,8 @@ int main(int argc, char **argv)
         error_report_err(local_err);
         exit(EXIT_FAILURE);
     }
-    if (export_name) {
-        nbd_export_set_name(exp, export_name);
-        nbd_export_set_description(exp, export_description);
-        newproto = true;
-    } else if (export_description) {
-        error_report("Export description requires an export name");
-        exit(EXIT_FAILURE);
-    }
+    nbd_export_set_name(exp, export_name);
+    nbd_export_set_description(exp, export_description);
 
     if (device) {
         int ret;
-- 
2.18.0
