Received: from eggs.gnu.org ([209.51.188.92]:45030)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gz0f2-0005YK-9V
	for qemu-devel@nongnu.org; Wed, 27 Feb 2019 09:58:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gz0f0-0006zZ-Qd
	for qemu-devel@nongnu.org; Wed, 27 Feb 2019 09:58:16 -0500
Received: from mx1.redhat.com ([209.132.183.28]:33458)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1gz0f0-0006zD-Hk
	for qemu-devel@nongnu.org; Wed, 27 Feb 2019 09:58:14 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id BD45578EA4
	for <qemu-devel@nongnu.org>; Wed, 27 Feb 2019 14:58:13 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Date: Wed, 27 Feb 2019 14:57:54 +0000
Message-Id: <20190227145755.26556-2-berrange@redhat.com>
In-Reply-To: <20190227145755.26556-1-berrange@redhat.com>
References: <20190227145755.26556-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 1/2] vnc: allow specifying a custom
 authorization object name
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, libvir-list@redhat.com, Gerd Hoffmann <kraxel@redhat.com>, Markus Armbruster <armbru@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>, Juan Quintela <quintela@redhat.com>

From: "Daniel P. Berrange" <berrange@redhat.com>

The VNC server has historically had support for ACLs to check both the
SASL username and the TLS x509 distinguished name. The VNC server was
responsible for creating the initial ACL, and the client app was then
responsible for populating it with rules using the HMP 'acl_add' command.

This is not satisfactory for a variety of reasons. There is no way to
populate the ACLs from the command line, users are forced to use the
HMP. With multiple network services all supporting TLS and ACLs now, it
is desirable to be able to define a single ACL that is referenced by all
services.

To address these limitations, two new options are added to the VNC
server CLI. The 'tls-authz' option takes the ID of a QAuthZ object to
use for checking TLS x509 distinguished names, and the 'sasl-authz'
option takes the ID of another object to use for checking SASL usernames.

In this example, we setup two authorization rules. The first allows any
client with a certificate issued by the 'RedHat' organization in the
'London' locality. The second ACL allows clients with either the
'joe@REDHAT.COM' or  'fred@REDHAT.COM' kerberos usernames. Both checks
must pass for the user to be allowed.

    $QEMU -object tls-creds-x509,id=3Dtls0,dir=3D/home/berrange/qemutls,\
                  endpoint=3Dserver,verify-peer=3Dyes \
          -object authz-simple,id=3Dauthz0,policy=3Ddeny,\
                  rules.0.match=3DO=3DRedHat,,L=3DLondon,rules.0.policy=3D=
allow \
          -object authz-simple,id=3Dauthz1,policy=3Ddeny,\
                  rules.0.match=3Dfred@REDHAT.COM,rules.0.policy=3Dallow =
\
                  rules.0.match=3Djoe@REDHAT.COM,rules.0.policy=3Dallow \
          -vnc 0.0.0.0:1,tls-creds=3Dtls0,tls-authz=3Dauthz0,
	       sasl,sasl-authz=3Dauthz1 \
          ...other QEMU args...

Reviewed-by: Juan Quintela <quintela@redhat.com>
Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
---
 qemu-deprecated.texi |  5 ++++
 qemu-options.hx      | 35 ++++++++++++++++++--------
 ui/vnc.c             | 58 +++++++++++++++++++++++++++++++++++++-------
 3 files changed, 79 insertions(+), 19 deletions(-)

diff --git a/qemu-deprecated.texi b/qemu-deprecated.texi
index 45c57952da..1258da4795 100644
--- a/qemu-deprecated.texi
+++ b/qemu-deprecated.texi
@@ -60,6 +60,11 @@ Support for invalid topologies will be removed, the us=
er must ensure
 topologies described with -smp include all possible cpus, i.e.
   @math{@var{sockets} * @var{cores} * @var{threads} =3D @var{maxcpus}}.
=20
+@subsection -vnc acl (since 4.0.0)
+
+The @code{acl} option to the @code{-vnc} argument has been replaced
+by the @code{tls-authz} and @code{sasl-authz} options.
+
 @section QEMU Machine Protocol (QMP) commands
=20
 @subsection block-dirty-bitmap-add "autoload" parameter (since 2.12.0)
diff --git a/qemu-options.hx b/qemu-options.hx
index 1cf9aac1fe..c74f99b265 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -1624,6 +1624,14 @@ will cause the VNC server socket to enable the VeN=
Crypt auth
 mechanism.  The credentials should have been previously created
 using the @option{-object tls-creds} argument.
=20
+@item tls-authz=3D@var{ID}
+
+Provides the ID of the QAuthZ authorization object against which
+the client's x509 distinguished name will validated. This object is
+only resolved at time of use, so can be deleted and recreated on the
+fly while the VNC server is active. If missing, it will default
+to denying access.
+
 @item sasl
=20
 Require that the client use SASL to authenticate with the VNC server.
@@ -1639,18 +1647,25 @@ ensures a data encryption preventing compromise o=
f authentication
 credentials. See the @ref{vnc_security} section for details on using
 SASL authentication.
=20
+@item sasl-authz=3D@var{ID}
+
+Provides the ID of the QAuthZ authorization object against which
+the client's SASL username will validated. This object is
+only resolved at time of use, so can be deleted and recreated on the
+fly while the VNC server is active. If missing, it will default
+to denying access.
+
 @item acl
=20
-Turn on access control lists for checking of the x509 client certificate
-and SASL party. For x509 certs, the ACL check is made against the
-certificate's distinguished name. This is something that looks like
-@code{C=3DGB,O=3DACME,L=3DBoston,CN=3Dbob}. For SASL party, the ACL chec=
k is
-made against the username, which depending on the SASL plugin, may
-include a realm component, eg @code{bob} or @code{bob@@EXAMPLE.COM}.
-When the @option{acl} flag is set, the initial access list will be
-empty, with a @code{deny} policy. Thus no one will be allowed to
-use the VNC server until the ACLs have been loaded. This can be
-achieved using the @code{acl} monitor command.
+Legacy method for enabling authorization of clients against the
+x509 distinguished name and SASL username. It results in the creation
+of two @code{authz-list} objects with IDs of @code{vnc.username} and
+@code{vnc.x509dname}. The rules for these objects must be configured
+with the HMP ACL commands.
+
+This option is deprecated and should no longer be used. The new
+@option{sasl-authz} and @option{tls-authz} options are a
+replacement.
=20
 @item lossy
=20
diff --git a/ui/vnc.c b/ui/vnc.c
index da4a21d4ce..15d6d2c5d3 100644
--- a/ui/vnc.c
+++ b/ui/vnc.c
@@ -3357,6 +3357,12 @@ static QemuOptsList qemu_vnc_opts =3D {
         },{
             .name =3D "acl",
             .type =3D QEMU_OPT_BOOL,
+        },{
+            .name =3D "tls-authz",
+            .type =3D QEMU_OPT_STRING,
+        },{
+            .name =3D "sasl-authz",
+            .type =3D QEMU_OPT_STRING,
         },{
             .name =3D "lossy",
             .type =3D QEMU_OPT_BOOL,
@@ -3796,6 +3802,8 @@ void vnc_display_open(const char *id, Error **errp)
     const char *credid;
     bool sasl =3D false;
     int acl =3D 0;
+    const char *tlsauthz;
+    const char *saslauthz;
     int lock_key_sync =3D 1;
     int key_delay_ms;
=20
@@ -3867,7 +3875,33 @@ void vnc_display_open(const char *id, Error **errp=
)
             goto fail;
         }
     }
+    if (qemu_opt_get(opts, "acl")) {
+        error_report("The 'acl' option to -vnc is deprecated. "
+                     "Please use the 'tls-authz' and 'sasl-authz' "
+                     "options instead");
+    }
     acl =3D qemu_opt_get_bool(opts, "acl", false);
+    tlsauthz =3D qemu_opt_get(opts, "tls-authz");
+    if (acl && tlsauthz) {
+        error_setg(errp, "'acl' option is mutually exclusive with the "
+                   "'tls-authz' option");
+        goto fail;
+    }
+    if (tlsauthz && !vd->tlscreds) {
+        error_setg(errp, "'tls-authz' provided but TLS is not enabled");
+        goto fail;
+    }
+
+    saslauthz =3D qemu_opt_get(opts, "sasl-authz");
+    if (acl && saslauthz) {
+        error_setg(errp, "'acl' option is mutually exclusive with the "
+                   "'sasl-authz' option");
+        goto fail;
+    }
+    if (saslauthz && !sasl) {
+        error_setg(errp, "'sasl-authz' provided but SASL auth is not ena=
bled");
+        goto fail;
+    }
=20
     share =3D qemu_opt_get(opts, "share");
     if (share) {
@@ -3897,7 +3931,9 @@ void vnc_display_open(const char *id, Error **errp)
         vd->non_adaptive =3D true;
     }
=20
-    if (acl) {
+    if (tlsauthz) {
+        vd->tlsauthzid =3D g_strdup(tlsauthz);
+    } else if (acl) {
         if (strcmp(vd->id, "default") =3D=3D 0) {
             vd->tlsauthzid =3D g_strdup("vnc.x509dname");
         } else {
@@ -3908,15 +3944,19 @@ void vnc_display_open(const char *id, Error **err=
p)
                                               &error_abort));
     }
 #ifdef CONFIG_VNC_SASL
-    if (acl && sasl) {
-        if (strcmp(vd->id, "default") =3D=3D 0) {
-            vd->sasl.authzid =3D g_strdup("vnc.username");
-        } else {
-            vd->sasl.authzid =3D g_strdup_printf("vnc.%s.username", vd->=
id);
+    if (sasl) {
+        if (saslauthz) {
+            vd->sasl.authzid =3D g_strdup(saslauthz);
+        } else if (acl) {
+            if (strcmp(vd->id, "default") =3D=3D 0) {
+                vd->sasl.authzid =3D g_strdup("vnc.username");
+            } else {
+                vd->sasl.authzid =3D g_strdup_printf("vnc.%s.username", =
vd->id);
+            }
+            vd->sasl.authz =3D QAUTHZ(qauthz_list_new(vd->sasl.authzid,
+                                                    QAUTHZ_LIST_POLICY_D=
ENY,
+                                                    &error_abort));
         }
-        vd->sasl.authz =3D QAUTHZ(qauthz_list_new(vd->sasl.authzid,
-                                                QAUTHZ_LIST_POLICY_DENY,
-                                                &error_abort));
     }
 #endif
=20
--=20
2.20.1
