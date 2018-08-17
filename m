Received: from eggs.gnu.org ([2001:4830:134:3::10]:36284)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1fqXA8-0000dC-Ov
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 01:19:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1fqXA7-0005bg-Ik
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 01:19:04 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:33471)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1fqXA6-0005Ys-Ko
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 01:19:03 -0400
From: "Emilio G. Cota" <cota@braap.org>
Date: Fri, 17 Aug 2018 01:18:52 -0400
Message-Id: <20180817051853.23792-9-cota@braap.org>
In-Reply-To: <20180817051853.23792-1-cota@braap.org>
References: <20180817051853.23792-1-cota@braap.org>
Subject: [Qemu-devel] [PATCH 8/9] hmp-commands: add sync-profile
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Richard Henderson <rth@twiddle.net>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Stefan Weil <sw@weilnetz.de>, Markus Armbruster <armbru@redhat.com>, Peter Xu <peterx@redhat.com>, Fam Zheng <famz@redhat.com>

The command introduced here is just for developers. This means that:

- the interface implemented here could change in the future
- the command is only meant to be used from HMP, not from QMP

Signed-off-by: Emilio G. Cota <cota@braap.org>
---
 hmp.h           |  1 +
 hmp.c           | 24 ++++++++++++++++++++++++
 hmp-commands.hx | 15 +++++++++++++++
 3 files changed, 40 insertions(+)

diff --git a/hmp.h b/hmp.h
index 33354f1bdd..5f1addcca2 100644
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
diff --git a/hmp.c b/hmp.c
index 2aafb50e8e..d94a47f7c7 100644
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
diff --git a/hmp-commands.hx b/hmp-commands.hx
index c1fc747403..db0c681f74 100644
--- a/hmp-commands.hx
+++ b/hmp-commands.hx
@@ -643,6 +643,21 @@ sendkey ctrl-alt-f1
 
 This command is useful to send keys that your graphical user interface
 intercepts at low level, such as @code{ctrl-alt-f1} in X Window.
+ETEXI
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
 ETEXI
 
     {
-- 
2.17.1
