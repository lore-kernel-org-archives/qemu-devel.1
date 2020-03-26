Return-Path: <SRS0=Dj2y=5L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58328C43331
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2020 20:35:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1200A2070A
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2020 20:35:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gUnYZfPU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1200A2070A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60056 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jHZDT-0000MH-51
	for qemu-devel@archiver.kernel.org; Thu, 26 Mar 2020 16:35:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37490)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jHZCm-0008GD-Bs
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 16:34:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1jHZCl-0001fk-2z
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 16:34:20 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:50408)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1jHZCk-0001eT-So
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 16:34:19 -0400
Received: by mail-wm1-x342.google.com with SMTP id d198so8469498wmd.0
 for <qemu-devel@nongnu.org>; Thu, 26 Mar 2020 13:34:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=eigIr7yZ70T25XWD0fJuHajFYnnBMnfjgNM68LuO0TM=;
 b=gUnYZfPUrWCJMMFzK/gN0Vf0dCjh3g0omt8SJVYPENCbD7hfBT4MfXAMc5+UpshO1Y
 K1IAGOgsZI8PTvUxgZ2DHB+piaw2erVmie2Su4XKg/oy7pbTwh/rJ5ozBMY/2TrXvpQH
 3O/ihWMrlzVMh4t0ZuMX/9UjmUDZGDlxkYJdmcCSF2YAQ/p5DIesbP3TgNIv4pft7BMU
 bynprzklxZJiJ1paRZG+ybELX//0XCZsftJ3dUbsrU/726tJU4zvZ4EwHwXigC8hBkQW
 2hXoxQe+Avd9fZxuwOoq3+Jgcm3vPKLXIFIKGiVnqLtlBAUTYbZouo4V/lfiU84yZcid
 3Hbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=eigIr7yZ70T25XWD0fJuHajFYnnBMnfjgNM68LuO0TM=;
 b=bxxCxuykeGxwKDRBAjok//rLWtfC2WOmr2AiEAreCTMqeXmSVtvb0nL6mFwiQiCl5J
 L1nQQW3l2aIhgygiGySkrGXMpP2o3XUmExVIwZoNo3gw+ASC0me6PIVhWCM9q5szUrL8
 IR/n/C8ntL0OXB06x8PRmBjN5Moi26cxNfCzHLC7B7Co1/8Ic1T+LvDncL6M6SVPYhEz
 bsS5VVOkUpS1GB5HESFA+93mVxM2vmV3MUIhsqV/E9YEHPPkqLH8ThFy2yJanCj4VrwP
 5kzAHDj2ZjrBiTJjm/mW86OtcwjdkZ4Ua/VIES6q5rMXT0/3j98fj6q2g3EKJmjVWMnT
 gUEg==
X-Gm-Message-State: ANhLgQ3fG7GbA8jkv4CL27jpL+f6t4liwmjNAlTrbvzlsRSIdQJ7DpvE
 m1mhD8vIrssbg1FMagcJGRiZC3/LWQ/lXA==
X-Google-Smtp-Source: ADFU+vs95qzvnHqwFhjQkVQOpHrXyZhUZ41UowxY90cqCn7xBg2kQ98oD8y2tg+sTQuZGFhASOd0eQ==
X-Received: by 2002:a7b:ca4e:: with SMTP id m14mr1715107wml.164.1585254857104; 
 Thu, 26 Mar 2020 13:34:17 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id s11sm5299123wrw.58.2020.03.26.13.34.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Mar 2020 13:34:16 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH] hw/arm/collie: Put StrongARMState* into a CollieMachineState
 struct
Date: Thu, 26 Mar 2020 20:34:14 +0000
Message-Id: <20200326203414.18140-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::342
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
 hw/arm/collie.c | 31 +++++++++++++++++++++++++++----
 1 file changed, 27 insertions(+), 4 deletions(-)

diff --git a/hw/arm/collie.c b/hw/arm/collie.c
index 4992084a3f6..8ca0df96b47 100644
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
 
@@ -57,8 +67,10 @@ static void collie_init(MachineState *machine)
     arm_load_kernel(s->cpu, machine, &collie_binfo);
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


