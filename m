Return-Path: <SRS0=mdN/=VA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DBA7C5B578
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2019 22:48:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 33EF921882
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2019 22:48:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 33EF921882
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41684 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hio3H-0003AU-Er
	for qemu-devel@archiver.kernel.org; Wed, 03 Jul 2019 18:48:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54654)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <eblake@redhat.com>) id 1hio2K-0002iL-5E
 for qemu-devel@nongnu.org; Wed, 03 Jul 2019 18:47:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1hio2D-0003qs-Gb
 for qemu-devel@nongnu.org; Wed, 03 Jul 2019 18:47:35 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45576)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>)
 id 1hio27-0003ki-Gn; Wed, 03 Jul 2019 18:47:23 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 01533308424C;
 Wed,  3 Jul 2019 22:47:21 +0000 (UTC)
Received: from blue.redhat.com (ovpn-116-152.phx2.redhat.com [10.3.116.152])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3C3F8891A4;
 Wed,  3 Jul 2019 22:47:15 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Date: Wed,  3 Jul 2019 17:47:07 -0500
Message-Id: <20190703224707.12437-1-eblake@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.40]); Wed, 03 Jul 2019 22:47:22 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v2 RFC] qemu-nbd: Permit TLS with Unix sockets
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Kevin Wolf <kwolf@redhat.com>, berrange@redhat.com,
 "open list:Network Block Dev..." <qemu-block@nongnu.org>,
 Markus Armbruster <armbru@redhat.com>, rjones@redhat.com,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Although you generally won't use encryption with a Unix socket (after
all, everything is local, so why waste the CPU power), there are
situations in testsuites where Unix sockets are much nicer than TCP
sockets.  Since nbdkit allows encryption over both types of sockets,
it makes sense for qemu-nbd to do likewise.

The restriction has been present since its introduction in commits
145614a1 and 75822a12 (v2.6), where the former documented the
limitation but did not provide any additional explanation why it was
added; but looking closer, it seems the most likely reason is that
x509 verification requires a hostname. But we can do the same as
migration did, and add a tls-hostname parameter to supply that
information.

Signed-off-by: Eric Blake <eblake@redhat.com>

---

Since this is now adding a new qemu-nbd command-line option, as well
as new QMP for blockdev-add, it has missed 4.1 softfreeze and should
probably be delayed to 4.2.

RFC: The test is racy - it sometimes passes, and sometimes fails with:

 =3D=3D check TLS with authorization over Unix =3D=3D
 qemu-img: Could not open 'driver=3Dnbd,path=3DSOCKET,tls-creds=3Dtls0,tl=
s-hostname=3Dlocalhost': Failed to read option reply: Cannot read from TL=
S channel: Input/output error
-qemu-img: Could not open 'driver=3Dnbd,path=3DSOCKET,tls-creds=3Dtls0,tl=
s-hostname=3Dlocalhost': Failed to read option reply: Cannot read from TL=
S channel: Input/output error
+qemu-img: Could not open 'driver=3Dnbd,path=3DSOCKET,tls-creds=3Dtls0,tl=
s-hostname=3Dlocalhost': Failed to read option reply: Cannot read from TL=
S channel: Software caused connection abort

I suspect that there is a bug in the qio TLS channel code when it
comes to handling a failed TLS handshake, which results in the racy
output. I'll need help solving that first.  It might also be nice if
we had a bit more visibility into the gnutls error message when TLS
handshake fails.
---
 qemu-nbd.texi              |  3 ++
 qapi/block-core.json       |  5 ++
 block/nbd.c                | 27 +++++++++--
 qemu-nbd.c                 | 26 ++++++++---
 tests/qemu-iotests/233     | 94 ++++++++++++++++++++++++++++++++++++--
 tests/qemu-iotests/233.out | 61 +++++++++++++++++++++++--
 tests/qemu-iotests/group   |  2 +-
 7 files changed, 198 insertions(+), 20 deletions(-)

diff --git a/qemu-nbd.texi b/qemu-nbd.texi
index 7f55657722bd..764518baef84 100644
--- a/qemu-nbd.texi
+++ b/qemu-nbd.texi
@@ -123,6 +123,9 @@ Store the server's process ID in the given file.
 Specify the ID of a qauthz object previously created with the
 --object option. This will be used to authorize connecting users
 against their x509 distinguished name.
+@item --tls-hostname=3DNAME
+When using list mode with TLS over a Unix socket, supply the hostname
+to use during validation of the server's x509 certificate.
 @item -v, --verbose
 Display extra debugging information.
 @item -h, --help
diff --git a/qapi/block-core.json b/qapi/block-core.json
index 0d43d4f37c1a..95da0d44c220 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -3856,6 +3856,10 @@
 #
 # @tls-creds:   TLS credentials ID
 #
+# @tls-hostname: Hostname of the server, required only when using x509 b=
ased
+#                TLS credentials when @server lacks a hostname (such as
+#                using a Unix socket). (Since 4.1)
+#
 # @x-dirty-bitmap: A "qemu:dirty-bitmap:NAME" string to query in place o=
f
 #                  traditional "base:allocation" block status (see
 #                  NBD_OPT_LIST_META_CONTEXT in the NBD protocol) (since=
 3.0)
@@ -3866,6 +3870,7 @@
   'data': { 'server': 'SocketAddress',
             '*export': 'str',
             '*tls-creds': 'str',
+            '*tls-hostname': 'str',
             '*x-dirty-bitmap': 'str' } }

 ##
diff --git a/block/nbd.c b/block/nbd.c
index 81edabbf35ed..ce3db21190ce 100644
--- a/block/nbd.c
+++ b/block/nbd.c
@@ -1577,6 +1577,11 @@ static QemuOptsList nbd_runtime_opts =3D {
             .type =3D QEMU_OPT_STRING,
             .help =3D "ID of the TLS credentials to use",
         },
+        {
+            .name =3D "tls-hostname",
+            .type =3D QEMU_OPT_STRING,
+            .help =3D "hostname for x509 TLS credentials of target host"=
,
+        },
         {
             .name =3D "x-dirty-bitmap",
             .type =3D QEMU_OPT_STRING,
@@ -1624,12 +1629,25 @@ static int nbd_open(BlockDriverState *bs, QDict *=
options, int flags,
             goto error;
         }

-        /* TODO SOCKET_ADDRESS_KIND_FD where fd has AF_INET or AF_INET6 =
*/
-        if (s->saddr->type !=3D SOCKET_ADDRESS_TYPE_INET) {
-            error_setg(errp, "TLS only supported over IP sockets");
+        switch (s->saddr->type) {
+        case SOCKET_ADDRESS_TYPE_INET:
+            hostname =3D s->saddr->u.inet.host;
+            if (qemu_opt_get(opts, "tls-hostname")) {
+                error_setg(errp, "tls-hostname not required with inet so=
cket");
+                goto error;
+            }
+            break;
+        case SOCKET_ADDRESS_TYPE_UNIX:
+            hostname =3D qemu_opt_get(opts, "tls-hostname");
+            break;
+        default:
+            /* TODO SOCKET_ADDRESS_KIND_FD where fd has AF_INET or AF_IN=
ET6 */
+            error_setg(errp, "TLS only supported over IP or Unix sockets=
");
             goto error;
         }
-        hostname =3D s->saddr->u.inet.host;
+    } else if (qemu_opt_get(opts, "tls-hostname")) {
+        error_setg(errp, "tls-hostname not supported without tls-creds")=
;
+        goto error;
     }

     /* NBD handshake */
@@ -1752,6 +1770,7 @@ static const char *const nbd_strong_runtime_opts[] =
=3D {
     "port",
     "export",
     "tls-creds",
+    "tls-hostname",
     "server.",

     NULL
diff --git a/qemu-nbd.c b/qemu-nbd.c
index a8cb39e51043..40ea1e299dc7 100644
--- a/qemu-nbd.c
+++ b/qemu-nbd.c
@@ -62,6 +62,7 @@
 #define QEMU_NBD_OPT_FORK          263
 #define QEMU_NBD_OPT_TLSAUTHZ      264
 #define QEMU_NBD_OPT_PID_FILE      265
+#define QEMU_NBD_OPT_TLSHOST       266

 #define MBR_SIZE 512

@@ -76,6 +77,7 @@ static int nb_fds;
 static QIONetListener *server;
 static QCryptoTLSCreds *tlscreds;
 static const char *tlsauthz;
+static const char *tlshost;

 static void usage(const char *name)
 {
@@ -640,6 +642,7 @@ int main(int argc, char **argv)
         { "description", required_argument, NULL, 'D' },
         { "tls-creds", required_argument, NULL, QEMU_NBD_OPT_TLSCREDS },
         { "tls-authz", required_argument, NULL, QEMU_NBD_OPT_TLSAUTHZ },
+        { "tls-hostname", required_argument, NULL, QEMU_NBD_OPT_TLSHOST =
},
         { "image-opts", no_argument, NULL, QEMU_NBD_OPT_IMAGE_OPTS },
         { "trace", required_argument, NULL, 'T' },
         { "fork", no_argument, NULL, QEMU_NBD_OPT_FORK },
@@ -864,6 +867,9 @@ int main(int argc, char **argv)
         case QEMU_NBD_OPT_TLSAUTHZ:
             tlsauthz =3D optarg;
             break;
+        case QEMU_NBD_OPT_TLSHOST:
+            tlshost =3D optarg;
+            break;
         case QEMU_NBD_OPT_FORK:
             fork_process =3D true;
             break;
@@ -931,18 +937,22 @@ int main(int argc, char **argv)
     }

     if (tlscredsid) {
-        if (sockpath) {
-            error_report("TLS is only supported with IPv4/IPv6");
-            exit(EXIT_FAILURE);
-        }
         if (device) {
             error_report("TLS is not supported with a host device");
             exit(EXIT_FAILURE);
         }
         if (tlsauthz && list) {
-            error_report("TLS authorization is incompatible with export =
list");
+            error_report("TLS authorization is incompatible with --list"=
);
             exit(EXIT_FAILURE);
         }
+        if (tlshost) {
+            if (!list) {
+                error_report("TLS hostname is only for use with --list")=
;
+                exit(EXIT_FAILURE);
+            }
+        } else {
+            tlshost =3D bindto;
+        }
         tlscreds =3D nbd_get_tls_creds(tlscredsid, list, &local_err);
         if (local_err) {
             error_report("Failed to get TLS creds %s",
@@ -954,11 +964,15 @@ int main(int argc, char **argv)
             error_report("--tls-authz is not permitted without --tls-cre=
ds");
             exit(EXIT_FAILURE);
         }
+        if (tlshost) {
+            error_report("--tls-hostname is not permitted without --tls-=
creds");
+            exit(EXIT_FAILURE);
+        }
     }

     if (list) {
         saddr =3D nbd_build_socket_address(sockpath, bindto, port);
-        return qemu_nbd_client_list(saddr, tlscreds, bindto);
+        return qemu_nbd_client_list(saddr, tlscreds, tlshost);
     }

 #if !HAVE_NBD_DEVICE
diff --git a/tests/qemu-iotests/233 b/tests/qemu-iotests/233
index a5c17c39639d..1891a3a65084 100755
--- a/tests/qemu-iotests/233
+++ b/tests/qemu-iotests/233
@@ -30,7 +30,7 @@ _cleanup()
 {
     nbd_server_stop
     _cleanup_test_img
-    # If we aborted early we want to see this log for diagnosis
+    # If we aborted early we want to see these logs for diagnosis
     test -f "$TEST_DIR/server.log" && cat "$TEST_DIR/server.log"
     rm -f "$TEST_DIR/server.log"
     tls_x509_cleanup
@@ -67,7 +67,7 @@ _make_test_img 64M
 $QEMU_IO -c 'w -P 0x11 1m 1m' "$TEST_IMG" | _filter_qemu_io

 echo
-echo "=3D=3D check TLS client to plain server fails =3D=3D"
+echo "=3D=3D check TLS client to plain TCP server fails =3D=3D"
 nbd_server_start_tcp_socket -f $IMGFMT "$TEST_IMG" 2> "$TEST_DIR/server.=
log"

 obj=3Dtls-creds-x509,dir=3D${tls_dir}/client1,endpoint=3Dclient,id=3Dtls=
0
@@ -80,7 +80,7 @@ $QEMU_NBD_PROG -L -b $nbd_tcp_addr -p $nbd_tcp_port --o=
bject $obj \
 nbd_server_stop

 echo
-echo "=3D=3D check plain client to TLS server fails =3D=3D"
+echo "=3D=3D check plain client to TLS TCP server fails =3D=3D"

 nbd_server_start_tcp_socket \
     --object tls-creds-x509,dir=3D${tls_dir}/server1,endpoint=3Dserver,i=
d=3Dtls0,verify-peer=3Dyes \
@@ -91,7 +91,7 @@ $QEMU_IMG info nbd://localhost:$nbd_tcp_port 2>&1 | sed=
 "s/$nbd_tcp_port/PORT/g"
 $QEMU_NBD_PROG -L -b $nbd_tcp_addr -p $nbd_tcp_port

 echo
-echo "=3D=3D check TLS works =3D=3D"
+echo "=3D=3D check TLS works over TCP =3D=3D"
 obj1=3Dtls-creds-x509,dir=3D${tls_dir}/client1,endpoint=3Dclient,id=3Dtl=
s0
 obj2=3Dtls-creds-x509,dir=3D${tls_dir}/client3,endpoint=3Dclient,id=3Dtl=
s0
 $QEMU_IMG info --image-opts --object $obj1 \
@@ -123,7 +123,7 @@ $QEMU_IO -c 'r -P 0x11 1m 1m' -c 'w -P 0x22 1m 1m' --=
image-opts \
 $QEMU_IO -f $IMGFMT -r -U -c 'r -P 0x22 1m 1m' "$TEST_IMG" | _filter_qem=
u_io

 echo
-echo "=3D=3D check TLS with authorization =3D=3D"
+echo "=3D=3D check TLS with authorization over TCP =3D=3D"

 nbd_server_stop

@@ -145,6 +145,90 @@ $QEMU_IMG info --image-opts \
     driver=3Dnbd,host=3D$nbd_tcp_addr,port=3D$nbd_tcp_port,tls-creds=3Dt=
ls0 \
     2>&1 | sed "s/$nbd_tcp_port/PORT/g"

+nbd_server_stop
+
+echo
+echo "=3D=3D check TLS client to plain Unix server fails =3D=3D"
+nbd_server_start_unix_socket -f $IMGFMT "$TEST_IMG" 2>> "$TEST_DIR/serve=
r.log"
+
+obj=3Dtls-creds-x509,dir=3D${tls_dir}/client1,endpoint=3Dclient,id=3Dtls=
0
+$QEMU_IMG info --image-opts --object $obj \
+    driver=3Dnbd,path=3D$nbd_unix_socket,tls-creds=3Dtls0,tls-hostname=3D=
localhost \
+    2>&1 | sed "s,$nbd_unix_socket,SOCKET,g"
+$QEMU_NBD_PROG -L -k $nbd_unix_socket --object $obj --tls-creds=3Dtls0
+
+nbd_server_stop
+
+echo
+echo "=3D=3D check plain client to TLS Unix server fails =3D=3D"
+
+nbd_server_start_unix_socket \
+    --object tls-creds-x509,dir=3D${tls_dir}/server1,endpoint=3Dserver,i=
d=3Dtls0,verify-peer=3Dyes \
+    --tls-creds tls0 \
+    -f $IMGFMT "$TEST_IMG" 2>> "$TEST_DIR/server.log"
+
+$QEMU_IMG info nbd+unix://\?socket=3D$nbd_unix_socket \
+    2>&1 | sed "s,$nbd_unix_socket,SOCKET,g"
+$QEMU_NBD_PROG -L -k $nbd_unix_socket
+
+echo
+echo "=3D=3D check TLS works over Unix =3D=3D"
+obj1=3Dtls-creds-x509,dir=3D${tls_dir}/client1,endpoint=3Dclient,id=3Dtl=
s0
+obj2=3Dtls-creds-x509,dir=3D${tls_dir}/client3,endpoint=3Dclient,id=3Dtl=
s0
+$QEMU_IMG info --image-opts --object $obj1 \
+    driver=3Dnbd,path=3D$nbd_unix_socket,tls-creds=3Dtls0 \
+    2>&1 | sed "s,$nbd_unix_socket,SOCKET,g"
+$QEMU_IMG info --image-opts --object $obj2 \
+    driver=3Dnbd,path=3D$nbd_unix_socket,tls-creds=3Dtls0,tls-hostname=3D=
localhost \
+    2>&1 | sed "s,$nbd_unix_socket,SOCKET,g"
+$QEMU_NBD_PROG -L -k $nbd_unix_socket --object $obj1 --tls-creds=3Dtls0
+$QEMU_NBD_PROG -L -k $nbd_unix_socket --object $obj1 --tls-creds=3Dtls0 =
\
+    --tls-hostname=3Dlocalhost
+
+echo
+echo "=3D=3D check TLS with different CA fails =3D=3D"
+obj=3Dtls-creds-x509,dir=3D${tls_dir}/client2,endpoint=3Dclient,id=3Dtls=
0
+$QEMU_IMG info --image-opts --object $obj \
+    driver=3Dnbd,path=3D$nbd_unix_socket,tls-creds=3Dtls0,tls-hostname=3D=
localhost \
+    2>&1 | sed "s,$nbd_unix_socket,SOCKET,g"
+$QEMU_NBD_PROG -L -k $nbd_unix_socket --object $obj \
+    --tls-creds=3Dtls0 --tls-hostname=3Dlocalhost
+
+echo
+echo "=3D=3D perform I/O over TLS =3D=3D"
+QEMU_IO_OPTIONS=3D$QEMU_IO_OPTIONS_NO_FMT
+$QEMU_IO -c 'r -P 0x22 1m 1m' -c 'w -P 0x33 1m 1m' --image-opts \
+    --object tls-creds-x509,dir=3D${tls_dir}/client1,endpoint=3Dclient,i=
d=3Dtls0 \
+    driver=3Dnbd,path=3D$nbd_unix_socket,tls-creds=3Dtls0,tls-hostname=3D=
localhost \
+    2>&1 | _filter_qemu_io
+
+$QEMU_IO -f $IMGFMT -r -U -c 'r -P 0x33 1m 1m' "$TEST_IMG" | _filter_qem=
u_io
+
+echo
+echo "=3D=3D check TLS with authorization over Unix =3D=3D"
+
+nbd_server_stop
+
+nbd_server_start_unix_socket \
+    --object tls-creds-x509,dir=3D${tls_dir}/server1,endpoint=3Dserver,i=
d=3Dtls0,verify-peer=3Dyes \
+    --object "authz-simple,id=3Dauthz0,identity=3DCN=3Dlocalhost,, \
+      O=3DCthulu Dark Lord Enterprises client1,,L=3DR'lyeh,,C=3DSouth Pa=
cific" \
+    --tls-authz authz0 \
+    --tls-creds tls0 \
+    -f $IMGFMT "$TEST_IMG" 2>> "$TEST_DIR/server.log"
+
+$QEMU_IMG info --image-opts \
+    --object tls-creds-x509,dir=3D${tls_dir}/client1,endpoint=3Dclient,i=
d=3Dtls0 \
+    driver=3Dnbd,path=3D$nbd_unix_socket,tls-creds=3Dtls0,tls-hostname=3D=
localhost \
+    2>&1 | sed "s,$nbd_unix_socket,SOCKET,g"
+
+$QEMU_IMG info --image-opts \
+    --object tls-creds-x509,dir=3D${tls_dir}/client3,endpoint=3Dclient,i=
d=3Dtls0 \
+    driver=3Dnbd,path=3D$nbd_unix_socket,tls-creds=3Dtls0,tls-hostname=3D=
localhost \
+    2>&1 | sed "s,$nbd_unix_socket,SOCKET,g"
+
+nbd_server_stop
+
 echo
 echo "=3D=3D final server log =3D=3D"
 cat "$TEST_DIR/server.log"
diff --git a/tests/qemu-iotests/233.out b/tests/qemu-iotests/233.out
index 9b46284ab0de..b86bee020649 100644
--- a/tests/qemu-iotests/233.out
+++ b/tests/qemu-iotests/233.out
@@ -13,19 +13,19 @@ Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D6=
7108864
 wrote 1048576/1048576 bytes at offset 1048576
 1 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)

-=3D=3D check TLS client to plain server fails =3D=3D
+=3D=3D check TLS client to plain TCP server fails =3D=3D
 qemu-img: Could not open 'driver=3Dnbd,host=3D127.0.0.1,port=3DPORT,tls-=
creds=3Dtls0': Denied by server for option 5 (starttls)
 server reported: TLS not configured
 qemu-nbd: Denied by server for option 5 (starttls)
 server reported: TLS not configured

-=3D=3D check plain client to TLS server fails =3D=3D
+=3D=3D check plain client to TLS TCP server fails =3D=3D
 qemu-img: Could not open 'nbd://localhost:PORT': TLS negotiation require=
d before option 8 (structured reply)
 server reported: Option 0x8 not permitted before TLS
 qemu-nbd: TLS negotiation required before option 8 (structured reply)
 server reported: Option 0x8 not permitted before TLS

-=3D=3D check TLS works =3D=3D
+=3D=3D check TLS works over TCP =3D=3D
 image: nbd://127.0.0.1:PORT
 file format: nbd
 virtual size: 64 MiB (67108864 bytes)
@@ -56,13 +56,66 @@ wrote 1048576/1048576 bytes at offset 1048576
 read 1048576/1048576 bytes at offset 1048576
 1 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)

-=3D=3D check TLS with authorization =3D=3D
+=3D=3D check TLS with authorization over TCP =3D=3D
 qemu-img: Could not open 'driver=3Dnbd,host=3D127.0.0.1,port=3DPORT,tls-=
creds=3Dtls0': Failed to read option reply: Cannot read from TLS channel:=
 Software caused connection abort
 qemu-img: Could not open 'driver=3Dnbd,host=3D127.0.0.1,port=3DPORT,tls-=
creds=3Dtls0': Failed to read option reply: Cannot read from TLS channel:=
 Software caused connection abort

+=3D=3D check TLS client to plain Unix server fails =3D=3D
+qemu-img: Could not open 'driver=3Dnbd,path=3DSOCKET,tls-creds=3Dtls0,tl=
s-hostname=3Dlocalhost': Denied by server for option 5 (starttls)
+server reported: TLS not configured
+qemu-nbd: Denied by server for option 5 (starttls)
+server reported: TLS not configured
+
+=3D=3D check plain client to TLS Unix server fails =3D=3D
+qemu-img: Could not open 'nbd+unix://?socket=3DSOCKET': TLS negotiation =
required before option 8 (structured reply)
+server reported: Option 0x8 not permitted before TLS
+qemu-nbd: TLS negotiation required before option 8 (structured reply)
+server reported: Option 0x8 not permitted before TLS
+
+=3D=3D check TLS works over Unix =3D=3D
+image: nbd+unix://?socket=3DSOCKET
+file format: nbd
+virtual size: 64 MiB (67108864 bytes)
+disk size: unavailable
+image: nbd+unix://?socket=3DSOCKET
+file format: nbd
+virtual size: 64 MiB (67108864 bytes)
+disk size: unavailable
+qemu-nbd: Certificate does not match the hostname 0.0.0.0
+exports available: 1
+ export: ''
+  size:  67108864
+  flags: 0x4ed ( flush fua trim zeroes df cache )
+  min block: 1
+  opt block: 4096
+  max block: 33554432
+  available meta contexts: 1
+   base:allocation
+
+=3D=3D check TLS with different CA fails =3D=3D
+qemu-img: Could not open 'driver=3Dnbd,path=3DSOCKET,tls-creds=3Dtls0,tl=
s-hostname=3Dlocalhost': The certificate hasn't got a known issuer
+qemu-nbd: The certificate hasn't got a known issuer
+
+=3D=3D perform I/O over TLS =3D=3D
+read 1048576/1048576 bytes at offset 1048576
+1 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 1048576/1048576 bytes at offset 1048576
+1 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+read 1048576/1048576 bytes at offset 1048576
+1 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+
+=3D=3D check TLS with authorization over Unix =3D=3D
+qemu-img: Could not open 'driver=3Dnbd,path=3DSOCKET,tls-creds=3Dtls0,tl=
s-hostname=3Dlocalhost': Failed to read option reply: Cannot read from TL=
S channel: Input/output error
+qemu-img: Could not open 'driver=3Dnbd,path=3DSOCKET,tls-creds=3Dtls0,tl=
s-hostname=3Dlocalhost': Failed to read option reply: Cannot read from TL=
S channel: Input/output error
+
 =3D=3D final server log =3D=3D
 qemu-nbd: option negotiation failed: Verify failed: No certificate was f=
ound.
 qemu-nbd: option negotiation failed: Verify failed: No certificate was f=
ound.
 qemu-nbd: option negotiation failed: TLS x509 authz check for CN=3Dlocal=
host,O=3DCthulhu Dark Lord Enterprises client1,L=3DR'lyeh,C=3DSouth Pacif=
ic is denied
 qemu-nbd: option negotiation failed: TLS x509 authz check for CN=3Dlocal=
host,O=3DCthulhu Dark Lord Enterprises client3,L=3DR'lyeh,C=3DSouth Pacif=
ic is denied
+qemu-nbd: option negotiation failed: Failed to read opts magic: Cannot r=
ead from TLS channel: Software caused connection abort
+qemu-nbd: option negotiation failed: Verify failed: No certificate was f=
ound.
+qemu-nbd: option negotiation failed: Verify failed: No certificate was f=
ound.
+qemu-nbd: option negotiation failed: TLS x509 authz check for CN=3Dlocal=
host,O=3DCthulhu Dark Lord Enterprises client1,L=3DR'lyeh,C=3DSouth Pacif=
ic is denied
+qemu-nbd: option negotiation failed: TLS x509 authz check for CN=3Dlocal=
host,O=3DCthulhu Dark Lord Enterprises client3,L=3DR'lyeh,C=3DSouth Pacif=
ic is denied
 *** done
diff --git a/tests/qemu-iotests/group b/tests/qemu-iotests/group
index b34c8e3c0c6d..7d02363f14bd 100644
--- a/tests/qemu-iotests/group
+++ b/tests/qemu-iotests/group
@@ -245,7 +245,7 @@
 229 auto quick
 231 auto quick
 232 quick
-233 auto quick
+233 auto
 234 quick migration
 235 quick
 236 quick
--=20
2.20.1


