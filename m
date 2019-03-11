Received: from eggs.gnu.org ([209.51.188.92]:59781)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1h3GNS-0001pJ-BV
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 04:33:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1h3GGY-00029w-VE
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 04:26:36 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45354)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1h3GGX-00026k-1E
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 04:26:34 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 2772813A4D
	for <qemu-devel@nongnu.org>; Mon, 11 Mar 2019 08:26:31 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Mon, 11 Mar 2019 09:26:19 +0100
Message-Id: <20190311082619.17966-6-kraxel@redhat.com>
In-Reply-To: <20190311082619.17966-1-kraxel@redhat.com>
References: <20190311082619.17966-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 5/5] monitor: deprecate acl_show, acl_reset,
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
Cc: libvir-list@redhat.com, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Markus Armbruster <armbru@redhat.com>, =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>

From: Daniel P. Berrang=C3=A9 <berrange@redhat.com>

The various ACL related commands are obsolete now that the QAuthZ
framework for authorization is fully integrated throughout QEMU network
services. These only ever worked with VNC and were never used by libvirt.
Mark it as deprecated with no direct replacement to be provided.

Authorization is now provided by using 'object_add' together with
the 'tls-authz' or 'sasl-authz' parameters to the VNC server, and
equivalent for other network services.

Reviewed-by: Juan Quintela <quintela@redhat.com>
Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
Message-id: 20190227145755.26556-3-berrange@redhat.com
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 monitor.c            | 23 +++++++++++++++++++++++
 qemu-deprecated.texi |  6 ++++++
 2 files changed, 29 insertions(+)

diff --git a/monitor.c b/monitor.c
index defa129319b0..72061d5baeb4 100644
--- a/monitor.c
+++ b/monitor.c
@@ -2032,6 +2032,19 @@ static QAuthZList *find_auth(Monitor *mon, const c=
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
@@ -2039,6 +2052,8 @@ static void hmp_acl_show(Monitor *mon, const QDict =
*qdict)
     QAuthZListRuleList *rules;
     size_t i =3D 0;
=20
+    hmp_warn_acl();
+
     if (!auth) {
         return;
     }
@@ -2062,6 +2077,8 @@ static void hmp_acl_reset(Monitor *mon, const QDict=
 *qdict)
     const char *aclname =3D qdict_get_str(qdict, "aclname");
     QAuthZList *auth =3D find_auth(mon, aclname);
=20
+    hmp_warn_acl();
+
     if (!auth) {
         return;
     }
@@ -2080,6 +2097,8 @@ static void hmp_acl_policy(Monitor *mon, const QDic=
t *qdict)
     int val;
     Error *err =3D NULL;
=20
+    hmp_warn_acl();
+
     if (!auth) {
         return;
     }
@@ -2124,6 +2143,8 @@ static void hmp_acl_add(Monitor *mon, const QDict *=
qdict)
     QAuthZListFormat format;
     size_t i =3D 0;
=20
+    hmp_warn_acl();
+
     if (!auth) {
         return;
     }
@@ -2169,6 +2190,8 @@ static void hmp_acl_remove(Monitor *mon, const QDic=
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
index 1258da479535..1e15f57e9cc9 100644
--- a/qemu-deprecated.texi
+++ b/qemu-deprecated.texi
@@ -104,6 +104,12 @@ The @option{[hub_id name]} parameter tuple of the 'h=
ostfwd_add' and
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
2.18.1
