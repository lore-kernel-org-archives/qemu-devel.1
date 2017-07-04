Received: from eggs.gnu.org ([2001:4830:134:3::10]:35617)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dSLl4-0006f1-2e
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 07:12:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dSLl3-0001tI-3j
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 07:12:41 -0400
Received: from mail-wm0-x244.google.com ([2a00:1450:400c:c09::244]:35526)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1dSLl2-0001st-Sz
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 07:12:41 -0400
Received: by mail-wm0-x244.google.com with SMTP id u23so25603576wma.2
	for <qemu-devel@nongnu.org>; Tue, 04 Jul 2017 04:12:40 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue,  4 Jul 2017 13:12:02 +0200
Message-Id: <1499166735-39360-10-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1499166735-39360-1-git-send-email-pbonzini@redhat.com>
References: <1499166735-39360-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH 09/22] monitor: disable "info jit" and "info
 opcount" if !TCG
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: rth@twiddle.net, thuth@redhat.com, anthony.xu@intel.com, berrange@redhat.com, a.rigo@virtualopensystems.com, yang.zhong@intel.com

Reviewed-by: Richard Henderson <rth@twiddle.net>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 accel/tcg/translate-all.c | 5 +++++
 hmp-commands-info.hx      | 4 ++++
 monitor.c                 | 2 ++
 3 files changed, 11 insertions(+)

diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
index 4c1d8c9..093207a 100644
--- a/accel/tcg/translate-all.c
+++ b/accel/tcg/translate-all.c
@@ -1851,6 +1851,11 @@ void dump_exec_info(FILE *f, fprintf_function cpu_fprintf)
 
     tb_lock();
 
+    if (!tcg_enabled()) {
+        cpu_fprintf(f, "TCG not enabled\n");
+        return;
+    }
+
     target_code_size = 0;
     max_target_code_size = 0;
     cross_page = 0;
diff --git a/hmp-commands-info.hx b/hmp-commands-info.hx
index ba98e58..07500ef 100644
--- a/hmp-commands-info.hx
+++ b/hmp-commands-info.hx
@@ -261,6 +261,7 @@ STEXI
 Show memory tree.
 ETEXI
 
+#if defined(CONFIG_TCG)
     {
         .name       = "jit",
         .args_type  = "",
@@ -268,6 +269,7 @@ ETEXI
         .help       = "show dynamic compiler info",
         .cmd        = hmp_info_jit,
     },
+#endif
 
 STEXI
 @item info jit
@@ -275,6 +277,7 @@ STEXI
 Show dynamic compiler info.
 ETEXI
 
+#if defined(CONFIG_TCG)
     {
         .name       = "opcount",
         .args_type  = "",
@@ -282,6 +285,7 @@ ETEXI
         .help       = "show dynamic compiler opcode counters",
         .cmd        = hmp_info_opcount,
     },
+#endif
 
 STEXI
 @item info opcount
diff --git a/monitor.c b/monitor.c
index 4031876..d8ac20f 100644
--- a/monitor.c
+++ b/monitor.c
@@ -1098,6 +1098,7 @@ static void hmp_info_registers(Monitor *mon, const QDict *qdict)
     }
 }
 
+#ifdef CONFIG_TCG
 static void hmp_info_jit(Monitor *mon, const QDict *qdict)
 {
     if (!tcg_enabled()) {
@@ -1113,6 +1114,7 @@ static void hmp_info_opcount(Monitor *mon, const QDict *qdict)
 {
     dump_opcount_info((FILE *)mon, monitor_fprintf);
 }
+#endif
 
 static void hmp_info_history(Monitor *mon, const QDict *qdict)
 {
-- 
1.8.3.1
