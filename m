Return-Path: <SRS0=PUPy=YH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 434C9ECE587
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 17:04:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0520C217D9
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 17:04:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ho/6xePR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0520C217D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54018 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iK3ls-00052T-AB
	for qemu-devel@archiver.kernel.org; Mon, 14 Oct 2019 13:04:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37197)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iK2qP-0004de-Px
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 12:05:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iK2qO-0007s2-Lk
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 12:05:13 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:45258)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iK2qO-0007rM-FO
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 12:05:12 -0400
Received: by mail-wr1-x443.google.com with SMTP id r5so20332412wrm.12
 for <qemu-devel@nongnu.org>; Mon, 14 Oct 2019 09:05:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=w2zTSs9Y2lp9+9zNL0MEH+1G0Ie/vtJdarrnfCIzakc=;
 b=ho/6xePRn1FeY6q/S4khg/RQpBlK1kXybYjdO3jKVUIXTrAWY5PluZndoSY5sci+Bs
 M5/nsr57Lm/KYm6nzWsX2NATUwOK4gSEuE4Frs5OncfHGvYwrx1osp671uK/hGlIFiLj
 hVp499ZsuQSDoUEYJ+52otFfAI03ujLK97RX0TTVcjlINbiZ5Zo9aa9NSvKvN/oLXCVI
 J9kWmc+kGUF9up28o+GFqCEbp5wKC8NgehEkfkZweKWMvuRm7/LLI8exzGx2nau0Ukwe
 OoPluLUn1xhskKNLuWndIVMbvEUGDjIU040mEWi/VmWiXHX6fw2tl6Hnto4Ld7BqekFz
 3hfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=w2zTSs9Y2lp9+9zNL0MEH+1G0Ie/vtJdarrnfCIzakc=;
 b=jCTFVlb5htwh7oiB+dMTyWprTK0zVK9+BvgvCeJ86fOVKY1PDCYCSe428goYLKBmLO
 hDOpfHybxsU1K9553qelMux2gCABjQ5wb1Y39OUNULpu8QHYYcGaDM6AbhtebckQ5Q+b
 woytGqi3cD2vNroacn+LHGpUpE0q/3VPMAWQAVMLFc2ogQRuJXAqygIJ/aC9zcHr5zt6
 SMpkVHvsBMuFN2Jl1vi2tSgczf+4YV17ujBXhHnMvEC2pdyqFRyjkYl5i96+qWXfD69x
 ghFzSH0KE8RidNCZc2wfeavfDTDS7g3ITJ2VydF56i+h2nAQZMcjabqVm1O2O8QXh3YE
 XH4g==
X-Gm-Message-State: APjAAAUVjiAhOLOMePMimrNKwbQZkI0An4dAPjmJGiKDwiY+MoVu21bA
 F3yq5DtZOrzlXVcX36GWVjArAnwUb7FjBg==
X-Google-Smtp-Source: APXvYqzcjy/gX9vD0C32TEnJZW+rGCHtCZmYKyuaLddR3+Zty1TrRwyYxhBAgjRo2Ylp5+4RRDNqSg==
X-Received: by 2002:a5d:55d0:: with SMTP id i16mr27672099wrw.150.1571069111200; 
 Mon, 14 Oct 2019 09:05:11 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id 5sm18029779wrk.86.2019.10.14.09.05.10
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Oct 2019 09:05:10 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 38/68] target/arm/arm-semi: Implement SH_EXT_EXIT_EXTENDED
 extension
Date: Mon, 14 Oct 2019 17:03:34 +0100
Message-Id: <20191014160404.19553-39-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191014160404.19553-1-peter.maydell@linaro.org>
References: <20191014160404.19553-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::443
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

SH_EXT_EXIT_EXTENDED is a v2.0 semihosting extension: it
indicates that the implementation supports the SYS_EXIT_EXTENDED
function. This function allows both A64 and A32/T32 guests to
exit with a specified exit status, unlike the older SYS_EXIT
function which only allowed this for A64 guests. Implement
this extension.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Message-id: 20190916141544.17540-15-peter.maydell@linaro.org
---
 target/arm/arm-semi.c | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/target/arm/arm-semi.c b/target/arm/arm-semi.c
index 57491740d73..f65d8c907e8 100644
--- a/target/arm/arm-semi.c
+++ b/target/arm/arm-semi.c
@@ -59,6 +59,7 @@
 #define TARGET_SYS_HEAPINFO    0x16
 #define TARGET_SYS_EXIT        0x18
 #define TARGET_SYS_SYNCCACHE   0x19
+#define TARGET_SYS_EXIT_EXTENDED 0x20
 
 /* ADP_Stopped_ApplicationExit is used for exit(0),
  * anything else is implemented as exit(1) */
@@ -513,12 +514,15 @@ static uint32_t gdb_flenfn(ARMCPU *cpu, GuestFD *gf)
 #define SHFB_MAGIC_2 0x46
 #define SHFB_MAGIC_3 0x42
 
+/* Feature bits reportable in feature byte 0 */
+#define SH_EXT_EXIT_EXTENDED (1 << 0)
+
 static const uint8_t featurefile_data[] = {
     SHFB_MAGIC_0,
     SHFB_MAGIC_1,
     SHFB_MAGIC_2,
     SHFB_MAGIC_3,
-    0, /* Feature byte 0 */
+    SH_EXT_EXIT_EXTENDED, /* Feature byte 0 */
 };
 
 static void init_featurefile_guestfd(int guestfd)
@@ -1042,11 +1046,14 @@ target_ulong do_arm_semihosting(CPUARMState *env)
             return 0;
         }
     case TARGET_SYS_EXIT:
-        if (is_a64(env)) {
+    case TARGET_SYS_EXIT_EXTENDED:
+        if (nr == TARGET_SYS_EXIT_EXTENDED || is_a64(env)) {
             /*
-             * The A64 version of this call takes a parameter block,
+             * The A64 version of SYS_EXIT takes a parameter block,
              * so the application-exit type can return a subcode which
              * is the exit status code from the application.
+             * SYS_EXIT_EXTENDED is an a new-in-v2.0 optional function
+             * which allows A32/T32 guests to also provide a status code.
              */
             GET_ARG(0);
             GET_ARG(1);
@@ -1058,8 +1065,10 @@ target_ulong do_arm_semihosting(CPUARMState *env)
             }
         } else {
             /*
-             * ARM specifies only Stopped_ApplicationExit as normal
-             * exit, everything else is considered an error
+             * The A32/T32 version of SYS_EXIT specifies only
+             * Stopped_ApplicationExit as normal exit, but does not
+             * allow the guest to specify the exit status code.
+             * Everything else is considered an error.
              */
             ret = (args == ADP_Stopped_ApplicationExit) ? 0 : 1;
         }
-- 
2.20.1


