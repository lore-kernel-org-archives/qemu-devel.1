Received: from eggs.gnu.org ([2001:4830:134:3::10]:60939)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1evjUr-0001ZG-FQ
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 08:57:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1evjUn-0000w1-HO
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 08:57:41 -0400
Received: from mail-wr0-x244.google.com ([2a00:1450:400c:c0c::244]:39013)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1evjUn-0000vV-BG
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 08:57:37 -0400
Received: by mail-wr0-x244.google.com with SMTP id k3so2976012wrg.6
	for <qemu-devel@nongnu.org>; Tue, 13 Mar 2018 05:57:37 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 13 Mar 2018 13:56:35 +0100
Message-Id: <1520945798-50640-20-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1520945798-50640-1-git-send-email-pbonzini@redhat.com>
References: <1520945798-50640-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 19/22] sev/i386: hmp: add 'info sev' command
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

The command can be used to show the SEV information when memory
encryption is enabled on AMD platform.

Cc: Eric Blake <eblake@redhat.com>
Cc: "Daniel P. Berrangé" <berrange@redhat.com>
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>
Reviewed-by: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hmp-commands-info.hx  | 16 ++++++++++++++++
 hmp.h                 |  1 +
 target/i386/monitor.c | 20 ++++++++++++++++++++
 3 files changed, 37 insertions(+)

diff --git a/hmp-commands-info.hx b/hmp-commands-info.hx
index ad590a4..ddfcd5a 100644
--- a/hmp-commands-info.hx
+++ b/hmp-commands-info.hx
@@ -867,6 +867,22 @@ Display the amount of initially allocated and present hotpluggable (if
 enabled) memory in bytes.
 ETEXI
 
+#if defined(TARGET_I386)
+    {
+        .name       = "sev",
+        .args_type  = "",
+        .params     = "",
+        .help       = "show SEV information",
+        .cmd        = hmp_info_sev,
+    },
+#endif
+
+STEXI
+@item info sev
+@findex info sev
+Show SEV information.
+ETEXI
+
 STEXI
 @end table
 ETEXI
diff --git a/hmp.h b/hmp.h
index b897338..4e2ec37 100644
--- a/hmp.h
+++ b/hmp.h
@@ -143,5 +143,6 @@ void hmp_info_ramblock(Monitor *mon, const QDict *qdict);
 void hmp_hotpluggable_cpus(Monitor *mon, const QDict *qdict);
 void hmp_info_vm_generation_id(Monitor *mon, const QDict *qdict);
 void hmp_info_memory_size_summary(Monitor *mon, const QDict *qdict);
+void hmp_info_sev(Monitor *mon, const QDict *qdict);
 
 #endif
diff --git a/target/i386/monitor.c b/target/i386/monitor.c
index 4eae0a6..64b5e6e 100644
--- a/target/i386/monitor.c
+++ b/target/i386/monitor.c
@@ -29,6 +29,7 @@
 #include "qapi/qmp/qdict.h"
 #include "hw/i386/pc.h"
 #include "sysemu/kvm.h"
+#include "sysemu/sev.h"
 #include "hmp.h"
 #include "qapi/error.h"
 #include "sev_i386.h"
@@ -677,3 +678,22 @@ SevInfo *qmp_query_sev(Error **errp)
 
     return info;
 }
+
+void hmp_info_sev(Monitor *mon, const QDict *qdict)
+{
+    SevInfo *info = sev_get_info();
+
+    if (info && info->enabled) {
+        monitor_printf(mon, "handle: %d\n", info->handle);
+        monitor_printf(mon, "state: %s\n", SevState_str(info->state));
+        monitor_printf(mon, "build: %d\n", info->build_id);
+        monitor_printf(mon, "api version: %d.%d\n",
+                       info->api_major, info->api_minor);
+        monitor_printf(mon, "debug: %s\n",
+                       info->policy & SEV_POLICY_NODBG ? "off" : "on");
+        monitor_printf(mon, "key-sharing: %s\n",
+                       info->policy & SEV_POLICY_NOKS ? "off" : "on");
+    } else {
+        monitor_printf(mon, "SEV is not enabled\n");
+    }
+}
-- 
1.8.3.1
