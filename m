Received: from eggs.gnu.org ([209.51.188.92]:34030)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gkDUL-0004zx-VK
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 14:38:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gkDUB-0000K0-L0
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 14:38:04 -0500
From: Eric Blake <eblake@redhat.com>
Date: Thu, 17 Jan 2019 13:36:56 -0600
Message-Id: <20190117193658.16413-20-eblake@redhat.com>
In-Reply-To: <20190117193658.16413-1-eblake@redhat.com>
References: <20190117193658.16413-1-eblake@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v4 19/21] qemu-nbd: Add --list option
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: nsoffer@redhat.com, rjones@redhat.com, jsnow@redhat.com, vsementsov@virtuozzo.com, qemu-block@nongnu.org

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
Reviewed-by: Richard W.M. Jones <rjones@redhat.com>

---
v4: a few more per-device options marked incompatible with --list,
doc tweaks [Vladimir]
v3: comment tweak [Rich], rebase to earlier changes
---
 qemu-nbd.texi |  29 ++++++++--
 qemu-nbd.c    | 155 +++++++++++++++++++++++++++++++++++++++++++++-----
 2 files changed, 167 insertions(+), 17 deletions(-)

diff --git a/qemu-nbd.texi b/qemu-nbd.texi
index 3f22559beb4..0d297eed6db 100644
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
@@ -14,6 +16,8 @@ Other uses:
 @itemize
 @item
 Bind a /dev/nbdX block device to a QEMU server (on Linux).
+@item
+As a client to query exports of a remote NBD server.
 @end itemize

 @c man end
@@ -31,13 +35,15 @@ See the @code{qemu(1)} manual page for full details o=
f the properties
 supported. The common object types that it makes sense to define are the
 @code{secret} object, which is used to supply passwords and/or encryptio=
n
 keys, and the @code{tls-creds} object, which is used to supply TLS
-credentials for the qemu-nbd server.
+credentials for the qemu-nbd server or client.
 @item -p, --port=3D@var{port}
-The TCP port to listen on (default @samp{10809}).
+The TCP port to listen on as a server, or connect to as a client
+(default @samp{10809}).
 @item -o, --offset=3D@var{offset}
 The offset into the image.
 @item -b, --bind=3D@var{iface}
-The interface to bind to (default @samp{0.0.0.0}).
+The interface to bind to as a server, or connect to as a client
+(default @samp{0.0.0.0}).
 @item -k, --socket=3D@var{path}
 Use a unix socket with path @var{path}.
 @item --image-opts
@@ -97,10 +103,16 @@ Set the NBD volume export name (default of a zero-le=
ngth string).
 @item -D, --description=3D@var{description}
 Set the NBD volume export description, as a human-readable
 string.
+@item -L, --list
+Connect as a client and list all details about the exports exposed by
+a remote NBD server.  This enables list mode, and is incompatible
+with options that change behavior related to a specific export (such as
+@option{--export-name}, @option{--offset}, ...).
 @item --tls-creds=3DID
 Enable mandatory TLS encryption for the server by setting the ID
 of the TLS credentials object previously created with the --object
-option.
+option; or provide the credentials needed for connecting as a client
+in list mode.
 @item --fork
 Fork off the server process and exit the parent once the server is runni=
ng.
 @item -v, --verbose
@@ -159,6 +171,15 @@ qemu-nbd -c /dev/nbd0 -f qcow2 file.qcow2
 qemu-nbd -d /dev/nbd0
 @end example

+Query a remote server to see details about what export(s) it is
+serving on port 10809, and authenticating via PSK:
+
+@example
+qemu-nbd \
+  --object tls-creds-psk,id=3Dtls0,dir=3D/tmp/keys,username=3Deblake,end=
point=3Dclient \
+  --tls-creds tls0 -L -b remote.example.com
+@end example
+
 @c man end

 @ignore
diff --git a/qemu-nbd.c b/qemu-nbd.c
index 3c538700eae..1f7b2a03f5d 100644
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
@@ -98,6 +99,7 @@ static void usage(const char *name)
 "  -B, --bitmap=3DNAME         expose a persistent dirty bitmap\n"
 "\n"
 "General purpose options:\n"
+"  -L, --list                list exports available from another NBD ser=
ver\n"
 "  --object type,id=3DID,...   define an object such as 'secret' for pro=
viding\n"
 "                            passwords and/or encryption keys\n"
 "  --tls-creds=3DID            use id of an earlier --object to provide =
TLS\n"
@@ -131,7 +133,7 @@ static void usage(const char *name)
 "      --image-opts          treat FILE as a full set of image options\n=
"
 "\n"
 QEMU_HELP_BOTTOM "\n"
-    , name, NBD_DEFAULT_PORT, "DEVICE");
+    , name, name, NBD_DEFAULT_PORT, "DEVICE");
 }

 static void version(const char *name)
@@ -243,6 +245,91 @@ static void termsig_handler(int signum)
 }


+static int qemu_nbd_client_list(SocketAddress *saddr, QCryptoTLSCreds *t=
ls,
+                                const char *hostname)
+{
+    int ret =3D EXIT_FAILURE;
+    int rc;
+    Error *err =3D NULL;
+    QIOChannelSocket *sioc;
+    NBDExportInfo *list;
+    int i, j;
+
+    sioc =3D qio_channel_socket_new();
+    if (qio_channel_socket_connect_sync(sioc, saddr, &err) < 0) {
+        error_report_err(err);
+        return EXIT_FAILURE;
+    }
+    rc =3D nbd_receive_export_list(QIO_CHANNEL(sioc), tls, hostname, &li=
st,
+                                 &err);
+    if (rc < 0) {
+        if (err) {
+            error_report_err(err);
+        }
+        goto out;
+    }
+    printf("exports available: %d\n", rc);
+    for (i =3D 0; i < rc; i++) {
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
+            printf("  available meta contexts: %d\n", list[i].n_contexts=
);
+            for (j =3D 0; j < list[i].n_contexts; j++) {
+                printf("   %s\n", list[i].contexts[j]);
+            }
+        }
+    }
+    nbd_free_export_list(list, rc);
+
+    ret =3D EXIT_SUCCESS;
+ out:
+    object_unref(OBJECT(sioc));
+    return ret;
+}
+
+
 #if HAVE_NBD_DEVICE
 static void *show_parts(void *arg)
 {
@@ -425,7 +512,8 @@ static QemuOptsList qemu_object_opts =3D {



-static QCryptoTLSCreds *nbd_get_tls_creds(const char *id, Error **errp)
+static QCryptoTLSCreds *nbd_get_tls_creds(const char *id, bool list,
+                                          Error **errp)
 {
     Object *obj;
     QCryptoTLSCreds *creds;
@@ -445,10 +533,18 @@ static QCryptoTLSCreds *nbd_get_tls_creds(const cha=
r *id, Error **errp)
         return NULL;
     }

-    if (creds->endpoint !=3D QCRYPTO_TLS_CREDS_ENDPOINT_SERVER) {
-        error_setg(errp,
-                   "Expecting TLS credentials with a server endpoint");
-        return NULL;
+    if (list) {
+        if (creds->endpoint !=3D QCRYPTO_TLS_CREDS_ENDPOINT_CLIENT) {
+            error_setg(errp,
+                       "Expecting TLS credentials with a client endpoint=
");
+            return NULL;
+        }
+    } else {
+        if (creds->endpoint !=3D QCRYPTO_TLS_CREDS_ENDPOINT_SERVER) {
+            error_setg(errp,
+                       "Expecting TLS credentials with a server endpoint=
");
+            return NULL;
+        }
     }
     object_ref(obj);
     return creds;
@@ -471,7 +567,8 @@ static void setup_address_and_port(const char **addre=
ss, const char **port)
 static const char *socket_activation_validate_opts(const char *device,
                                                    const char *sockpath,
                                                    const char *address,
-                                                   const char *port)
+                                                   const char *port,
+                                                   bool list)
 {
     if (device !=3D NULL) {
         return "NBD device can't be set when using socket activation";
@@ -489,6 +586,10 @@ static const char *socket_activation_validate_opts(c=
onst char *device,
         return "TCP port number can't be set when using socket activatio=
n";
     }

+    if (list) {
+        return "List mode is incompatible with socket activation";
+    }
+
     return NULL;
 }

@@ -512,7 +613,7 @@ int main(int argc, char **argv)
     int64_t fd_size;
     QemuOpts *sn_opts =3D NULL;
     const char *sn_id_or_name =3D NULL;
-    const char *sopt =3D "hVb:o:p:rsnP:c:dvk:e:f:tl:x:T:D:B:";
+    const char *sopt =3D "hVb:o:p:rsnP:c:dvk:e:f:tl:x:T:D:B:L";
     struct option lopt[] =3D {
         { "help", no_argument, NULL, 'h' },
         { "version", no_argument, NULL, 'V' },
@@ -525,6 +626,7 @@ int main(int argc, char **argv)
         { "bitmap", required_argument, NULL, 'B' },
         { "connect", required_argument, NULL, 'c' },
         { "disconnect", no_argument, NULL, 'd' },
+        { "list", no_argument, NULL, 'L' },
         { "snapshot", no_argument, NULL, 's' },
         { "load-snapshot", required_argument, NULL, 'l' },
         { "nocache", no_argument, NULL, 'n' },
@@ -559,7 +661,7 @@ int main(int argc, char **argv)
     Error *local_err =3D NULL;
     BlockdevDetectZeroesOptions detect_zeroes =3D BLOCKDEV_DETECT_ZEROES=
_OPTIONS_OFF;
     QDict *options =3D NULL;
-    const char *export_name =3D ""; /* Default export name */
+    const char *export_name =3D NULL; /* defaults to "" later for server=
 mode */
     const char *export_description =3D NULL;
     const char *bitmap =3D NULL;
     const char *tlscredsid =3D NULL;
@@ -567,6 +669,7 @@ int main(int argc, char **argv)
     bool writethrough =3D true;
     char *trace_file =3D NULL;
     bool fork_process =3D false;
+    bool list =3D false;
     int old_stderr =3D -1;
     unsigned socket_activation;

@@ -760,13 +863,33 @@ int main(int argc, char **argv)
         case QEMU_NBD_OPT_FORK:
             fork_process =3D true;
             break;
+        case 'L':
+            list =3D true;
+            break;
         }
     }

-    if ((argc - optind) !=3D 1) {
+    if (list) {
+        if (argc !=3D optind) {
+            error_report("List mode is incompatible with a file name");
+            exit(EXIT_FAILURE);
+        }
+        if (export_name || export_description || dev_offset || partition=
 ||
+            device || disconnect || fmt || sn_id_or_name || bitmap ||
+            seen_aio || seen_discard || seen_cache) {
+            error_report("List mode is incompatible with per-device sett=
ings");
+            exit(EXIT_FAILURE);
+        }
+        if (fork_process) {
+            error_report("List mode is incompatible with forking");
+            exit(EXIT_FAILURE);
+        }
+    } else if ((argc - optind) !=3D 1) {
         error_report("Invalid number of arguments");
         error_printf("Try `%s --help' for more information.\n", argv[0])=
;
         exit(EXIT_FAILURE);
+    } else if (!export_name) {
+        export_name =3D "";
     }

     qemu_opts_foreach(&qemu_object_opts,
@@ -785,7 +908,8 @@ int main(int argc, char **argv)
     } else {
         /* Using socket activation - check user didn't use -p etc. */
         const char *err_msg =3D socket_activation_validate_opts(device, =
sockpath,
-                                                              bindto, po=
rt);
+                                                              bindto, po=
rt,
+                                                              list);
         if (err_msg !=3D NULL) {
             error_report("%s", err_msg);
             exit(EXIT_FAILURE);
@@ -808,7 +932,7 @@ int main(int argc, char **argv)
             error_report("TLS is not supported with a host device");
             exit(EXIT_FAILURE);
         }
-        tlscreds =3D nbd_get_tls_creds(tlscredsid, &local_err);
+        tlscreds =3D nbd_get_tls_creds(tlscredsid, list, &local_err);
         if (local_err) {
             error_report("Failed to get TLS creds %s",
                          error_get_pretty(local_err));
@@ -816,6 +940,11 @@ int main(int argc, char **argv)
         }
     }

+    if (list) {
+        saddr =3D nbd_build_socket_address(sockpath, bindto, port);
+        return qemu_nbd_client_list(saddr, tlscreds, bindto);
+    }
+
 #if !HAVE_NBD_DEVICE
     if (disconnect || device) {
         error_report("Kernel /dev/nbdN support not available");
--=20
2.20.1
