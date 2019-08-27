Return-Path: <SRS0=HeXf=WX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF9BCC3A59F
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2019 00:09:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B91E72053B
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2019 00:09:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LxwTJzDX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B91E72053B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58590 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i2P3S-0001Ew-AU
	for qemu-devel@archiver.kernel.org; Mon, 26 Aug 2019 20:09:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33595)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1i2P1f-0007z0-0I
 for qemu-devel@nongnu.org; Mon, 26 Aug 2019 20:07:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1i2P1d-00074A-R9
 for qemu-devel@nongnu.org; Mon, 26 Aug 2019 20:07:54 -0400
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543]:43001)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1i2P1d-00073Z-L8
 for qemu-devel@nongnu.org; Mon, 26 Aug 2019 20:07:53 -0400
Received: by mail-pg1-x543.google.com with SMTP id p3so11546182pgb.9
 for <qemu-devel@nongnu.org>; Mon, 26 Aug 2019 17:07:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=SRc32Ou24udhsMw0wK0CRQF1hYfrg5D7ZeKTyuBxM4c=;
 b=LxwTJzDXPH26lxArero6GA8UkaMcfy9Bk2Msaq+18TOm7Lrp8z2qttlEk7IFGWKyt7
 Z4wThRKAH483rSl5OVhO1tHGcigLfdexX6lQTcMX5mQvU8O+qlUbY1IwFTjf99/X5g7i
 wEI5xj7SA2la7l8Ws3Q/39chhfek+N3mF6P6KcoCZnXql2eNvNCVVnx6CCX0bUlbIBLD
 0MWd8UhxhQekPlVH0i/bSKu2MxKUNYmKk1JkWRKRx0cJTAmLQz7FaOQq+wOgLtmc7Pi5
 iRJzDFIqBPdohVEYABBArtE25hIiVO+H66QxaftYDC2mfXVfsh9wEiFni9KsrhBQg9UN
 XNCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=SRc32Ou24udhsMw0wK0CRQF1hYfrg5D7ZeKTyuBxM4c=;
 b=j6DhbRLHEvR4Xn5kSYtNV7RkXdr3330TVgMQBzTSwQxX6VG5SXZgb5uUVvgUa+7WyK
 Te+PdBWbxQzDpU1EDHE9+/ygcwXqoZAryvsgk79qVSzozYAbrzTKjAr9E1rgQBoCCX7O
 ZxI1UI1urZ0zvWnzEnWFTtwWLjFksZJgGb+K+IaQ7vpEXiFDHbJE9hpVc9dYO2RVyEzA
 C2xLYkB02RZ9qcDeW0QS2g1//BjN0FJyTse5lBbxYppIBDI39Fw8qvzMiBFy9u++uD0I
 5Z9SPzU0m74vp/nc437BmJwkOtXsNglHji37pzCB49buwGxdEA4EhzgTHjfPL5fCeyB4
 Dmow==
X-Gm-Message-State: APjAAAVP0jmI6XKoqfSjjYwxwBgTy9lL4u62aPwUAvDppp+4aK8bo6Vl
 FY1hoRG7mZzXm+FRWIzIHWAWtsd3ydg=
X-Google-Smtp-Source: APXvYqzgU0/BZb4S9XUbZmii5QhufKupahIBmjjTJcXtixS3xIqqvE2GtRoPRvVphoklIjI153McWQ==
X-Received: by 2002:a65:608e:: with SMTP id t14mr18785798pgu.373.1566864472122; 
 Mon, 26 Aug 2019 17:07:52 -0700 (PDT)
Received: from localhost.localdomain (97-113-7-119.tukw.qwest.net.
 [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id e189sm11691067pgc.15.2019.08.26.17.07.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Aug 2019 17:07:51 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Mon, 26 Aug 2019 17:07:36 -0700
Message-Id: <20190827000745.19645-5-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190827000745.19645-1-richard.henderson@linaro.org>
References: <20190827000745.19645-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::543
Subject: [Qemu-devel] [PATCH 04/13] target/openrisc: Make VR and PPC
 read-only
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
Cc: shorne@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

These SPRs are read-only.  The writes can simply be ignored,
as we already do for other read-only (or missing) registers.
There is no reason to mask the value in env->vr.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/openrisc/cpu.h        |  3 ---
 target/openrisc/sys_helper.c | 10 +---------
 2 files changed, 1 insertion(+), 12 deletions(-)

diff --git a/target/openrisc/cpu.h b/target/openrisc/cpu.h
index 561f0f7fad..755282f95d 100644
--- a/target/openrisc/cpu.h
+++ b/target/openrisc/cpu.h
@@ -68,9 +68,6 @@ enum {
                                       (reg) |= ((v & 0x1f) << 2);\
                                   } while (0)
 
-/* Version Register */
-#define SPR_VR 0xFFFF003F
-
 /* Interrupt */
 #define NR_IRQS  32
 
diff --git a/target/openrisc/sys_helper.c b/target/openrisc/sys_helper.c
index 1053409a04..d20f48b659 100644
--- a/target/openrisc/sys_helper.c
+++ b/target/openrisc/sys_helper.c
@@ -39,10 +39,6 @@ void HELPER(mtspr)(CPUOpenRISCState *env, target_ulong spr, target_ulong rb)
     int idx;
 
     switch (spr) {
-    case TO_SPR(0, 0): /* VR */
-        env->vr = rb;
-        break;
-
     case TO_SPR(0, 11): /* EVBAR */
         env->evbar = rb;
         break;
@@ -62,10 +58,6 @@ void HELPER(mtspr)(CPUOpenRISCState *env, target_ulong spr, target_ulong rb)
         cpu_set_sr(env, rb);
         break;
 
-    case TO_SPR(0, 18): /* PPC */
-        env->ppc = rb;
-        break;
-
     case TO_SPR(0, 32): /* EPCR */
         env->epcr = rb;
         break;
@@ -204,7 +196,7 @@ target_ulong HELPER(mfspr)(CPUOpenRISCState *env, target_ulong rd,
 
     switch (spr) {
     case TO_SPR(0, 0): /* VR */
-        return env->vr & SPR_VR;
+        return env->vr;
 
     case TO_SPR(0, 1): /* UPR */
         return env->upr;    /* TT, DM, IM, UP present */
-- 
2.17.1


