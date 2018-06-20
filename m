Received: from eggs.gnu.org ([2001:4830:134:3::10]:36819)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fVc0Y-0000d7-M3
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 08:14:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fVc0X-0008Le-ME
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 08:14:42 -0400
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Date: Wed, 20 Jun 2018 13:14:23 +0100
Message-Id: <20180620121423.16979-7-berrange@redhat.com>
In-Reply-To: <20180620121423.16979-1-berrange@redhat.com>
References: <20180620121423.16979-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 6/6] monitor: deprecate acl_show, acl_reset,
 acl_policy, acl_add, acl_remove
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Max Reitz <mreitz@redhat.com>, Markus Armbruster <armbru@redhat.com>, qemu-block@nongnu.org, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Juan Quintela <quintela@redhat.com>, Eric Blake <eblake@redhat.com>, =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>

The various ACL related commands are obsolete now that the QAuthZ
framework for authorization is fully integrated throughout QEMU network
services. Mark it as deprecated with no replacement to be provided.

Authorization is now provided by using 'object_add' together with
the 'tls-authz' or 'sasl-authz' parameters to the VNC server, and
equivalent for other network services.

Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
---
 monitor.c     | 23 +++++++++++++++++++++++
 qemu-doc.texi |  8 ++++++++
 2 files changed, 31 insertions(+)

diff --git a/monitor.c b/monitor.c
index 07d14f53f9..cbcfbf912b 100644
--- a/monitor.c
+++ b/monitor.c
@@ -2112,6 +2112,19 @@ static QAuthZList *find_auth(Monitor *mon, const c=
har *name)
     return QAUTHZ_LIST(obj);
 }
=20
+static bool warn_acl;
+static void hmp_warn_acl(void)
+{
+    if (warn_acl) {
+        return;
+    }
+    error_report("The acl_show, acl_reset, acl_policy, acl_add, acl_remo=
ve "
+                 "commands are deprecated with no replacement. Authoriza=
tion "
+                 "for VNC should be performed using the pluggable QAuthZ=
 "
+                 "objects");
+    warn_acl =3D true;
+}
+
 static void hmp_acl_show(Monitor *mon, const QDict *qdict)
 {
     const char *aclname =3D qdict_get_str(qdict, "aclname");
@@ -2119,6 +2132,8 @@ static void hmp_acl_show(Monitor *mon, const QDict =
*qdict)
     QAuthZListRuleList *rules;
     size_t i =3D 0;
=20
+    hmp_warn_acl();
+
     if (!auth) {
         return;
     }
@@ -2142,6 +2157,8 @@ static void hmp_acl_reset(Monitor *mon, const QDict=
 *qdict)
     const char *aclname =3D qdict_get_str(qdict, "aclname");
     QAuthZList *auth =3D find_auth(mon, aclname);
=20
+    hmp_warn_acl();
+
     if (!auth) {
         return;
     }
@@ -2160,6 +2177,8 @@ static void hmp_acl_policy(Monitor *mon, const QDic=
t *qdict)
     int val;
     Error *err =3D NULL;
=20
+    hmp_warn_acl();
+
     if (!auth) {
         return;
     }
@@ -2195,6 +2214,8 @@ static void hmp_acl_add(Monitor *mon, const QDict *=
qdict)
     QAuthZListFormat format;
     size_t i =3D 0;
=20
+    hmp_warn_acl();
+
     if (!auth) {
         return;
     }
@@ -2250,6 +2271,8 @@ static void hmp_acl_remove(Monitor *mon, const QDic=
t *qdict)
     QAuthZList *auth =3D find_auth(mon, aclname);
     ssize_t i =3D 0;
=20
+    hmp_warn_acl();
+
     if (!auth) {
         return;
     }
diff --git a/qemu-doc.texi b/qemu-doc.texi
index 5639b7ecdb..8327e56db9 100644
--- a/qemu-doc.texi
+++ b/qemu-doc.texi
@@ -2933,6 +2933,14 @@ The ``query-cpus'' command is replaced by the ``qu=
ery-cpus-fast'' command.
 The ``arch'' output member of the ``query-cpus-fast'' command is
 replaced by the ``target'' output member.
=20
+@section Human Monitor Protocol (HMP) commands
+
+@subsection acl_show, acl_reset, acl_policy, acl_add, acl_remove (since =
3.0.0)
+
+The ``acl_show'', ``acl_reset'', ``acl_policy'', ``acl_add'', and
+``acl_remove'' commands are deprecated with no replacement. Authorizatio=
n
+for VNC should be performed using the pluggable QAuthZ objects.
+
 @section System emulator devices
=20
 @subsection ivshmem (since 2.6.0)
--=20
2.17.0
