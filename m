Return-Path: <SRS0=vx8y=AW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E846C433E3
	for <qemu-devel@archiver.kernel.org>; Sat, 11 Jul 2020 17:08:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0A98E20786
	for <qemu-devel@archiver.kernel.org>; Sat, 11 Jul 2020 17:08:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RjpP83qd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A98E20786
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45004 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1juIzO-0005FM-5g
	for qemu-devel@archiver.kernel.org; Sat, 11 Jul 2020 13:08:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33278)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1juIyY-0003Zo-AS
 for qemu-devel@nongnu.org; Sat, 11 Jul 2020 13:07:46 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333]:40718)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1juIyW-0006i4-PI
 for qemu-devel@nongnu.org; Sat, 11 Jul 2020 13:07:46 -0400
Received: by mail-wm1-x333.google.com with SMTP id f139so8926323wmf.5
 for <qemu-devel@nongnu.org>; Sat, 11 Jul 2020 10:07:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=P6PJzzzQNrSC5tAYpYn2kGTEbKawbCEqTeNv8SlAYQ0=;
 b=RjpP83qder6zD01uFcnQCzUjtlgSVBU+2ABDGdV+dfajSRdmgoqIMxGw88rK9HZ6pc
 fhmXA8jUz5GMRk8oFyanuBfmakKUK/JEAD6FgEWSNOtPWsk1G251d1/eqXGcgl3TjKIA
 vFs6H/9wT4EwOp9GAkJJuQiyPv42E3ChIVVx6bqCWmFYrbszfPGPXWd9qD2bejwn3RLG
 1a8PU/JsctXq7TE6hAOoq7ic9U48lz1i9bu6dkt18HT8G91hroOUEWPgFxao0vIjCpfU
 fjLCXJM0VdAh387rM/ZzAS1U6MTIryzSLhzNoxOb1Iq7tUvKHIUVTNtk0YF2tipa120f
 7+YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=P6PJzzzQNrSC5tAYpYn2kGTEbKawbCEqTeNv8SlAYQ0=;
 b=bNtLkm9N3K8xEuwOJzvxEpgp/1EjBrSJLMN7Y0NRcKEiN/VHjciRhK7OR6Qba2WmXR
 63/uLRxA6srvtPNpsx/36aNwa3w7rlLHSjW1G1thI6DGxP8sxoeXBCdK9XP2MIBJbE+E
 HxYQQm7O/+6QgH21KeLOyCmr82siNfCoc2H/9Q6f5cBPKATII59snUXLDrE5wFmdoQUC
 S3cij0HquN35x/j8Dl4cVWWHJaaaTxy2fTcJUd/gcAaLzpXbmXbENWjn7Cw5mOhzUnyN
 0R04TseZlHC+rFC20O+9N7n55BtwHlOYbJUuMCZWhPi78pYYQAVoE74AwiEb+3/i1lKG
 P6Pw==
X-Gm-Message-State: AOAM530DaPdBhGWMMtDIkP+fZ2Fn+1Ef1GL/xxluMV2docBuBCPHVLPW
 kt2T9ewlAz5KsSL9VeXN1CFkcw==
X-Google-Smtp-Source: ABdhPJxCPE6l0VtJPFjy3YgqXA6yBe2rkWP0KrgCULqKvM5q1nFcOlSW47CYvWU1M5tMkXnDQDBiLg==
X-Received: by 2002:a05:600c:218f:: with SMTP id
 e15mr10399380wme.187.1594487263417; 
 Sat, 11 Jul 2020 10:07:43 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id c206sm15510000wmf.36.2020.07.11.10.07.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 11 Jul 2020 10:07:37 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id BEDE71FF93;
 Sat, 11 Jul 2020 18:07:32 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Subject: [PULL v2 47/50] .cirrus.yml: add bash to the brew packages
Date: Sat, 11 Jul 2020 18:07:29 +0100
Message-Id: <20200711170732.26213-8-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200711170732.26213-1-alex.bennee@linaro.org>
References: <20200711170732.26213-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x333.google.com
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
Cc: Ed Maste <emaste@freebsd.org>, Li-Wen Hsu <lwhsu@freebsd.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Like the sed we include earlier we want something more recent for
iotests to work.

Fixes: 57ee95ed
Cc: Max Reitz <mreitz@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20200710182238.10675-1-alex.bennee@linaro.org>

diff --git a/.cirrus.yml b/.cirrus.yml
index 69342ae031..f287d23c5b 100644
--- a/.cirrus.yml
+++ b/.cirrus.yml
@@ -20,7 +20,7 @@ macos_task:
   osx_instance:
     image: mojave-base
   install_script:
-    - brew install pkg-config python gnu-sed glib pixman make sdl2
+    - brew install pkg-config python gnu-sed glib pixman make sdl2 bash
   script:
     - mkdir build
     - cd build
@@ -33,7 +33,7 @@ macos_xcode_task:
     # this is an alias for the latest Xcode
     image: mojave-xcode
   install_script:
-    - brew install pkg-config gnu-sed glib pixman make sdl2
+    - brew install pkg-config gnu-sed glib pixman make sdl2 bash
   script:
     - mkdir build
     - cd build
-- 
2.20.1


