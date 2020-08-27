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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C14FC433E1
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2020 04:50:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 353E62078A
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2020 04:50:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lj+7e+M3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 353E62078A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54132 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kB9rx-0004hG-EH
	for qemu-devel@archiver.kernel.org; Thu, 27 Aug 2020 00:50:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59584)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kB9rC-00031R-2O
 for qemu-devel@nongnu.org; Thu, 27 Aug 2020 00:49:50 -0400
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:36941)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kB9rA-0003hF-Eb
 for qemu-devel@nongnu.org; Thu, 27 Aug 2020 00:49:49 -0400
Received: by mail-pf1-x443.google.com with SMTP id x143so2535425pfc.4
 for <qemu-devel@nongnu.org>; Wed, 26 Aug 2020 21:49:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=rIP9TCfc3oqvA8Vp/R/E5MTUabOcrCowAJuIfVAgJrs=;
 b=Lj+7e+M31Jh9HGfacgwlvuk2cowjBdBkec7wQbrdIuxNlLoOXE+zVBSqfHBSGkXP+Y
 0kpdipUVzCQkhiSMsr0XYg0loio89MY1CSR5uE3oleWcHX0tUzZAfr5WArCQXocXG+BQ
 faglqAGKhF31GYN2LA2AUcpwFll0R9EYHHMVfilL+N2lteX5hdH3y2qsT6iwcTo5z7gB
 ydmpBA165fyvGUEB7oUhUGMXAbVHrX7N/OihHtOrap/OtVPwDystEHGND+IaSflqBC/1
 q1w9tUSuRs6/l3pcGUkM7dEMCpQswATCCUpqV+yLM7pQJ/Ok+ddu6erkyKVaPtumH2sV
 VRRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=rIP9TCfc3oqvA8Vp/R/E5MTUabOcrCowAJuIfVAgJrs=;
 b=HGIEsKSucQAL3Os+O3TUzQTgQH5E3VgvRwIE3FnT1KfhAySuoO7oj9iK4LGVf9/EYd
 1EqbUkPVUUcWXSAnK5/5uEvInMGXQuehHvA3/y39DXj2NtEdlUBqS1V1uJc6EcSpMKN3
 dsvS0ZRwwe1MgLZO2lv4dc5lqw4tP7llxgYJ7tFQ38Nrws01IWXoXZPK/UhTbczqIUUO
 VFYzHEXr7AiGVgvzj2QNmWN2JaqLhYXJ+PCk3LiZc3lQCOCLOLP4BH+FghkCgz4X2026
 cxGZQOocrdfNnJpQWvmfr2AhxYP/JHX/U9kVXSaAZ8MB4ZQ6cGnxIWHodd1QaQPxP995
 NJmQ==
X-Gm-Message-State: AOAM5328/7BnK/C/wOd5PMNUNUCP9xWDTrO7tes/W+fExhp66iDFj+//
 Oe08aBjif/EOFcapSnJ1ruNdlDffwT+v7aLy1kI=
X-Google-Smtp-Source: ABdhPJxTfljYwgIutZFgXEfn4gT7GzzEUplBwHPhXaSX6LSFv+N0UibHi/EAGJbMiBuWLM3MeEB+WA==
X-Received: by 2002:a63:2482:: with SMTP id
 k124mr13780529pgk.251.1598503786704; 
 Wed, 26 Aug 2020 21:49:46 -0700 (PDT)
Received: from localhost.localdomain ([2401:c080:1c01:4fe:5400:2ff:fef1:b056])
 by smtp.googlemail.com with ESMTPSA id
 n26sm902296pff.30.2020.08.26.21.49.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Aug 2020 21:49:45 -0700 (PDT)
From: luoyonggang@gmail.com
To: qemu-devel@nongnu.org
Subject: [PATCH 3/6] meson: Mingw64 gcc doesn't recognize system include_type
 for sdl2
Date: Thu, 27 Aug 2020 12:49:14 +0800
Message-Id: <20200827044917.1356-4-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.27.0.windows.1
In-Reply-To: <20200827044917.1356-1-luoyonggang@gmail.com>
References: <20200827044917.1356-1-luoyonggang@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::443;
 envelope-from=luoyonggang@gmail.com; helo=mail-pf1-x443.google.com
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
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>
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


