Return-Path: <SRS0=muvY=DW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99764C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2020 20:15:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E07B920725
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2020 20:15:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ihD2KHRR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E07B920725
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57354 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kT9eg-0003eJ-S8
	for qemu-devel@archiver.kernel.org; Thu, 15 Oct 2020 16:15:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33924)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kT9dS-0002cJ-5Z; Thu, 15 Oct 2020 16:14:02 -0400
Received: from mail-pj1-x102b.google.com ([2607:f8b0:4864:20::102b]:40342)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kT9dQ-0001uL-Bp; Thu, 15 Oct 2020 16:14:01 -0400
Received: by mail-pj1-x102b.google.com with SMTP id j8so58598pjy.5;
 Thu, 15 Oct 2020 13:13:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Zs60eK5PfD5d3cYvFCbEHXTMHa3QpK7RkQrrTjYQvO0=;
 b=ihD2KHRRswMk2wryESPfGJDrrofohlFw6aGT2UjdJjKZErsxCIovHF4gtn6GCe6KVh
 ZA0fLocmdnsONd+Uo6Qm/Hwgln/bCQnBueIx3SLXqNn/dPGypV4o7P3QbAIzo0DV84Dz
 oFGaZFoo/M1geUbq6jYT20rGUONQxwYvdgx5pumujeszHBMWM7HMW7pSFlH+T5pOG43h
 0aMpCSiDA+cdlsb6Szvj1Fj0r40waOcxNItYAI/gWRKIRchUCcw/IcLZIhLQQ1ZCKoHe
 vOlRUkSumr5mR7Tai+wpQrUbiLYiCVhP1V5u5f+GbM38UL7XxrNeuYYYV/iQvLM8eciv
 afAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Zs60eK5PfD5d3cYvFCbEHXTMHa3QpK7RkQrrTjYQvO0=;
 b=Z0lT01aOuL+kEiD5HsuJUcEACzDbt6o68SZ/pqSFoHyWtaNaR023e10D/KwH8SRHYN
 nlVkRpjcMkeI8IDy2TdlDKrdPyebHYphi9kl8yNOy6WVCFgX9eT88Cm6T0vr9TmOs1WK
 fiBPoR7Tfgk2yZ/D14AgtzDob9iQ2IWnn1hR1qewMw4XnkjEXQDb3pF0RpK19vQwt8oD
 SepVGQZWiQBlhbdfQN2yJqugGn1dHt7alvmZCiO8SM7Scoms4yIwJr7EiQVxKj1pK6ZZ
 BHNCR3emItxXmntNqiEdZNSa7tOzFXl7HNfcV3N62U7+5alCzAXvWq8CyCDWOTQ6h5h5
 eHCA==
X-Gm-Message-State: AOAM531hZb2Oo4rVIYFdfjegpIrG3h+lHbbzrHGeHOYzAJc+Yx0tl2/m
 YwDcMJo7PQteOetY0fdM64oSqQVOOsfcIWBx
X-Google-Smtp-Source: ABdhPJxh0fKR+hiPOzKdwT/A57r4Q/oRk8m1LyUzn9kQIdnaIl7FUWjwgkO3o0SRbh/27RKuurr80Q==
X-Received: by 2002:a17:90b:4b08:: with SMTP id
 lx8mr401823pjb.204.1602792837924; 
 Thu, 15 Oct 2020 13:13:57 -0700 (PDT)
Received: from localhost.localdomain ([103.94.185.75])
 by smtp.googlemail.com with ESMTPSA id s20sm89922pfc.201.2020.10.15.13.13.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Oct 2020 13:13:57 -0700 (PDT)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 2/2] block: enable libnfs on msys2/mingw in cirrus.yml
Date: Fri, 16 Oct 2020 04:13:35 +0800
Message-Id: <20201015201335.357-3-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.28.0.windows.1
In-Reply-To: <20201015201335.357-1-luoyonggang@gmail.com>
References: <20201015201335.357-1-luoyonggang@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102b;
 envelope-from=luoyonggang@gmail.com; helo=mail-pj1-x102b.google.com
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 QEMU Trivial <qemu-trivial@nongnu.org>, Peter Lieven <pl@kamp.de>,
 Max Reitz <mreitz@redhat.com>, Yonggang Luo <luoyonggang@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Initially, libnfs has not been enabled, and now it's fixed, so enable it
on cirrus.

Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
---
 .cirrus.yml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/.cirrus.yml b/.cirrus.yml
index f42ccb956a..2c6bf45e6d 100644
--- a/.cirrus.yml
+++ b/.cirrus.yml
@@ -109,6 +109,7 @@ windows_msys2_task:
           mingw-w64-x86_64-cyrus-sasl \
           mingw-w64-x86_64-curl \
           mingw-w64-x86_64-gnutls \
+          mingw-w64-x86_64-libnfs \
           "
         bitsadmin /transfer msys_download /dynamic /download /priority FOREGROUND `
           https://repo.msys2.org/mingw/x86_64/mingw-w64-x86_64-python-sphinx-2.3.1-1-any.pkg.tar.xz `
-- 
2.28.0.windows.1


