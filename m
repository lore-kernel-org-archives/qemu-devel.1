Return-Path: <SRS0=TwS2=YA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0194C47404
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Oct 2019 15:36:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9B33320700
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Oct 2019 15:36:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IeovF85J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B33320700
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46278 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iHV4E-0000IM-9f
	for qemu-devel@archiver.kernel.org; Mon, 07 Oct 2019 11:36:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48939)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iHUwN-0002dd-Id
 for qemu-devel@nongnu.org; Mon, 07 Oct 2019 11:28:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iHUwL-0005CA-8b
 for qemu-devel@nongnu.org; Mon, 07 Oct 2019 11:28:51 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:41996)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iHUwK-0005Bc-VM
 for qemu-devel@nongnu.org; Mon, 07 Oct 2019 11:28:49 -0400
Received: by mail-wr1-x443.google.com with SMTP id n14so15801927wrw.9
 for <qemu-devel@nongnu.org>; Mon, 07 Oct 2019 08:28:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=7gCV4zFcfwB/MqyFrxlDjzbDS1zMRutLLkzPj4QW9Yk=;
 b=IeovF85JWo8oxbPzCVzRpSEbLanGm4HKDdhNpt0WT4SqJtnnEVhnx28G+vo6fto/T+
 3yCJxBM6VcRPMa2M2zu1GMDqbm/l31qkQYgVujlZyaUtwSXw1M/vXaagriucXfin2TS7
 FInyMJUXKTO6f2rTfmaJXFTPrPuEyiL+Y28tUcRg4Q9BBActsHDZXVFfEWYrA889ncoM
 7TTsD4G7S8VYpnVGpz/43Gpw1Fhe/y90p8EwVAh3pr/lcGECZe2oIkMMnzuuevbwPgZw
 xm9iiLVVWD4+jTQ4GQRKvuE/EoAf1FXNdblmLsAyOpo9V/BaHgT6c7K5pNZO7cPaAD03
 VOaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=7gCV4zFcfwB/MqyFrxlDjzbDS1zMRutLLkzPj4QW9Yk=;
 b=tGvF+ZZ+Xzx1gdsgYmtuysUP3pRR0TMafw+P3K2077N8stezm1kZpZwH8e2JdR1qgW
 TXIj3J4C76Iy2ceC7OCwjEkl8/3WDjUjxEgy9+fDX76kR9JfIrodXi0qw55kL1wIdJp9
 5jW7MdK8X+Bmy5+3gM39Ag4Ips4Mvtqr8I1CSktPzDEh+Uxv6Km8HTwhC7KnwYzvnApP
 n5xftYBqYMeddOyD1Rzr73HUdds3QC+2vvqf1OAc+Rz6uy18O4yiqW2yNiZAREDB9zlf
 rMY2F8hPAAB1zT+55Kald3lXg44h/XPibE0S/kWOfXK4DnTglqP7c8LHoYGJ56Nplp40
 RSnA==
X-Gm-Message-State: APjAAAXZOus+s3JuLTJzzQc0e5CwqQX/hFXveb8d4FHHG+opwQHa60Nc
 T9bCBekUecInjCP4EC7QwaNzyA==
X-Google-Smtp-Source: APXvYqyTLkdYcHSmztmzAOfAANnuxIAAt+AnxDeFfBzFrVrBhJSb41bUTDwVSi65hh9gMMLQFGszIA==
X-Received: by 2002:adf:f950:: with SMTP id q16mr8124174wrr.225.1570462127811; 
 Mon, 07 Oct 2019 08:28:47 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id 207sm21693651wme.17.2019.10.07.08.28.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Oct 2019 08:28:42 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 64F731FF9A;
 Mon,  7 Oct 2019 16:28:40 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH  v9 10/13] tb-stats: dump hot TBs at the end of the execution
Date: Mon,  7 Oct 2019 16:28:36 +0100
Message-Id: <20191007152839.30804-11-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191007152839.30804-1-alex.bennee@linaro.org>
References: <20191007152839.30804-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::443
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: "Vanderson M. do Rosario" <vandersonmr2@gmail.com>,
 Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>,
 cota@braap.org, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: "Vanderson M. do Rosario" <vandersonmr2@gmail.com>

Dump the hottest TBs if -d tb_stats,dump_limit=N is used.

Example of output for the 3 hottest TBs:

TB id:1 | phys:0x34d54 virt:0x0000000000034d54 flags:0x0000f0
        | exec:4828932/0 guest inst cov:16.38%
        | trans:1 ints: g:3 op:82 op_opt:34 spills:3
        | h/g (host bytes / guest insts): 90.666664
        | time to gen at 2.4GHz => code:3150.83(ns) IR:712.08(ns)
        | targets: 0x0000000000034d5e (id:11), 0x0000000000034d0d (id:2)

TB id:2 | phys:0x34d0d virt:0x0000000000034d0d flags:0x0000f0
        | exec:4825842/0 guest inst cov:21.82%
        | trans:1 ints: g:4 op:80 op_opt:38 spills:2
        | h/g (host bytes / guest insts): 84.000000
        | time to gen at 2.4GHz => code:3362.92(ns) IR:793.75(ns)
        | targets: 0x0000000000034d19 (id:12), 0x0000000000034d54 (id:1)

TB id:3 | phys:0xec1c1 virt:0x00000000000ec1c1 flags:0x0000b0
        | exec:872032/0 guest inst cov:1.97%
        | trans:1 ints: g:2 op:56 op_opt:26 spills:1
        | h/g (host bytes / guest insts): 68.000000
        | time to gen at 2.4GHz => code:1692.08(ns) IR:473.75(ns)
        | targets: 0x00000000000ec1c5 (id:4), 0x00000000000ec1cb (id:13)

Signed-off-by: Vanderson M. do Rosario <vandersonmr2@gmail.com>
Message-Id: <20190829173437.5926-12-vandersonmr2@gmail.com>
[AJB: fix authorship, ad softmmu support]
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

---
AJB:
  - move vars into tb_stats.c
  - support softmmu as well
---
 accel/tcg/tb-stats.c          | 21 +++++++++++++++++++++
 include/exec/tb-stats-dump.h  | 21 +++++++++++++++++++++
 include/exec/tb-stats-flags.h |  1 +
 linux-user/exit.c             |  2 ++
 stubs/tb-stats.c              |  5 +++++
 util/log.c                    |  4 ++--
 vl.c                          |  2 ++
 7 files changed, 54 insertions(+), 2 deletions(-)
 create mode 100644 include/exec/tb-stats-dump.h

diff --git a/accel/tcg/tb-stats.c b/accel/tcg/tb-stats.c
index 3c1cc8cd06..60a9ee4b9c 100644
--- a/accel/tcg/tb-stats.c
+++ b/accel/tcg/tb-stats.c
@@ -15,6 +15,7 @@
 #include "qemu/qemu-print.h"
 
 #include "exec/tb-stats.h"
+#include "exec/tb-stats-dump.h"
 
 /* TBStatistic collection controls */
 enum TBStatsStatus {
@@ -26,6 +27,7 @@ enum TBStatsStatus {
 
 static enum TBStatsStatus tcg_collect_tb_stats;
 static uint32_t default_tbstats_flag;
+static int max_dump_tbs;
 /* only accessed in safe work */
 static GList *last_search;
 static int id = 1; /* display_id increment counter */
@@ -591,6 +593,20 @@ void dump_tb_info(int id, int log_mask, bool use_monitor)
 }
 
 
+/*
+ * Dump the final stats
+ */
+void tb_stats_dump(void)
+{
+    if (!tb_stats_collection_enabled()) {
+        return;
+    }
+
+    dump_tbs_info(max_dump_tbs, SORT_BY_HOTNESS, false);
+}
+
+/* TBStatistic collection controls */
+
 void enable_collect_tb_stats(void)
 {
     init_tb_stats_htable_if_not();
@@ -639,3 +655,8 @@ void set_default_tbstats_flag(uint32_t flags)
 {
     default_tbstats_flag = flags;
 }
+
+void set_tbstats_max_tbs(int max)
+{
+    max_dump_tbs = max;
+}
diff --git a/include/exec/tb-stats-dump.h b/include/exec/tb-stats-dump.h
new file mode 100644
index 0000000000..197c6148e9
--- /dev/null
+++ b/include/exec/tb-stats-dump.h
@@ -0,0 +1,21 @@
+/*
+ * TB Stats common dump functions across sysemu/linux-user
+ *
+ * Copyright (c) 2019 Linaro
+ *
+ * SPDX-License-Identifier: GPL-3.0-or-later
+ */
+
+#ifndef _TB_STATS_DUMP_H_
+#define _TB_STATS_DUMP_H_
+
+/**
+ * tb_stats_dump: dump final tb_stats at end of execution
+ */
+#ifdef CONFIG_TCG
+void tb_stats_dump(void);
+#else
+static inline void tb_stats_dump(void) { /* do nothing */ };
+#endif
+
+#endif /* _TB_STATS_DUMP_H_ */
diff --git a/include/exec/tb-stats-flags.h b/include/exec/tb-stats-flags.h
index 252304d685..a5bf44f824 100644
--- a/include/exec/tb-stats-flags.h
+++ b/include/exec/tb-stats-flags.h
@@ -24,6 +24,7 @@ void pause_collect_tb_stats(void);
 bool tb_stats_collection_enabled(void);
 bool tb_stats_collection_paused(void);
 
+void set_tbstats_max_tbs(int max);
 uint32_t get_default_tbstats_flag(void);
 void set_default_tbstats_flag(uint32_t);
 
diff --git a/linux-user/exit.c b/linux-user/exit.c
index bdda720553..c00700bb96 100644
--- a/linux-user/exit.c
+++ b/linux-user/exit.c
@@ -21,6 +21,7 @@
 #ifdef TARGET_GPROF
 #include <sys/gmon.h>
 #endif
+#include "exec/tb-stats-dump.h"
 
 #ifdef CONFIG_GCOV
 extern void __gcov_dump(void);
@@ -35,4 +36,5 @@ void preexit_cleanup(CPUArchState *env, int code)
         __gcov_dump();
 #endif
         gdb_exit(env, code);
+        tb_stats_dump();
 }
diff --git a/stubs/tb-stats.c b/stubs/tb-stats.c
index d212c2a1fa..a3e1406b88 100644
--- a/stubs/tb-stats.c
+++ b/stubs/tb-stats.c
@@ -21,6 +21,11 @@ bool tb_stats_collection_enabled(void)
     return false;
 }
 
+void set_tbstats_max_tbs(int max)
+{
+    return;
+}
+
 void set_default_tbstats_flag(uint32_t flags)
 {
     return;
diff --git a/util/log.c b/util/log.c
index fa78e2bca9..b6e4f71c1f 100644
--- a/util/log.c
+++ b/util/log.c
@@ -32,7 +32,6 @@ FILE *qemu_logfile;
 int qemu_loglevel;
 static int log_append = 0;
 static GArray *debug_regions;
-int32_t max_num_hot_tbs_to_dump;
 static bool to_monitor;
 bool to_string;
 
@@ -337,7 +336,8 @@ int qemu_str_to_log_mask(const char *str)
             enable_collect_tb_stats();
         } else if (tb_stats_collection_enabled() &&
                    g_str_has_prefix(*tmp, "dump_limit=")) {
-            max_num_hot_tbs_to_dump = atoi((*tmp) + 11);
+            int hot_tbs = atoi((*tmp) + 11);
+            set_tbstats_max_tbs(hot_tbs);
         } else if (tb_stats_collection_enabled() &&
                    g_str_has_prefix(*tmp, "level=")) {
             uint32_t flags = 0;
diff --git a/vl.c b/vl.c
index 781fddaf18..9ceb401007 100644
--- a/vl.c
+++ b/vl.c
@@ -35,6 +35,7 @@
 #include "sysemu/runstate.h"
 #include "sysemu/seccomp.h"
 #include "sysemu/tcg.h"
+#include "exec/tb-stats-dump.h"
 
 #ifdef CONFIG_SDL
 #if defined(__APPLE__) || defined(main)
@@ -4514,6 +4515,7 @@ int main(int argc, char **argv, char **envp)
     /* No more vcpu or device emulation activity beyond this point */
     vm_shutdown();
 
+    tb_stats_dump();
     job_cancel_sync_all();
     bdrv_close_all();
 
-- 
2.20.1


