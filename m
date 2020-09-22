Return-Path: <SRS0=0j61=C7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD6EBC4363D
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 17:52:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 56C962376F
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 17:52:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rCRmzQtZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 56C962376F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57636 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKmSk-0003qm-9v
	for qemu-devel@archiver.kernel.org; Tue, 22 Sep 2020 13:52:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45486)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kKmOX-0007xp-K7
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 13:48:09 -0400
Received: from mail-pg1-x52e.google.com ([2607:f8b0:4864:20::52e]:34243)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kKmOM-0004Kj-Ta
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 13:47:59 -0400
Received: by mail-pg1-x52e.google.com with SMTP id u24so1752152pgi.1
 for <qemu-devel@nongnu.org>; Tue, 22 Sep 2020 10:47:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Nh1db1dZeJoMf+455PtMij2SzqSvT9UF/0EwtPYuxYM=;
 b=rCRmzQtZcOTLr4VP/p62Ndm89mwkUbhNCCL9dUAG+GvMLnfEV1L0APVkyjB6gt4Ujn
 wrgGck2FsZ0lpmU0XKoftyB/YDx8Cwdkwmy/N17xgM2rjkBg7+jfeGRSHAiCeS/LoYpP
 ZwqO6fBoppgRyapoI7x1tgQWAVJOb6kT0OQ+Hc6wrzkOVudQbMJPLupvD9dqJrWMpRdc
 2MH8Ahyn/s4JmKQ0Q13pTrJu4zxOb3afDbbg3OeR2GS+iVpkQ0LGDoIQsyJhZNPYqHqC
 lymYznp7D18pKVC5Tv8Za3kJKEjQbKKVFaXWNuAXe/NOmTkYXiO16ogc4l027Vwim1LV
 5d5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Nh1db1dZeJoMf+455PtMij2SzqSvT9UF/0EwtPYuxYM=;
 b=mhJAnGcm/pEbzwuOlLlRaQhuUrH2YubaopEWwuVAORwfx2PSu75PTsfu/7Mgi0iskN
 qQ4kPt4ju8QcnKOVDjmxdr4570+HO9iNALyLjv2rU7Q7kJUtgKC/2VYq064v+mqyVylc
 X0vTYb8BbzQ0IHi78eFfdv4w3WCzHiyE4N4smvqLXEWrtwVkcsjjqO0sC3Nsdue07nje
 lFqSVFGPsJ/3psMIjkIVP6JCQx55RXmaXQ651uGfVB65Y2lU5j5fH9s1P8xY+Ehv8axV
 pYEboVhUffPlrTQqnD2XA2eD9Y0t7AbnfOe7lMC/P5/2gVqnwVl+Mstrp4Jd1UVa1H2g
 C7wQ==
X-Gm-Message-State: AOAM533rd1piAOs0xjgkcPABeQaufLoX4Wc6FWb/ans+FG57dJy79wnH
 NMUlXL+F+X6fhTgm4C90+uQWeKVclBPxcg==
X-Google-Smtp-Source: ABdhPJyOfjFDPEXoXd5Sf8B+XN2kw/K/E8Vr5gwnmOaI/t8zhFnfj5RpID9z5crNVGN550dz0qflOA==
X-Received: by 2002:a65:5902:: with SMTP id f2mr4195566pgu.379.1600796868535; 
 Tue, 22 Sep 2020 10:47:48 -0700 (PDT)
Received: from localhost.localdomain ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id r1sm14825310pgl.66.2020.09.22.10.47.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Sep 2020 10:47:47 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 03/11] capstone: Require version 4.0 from a system library
Date: Tue, 22 Sep 2020 10:47:33 -0700
Message-Id: <20200922174741.475876-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200922174741.475876-1-richard.henderson@linaro.org>
References: <20200922174741.475876-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52e.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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
Cc: peter.maydell@linaro.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We're about to use a portion of the 4.0 API.
Reject a system library version prior to that.

Tested-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 meson.build | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/meson.build b/meson.build
index 4c92b43fe5..114b136129 100644
--- a/meson.build
+++ b/meson.build
@@ -613,7 +613,7 @@ if capstone_opt == 'no'
   capstone_opt = false
 elif capstone_opt in ['yes', 'auto', 'system']
   have_internal = fs.exists('capstone/Makefile')
-  capstone = dependency('capstone', static: enable_static,
+  capstone = dependency('capstone', version: '>=4.0', static: enable_static,
                         required: capstone_opt == 'system' or
                                   capstone_opt == 'yes' and not have_internal)
   if capstone.found()
-- 
2.25.1


