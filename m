Received: from eggs.gnu.org ([2001:4830:134:3::10]:56152)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gSqtR-0004WL-OJ
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 17:04:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gSqtQ-0005CW-5h
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 17:04:13 -0500
From: Eric Blake <eblake@redhat.com>
Date: Fri, 30 Nov 2018 16:03:42 -0600
Message-Id: <20181130220344.3350618-14-eblake@redhat.com>
In-Reply-To: <20181130220344.3350618-1-eblake@redhat.com>
References: <20181130220344.3350618-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH 13/14] qemu-nbd: Add --list option
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: jsnow@redhat.com, nsoffer@redhat.com, rjones@redhat.com, vsementsov@virtuozzo.com, qemu-block@nongnu.org

We want to be able to detect whether a given qemu NBD server is
exposing the right export(s) and dirty bitmaps, at least for
regression testing.  We could use 'nbd-client -l' from the upstream
NBD project to list exports, but it's annoying to rely on
out-of-tree binaries; furthermore, nbd-client doesn't necessarily
know about all of the qemu NBD extensions.  Thus, we plan on adding
a new mode to qemu-nbd that merely sniffs all possible information
from the server during handshake phase, then disconnects and dumps
the information.

This patch actually implements --list/-L, while reusing other
options such as --tls-creds for now designating how to connect
as the client (rather than their non-list usage of how to operate
as the server).

I debated about adding this functionality to something akin to
'qemu-img info' - but that tool does not readily lend itself
to connecting to an arbitrary NBD server without also tying to
a specific export (I may, however, still add ImageInfoSpecificNBD
for reporting the bitmaps available when connecting to a single
export).  And, while it may feel a bit odd that normally
qemu-nbd is a server but 'qemu-nbd -L' is a client, we are not
really making the qemu-nbd binary that much larger, because
'qemu-nbd -c' has to operate as both server and client
simultaneously across two threads when feeding the kernel module
for /dev/nbdN access.

Sample output:
$ qemu-nbd -L
exports available: 1
 export: ''
  size:  65536
  flags: 0x4ed ( flush fua trim zeroes df cache )
  min block: 512
  opt block: 4096
  max block: 33554432
  available meta contexts: 1
   base:allocation

Signed-off-by: Eric Blake <eblake@redhat.com>
---
 qemu-nbd.c | 153 ++++++++++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 141 insertions(+), 12 deletions(-)

diff --git a/qemu-nbd.c b/qemu-nbd.c
index c57053a0795..e19a841b869 100644
--- a/qemu-nbd.c
+++ b/qemu-nbd.c
@@ -76,6 +76,7 @@ static void usage(const char *name)
 {
     (printf) (
 "Usage: %s [OPTIONS] FILE\n"
+"  or:  %s -L [OPTIONS]\n"
 "QEMU Disk Network Block Device Server\n"
 "\n"
 "  -h, --help                display this help and exit\n"
@@ -97,6 +98,7 @@ static void usage(const char *name)
 "  -P, --partition=NUM       only expose partition NUM\n"
 "\n"
 "General purpose options:\n"
+"  -L, --list                list NBD exports visible to client\n"
 "  --object type,id=ID,...   define an object such as 'secret' for providing\n"
 "                            passwords and/or encryption keys\n"
 "  --tls-creds=ID            use id of an earlier --object to provide TLS\n"
@@ -130,7 +132,7 @@ static void usage(const char *name)
 "      --image-opts          treat FILE as a full set of image options\n"
 "\n"
 QEMU_HELP_BOTTOM "\n"
-    , name, NBD_DEFAULT_PORT, "DEVICE");
+    , name, name, NBD_DEFAULT_PORT, "DEVICE");
 }

 static void version(const char *name)
@@ -242,6 +244,92 @@ static void termsig_handler(int signum)
 }


+static int qemu_nbd_client_list(SocketAddress *saddr, QCryptoTLSCreds *tls,
+                                const char *hostname)
+{
+    int ret = EXIT_FAILURE;
+    int rc;
+    Error *err = NULL;
+    QIOChannelSocket *sioc;
+    NBDExportInfo *list;
+    int i, j;
+
+    sioc = qio_channel_socket_new();
+    if (qio_channel_socket_connect_sync(sioc, saddr, &err) < 0) {
+        error_report_err(err);
+        goto out;
+    }
+    rc = nbd_receive_export_list(QIO_CHANNEL(sioc), tls, hostname, &list,
+                                 &err);
+    if (rc < 0) {
+        if (err) {
+            error_report_err(err);
+        }
+        goto out_socket;
+    }
+    printf("exports available: %d\n", rc);
+    for (i = 0; i < rc; i++) {
+        printf(" export: '%s'\n", list[i].name);
+        if (list[i].description && *list[i].description) {
+            printf("  description: %s\n", list[i].description);
+        }
+        if (list[i].flags & NBD_FLAG_HAS_FLAGS) {
+            printf("  size:  %" PRIu64 "\n", list[i].size);
+            printf("  flags: 0x%x (", list[i].flags);
+            if (list[i].flags & NBD_FLAG_READ_ONLY) {
+                printf(" readonly");
+            }
+            if (list[i].flags & NBD_FLAG_SEND_FLUSH) {
+                printf(" flush");
+            }
+            if (list[i].flags & NBD_FLAG_SEND_FUA) {
+                printf(" fua");
+            }
+            if (list[i].flags & NBD_FLAG_ROTATIONAL) {
+                printf(" rotational");
+            }
+            if (list[i].flags & NBD_FLAG_SEND_TRIM) {
+                printf(" trim");
+            }
+            if (list[i].flags & NBD_FLAG_SEND_WRITE_ZEROES) {
+                printf(" zeroes");
+            }
+            if (list[i].flags & NBD_FLAG_SEND_DF) {
+                printf(" df");
+            }
+            if (list[i].flags & NBD_FLAG_CAN_MULTI_CONN) {
+                printf(" multi");
+            }
+            if (list[i].flags & NBD_FLAG_SEND_RESIZE) {
+                printf(" resize");
+            }
+            if (list[i].flags & NBD_FLAG_SEND_CACHE) {
+                printf(" cache");
+            }
+            printf(" )\n");
+        }
+        if (list[i].min_block) {
+            printf("  min block: %u\n", list[i].min_block);
+            printf("  opt block: %u\n", list[i].opt_block);
+            printf("  max block: %u\n", list[i].max_block);
+        }
+        if (list[i].n_contexts) {
+            printf("  available meta contexts: %d\n", list[i].n_contexts);
+            for (j = 0; j < list[i].n_contexts; j++) {
+                printf("   %s\n", list[i].contexts[j]);
+            }
+        }
+    }
+    nbd_free_export_list(list, rc);
+
+    ret = EXIT_SUCCESS;
+ out_socket:
+    object_unref(OBJECT(sioc));
+ out:
+    return ret;
+}
+
+
 #if HAVE_NBD_DEVICE
 static void *show_parts(void *arg)
 {
@@ -424,7 +512,8 @@ static QemuOptsList qemu_object_opts = {



-static QCryptoTLSCreds *nbd_get_tls_creds(const char *id, Error **errp)
+static QCryptoTLSCreds *nbd_get_tls_creds(const char *id, bool list,
+                                          Error **errp)
 {
     Object *obj;
     QCryptoTLSCreds *creds;
@@ -444,10 +533,18 @@ static QCryptoTLSCreds *nbd_get_tls_creds(const char *id, Error **errp)
         return NULL;
     }

-    if (creds->endpoint != QCRYPTO_TLS_CREDS_ENDPOINT_SERVER) {
-        error_setg(errp,
-                   "Expecting TLS credentials with a server endpoint");
-        return NULL;
+    if (list) {
+        if (creds->endpoint != QCRYPTO_TLS_CREDS_ENDPOINT_CLIENT) {
+            error_setg(errp,
+                       "Expecting TLS credentials with a client endpoint");
+            return NULL;
+        }
+    } else {
+        if (creds->endpoint != QCRYPTO_TLS_CREDS_ENDPOINT_SERVER) {
+            error_setg(errp,
+                       "Expecting TLS credentials with a server endpoint");
+            return NULL;
+        }
     }
     object_ref(obj);
     return creds;
@@ -470,7 +567,8 @@ static void setup_address_and_port(const char **address, const char **port)
 static const char *socket_activation_validate_opts(const char *device,
                                                    const char *sockpath,
                                                    const char *address,
-                                                   const char *port)
+                                                   const char *port,
+                                                   bool list)
 {
     if (device != NULL) {
         return "NBD device can't be set when using socket activation";
@@ -488,6 +586,10 @@ static const char *socket_activation_validate_opts(const char *device,
         return "TCP port number can't be set when using socket activation";
     }

+    if (list) {
+        return "List mode is incompatible with socket activation";
+    }
+
     return NULL;
 }

@@ -511,7 +613,7 @@ int main(int argc, char **argv)
     off_t fd_size;
     QemuOpts *sn_opts = NULL;
     const char *sn_id_or_name = NULL;
-    const char *sopt = "hVb:o:p:rsnP:c:dvk:e:f:tl:x:T:D:";
+    const char *sopt = "hVb:o:p:rsnP:c:dvk:e:f:tl:x:T:D:L";
     struct option lopt[] = {
         { "help", no_argument, NULL, 'h' },
         { "version", no_argument, NULL, 'V' },
@@ -523,6 +625,7 @@ int main(int argc, char **argv)
         { "partition", required_argument, NULL, 'P' },
         { "connect", required_argument, NULL, 'c' },
         { "disconnect", no_argument, NULL, 'd' },
+        { "list", no_argument, NULL, 'L' },
         { "snapshot", no_argument, NULL, 's' },
         { "load-snapshot", required_argument, NULL, 'l' },
         { "nocache", no_argument, NULL, 'n' },
@@ -558,13 +661,14 @@ int main(int argc, char **argv)
     Error *local_err = NULL;
     BlockdevDetectZeroesOptions detect_zeroes = BLOCKDEV_DETECT_ZEROES_OPTIONS_OFF;
     QDict *options = NULL;
-    const char *export_name = ""; /* Default export name */
+    const char *export_name = NULL;
     const char *export_description = NULL;
     const char *tlscredsid = NULL;
     bool imageOpts = false;
     bool writethrough = true;
     char *trace_file = NULL;
     bool fork_process = false;
+    bool list = false;
     int old_stderr = -1;
     unsigned socket_activation;

@@ -764,13 +868,32 @@ int main(int argc, char **argv)
         case QEMU_NBD_OPT_FORK:
             fork_process = true;
             break;
+        case 'L':
+            list = true;
+            break;
         }
     }

-    if ((argc - optind) != 1) {
+    if (list) {
+        if (argc != optind) {
+            error_report("List mode is incompatible with a file name");
+            exit(EXIT_FAILURE);
+        }
+        if (export_name || export_description || dev_offset || partition ||
+            device || disconnect || fmt || sn_id_or_name) {
+            error_report("List mode is incompatible with per-device settings");
+            exit(EXIT_FAILURE);
+        }
+        if (fork_process) {
+            error_report("List mode is incompatible with forking");
+            exit(EXIT_FAILURE);
+        }
+    } else if ((argc - optind) != 1) {
         error_report("Invalid number of arguments");
         error_printf("Try `%s --help' for more information.\n", argv[0]);
         exit(EXIT_FAILURE);
+    } else if (!export_name) {
+        export_name = "";
     }

     qemu_opts_foreach(&qemu_object_opts,
@@ -789,7 +912,8 @@ int main(int argc, char **argv)
     } else {
         /* Using socket activation - check user didn't use -p etc. */
         const char *err_msg = socket_activation_validate_opts(device, sockpath,
-                                                              bindto, port);
+                                                              bindto, port,
+                                                              list);
         if (err_msg != NULL) {
             error_report("%s", err_msg);
             exit(EXIT_FAILURE);
@@ -812,7 +936,7 @@ int main(int argc, char **argv)
             error_report("TLS is not supported with a host device");
             exit(EXIT_FAILURE);
         }
-        tlscreds = nbd_get_tls_creds(tlscredsid, &local_err);
+        tlscreds = nbd_get_tls_creds(tlscredsid, list, &local_err);
         if (local_err) {
             error_report("Failed to get TLS creds %s",
                          error_get_pretty(local_err));
@@ -820,6 +944,11 @@ int main(int argc, char **argv)
         }
     }

+    if (list) {
+        saddr = nbd_build_socket_address(sockpath, bindto, port);
+        return qemu_nbd_client_list(saddr, tlscreds, bindto);
+    }
+
     if (disconnect) {
 #if HAVE_NBD_DEVICE
         int nbdfd = open(argv[optind], O_RDWR);
-- 
2.17.2
