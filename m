Return-Path: <SRS0=H2wg=6F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47270C54FC9
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2020 19:24:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 151B6206B8
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2020 19:24:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hS7UHBVl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 151B6206B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35048 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jQyV3-00082K-2u
	for qemu-devel@archiver.kernel.org; Tue, 21 Apr 2020 15:24:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52116)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <palmerdabbelt@google.com>) id 1jQyQh-0007rS-20
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 15:19:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <palmerdabbelt@google.com>) id 1jQyQf-0007kb-A0
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 15:19:33 -0400
Received: from mail-pj1-x102c.google.com ([2607:f8b0:4864:20::102c]:33460)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <palmerdabbelt@google.com>)
 id 1jQyQe-0007k9-Rl
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 15:19:32 -0400
Received: by mail-pj1-x102c.google.com with SMTP id 7so1504222pjo.0
 for <qemu-devel@nongnu.org>; Tue, 21 Apr 2020 12:19:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding:cc:from:to;
 bh=GWbJbZaJ6u3f69H5B2fCYzb09uZ3Zh4y+AP4E7eeq8A=;
 b=hS7UHBVlP8RZI22J5SXLuHyTa0HORbMZP+ttCabO2TjSgBJSs8pvn+SlGMx9pyeA9K
 f64t7Q7iEOmSfVxXoPPt9iQbGYFRy4QLcuaxPrzVqivMP5xq6uGX31u8rhc85hciJJd7
 od4JTP6c55fNH4Pgy3VTn/+cQX2DzrG/yuPLwrZxfEbvtCO/YB0UgiC0IerIhomL/AyV
 JKOUFVGh6VRYg0WUWhnfZDGf2AC+g3+hiQKJtF+pX9eWE2WUr4uzfBngEbrBZ2GiBGt0
 XW1lOSnW4f74ScxZcDc9Au22pjtRVi2zsQUv1t/7x3Bx0a8vjD8rdy7WKmuR68CrC6zb
 SMtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding:cc:from:to;
 bh=GWbJbZaJ6u3f69H5B2fCYzb09uZ3Zh4y+AP4E7eeq8A=;
 b=dUPA/PWPLS9tuWQb9TaMX3Ua65DRUAqnG1AwfluO9o+ffT27hhwCb7C3D3j1gNSQMW
 YPQXeTY7AnQC6xa+1eUxMzMx101D+C3um/xPRmDJlB3ubiuqVxYOr5F3DIpOVaRq+N1e
 K1ga/cehoxlzHFs1kag0k6tysU+TfAiS5vQ3swtirbwM9gToN3rM2iOvU4nY3PS4wP4D
 /zYmVUAeQ51j4N1UgTwsEX6zQKh6VdoYXkMMf45m2ww8KqV1XC+XAD7Wc1DK0CYKI+96
 jeZkRFsWnvnVgNTs0lNkG54eQ4IQgJXOYgbG7Ev5YqZShib0OZ9nfnjfBFzCZHecHBS5
 xH0g==
X-Gm-Message-State: AGi0PuZ9vp+lj6gQPWqrH8Fn2t6h/BxFqwXy0AxfXvhGaAhn+8uE5iep
 jpc5qaFIGFhJtE9WI6HDleyh7Q==
X-Google-Smtp-Source: APiQypKNoDz6BP1RI9M0YPl9pcWqGxIrOVYsfjmoWi9nuctOhjmahygNaaTZyVnyzsVeN84KubdnJQ==
X-Received: by 2002:a17:90a:d56:: with SMTP id
 22mr6952803pju.187.1587496771311; 
 Tue, 21 Apr 2020 12:19:31 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net.
 [76.210.143.223])
 by smtp.gmail.com with ESMTPSA id z25sm692257pfa.213.2020.04.21.12.19.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Apr 2020 12:19:30 -0700 (PDT)
Subject: [PULL 4/6] riscv/sifive_u: Fix up file ordering
Date: Tue, 21 Apr 2020 12:09:59 -0700
Message-Id: <20200421191001.92644-5-palmerdabbelt@google.com>
X-Mailer: git-send-email 2.26.1.301.g55bc3eb7cb9-goog
In-Reply-To: <20200421191001.92644-1-palmerdabbelt@google.com>
References: <20200421191001.92644-1-palmerdabbelt@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: qemu-riscv@nongnu.org,          qemu-devel@nongnu.org,
 Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bmeng.cn@gmail.com>,
 Palmer Dabbelt <palmerdabbelt@google.com>
From: Palmer Dabbelt <palmerdabbelt@google.com>
To: Peter Maydell <peter.maydell@linaro.org>
Received-SPF: pass client-ip=2607:f8b0:4864:20::102c;
 envelope-from=palmerdabbelt@google.com; helo=mail-pj1-x102c.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2607:f8b0:4864:20::102c
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

From: Alistair Francis <alistair.francis@wdc.com>

Split the file into clear machine and SoC sections.

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Bin Meng <bmeng.cn@gmail.com>
Signed-off-by: Palmer Dabbelt <palmerdabbelt@google.com>
---
 hw/riscv/sifive_u.c | 109 ++++++++++++++++++++++----------------------
 1 file changed, 55 insertions(+), 54 deletions(-)

diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
index 56351c4faa..d0ea6803db 100644
--- a/hw/riscv/sifive_u.c
+++ b/hw/riscv/sifive_u.c
@@ -312,7 +312,7 @@ static void create_fdt(SiFiveUState *s, const struct MemmapEntry *memmap,
     g_free(nodename);
 }
 
-static void riscv_sifive_u_init(MachineState *machine)
+static void sifive_u_machine_init(MachineState *machine)
 {
     const struct MemmapEntry *memmap = sifive_u_memmap;
     SiFiveUState *s = RISCV_U_MACHINE(machine);
@@ -403,6 +403,60 @@ static void riscv_sifive_u_init(MachineState *machine)
                           &address_space_memory);
 }
 
+static bool sifive_u_machine_get_start_in_flash(Object *obj, Error **errp)
+{
+    SiFiveUState *s = RISCV_U_MACHINE(obj);
+
+    return s->start_in_flash;
+}
+
+static void sifive_u_machine_set_start_in_flash(Object *obj, bool value, Error **errp)
+{
+    SiFiveUState *s = RISCV_U_MACHINE(obj);
+
+    s->start_in_flash = value;
+}
+
+static void sifive_u_machine_instance_init(Object *obj)
+{
+    SiFiveUState *s = RISCV_U_MACHINE(obj);
+
+    s->start_in_flash = false;
+    object_property_add_bool(obj, "start-in-flash", sifive_u_machine_get_start_in_flash,
+                             sifive_u_machine_set_start_in_flash, NULL);
+    object_property_set_description(obj, "start-in-flash",
+                                    "Set on to tell QEMU's ROM to jump to " \
+                                    "flash. Otherwise QEMU will jump to DRAM",
+                                    NULL);
+}
+
+
+static void sifive_u_machine_class_init(ObjectClass *oc, void *data)
+{
+    MachineClass *mc = MACHINE_CLASS(oc);
+
+    mc->desc = "RISC-V Board compatible with SiFive U SDK";
+    mc->init = sifive_u_machine_init;
+    mc->max_cpus = SIFIVE_U_MANAGEMENT_CPU_COUNT + SIFIVE_U_COMPUTE_CPU_COUNT;
+    mc->min_cpus = SIFIVE_U_MANAGEMENT_CPU_COUNT + 1;
+    mc->default_cpus = mc->min_cpus;
+}
+
+static const TypeInfo sifive_u_machine_typeinfo = {
+    .name       = MACHINE_TYPE_NAME("sifive_u"),
+    .parent     = TYPE_MACHINE,
+    .class_init = sifive_u_machine_class_init,
+    .instance_init = sifive_u_machine_instance_init,
+    .instance_size = sizeof(SiFiveUState),
+};
+
+static void sifive_u_machine_init_register_types(void)
+{
+    type_register_static(&sifive_u_machine_typeinfo);
+}
+
+type_init(sifive_u_machine_init_register_types)
+
 static void riscv_sifive_u_soc_init(Object *obj)
 {
     MachineState *ms = MACHINE(qdev_get_machine());
@@ -443,33 +497,6 @@ static void riscv_sifive_u_soc_init(Object *obj)
                           TYPE_CADENCE_GEM);
 }
 
-static bool sifive_u_get_start_in_flash(Object *obj, Error **errp)
-{
-    SiFiveUState *s = RISCV_U_MACHINE(obj);
-
-    return s->start_in_flash;
-}
-
-static void sifive_u_set_start_in_flash(Object *obj, bool value, Error **errp)
-{
-    SiFiveUState *s = RISCV_U_MACHINE(obj);
-
-    s->start_in_flash = value;
-}
-
-static void riscv_sifive_u_machine_instance_init(Object *obj)
-{
-    SiFiveUState *s = RISCV_U_MACHINE(obj);
-
-    s->start_in_flash = false;
-    object_property_add_bool(obj, "start-in-flash", sifive_u_get_start_in_flash,
-                             sifive_u_set_start_in_flash, NULL);
-    object_property_set_description(obj, "start-in-flash",
-                                    "Set on to tell QEMU's ROM to jump to " \
-                                    "flash. Otherwise QEMU will jump to DRAM",
-                                    NULL);
-}
-
 static void riscv_sifive_u_soc_realize(DeviceState *dev, Error **errp)
 {
     MachineState *ms = MACHINE(qdev_get_machine());
@@ -607,29 +634,3 @@ static void riscv_sifive_u_soc_register_types(void)
 }
 
 type_init(riscv_sifive_u_soc_register_types)
-
-static void riscv_sifive_u_machine_class_init(ObjectClass *oc, void *data)
-{
-    MachineClass *mc = MACHINE_CLASS(oc);
-
-    mc->desc = "RISC-V Board compatible with SiFive U SDK";
-    mc->init = riscv_sifive_u_init;
-    mc->max_cpus = SIFIVE_U_MANAGEMENT_CPU_COUNT + SIFIVE_U_COMPUTE_CPU_COUNT;
-    mc->min_cpus = SIFIVE_U_MANAGEMENT_CPU_COUNT + 1;
-    mc->default_cpus = mc->min_cpus;
-}
-
-static const TypeInfo riscv_sifive_u_machine_typeinfo = {
-    .name       = MACHINE_TYPE_NAME("sifive_u"),
-    .parent     = TYPE_MACHINE,
-    .class_init = riscv_sifive_u_machine_class_init,
-    .instance_init = riscv_sifive_u_machine_instance_init,
-    .instance_size = sizeof(SiFiveUState),
-};
-
-static void riscv_sifive_u_machine_init_register_types(void)
-{
-    type_register_static(&riscv_sifive_u_machine_typeinfo);
-}
-
-type_init(riscv_sifive_u_machine_init_register_types)
-- 
2.26.1.301.g55bc3eb7cb9-goog


