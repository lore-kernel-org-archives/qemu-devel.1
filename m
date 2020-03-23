Return-Path: <SRS0=WkHy=5I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92427C3F2CD
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2020 17:41:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4B5B52072D
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2020 17:41:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VeQEvntk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B5B52072D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37622 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jGR5A-00061N-Bf
	for qemu-devel@archiver.kernel.org; Mon, 23 Mar 2020 13:41:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52220)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jGR3h-0004OG-Hw
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 13:40:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1jGR3g-0003hZ-If
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 13:40:17 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:39659)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1jGR3g-0003g3-5v
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 13:40:16 -0400
Received: by mail-wr1-x441.google.com with SMTP id p10so5764031wrt.6
 for <qemu-devel@nongnu.org>; Mon, 23 Mar 2020 10:40:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=Bajoz+UVKNChgk5fuej6bzALgtOzMFKSB1SLz/XHXRk=;
 b=VeQEvntktYkrFhTTinhzDdlSffzgyQJcqnsTTuyZyemL9UGRjlxdJincdEA5cSuYec
 Txvs51POF+yI0Pbi+MC9ov1W4VSpu9zFj7PRCZEeToZjZXldz7vqJldGgBuIDOuwlftx
 jGXIzxrOHwd3ohksrxFm7rnva+BcluBQIwbMqWM+vhLS24ZaTQ9MZQwLZm4OeDWhbSBt
 azwDrZm8ibQZeYFZdK86y26+EOuYZ8GBj9slLafFXj4D5nTcPy7cUi1CocPP+RRXNumM
 U+PxFpZ2HPaS68kTywFsagD+HgBUT67TBi3lVWgX9V4RjZkcVyS2nAOQ09pk+uZ+2sAH
 dVOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Bajoz+UVKNChgk5fuej6bzALgtOzMFKSB1SLz/XHXRk=;
 b=R2nNumqp+86y2RoIMM0kRONevzPDqV2nLeQ9G+NZXnJi9MjVVDt0+bmuag34sEoyF/
 YwuOmphVWehPgnNEabTL5mtEUopQ1Vqy1+9MJKHDwLVl9C+AA9jJ8T/WQhGH/3oZwM2B
 mYSCpGUrF5uiwHDnjKfklKmpAvOQ0q2sLIA11Qzo48ZzEnHYJFYfqHoY2pZn/4hRmTI7
 XkLsZO//L2Q+mVnL/uvmSy2O1AJoTuZ2FA4ZMHu8SLjGWzdRPlq1Qn5hxTAcEo2EcGV6
 ecQrraiyQaerZ8EadZm6D1wJiMiKubRebWpXDRgc0kO9pW1z1wF0gvJaO287agnxsOQb
 5qsw==
X-Gm-Message-State: ANhLgQ13Qc89MG/ZW8BRb0znZmjzpgYZ80NTdfINg4uAZZzP+WwgVJac
 rvWw3Av+ASHkj90yQHnUnWiVrVYgsj/86A==
X-Google-Smtp-Source: ADFU+vsabAUZ/Hx2f2uURgCoAc8fPBPFO5E1BBweePnyxqncscz7rDhNZa61qi5MPILHBaAC3sfuZw==
X-Received: by 2002:adf:efc9:: with SMTP id i9mr10965935wrp.23.1584985214122; 
 Mon, 23 Mar 2020 10:40:14 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id o9sm25145282wrw.20.2020.03.23.10.40.13
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Mar 2020 10:40:13 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 4/5] target/arm: Assert immh != 0 in disas_simd_shift_imm
Date: Mon, 23 Mar 2020 17:40:05 +0000
Message-Id: <20200323174006.8468-5-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200323174006.8468-1-peter.maydell@linaro.org>
References: <20200323174006.8468-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::441
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

From: Richard Henderson <richard.henderson@linaro.org>

Coverity raised a shed-load of errors cascading from inferring
that clz32(immh) might yield 32, from immh might be 0.

While immh cannot be 0 from encoding, it is not obvious even to
a human how we've checked that: via the filtering provided by
data_proc_simd[].

Reported-by: Coverity (CID 1421923, and more)
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-id: 20200320160622.8040-3-richard.henderson@linaro.org
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/translate-a64.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index 8fffb52203d..032478614c4 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -10405,6 +10405,9 @@ static void disas_simd_shift_imm(DisasContext *s, uint32_t insn)
     bool is_u = extract32(insn, 29, 1);
     bool is_q = extract32(insn, 30, 1);
 
+    /* data_proc_simd[] has sent immh == 0 to disas_simd_mod_imm. */
+    assert(immh != 0);
+
     switch (opcode) {
     case 0x08: /* SRI */
         if (!is_u) {
-- 
2.20.1


