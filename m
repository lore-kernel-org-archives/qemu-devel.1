Return-Path: <SRS0=+uBF=DN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C94EC41604
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Oct 2020 12:11:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CFA3D20663
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Oct 2020 12:11:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q0nHtbtg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CFA3D20663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46990 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kPlot-00058I-NB
	for qemu-devel@archiver.kernel.org; Tue, 06 Oct 2020 08:11:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48976)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kPlnA-0003Mm-BE
 for qemu-devel@nongnu.org; Tue, 06 Oct 2020 08:10:04 -0400
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641]:44550)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kPln7-0004Dm-Vr
 for qemu-devel@nongnu.org; Tue, 06 Oct 2020 08:10:04 -0400
Received: by mail-pl1-x641.google.com with SMTP id h2so1117082pll.11
 for <qemu-devel@nongnu.org>; Tue, 06 Oct 2020 05:10:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=ChWuKq12YEBlrVQq4Iva9E7cg0lDlX98+uvW3A3EDFU=;
 b=Q0nHtbtgCA/rPt07KzbJ9+UaXJUZvRdskOPP47GpIoRdVyz4D2ik6TezGtkoIaxmHF
 fARW2a/0bPMCv7REiIAxMILK+aAEJGvnS2Ghcgej6DjKGFPR7thCIDn1+ZYLBmRsio9W
 fJ3Da+54SDY+DPCkxD1NvbwD1xhPrJicivJNTTVH6RsL17YbzjWpvBcAZIzgXris3pOg
 IzZUl3DBteHS30S+uuTiNTJfweWCpPk4Wh6CfPK8pv8MK9clMbgI2bfatMEnFJ+QBMqT
 zk6WXLUExYtHEdSQgI/gNXJYHmzQtGCKj8xdAKPIAXnkNDI4tBrdJQ/uHwhywbH9x3Ft
 WBXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=ChWuKq12YEBlrVQq4Iva9E7cg0lDlX98+uvW3A3EDFU=;
 b=EVvaHXdJOVSjSSh5bdCpO0ICK/0cHrys8p4vjXMuS6G+PUPud5a6OO8tuFJXYf+1FZ
 PbNfnyeuZ7hDQTBqQWuQGgts0HS4Rk30ISrltIWPPhmQrqNkieYeu9Tszm/yttdAwwVk
 GnZ7EG4EFiVDp6mOt0hYTl1I1HFYsHP3J7kXQ1H6FddPWmOpa9kRkQZW5xfDt4vLOFQf
 zTO/5KD3FLxERX/dB+fjWi7/mEYYWRajfVOxE0bPw8Xy1dvctzBViARx0K9ZqosQYlYQ
 YCKoqZbW6//JwO3JfBOs27XCt2YWgXHZ+3xojurpAannjQGKMoQMcVht/qvLCeqjOPAF
 ZL/w==
X-Gm-Message-State: AOAM532U4S54JtZLNsY6tyg9B10VwHp8FUuF4FFsUMjlL3h+/hDVgBwB
 lAqQGtVE6CpPM6m5+g2RCO+JWJl8ufVy0A==
X-Google-Smtp-Source: ABdhPJxnPS65Yk4e6fTu4UvMdrVzT9i8MaRPkgWO1SUeMLIXcHjDVX8kOcLU2GSjf/WYnxmklQsjxA==
X-Received: by 2002:a17:90a:e088:: with SMTP id
 q8mr4260818pjy.172.1601986200303; 
 Tue, 06 Oct 2020 05:10:00 -0700 (PDT)
Received: from localhost.localdomain ([103.94.185.75])
 by smtp.googlemail.com with ESMTPSA id f4sm2965681pgk.19.2020.10.06.05.09.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Oct 2020 05:09:59 -0700 (PDT)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v5 3/7] plugin: getting qemu_plugin_get_hwaddr only expose one
 function prototype
Date: Tue,  6 Oct 2020 20:08:56 +0800
Message-Id: <20201006120900.1579-4-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.28.0.windows.1
In-Reply-To: <20201006120900.1579-1-luoyonggang@gmail.com>
References: <20201006120900.1579-1-luoyonggang@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::641;
 envelope-from=luoyonggang@gmail.com; helo=mail-pl1-x641.google.com
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
 Richard Henderson <richard.henderson@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is used for counting how much function are export to qemu plugin.

Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
---
 plugins/api.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/plugins/api.c b/plugins/api.c
index bbdc5a4eb4..13177d3578 100644
--- a/plugins/api.c
+++ b/plugins/api.c
@@ -251,10 +251,12 @@ bool qemu_plugin_mem_is_store(qemu_plugin_meminfo_t info)
 
 #ifdef CONFIG_SOFTMMU
 static __thread struct qemu_plugin_hwaddr hwaddr_info;
+#endif
 
 struct qemu_plugin_hwaddr *qemu_plugin_get_hwaddr(qemu_plugin_meminfo_t info,
                                                   uint64_t vaddr)
 {
+#ifdef CONFIG_SOFTMMU
     CPUState *cpu = current_cpu;
     unsigned int mmu_idx = info >> TRACE_MEM_MMU_SHIFT;
     hwaddr_info.is_store = info & TRACE_MEM_ST;
@@ -266,14 +268,10 @@ struct qemu_plugin_hwaddr *qemu_plugin_get_hwaddr(qemu_plugin_meminfo_t info,
     }
 
     return &hwaddr_info;
-}
 #else
-struct qemu_plugin_hwaddr *qemu_plugin_get_hwaddr(qemu_plugin_meminfo_t info,
-                                                  uint64_t vaddr)
-{
     return NULL;
-}
 #endif
+}
 
 bool qemu_plugin_hwaddr_is_io(const struct qemu_plugin_hwaddr *haddr)
 {
-- 
2.28.0.windows.1


