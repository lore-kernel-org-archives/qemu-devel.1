Return-Path: <SRS0=FSHi=DM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89E31C4363A
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2020 16:29:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 17F0820756
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2020 16:29:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CzoTvsvB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 17F0820756
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40024 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kPTMz-0000Uo-7P
	for qemu-devel@archiver.kernel.org; Mon, 05 Oct 2020 12:29:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40632)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kPTLj-0007cJ-Gj
 for qemu-devel@nongnu.org; Mon, 05 Oct 2020 12:28:31 -0400
Received: from mail-pj1-x1041.google.com ([2607:f8b0:4864:20::1041]:34075)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kPTLg-0006pu-Km
 for qemu-devel@nongnu.org; Mon, 05 Oct 2020 12:28:31 -0400
Received: by mail-pj1-x1041.google.com with SMTP id nl2so252535pjb.1
 for <qemu-devel@nongnu.org>; Mon, 05 Oct 2020 09:28:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=oA6lwA9DRk6v/CqH7e4pibYzUGFI9UFOt7RD8ATdFPQ=;
 b=CzoTvsvBUxbxE8aidwK79HXXqmMvMyukI4LAXaYl/3TtA6BUB09nKthGtOGUI/cXCn
 6lRxDafyUEaPHTUIjpITlzHxGx0KUdrmj1Lx2NfFWOM5roP0NUzajrpZzEgoBSa9xdbW
 suwqT9SeF+5Lap4IRk7fSx3YNdF8IZmPlBNSsCou2XlYFVCiOvPaBJm4WmB2H5JYtReJ
 O8lUqGm5IEU183wZQ5cXbaOfYmpBYDoGYlRaci410i7nE8lkR9ztnJ4l3VWql+RDZiXR
 409arrmKWJFLf6zdoQZ7x/L8c7VTiuOfhgk37lDCP6fLwuYHcdk0sUEfduauMbhdfV9N
 9LfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=oA6lwA9DRk6v/CqH7e4pibYzUGFI9UFOt7RD8ATdFPQ=;
 b=EedwCT+NLbOO2MClLmzaigMyX9QCQK41PPuT5gs6mHeKMWRAM0cw56c8U9ccg5AXxE
 9AQTnl2uaNCZnYwzw7XhYc42MW7BYAVUkXueUJ2iWKvEyZN3XV62LOjh9TkbhlzxQQob
 /RHm31im4RD6W/SW+4fU96aHOOoi0maSQ07DAKXlLabTJd48OOgsE3j0ForAp+N+UCyj
 II1ULGhKUcxqhDzpnGCP2nqY/tQVtuaRCoR6REwKJncEnQwFtQxlkJ1VR9lUAeA3Wj0A
 X+E+2pcKXQOgZq9QTcld4Roe9IHCsgjaY19KhKLOvCNb4SwPY2iX4kdE+zNAn2Vic/EW
 tZUw==
X-Gm-Message-State: AOAM533WSubZ6dEZMXsoR7WyggKtAeB+fxDimyEqnn1mWBFvoqwf06VF
 zspI4mIk319TcanxdDeJITkKwcbT6B/hUA==
X-Google-Smtp-Source: ABdhPJyGIYYdVMYIgDeV9I73z2WCmmjJX/j/cvLWOTdDnYfq3KjmBmrgThMxAg31cQLm3YokRw2tpQ==
X-Received: by 2002:a17:90a:514e:: with SMTP id
 k14mr233766pjm.48.1601915306472; 
 Mon, 05 Oct 2020 09:28:26 -0700 (PDT)
Received: from localhost.localdomain ([103.94.185.75])
 by smtp.googlemail.com with ESMTPSA id x13sm374725pfj.199.2020.10.05.09.28.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Oct 2020 09:28:25 -0700 (PDT)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 2/6] plugin: Fixes compiling errors on msys2/mingw
Date: Tue,  6 Oct 2020 00:28:02 +0800
Message-Id: <20201005162806.1350-3-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.28.0.windows.1
In-Reply-To: <20201005162806.1350-1-luoyonggang@gmail.com>
References: <20201005162806.1350-1-luoyonggang@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1041;
 envelope-from=luoyonggang@gmail.com; helo=mail-pj1-x1041.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Yonggang Luo <luoyonggang@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
---
 contrib/plugins/hotblocks.c | 2 +-
 tests/plugin/bb.c           | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/contrib/plugins/hotblocks.c b/contrib/plugins/hotblocks.c
index 3942a2ca54..37435a3fc7 100644
--- a/contrib/plugins/hotblocks.c
+++ b/contrib/plugins/hotblocks.c
@@ -102,7 +102,7 @@ static void vcpu_tb_trans(qemu_plugin_id_t id, struct qemu_plugin_tb *tb)
 {
     ExecCount *cnt;
     uint64_t pc = qemu_plugin_tb_vaddr(tb);
-    unsigned long insns = qemu_plugin_tb_n_insns(tb);
+    size_t insns = qemu_plugin_tb_n_insns(tb);
     uint64_t hash = pc ^ insns;
 
     g_mutex_lock(&lock);
diff --git a/tests/plugin/bb.c b/tests/plugin/bb.c
index e4cc7fdd6e..de09bdde4e 100644
--- a/tests/plugin/bb.c
+++ b/tests/plugin/bb.c
@@ -72,7 +72,7 @@ static void vcpu_tb_exec(unsigned int cpu_index, void *udata)
     CPUCount *count = max_cpus ?
         g_ptr_array_index(counts, cpu_index) : &inline_count;
 
-    unsigned long n_insns = (unsigned long)udata;
+    uintptr_t n_insns = (uintptr_t)udata;
     g_mutex_lock(&count->lock);
     count->insn_count += n_insns;
     count->bb_count++;
@@ -81,7 +81,7 @@ static void vcpu_tb_exec(unsigned int cpu_index, void *udata)
 
 static void vcpu_tb_trans(qemu_plugin_id_t id, struct qemu_plugin_tb *tb)
 {
-    unsigned long n_insns = qemu_plugin_tb_n_insns(tb);
+    size_t n_insns = qemu_plugin_tb_n_insns(tb);
 
     if (do_inline) {
         qemu_plugin_register_vcpu_tb_exec_inline(tb, QEMU_PLUGIN_INLINE_ADD_U64,
-- 
2.28.0.windows.1


