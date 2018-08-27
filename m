Received: from eggs.gnu.org ([2001:4830:134:3::10]:56833)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fuDHA-0005XD-3q
	for qemu-devel@nongnu.org; Mon, 27 Aug 2018 04:53:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fuDH6-0004l5-9X
	for qemu-devel@nongnu.org; Mon, 27 Aug 2018 04:53:31 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:53456 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1fuDH5-0004kM-T2
	for qemu-devel@nongnu.org; Mon, 27 Aug 2018 04:53:28 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 7DDD820E19
	for <qemu-devel@nongnu.org>; Mon, 27 Aug 2018 08:53:27 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Mon, 27 Aug 2018 10:53:14 +0200
Message-Id: <20180827085320.9732-7-kraxel@redhat.com>
In-Reply-To: <20180827085320.9732-1-kraxel@redhat.com>
References: <20180827085320.9732-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 06/12] vnc: remove support for deprecated tls,
 x509, x509verify options
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: libvir-list@redhat.com, Gerd Hoffmann <kraxel@redhat.com>, =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>

From: Daniel P. Berrang=C3=A9 <berrange@redhat.com>

The 'tls-creds' option accepts the name of a TLS credentials
object. This replaced the usage of 'tls', 'x509' and 'x509verify'
options in 2.5.0. These deprecated options were grandfathered in
when the deprecation policy was introduded in 2.10.0, so can now
finally be removed.

Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
Message-id: 20180725092751.21767-3-berrange@redhat.com
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 ui/vnc.c             | 91 ----------------------------------------------=
------
 qemu-deprecated.texi | 20 ------------
 qemu-options.hx      | 43 -------------------------
 3 files changed, 154 deletions(-)

diff --git a/ui/vnc.c b/ui/vnc.c
index 359693238b..fd929b0957 100644
--- a/ui/vnc.c
+++ b/ui/vnc.c
@@ -3345,10 +3345,6 @@ static QemuOptsList qemu_vnc_opts =3D {
             .name =3D "tls-creds",
             .type =3D QEMU_OPT_STRING,
         },{
-            /* Deprecated in favour of tls-creds */
-            .name =3D "x509",
-            .type =3D QEMU_OPT_STRING,
-        },{
             .name =3D "share",
             .type =3D QEMU_OPT_STRING,
         },{
@@ -3385,14 +3381,6 @@ static QemuOptsList qemu_vnc_opts =3D {
             .name =3D "sasl",
             .type =3D QEMU_OPT_BOOL,
         },{
-            /* Deprecated in favour of tls-creds */
-            .name =3D "tls",
-            .type =3D QEMU_OPT_BOOL,
-        },{
-            /* Deprecated in favour of tls-creds */
-            .name =3D "x509verify",
-            .type =3D QEMU_OPT_STRING,
-        },{
             .name =3D "acl",
             .type =3D QEMU_OPT_BOOL,
         },{
@@ -3519,51 +3507,6 @@ vnc_display_setup_auth(int *auth,
 }
=20
=20
-/*
- * Handle back compat with old CLI syntax by creating some
- * suitable QCryptoTLSCreds objects
- */
-static QCryptoTLSCreds *
-vnc_display_create_creds(bool x509,
-                         bool x509verify,
-                         const char *dir,
-                         const char *id,
-                         Error **errp)
-{
-    gchar *credsid =3D g_strdup_printf("tlsvnc%s", id);
-    Object *parent =3D object_get_objects_root();
-    Object *creds;
-    Error *err =3D NULL;
-
-    if (x509) {
-        creds =3D object_new_with_props(TYPE_QCRYPTO_TLS_CREDS_X509,
-                                      parent,
-                                      credsid,
-                                      &err,
-                                      "endpoint", "server",
-                                      "dir", dir,
-                                      "verify-peer", x509verify ? "yes" =
: "no",
-                                      NULL);
-    } else {
-        creds =3D object_new_with_props(TYPE_QCRYPTO_TLS_CREDS_ANON,
-                                      parent,
-                                      credsid,
-                                      &err,
-                                      "endpoint", "server",
-                                      NULL);
-    }
-
-    g_free(credsid);
-
-    if (err) {
-        error_propagate(errp, err);
-        return NULL;
-    }
-
-    return QCRYPTO_TLS_CREDS(creds);
-}
-
-
 static int vnc_display_get_address(const char *addrstr,
                                    bool websocket,
                                    bool reverse,
@@ -3930,15 +3873,6 @@ void vnc_display_open(const char *id, Error **errp=
)
     credid =3D qemu_opt_get(opts, "tls-creds");
     if (credid) {
         Object *creds;
-        if (qemu_opt_get(opts, "tls") ||
-            qemu_opt_get(opts, "x509") ||
-            qemu_opt_get(opts, "x509verify")) {
-            error_setg(errp,
-                       "'tls-creds' parameter is mutually exclusive with=
 "
-                       "'tls', 'x509' and 'x509verify' parameters");
-            goto fail;
-        }
-
         creds =3D object_resolve_path_component(
             object_get_objects_root(), credid);
         if (!creds) {
@@ -3961,31 +3895,6 @@ void vnc_display_open(const char *id, Error **errp=
)
                        "Expecting TLS credentials with a server endpoint=
");
             goto fail;
         }
-    } else {
-        const char *path;
-        bool tls =3D false, x509 =3D false, x509verify =3D false;
-        tls  =3D qemu_opt_get_bool(opts, "tls", false);
-        if (tls) {
-            path =3D qemu_opt_get(opts, "x509");
-
-            if (path) {
-                x509 =3D true;
-            } else {
-                path =3D qemu_opt_get(opts, "x509verify");
-                if (path) {
-                    x509 =3D true;
-                    x509verify =3D true;
-                }
-            }
-            vd->tlscreds =3D vnc_display_create_creds(x509,
-                                                    x509verify,
-                                                    path,
-                                                    vd->id,
-                                                    errp);
-            if (!vd->tlscreds) {
-                goto fail;
-            }
-        }
     }
     acl =3D qemu_opt_get_bool(opts, "acl", false);
=20
diff --git a/qemu-deprecated.texi b/qemu-deprecated.texi
index 87212b62f2..1b9c007f12 100644
--- a/qemu-deprecated.texi
+++ b/qemu-deprecated.texi
@@ -40,26 +40,6 @@ which is the default.
 The ``-no-kvm'' argument is now a synonym for setting
 ``-machine accel=3Dtcg''.
=20
-@subsection -vnc tls (since 2.5.0)
-
-The ``-vnc tls'' argument is now a synonym for setting
-``-object tls-creds-anon,id=3Dtls0'' combined with
-``-vnc tls-creds=3Dtls0'
-
-@subsection -vnc x509 (since 2.5.0)
-
-The ``-vnc x509=3D/path/to/certs'' argument is now a
-synonym for setting
-``-object tls-creds-x509,dir=3D/path/to/certs,id=3Dtls0,verify-peer=3Dno=
''
-combined with ``-vnc tls-creds=3Dtls0'
-
-@subsection -vnc x509verify (since 2.5.0)
-
-The ``-vnc x509verify=3D/path/to/certs'' argument is now a
-synonym for setting
-``-object tls-creds-x509,dir=3D/path/to/certs,id=3Dtls0,verify-peer=3Dye=
s''
-combined with ``-vnc tls-creds=3Dtls0'
-
 @subsection -tftp (since 2.6.0)
=20
 The ``-tftp /some/dir'' argument is replaced by either
diff --git a/qemu-options.hx b/qemu-options.hx
index 5515dfaba5..2417154a70 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -1632,49 +1632,6 @@ will cause the VNC server socket to enable the VeN=
Crypt auth
 mechanism.  The credentials should have been previously created
 using the @option{-object tls-creds} argument.
=20
-The @option{tls-creds} parameter obsoletes the @option{tls},
-@option{x509}, and @option{x509verify} options, and as such
-it is not permitted to set both new and old type options at
-the same time.
-
-@item tls
-
-Require that client use TLS when communicating with the VNC server. This
-uses anonymous TLS credentials so is susceptible to a man-in-the-middle
-attack. It is recommended that this option be combined with either the
-@option{x509} or @option{x509verify} options.
-
-This option is now deprecated in favor of using the @option{tls-creds}
-argument.
-
-@item x509=3D@var{/path/to/certificate/dir}
-
-Valid if @option{tls} is specified. Require that x509 credentials are us=
ed
-for negotiating the TLS session. The server will send its x509 certifica=
te
-to the client. It is recommended that a password be set on the VNC serve=
r
-to provide authentication of the client when this is used. The path foll=
owing
-this option specifies where the x509 certificates are to be loaded from.
-See the @ref{vnc_security} section for details on generating certificate=
s.
-
-This option is now deprecated in favour of using the @option{tls-creds}
-argument.
-
-@item x509verify=3D@var{/path/to/certificate/dir}
-
-Valid if @option{tls} is specified. Require that x509 credentials are us=
ed
-for negotiating the TLS session. The server will send its x509 certifica=
te
-to the client, and request that the client send its own x509 certificate=
.
-The server will validate the client's certificate against the CA certifi=
cate,
-and reject clients when validation fails. If the certificate authority i=
s
-trusted, this is a sufficient authentication mechanism. You may still wi=
sh
-to set a password on the VNC server as a second authentication layer. Th=
e
-path following this option specifies where the x509 certificates are to
-be loaded from. See the @ref{vnc_security} section for details on genera=
ting
-certificates.
-
-This option is now deprecated in favour of using the @option{tls-creds}
-argument.
-
 @item sasl
=20
 Require that the client use SASL to authenticate with the VNC server.
--=20
2.9.3
