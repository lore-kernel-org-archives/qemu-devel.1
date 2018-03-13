Received: from eggs.gnu.org ([2001:4830:134:3::10]:60923)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1evjUq-0001YV-Ph
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 08:57:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1evjUp-0000xr-Sl
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 08:57:40 -0400
Received: from mail-wr0-x242.google.com ([2a00:1450:400c:c0c::242]:46809)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1evjUp-0000xF-Li
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 08:57:39 -0400
Received: by mail-wr0-x242.google.com with SMTP id m12so22360093wrm.13
	for <qemu-devel@nongnu.org>; Tue, 13 Mar 2018 05:57:39 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 13 Mar 2018 13:56:37 +0100
Message-Id: <1520945798-50640-22-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1520945798-50640-1-git-send-email-pbonzini@redhat.com>
References: <1520945798-50640-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 21/22] sev/i386: qmp: add query-sev-capabilities
 command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Brijesh Singh <brijesh.singh@amd.com>, =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Markus Armbruster <armbru@redhat.com>

From: Brijesh Singh <brijesh.singh@amd.com>

The command can be used by libvirt to query the SEV capabilities.

Cc: "Daniel P. Berrangé" <berrange@redhat.com>
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 monitor.c             |  7 +++++++
 qapi/misc.json        | 42 ++++++++++++++++++++++++++++++++++++++++++
 target/i386/monitor.c |  6 ++++++
 tests/qmp-test.c      |  1 +
 4 files changed, 56 insertions(+)

diff --git a/monitor.c b/monitor.c
index 36ed087..3117a3e 100644
--- a/monitor.c
+++ b/monitor.c
@@ -985,6 +985,7 @@ static void qmp_unregister_commands_hack(void)
     qmp_unregister_command(&qmp_commands, "rtc-reset-reinjection");
     qmp_unregister_command(&qmp_commands, "query-sev");
     qmp_unregister_command(&qmp_commands, "query-sev-launch-measure");
+    qmp_unregister_command(&qmp_commands, "query-sev-capabilities");
 #endif
 #ifndef TARGET_S390X
     qmp_unregister_command(&qmp_commands, "dump-skeys");
@@ -4117,6 +4118,12 @@ SevLaunchMeasureInfo *qmp_query_sev_launch_measure(Error **errp)
     error_setg(errp, QERR_FEATURE_DISABLED, "query-sev-launch-measure");
     return NULL;
 }
+
+SevCapability *qmp_query_sev_capabilities(Error **errp)
+{
+    error_setg(errp, QERR_FEATURE_DISABLED, "query-sev-capabilities");
+    return NULL;
+}
 #endif
 
 #ifndef TARGET_S390X
diff --git a/qapi/misc.json b/qapi/misc.json
index b8318f5..6150b9a 100644
--- a/qapi/misc.json
+++ b/qapi/misc.json
@@ -3322,3 +3322,45 @@
 #
 ##
 { 'command': 'query-sev-launch-measure', 'returns': 'SevLaunchMeasureInfo' }
+
+##
+# @SevCapability:
+#
+# The struct describes capability for a Secure Encrypted Virtualization
+# feature.
+#
+# @pdh:  Platform Diffie-Hellman key (base64 encoded)
+#
+# @cert-chain:  PDH certificate chain (base64 encoded)
+#
+# @cbitpos: C-bit location in page table entry
+#
+# @reduced-phys-bits: Number of physical Address bit reduction when SEV is
+#                     enabled
+#
+# Since: 2.12
+##
+{ 'struct': 'SevCapability',
+  'data': { 'pdh': 'str',
+            'cert-chain': 'str',
+            'cbitpos': 'int',
+            'reduced-phys-bits': 'int'} }
+
+##
+# @query-sev-capabilities:
+#
+# This command is used to get the SEV capabilities, and is supported on AMD
+# X86 platforms only.
+#
+# Returns: SevCapability objects.
+#
+# Since: 2.12
+#
+# Example:
+#
+# -> { "execute": "query-sev-capabilities" }
+# <- { "return": { "pdh": "8CCDD8DDD", "cert-chain": "888CCCDDDEE",
+#                  "cbitpos": 47, "reduced-phys-bits": 5}}
+#
+##
+{ 'command': 'query-sev-capabilities', 'returns': 'SevCapability' }
diff --git a/target/i386/monitor.c b/target/i386/monitor.c
index f8a0e4b..8a786fb 100644
--- a/target/i386/monitor.c
+++ b/target/i386/monitor.c
@@ -714,3 +714,9 @@ SevLaunchMeasureInfo *qmp_query_sev_launch_measure(Error **errp)
 
     return info;
 }
+
+SevCapability *qmp_query_sev_capabilities(Error **errp)
+{
+    error_setg(errp, "SEV feature is not available");
+    return NULL;
+}
diff --git a/tests/qmp-test.c b/tests/qmp-test.c
index ec8c7c7..7470c6b 100644
--- a/tests/qmp-test.c
+++ b/tests/qmp-test.c
@@ -208,6 +208,7 @@ static bool query_is_blacklisted(const char *cmd)
         "query-sev-launch-measure",
         /* Success depends on Host or Hypervisor SEV support */
         "query-sev",
+        "query-sev-capabilities",
         NULL
     };
     int i;
-- 
1.8.3.1
