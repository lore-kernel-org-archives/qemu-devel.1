Return-Path: <SRS0=bTwh=ZU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B599C432C3
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Nov 2019 05:47:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2B566215E5
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Nov 2019 05:47:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=aj.id.au header.i=@aj.id.au header.b="rqc/+eU8";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="yJSRw9WM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B566215E5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=aj.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45472 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iaCeB-0008Tn-4z
	for qemu-devel@archiver.kernel.org; Thu, 28 Nov 2019 00:47:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48239)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <andrew@aj.id.au>) id 1iaCb8-0006kI-Cw
 for qemu-devel@nongnu.org; Thu, 28 Nov 2019 00:44:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <andrew@aj.id.au>) id 1iaCb7-0001q9-4a
 for qemu-devel@nongnu.org; Thu, 28 Nov 2019 00:44:14 -0500
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:45793)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <andrew@aj.id.au>)
 id 1iaCb4-0001kI-I0; Thu, 28 Nov 2019 00:44:10 -0500
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
 by mailout.nyi.internal (Postfix) with ESMTP id 4EC2B22767;
 Thu, 28 Nov 2019 00:44:10 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
 by compute4.internal (MEProxy); Thu, 28 Nov 2019 00:44:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aj.id.au; h=from
 :to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding; s=fm1; bh=+oHpNhAQBewWJ
 O+2Nx1MPukGNENONDxvGYUWVPaZGgA=; b=rqc/+eU8hQQH2N+QJEnsiwYL0H7rB
 9tgEYjpmTQM8fmCRIGBUCXebySF1iacAROZZcm0hiqFQS8c68uyg5g99nXI7d5tB
 7atw1Sdbh4zukUxQ4pfd0cJZblvxxXBm614r0QD3fGHnRxeoPbMJMf+GbUCmPh5g
 fTyT1StwYEsSVl9GpD2d5CKxRlKLWKinkenMjMWFOZ7eGaoZIUrD88DKq3/bo4N7
 l+ubK1HGv3NS48W8mTb0NfOfUmSDwYP22mOev/bTnzjJ8UVez4EcZ6CVkrVOquai
 pfpFx9OwTpAKcUmHV6xQYwdI/KC/y7TxeQxADeOU6FLJQNvu5AiNxG3Kg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:date:from
 :in-reply-to:message-id:mime-version:references:subject:to
 :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
 fm1; bh=+oHpNhAQBewWJO+2Nx1MPukGNENONDxvGYUWVPaZGgA=; b=yJSRw9WM
 uVWu7dgnjvq5uA3TKm1Ln2peWm3LbY9D5KNHXHT001d4U/5HaNKa3bzXsgzHfYIl
 B1kfMx69kSUu+pqw8EWVX5GqxVB05JUs7AxqzKCJsQWvU1jtM8kuSFQco1RmhmPx
 TukQ7oC/pKzX22X8qQ7wDS+4Sfz0VIIAYjrWLfBkGxALupgfY7t3TNW6bPabpn62
 UT9kMjhLl4+AGb2vo9xIdGaYanL9aM66v0mKEHbT+1jQiH2Erb3T2tvzsZNGPB8a
 FpTdJ+Jt0opEfF2exqhXq6lSoPbTzXDgXziZdIQCJ3GliB3aWZDAT8PgTWrCWZW6
 lj2XYdhSrPuf0Q==
X-ME-Sender: <xms:ql7fXcUmNr49bk04b6FjqTH283sEHyW2Y3-pySolapQrJPpALV_UeQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedufedrudeiiedgkeekucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgjfhgggfestdekre
 dtredttdenucfhrhhomheptehnughrvgifucflvghffhgvrhihuceorghnughrvgifsegr
 jhdrihgurdgruheqnecukfhppedvtddvrdekuddrudekrdeftdenucfrrghrrghmpehmrg
 hilhhfrhhomheprghnughrvgifsegrjhdrihgurdgruhenucevlhhushhtvghrufhiiigv
 pedu
X-ME-Proxy: <xmx:ql7fXckJcmQR3BIlqSAUncE0vqTSUP2IwY1rnEi_9ZYFNqSX2KgCVA>
 <xmx:ql7fXTCEWK0w4zDBNmGZHl_GQ4SUrnME93wW9bmZoPRoxsZT1StiDA>
 <xmx:ql7fXZgw9QL644uCCWF7dACeMZ1KHNxwHkPw-l_1x4kI4KFTTi3JXQ>
 <xmx:ql7fXTpH23K8Yycv6nnJi_IQ9p886k8UCTxIyhQwLUpDOyr-VTYTFQ>
Received: from mistburn.au.ibm.com (bh02i525f01.au.ibm.com [202.81.18.30])
 by mail.messagingengine.com (Postfix) with ESMTPA id E7ECD8005A;
 Thu, 28 Nov 2019 00:44:07 -0500 (EST)
From: Andrew Jeffery <andrew@aj.id.au>
To: qemu-arm@nongnu.org
Subject: [PATCH 2/4] target/arm: Abstract the generic timer frequency
Date: Thu, 28 Nov 2019 16:15:25 +1030
Message-Id: <20191128054527.25450-3-andrew@aj.id.au>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191128054527.25450-1-andrew@aj.id.au>
References: <20191128054527.25450-1-andrew@aj.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 66.111.4.26
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
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org, clg@kaod.org,
 joel@jms.id.au
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
period from gt_cntfrq stored in struct ARMCPU. Initially set gt_cntfrq
to the frequency associated with GTIMER_SCALE so current behaviour is
maintained.

Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
---
 target/arm/cpu.c    |  2 ++
 target/arm/cpu.h    | 10 ++++++++++
 target/arm/helper.c | 10 +++++++---
 3 files changed, 19 insertions(+), 3 deletions(-)

diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 7a4ac9339bf9..5698a74061bb 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -974,6 +974,8 @@ static void arm_cpu_initfn(Object *obj)
     if (tcg_enabled()) {
         cpu->psci_version = 2; /* TCG implements PSCI 0.2 */
     }
+
+    cpu->gt_cntfrq = NANOSECONDS_PER_SECOND / GTIMER_SCALE;
 }
 
 static Property arm_cpu_reset_cbar_property =
diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 83a809d4bac4..666c03871fdf 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -932,8 +932,18 @@ struct ARMCPU {
      */
     DECLARE_BITMAP(sve_vq_map, ARM_MAX_VQ);
     DECLARE_BITMAP(sve_vq_init, ARM_MAX_VQ);
+
+    /* Generic timer counter frequency, in Hz */
+    uint64_t gt_cntfrq;
 };
 
+static inline unsigned int gt_cntfrq_period_ns(ARMCPU *cpu)
+{
+    /* XXX: Could include qemu/timer.h to get NANOSECONDS_PER_SECOND? */
+    const unsigned int ns_per_s = 1000 * 1000 * 1000;
+    return ns_per_s > cpu->gt_cntfrq ? ns_per_s / cpu->gt_cntfrq : 1;
+}
+
 void arm_cpu_post_init(Object *obj);
 
 uint64_t arm_cpu_mp_affinity(int idx, uint8_t clustersz);
diff --git a/target/arm/helper.c b/target/arm/helper.c
index 65c4441a3896..1cc0551081a0 100644
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
+    return cpu_get_clock() / gt_cntfrq_period(cpu);
 }
 
 static const ARMCPRegInfo generic_timer_cp_reginfo[] = {
-- 
2.20.1


