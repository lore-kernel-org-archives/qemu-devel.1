Received: from eggs.gnu.org ([209.51.188.92]:52820)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1gxCoz-0003SC-IC
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 10:33:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1gxCoy-0002Zg-8Q
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 10:33:05 -0500
Received: from mx1.redhat.com ([209.132.183.28]:54576)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1gxCox-0002Si-UX
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 10:33:04 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id CEE2BE6A83
	for <qemu-devel@nongnu.org>; Fri, 22 Feb 2019 15:32:59 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Fri, 22 Feb 2019 15:32:54 +0000
Message-Id: <20190222153254.22739-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH] qmp: add query-qemu-capabilities
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Peter Krempa <pkrempa@redhat.com>

QMP clients can usually detect the presence of features via schema
introspection.  There are rare features that do not involve schema
changes and are therefore impossible to detect with schema
introspection.

This patch adds the query-qemu-capabilities command.  It returns a list
of capabilities that this QEMU supports.

The decision to make this a command rather than something statically
defined in the schema is intentional.  It allows QEMU to decide which
capabilities are available at runtime, if necessary.

This new interface is necessary so that QMP clients can discover that
migrating disk image files is safe with cache.direct=3Doff on Linux.
There is no other way to detect whether or not QEMU supports this.

Cc: Markus Armbruster <armbru@redhat.com>
Cc: Peter Krempa <pkrempa@redhat.com>
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 qapi/misc.json | 42 ++++++++++++++++++++++++++++++++++++++++++
 qmp.c          | 18 ++++++++++++++++++
 2 files changed, 60 insertions(+)

diff --git a/qapi/misc.json b/qapi/misc.json
index 8b3ca4fdd3..9cf24919a3 100644
--- a/qapi/misc.json
+++ b/qapi/misc.json
@@ -3051,3 +3051,45 @@
   'data': 'NumaOptions',
   'allow-preconfig': true
 }
+
+##
+# @QemuCapability:
+#
+# Capabilities that are not otherwise introspectable.
+#
+# @migrate-with-cache-direct-off-on-linux:
+#  It is safe to migrate disk image files with cache.direct=3Doff on Lin=
ux.
+#  Previously only cache.direct=3Don was supported for live migration.
+#
+# Since: 4.0
+##
+{ 'enum': 'QemuCapability',
+  'data': [
+    'migrate-with-cache-direct-off-on-linux'
+  ]
+}
+
+##
+# @QemuCapabilities:
+#
+# Capability information.
+#
+# @capabilities: supported capabilities
+#
+# Since: 4.0
+##
+{ 'struct': 'QemuCapabilities',
+  'data': { 'capabilities': ['QemuCapability'] } }
+
+##
+# @query-qemu-capabilities:
+#
+# Return the capabilities supported by this QEMU.  Most features can be
+# detected via schema introspection but some are not observable from the
+# schema.  This command offers a way to check for the presence of such
+# features.
+#
+# Since: 4.0
+##
+{ 'command': 'query-qemu-capabilities',
+  'returns': 'QemuCapabilities' }
diff --git a/qmp.c b/qmp.c
index b92d62cd5f..91a1228be7 100644
--- a/qmp.c
+++ b/qmp.c
@@ -717,3 +717,21 @@ MemoryInfo *qmp_query_memory_size_summary(Error **er=
rp)
=20
     return mem_info;
 }
+
+QemuCapabilities *qmp_query_qemu_capabilities(Error **errp)
+{
+    QemuCapabilities *caps =3D g_new0(QemuCapabilities, 1);
+    QemuCapabilityList **prev =3D &caps->capabilities;
+    QemuCapability cap_val;
+
+    /* Add all QemuCapability enum values defined in the schema */
+    for (cap_val =3D 0; cap_val < QEMU_CAPABILITY__MAX; cap_val++) {
+        QemuCapabilityList *cap =3D g_new0(QemuCapabilityList, 1);
+
+        cap->value =3D cap_val;
+        *prev =3D cap;
+        prev =3D &cap->next;
+    }
+
+    return caps;
+}
--=20
2.20.1
