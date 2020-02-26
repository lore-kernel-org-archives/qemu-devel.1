Return-Path: <SRS0=zj/5=4O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C3ACC4BA0A
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2020 07:51:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6870321556
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2020 07:51:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CtWcg8dE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6870321556
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39534 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6rTs-0002Q0-Ip
	for qemu-devel@archiver.kernel.org; Wed, 26 Feb 2020 02:51:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50456)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1j6rO6-0003XY-4F
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 02:45:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1j6rO4-0005dw-AU
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 02:45:45 -0500
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332]:52413)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1j6rO3-0005a1-3N
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 02:45:43 -0500
Received: by mail-wm1-x332.google.com with SMTP id p9so1817131wmc.2
 for <qemu-devel@nongnu.org>; Tue, 25 Feb 2020 23:45:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=SKIVM/nv6pvrBs0kbqjR1dcnk9jHgbZ0MPB1gDBk62c=;
 b=CtWcg8dEkhnd0+Y5sXJjEWQmwy5kebfuQzeFRbn+bEcd8p4TF65H3IOBPij1UOpYms
 LL7R8RDnMUpym+Zy89ZHo3S/SDD921qeqxhO+7aIOrLs7F09WQbnZx6bedwWvGmKO/UC
 I67y8CuK0FAFAeCdiJP9OWnQzV8XPK/NlJr2yAaIfxx8cEVoe/FCwAxadz953LKd4aqD
 bU1nzwR/9ym+am9ptJl1SGcZvjwVTHelos/LoBZBA1BA82WgdEFszbEq0ovw/JWoXcPM
 kMvR6NfDTHA/y0I2ZscSS8EOdLTv+jHXgIRytf0khKDoFBc/Zop2DzxMBCxNYGjqwVGB
 GONQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=SKIVM/nv6pvrBs0kbqjR1dcnk9jHgbZ0MPB1gDBk62c=;
 b=kjfrXMxwlVotB94p2R1LBKovMP1Q7akgsagDDawoE1+dzEjKgdvPnAmhy4cEeTHaJR
 yhQpOorxidvyoAw6hhWaAcmj1CVrCusrYTAhI922u/1O/gHEJSH0JIwo+d8vwmLmZVrZ
 0xKsGWghpDIgJr4xzsCd/0cU8rFbstBdzAeMYNFiGWllK/4WLjFrktO/b81uKooN5wi5
 5ujdXWjdMKpBv1Ak6ILFDFVVpXTev1iIQ+1AGzMVQjUMv47nyXtNtwu3A1mjFWpDthwq
 FGcUVeCSomFYv3Qz97c+0ykBqzAEIJosB1/oBEv7jZ5ci0hESIe0hkviUIPLcUn6FCTx
 Khkg==
X-Gm-Message-State: APjAAAUJc5nYb811WLMckEz1pt+DQLfYAnnyHcCN8LHJ9e1iYSbKKxYp
 anIfm6l3rLi5eQoaftt7oYrV0g==
X-Google-Smtp-Source: APXvYqwGj8EMfBArgKcs2UlK1QAOjSRAFfe+pcxxPQUfRxsbf+a5PMZnZzXgU8YNeGh/i78DPkMHbA==
X-Received: by 2002:a7b:cb97:: with SMTP id m23mr3640772wmi.37.1582703141998; 
 Tue, 25 Feb 2020 23:45:41 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id t131sm1861721wmb.13.2020.02.25.23.45.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Feb 2020 23:45:40 -0800 (PST)
Received: from zen.home.arpa (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 920C01FF9F;
 Wed, 26 Feb 2020 07:39:30 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Subject: [PULL 15/19] tests/plugins: make howvec clean-up after itself.
Date: Wed, 26 Feb 2020 07:39:25 +0000
Message-Id: <20200226073929.28237-16-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200226073929.28237-1-alex.bennee@linaro.org>
References: <20200226073929.28237-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::332
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
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org,
 Robert Foley <robert.foley@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

TCG plugins are responsible for their own memory usage and although
the plugin_exit is tied to the end of execution in this case it is
still poor practice. Ensure we delete the hash table and related data
when we are done to be a good plugin citizen.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Robert Foley <robert.foley@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

Message-Id: <20200225124710.14152-16-alex.bennee@linaro.org>

diff --git a/tests/plugin/howvec.c b/tests/plugin/howvec.c
index 4ca555e1239..3b9a6939f23 100644
--- a/tests/plugin/howvec.c
+++ b/tests/plugin/howvec.c
@@ -163,6 +163,13 @@ static gint cmp_exec_count(gconstpointer a, gconstpointer b)
     return ea->count > eb->count ? -1 : 1;
 }
 
+static void free_record(gpointer data)
+{
+    InsnExecCount *rec = (InsnExecCount *) data;
+    g_free(rec->insn);
+    g_free(rec);
+}
+
 static void plugin_exit(qemu_plugin_id_t id, void *p)
 {
     g_autoptr(GString) report = g_string_new("Instruction Classes:\n");
@@ -195,30 +202,31 @@ static void plugin_exit(qemu_plugin_id_t id, void *p)
 
     counts = g_hash_table_get_values(insns);
     if (counts && g_list_next(counts)) {
-        GList *it;
-
         g_string_append_printf(report,"Individual Instructions:\n");
+        counts = g_list_sort(counts, cmp_exec_count);
 
-        it = g_list_sort(counts, cmp_exec_count);
-
-        for (i = 0; i < limit && it->next; i++, it = it->next) {
-            InsnExecCount *rec = (InsnExecCount *) it->data;
-            g_string_append_printf(report, "Instr: %-24s\t(%ld hits)\t(op=%#08x/%s)\n",
+        for (i = 0; i < limit && g_list_next(counts);
+             i++, counts = g_list_next(counts)) {
+            InsnExecCount *rec = (InsnExecCount *) counts->data;
+            g_string_append_printf(report,
+                                   "Instr: %-24s\t(%ld hits)\t(op=%#08x/%s)\n",
                                    rec->insn,
                                    rec->count,
                                    rec->opcode,
                                    rec->class ?
                                    rec->class->class : "un-categorised");
         }
-        g_list_free(it);
+        g_list_free(counts);
     }
 
+    g_hash_table_destroy(insns);
+
     qemu_plugin_outs(report->str);
 }
 
 static void plugin_init(void)
 {
-    insns = g_hash_table_new(NULL, g_direct_equal);
+    insns = g_hash_table_new_full(NULL, g_direct_equal, NULL, &free_record);
 }
 
 static void vcpu_insn_exec_before(unsigned int cpu_index, void *udata)
-- 
2.20.1


