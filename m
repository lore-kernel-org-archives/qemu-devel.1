Return-Path: <SRS0=A34B=UQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5BFAC31E5B
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 15:33:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8CE9C208CB
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 15:33:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CvFMte1e"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8CE9C208CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48538 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hctdK-0003tL-R7
	for qemu-devel@archiver.kernel.org; Mon, 17 Jun 2019 11:33:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46747)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hcsiN-0003hE-Sz
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 10:34:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hcsiM-00087i-AY
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 10:34:31 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c]:46867)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hcsiM-00086z-3y
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 10:34:30 -0400
Received: by mail-wr1-x42c.google.com with SMTP id n4so10192276wrw.13
 for <qemu-devel@nongnu.org>; Mon, 17 Jun 2019 07:34:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=Ul7s+t7hXiN2ylOfOOWOvIZY61Jzqwc15l5S4ChbjBk=;
 b=CvFMte1edGk9eG8aLfxqr1dB7a84QSvtFjjuq7lkeTzTmBVgwE83VlUWCqVTNuVytC
 Sz0MOwq0w9oLGDbjx2SudKGXC0gAwuR5r0wdmnTiiLzEonSYmWsu9cFSvUiswtzzqY18
 HGvMqeXeVTvjbKTxEIDdzLYCrrgOwHZS5Y+fS0xb7itG3ItmRtuvtq6sjb3M3Rwr4l0V
 SJ13cOYCGeI8DQ2GFY2tDZUwwhkVGUGBD5HsKKfiV8K4bv2gFwHvUhZ7cJVHBcy03hdV
 9P/oP6xdHr7cBFsXkYwuqg81qRzLWmaLseu5D2qkRgjZ1KvPfyc+WWnB4y+d55urNIeO
 /eYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Ul7s+t7hXiN2ylOfOOWOvIZY61Jzqwc15l5S4ChbjBk=;
 b=aHVPsbuJ2/V/3h+60eoSVRAjKhOkJyuOQscf+hdRnaE2RQSWOPuf5t+2eI+lVm5Mh+
 WYGtxTM/jaWjxupQnII1JwyXJo4a4r4vtOKpRtvelStTc3uImseEs3lA12aH/BJcNYmR
 7hkmYIfoJyY6rBtFctVnQZ5wHaGYD3V8+Y4umS61i5rIsq0Vixt5KSV6f5yZVVslAPpn
 GEzXRBlittyEprr+O9nLTA7xTnQwtnrRUVBmPa9Kkeb/VkFIRQagvViK8TEb1B4sRzly
 FHkWtEo9z5rJgjb/PeiBj3Yrhp19cFnkO7MVvni5Fnu+qXHurvWw3uNbocVJtdiV7Rgh
 EEnQ==
X-Gm-Message-State: APjAAAUVES4jqe9qRGBmVthaURQGcjrPzjXWGBnwy8awHeO12bgcdLhP
 ui9pnUYNCxJImb2thkCnR5APVXpOuhfiLQ==
X-Google-Smtp-Source: APXvYqwGjbkH3UXRA7nFlilUNpcQMPxSsa78E0ubDZOtdiHrdrB5vNI2cjZn7AgnGCPJBAz08RzgCQ==
X-Received: by 2002:a5d:6212:: with SMTP id y18mr29951084wru.178.1560782068873; 
 Mon, 17 Jun 2019 07:34:28 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id a67sm13819985wmh.40.2019.06.17.07.34.27
 for <qemu-devel@nongnu.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 17 Jun 2019 07:34:28 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Date: Mon, 17 Jun 2019 15:34:01 +0100
Message-Id: <20190617143412.5734-14-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190617143412.5734-1-peter.maydell@linaro.org>
References: <20190617143412.5734-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::42c
Subject: [Qemu-devel] [PULL 13/24] target/arm: Stop using cpu_F0s for
 NEON_2RM_VABS_F
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

Where Neon instructions are floating point operations, we
mostly use the old VFP utility functions like gen_vfp_abs()
which work on the TCG globals cpu_F0s and cpu_F1s. The
Neon for-each-element loop conditionally loads the inputs
into either a plain old TCG temporary for most operations
or into cpu_F0s for float operations, and similarly stores
back either cpu_F0s or the temporary.

Switch NEON_2RM_VABS_F away from using cpu_F0s, and
update neon_2rm_is_float_op() accordingly.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-id: 20190613163917.28589-4-peter.maydell@linaro.org
---
 target/arm/translate.c | 19 ++++++++-----------
 1 file changed, 8 insertions(+), 11 deletions(-)

diff --git a/target/arm/translate.c b/target/arm/translate.c
index c274c8b4602..a10fded1f39 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -1374,14 +1374,6 @@ static TCGv_ptr get_fpstatus_ptr(int neon)
     return statusptr;
 }
 
-static inline void gen_vfp_abs(int dp)
-{
-    if (dp)
-        gen_helper_vfp_absd(cpu_F0d, cpu_F0d);
-    else
-        gen_helper_vfp_abss(cpu_F0s, cpu_F0s);
-}
-
 static inline void gen_vfp_neg(int dp)
 {
     if (dp)
@@ -4191,8 +4183,13 @@ static const uint8_t neon_3r_sizes[] = {
 
 static int neon_2rm_is_float_op(int op)
 {
-    /* Return true if this neon 2reg-misc op is float-to-float */
-    return (op == NEON_2RM_VABS_F || op == NEON_2RM_VNEG_F ||
+    /*
+     * Return true if this neon 2reg-misc op is float-to-float.
+     * This is not a property of the operation but of our code --
+     * what we are asking here is "does the code for this case in
+     * the Neon for-each-pass loop use cpu_F0s?".
+     */
+    return (op == NEON_2RM_VNEG_F ||
             (op >= NEON_2RM_VRINTN && op <= NEON_2RM_VRINTZ) ||
             op == NEON_2RM_VRINTM ||
             (op >= NEON_2RM_VRINTP && op <= NEON_2RM_VCVTMS) ||
@@ -6761,7 +6758,7 @@ static int disas_neon_data_insn(DisasContext *s, uint32_t insn)
                             break;
                         }
                         case NEON_2RM_VABS_F:
-                            gen_vfp_abs(0);
+                            gen_helper_vfp_abss(tmp, tmp);
                             break;
                         case NEON_2RM_VNEG_F:
                             gen_vfp_neg(0);
-- 
2.20.1


