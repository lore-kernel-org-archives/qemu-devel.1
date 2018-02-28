Received: from eggs.gnu.org ([2001:4830:134:3::10]:53141)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <brijesh.singh@amd.com>) id 1er90G-0001GU-1D
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 16:11:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <brijesh.singh@amd.com>) id 1er90B-0005gy-Ay
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 16:11:07 -0500
Received: from mail-dm3nam03on0040.outbound.protection.outlook.com
	([104.47.41.40]:59821
	helo=NAM03-DM3-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <brijesh.singh@amd.com>)
	id 1er90B-0005fB-1W
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 16:11:03 -0500
From: Brijesh Singh <brijesh.singh@amd.com>
Date: Wed, 28 Feb 2018 15:10:09 -0600
Message-ID: <20180228211028.83970-10-brijesh.singh@amd.com>
In-Reply-To: <20180228211028.83970-1-brijesh.singh@amd.com>
References: <20180228211028.83970-1-brijesh.singh@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v10 09/28] qmp: add query-sev command
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

Cc: Eric Blake <eblake@redhat.com>
Cc: "Daniel P. Berrang=C3=A9" <berrange@redhat.com>
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
---
 monitor.c             |  7 ++++++
 qapi-schema.json      | 61 +++++++++++++++++++++++++++++++++++++++++++++++=
++++
 target/i386/monitor.c |  8 +++++++
 3 files changed, 76 insertions(+)

diff --git a/monitor.c b/monitor.c
index d77edc4bb692..356d550aaf2d 100644
--- a/monitor.c
+++ b/monitor.c
@@ -983,6 +983,7 @@ static void qmp_unregister_commands_hack(void)
 #endif
 #ifndef TARGET_I386
     qmp_unregister_command(&qmp_commands, "rtc-reset-reinjection");
+    qmp_unregister_command(&qmp_commands, "query-sev");
 #endif
 #ifndef TARGET_S390X
     qmp_unregister_command(&qmp_commands, "dump-skeys");
@@ -4157,6 +4158,12 @@ void qmp_rtc_reset_reinjection(Error **errp)
 {
     error_setg(errp, QERR_FEATURE_DISABLED, "rtc-reset-reinjection");
 }
+
+SevInfo *qmp_query_sev(Error **errp)
+{
+    error_setg(errp, QERR_FEATURE_DISABLED, "query-sev");
+    return NULL;
+}
 #endif
=20
 #ifndef TARGET_S390X
diff --git a/qapi-schema.json b/qapi-schema.json
index 0262b9f20bc6..467a06460ead 100644
--- a/qapi-schema.json
+++ b/qapi-schema.json
@@ -3189,3 +3189,64 @@
 # Since: 2.11
 ##
 { 'command': 'watchdog-set-action', 'data' : {'action': 'WatchdogAction'} =
}
+
+##
+# @SevState:
+#
+# An enumeration of SEV state information used during @query-sev.
+#
+# Since: 2.12
+##
+{ 'enum': 'SevState',
+  'data': ['uninit', 'lupdate', 'lsecret', 'running', 'supdate', 'rupdate'=
 ] }
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
+# @handle: SEV firmware handle
+#
+# Since: 2.12
+##
+{ 'struct': 'SevInfo',
+    'data': { 'enabled': 'bool',
+              'api-major': 'uint8',
+              'api-minor' : 'uint8',
+              'build-id' : 'uint8',
+              'policy' : 'uint32',
+              'state' : 'SevState',
+              'handle' : 'uint32'
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
+#                  "build-id" : 0, "policy" : 0, "state" : "running",
+#                  "handle" : 1 } }
+#
+##
+{ 'command': 'query-sev', 'returns': 'SevInfo' }
diff --git a/target/i386/monitor.c b/target/i386/monitor.c
index 55ea10deb8ef..f429b1fc5383 100644
--- a/target/i386/monitor.c
+++ b/target/i386/monitor.c
@@ -30,6 +30,8 @@
 #include "hw/i386/pc.h"
 #include "sysemu/kvm.h"
 #include "hmp.h"
+#include "sev_i386.h"
+#include "qmp-commands.h"
=20
=20
 static void print_pte(Monitor *mon, CPUArchState *env, hwaddr addr,
@@ -665,3 +667,9 @@ void hmp_info_io_apic(Monitor *mon, const QDict *qdict)
         ioapic_dump_state(mon, qdict);
     }
 }
+
+SevInfo *qmp_query_sev(Error **errp)
+{
+    error_setg(errp, "SEV feature is not available");
+    return NULL;
+}
--=20
2.14.3
