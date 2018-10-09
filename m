Received: from eggs.gnu.org ([2001:4830:134:3::10]:53354)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1g9s0D-0006EY-C9
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 09:24:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1g9s0C-0004w0-J1
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 09:24:45 -0400
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Date: Tue,  9 Oct 2018 14:23:30 +0100
Message-Id: <20181009132330.7549-7-berrange@redhat.com>
In-Reply-To: <20181009132330.7549-1-berrange@redhat.com>
References: <20181009132330.7549-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v3 6/6] monitor: deprecate acl_show, acl_reset,
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-block@nongnu.org, Eric Blake <eblake@redhat.com>, libvir-list@redhat.com, Kevin Wolf <kwolf@redhat.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Juan Quintela <quintela@redhat.com>, Max Reitz <mreitz@redhat.com>, Markus Armbruster <armbru@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>

The various ACL related commands are obsolete now that the QAuthZ
framework for authorization is fully integrated throughout QEMU network
services. Mark it as deprecated with no replacement to be provided.

Authorization is now provided by using 'object_add' together with
the 'tls-authz' or 'sasl-authz' parameters to the VNC server, and
equivalent for other network services.

Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
---
 monitor.c            | 23 +++++++++++++++++++++++
 qemu-deprecated.texi |  6 ++++++
 2 files changed, 29 insertions(+)

diff --git a/monitor.c b/monitor.c
index abedc6263f..8144f304c4 100644
--- a/monitor.c
+++ b/monitor.c
@@ -2056,6 +2056,19 @@ static QAuthZList *find_auth(Monitor *mon, const c=
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
@@ -2063,6 +2076,8 @@ static void hmp_acl_show(Monitor *mon, const QDict =
*qdict)
     QAuthZListRuleList *rules;
     size_t i =3D 0;
=20
+    hmp_warn_acl();
+
     if (!auth) {
         return;
     }
@@ -2086,6 +2101,8 @@ static void hmp_acl_reset(Monitor *mon, const QDict=
 *qdict)
     const char *aclname =3D qdict_get_str(qdict, "aclname");
     QAuthZList *auth =3D find_auth(mon, aclname);
=20
+    hmp_warn_acl();
+
     if (!auth) {
         return;
     }
@@ -2104,6 +2121,8 @@ static void hmp_acl_policy(Monitor *mon, const QDic=
t *qdict)
     int val;
     Error *err =3D NULL;
=20
+    hmp_warn_acl();
+
     if (!auth) {
         return;
     }
@@ -2139,6 +2158,8 @@ static void hmp_acl_add(Monitor *mon, const QDict *=
qdict)
     QAuthZListFormat format;
     size_t i =3D 0;
=20
+    hmp_warn_acl();
+
     if (!auth) {
         return;
     }
@@ -2194,6 +2215,8 @@ static void hmp_acl_remove(Monitor *mon, const QDic=
t *qdict)
     QAuthZList *auth =3D find_auth(mon, aclname);
     ssize_t i =3D 0;
=20
+    hmp_warn_acl();
+
     if (!auth) {
         return;
     }
diff --git a/qemu-deprecated.texi b/qemu-deprecated.texi
index d74d9ea02c..dc6b1909e0 100644
--- a/qemu-deprecated.texi
+++ b/qemu-deprecated.texi
@@ -121,6 +121,12 @@ replaced by the ``target'' output member.
 The @option{[hub_id name]} parameter tuple of the 'hostfwd_add' and
 'hostfwd_remove' HMP commands has been replaced by @option{netdev_id}.
=20
+@subsection acl_show, acl_reset, acl_policy, acl_add, acl_remove (since =
3.1)
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
2.17.1
