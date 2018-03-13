Received: from eggs.gnu.org ([2001:4830:134:3::10]:60597)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1evjUd-0001Is-98
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 08:57:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1evjUa-0000kY-Lt
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 08:57:27 -0400
Received: from mail-wr0-x234.google.com ([2a00:1450:400c:c0c::234]:38011)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1evjUa-0000jw-D4
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 08:57:24 -0400
Received: by mail-wr0-x234.google.com with SMTP id l8so8045564wrg.5
	for <qemu-devel@nongnu.org>; Tue, 13 Mar 2018 05:57:24 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 13 Mar 2018 13:56:24 +0100
Message-Id: <1520945798-50640-9-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1520945798-50640-1-git-send-email-pbonzini@redhat.com>
References: <1520945798-50640-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 08/22] sev/i386: qmp: add query-sev command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Brijesh Singh <brijesh.singh@amd.com>, Eric Blake <eblake@redhat.com>, =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Markus Armbruster <armbru@redhat.com>

From: Brijesh Singh <brijesh.singh@amd.com>

The QMP query command can used to retrieve the SEV information when
memory encryption is enabled on AMD platform.

Cc: Eric Blake <eblake@redhat.com>
Cc: "Daniel P. Berrangé" <berrange@redhat.com>
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 monitor.c             |  7 +++++
 qapi/misc.json        | 77 +++++++++++++++++++++++++++++++++++++++++++++++++++
 target/i386/monitor.c |  8 ++++++
 tests/qmp-test.c      |  2 ++
 4 files changed, 94 insertions(+)

diff --git a/monitor.c b/monitor.c
index a4417f2..af11654 100644
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
@@ -4103,6 +4104,12 @@ void qmp_rtc_reset_reinjection(Error **errp)
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
 
 #ifndef TARGET_S390X
diff --git a/qapi/misc.json b/qapi/misc.json
index bcd5d10..7b628c2 100644
--- a/qapi/misc.json
+++ b/qapi/misc.json
@@ -3216,3 +3216,80 @@
 # Since: 2.9
 ##
 { 'command': 'query-vm-generation-id', 'returns': 'GuidInfo' }
+
+
+##
+# @SevState:
+#
+# An enumeration of SEV state information used during @query-sev.
+#
+# @uninit: The guest is uninitialized.
+#
+# @launch-update: The guest is currently being launched; plaintext data and
+#                 register state is being imported.
+#
+# @launch-secret: The guest is currently being launched; ciphertext data
+#                 is being imported.
+#
+# @running: The guest is fully launched or migrated in.
+#
+# @send-update: The guest is currently being migrated out to another machine.
+#
+# @receive-update: The guest is currently being migrated from another machine.
+#
+# Since: 2.12
+##
+{ 'enum': 'SevState',
+  'data': ['uninit', 'launch-update', 'launch-secret', 'running',
+           'send-update', 'receive-update' ] }
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
index 7542912..0d1556f 100644
--- a/target/i386/monitor.c
+++ b/target/i386/monitor.c
@@ -30,6 +30,8 @@
 #include "hw/i386/pc.h"
 #include "sysemu/kvm.h"
 #include "hmp.h"
+#include "qapi/error.h"
+#include "qapi/qapi-commands-misc.h"
 
 
 static void print_pte(Monitor *mon, CPUArchState *env, hwaddr addr,
@@ -661,3 +663,9 @@ void hmp_info_io_apic(Monitor *mon, const QDict *qdict)
         ioapic_dump_state(mon, qdict);
     }
 }
+
+SevInfo *qmp_query_sev(Error **errp)
+{
+    error_setg(errp, "SEV feature is not available");
+    return NULL;
+}
diff --git a/tests/qmp-test.c b/tests/qmp-test.c
index 22445d9..a77ff92 100644
--- a/tests/qmp-test.c
+++ b/tests/qmp-test.c
@@ -204,6 +204,8 @@ static bool query_is_blacklisted(const char *cmd)
         "query-gic-capabilities", /* arm */
         /* Success depends on target-specific build configuration: */
         "query-pci",              /* CONFIG_PCI */
+        /* Success depends on Host or Hypervisor SEV support */
+        "query-sev",
         NULL
     };
     int i;
-- 
1.8.3.1
