Received: from eggs.gnu.org ([2001:4830:134:3::10]:53331)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dv2jX-0002YI-Ob
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 10:45:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dv2jT-0003XC-Hi
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 10:45:43 -0400
Received: from mail-wm0-x22d.google.com ([2a00:1450:400c:c09::22d]:45482)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1dv2jT-0003WZ-B4
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 10:45:39 -0400
Received: by mail-wm0-x22d.google.com with SMTP id q124so2569742wmb.0
	for <qemu-devel@nongnu.org>; Thu, 21 Sep 2017 07:45:39 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Thu, 21 Sep 2017 15:45:34 +0100
Message-Id: <20170921144534.22674-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [RFC PATCH] monitor: add info translate (HACK!)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Richard Henderson <rth@twiddle.net>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Markus Armbruster <armbru@redhat.com>

Currently investigating translation involves enabling debugging flags
and potentially generating large amounts of debug information and
sifting through it. -dfilter helps but often you want to investigate
what's going on in a live system. This patch is an attempt at that.

It adds a "info translate" command which is passed an address. It then
grabs the tb_lock, fiddles with the loglevel flags and then does a
un-cached translation, spewing the output on stderr. There are a
number of open questions:

 - there is currently no safe way to re-direct log output
 - messing with internal qemu_loglevel flags is *eewww*
 - we don't deal with translation flags

We could deal with the inherent racey behaviour by pushing the output
to a async safe function. It also might make sense to be able to
introspect what TB's exist in a given range and then use that
information to re-run the translation live.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 accel/tcg/translate-all.c | 23 +++++++++++++++++++++++
 hmp-commands-info.hx      | 16 ++++++++++++++++
 include/exec/cpu-all.h    |  2 ++
 monitor.c                 | 15 +++++++++++++++
 4 files changed, 56 insertions(+)

diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
index 2d1ed06065..09fc698bb0 100644
--- a/accel/tcg/translate-all.c
+++ b/accel/tcg/translate-all.c
@@ -1947,6 +1947,29 @@ void dump_opcount_info(FILE *f, fprintf_function cpu_fprintf)
     tcg_dump_op_count(f, cpu_fprintf);
 }
 
+/*
+ * To dump translation info we temporally translate the given address
+ * while tweak the log flags to dump information.
+ *
+ * It might make more sense to push this off to an safe async function
+ * to do this in a less racey manner.
+ */
+
+void dump_translate_info(FILE *f, fprintf_function cpu_fprintf,
+                         target_ulong addr, int flags)
+{
+    int old_flags = qemu_loglevel;
+
+    /* grab the lock, currently that means no other translation */
+    tb_lock();
+    qemu_loglevel = flags;
+
+    tb_gen_code(first_cpu, addr, 0, 0, CF_NOCACHE | CF_IGNORE_ICOUNT);
+
+    qemu_loglevel = old_flags;
+    tb_unlock();
+}
+
 #else /* CONFIG_USER_ONLY */
 
 void cpu_interrupt(CPUState *cpu, int mask)
diff --git a/hmp-commands-info.hx b/hmp-commands-info.hx
index 1c6772597d..68f64aff7e 100644
--- a/hmp-commands-info.hx
+++ b/hmp-commands-info.hx
@@ -292,6 +292,22 @@ STEXI
 @item info opcount
 @findex opcount
 Show dynamic compiler opcode counters
+ETEXI
+
+#if defined(CONFIG_TCG)
+    {
+        .name       = "translate",
+        .args_type  = "addr:l,flags:s",
+        .params     = "addr [flags]",
+        .help       = "show translation info",
+        .cmd        = hmp_info_translate,
+    },
+#endif
+
+STEXI
+@item info translate
+@findex translate
+Show dynamic compiler info.
 ETEXI
 
     {
diff --git a/include/exec/cpu-all.h b/include/exec/cpu-all.h
index ffe43d5654..456fd03f44 100644
--- a/include/exec/cpu-all.h
+++ b/include/exec/cpu-all.h
@@ -340,6 +340,8 @@ CPUArchState *cpu_copy(CPUArchState *env);
 
 void dump_exec_info(FILE *f, fprintf_function cpu_fprintf);
 void dump_opcount_info(FILE *f, fprintf_function cpu_fprintf);
+void dump_translate_info(FILE *f, fprintf_function cpu_fprintf,
+                         target_ulong addr, int flags);
 #endif /* !CONFIG_USER_ONLY */
 
 int cpu_memory_rw_debug(CPUState *cpu, target_ulong addr,
diff --git a/monitor.c b/monitor.c
index cd831eaab4..f0cdd54cfb 100644
--- a/monitor.c
+++ b/monitor.c
@@ -1115,6 +1115,21 @@ static void hmp_info_opcount(Monitor *mon, const QDict *qdict)
 {
     dump_opcount_info((FILE *)mon, monitor_fprintf);
 }
+
+static void hmp_info_translate(Monitor *mon, const QDict *qdict)
+{
+    target_ulong addr;
+
+    if (!tcg_enabled()) {
+        error_report("translation information is only available with accel=tcg");
+        return;
+    }
+
+    addr = qdict_get_int(qdict, "addr");
+
+    dump_translate_info((FILE *)mon, monitor_fprintf, addr,
+                        CPU_LOG_TB_IN_ASM | CPU_LOG_TB_OUT_ASM | CPU_LOG_TB_OP);
+}
 #endif
 
 static void hmp_info_history(Monitor *mon, const QDict *qdict)
-- 
2.14.1
