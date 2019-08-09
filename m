Return-Path: <SRS0=8dir=WF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FE51C433FF
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Aug 2019 05:44:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3A8982089E
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Aug 2019 05:44:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=aj.id.au header.i=@aj.id.au header.b="FKoWeXEH";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="BWnOg5N2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A8982089E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=aj.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56500 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hvxhU-0003zl-Dy
	for qemu-devel@archiver.kernel.org; Fri, 09 Aug 2019 01:44:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36617)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <andrew@aj.id.au>) id 1hvxgw-0002pV-JG
 for qemu-devel@nongnu.org; Fri, 09 Aug 2019 01:43:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <andrew@aj.id.au>) id 1hvxgv-0001R8-Ef
 for qemu-devel@nongnu.org; Fri, 09 Aug 2019 01:43:54 -0400
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:55929)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <andrew@aj.id.au>)
 id 1hvxgs-0001JJ-17; Fri, 09 Aug 2019 01:43:50 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
 by mailout.nyi.internal (Postfix) with ESMTP id 904CF21540;
 Fri,  9 Aug 2019 01:43:49 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
 by compute4.internal (MEProxy); Fri, 09 Aug 2019 01:43:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aj.id.au; h=from
 :to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding; s=fm3; bh=caEbH9eB9pyP5p77goifr2wWJQ
 78fwxTcp7BPCt1nYQ=; b=FKoWeXEHKszI4Z4WygqHaM9FJ+bisXWZALJlsgo/rZ
 JE9vMwUHwpVaPRr464O8B9abcNeHsLBf6Dq/vbripcHPqlsbtEDayiNh7vabUrlU
 ATPEqhhAIk6RXrUi4o9PbSqwheYTu9k+YV9nETpCjHi1rVxQTYDoEg2pw2rda1qB
 QCExprtiFH4hd9QySVc7JCvH6goe1LlJKA7M2vM/G9OqB+wT6ajhUc0E4l3CciO1
 bCA3pPMnFcXVCUtkxSCxd9fFRNGCGogEIAOIe+rR+2ReZNBXL63Bf9FxavmiF4ms
 7yNbFQxQm0gv2HKObkLqBuW9nyetNtd5xRgBt6kL6lfQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:date:from
 :message-id:mime-version:subject:to:x-me-proxy:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=caEbH9eB9pyP5p77g
 oifr2wWJQ78fwxTcp7BPCt1nYQ=; b=BWnOg5N2GOUhEIWoct85GGW63nxOGNIts
 WU6Yp/QIDBvFD7aXaqOlkBOgD0RZIAyZ9BQO5sddawRJviJeCx4ZK4rLhaRKj3wh
 3svFaC1WFFnyULPiVnzjiyh/PUqusw+RnXVUCr2K9TNY8cX/7yIlxljIEumqvNKS
 lz6VhwyksRaxOhRMr6f1l49FtJWpd32DQ/j9xNfTIskJ/IhIC9NsEmkJQWvf934y
 PGo+mOSc5ZQQD42eONIniNaTKCRUi0UTEpflzdQuRlTucPS7oCy/OQUZ5aXeliz9
 s2M1v/w2JW9hChnbrSEjTQ+EzO/aGhpjAuUSD8YMzJVtdBJh5I/ww==
X-ME-Sender: <xms:EwhNXdWOROtGffvce2uRQTGiNaj8lqA1LAx-H1KSBTwczsOHFH3vkg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduvddrudduiedgleejucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgggfestdekredtre
 dttdenucfhrhhomheptehnughrvgifucflvghffhgvrhihuceorghnughrvgifsegrjhdr
 ihgurdgruheqnecukfhppeduudekrddvuddtrddugeefrdduvdehnecurfgrrhgrmhepmh
 grihhlfhhrohhmpegrnhgurhgvfiesrghjrdhiugdrrghunecuvehluhhsthgvrhfuihii
 vgeptd
X-ME-Proxy: <xmx:EwhNXZBAKSYxKBU3KEvKPEy4GVs0CzRKpgQ5NNphc0Ue0hJDQrzSmg>
 <xmx:EwhNXYEDQwTfLly1ZampSxYESBleWWCN3aJ-O8wCF4OSSUo0eoFndQ>
 <xmx:EwhNXdeSPHcdnF5GtrtgSmBCc1vWkXO4jJIIvZJlLo81IsgEvjp2EQ>
 <xmx:FQhNXT93x0mc4g8zNHCV2Agqw54adsiGmf1ms7yc-7xVlD_XK0ZyCQ>
Received: from localhost.localdomain
 (ppp118-210-143-125.adl-adc-lon-bras33.tpg.internode.on.net
 [118.210.143.125])
 by mail.messagingengine.com (Postfix) with ESMTPA id 6A9F0380075;
 Fri,  9 Aug 2019 01:43:45 -0400 (EDT)
From: Andrew Jeffery <andrew@aj.id.au>
To: qemu-arm@nongnu.org
Date: Fri,  9 Aug 2019 15:13:41 +0930
Message-Id: <20190809054341.24728-1-andrew@aj.id.au>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 66.111.4.26
Subject: [Qemu-devel] [PATCH v2] target-arm: Make the counter tick relative
 to cntfrq
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
Cc: Andrew Jeffery <andrew@aj.id.au>, peter.maydell@linaro.org, clg@kaod.org,
 qemu-devel@nongnu.org, joel@jms.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The use of GTIMER_SCALE assumes the clock feeding the generic timer is
62.5MHz for all platforms. This is untrue in general, for example the
ASPEED AST2600 feeds the counter with either an 800 or 1200MHz clock,
and CNTFRQ is configured appropriately by u-boot.

To cope with these values we need to take care of the quantization
caused by the clock scaling in terms of nanoseconds per clock by
calculating an effective frequency such that NANOSECONDS_PER_SECOND is
an integer multiple of the effective frequency. Failing to account for
the quantisation leads to sticky behaviour in the VM as the guest timer
subsystems account for the difference between delay time and the counter
value.

Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
---
v2:
1. Removed the user-mode change that broke v1
2. Rearranged the implementation as a consequence of 1.

 target/arm/helper.c | 51 ++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 48 insertions(+), 3 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index b74c23a9bc08..166a54daf278 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -2277,6 +2277,34 @@ static const ARMCPRegInfo v6k_cp_reginfo[] = {
 
 #ifndef CONFIG_USER_ONLY
 
+static void gt_recalc_timer(ARMCPU *cpu, int timeridx);
+static void gt_cntfrq_write(CPUARMState *env, const ARMCPRegInfo *ri,
+                            uint64_t value)
+{
+    uint64_t scale;
+    ARMCPU *cpu;
+    int i;
+
+    raw_write(env, ri, value);
+
+    /* Fix up the timer scaling */
+    cpu = env_archcpu(env);
+    scale = MAX(1, NANOSECONDS_PER_SECOND / value);
+    for (i = 0; i < NUM_GTIMERS; i++) {
+        if (!cpu->gt_timer[i]) {
+            continue;
+        }
+
+        cpu->gt_timer[i]->scale = scale;
+        gt_recalc_timer(cpu, i);
+    }
+}
+
+static void gt_cntfrq_reset(CPUARMState *env, const ARMCPRegInfo *opaque)
+{
+    gt_cntfrq_write(env, opaque, opaque->resetvalue);
+}
+
 static CPAccessResult gt_cntfrq_access(CPUARMState *env, const ARMCPRegInfo *ri,
                                        bool isread)
 {
@@ -2407,7 +2435,21 @@ static CPAccessResult gt_stimer_access(CPUARMState *env,
 
 static uint64_t gt_get_countervalue(CPUARMState *env)
 {
-    return qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) / GTIMER_SCALE;
+    uint64_t effective;
+
+    /*
+     * Deal with quantized clock scaling by calculating the effective frequency
+     * in terms of the timer scale.
+     */
+    if (env->cp15.c14_cntfrq <= NANOSECONDS_PER_SECOND) {
+        uint32_t scale = NANOSECONDS_PER_SECOND / env->cp15.c14_cntfrq;
+        effective = NANOSECONDS_PER_SECOND / scale;
+    } else {
+        effective = NANOSECONDS_PER_SECOND;
+    }
+
+    return muldiv64(qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL), effective,
+                    NANOSECONDS_PER_SECOND);
 }
 
 static void gt_recalc_timer(ARMCPU *cpu, int timeridx)
@@ -2443,8 +2485,8 @@ static void gt_recalc_timer(ARMCPU *cpu, int timeridx)
          * set the timer for as far in the future as possible. When the
          * timer expires we will reset the timer for any remaining period.
          */
-        if (nexttick > INT64_MAX / GTIMER_SCALE) {
-            nexttick = INT64_MAX / GTIMER_SCALE;
+        if (nexttick > INT64_MAX / cpu->gt_timer[timeridx]->scale) {
+            nexttick = INT64_MAX / cpu->gt_timer[timeridx]->scale;
         }
         timer_mod(cpu->gt_timer[timeridx], nexttick);
         trace_arm_gt_recalc(timeridx, irqstate, nexttick);
@@ -2686,13 +2728,16 @@ static const ARMCPRegInfo generic_timer_cp_reginfo[] = {
     { .name = "CNTFRQ", .cp = 15, .crn = 14, .crm = 0, .opc1 = 0, .opc2 = 0,
       .type = ARM_CP_ALIAS,
       .access = PL1_RW | PL0_R, .accessfn = gt_cntfrq_access,
+      .writefn = gt_cntfrq_write,
       .fieldoffset = offsetoflow32(CPUARMState, cp15.c14_cntfrq),
     },
     { .name = "CNTFRQ_EL0", .state = ARM_CP_STATE_AA64,
       .opc0 = 3, .opc1 = 3, .crn = 14, .crm = 0, .opc2 = 0,
       .access = PL1_RW | PL0_R, .accessfn = gt_cntfrq_access,
+      .writefn = gt_cntfrq_write,
       .fieldoffset = offsetof(CPUARMState, cp15.c14_cntfrq),
       .resetvalue = (1000 * 1000 * 1000) / GTIMER_SCALE,
+      .resetfn = gt_cntfrq_reset,
     },
     /* overall control: mostly access permissions */
     { .name = "CNTKCTL", .state = ARM_CP_STATE_BOTH,
-- 
2.20.1


