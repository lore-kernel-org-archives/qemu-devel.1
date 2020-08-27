Return-Path: <SRS0=k4hX=CF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9E07C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2020 05:08:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A2BE82080C
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2020 05:08:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TkDDcUg2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A2BE82080C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50968 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBA92-0007VY-Uh
	for qemu-devel@archiver.kernel.org; Thu, 27 Aug 2020 01:08:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33918)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kBA70-00031Y-Dv
 for qemu-devel@nongnu.org; Thu, 27 Aug 2020 01:06:10 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429]:36068)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kBA6y-0005ej-R1
 for qemu-devel@nongnu.org; Thu, 27 Aug 2020 01:06:10 -0400
Received: by mail-pf1-x429.google.com with SMTP id m8so2565896pfh.3
 for <qemu-devel@nongnu.org>; Wed, 26 Aug 2020 22:06:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=rIP9TCfc3oqvA8Vp/R/E5MTUabOcrCowAJuIfVAgJrs=;
 b=TkDDcUg2GU/8UeZcEWahaO+7zHC5uhjvAo5b8Ty6Pt1uxCM1L2/w9XS2Zlx10L4Z+S
 AkZjj63BqK8svVdTuxqVNRYOE/QtYQC9Mmd82Qax+JsdQj/k/HII4KPQVQaatzx2DLkb
 fn4wgwVB9sYlaz4uGwOhqgbjarsZO4hknC2lN3i/1lCU+Bju56AO/n5fsPGDhafQRl+H
 jDV4mFoCnXCFfm3bH6MYoHjQj3ZzZ7igWawc0gi/on89/XSSfXFcZHKTyQ1rkXKL43tK
 bkyuMyF4Rg6UvRqdRKvm9KU6/GrZ9ddV6AjFnOiHCgqcuc1yd1uIj9xrKivET384JweC
 niGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=rIP9TCfc3oqvA8Vp/R/E5MTUabOcrCowAJuIfVAgJrs=;
 b=Q5narCu+jqJphJpNy7Vnp8zp0X0zZU/bK2a2gCAaWKmZQckiHDtkZ2PcwliZDND5Ot
 /LctKXuUm0LgNVgjaDL8FxOH0qE2iGWEkb77VHXWDEj6XIrcVnqRkmuz7WUlFdc9X99T
 jLZOxVXS7pqircNV689xuXYsMvo1AJbVa/KX/YDQV3qJiNjBfnTnatuoFBg7YT3waUm6
 Kr1S74EqKbSfXo8vGar7XsLBmKaVBQuFRQ22TLAd+zPUITWhGi/Mzn5m/zUWvegeScpZ
 2QDjVzGhAJiVMk0WpR5d7G8NevtzRxvjKbbvis72pQvdwNm/x8GmBfmCj5qYoNqcDj+K
 RG/w==
X-Gm-Message-State: AOAM533V9bs5M0r0tzZ/1xtH8Ru5xEkQ2AwaUoD6T2k8Qaobeq85vEZy
 tQH8L6YDVBrAOcxLkzMvj/lLaf2VQrps8Vgqe3k=
X-Google-Smtp-Source: ABdhPJxzzIC0pwcJzoBcpsJCC5d/Kfk0Y63gjUnGLvYfxsgmvSniX91t8/Cej2ZwZzINyHkMakXl+Q==
X-Received: by 2002:a63:471b:: with SMTP id u27mr13149500pga.139.1598504766932; 
 Wed, 26 Aug 2020 22:06:06 -0700 (PDT)
Received: from localhost.localdomain ([103.94.185.75])
 by smtp.googlemail.com with ESMTPSA id u3sm724213pjn.29.2020.08.26.22.06.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Aug 2020 22:06:06 -0700 (PDT)
From: luoyonggang@gmail.com
To: qemu-devel@nongnu.org
Subject: [PATCH v2 3/6] meson: Mingw64 gcc doesn't recognize system
 include_type for sdl2
Date: Thu, 27 Aug 2020 13:05:40 +0800
Message-Id: <20200827050543.44-4-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.27.0.windows.1
In-Reply-To: <20200827050543.44-1-luoyonggang@gmail.com>
References: <20200827050543.44-1-luoyonggang@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=luoyonggang@gmail.com; helo=mail-pf1-x429.google.com
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
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=E8=8C=85?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Yonggang Luo <luoyonggang@gmail.com>

Fixes this for msys2/mingw64 by remove the include_type for sdl2 discovery in meson

Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
---
 meson.build | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/meson.build b/meson.build
index f0fe5f8799..1644bbd83c 100644
--- a/meson.build
+++ b/meson.build
@@ -224,8 +224,7 @@ if 'CONFIG_BRLAPI' in config_host
   brlapi = declare_dependency(link_args: config_host['BRLAPI_LIBS'].split())
 endif
 
-sdl = dependency('sdl2', required: get_option('sdl'), static: enable_static,
-                 include_type: 'system')
+sdl = dependency('sdl2', required: get_option('sdl'), static: enable_static)
 sdl_image = not_found
 if sdl.found()
   # work around 2.0.8 bug
-- 
2.27.0.windows.1


