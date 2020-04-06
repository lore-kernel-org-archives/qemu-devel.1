Return-Path: <SRS0=By5p=5W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2933EC2BA19
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Apr 2020 10:13:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E729C20678
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Apr 2020 10:13:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bw8u93gq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E729C20678
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58004 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jLOl9-00082Z-3q
	for qemu-devel@archiver.kernel.org; Mon, 06 Apr 2020 06:13:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50065)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jLOjk-0006g4-Jf
 for qemu-devel@nongnu.org; Mon, 06 Apr 2020 06:12:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1jLOjj-0002hN-CW
 for qemu-devel@nongnu.org; Mon, 06 Apr 2020 06:12:12 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:50423)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1jLOjj-0002g6-6J
 for qemu-devel@nongnu.org; Mon, 06 Apr 2020 06:12:11 -0400
Received: by mail-wm1-x343.google.com with SMTP id x25so2982198wmc.0
 for <qemu-devel@nongnu.org>; Mon, 06 Apr 2020 03:12:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=PK57Fc2V7JwfxoVRwYEuCtw0T1ACQONhmzqVf5av14o=;
 b=bw8u93gqMEmsEMXERPMeveWm1C06rE1kir4ArkHbjlKr+CEbLY5LnrMgoUYg3YBuuD
 DBAJKdaa7lYROzSoIl48WmY8LsnODvW9oE7W7I6p5PbK/DhGngGlqxhe/83dMwEiiuZb
 mR2xF5WOILfuCzDolwkyBOziboonJK9zWFr3FkwBV1tb7A8h5GQfCdUZOiGmNB8eJRA2
 4BE1ZrG8gwNzvrqVf3fEhLrpVmS7DTpbchujMdQqijh6DZOfDXewQXo5szjhkEPXAiV3
 wByoHpABLkFr2Y7uLDBSqazGMuv1JFGz9h2pAIXaG3mMOYBRRzebgOcxyvfnEb7pEw9T
 PjmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=PK57Fc2V7JwfxoVRwYEuCtw0T1ACQONhmzqVf5av14o=;
 b=HyrCyvIzpp/EbGNdco/Df3/4MoBblzRW8niui4TwZIU+/67eibDFFLKMdQVKja1pRJ
 BZ/PN5cdTinLM/jj2xbBkStpk0NtHzVt5oK9Fny8/xBTZvFDTVFOSVaeWV/+tqHQRSF5
 7RngyWzUzZ+DGUrtIMVq3UDsfhYA6lKQv/0Suy0687QqeZOijC3opxsf1xCbwfBaRioJ
 SqiPBvwUIUM+rDFCGsacVXopKbmPwQcpx5zbcxxim0qK+iy32uFnKiGhmJtSZy9luIYt
 6g57BNHJ/nn+nfKbdbks78jb/H1C8FDNIg/L+iTKxewSbSUoJtVurhsOaVaiYKuvRdef
 aQxw==
X-Gm-Message-State: AGi0PubHLJh6qOwtaoFriLTfZNFCFbwRFl/BQIGU/QZ+8ppKSuUMslrV
 4rpqtbkVNqleN5997o1pQMOiLW2IUR+GDw==
X-Google-Smtp-Source: APiQypIoECAN+jFdnVcEaoBKwcgQ4d3SJPeX188M1PM9G0Lql4BmUk4hd1LYv5A5KjaVpW0OR6qzuQ==
X-Received: by 2002:a1c:9aca:: with SMTP id c193mr21176800wme.38.1586167929814; 
 Mon, 06 Apr 2020 03:12:09 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id f187sm25163765wme.9.2020.04.06.03.12.08
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Apr 2020 03:12:09 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 02/11] hw/arm/collie: Put StrongARMState* into a
 CollieMachineState struct
Date: Mon,  6 Apr 2020 11:11:56 +0100
Message-Id: <20200406101205.23027-3-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200406101205.23027-1-peter.maydell@linaro.org>
References: <20200406101205.23027-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::343
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
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-id: 20200326204919.22006-1-peter.maydell@linaro.org
---
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


