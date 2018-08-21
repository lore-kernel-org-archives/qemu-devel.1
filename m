Received: from eggs.gnu.org ([2001:4830:134:3::10]:33474)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1fsA4Y-0001x6-Ta
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 13:04:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1fsA4V-0006lg-6a
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 13:04:02 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e]:33788)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1fsA4U-000645-6Y
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 13:03:58 -0400
Received: by mail-wr1-x42e.google.com with SMTP id v90-v6so13315892wrc.0
	for <qemu-devel@nongnu.org>; Tue, 21 Aug 2018 10:03:31 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 21 Aug 2018 19:01:57 +0200
Message-Id: <1534870966-9287-26-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1534870966-9287-1-git-send-email-pbonzini@redhat.com>
References: <1534870966-9287-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 25/74] hmp-commands: add sync-profile
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: "Emilio G. Cota" <cota@braap.org>

From: "Emilio G. Cota" <cota@braap.org>

The command introduced here is just for developers. This means that:

- the interface implemented here could change in the future
- the command is only meant to be used from HMP, not from QMP

Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Signed-off-by: Emilio G. Cota <cota@braap.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hmp-commands.hx | 15 +++++++++++++++
 hmp.c           | 24 ++++++++++++++++++++++++
 hmp.h           |  1 +
 3 files changed, 40 insertions(+)

diff --git a/hmp-commands.hx b/hmp-commands.hx
index c1fc747..db0c681 100644
--- a/hmp-commands.hx
+++ b/hmp-commands.hx
@@ -644,6 +644,21 @@ sendkey ctrl-alt-f1
 This command is useful to send keys that your graphical user interface
 intercepts at low level, such as @code{ctrl-alt-f1} in X Window.
 ETEXI
+    {
+        .name       = "sync-profile",
+        .args_type  = "op:s?",
+        .params     = "[on|off|reset]",
+        .help       = "enable, disable or reset synchronization profiling. "
+                      "With no arguments, prints whether profiling is on or off.",
+        .cmd        = hmp_sync_profile,
+    },
+
+STEXI
+@item sync-profile [on|off|reset]
+@findex sync-profile
+Enable, disable or reset synchronization profiling. With no arguments, prints
+whether profiling is on or off.
+ETEXI
 
     {
         .name       = "system_reset",
diff --git a/hmp.c b/hmp.c
index 2aafb50..d94a47f 100644
--- a/hmp.c
+++ b/hmp.c
@@ -1062,6 +1062,30 @@ void hmp_stop(Monitor *mon, const QDict *qdict)
     qmp_stop(NULL);
 }
 
+void hmp_sync_profile(Monitor *mon, const QDict *qdict)
+{
+    const char *op = qdict_get_try_str(qdict, "op");
+
+    if (op == NULL) {
+        bool on = qsp_is_enabled();
+
+        monitor_printf(mon, "sync-profile is %s\n", on ? "on" : "off");
+        return;
+    }
+    if (!strcmp(op, "on")) {
+        qsp_enable();
+    } else if (!strcmp(op, "off")) {
+        qsp_disable();
+    } else if (!strcmp(op, "reset")) {
+        qsp_reset();
+    } else {
+        Error *err = NULL;
+
+        error_setg(&err, QERR_INVALID_PARAMETER, op);
+        hmp_handle_error(mon, &err);
+    }
+}
+
 void hmp_system_reset(Monitor *mon, const QDict *qdict)
 {
     qmp_system_reset(NULL);
diff --git a/hmp.h b/hmp.h
index 33354f1..5f1addc 100644
--- a/hmp.h
+++ b/hmp.h
@@ -42,6 +42,7 @@ void hmp_info_tpm(Monitor *mon, const QDict *qdict);
 void hmp_info_iothreads(Monitor *mon, const QDict *qdict);
 void hmp_quit(Monitor *mon, const QDict *qdict);
 void hmp_stop(Monitor *mon, const QDict *qdict);
+void hmp_sync_profile(Monitor *mon, const QDict *qdict);
 void hmp_system_reset(Monitor *mon, const QDict *qdict);
 void hmp_system_powerdown(Monitor *mon, const QDict *qdict);
 void hmp_exit_preconfig(Monitor *mon, const QDict *qdict);
-- 
1.8.3.1
