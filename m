Return-Path: <SRS0=brme=YQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB050CA9EB6
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2019 15:47:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 827B920679
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2019 15:47:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kRI/7Vjd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 827B920679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39906 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNIrJ-0005cD-1c
	for qemu-devel@archiver.kernel.org; Wed, 23 Oct 2019 11:47:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35503)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iNI8y-0008Hs-Tt
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 11:01:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iNI8r-0001Gm-P8
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 11:01:48 -0400
Received: from mail-qk1-x744.google.com ([2607:f8b0:4864:20::744]:35195)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iNI8r-0001A4-KE
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 11:01:41 -0400
Received: by mail-qk1-x744.google.com with SMTP id w2so20044779qkf.2
 for <qemu-devel@nongnu.org>; Wed, 23 Oct 2019 08:01:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=4z2zPWedOviyKqg3qmIWn8g3R8jv2yS1u67ka41eHWc=;
 b=kRI/7VjdZTOejYq4avHlHxKBwzld0iJdrnmUJYizOKUKU4Hvyw5X6xk+vB3jQ3MwbE
 GLKAtYQpd6/4UIjpbFlHS6RsMGZxt96vmQr8KHoZK7vq5Q/I2gQ+CJI+57KmH+9Tw/S8
 jzDgMHMp9/O4vIyfV63ewmnma2+XgWyqvayX8qP6LVmCGw6aqVx45uxbJG+W0jeX8edm
 vnZPw0Rra91QSKoi7rjXjY4gcglLlxA2jg29dVM2MKfyQt/2mAW4CjZid7E+oJ6jfNFo
 pTRacCtRxTQJf7PP7+OSofKTGq+VTEZPtewTlc93jRXkXg6C8Q6+fjTdecgZ+Gl/GAZe
 zI0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=4z2zPWedOviyKqg3qmIWn8g3R8jv2yS1u67ka41eHWc=;
 b=FJbhdIcmXvTqR2KPuBkWfeGMn7WStQ+i45Bma6yDZCj/O0407PL0jCFYyS4q8DvPK0
 DF7gNbl4ESwHCSGoNe+nU3PaN7YGYVYDfwqeffPYIpt3qS9jcJUV9F+cidYsPlufjoPm
 ZoXNEn0Pq9flEZNouBmXGQGacmFnJ1/viIx1ZijjJ48rBFfOxpOZ5KDcSv4w3q5btBdI
 4CUvEMOPlMDdAjOLtNbDan8mUkbPxeyoEp+CUgID35ZSHMa5/NKd+FRIYHyU0zrE32G+
 y0iqX9oQyrrEuF7fN4p8N/7aJwi8KGHGjbTPbH9ybJrQvDAiSgQUmVFI9FX8zmybOO1m
 GQ3A==
X-Gm-Message-State: APjAAAUsBzfuNvHLNwhn2QN7eD9oETzArtyIMSQ6OFuc0DkvVixjSMNm
 cfyao0P6kq2iGO3WiKAgojvv6O8xAyw=
X-Google-Smtp-Source: APXvYqwCyMJQhJXQl7OBCRepQyVtAXf4gm3vuPK9zHOvZBO9kBA4nDc4WfFJAdKfCphS9Oio81wzGg==
X-Received: by 2002:a37:7906:: with SMTP id u6mr9178909qkc.5.1571842888188;
 Wed, 23 Oct 2019 08:01:28 -0700 (PDT)
Received: from localhost.localdomain (198-4-20-64.static.cosmoweb.net.
 [64.20.4.198])
 by smtp.gmail.com with ESMTPSA id l189sm11030168qke.69.2019.10.23.08.01.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Oct 2019 08:01:27 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v9 19/24] target/arm: Rebuild hflags at Xscale SCTLR writes
Date: Wed, 23 Oct 2019 11:00:52 -0400
Message-Id: <20191023150057.25731-20-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191023150057.25731-1-richard.henderson@linaro.org>
References: <20191023150057.25731-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::744
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
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Continue setting, but not relying upon, env->hflags.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/helper.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index aae7b62458..c55783e540 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -4174,6 +4174,16 @@ static void sctlr_write(CPUARMState *env, const ARMCPRegInfo *ri,
     /* ??? Lots of these bits are not implemented.  */
     /* This may enable/disable the MMU, so do a TLB flush.  */
     tlb_flush(CPU(cpu));
+
+    if (ri->type & ARM_CP_SUPPRESS_TB_END) {
+        /*
+         * Normally we would always end the TB on an SCTLR write; see the
+         * comment in ARMCPRegInfo sctlr initialization below for why Xscale
+         * is special.  Setting ARM_CP_SUPPRESS_TB_END also stops the rebuild
+         * of hflags from the translator, so do it here.
+         */
+        arm_rebuild_hflags(env);
+    }
 }
 
 static CPAccessResult fpexc32_access(CPUARMState *env, const ARMCPRegInfo *ri,
-- 
2.17.1


