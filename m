Return-Path: <SRS0=vx8y=AW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,FROM_LOCAL_NOVOWEL,HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81BBBC433E5
	for <qemu-devel@archiver.kernel.org>; Sat, 11 Jul 2020 11:10:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4FBEF2078B
	for <qemu-devel@archiver.kernel.org>; Sat, 11 Jul 2020 11:10:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="og6TEkuq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4FBEF2078B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43544 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1juDP6-00015P-JR
	for qemu-devel@archiver.kernel.org; Sat, 11 Jul 2020 07:10:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52652)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jcmvbkbc@gmail.com>)
 id 1juDMH-0004Mb-RQ
 for qemu-devel@nongnu.org; Sat, 11 Jul 2020 07:07:53 -0400
Received: from mail-pg1-x52e.google.com ([2607:f8b0:4864:20::52e]:42192)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jcmvbkbc@gmail.com>)
 id 1juDMG-0006N9-4p
 for qemu-devel@nongnu.org; Sat, 11 Jul 2020 07:07:53 -0400
Received: by mail-pg1-x52e.google.com with SMTP id m22so3686419pgv.9
 for <qemu-devel@nongnu.org>; Sat, 11 Jul 2020 04:07:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=WZrxDgWWXXP9PmlZyyBGjdv9eqT/iSmUhBtmo9zxmiE=;
 b=og6TEkuqvyL9WqFB2XPRBVNhqgGVqrluIQwOzhZXqjonXxaOtdcemhkx/tVmeHwbqF
 XYvaSJyE1fa6QifMUiBfvlekqTneXmPoBzSZ+N3ANLozuOHHEFaKKFZSLeXUDfOT9Dsa
 GxEnTX3OdAqC8xBpjxhxqfLa/ZU0ypxhiz6nJ6pq94mhN85eGtzz/OBlefvlpC6TVx6J
 UHWx/yaEPwECXR8YeC99yIPCSNvLqavncnOnE9CvEUTnoOKna6cVV0XiQW4w3H6YcM/x
 9G0BsvtC4Jn3gBnjLnAR4rNiz8OLdwg8vA3z7l0p1/x0/U9Srt06ligpAuhP1d3l39UR
 AGPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=WZrxDgWWXXP9PmlZyyBGjdv9eqT/iSmUhBtmo9zxmiE=;
 b=bYkxVMCguyRZm23dl9EjLF5B6jtm4NmpVois7NNH8Yf+zGjt+mebFftdbqxCnBsLho
 caARUXqDEB9BQQnjV1qgeI0Fj/TXMpaU1GwPBf1r0nOIDiOARawGe4JR0IpMcXO9hZE1
 oxoYSyEkerVSPv5XJBIuI/OG1mAvWgM+/roUWzzsURF5KhsamPbDErSkOszBT8VM4S2H
 a7Yj1wOvJUhcPj4jNNaa/uXptIVl+GjDonxSILfxTCnKPLnONS7W9T0Kpv5RMOAiSfNV
 A4YR5n7NaVS6xBekUXuceGRAqzNNx0H9/x8nfOcdiLpCLeFsUymDEvrUfFcd9H9+pmqV
 DiZQ==
X-Gm-Message-State: AOAM5324vhfYDlItA5bZ1UnbRS6KLJwoMf9Tssb/0GWHSTLGhpEg+tpd
 Kq34FoyieheIrKsc3yJYkzhUeIXf
X-Google-Smtp-Source: ABdhPJx91xbPfHduPmKK1qsZU3HwlKROZQ964Sj6EqC8/pdM9ZpyqIOZMfy/DFYTJgvMhloRRZyZcA==
X-Received: by 2002:a62:6dc3:: with SMTP id
 i186mr43211212pfc.104.1594465670640; 
 Sat, 11 Jul 2020 04:07:50 -0700 (PDT)
Received: from octofox.hsd1.ca.comcast.net
 ([2601:641:400:e00:19b7:f650:7bbe:a7fb])
 by smtp.gmail.com with ESMTPSA id m31sm8925826pjb.52.2020.07.11.04.07.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 11 Jul 2020 04:07:50 -0700 (PDT)
From: Max Filippov <jcmvbkbc@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 04/22] target/xtensa: add geometry to
 xtensa_get_regfile_by_name
Date: Sat, 11 Jul 2020 04:06:39 -0700
Message-Id: <20200711110655.20287-5-jcmvbkbc@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200711110655.20287-1-jcmvbkbc@gmail.com>
References: <20200711110655.20287-1-jcmvbkbc@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52e;
 envelope-from=jcmvbkbc@gmail.com; helo=mail-pg1-x52e.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 FROM_LOCAL_NOVOWEL=0.5, HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
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
Cc: Max Filippov <jcmvbkbc@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Register file name may not uniquely identify a register file in the set
of configurations. E.g. floating point registers may have different size
in different configurations. Use register file geometry as additional
identifier.

Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
---
 target/xtensa/cpu.h       |  2 +-
 target/xtensa/helper.c    |  4 +++-
 target/xtensa/translate.c | 35 +++++++++++++++++++++++++++--------
 3 files changed, 31 insertions(+), 10 deletions(-)

diff --git a/target/xtensa/cpu.h b/target/xtensa/cpu.h
index 0c96181212a5..0409aa6189cf 100644
--- a/target/xtensa/cpu.h
+++ b/target/xtensa/cpu.h
@@ -598,7 +598,7 @@ void xtensa_cpu_do_unaligned_access(CPUState *cpu, vaddr addr,
 
 void xtensa_collect_sr_names(const XtensaConfig *config);
 void xtensa_translate_init(void);
-void **xtensa_get_regfile_by_name(const char *name);
+void **xtensa_get_regfile_by_name(const char *name, int entries, int bits);
 void xtensa_breakpoint_handler(CPUState *cs);
 void xtensa_register_core(XtensaConfigList *node);
 void xtensa_sim_open_console(Chardev *chr);
diff --git a/target/xtensa/helper.c b/target/xtensa/helper.c
index 7073381f03b2..05e2b7f70a1e 100644
--- a/target/xtensa/helper.c
+++ b/target/xtensa/helper.c
@@ -133,8 +133,10 @@ static void init_libisa(XtensaConfig *config)
     config->regfile = g_new(void **, regfiles);
     for (i = 0; i < regfiles; ++i) {
         const char *name = xtensa_regfile_name(config->isa, i);
+        int entries = xtensa_regfile_num_entries(config->isa, i);
+        int bits = xtensa_regfile_num_bits(config->isa, i);
 
-        config->regfile[i] = xtensa_get_regfile_by_name(name);
+        config->regfile[i] = xtensa_get_regfile_by_name(name, entries, bits);
 #ifdef DEBUG
         if (config->regfile[i] == NULL) {
             fprintf(stderr, "regfile '%s' not found for %s\n",
diff --git a/target/xtensa/translate.c b/target/xtensa/translate.c
index 03d796d7a1ed..9838bf6b3ec5 100644
--- a/target/xtensa/translate.c
+++ b/target/xtensa/translate.c
@@ -227,24 +227,43 @@ void xtensa_translate_init(void)
                                "exclusive_val");
 }
 
-void **xtensa_get_regfile_by_name(const char *name)
+void **xtensa_get_regfile_by_name(const char *name, int entries, int bits)
 {
+    char *geometry_name;
+    void **res;
+
     if (xtensa_regfile_table == NULL) {
         xtensa_regfile_table = g_hash_table_new(g_str_hash, g_str_equal);
+        /*
+         * AR is special. Xtensa translator uses it as a current register
+         * window, but configuration overlays represent it as a complete
+         * physical register file.
+         */
         g_hash_table_insert(xtensa_regfile_table,
-                            (void *)"AR", (void *)cpu_R);
+                            (void *)"AR 16x32", (void *)cpu_R);
         g_hash_table_insert(xtensa_regfile_table,
-                            (void *)"MR", (void *)cpu_MR);
+                            (void *)"AR 32x32", (void *)cpu_R);
         g_hash_table_insert(xtensa_regfile_table,
-                            (void *)"FR", (void *)cpu_FR);
+                            (void *)"AR 64x32", (void *)cpu_R);
+
         g_hash_table_insert(xtensa_regfile_table,
-                            (void *)"BR", (void *)cpu_BR);
+                            (void *)"MR 4x32", (void *)cpu_MR);
+
         g_hash_table_insert(xtensa_regfile_table,
-                            (void *)"BR4", (void *)cpu_BR4);
+                            (void *)"FR 16x32", (void *)cpu_FR);
+
         g_hash_table_insert(xtensa_regfile_table,
-                            (void *)"BR8", (void *)cpu_BR8);
+                            (void *)"BR 16x1", (void *)cpu_BR);
+        g_hash_table_insert(xtensa_regfile_table,
+                            (void *)"BR4 4x4", (void *)cpu_BR4);
+        g_hash_table_insert(xtensa_regfile_table,
+                            (void *)"BR8 2x8", (void *)cpu_BR8);
     }
-    return (void **)g_hash_table_lookup(xtensa_regfile_table, (void *)name);
+
+    geometry_name = g_strdup_printf("%s %dx%d", name, entries, bits);
+    res = (void **)g_hash_table_lookup(xtensa_regfile_table, geometry_name);
+    g_free(geometry_name);
+    return res;
 }
 
 static inline bool option_enabled(DisasContext *dc, int opt)
-- 
2.20.1


