Received: from eggs.gnu.org ([2001:4830:134:3::10]:36822)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fVc0Y-0000d9-NX
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 08:14:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fVc0X-0008Ke-7z
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 08:14:42 -0400
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Date: Wed, 20 Jun 2018 13:14:22 +0100
Message-Id: <20180620121423.16979-6-berrange@redhat.com>
In-Reply-To: <20180620121423.16979-1-berrange@redhat.com>
References: <20180620121423.16979-1-berrange@redhat.com>
Subject: [Qemu-devel] [PATCH v2 5/6] vnc: allow specifying a custom
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
Cc: Kevin Wolf <kwolf@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Max Reitz <mreitz@redhat.com>, Markus Armbruster <armbru@redhat.com>, qemu-block@nongnu.org, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Juan Quintela <quintela@redhat.com>, Eric Blake <eblake@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>

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

    $QEMU -object tls-creds-x509,id=tls0,dir=/home/berrange/qemutls,\
                  endpoint=server,verify-peer=yes \
          -object authz-simple,id=authz0,policy=deny,\
                  rules.0.match=O=RedHat,,L=London,rules.0.policy=allow \
          -object authz-simple,id=authz1,policy=deny,\
                  rules.0.match=fred@REDHAT.COM,rules.0.policy=allow \
                  rules.0.match=joe@REDHAT.COM,rules.0.policy=allow \
          -vnc 0.0.0.0:1,tls-creds=tls0,tls-authz=authz0,
	       sasl,sasl-authz=authz1 \
          ...other QEMU args...

Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
---
 qemu-doc.texi   |  5 +++++
 qemu-options.hx | 35 ++++++++++++++++++++---------
 ui/vnc.c        | 58 +++++++++++++++++++++++++++++++++++++++++--------
 3 files changed, 79 insertions(+), 19 deletions(-)

diff --git a/qemu-doc.texi b/qemu-doc.texi
index 282bc3dc35..5639b7ecdb 100644
--- a/qemu-doc.texi
+++ b/qemu-doc.texi
@@ -2912,6 +2912,11 @@ Option @option{-virtioconsole} has been replaced by
 The @code{-clock} option is ignored since QEMU version 1.7.0. There is no
 replacement since it is not needed anymore.
 
+@subsection -vnc acl (since 3.0.0)
+
+The @code{acl} option to the @code{-vnc} argument has been replaced
+by the @code{tls-authz} and @code{sasl-authz} options.
+
 @section QEMU Machine Protocol (QMP) commands
 
 @subsection block-dirty-bitmap-add "autoload" parameter (since 2.12.0)
diff --git a/qemu-options.hx b/qemu-options.hx
index b7337da782..d7a87e8b1e 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -1647,6 +1647,14 @@ The @option{tls-creds} parameter obsoletes the @option{tls},
 it is not permitted to set both new and old type options at
 the same time.
 
+@item tls-authz=@var{ID}
+
+Provides the ID of the QAuthZ authorization object against which
+the client's x509 distinguished name will validated. This object is
+only resolved at time of use, so can be deleted and recreated on the
+fly while the VNC server is active. If missing, it will default
+to denying access.
+
 @item tls
 
 Require that client use TLS when communicating with the VNC server. This
@@ -1700,18 +1708,25 @@ ensures a data encryption preventing compromise of authentication
 credentials. See the @ref{vnc_security} section for details on using
 SASL authentication.
 
+@item sasl-authz=@var{ID}
+
+Provides the ID of the QAuthZ authorization object against which
+the client's SASL username will validated. This object is
+only resolved at time of use, so can be deleted and recreated on the
+fly while the VNC server is active. If missing, it will default
+to denying access.
+
 @item acl
 
-Turn on access control lists for checking of the x509 client certificate
-and SASL party. For x509 certs, the ACL check is made against the
-certificate's distinguished name. This is something that looks like
-@code{C=GB,O=ACME,L=Boston,CN=bob}. For SASL party, the ACL check is
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
 
 @item lossy
 
diff --git a/ui/vnc.c b/ui/vnc.c
index 9fb8430c35..2da9433ca7 100644
--- a/ui/vnc.c
+++ b/ui/vnc.c
@@ -3407,6 +3407,12 @@ static QemuOptsList qemu_vnc_opts = {
         },{
             .name = "acl",
             .type = QEMU_OPT_BOOL,
+        },{
+            .name = "tls-authz",
+            .type = QEMU_OPT_STRING,
+        },{
+            .name = "sasl-authz",
+            .type = QEMU_OPT_STRING,
         },{
             .name = "lossy",
             .type = QEMU_OPT_BOOL,
@@ -3894,6 +3900,8 @@ void vnc_display_open(const char *id, Error **errp)
     int saslErr;
 #endif
     int acl = 0;
+    const char *tlsauthz;
+    const char *saslauthz;
     int lock_key_sync = 1;
     int key_delay_ms;
 
@@ -3999,7 +4007,33 @@ void vnc_display_open(const char *id, Error **errp)
             }
         }
     }
+    if (qemu_opt_get(opts, "acl")) {
+        error_report("The 'acl' option to -vnc is deprecated. "
+                     "Please use the 'tls-authz' and 'sasl-authz' "
+                     "options instead");
+    }
     acl = qemu_opt_get_bool(opts, "acl", false);
+    tlsauthz = qemu_opt_get(opts, "tls-authz");
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
+    saslauthz = qemu_opt_get(opts, "sasl-authz");
+    if (acl && saslauthz) {
+        error_setg(errp, "'acl' option is mutually exclusive with the "
+                   "'sasl-authz' option");
+        goto fail;
+    }
+    if (saslauthz && !sasl) {
+        error_setg(errp, "'sasl-authz' provided but SASL auth is not enabled");
+        goto fail;
+    }
 
     share = qemu_opt_get(opts, "share");
     if (share) {
@@ -4029,7 +4063,9 @@ void vnc_display_open(const char *id, Error **errp)
         vd->non_adaptive = true;
     }
 
-    if (acl) {
+    if (tlsauthz) {
+        vd->tlsauthzid = g_strdup(tlsauthz);
+    } else if (acl) {
         if (strcmp(vd->id, "default") == 0) {
             vd->tlsauthzid = g_strdup("vnc.x509dname");
         } else {
@@ -4040,15 +4076,19 @@ void vnc_display_open(const char *id, Error **errp)
                                               &error_abort));
     }
 #ifdef CONFIG_VNC_SASL
-    if (acl && sasl) {
-        if (strcmp(vd->id, "default") == 0) {
-            vd->sasl.authzid = g_strdup("vnc.username");
-        } else {
-            vd->sasl.authzid = g_strdup_printf("vnc.%s.username", vd->id);
+    if (sasl) {
+        if (saslauthz) {
+            vd->sasl.authzid = g_strdup(saslauthz);
+        } else if (acl) {
+            if (strcmp(vd->id, "default") == 0) {
+                vd->sasl.authzid = g_strdup("vnc.username");
+            } else {
+                vd->sasl.authzid = g_strdup_printf("vnc.%s.username", vd->id);
+            }
+            vd->sasl.authz = QAUTHZ(qauthz_list_new(vd->sasl.authzid,
+                                                    QAUTHZ_LIST_POLICY_DENY,
+                                                    &error_abort));
         }
-        vd->sasl.authz = QAUTHZ(qauthz_list_new(vd->sasl.authzid,
-                                                QAUTHZ_LIST_POLICY_DENY,
-                                                &error_abort));
     }
 #endif
 
-- 
2.17.0
