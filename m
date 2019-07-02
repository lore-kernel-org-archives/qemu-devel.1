Return-Path: <SRS0=9yXi=U7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90ABBC5B57D
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 21:16:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5C1DF2189E
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 21:16:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GD1xtf8D"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C1DF2189E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57644 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hiQ8r-0007LM-Mn
	for qemu-devel@archiver.kernel.org; Tue, 02 Jul 2019 17:16:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45192)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <vandersonmr2@gmail.com>) id 1hiPvG-00081V-Ht
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 17:02:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vandersonmr2@gmail.com>) id 1hiPvE-0003xx-Qa
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 17:02:42 -0400
Received: from mail-qt1-x829.google.com ([2607:f8b0:4864:20::829]:39553)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <vandersonmr2@gmail.com>)
 id 1hiPvE-0002bS-GY
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 17:02:40 -0400
Received: by mail-qt1-x829.google.com with SMTP id i34so128760qta.6
 for <qemu-devel@nongnu.org>; Tue, 02 Jul 2019 14:00:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=JHuUCbiawgHtGiPzef6nyhJfeqGU4xs0hrBmvHTrHLU=;
 b=GD1xtf8DbBzO0XzxoZ54qZZr1buTXkrQFOkBChTMIkZ5mEoAp3k+ExVKAIoNG52LLL
 zALRURZgIzvBeG2UNv2iguoFVyIShCH2xokb2O/JmvQZovsBpDhSWui0k+FldVVz35zB
 X9o2NaJezGM895KPKu5x0alWChDAS6DjMSM8pufRCdJAbkG/gtKyWjccvA7XzrDUGlvP
 spuhwZ1levUs8IxMPQr1MJaY7z32t6Cf+ZpHkbTe3NWR/M72M1knrjx+c2RrhC3AIWUA
 9vvzBuOlq3GZjhXwWvqv2i8Wx9s1/utVx50S6+mnpBeefKmFlDc4RksAZyHX20FI9U61
 gO3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=JHuUCbiawgHtGiPzef6nyhJfeqGU4xs0hrBmvHTrHLU=;
 b=SezQHmHnYthJ3QdHVrum3gtnlrksihILJya9vHVlc+x4e6YUtSi4w8z5dI1K7oiQ+o
 Aav/eqeAOAWzoprON3xwJwThI5HOcyrsybi+k1hvmhmeNO8wY2ALVW5SKBuAO4itatV7
 Pd/xqWwCgnXVClxg4TIMqsnqXgvGQHOEGD/g+qiOtnVsZzyl3i4Wq0FZRiZfDgmoD89H
 9bqCpQeYOKMEj/+J4vsGqCPpfJOHoogY7Ks7gCxSfqwqKq0Oc+msw8DKGNM9Vc6BG/fa
 XllP3q7XpBbnLQvr6J0Qaq7E7xnLYp2vbxFgUFifvRu3/zd5YmeLbwFYsomi+2IJsdF8
 p0AQ==
X-Gm-Message-State: APjAAAWIpapKs8YhJiAK65RBzY/hNJWyfvgr3CDzx3G7ZM/pTojMQ6uW
 K9ZDahY7wvto6VFahCGnkfSMtq57Mvo=
X-Google-Smtp-Source: APXvYqyq5GhQKxOkqDZdkyUI0Lyp4oPihc4SoZ6iaR3eTDTATWszvvcVhK+ygp+xFhcDV/nStrgJvQ==
X-Received: by 2002:ac8:2cfc:: with SMTP id 57mr26785863qtx.194.1562101256429; 
 Tue, 02 Jul 2019 14:00:56 -0700 (PDT)
Received: from vanderson-lmcad.HotSpot300 ([189.61.239.22])
 by smtp.googlemail.com with ESMTPSA id
 s127sm6770979qkd.107.2019.07.02.14.00.54
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Tue, 02 Jul 2019 14:00:56 -0700 (PDT)
From: vandersonmr <vandersonmr2@gmail.com>
To: qemu-devel@nongnu.org
Date: Tue,  2 Jul 2019 18:00:16 -0300
Message-Id: <20190702210017.4275-5-vandersonmr2@gmail.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190702210017.4275-1-vandersonmr2@gmail.com>
References: <20190702210017.4275-1-vandersonmr2@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::829
Subject: [Qemu-devel] [PATCH v3 5/6] monitor: adding info tb and tbs to
 monitor
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
Cc: vandersonmr <vandersonmr2@gmail.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

adding options to list tbs by some metric and
investigate their code.

Signed-off-by: Vanderson M. do Rosario <vandersonmr2@gmail.com>
---
 hmp-commands-info.hx | 22 ++++++++++++++
 monitor/misc.c       | 69 ++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 91 insertions(+)

diff --git a/hmp-commands-info.hx b/hmp-commands-info.hx
index c59444c461..0b8c0de95d 100644
--- a/hmp-commands-info.hx
+++ b/hmp-commands-info.hx
@@ -288,6 +288,28 @@ ETEXI
         .params     = "",
         .help       = "show dynamic compiler info",
         .cmd        = hmp_info_jit,
+    {
+        .name       = "tbs",
+        .args_type  = "number:i?,sortedby:s?",
+        .params     = "[number sortedby]",
+        .help       = "show a [number] translated blocks sorted by [sortedby]"
+                      "sortedby opts: hotness hg",
+        .cmd        = hmp_info_tbs,
+    },
+    {
+        .name       = "tb",
+        .args_type  = "id:i,flags:s?",
+        .params     = "id [log1[,...] flags]",
+        .help       = "show information about one translated block by id",
+        .cmd        = hmp_info_tb,
+    },
+    {
+        .name       = "coverset",
+        .args_type  = "number:i?",
+        .params     = "[number]",
+        .help       = "show hottest translated blocks neccesary to cover"
+                      "[number]% of the execution count",
+        .cmd        = hmp_info_coverset,
     },
 #endif
 
diff --git a/monitor/misc.c b/monitor/misc.c
index bf9faceb86..1fb4d75871 100644
--- a/monitor/misc.c
+++ b/monitor/misc.c
@@ -469,6 +469,75 @@ static void hmp_info_jit(Monitor *mon, const QDict *qdict)
     dump_drift_info();
 }
 
+static void hmp_info_tbs(Monitor *mon, const QDict *qdict)
+{
+    int n;
+    const char *s = NULL;
+    if (!tcg_enabled()) {
+        error_report("TB information is only available with accel=tcg");
+        return;
+    }
+    if (!tb_ctx.tb_stats.map) {
+        error_report("no TB information recorded");
+        return;
+    }
+
+    n = qdict_get_try_int(qdict, "number", 10);
+    s = qdict_get_try_str(qdict, "sortedby");
+
+    int sortedby = 0;
+    if (s == NULL || strcmp(s, "hotness") == 0) {
+        sortedby = SORT_BY_HOTNESS;
+    } else if (strcmp(s, "hg") == 0) {
+        sortedby = SORT_BY_HG;
+    }
+
+    dump_tbs_info(n, sortedby, true);
+}
+
+static void hmp_info_tb(Monitor *mon, const QDict *qdict)
+{
+    const int id = qdict_get_int(qdict, "id");
+    const char *flags = qdict_get_try_str(qdict, "flags");
+    int mask;
+
+    if (!tcg_enabled()) {
+        error_report("TB information is only available with accel=tcg");
+        return;
+    }
+
+    mask = flags ? qemu_str_to_log_mask(flags) : CPU_LOG_TB_IN_ASM;
+
+    if (!mask) {
+        help_cmd(mon, "log");
+        return;
+    }
+
+    dump_tb_info(id, mask, true);
+}
+
+static void hmp_info_coverset(Monitor *mon, const QDict *qdict)
+{
+    int n;
+    if (!tcg_enabled()) {
+        error_report("TB information is only available with accel=tcg");
+        return;
+    }
+    if (!qemu_loglevel_mask(CPU_LOG_HOT_TBS)) {
+        error_report("TB information not being recorded");
+        return;
+    }
+
+    n = qdict_get_try_int(qdict, "number", 90);
+
+    if (n < 0 || n > 100) {
+        error_report("Coverset percentage should be between 0 and 100");
+        return;
+    }
+
+    dump_coverset_info(n, true);
+}
+
 static void hmp_info_opcount(Monitor *mon, const QDict *qdict)
 {
     dump_opcount_info();
-- 
2.22.0


