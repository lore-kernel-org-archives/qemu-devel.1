Received: from eggs.gnu.org ([2001:4830:134:3::10]:51661)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <brijesh.singh@amd.com>) id 1ejSFo-0005y7-GF
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 11:07:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <brijesh.singh@amd.com>) id 1ejSFk-0006vj-Gz
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 11:07:24 -0500
Received: from mail-bl2nam02on0041.outbound.protection.outlook.com
	([104.47.38.41]:22992
	helo=NAM02-BL2-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <brijesh.singh@amd.com>)
	id 1ejSFk-0006vQ-AY
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 11:07:20 -0500
From: Brijesh Singh <brijesh.singh@amd.com>
Date: Wed,  7 Feb 2018 10:06:25 -0600
Message-ID: <20180207160638.98872-13-brijesh.singh@amd.com>
In-Reply-To: <20180207160638.98872-1-brijesh.singh@amd.com>
References: <20180207160638.98872-1-brijesh.singh@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v7 13/26] qmp: add query-sev command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Alistair Francis <alistair.francis@xilinx.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, "Daniel P . Berrange" <berrange@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>, Eduardo Habkost <ehabkost@redhat.com>, Eric Blake <eblake@redhat.com>, kvm@vger.kernel.org, Marcel Apfelbaum <marcel@redhat.com>, Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Peter Maydell <peter.maydell@linaro.org>, Richard Henderson <richard.henderson@linaro.org>, Stefan Hajnoczi <stefanha@gmail.com>, Thomas Lendacky <Thomas.Lendacky@amd.com>, Borislav Petkov <bp@suse.de>, Brijesh Singh <brijesh.singh@amd.com>

The QMP query command can used to retrieve the SEV information when
memory encryption is enabled on AMD platform.

Cc: "Daniel P. Berrang=C3=A9" <berrange@redhat.com>
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
---
 qapi-schema.json | 47 +++++++++++++++++++++++++++++++++++++++++++++++
 qmp.c            | 16 ++++++++++++++++
 2 files changed, 63 insertions(+)

diff --git a/qapi-schema.json b/qapi-schema.json
index 5c06745c7927..447ebb15266e 100644
--- a/qapi-schema.json
+++ b/qapi-schema.json
@@ -3189,3 +3189,50 @@
 # Since: 2.11
 ##
 { 'command': 'watchdog-set-action', 'data' : {'action': 'WatchdogAction'} =
}
+
+##
+# @SevInfo:
+#
+# Information about SEV support
+#
+# @enabled: true if SEV is active
+#
+# @api_major: SEV API major version
+#
+# @api_minor: SEV API minor version
+#
+# @build_id: SEV FW build id
+#
+# @policy: SEV policy value
+#
+# @state: SEV guest state
+#
+# Since: 2.12
+##
+{ 'struct': 'SevInfo',
+    'data': { 'enabled': 'bool',
+              'api_major': 'uint8',
+              'api_minor' : 'uint8',
+              'build_id' : 'uint8',
+              'policy' : 'uint32',
+              'state' : 'str'
+            }
+}
+
+##
+# @query-sev:
+#
+# Returns information about SEV
+#
+# Returns: @SevInfo
+#
+# Since: 2.12
+#
+# Example:
+#
+# -> { "execute": "query-sev" }
+# <- { "return": { "enabled": true, "api-major" : 0, "api-minor" : 0,
+#                  "build-id" : 0, "policy" : 0, "state" : "running" } }
+#
+##
+{ 'command': 'query-sev', 'returns': 'SevInfo' }
diff --git a/qmp.c b/qmp.c
index 52cfd2d81c0f..1a5cfad09dd0 100644
--- a/qmp.c
+++ b/qmp.c
@@ -37,6 +37,7 @@
 #include "qom/object_interfaces.h"
 #include "hw/mem/pc-dimm.h"
 #include "hw/acpi/acpi_dev_interface.h"
+#include "sysemu/sev.h"
=20
 NameInfo *qmp_query_name(Error **errp)
 {
@@ -717,3 +718,18 @@ MemoryInfo *qmp_query_memory_size_summary(Error **errp=
)
=20
     return mem_info;
 }
+
+SevInfo *qmp_query_sev(Error **errp)
+{
+    SevInfo *info =3D g_malloc0(sizeof(*info));
+
+    info->enabled =3D sev_enabled();
+    if (info->enabled) {
+        sev_get_fw_version(&info->api_major,
+                           &info->api_minor, &info->build_id);
+        sev_get_policy(&info->policy);
+        sev_get_current_state(&info->state);
+    }
+
+    return info;
+}
--=20
2.14.3
