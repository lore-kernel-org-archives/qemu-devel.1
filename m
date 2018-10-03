Received: from eggs.gnu.org ([2001:4830:134:3::10]:33260)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1g7koc-00008b-1W
	for qemu-devel@nongnu.org; Wed, 03 Oct 2018 13:20:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1g7koa-0001Vo-WB
	for qemu-devel@nongnu.org; Wed, 03 Oct 2018 13:20:02 -0400
From: Eric Blake <eblake@redhat.com>
Date: Wed,  3 Oct 2018 12:19:47 -0500
Message-Id: <20181003171947.588103-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH] nbd: Flip qemu-nbd to prefer newstyle;
 add -O for old behavior
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: vsementsov@virtuozzo.com, Paolo Bonzini <pbonzini@redhat.com>, "open list:Network Block Dev..." <qemu-block@nongnu.org>

Oldstyle NBD negotiation cannot perform any of the extensions that
we have recently been relying on.  While you can always pass -x ""
to get newstyle negotiation, these days, it is better to just default
to newstyle (with an empty export name) and fall back to oldstyle
only on an explicit request.

For comparison:

nbdkit 1.3 switched its default to newstyle (Jan 2018):
https://github.com/libguestfs/nbdkit/commit/b2a8aecc
https://github.com/libguestfs/nbdkit/commit/8158e773

nbd 3.10 dropped oldstyle long ago (Mar 2015):
https://github.com/NetworkBlockDevice/nbd/commit/36940193

Signed-off-by: Eric Blake <eblake@redhat.com>
---
 qemu-nbd.c | 27 +++++++++++++++++++--------
 1 file changed, 19 insertions(+), 8 deletions(-)

diff --git a/qemu-nbd.c b/qemu-nbd.c
index 51b9d38c727..8571a4f93d8 100644
--- a/qemu-nbd.c
+++ b/qemu-nbd.c
@@ -86,6 +86,7 @@ static void usage(const char *name)
 "  -v, --verbose             display extra debugging information\n"
 "  -x, --export-name=NAME    expose export by name\n"
 "  -D, --description=TEXT    with -x, also export a human-readable description\n"
+"  -O, --oldstyle            force oldstyle negotiation\n"
 "\n"
 "Exposing part of the image:\n"
 "  -o, --offset=OFFSET       offset into the image\n"
@@ -529,6 +530,7 @@ int main(int argc, char **argv)
         { "object", required_argument, NULL, QEMU_NBD_OPT_OBJECT },
         { "export-name", required_argument, NULL, 'x' },
         { "description", required_argument, NULL, 'D' },
+        { "oldstyle", no_argument, NULL, 'O' },
         { "tls-creds", required_argument, NULL, QEMU_NBD_OPT_TLSCREDS },
         { "image-opts", no_argument, NULL, QEMU_NBD_OPT_IMAGE_OPTS },
         { "trace", required_argument, NULL, 'T' },
@@ -551,6 +553,7 @@ int main(int argc, char **argv)
     QDict *options = NULL;
     const char *export_name = NULL;
     const char *export_description = NULL;
+    bool oldstyle = false;
     const char *tlscredsid = NULL;
     bool imageOpts = false;
     bool writethrough = true;
@@ -723,6 +726,9 @@ int main(int argc, char **argv)
         case 'D':
             export_description = optarg;
             break;
+        case 'O':
+            oldstyle = true;
+            break;
         case 'v':
             verbose = 1;
             break;
@@ -799,7 +805,16 @@ int main(int argc, char **argv)
         }
     }

+    if (!oldstyle && !export_name) {
+        /* Set the default NBD protocol export name, to favor new style. */
+        export_name = "";
+    }
+
     if (tlscredsid) {
+        if (oldstyle) {
+            error_report("TLS is incompatible with oldstyle");
+            exit(EXIT_FAILURE);
+        }
         if (sockpath) {
             error_report("TLS is only supported with IPv4/IPv6");
             exit(EXIT_FAILURE);
@@ -808,11 +823,6 @@ int main(int argc, char **argv)
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
@@ -1013,13 +1023,14 @@ int main(int argc, char **argv)
         error_report_err(local_err);
         exit(EXIT_FAILURE);
     }
+    if (oldstyle && (export_name || export_description)) {
+        error_report("oldstyle negotiation cannot set export details");
+        exit(EXIT_FAILURE);
+    }
     if (export_name) {
         nbd_export_set_name(exp, export_name);
         nbd_export_set_description(exp, export_description);
         newproto = true;
-    } else if (export_description) {
-        error_report("Export description requires an export name");
-        exit(EXIT_FAILURE);
     }

     if (device) {
-- 
2.17.1
