Received: from eggs.gnu.org ([209.51.188.92]:37175)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1guh5m-0005TT-HC
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 12:16:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1guh5l-0006cs-L5
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 12:16:02 -0500
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Date: Fri, 15 Feb 2019 17:14:36 +0000
Message-Id: <20190215171436.30457-7-berrange@redhat.com>
In-Reply-To: <20190215171436.30457-1-berrange@redhat.com>
References: <20190215171436.30457-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v4 6/6] monitor: deprecate acl_show, acl_reset,
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
Cc: Kevin Wolf <kwolf@redhat.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Juan Quintela <quintela@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, libvir-list@redhat.com, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>, Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>

The various ACL related commands are obsolete now that the QAuthZ
framework for authorization is fully integrated throughout QEMU network
services. Mark it as deprecated with no replacement to be provided.

Authorization is now provided by using 'object_add' together with
the 'tls-authz' or 'sasl-authz' parameters to the VNC server, and
equivalent for other network services.

Reviewed-by: Juan Quintela <quintela@redhat.com>
Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
---
 monitor.c            | 23 +++++++++++++++++++++++
 qemu-deprecated.texi |  6 ++++++
 2 files changed, 29 insertions(+)

diff --git a/monitor.c b/monitor.c
index b2a5ae5374..92ea51ed06 100644
--- a/monitor.c
+++ b/monitor.c
@@ -2068,6 +2068,19 @@ static QAuthZList *find_auth(Monitor *mon, const c=
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
@@ -2075,6 +2088,8 @@ static void hmp_acl_show(Monitor *mon, const QDict =
*qdict)
     QAuthZListRuleList *rules;
     size_t i =3D 0;
=20
+    hmp_warn_acl();
+
     if (!auth) {
         return;
     }
@@ -2098,6 +2113,8 @@ static void hmp_acl_reset(Monitor *mon, const QDict=
 *qdict)
     const char *aclname =3D qdict_get_str(qdict, "aclname");
     QAuthZList *auth =3D find_auth(mon, aclname);
=20
+    hmp_warn_acl();
+
     if (!auth) {
         return;
     }
@@ -2116,6 +2133,8 @@ static void hmp_acl_policy(Monitor *mon, const QDic=
t *qdict)
     int val;
     Error *err =3D NULL;
=20
+    hmp_warn_acl();
+
     if (!auth) {
         return;
     }
@@ -2160,6 +2179,8 @@ static void hmp_acl_add(Monitor *mon, const QDict *=
qdict)
     QAuthZListFormat format;
     size_t i =3D 0;
=20
+    hmp_warn_acl();
+
     if (!auth) {
         return;
     }
@@ -2205,6 +2226,8 @@ static void hmp_acl_remove(Monitor *mon, const QDic=
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
index 6139d09793..004daf5ab6 100644
--- a/qemu-deprecated.texi
+++ b/qemu-deprecated.texi
@@ -99,6 +99,12 @@ The @option{[hub_id name]} parameter tuple of the 'hos=
tfwd_add' and
 Use ``device_add'' for hotplugging vCPUs instead of ``cpu-add''.  See
 documentation of ``query-hotpluggable-cpus'' for additional details.
=20
+@subsection acl_show, acl_reset, acl_policy, acl_add, acl_remove (since =
4.0.0)
+
+The ``acl_show'', ``acl_reset'', ``acl_policy'', ``acl_add'', and
+``acl_remove'' commands are deprecated with no replacement. Authorizatio=
n
+for VNC should be performed using the pluggable QAuthZ objects.
+
 @section System emulator devices
=20
 @subsection bluetooth (since 3.1)
--=20
2.20.1
