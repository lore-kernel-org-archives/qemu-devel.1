Return-Path: <SRS0=IjNW=VM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4156AC7618F
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jul 2019 13:44:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0F3F22067C
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jul 2019 13:44:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="N03UZhwW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F3F22067C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38762 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hn1H5-0007QI-1g
	for qemu-devel@archiver.kernel.org; Mon, 15 Jul 2019 09:44:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51830)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hn1FK-00086m-1t
 for qemu-devel@nongnu.org; Mon, 15 Jul 2019 09:42:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hn1FI-0006D5-O9
 for qemu-devel@nongnu.org; Mon, 15 Jul 2019 09:42:25 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:32903)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hn1FG-0006Bd-Rh
 for qemu-devel@nongnu.org; Mon, 15 Jul 2019 09:42:23 -0400
Received: by mail-wm1-x342.google.com with SMTP id h19so14355384wme.0
 for <qemu-devel@nongnu.org>; Mon, 15 Jul 2019 06:42:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=kmd44QPB5fQioinpnyOTPTkf7ReufwKIl1vLPJ0oHiI=;
 b=N03UZhwWttVqwYCo8jdV55LfKwpaawjnoneiS3Doxwu5Ll+hLGfgV0ddQ0lAKE6Tw0
 kR0WiaE+UgxrBvmAjbL9349+Ld6KyFWzoAblO2rxVuii1YUOAUmoWhfilOG1UjjySmc2
 8Gj5PkZAbjY6VouB6f09z5jXfHhIwlXwtFxhiQF3LRKHR/V4vRGF8h6p8uI0vSYk2RvY
 Cchq+L6L5sesnaRZLRKbRXRWYQb4l73E0GlTox0m3/Byf4Ek5VrM86pL2qY1mIEDpdu0
 GMpKhKhQTMw2PmZP/OFlyz9T7grdhc+QNiIbBeIl1BJ6iLVST4KrJWeEUW9jGdYSklFx
 57TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=kmd44QPB5fQioinpnyOTPTkf7ReufwKIl1vLPJ0oHiI=;
 b=aoLwKVh5IFEi7s6dw7hsrhfiQrSfGYHcykAbotR7SuHdLlIdN2/E3nXMfXEadv02WF
 C+Vrhas72KuRBG57rTqu9J1jnHfC8ac2+HZ69Pleugl3blIwPnsoj4IyfeYZRF/KX9+/
 KtTlaZtmT0seoyWV21LHQGV/26diJA20DuksNIuVRaCIS4SN6c5OuH/NgUc6ELA8Kt5C
 T8aoISIEfqeSkslo4Yi9XRHWg/gdwjIh0bQUHAbWYAxtJNlTOpKTaWF4aU9llfH7qyYj
 rNpBsgZPTo0OaeX8G3QYg5NCi3HmYMT7kZzzCN4D0in46IlPU2FjxhXtF08J9LrAodc5
 RwIg==
X-Gm-Message-State: APjAAAX0Ip8QKrjSQHEFYRBMue7nD/o/ruoZf6bN4i8GvyKdXS13/5UI
 JbfQb3GFEHP7kuSgdoPLLZ/CGoMmyNdx6g==
X-Google-Smtp-Source: APXvYqyoNM/de+xUoMoBH2YEFzEJzgeA3CZEjEq3Xwec5F00Bqle3ETqq9GUfZNE6m8eicvFh0yLDQ==
X-Received: by 2002:a05:600c:da:: with SMTP id
 u26mr24039839wmm.108.1563198141615; 
 Mon, 15 Jul 2019 06:42:21 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id c7sm14221808wro.70.2019.07.15.06.42.20
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Mon, 15 Jul 2019 06:42:21 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Date: Mon, 15 Jul 2019 14:42:10 +0100
Message-Id: <20190715134211.23063-10-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190715134211.23063-1-peter.maydell@linaro.org>
References: <20190715134211.23063-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::342
Subject: [Qemu-devel] [PULL 09/10] target/arm: Set VFP-related MVFR0 fields
 for arm926 and arm1026
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

The ARMv5 architecture didn't specify detailed per-feature ID
registers. Now that we're using the MVFR0 register fields to
gate the existence of VFP instructions, we need to set up
the correct values in the cpu->isar structure so that we still
provide an FPU to the guest.

This fixes a regression in the arm926 and arm1026 CPUs, which
are the only ones that both have VFP and are ARMv5 or earlier.
This regression was introduced by the VFP refactoring, and more
specifically by commits 1120827fa182f0e76 and 266bd25c485597c,
which accidentally disabled VFP short-vector support and
double-precision support on these CPUs.

Fixes: 1120827fa182f0e
Fixes: 266bd25c485597c
Fixes: https://bugs.launchpad.net/qemu/+bug/1836192
Reported-by: Christophe Lyon <christophe.lyon@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Tested-by: Christophe Lyon <christophe.lyon@linaro.org>
Message-id: 20190711131241.22231-1-peter.maydell@linaro.org
---
 target/arm/cpu.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index ad164a773b2..1959467fdc8 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -1666,6 +1666,12 @@ static void arm926_initfn(Object *obj)
      * set the field to indicate Jazelle support within QEMU.
      */
     cpu->isar.id_isar1 = FIELD_DP32(cpu->isar.id_isar1, ID_ISAR1, JAZELLE, 1);
+    /*
+     * Similarly, we need to set MVFR0 fields to enable double precision
+     * and short vector support even though ARMv5 doesn't have this register.
+     */
+    cpu->isar.mvfr0 = FIELD_DP32(cpu->isar.mvfr0, MVFR0, FPSHVEC, 1);
+    cpu->isar.mvfr0 = FIELD_DP32(cpu->isar.mvfr0, MVFR0, FPDP, 1);
 }
 
 static void arm946_initfn(Object *obj)
@@ -1702,6 +1708,12 @@ static void arm1026_initfn(Object *obj)
      * set the field to indicate Jazelle support within QEMU.
      */
     cpu->isar.id_isar1 = FIELD_DP32(cpu->isar.id_isar1, ID_ISAR1, JAZELLE, 1);
+    /*
+     * Similarly, we need to set MVFR0 fields to enable double precision
+     * and short vector support even though ARMv5 doesn't have this register.
+     */
+    cpu->isar.mvfr0 = FIELD_DP32(cpu->isar.mvfr0, MVFR0, FPSHVEC, 1);
+    cpu->isar.mvfr0 = FIELD_DP32(cpu->isar.mvfr0, MVFR0, FPDP, 1);
 
     {
         /* The 1026 had an IFAR at c6,c0,0,1 rather than the ARMv6 c6,c0,0,2 */
-- 
2.20.1


