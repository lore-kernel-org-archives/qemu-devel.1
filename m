Return-Path: <SRS0=lwXe=VR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81388C7618F
	for <qemu-devel@archiver.kernel.org>; Sat, 20 Jul 2019 01:04:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 495D721849
	for <qemu-devel@archiver.kernel.org>; Sat, 20 Jul 2019 01:04:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pu4JJLFT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 495D721849
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49050 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hodnt-00048L-Im
	for qemu-devel@archiver.kernel.org; Fri, 19 Jul 2019 21:04:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39999)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <vandersonmr2@gmail.com>) id 1hodmV-0006Ya-Ue
 for qemu-devel@nongnu.org; Fri, 19 Jul 2019 21:03:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vandersonmr2@gmail.com>) id 1hodmU-0006Ic-Rz
 for qemu-devel@nongnu.org; Fri, 19 Jul 2019 21:03:23 -0400
Received: from mail-qk1-x744.google.com ([2607:f8b0:4864:20::744]:43193)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <vandersonmr2@gmail.com>)
 id 1hodmU-0006IP-OF
 for qemu-devel@nongnu.org; Fri, 19 Jul 2019 21:03:22 -0400
Received: by mail-qk1-x744.google.com with SMTP id m14so24563673qka.10
 for <qemu-devel@nongnu.org>; Fri, 19 Jul 2019 18:03:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Q+nw72rF9g/bpUICpo+ScG/tVrJDwS+qDXPM6jCFUOg=;
 b=pu4JJLFTzifIMuTTYOLgZe6JBQoMEIFLAL8GhQWgrqYmzQ6Yp/SudlO/kkHLaaE2ld
 XtUO0rnT2xCDv3P9JPCJ3HWGEsIq1476BNQLIjJMX3/AzsGYBMyJ8Dsl//xt8AfhLEE9
 cSqRP8wd1IRa8rfnmy4X+kA03Ped/4ciEI8ix2E4RbwvYUTfmVI9RVt9aXZBZfollIRJ
 ehrDuK+46ztta80RckTuZ8ClQMKVZpoTophbKXqQ9Am1GMLm0dpMCHUD46GUi/oGL8VF
 tz5UJpBqOdiUQfUMHG3V9SYyje0tTaMZ1fm5lTKdtN0RBDzM2i3cawtlpv6/LtxIAe6f
 TkNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Q+nw72rF9g/bpUICpo+ScG/tVrJDwS+qDXPM6jCFUOg=;
 b=VR7Mow+3P8AMKeBV4MMMAdi9HuZRehZ+pcmm3ggOqURyoWz87vjCANBdW0bq0iKnxB
 D59C2YGgjEjN2ZvjovA1exiBQ+/Z/u+8HZTpZVUpmOfCqyywHix7iBo6IN0RTLFlWiKZ
 +NoVmNkFNgTaSk4zXClXyqzkPl26ZqggUUnuiAjL5nMMSrKf4fow3AhdOwL6ZSvZeVMy
 KnebuxeAlqHOtu4Df5GWFbgdnTA8DRmXD3e4Cdk+rRbH9966qZAZp3Uh9tIchQFNA9VA
 TeFiV3eZuNvsIWEu6CGR/uXalGLxw2aZOCzw7QmTSykRVqWzNjgVfAFu/Hz3o15+VbcJ
 Rbpg==
X-Gm-Message-State: APjAAAXaOaSgWFhDZQEVnCvw1iVuMVaumxpvnaZoU6EoDBOXDgfabuKO
 /Os2R5zWPik9xG+wSBwk1nKzmw/Z
X-Google-Smtp-Source: APXvYqyvqf90yULGN33aAIM7hno/P27dbpH4fwtD6WZ+40A1xNgll20VDEjQXJy3XSU3DqVcZ1zPzA==
X-Received: by 2002:a37:6c8:: with SMTP id 191mr39277192qkg.102.1563584602037; 
 Fri, 19 Jul 2019 18:03:22 -0700 (PDT)
Received: from vanderson-lmcad.domain.name ([177.137.96.41])
 by smtp.googlemail.com with ESMTPSA id g10sm13405115qki.37.2019.07.19.18.03.20
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Fri, 19 Jul 2019 18:03:21 -0700 (PDT)
From: vandersonmr <vandersonmr2@gmail.com>
To: qemu-devel@nongnu.org
Date: Fri, 19 Jul 2019 22:02:33 -0300
Message-Id: <20190720010235.32444-6-vandersonmr2@gmail.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190720010235.32444-1-vandersonmr2@gmail.com>
References: <20190720010235.32444-1-vandersonmr2@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::744
Subject: [Qemu-devel] [PATCH v4 5/7] log: adding -d tb_stats to control
 tbstats
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
Cc: vandersonmr <vandersonmr2@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Adding -d tb_stats:[limit:[all|jit|exec]] to control TBStatistics
collection. "limit" is used to limit the number of TBStats in the
linux-user dump. [all|jit|exec] control the profilling level used
by the TBStats: all, only jit stats or only execution count stats.

Signed-off-by: Vanderson M. do Rosario <vandersonmr2@gmail.com>
---
 include/qemu/log.h |  1 +
 util/log.c         | 34 ++++++++++++++++++++++++++++++++++
 2 files changed, 35 insertions(+)

diff --git a/include/qemu/log.h b/include/qemu/log.h
index 8cdfc268ca..93642603e5 100644
--- a/include/qemu/log.h
+++ b/include/qemu/log.h
@@ -45,6 +45,7 @@ static inline bool qemu_log_separate(void)
 /* LOG_TRACE (1 << 15) is defined in log-for-trace.h */
 #define CPU_LOG_TB_OP_IND  (1 << 16)
 #define CPU_LOG_TB_FPU     (1 << 17)
+#define CPU_LOG_TB_STATS   (1 << 18)
 
 /* Lock output for a series of related logs.  Since this is not needed
  * for a single qemu_log / qemu_log_mask / qemu_log_mask_and_addr, we
diff --git a/util/log.c b/util/log.c
index f81653d712..8109d19afb 100644
--- a/util/log.c
+++ b/util/log.c
@@ -30,6 +30,7 @@ FILE *qemu_logfile;
 int qemu_loglevel;
 static int log_append = 0;
 static GArray *debug_regions;
+int32_t max_num_hot_tbs_to_dump;
 
 /* Return the number of characters emitted.  */
 int qemu_log(const char *fmt, ...)
@@ -273,6 +274,8 @@ const QEMULogItem qemu_log_items[] = {
     { CPU_LOG_TB_NOCHAIN, "nochain",
       "do not chain compiled TBs so that \"exec\" and \"cpu\" show\n"
       "complete traces" },
+    { CPU_LOG_TB_STATS, "tb_stats[:limit:(all,jit,exec)]",
+      "show TBs statistics (until given a limit) ordered by their hotness.\n" },
     { 0, NULL, NULL },
 };
 
@@ -294,6 +297,37 @@ int qemu_str_to_log_mask(const char *str)
             trace_enable_events((*tmp) + 6);
             mask |= LOG_TRACE;
 #endif
+        } else if (g_str_has_prefix(*tmp, "tb_stats")) {
+            if (g_str_has_prefix(*tmp, "tb_stats:") && (*tmp)[9] != '\0') {
+
+                if (!g_ascii_isdigit(*((*tmp) + 9))) {
+                    fprintf(stderr,
+                            "should be a number follow by [all|jit|exec], as tb_stats:10:all\n");
+                    exit(1);
+                }
+                /* get limit */
+                max_num_hot_tbs_to_dump = atoi((*tmp) + 9);
+
+                /* get profilling level */
+                char *s = (*tmp) + 9;
+                while (*s != '\0') {
+                    if (*s++ == ':') {
+                        break;
+                    }
+                }
+                if (g_str_equal(s, "jit") == 0) {
+                    set_default_tbstats_flag(TB_JIT_STATS);
+                } else if (g_str_equal(s, "exec") == 0) {
+                    set_default_tbstats_flag(TB_EXEC_STATS);
+                } else {
+                    set_default_tbstats_flag(TB_JIT_STATS | TB_EXEC_STATS);
+                }
+            } else {
+                set_default_tbstats_flag(TB_JIT_STATS | TB_EXEC_STATS);
+            }
+
+            mask |= CPU_LOG_TB_STATS;
+            enable_collect_tb_stats();
         } else {
             for (item = qemu_log_items; item->mask != 0; item++) {
                 if (g_str_equal(*tmp, item->name)) {
-- 
2.22.0


