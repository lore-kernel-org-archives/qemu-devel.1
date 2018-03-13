Received: from eggs.gnu.org ([2001:4830:134:3::10]:60907)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1evjUp-0001XB-L2
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 08:57:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1evjUo-0000wz-Ow
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 08:57:39 -0400
Received: from mail-wr0-x243.google.com ([2a00:1450:400c:c0c::243]:33257)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1evjUo-0000wd-I2
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 08:57:38 -0400
Received: by mail-wr0-x243.google.com with SMTP id r8so7237238wrg.0
	for <qemu-devel@nongnu.org>; Tue, 13 Mar 2018 05:57:38 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 13 Mar 2018 13:56:36 +0100
Message-Id: <1520945798-50640-21-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1520945798-50640-1-git-send-email-pbonzini@redhat.com>
References: <1520945798-50640-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 20/22] sev/i386: qmp: add
 query-sev-launch-measure command
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

The command can be used by libvirt to retrieve the measurement of SEV guest.
This measurement is a signature of the memory contents that was encrypted
through the LAUNCH_UPDATE_DATA.

Cc: "Daniel P. Berrangé" <berrange@redhat.com>
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 monitor.c             |  7 +++++++
 qapi/misc.json        | 29 +++++++++++++++++++++++++++++
 target/i386/monitor.c | 17 +++++++++++++++++
 tests/qmp-test.c      |  2 ++
 4 files changed, 55 insertions(+)

diff --git a/monitor.c b/monitor.c
index af11654..36ed087 100644
--- a/monitor.c
+++ b/monitor.c
@@ -984,6 +984,7 @@ static void qmp_unregister_commands_hack(void)
 #ifndef TARGET_I386
     qmp_unregister_command(&qmp_commands, "rtc-reset-reinjection");
     qmp_unregister_command(&qmp_commands, "query-sev");
+    qmp_unregister_command(&qmp_commands, "query-sev-launch-measure");
 #endif
 #ifndef TARGET_S390X
     qmp_unregister_command(&qmp_commands, "dump-skeys");
@@ -4110,6 +4111,12 @@ SevInfo *qmp_query_sev(Error **errp)
     error_setg(errp, QERR_FEATURE_DISABLED, "query-sev");
     return NULL;
 }
+
+SevLaunchMeasureInfo *qmp_query_sev_launch_measure(Error **errp)
+{
+    error_setg(errp, QERR_FEATURE_DISABLED, "query-sev-launch-measure");
+    return NULL;
+}
 #endif
 
 #ifndef TARGET_S390X
diff --git a/qapi/misc.json b/qapi/misc.json
index 7b628c2..b8318f5 100644
--- a/qapi/misc.json
+++ b/qapi/misc.json
@@ -3293,3 +3293,32 @@
 #
 ##
 { 'command': 'query-sev', 'returns': 'SevInfo' }
+
+##
+# @SevLaunchMeasureInfo:
+#
+# SEV Guest Launch measurement information
+#
+# @data: the measurement value encoded in base64
+#
+# Since: 2.12
+#
+##
+{ 'struct': 'SevLaunchMeasureInfo', 'data': {'data': 'str'} }
+
+##
+# @query-sev-launch-measure:
+#
+# Query the SEV guest launch information.
+#
+# Returns: The @SevLaunchMeasureInfo for the guest
+#
+# Since: 2.12
+#
+# Example:
+#
+# -> { "execute": "query-sev-launch-measure" }
+# <- { "return": { "data": "4l8LXeNlSPUDlXPJG5966/8%YZ" } }
+#
+##
+{ 'command': 'query-sev-launch-measure', 'returns': 'SevLaunchMeasureInfo' }
diff --git a/target/i386/monitor.c b/target/i386/monitor.c
index 64b5e6e..f8a0e4b 100644
--- a/target/i386/monitor.c
+++ b/target/i386/monitor.c
@@ -697,3 +697,20 @@ void hmp_info_sev(Monitor *mon, const QDict *qdict)
         monitor_printf(mon, "SEV is not enabled\n");
     }
 }
+
+SevLaunchMeasureInfo *qmp_query_sev_launch_measure(Error **errp)
+{
+    char *data;
+    SevLaunchMeasureInfo *info;
+
+    data = sev_get_launch_measurement();
+    if (!data) {
+        error_setg(errp, "Measurement is not available");
+        return NULL;
+    }
+
+    info = g_malloc0(sizeof(*info));
+    info->data = data;
+
+    return info;
+}
diff --git a/tests/qmp-test.c b/tests/qmp-test.c
index a77ff92..ec8c7c7 100644
--- a/tests/qmp-test.c
+++ b/tests/qmp-test.c
@@ -204,6 +204,8 @@ static bool query_is_blacklisted(const char *cmd)
         "query-gic-capabilities", /* arm */
         /* Success depends on target-specific build configuration: */
         "query-pci",              /* CONFIG_PCI */
+        /* Success depends on launching SEV guest */
+        "query-sev-launch-measure",
         /* Success depends on Host or Hypervisor SEV support */
         "query-sev",
         NULL
-- 
1.8.3.1
