Received: from eggs.gnu.org ([2001:4830:134:3::10]:34816)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gYAP0-0005Ye-95
	for qemu-devel@nongnu.org; Sat, 15 Dec 2018 08:54:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gYAOx-0000PY-MH
	for qemu-devel@nongnu.org; Sat, 15 Dec 2018 08:54:46 -0500
From: Eric Blake <eblake@redhat.com>
Date: Sat, 15 Dec 2018 07:53:22 -0600
Message-Id: <20181215135324.152629-21-eblake@redhat.com>
In-Reply-To: <20181215135324.152629-1-eblake@redhat.com>
References: <20181215135324.152629-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH v2 20/22] qemu-nbd: Add --list option
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: nsoffer@redhat.com, jsnow@redhat.com, rjones@redhat.com, vsementsov@virtuozzo.com, qemu-block@nongnu.org

We want to be able to detect whether a given qemu NBD server is
exposing the right export(s) and dirty bitmaps, at least for
regression testing.  We could use 'nbd-client -l' from the upstream
NBD project to list exports, but it's annoying to rely on
out-of-tree binaries; furthermore, nbd-client doesn't necessarily
know about all of the qemu NBD extensions.  Thus, it is time to add
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

Note that the output only lists sizes if the server sent
NBD_FLAG_HAS_FLAGS, because a newstyle server does not give
the size otherwise.  It has the side effect that for really
old servers that did not send any flags, the size is not
output even though it was available.  However, I'm not too
concerned about that - oldstyle servers are (rightfully)
getting less common to encounter (qemu 3.0 was the last
version where we even serve it), and most existing servers
that still even offer oldstyle negotiation (such as nbdkit)
still send flags (since that was added to the NBD protocol
in 2007 to permit read-only connections).

Not done here, but maybe worth future experiments: capture
the meat of NBDExportInfo into a QAPI struct, and use the
generated QAPI pretty-printers instead of hand-rolling our
output loop.  It would also permit us to add a JSON output
mode for machine parsing.

Signed-off-by: Eric Blake <eblake@redhat.com>

---
v2: commit message improvements [Vladimir]
wording tweak to --help output [Vladimir]
update man page documentation
---
 qemu-nbd.texi |  30 ++++++++--
 qemu-nbd.c    | 155 +++++++++++++++++++++++++++++++++++++++++++++-----
 2 files changed, 166 insertions(+), 19 deletions(-)

diff --git a/qemu-nbd.texi b/qemu-nbd.texi
index 0e24c2801ee..1e168c10850 100644
--- a/qemu-nbd.texi
+++ b/qemu-nbd.texi
@@ -2,6 +2,8 @@
 @c man begin SYNOPSIS
 @command{qemu-nbd} [OPTION]... @var{filename}

+@command{qemu-nbd} @option{-L} [OPTION]...
+
 @command{qemu-nbd} @option{-d} @var{dev}
 @c man end
 @end example
@@ -10,8 +12,9 @@

 Provide access to various QEMU NBD features.  Most commonly used to
 export a QEMU disk image using the NBD protocol as a server, but can
-also be used (on Linux) to manage kernel bindings of a /dev/nbdX
-block device to a QEMU server.
+also be used as a client to query properties of a remote server, or
+(on Linux) to manage kernel bindings of a /dev/nbdX block device to a
+QEMU server.

 @c man end

@@ -28,13 +31,15 @@ See the @code{qemu(1)} manual page for full details of the properties
 supported. The common object types that it makes sense to define are the
 @code{secret} object, which is used to supply passwords and/or encryption
 keys, and the @code{tls-creds} object, which is used to supply TLS
-credentials for the qemu-nbd server.
+credentials for the qemu-nbd server or client.
 @item -p, --port=@var{port}
-The TCP port to listen on (default @samp{10809}).
+The TCP port to listen on as a server, or connect to as a client
+(default @samp{10809}).
 @item -o, --offset=@var{offset}
 The offset into the image.
 @item -b, --bind=@var{iface}
-The interface to bind to (default @samp{0.0.0.0}).
+The interface to bind to as a server, or connect to as a client
+(default @samp{0.0.0.0}).
 @item -k, --socket=@var{path}
 Use a unix socket with path @var{path}.
 @item --image-opts
@@ -88,10 +93,14 @@ Set the NBD volume export name (default of a zero-length string).
 @item -D, --description=@var{description}
 Set the NBD volume export description, as a human-readable
 string.
+@item -L, --list
+Connect as a client and list all details about the exports exposed by
+a remote NBD server.
 @item --tls-creds=ID
 Enable mandatory TLS encryption for the server by setting the ID
 of the TLS credentials object previously created with the --object
-option.
+option; or provide the credentials needed for connecting as a client
+in list mode.
 @item --fork
 Fork off the server process and exit the parent once the server is running.
 @item -v, --verbose
@@ -149,6 +158,15 @@ qemu-nbd -c /dev/nbd0 -f qcow2 file.qcow2
 qemu-nbd -d /dev/nbd0
 @end example

+Query a remote server to see details about what export(s) it is
+serving on port 10809, and authenticating via PSK:
+
+@example
+qemu-nbd \
+  --object tls-creds-psk,id=tls0,dir=/tmp/keys,username=eblake,endpoint=client \
+  --tls-creds tls0 -L -b remote.example.com
+@end example
+
 @c man end

 @ignore
diff --git a/qemu-nbd.c b/qemu-nbd.c
index 545a6dfbbc7..4541bbd07d3 100644
--- a/qemu-nbd.c
+++ b/qemu-nbd.c
@@ -76,7 +76,8 @@ static void usage(const char *name)
 {
     (printf) (
 "Usage: %s [OPTIONS] FILE\n"
-"QEMU Disk Network Block Device Server\n"
+"  or:  %s -L [OPTIONS]\n"
+"QEMU Disk Network Block Device Utility\n"
 "\n"
 "  -h, --help                display this help and exit\n"
 "  -V, --version             output version information and exit\n"
@@ -97,6 +98,7 @@ static void usage(const char *name)
 "  -P, --partition=NUM       only expose partition NUM\n"
 "\n"
 "General purpose options:\n"
+"  -L, --list                list exports available from another NBD server\n"
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
@@ -557,13 +660,14 @@ int main(int argc, char **argv)
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

@@ -755,13 +859,32 @@ int main(int argc, char **argv)
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
@@ -780,7 +903,8 @@ int main(int argc, char **argv)
     } else {
         /* Using socket activation - check user didn't use -p etc. */
         const char *err_msg = socket_activation_validate_opts(device, sockpath,
-                                                              bindto, port);
+                                                              bindto, port,
+                                                              list);
         if (err_msg != NULL) {
             error_report("%s", err_msg);
             exit(EXIT_FAILURE);
@@ -803,7 +927,7 @@ int main(int argc, char **argv)
             error_report("TLS is not supported with a host device");
             exit(EXIT_FAILURE);
         }
-        tlscreds = nbd_get_tls_creds(tlscredsid, &local_err);
+        tlscreds = nbd_get_tls_creds(tlscredsid, list, &local_err);
         if (local_err) {
             error_report("Failed to get TLS creds %s",
                          error_get_pretty(local_err));
@@ -811,6 +935,11 @@ int main(int argc, char **argv)
         }
     }

+    if (list) {
+        saddr = nbd_build_socket_address(sockpath, bindto, port);
+        return qemu_nbd_client_list(saddr, tlscreds, bindto);
+    }
+
 #if !HAVE_NBD_DEVICE
     if (disconnect || device) {
         error_report("Kernel /dev/nbdN support not available");
-- 
2.17.2
