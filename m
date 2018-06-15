Received: from eggs.gnu.org ([2001:4830:134:3::10]:58942)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fTr0W-0000AK-Cb
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 11:51:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fTr0V-0006fj-81
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 11:51:24 -0400
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Date: Fri, 15 Jun 2018 16:51:03 +0100
Message-Id: <20180615155103.11924-7-berrange@redhat.com>
In-Reply-To: <20180615155103.11924-1-berrange@redhat.com>
References: <20180615155103.11924-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 6/6] monitor: deprecate acl_show, acl_reset,
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
Cc: Eric Blake <eblake@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Markus Armbruster <armbru@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, qemu-block@nongnu.org, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Juan Quintela <quintela@redhat.com>, =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>

The various ACL related commands are obsolete now that the QAuthZ
framework for authorization is fully integrated throughout QEMU network
services. Mark it as deprecated with no replacement to be provided.

Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
---
 monitor.c     | 23 +++++++++++++++++++++++
 qemu-doc.texi |  8 ++++++++
 2 files changed, 31 insertions(+)

diff --git a/monitor.c b/monitor.c
index 67c63013bd..c4a9ae5c85 100644
--- a/monitor.c
+++ b/monitor.c
@@ -2089,6 +2089,19 @@ static QAuthZList *find_auth(Monitor *mon, const c=
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
@@ -2096,6 +2109,8 @@ static void hmp_acl_show(Monitor *mon, const QDict =
*qdict)
     QAuthZListRuleList *rules;
     size_t i =3D 0;
=20
+    hmp_warn_acl();
+
     if (!auth) {
         return;
     }
@@ -2119,6 +2134,8 @@ static void hmp_acl_reset(Monitor *mon, const QDict=
 *qdict)
     const char *aclname =3D qdict_get_str(qdict, "aclname");
     QAuthZList *auth =3D find_auth(mon, aclname);
=20
+    hmp_warn_acl();
+
     if (!auth) {
         return;
     }
@@ -2137,6 +2154,8 @@ static void hmp_acl_policy(Monitor *mon, const QDic=
t *qdict)
     int val;
     Error *err =3D NULL;
=20
+    hmp_warn_acl();
+
     if (!auth) {
         return;
     }
@@ -2172,6 +2191,8 @@ static void hmp_acl_add(Monitor *mon, const QDict *=
qdict)
     QAuthZListFormat format;
     size_t i =3D 0;
=20
+    hmp_warn_acl();
+
     if (!auth) {
         return;
     }
@@ -2227,6 +2248,8 @@ static void hmp_acl_remove(Monitor *mon, const QDic=
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
index 5b7e3faab2..c6aad94015 100644
--- a/qemu-doc.texi
+++ b/qemu-doc.texi
@@ -2938,6 +2938,14 @@ The ``query-cpus'' command is replaced by the ``qu=
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
