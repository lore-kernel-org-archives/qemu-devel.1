Received: from eggs.gnu.org ([2001:4830:134:3::10]:50171)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1g7lN7-0003bN-GR
	for qemu-devel@nongnu.org; Wed, 03 Oct 2018 13:55:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1g7lN6-0004Rj-Hx
	for qemu-devel@nongnu.org; Wed, 03 Oct 2018 13:55:41 -0400
From: Eric Blake <eblake@redhat.com>
Date: Wed,  3 Oct 2018 12:55:24 -0500
Message-Id: <20181003175524.597407-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH v2] nbd: Flip qemu-nbd to prefer newstyle;
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
Cc: vsementsov@virtuozzo.com, rjones@redhat.com, berrange@redhat.com, Paolo Bonzini <pbonzini@redhat.com>, "open list:Network Block Dev..." <qemu-block@nongnu.org>

Oldstyle NBD negotiation cannot perform any of the extensions that
we have recently been relying on.  While you can always pass -x ""
to get newstyle negotiation, these days, it is better to just default
to newstyle (with an empty export name) and fall back to oldstyle
only on an explicit request.

qemu as client can manage either style since 2.6.0, commit 69b49502d8

For comparison:

nbdkit 1.3 switched its default to newstyle (Jan 2018):
https://github.com/libguestfs/nbdkit/commit/b2a8aecc
https://github.com/libguestfs/nbdkit/commit/8158e773

nbd 3.10 dropped oldstyle long ago (Mar 2015):
https://github.com/NetworkBlockDevice/nbd/commit/36940193

Signed-off-by: Eric Blake <eblake@redhat.com>
---
v2: improve 'qemu-nbd --help', drop redundant variable 'newproto'
---
 qemu-nbd.c | 37 +++++++++++++++++++++++--------------
 1 file changed, 23 insertions(+), 14 deletions(-)

diff --git a/qemu-nbd.c b/qemu-nbd.c
index 51b9d38c727..e35c97e7ca4 100644
--- a/qemu-nbd.c
+++ b/qemu-nbd.c
@@ -56,7 +56,7 @@
 #define MBR_SIZE 512

 static NBDExport *exp;
-static bool newproto;
+static bool oldstyle;
 static int verbose;
 static char *srcpath;
 static SocketAddress *saddr;
@@ -84,8 +84,9 @@ static void usage(const char *name)
 "  -e, --shared=NUM          device can be shared by NUM clients (default '1')\n"
 "  -t, --persistent          don't exit on the last connection\n"
 "  -v, --verbose             display extra debugging information\n"
-"  -x, --export-name=NAME    expose export by name\n"
-"  -D, --description=TEXT    with -x, also export a human-readable description\n"
+"  -x, --export-name=NAME    expose export by name (default "")\n"
+"  -D, --description=TEXT    expose a human-readable description of export\n"
+"  -O, --oldstyle            force oldstyle (not with -x, -D, or --tls-creds)\n"
 "\n"
 "Exposing part of the image:\n"
 "  -o, --offset=OFFSET       offset into the image\n"
@@ -354,7 +355,7 @@ static void nbd_accept(QIONetListener *listener, QIOChannelSocket *cioc,

     nb_fds++;
     nbd_update_server_watch();
-    nbd_client_new(newproto ? NULL : exp, cioc,
+    nbd_client_new(oldstyle ? exp : NULL, cioc,
                    tlscreds, NULL, nbd_client_closed);
 }

@@ -502,7 +503,7 @@ int main(int argc, char **argv)
     off_t fd_size;
     QemuOpts *sn_opts = NULL;
     const char *sn_id_or_name = NULL;
-    const char *sopt = "hVb:o:p:rsnP:c:dvk:e:f:tl:x:T:D:";
+    const char *sopt = "hVb:o:p:rsnP:c:dvk:e:f:tl:x:T:D:O";
     struct option lopt[] = {
         { "help", no_argument, NULL, 'h' },
         { "version", no_argument, NULL, 'V' },
@@ -529,6 +530,7 @@ int main(int argc, char **argv)
         { "object", required_argument, NULL, QEMU_NBD_OPT_OBJECT },
         { "export-name", required_argument, NULL, 'x' },
         { "description", required_argument, NULL, 'D' },
+        { "oldstyle", no_argument, NULL, 'O' },
         { "tls-creds", required_argument, NULL, QEMU_NBD_OPT_TLSCREDS },
         { "image-opts", no_argument, NULL, QEMU_NBD_OPT_IMAGE_OPTS },
         { "trace", required_argument, NULL, 'T' },
@@ -723,6 +725,9 @@ int main(int argc, char **argv)
         case 'D':
             export_description = optarg;
             break;
+        case 'O':
+            oldstyle = true;
+            break;
         case 'v':
             verbose = 1;
             break;
@@ -799,7 +804,16 @@ int main(int argc, char **argv)
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
@@ -808,11 +822,6 @@ int main(int argc, char **argv)
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
@@ -1013,13 +1022,13 @@ int main(int argc, char **argv)
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
-        newproto = true;
-    } else if (export_description) {
-        error_report("Export description requires an export name");
-        exit(EXIT_FAILURE);
     }

     if (device) {
-- 
2.17.1
