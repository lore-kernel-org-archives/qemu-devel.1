Return-Path: <SRS0=KBml=XB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2569DC43331
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Sep 2019 06:15:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 03BC3206BB
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Sep 2019 06:15:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=alistair23.me header.i=@alistair23.me header.b="KTgk318H";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="xs0HuczK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 03BC3206BB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=alistair23.me
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52408 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i67Wq-0006MN-Gg
	for qemu-devel@archiver.kernel.org; Fri, 06 Sep 2019 02:15:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39943)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alistair@alistair23.me>) id 1i67Sc-0002VW-9w
 for qemu-devel@nongnu.org; Fri, 06 Sep 2019 02:11:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alistair@alistair23.me>) id 1i67Sb-0003lt-5c
 for qemu-devel@nongnu.org; Fri, 06 Sep 2019 02:11:06 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:33703)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <alistair@alistair23.me>)
 id 1i67Sb-0003ll-24
 for qemu-devel@nongnu.org; Fri, 06 Sep 2019 02:11:05 -0400
Received: from compute7.internal (compute7.nyi.internal [10.202.2.47])
 by mailout.nyi.internal (Postfix) with ESMTP id D637021F83;
 Fri,  6 Sep 2019 02:11:04 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
 by compute7.internal (MEProxy); Fri, 06 Sep 2019 02:11:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding; s=fm2; bh=jWgP1ADGwTyur
 qv6cMs6wlleYyD1So+YWUkeKZjC4dk=; b=KTgk318HnOFwWxW9zLfEHoizqPIIQ
 Z8j4ZBS4UW+am7PefX/sxtT+BufGzRAC4MqwKzLwFn4abMJRklI/KnzTcy3fkh0p
 ScyZzDdXgdpqYnO+CPVb1/slVaV21LwLp39fgndBU7GmTYWuoL6JOG57L2CW4sfN
 GXoazKqq1hV4is9GBIbr6ftXkiuqGsf7Y2MV9kVlpUhrOA79SoAjXDKdWEiTrPh0
 txISx8SufE1OK/1ltXxxAFfyzXEv03lKMwDuVPWvq04Yl/tCF3SudM1u1E29cxRI
 2+hMMrMeVXLg647WUV95Rg2tAW1d+JG/OxJi9pVzswqYe/LZRh6YCcO1g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:date:from
 :in-reply-to:message-id:mime-version:references:subject:to
 :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
 fm3; bh=jWgP1ADGwTyurqv6cMs6wlleYyD1So+YWUkeKZjC4dk=; b=xs0HuczK
 SGx+RFxOT+r4UQMivii7PDbY0w9PmY3umMsvG0ZTxqg1AXwf6a57p4fbIrl8lejB
 lgm/DcB22hcqRPmATvITStd5idHTDJxertXQxmwcEG3CuXLISqYixukeBGaWdvwR
 DFigbkHyHgkHIg2G09YN9Xa4whfrEp0+leIkOBbrToz2TjQJhkV0FrO5gXMo54rt
 Te6j6Z6OQhCU7P+DMyOY4Xm9N/YQCOd4qNJgzrSTGENWRMbI9Uw824Wu4OpY1ZBt
 AxJKHtQ5R1+VN9O0x5JE3x9SNmQo2iGF5aUSVJj0OEksiLVGZb/MtoJ2xK6zlPP9
 QHdB7gPKvfcz4g==
X-ME-Sender: <xms:ePhxXQmhoCNjAofFULuuVus0jXreU_1Z2DiIpPw46vptU7pnayP60w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduvddrudejkedgheelucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgjfhgggfestdekre
 dtredttdenucfhrhhomheptehlihhsthgrihhrucfhrhgrnhgtihhsuceorghlihhsthgr
 ihhrsegrlhhishhtrghirhdvfedrmhgvqeenucfkphepjeefrdelfedrkeegrddvtdekne
 curfgrrhgrmhepmhgrihhlfhhrohhmpegrlhhishhtrghirhesrghlihhsthgrihhrvdef
 rdhmvgenucevlhhushhtvghrufhiiigvpedt
X-ME-Proxy: <xmx:ePhxXWMlyRB8pUI_hFCOfUR_Pp2aYrzxrOeoFV1V0qfjzgDbzx5t5Q>
 <xmx:ePhxXa7-b6ugHIOa7krf7fM0kJNSxwUW7oPu9hj9VSYvXaarJbZZCg>
 <xmx:ePhxXaZjVa81KA1azVesxWS20Wy6NVFr7TaBJrg0PyoPi4U7VB_Tkg>
 <xmx:ePhxXXlHzU873a7klfeCH7-hwmDeqhCZYHl8Ap_0TVPlYNhDT8F-uQ>
Received: from alistair-xps-14z.alistair23.me
 (c-73-93-84-208.hsd1.ca.comcast.net [73.93.84.208])
 by mail.messagingengine.com (Postfix) with ESMTPA id 442E0D60062;
 Fri,  6 Sep 2019 02:11:04 -0400 (EDT)
From: Alistair Francis <alistair@alistair23.me>
To: qemu-devel@nongnu.org,
	peter.maydell@linaro.org
Date: Thu,  5 Sep 2019 23:11:03 -0700
Message-Id: <7e78d043a9ce878166c0dd750844722aa9b54d84.1567750222.git.alistair@alistair23.me>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <cover.1567750222.git.alistair@alistair23.me>
References: <cover.1567750222.git.alistair@alistair23.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 66.111.4.25
Subject: [Qemu-devel] [PATCH v4 2/6] target/arm: Allow setting M mode entry
 and sp
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
Cc: alistair23@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Add M mode initial entry PC and SP properties.

Signed-off-by: Alistair Francis <alistair@alistair23.me>
---
 target/arm/cpu.c | 52 +++++++++++++++++++++++++++++++++++++++++++-----
 target/arm/cpu.h |  3 +++
 2 files changed, 50 insertions(+), 5 deletions(-)

diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 2399c14471..315aa503f6 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -311,6 +311,9 @@ static void arm_cpu_reset(CPUState *s)
              */
             initial_msp = ldl_p(rom);
             initial_pc = ldl_p(rom + 4);
+        } else if (cpu->init_sp || cpu->init_entry) {
+            initial_msp = cpu->init_sp;
+            initial_pc = cpu->init_entry;
         } else {
             /* Address zero not covered by a ROM blob, or the ROM blob
              * is in non-modifiable memory and this is a second reset after
@@ -1055,6 +1058,38 @@ static void arm_set_init_svtor(Object *obj, Visitor *v, const char *name,
     visit_type_uint32(v, name, &cpu->init_svtor, errp);
 }
 
+static void arm_get_init_sp(Object *obj, Visitor *v, const char *name,
+                            void *opaque, Error **errp)
+{
+    ARMCPU *cpu = ARM_CPU(obj);
+
+    visit_type_uint32(v, name, &cpu->init_sp, errp);
+}
+
+static void arm_set_init_sp(Object *obj, Visitor *v, const char *name,
+                            void *opaque, Error **errp)
+{
+    ARMCPU *cpu = ARM_CPU(obj);
+
+    visit_type_uint32(v, name, &cpu->init_sp, errp);
+}
+
+static void arm_get_init_entry(Object *obj, Visitor *v, const char *name,
+                            void *opaque, Error **errp)
+{
+    ARMCPU *cpu = ARM_CPU(obj);
+
+    visit_type_uint32(v, name, &cpu->init_entry, errp);
+}
+
+static void arm_set_init_entry(Object *obj, Visitor *v, const char *name,
+                            void *opaque, Error **errp)
+{
+    ARMCPU *cpu = ARM_CPU(obj);
+
+    visit_type_uint32(v, name, &cpu->init_entry, errp);
+}
+
 void arm_cpu_post_init(Object *obj)
 {
     ARMCPU *cpu = ARM_CPU(obj);
@@ -1155,19 +1190,26 @@ void arm_cpu_post_init(Object *obj)
         }
     }
 
+    /*
+     * M profile: initial value of the SP, entry and Secure VTOR.
+     * We can't just use a simple DEFINE_PROP_UINT32 for this because we want
+     * to permit the property to be set after realize.
+     */
     if (arm_feature(&cpu->env, ARM_FEATURE_M_SECURITY)) {
         object_property_add_link(obj, "idau", TYPE_IDAU_INTERFACE, &cpu->idau,
                                  qdev_prop_allow_set_link_before_realize,
                                  OBJ_PROP_LINK_STRONG,
                                  &error_abort);
-        /*
-         * M profile: initial value of the Secure VTOR. We can't just use
-         * a simple DEFINE_PROP_UINT32 for this because we want to permit
-         * the property to be set after realize.
-         */
         object_property_add(obj, "init-svtor", "uint32",
                             arm_get_init_svtor, arm_set_init_svtor,
                             NULL, NULL, &error_abort);
+    } else if (arm_feature(&cpu->env, ARM_FEATURE_M)) {
+        object_property_add(obj, "init-sp", "uint32",
+                            arm_get_init_sp, arm_set_init_sp,
+                            NULL, NULL, &error_abort);
+        object_property_add(obj, "init-entry", "uint32",
+                            arm_get_init_entry, arm_set_init_entry,
+                            NULL, NULL, &error_abort);
     }
 
     qdev_property_add_static(DEVICE(obj), &arm_cpu_cfgend_property,
diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 297ad5e47a..4856d4c36b 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -805,6 +805,9 @@ struct ARMCPU {
      */
     uint32_t psci_conduit;
 
+    /* For M, initial value of the entry and SP */
+    uint32_t init_sp, init_entry;
+
     /* For v8M, initial value of the Secure VTOR */
     uint32_t init_svtor;
 
-- 
2.22.0


