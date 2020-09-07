Return-Path: <SRS0=tzYv=CQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4B0BC433E2
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2020 19:52:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 42BF421556
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2020 19:52:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lsV8rnmh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 42BF421556
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40722 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFNC7-0002D5-EO
	for qemu-devel@archiver.kernel.org; Mon, 07 Sep 2020 15:52:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59074)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kFNAB-00078Z-03
 for qemu-devel@nongnu.org; Mon, 07 Sep 2020 15:50:51 -0400
Received: from mail-pg1-x530.google.com ([2607:f8b0:4864:20::530]:45617)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kFNA9-0006eN-DK
 for qemu-devel@nongnu.org; Mon, 07 Sep 2020 15:50:50 -0400
Received: by mail-pg1-x530.google.com with SMTP id 67so8441776pgd.12
 for <qemu-devel@nongnu.org>; Mon, 07 Sep 2020 12:50:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=LvgBmVo5Tzfa2ETkxK8CQ+jBfbey6Ap12eTwlbT45c8=;
 b=lsV8rnmh3jy16Zhzfcu+krTZUipYE4fSkmE4vUDh2XDFFI2PDEVbnA2ifBmo/ypFzo
 o2boICgLwel9d4IPx6E4+sHEFlFwtivalbOGGiZ1q5VCAP7HYgbFNOThjJSz7Jhg1PgY
 5RokD19IYjP5/ab/hyxH3jgGiulg5/K5hT33x98RQy/YHKMcxAF78MFUZfypAu8aT6Yy
 3oXMX083NLT9qXAv4f6miZh4i3NYwNhvfX/JbJM0i3PWQRFBaXANvG7l1DRL44rLFJId
 9yGheNx3EW+0YRftWXUgAxuKsOfgN7yWKf3hhh3NvLCWVJCQ+oKu1DkcelAMGa2hkAWI
 Pjuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=LvgBmVo5Tzfa2ETkxK8CQ+jBfbey6Ap12eTwlbT45c8=;
 b=GAshK99ma0BxOLe7ic6TGj3cAGtV3VycXxB2wwYUij29eF3opCL7s3UIdfvFz9ZgmL
 qmJL5fi2iKU+/NZ4mdPtZ7ZROcEE7gSzTCCImip9K8BSeWOQCjYgOyj1TGzqUKVxIhO1
 ODMwKdan2kws+NhSumD8nj6XGg4LoCrGckZIDjjEGl7U9WeScDJr5GJb2FX/7SC02e/e
 zLSSRnijzQXIDqn8vCDoKug3WApeei24krXS/w5WqTIqZLa7APSuqqTrcrlRT0sdYTaE
 /3C8M/K6ZtD0ct20vNRsXXFw67W3B4O8F80zKqFZ+FHnILTU3rE8xsOLqOccMDvzmhEs
 wfmw==
X-Gm-Message-State: AOAM533MLzZNcgPFh4+JjNZC+W64B3bDjJqilfRFZD3fz1HTWRE19wx9
 +VVLzRsploLQ0V/uhfI4DTQtQQyiZ6VZp11h
X-Google-Smtp-Source: ABdhPJxjoSoztLlhvL1WtEgnRnGwwMgzBrAW7pVdGf7Yp3OhU3gqt43MKsTLpG/6vkSadWMhQmKDmA==
X-Received: by 2002:a17:902:bc44:: with SMTP id
 t4mr19673305plz.77.1599508247620; 
 Mon, 07 Sep 2020 12:50:47 -0700 (PDT)
Received: from localhost.localdomain ([222.95.248.6])
 by smtp.googlemail.com with ESMTPSA id ev19sm4818990pjb.42.2020.09.07.12.50.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Sep 2020 12:50:46 -0700 (PDT)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 3/4] meson: remove empty else and duplicated gio deps
Date: Tue,  8 Sep 2020 03:50:24 +0800
Message-Id: <20200907195025.2308-4-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.28.0.windows.1
In-Reply-To: <20200907195025.2308-1-luoyonggang@gmail.com>
References: <20200907195025.2308-1-luoyonggang@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::530;
 envelope-from=luoyonggang@gmail.com; helo=mail-pg1-x530.google.com
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Yonggang Luo <luoyonggang@gmail.com>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
 Juan Quintela <quintela@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
---
 meson.build | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/meson.build b/meson.build
index 6e909213ee..d6a1949b2f 100644
--- a/meson.build
+++ b/meson.build
@@ -320,7 +320,6 @@ opengl = not_found
 if 'CONFIG_OPENGL' in config_host
   opengl = declare_dependency(compile_args: config_host['OPENGL_CFLAGS'].split(),
                               link_args: config_host['OPENGL_LIBS'].split())
-else
 endif
 gtk = not_found
 if 'CONFIG_GTK' in config_host
@@ -347,11 +346,6 @@ if 'CONFIG_ICONV' in config_host
   iconv = declare_dependency(compile_args: config_host['ICONV_CFLAGS'].split(),
                              link_args: config_host['ICONV_LIBS'].split())
 endif
-gio = not_found
-if 'CONFIG_GIO' in config_host
-  gio = declare_dependency(compile_args: config_host['GIO_CFLAGS'].split(),
-                           link_args: config_host['GIO_LIBS'].split())
-endif
 vnc = not_found
 png = not_found
 jpeg = not_found
-- 
2.28.0.windows.1


