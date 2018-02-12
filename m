Received: from eggs.gnu.org ([2001:4830:134:3::10]:55912)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <brijesh.singh@amd.com>) id 1elGBY-0003Th-Qy
	for qemu-devel@nongnu.org; Mon, 12 Feb 2018 10:38:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <brijesh.singh@amd.com>) id 1elGBV-0004DP-Kd
	for qemu-devel@nongnu.org; Mon, 12 Feb 2018 10:38:28 -0500
Received: from mail-by2nam01on0070.outbound.protection.outlook.com
	([104.47.34.70]:50592
	helo=NAM01-BY2-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <brijesh.singh@amd.com>)
	id 1elGBV-0004C9-EU
	for qemu-devel@nongnu.org; Mon, 12 Feb 2018 10:38:25 -0500
From: Brijesh Singh <brijesh.singh@amd.com>
Date: Mon, 12 Feb 2018 09:37:00 -0600
Message-ID: <20180212153715.87555-14-brijesh.singh@amd.com>
In-Reply-To: <20180212153715.87555-1-brijesh.singh@amd.com>
References: <20180212153715.87555-1-brijesh.singh@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v8 13/28] qmp: add query-sev command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Alistair Francis <alistair.francis@xilinx.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, "Daniel P . Berrange" <berrange@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>, Eduardo Habkost <ehabkost@redhat.com>, Eric Blake <eblake@redhat.com>, kvm@vger.kernel.org, Marcel Apfelbaum <marcel@redhat.com>, Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Peter Maydell <peter.maydell@linaro.org>, Richard Henderson <richard.henderson@linaro.org>, Stefan Hajnoczi <stefanha@gmail.com>, Thomas Lendacky <Thomas.Lendacky@amd.com>, Borislav Petkov <bp@suse.de>, Alexander Graf <agraf@suse.de>, Bruce Rogers <brogers@suse.com>, Brijesh Singh <brijesh.singh@amd.com>

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
index 5c06745c7927..9203e28b8aee 100644
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
+# Information about Secure Encrypted Virtualization (SEV) support
+#
+# @enabled: true if SEV is active
+#
+# @api-major: SEV API major version
+#
+# @api-minor: SEV API minor version
+#
+# @build-id: SEV FW build id
+#
+# @policy: SEV policy value
+#
+# @state: SEV guest state
+#
+# Since: 2.12
+##
+{ 'struct': 'SevInfo',
+    'data': { 'enabled': 'bool',
+              'api-major': 'uint8',
+              'api-minor' : 'uint8',
+              'build-id' : 'uint8',
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
index 793f6f332302..7907e539c8f2 100644
--- a/qmp.c
+++ b/qmp.c
@@ -39,6 +39,7 @@
 #include "qom/object_interfaces.h"
 #include "hw/mem/pc-dimm.h"
 #include "hw/acpi/acpi_dev_interface.h"
+#include "sysemu/sev.h"
=20
 NameInfo *qmp_query_name(Error **errp)
 {
@@ -719,3 +720,18 @@ MemoryInfo *qmp_query_memory_size_summary(Error **errp=
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
