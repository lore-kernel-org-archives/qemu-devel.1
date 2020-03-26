Return-Path: <SRS0=Dj2y=5L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EF77C43331
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2020 20:50:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3DADE2070A
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2020 20:50:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kHPAtvm4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3DADE2070A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60208 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jHZS6-0005Mt-B0
	for qemu-devel@archiver.kernel.org; Thu, 26 Mar 2020 16:50:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39722)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jHZRM-0004mb-JZ
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 16:49:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1jHZRL-0005HT-F9
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 16:49:24 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:39185)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1jHZRL-0005G0-8G
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 16:49:23 -0400
Received: by mail-wm1-x341.google.com with SMTP id a9so9210576wmj.4
 for <qemu-devel@nongnu.org>; Thu, 26 Mar 2020 13:49:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=bAQfFYBSPpibKiPXxyi44d7P7+tA6VEgfXGXzLkCrIs=;
 b=kHPAtvm4hEHla5vZLv2326STOa51pQHpfycFSTrcV5j8Qo+vzKEzKEoUUh4OeZlQ2S
 ABGaxlF2xuoJj63YYPy8tNURAZFZQnHeAga6Aey4PfXyOINhKKxgZN8vdKGP2vGKhuMI
 LzxD0VgQw6uA8NLaZuJdeRLc3dAvhAuIt7pMS1+F1osB7G+tR+kpLfEEdVwaIaSXHIGv
 8krbTwKoJOXYHLNeWlejFELHA3h0V/bAWqmXZ03a6CUEBRfmQeASoElpP47KXG1nW6Yf
 nGB3udNhrhiNe/X4b3ywjyQj9OD3HGmXGeEqwiDnVFMq1a39DOIzTc/HrkzwkWn3pGiR
 hYLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=bAQfFYBSPpibKiPXxyi44d7P7+tA6VEgfXGXzLkCrIs=;
 b=kp/eFowMqkRpHmSEGJQFXm/3NIAn6JqC9RLJeiv7Dcyry0/kIx9ny9ZGpL1x4bQzSR
 BRrKZUgaCdQ/wSRiX2El6RQequP0hGUMC6dNUadxIw7h/4+Pm6kbFgdVXyqnoDbPu5ix
 CU5+2Mgqew80XItuqJ3VB02nkXfVzLpZzRmpPlmMA97cjH3OZBje/XGbRvzLBCB5itxn
 M/Yx5L2rVCjH/R4fjgi6XYhmOg/UsFVCoAxAKm/0wR0oKs8jAhY+iPoHleR93P7U+KbV
 yLSl/VUUCIQWXlAQ1e32BsIUrr9FMbKNdEa/h8Pf84rMWqX1MprymEEl5uC5ASJxAXyF
 Tuow==
X-Gm-Message-State: ANhLgQ15rktcXzUsfekO04o1IImiVOjBVyRE0IF3fX6wXgrIQbxKpw4r
 Z4X0EFOlt5+yjGB0W3AGW9tvoQ==
X-Google-Smtp-Source: ADFU+vuFgqhYpxRaB4uvyha/BF+Hx92W1cergey65xjzZ7hNolX5M9F9axyB7AojrLF9SR8y2y+8Gw==
X-Received: by 2002:adf:fc08:: with SMTP id i8mr4027024wrr.109.1585255761608; 
 Thu, 26 Mar 2020 13:49:21 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id 9sm4864561wmm.6.2020.03.26.13.49.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Mar 2020 13:49:21 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH v2] hw/arm/collie: Put StrongARMState* into a
 CollieMachineState struct
Date: Thu, 26 Mar 2020 20:49:19 +0000
Message-Id: <20200326204919.22006-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::341
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

Coverity complains that the collie_init() function leaks the memory
allocated in sa1110_init().  This is true but not significant since
the function is called only once on machine init and the memory must
remain in existence until QEMU exits anyway.

Still, we can avoid the technical memory leak by keeping the pointer
to the StrongARMState inside the machine state struct.  Switch from
the simple DEFINE_MACHINE() style to defining a subclass of
TYPE_MACHINE which extends the MachineState struct, and keep the
pointer there.

Fixes: CID 1421921
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
v1->v2: folded in the uncommitted change that fixes the
arm_load_kernel() first argument.

 hw/arm/collie.c | 33 ++++++++++++++++++++++++++++-----
 1 file changed, 28 insertions(+), 5 deletions(-)

diff --git a/hw/arm/collie.c b/hw/arm/collie.c
index 4992084a3f6..4b35ef4bed6 100644
--- a/hw/arm/collie.c
+++ b/hw/arm/collie.c
@@ -19,6 +19,16 @@
 #include "exec/address-spaces.h"
 #include "cpu.h"
 
+typedef struct {
+    MachineState parent;
+
+    StrongARMState *sa1110;
+} CollieMachineState;
+
+#define TYPE_COLLIE_MACHINE MACHINE_TYPE_NAME("collie")
+#define COLLIE_MACHINE(obj) \
+    OBJECT_CHECK(CollieMachineState, obj, TYPE_COLLIE_MACHINE)
+
 static struct arm_boot_info collie_binfo = {
     .loader_start = SA_SDCS0,
     .ram_size = 0x20000000,
@@ -26,9 +36,9 @@ static struct arm_boot_info collie_binfo = {
 
 static void collie_init(MachineState *machine)
 {
-    StrongARMState *s;
     DriveInfo *dinfo;
     MachineClass *mc = MACHINE_GET_CLASS(machine);
+    CollieMachineState *cms = COLLIE_MACHINE(machine);
 
     if (machine->ram_size != mc->default_ram_size) {
         char *sz = size_to_str(mc->default_ram_size);
@@ -37,7 +47,7 @@ static void collie_init(MachineState *machine)
         exit(EXIT_FAILURE);
     }
 
-    s = sa1110_init(machine->cpu_type);
+    cms->sa1110 = sa1110_init(machine->cpu_type);
 
     memory_region_add_subregion(get_system_memory(), SA_SDCS0, machine->ram);
 
@@ -54,11 +64,13 @@ static void collie_init(MachineState *machine)
     sysbus_create_simple("scoop", 0x40800000, NULL);
 
     collie_binfo.board_id = 0x208;
-    arm_load_kernel(s->cpu, machine, &collie_binfo);
+    arm_load_kernel(cms->sa1110->cpu, machine, &collie_binfo);
 }
 
-static void collie_machine_init(MachineClass *mc)
+static void collie_machine_class_init(ObjectClass *oc, void *data)
 {
+    MachineClass *mc = MACHINE_CLASS(oc);
+
     mc->desc = "Sharp SL-5500 (Collie) PDA (SA-1110)";
     mc->init = collie_init;
     mc->ignore_memory_transaction_failures = true;
@@ -67,4 +79,15 @@ static void collie_machine_init(MachineClass *mc)
     mc->default_ram_id = "strongarm.sdram";
 }
 
-DEFINE_MACHINE("collie", collie_machine_init)
+static const TypeInfo collie_machine_typeinfo = {
+    .name = TYPE_COLLIE_MACHINE,
+    .parent = TYPE_MACHINE,
+    .class_init = collie_machine_class_init,
+    .instance_size = sizeof(CollieMachineState),
+};
+
+static void collie_machine_register_types(void)
+{
+    type_register_static(&collie_machine_typeinfo);
+}
+type_init(collie_machine_register_types);
-- 
2.20.1


