Return-Path: <SRS0=7PyC=UX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 178D2C43613
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2019 06:02:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D5E252083D
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2019 06:02:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bgwUEwz+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D5E252083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48142 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hfI3U-0005yV-2k
	for qemu-devel@archiver.kernel.org; Mon, 24 Jun 2019 02:02:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35140)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <vandersonmr2@gmail.com>) id 1hfHxI-0000jh-01
 for qemu-devel@nongnu.org; Mon, 24 Jun 2019 01:55:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vandersonmr2@gmail.com>) id 1hfHxH-00040M-1F
 for qemu-devel@nongnu.org; Mon, 24 Jun 2019 01:55:51 -0400
Received: from mail-qt1-x841.google.com ([2607:f8b0:4864:20::841]:41255)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <vandersonmr2@gmail.com>)
 id 1hfHxG-0003zV-TO
 for qemu-devel@nongnu.org; Mon, 24 Jun 2019 01:55:50 -0400
Received: by mail-qt1-x841.google.com with SMTP id d17so13222051qtj.8
 for <qemu-devel@nongnu.org>; Sun, 23 Jun 2019 22:55:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=sk8uSCdQ3hpnmo3bU04NmJku/FzpWj9gaS0iIIIjZe8=;
 b=bgwUEwz+jk2hAR+SpgR14G2rp6yZetZ3n2wHPX7LJKei0CVC2CjGn5YgzstJNtLagu
 AMdkFigZ/FvWyJI8IJpaM3FMdNcCFu1FOxndDHdgYzRVrhHFcJpoJQzZhjBSnibIGI6j
 dEnfmfTxoCUJwys2qUUvdbGJ+fhUlg+/gZDv5y/SZhckQZRf9G6SDD0oT8FFjBOLSZEn
 v4H2PQBv0KdA13WaIcf0Z55qBaqkl8TLXG8hyIie4kVpVwSoCcq6jgsaMyRN/QJ7ACuW
 7Fmji7pRCcN0d9deR0WvS8bPd6oFHt0+68IU5v6yY/WPlIeZYxIiloiIZR/7ujm0sfmn
 RYmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=sk8uSCdQ3hpnmo3bU04NmJku/FzpWj9gaS0iIIIjZe8=;
 b=QqVEuBUAG4A8QxENfvAoVm8WryYyeLwD0RLV17oGCFiFzWGTPyZUnJzhZBFK0XheQs
 WXWOjJI/TaO0JLEg66qgqJQwCxRisTALC/tFWaR3zS6mY4qx9doVsjxPnJ2ysrD6DpKD
 e6TpIaEzrsIjVdUKc9CHnxNFzsAvaZtOuP0mpbPOP5IjKaFr/7f7V7g9rVVoKMV2CtzP
 sUoXYhVooBfIWhOOHoeSQsi+ST0LJRVNcJgg4cYn+q5mHJRdWdjLyDWDcK/2o5RJPEPh
 IaO9C86fd/iXmmKL4ZL1quesVhggzy5JKWsXZIcMPgmkRG7ZsEdn3q9N8QpHDgxR5IoG
 JTtg==
X-Gm-Message-State: APjAAAVj5kBVrWXVU2toHiNyYSyGRmhZEzJXhaJUzO4naY795ZVoiF9a
 xm4lbd8ejQuykN4BUNXTrHbP8AmfUKs=
X-Google-Smtp-Source: APXvYqwfn7KY9bzRr/H8RSQIkhLEhALGt1LNPTy29pzS9uW0mbyynqjl8+hF9QWiZ1WDWZyjG9yPGQ==
X-Received: by 2002:aed:24d9:: with SMTP id
 u25mr130587406qtc.111.1561355750187; 
 Sun, 23 Jun 2019 22:55:50 -0700 (PDT)
Received: from localhost.localdomain ([2804:7f4:548d:5237:c368:80a0:cb96:64bf])
 by smtp.googlemail.com with ESMTPSA id t80sm5154440qka.87.2019.06.23.22.55.48
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Sun, 23 Jun 2019 22:55:49 -0700 (PDT)
From: vandersonmr <vandersonmr2@gmail.com>
To: qemu-devel@nongnu.org
Date: Mon, 24 Jun 2019 02:54:42 -0300
Message-Id: <20190624055442.2973-5-vandersonmr2@gmail.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190624055442.2973-1-vandersonmr2@gmail.com>
References: <20190624055442.2973-1-vandersonmr2@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::841
Subject: [Qemu-devel] [PATCH v2 4/4] adding -d hot_tbs:limit command line
 option
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
Cc: Riku Voipio <riku.voipio@iki.fi>, vandersonmr <vandersonmr2@gmail.com>,
 Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

add option to dump the N most hot TB blocks.
-d hot_tbs:N

Signed-off-by: vandersonmr <vandersonmr2@gmail.com>
---
 include/qemu/log-for-trace.h | 2 ++
 linux-user/exit.c            | 3 +++
 util/log.c                   | 9 +++++++++
 3 files changed, 14 insertions(+)

diff --git a/include/qemu/log-for-trace.h b/include/qemu/log-for-trace.h
index 2f0a5b080e..d65eb83037 100644
--- a/include/qemu/log-for-trace.h
+++ b/include/qemu/log-for-trace.h
@@ -21,6 +21,8 @@
 /* Private global variable, don't use */
 extern int qemu_loglevel;
 
+extern int32_t max_num_hot_tbs_to_dump;
+
 #define LOG_TRACE          (1 << 15)
 
 /* Returns true if a bit is set in the current loglevel mask */
diff --git a/linux-user/exit.c b/linux-user/exit.c
index bdda720553..08b86dfd61 100644
--- a/linux-user/exit.c
+++ b/linux-user/exit.c
@@ -28,6 +28,9 @@ extern void __gcov_dump(void);
 
 void preexit_cleanup(CPUArchState *env, int code)
 {
+    if (qemu_loglevel_mask(CPU_LOG_HOT_TBS)) {
+        tb_dump_exec_freq(max_num_hot_tbs_to_dump);
+    }
 #ifdef TARGET_GPROF
         _mcleanup();
 #endif
diff --git a/util/log.c b/util/log.c
index 1d1b33f7d9..e71c663143 100644
--- a/util/log.c
+++ b/util/log.c
@@ -30,6 +30,7 @@ FILE *qemu_logfile;
 int qemu_loglevel;
 static int log_append = 0;
 static GArray *debug_regions;
+int32_t max_num_hot_tbs_to_dump;
 
 /* Return the number of characters emitted.  */
 int qemu_log(const char *fmt, ...)
@@ -273,6 +274,9 @@ const QEMULogItem qemu_log_items[] = {
     { CPU_LOG_TB_NOCHAIN, "nochain",
       "do not chain compiled TBs so that \"exec\" and \"cpu\" show\n"
       "complete traces" },
+    { CPU_LOG_HOT_TBS, "hot_tbs(:limit)",
+      "show TBs (until given a limit) ordered by their hotness.\n"
+      "(if no limit is given, show all)" },
     { 0, NULL, NULL },
 };
 
@@ -294,6 +298,11 @@ int qemu_str_to_log_mask(const char *str)
             trace_enable_events((*tmp) + 6);
             mask |= LOG_TRACE;
 #endif
+        } else if (g_str_has_prefix(*tmp, "hot_tbs")) {
+            if (g_str_has_prefix(*tmp, "hot_tbs:") && (*tmp)[8] != '\0') {
+                max_num_hot_tbs_to_dump = atoi((*tmp) + 8);
+            }
+            mask |= CPU_LOG_HOT_TBS;
         } else {
             for (item = qemu_log_items; item->mask != 0; item++) {
                 if (g_str_equal(*tmp, item->name)) {
-- 
2.22.0


