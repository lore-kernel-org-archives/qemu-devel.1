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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89A05C47095
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2020 16:33:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DA29A20756
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2020 16:33:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yd/QywdP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA29A20756
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46162 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kPTQJ-0003BR-R9
	for qemu-devel@archiver.kernel.org; Mon, 05 Oct 2020 12:33:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40590)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kPTLf-0007UG-DM
 for qemu-devel@nongnu.org; Mon, 05 Oct 2020 12:28:27 -0400
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:46381)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kPTLd-0006oB-SZ
 for qemu-devel@nongnu.org; Mon, 05 Oct 2020 12:28:27 -0400
Received: by mail-pf1-x444.google.com with SMTP id y14so4017958pfp.13
 for <qemu-devel@nongnu.org>; Mon, 05 Oct 2020 09:28:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=vwWICdvW/zCGPD13s4UEGsuus824XjxUxjGQ4brZjgg=;
 b=Yd/QywdPpXWl/WLxb+zrVZZiGc5cfGdOb7yiJfyQXSlao2keJPARIpI45oblltxAuP
 kQ89LnoaeFs0As5lJ5cklBssGlUX2p+81BjAgxJP5NhPmiJ3vqOn7l+gx94ObrEH/bF3
 CD/zCwqtoWfQXRnY3dPalF9Uo8C503zEYkxvbWKhbny1NLLM10L/Q3/A9x3KIvSrgwJv
 RO9m0KaU+qEn+zl1L2gJF+9lcPCLpSeg/cHNv4equ7VmAomL/DYWR9KQpegk2YFK+vZS
 vsYKRBgr2XxiPknO4QJ+b3tbWqbGc2+wXbzguY8WInsH6qOdMGqhpEeZwi5oomsniYfY
 wd9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=vwWICdvW/zCGPD13s4UEGsuus824XjxUxjGQ4brZjgg=;
 b=nt96frAEiOkd4QDTEnN5kSh1RhjPb+Hiw+zBd4XX2ypkROC+8DeZnCElgceoiDhDo1
 BLtk0m9gck3sgSSz7RWHNlF8ToiDm5RScK+4VyXGA4JJfKgm+j5s4DmwsN4nEOhPhWt0
 rHtzOAqOElK7paUzcreRmL+CTfbGy8WYsTSEDX+VxT6gAYwySH1v6WcwaDx/MgVXfC5j
 ZP9PBNounx0tNB5ftU/fyz+tQr2r6GK7rnEjxiN/qO4jl1w2TPIbefMO8VQIyovcCHkz
 VoBntNjpyk9AzLwXBSTnTJK52BANdGyKf/PecxS+4YGx5pR3JbkgL2gSMSjE7L4Jevxn
 IE6Q==
X-Gm-Message-State: AOAM530J7Vq34GafOZoe5icl1Tt/oR0vFJ4vYqkCtiB5sBCqQbwHcQp3
 sszPotsFiE2UL5lMN63AIo6+NC42HeYHhQ==
X-Google-Smtp-Source: ABdhPJx62MDFTjSn/4xSt56ZbNq0+N42ntaBE4Yz5GhIne1iIW3zVRh6EXScvemf3JL7TpTWu/7ZyA==
X-Received: by 2002:a63:5a11:: with SMTP id o17mr235293pgb.287.1601915303966; 
 Mon, 05 Oct 2020 09:28:23 -0700 (PDT)
Received: from localhost.localdomain ([103.94.185.75])
 by smtp.googlemail.com with ESMTPSA id x13sm374725pfj.199.2020.10.05.09.28.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Oct 2020 09:28:23 -0700 (PDT)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 1/6] plugins: Fixes a issue when dlsym failed,
 the handle not closed
Date: Tue,  6 Oct 2020 00:28:01 +0800
Message-Id: <20201005162806.1350-2-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.28.0.windows.1
In-Reply-To: <20201005162806.1350-1-luoyonggang@gmail.com>
References: <20201005162806.1350-1-luoyonggang@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::444;
 envelope-from=luoyonggang@gmail.com; helo=mail-pf1-x444.google.com
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
 plugins/loader.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/plugins/loader.c b/plugins/loader.c
index 685d334e1a..8ac5dbc20f 100644
--- a/plugins/loader.c
+++ b/plugins/loader.c
@@ -235,6 +235,7 @@ static int plugin_load(struct qemu_plugin_desc *desc, const qemu_info_t *info)
     return rc;
 
  err_symbol:
+    g_module_close(ctx->handle);
  err_dlopen:
     qemu_vfree(ctx);
     return 1;
-- 
2.28.0.windows.1


