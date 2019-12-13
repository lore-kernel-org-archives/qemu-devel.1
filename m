Return-Path: <SRS0=VaDC=2D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9393C43603
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2019 05:50:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A541622527
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2019 05:50:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=aj.id.au header.i=@aj.id.au header.b="AJOpj6G8";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="P4wu3xWK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A541622527
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=aj.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41170 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ifdqG-0004cu-NE
	for qemu-devel@archiver.kernel.org; Fri, 13 Dec 2019 00:50:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56225)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <andrew@aj.id.au>) id 1ifdos-00036l-BW
 for qemu-devel@nongnu.org; Fri, 13 Dec 2019 00:48:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <andrew@aj.id.au>) id 1ifdoq-0004u7-WC
 for qemu-devel@nongnu.org; Fri, 13 Dec 2019 00:48:54 -0500
Received: from wout3-smtp.messagingengine.com ([64.147.123.19]:58197)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <andrew@aj.id.au>)
 id 1ifdon-0004mH-O7; Fri, 13 Dec 2019 00:48:49 -0500
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
 by mailout.west.internal (Postfix) with ESMTP id 70A828F2;
 Fri, 13 Dec 2019 00:48:48 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
 by compute4.internal (MEProxy); Fri, 13 Dec 2019 00:48:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aj.id.au; h=from
 :to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-type:content-transfer-encoding; s=fm1; bh=
 lF/a3idVNwHnX0XK1rPPf8+9v2Pnt27BJWxzuIfged8=; b=AJOpj6G8P9YissdJ
 FPD3Nm4ILZwz8ByQTI93Rd2pAS4j8K5JyQkeO72C9ZhpnD5P1cs0tE+8fp9gSI0A
 2EzVAA0l/LBvN227uKbRa0tvSN9UOFrAclrvOvuLeBIdkchg2tnivl1PWGpP0GUl
 HGllpmgY5QudDS1oROw27lOLq9pN50mpxr+Bz5JbptnI7XO5c/4JzZgUl8Xc6ygk
 QKfmeLqBMFh2aGqOBF9DtdTYaVb/Wj+0JxyXTh4JDP5mpbSIw7gI6f5ESxQAefyH
 y2n6aZyAPubLE7nHFyKl+d9DEcMFaI4//joQPUk8JSjXua2T39GfdGcbL1eSWkMU
 Wlw55g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:content-type
 :date:from:in-reply-to:message-id:mime-version:references
 :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
 :x-sasl-enc; s=fm1; bh=lF/a3idVNwHnX0XK1rPPf8+9v2Pnt27BJWxzuIfge
 d8=; b=P4wu3xWK7FbQ6oZtsvBR5BkeS4iYwWthQX18IUMzPjkb7ZMQo2NTjlzKo
 lufqw4vGzpWEXZlwz2wiV7f8C3J4uP7uLbkRx6IEiIOOfnpHwu7Vu8UrdIAgkflE
 tv9QmhRthHzjnNH5uHe2DJYbGrOJ1cYCQoVmjj1+i/J+qPqBIT2g/kxmHRY0IFuS
 FZOUkvebFxQ0s5geC8EeTghQQ+jSvqoqjGvHoXY4ge6B3rFUTSj9isMUYgpfjSHH
 AbWY4+p1pDSCSydNEszeONquJFcV6oXXr34oRjnA/MdwrY0oOtdcibCTgipXMMvE
 +7n2vv2dPPgBV3DV2mUPNqVUynVpg==
X-ME-Sender: <xms:PybzXW54JXibJB2BSC9nM_bgtQQOIeK0PBGjPQ-0Jxuc-5l7RjASYw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedufedrudelkedgkeejucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhephffvufffkffojghfgggtgfesthekredtredtjeenucfhrhhomheptehnughr
 vgifucflvghffhgvrhihuceorghnughrvgifsegrjhdrihgurdgruheqnecukfhppedvtd
 dvrdekuddrudekrdeftdenucfrrghrrghmpehmrghilhhfrhhomheprghnughrvgifsegr
 jhdrihgurdgruhenucevlhhushhtvghrufhiiigvpedu
X-ME-Proxy: <xmx:PybzXbnqMUj1KPfU7tGUja7SCfStiR3b8djA9BV9jGGp-ccbslGt_w>
 <xmx:PybzXQKA9wJqdSOYp0bGhX23NHOGhKrwJDbYZ4VDGcFWcerTh2LJUQ>
 <xmx:PybzXUGUZSzuwXmUrguFRMGkcai3OXQV5leFO7DRrW0aFDFOwDzFww>
 <xmx:QCbzXZFiboaTqGmA2Q9sar6HUTP-zSoLCs2DcrBaRtZVmX14x_YEcQ>
Received: from mistburn.au.ibm.com (bh02i525f01.au.ibm.com [202.81.18.30])
 by mail.messagingengine.com (Postfix) with ESMTPA id C76D180063;
 Fri, 13 Dec 2019 00:48:44 -0500 (EST)
From: Andrew Jeffery <andrew@aj.id.au>
To: qemu-arm@nongnu.org
Subject: [PATCH v3 2/4] target/arm: Abstract the generic timer frequency
Date: Fri, 13 Dec 2019 16:19:49 +1030
Message-Id: <40bd8df043f66e1ccfb3e9482999d099ac72bb2e.1576215453.git-series.andrew@aj.id.au>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.ec85a2db47c3e10de70fba144e1bc75caf2f0a91.1576215453.git-series.andrew@aj.id.au>
References: <cover.ec85a2db47c3e10de70fba144e1bc75caf2f0a91.1576215453.git-series.andrew@aj.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 64.147.123.19
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
Cc: peter.maydell@linaro.org, Richard Henderson <richard.henderson@linaro.org>,
 qemu-devel@nongnu.org, clg@kaod.org, philmd@redhat.com, joel@jms.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Prepare for SoCs such as the ASPEED AST2600 whose firmware configures
CNTFRQ to values significantly larger than the static 62.5MHz value
currently derived from GTIMER_SCALE. As the OS potentially derives its
timer periods from the CNTFRQ value the lack of support for running
QEMUTimers at the appropriate rate leads to sticky behaviour in the
guest.

Substitute the GTIMER_SCALE constant with use of a helper to derive the
period from gt_cntfrq_hz stored in struct ARMCPU. Initially set
gt_cntfrq_hz to the frequency associated with GTIMER_SCALE so current
behaviour is maintained.

Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---

v3:
* Uninline gt_cntfrq_period_ns()
* Rename gt_cntfrq to gt_cntfrq_hz

 target/arm/cpu.c    |  8 ++++++++
 target/arm/cpu.h    |  5 +++++
 target/arm/helper.c | 10 +++++++---
 3 files changed, 20 insertions(+), 3 deletions(-)

diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 7a4ac9339bf9..cd0dbe005d9f 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -974,6 +974,8 @@ static void arm_cpu_initfn(Object *obj)
     if (tcg_enabled()) {
         cpu->psci_version = 2; /* TCG implements PSCI 0.2 */
     }
+
+    cpu->gt_cntfrq_hz = NANOSECONDS_PER_SECOND / GTIMER_SCALE;
 }
 
 static Property arm_cpu_reset_cbar_property =
@@ -1055,6 +1057,12 @@ static void arm_set_init_svtor(Object *obj, Visitor *v, const char *name,
     visit_type_uint32(v, name, &cpu->init_svtor, errp);
 }
 
+unsigned int gt_cntfrq_period_ns(ARMCPU *cpu)
+{
+    return NANOSECONDS_PER_SECOND > cpu->gt_cntfrq_hz ?
+      NANOSECONDS_PER_SECOND / cpu->gt_cntfrq_hz : 1;
+}
+
 void arm_cpu_post_init(Object *obj)
 {
     ARMCPU *cpu = ARM_CPU(obj);
diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 83a809d4bac4..ff17ec0df545 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -932,8 +932,13 @@ struct ARMCPU {
      */
     DECLARE_BITMAP(sve_vq_map, ARM_MAX_VQ);
     DECLARE_BITMAP(sve_vq_init, ARM_MAX_VQ);
+
+    /* Generic timer counter frequency, in Hz */
+    uint64_t gt_cntfrq_hz;
 };
 
+unsigned int gt_cntfrq_period_ns(ARMCPU *cpu);
+
 void arm_cpu_post_init(Object *obj);
 
 uint64_t arm_cpu_mp_affinity(int idx, uint8_t clustersz);
diff --git a/target/arm/helper.c b/target/arm/helper.c
index 65c4441a3896..2622a9a8d02f 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -2409,7 +2409,9 @@ static CPAccessResult gt_stimer_access(CPUARMState *env,
 
 static uint64_t gt_get_countervalue(CPUARMState *env)
 {
-    return qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) / GTIMER_SCALE;
+    ARMCPU *cpu = env_archcpu(env);
+
+    return qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) / gt_cntfrq_period_ns(cpu);
 }
 
 static void gt_recalc_timer(ARMCPU *cpu, int timeridx)
@@ -2445,7 +2447,7 @@ static void gt_recalc_timer(ARMCPU *cpu, int timeridx)
          * set the timer for as far in the future as possible. When the
          * timer expires we will reset the timer for any remaining period.
          */
-        if (nexttick > INT64_MAX / GTIMER_SCALE) {
+        if (nexttick > INT64_MAX / gt_cntfrq_period_ns(cpu)) {
             timer_mod_ns(cpu->gt_timer[timeridx], INT64_MAX);
         } else {
             timer_mod(cpu->gt_timer[timeridx], nexttick);
@@ -2874,11 +2876,13 @@ static const ARMCPRegInfo generic_timer_cp_reginfo[] = {
 
 static uint64_t gt_virt_cnt_read(CPUARMState *env, const ARMCPRegInfo *ri)
 {
+    ARMCPU *cpu = env_archcpu(env);
+
     /* Currently we have no support for QEMUTimer in linux-user so we
      * can't call gt_get_countervalue(env), instead we directly
      * call the lower level functions.
      */
-    return cpu_get_clock() / GTIMER_SCALE;
+    return cpu_get_clock() / gt_cntfrq_period_ns(cpu);
 }
 
 static const ARMCPRegInfo generic_timer_cp_reginfo[] = {
-- 
git-series 0.9.1

