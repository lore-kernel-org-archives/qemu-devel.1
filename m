Return-Path: <SRS0=M6H1=DI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4915BC4727E
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2020 16:41:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B77492075F
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2020 16:41:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ILxu3v20"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B77492075F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51350 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kO1eQ-0005P4-NL
	for qemu-devel@archiver.kernel.org; Thu, 01 Oct 2020 12:41:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45108)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kO1Xg-00058Q-3Z
 for qemu-devel@nongnu.org; Thu, 01 Oct 2020 12:34:52 -0400
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441]:36113)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kO1Xd-0004WQ-E2
 for qemu-devel@nongnu.org; Thu, 01 Oct 2020 12:34:51 -0400
Received: by mail-pf1-x441.google.com with SMTP id d9so5046497pfd.3
 for <qemu-devel@nongnu.org>; Thu, 01 Oct 2020 09:34:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=EmMCKff5D2NhzruLHhJVDlZo6kyMN39ZVhWfzFJSsKo=;
 b=ILxu3v20xdckSh+UCVTk+eWOblJRoGHQ6wdhsBBTwHfjSQNMs8iWh0Y7j0aAFpmwgU
 U2mZYEWq7LCYh6BSyqMxFtbTgdFG9b0wG2s70OSrfr+qGaDAqkhghozy4dERKjVLYXZC
 t61jHeDEPKULXHa2vwf7Ysugvn8R8iXktxHwflZwDKlTUZI+6yawt90kcshP/kZ4J6IH
 K1rpvR10F9ZK2npmZtQTIjQEM4ZTLk0EXfQmTsNYPhi3rZssmC/9q7yuM/i5UgbCcnm2
 zbvfbuq6C7ZHL7GlBjvdVc98mSDM/sp6VQTUfWByn+arYEW/2JYVPXQzpDPtJoWULX/e
 B2fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=EmMCKff5D2NhzruLHhJVDlZo6kyMN39ZVhWfzFJSsKo=;
 b=H8YOlSDWeSaafam+Duj85iJMCgc8lgsu9eDse+2z16DygQf8UIIov/JraCo+8OJyLV
 WdiqnTo3ENvs/g9DBWUma/ML6PV9cg0DBWNMju3B4wBYJSaRoozDfnPoOdkiq25+Hb3f
 MXnpECkMTG9ntw0bWJ5aAPHy12SvOFudbmhfA5l/5cjUnNSaQL5yERYCwInxphRRYE5V
 sU7o0JJlXqvWp83m9VzpkDjPrk4kSnVocdnnPO3voFj91wf2ej2IXA7zm5OIcZErNtzG
 +ZWoMKkVay/qDvsk7UXG8xtcx7KpsIB/8Pp6CUnzFe0hKqegjhcNMYcOf0/+PjhKzjSe
 AzGg==
X-Gm-Message-State: AOAM532MxhFaolBoheN10S/5Dt+OC/F+DXgHHKm6UMmvpWy5MTDABuNo
 6MdTo+4PckGhS5tb5QIKUiVR2wBtpKaC2g==
X-Google-Smtp-Source: ABdhPJxmBQmurc+OFlBx1Jpe4pBjwurc1K2liVePb8iyunzGU3XJDad0CdNfXGm3Cs11pe3dr0QmWA==
X-Received: by 2002:a63:c04d:: with SMTP id z13mr6913665pgi.215.1601570087454; 
 Thu, 01 Oct 2020 09:34:47 -0700 (PDT)
Received: from localhost.localdomain ([103.94.185.75])
 by smtp.googlemail.com with ESMTPSA id t12sm6946028pfh.73.2020.10.01.09.34.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Oct 2020 09:34:46 -0700 (PDT)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 1/6] plugins: Fixes a issue when dlsym failed,
 the handle not closed
Date: Fri,  2 Oct 2020 00:34:24 +0800
Message-Id: <20201001163429.1348-2-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.28.0.windows.1
In-Reply-To: <20201001163429.1348-1-luoyonggang@gmail.com>
References: <20201001163429.1348-1-luoyonggang@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::441;
 envelope-from=luoyonggang@gmail.com; helo=mail-pf1-x441.google.com
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


