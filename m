Return-Path: <SRS0=Szrt=YV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D252CA9EC0
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Oct 2019 16:17:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EBF98204FD
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Oct 2019 16:17:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="kORLJ6z6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EBF98204FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57322 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iP7hs-0006FD-OW
	for qemu-devel@archiver.kernel.org; Mon, 28 Oct 2019 12:17:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34763)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <palmer@sifive.com>) id 1iP7Pf-0005OQ-Bp
 for qemu-devel@nongnu.org; Mon, 28 Oct 2019 11:58:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <palmer@sifive.com>) id 1iP7Pd-0003tn-WC
 for qemu-devel@nongnu.org; Mon, 28 Oct 2019 11:58:35 -0400
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441]:39534)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <palmer@sifive.com>) id 1iP7Pd-0003tR-Qu
 for qemu-devel@nongnu.org; Mon, 28 Oct 2019 11:58:33 -0400
Received: by mail-pf1-x441.google.com with SMTP id v4so7155303pff.6
 for <qemu-devel@nongnu.org>; Mon, 28 Oct 2019 08:58:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sifive.com; s=google;
 h=subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding:cc:from:to;
 bh=WP8Cy2LjfUyKbvj4Exi5IKEff9PRhXsowYLykTeYI5E=;
 b=kORLJ6z6gEe/Ceo8UQOBHOKCOnfw6s2wmPE7QEw9n/qWGkJQup48aRtedF8UQBrMtY
 9aElaVJLm517nJ0cFsA7r71GYN+GINEu30pEo8MRm/DhLnsTqDx8dEIWnqBNF7KdpH7g
 6M3IG7p4wtHA87Ae0EA+Uk1mdwM2qDUBOzZ8BseTEburU1bGLuefQVsm66kjUTCe7C/A
 4hu8ct1bfdn+evh6oszyDmUG6bNXZ4A+IikKeCZ90ofN7esFAaGMxfspCE+jZ3mWVPQ/
 SuFqLuW8Yh9Ou3yAg7f7hsDqUxPj7Z0J2GADsr5i21TSSiQmmNagYV7ehhiewxRmE/La
 x87Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding:cc:from:to;
 bh=WP8Cy2LjfUyKbvj4Exi5IKEff9PRhXsowYLykTeYI5E=;
 b=dyaCNk1ghjIpT5v3p9SvU7TAKWLiDNp5SNYOl4zYtvNi3B/es1AXvv1OViQZ3qksoY
 mNsElS1W/IK5/IpHTaV0H2cSnzLlzvVeEqLSJg7HXZdUnY4kyRIut6odKcy1yDaqSmeB
 ZOuY0zXnAGNdlx7kESxg3oQZGhHVEostZQA5AKVO4UBYRWIEw3PWeUP9GoXf914F98TP
 21R0aUIlyi9/5mxazyongFFCfF6TDn7UuWk91Y1H8kZobf9zh9P+nk1WJv6emADZQYUt
 E6qlSutJvse3TvbpXp20SZaO0t4cDecfGB/urVxLDilo2Wa/XdxMDgJ6K0pSX+vnOIg1
 V3Pg==
X-Gm-Message-State: APjAAAUAdx2pEpPVaC6YD9glREtFTJ/NEEo+3ITNBZBLA6QIIx0CNqbY
 DkkLfR/MTOpygfhR3LsGa/sLGYbeJPZk0A==
X-Google-Smtp-Source: APXvYqzNElE53svNMF4biWhIynm8Rhq2pOSIu6Ieo3h91imlrRepPCKHzaYLSz5dKK5z+AheHfQpZg==
X-Received: by 2002:a17:90b:914:: with SMTP id bo20mr17886pjb.6.1572278312458; 
 Mon, 28 Oct 2019 08:58:32 -0700 (PDT)
Received: from localhost ([12.206.222.5])
 by smtp.gmail.com with ESMTPSA id y20sm12374138pge.48.2019.10.28.08.58.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Oct 2019 08:58:31 -0700 (PDT)
Subject: [PULL 09/18] riscv/sifive_u: Manually define the machine
Date: Mon, 28 Oct 2019 08:48:53 -0700
Message-Id: <20191028154902.32491-10-palmer@sifive.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191028154902.32491-1-palmer@sifive.com>
References: <20191028154902.32491-1-palmer@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
From: Palmer Dabbelt <palmer@sifive.com>
To: Peter Maydell <peter.maydell@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::441
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
Cc: Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bmeng.cn@gmail.com>,
 qemu-riscv@nongnu.org, qemu-devel@nongnu.org,
 Palmer Dabbelt <palmer@sifive.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Alistair Francis <alistair.francis@wdc.com>

Instead of using the DEFINE_MACHINE() macro to define the machine let's
do it manually. This allows us to specify machine properties.

This patch is no functional change.

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Bin Meng <bmeng.cn@gmail.com>
Tested-by: Bin Meng <bmeng.cn@gmail.com>
Signed-off-by: Palmer Dabbelt <palmer@sifive.com>
---
 hw/riscv/sifive_u.c         | 44 ++++++++++++++++++++++++++-----------
 include/hw/riscv/sifive_u.h |  7 +++++-
 2 files changed, 37 insertions(+), 14 deletions(-)

diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
index a32d6773a8..eb4124f5b4 100644
--- a/hw/riscv/sifive_u.c
+++ b/hw/riscv/sifive_u.c
@@ -311,8 +311,7 @@ static void create_fdt(SiFiveUState *s, const struct MemmapEntry *memmap,
 static void riscv_sifive_u_init(MachineState *machine)
 {
     const struct MemmapEntry *memmap = sifive_u_memmap;
-
-    SiFiveUState *s = g_new0(SiFiveUState, 1);
+    SiFiveUState *s = RISCV_U_MACHINE(machine);
     MemoryRegion *system_memory = get_system_memory();
     MemoryRegion *main_mem = g_new(MemoryRegion, 1);
     MemoryRegion *flash0 = g_new(MemoryRegion, 1);
@@ -434,6 +433,10 @@ static void riscv_sifive_u_soc_init(Object *obj)
                           TYPE_CADENCE_GEM);
 }
 
+static void riscv_sifive_u_machine_instance_init(Object *obj)
+{
+}
+
 static void riscv_sifive_u_soc_realize(DeviceState *dev, Error **errp)
 {
     MachineState *ms = MACHINE(qdev_get_machine());
@@ -547,17 +550,6 @@ static void riscv_sifive_u_soc_realize(DeviceState *dev, Error **errp)
         memmap[SIFIVE_U_GEM_MGMT].base, memmap[SIFIVE_U_GEM_MGMT].size);
 }
 
-static void riscv_sifive_u_machine_init(MachineClass *mc)
-{
-    mc->desc = "RISC-V Board compatible with SiFive U SDK";
-    mc->init = riscv_sifive_u_init;
-    mc->max_cpus = SIFIVE_U_MANAGEMENT_CPU_COUNT + SIFIVE_U_COMPUTE_CPU_COUNT;
-    mc->min_cpus = SIFIVE_U_MANAGEMENT_CPU_COUNT + 1;
-    mc->default_cpus = mc->min_cpus;
-}
-
-DEFINE_MACHINE("sifive_u", riscv_sifive_u_machine_init)
-
 static void riscv_sifive_u_soc_class_init(ObjectClass *oc, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(oc);
@@ -581,3 +573,29 @@ static void riscv_sifive_u_soc_register_types(void)
 }
 
 type_init(riscv_sifive_u_soc_register_types)
+
+static void riscv_sifive_u_machine_class_init(ObjectClass *oc, void *data)
+{
+    MachineClass *mc = MACHINE_CLASS(oc);
+
+    mc->desc = "RISC-V Board compatible with SiFive U SDK";
+    mc->init = riscv_sifive_u_init;
+    mc->max_cpus = SIFIVE_U_MANAGEMENT_CPU_COUNT + SIFIVE_U_COMPUTE_CPU_COUNT;
+    mc->min_cpus = SIFIVE_U_MANAGEMENT_CPU_COUNT + 1;
+    mc->default_cpus = mc->min_cpus;
+}
+
+static const TypeInfo riscv_sifive_u_machine_typeinfo = {
+    .name       = MACHINE_TYPE_NAME("sifive_u"),
+    .parent     = TYPE_MACHINE,
+    .class_init = riscv_sifive_u_machine_class_init,
+    .instance_init = riscv_sifive_u_machine_instance_init,
+    .instance_size = sizeof(SiFiveUState),
+};
+
+static void riscv_sifive_u_machine_init_register_types(void)
+{
+    type_register_static(&riscv_sifive_u_machine_typeinfo);
+}
+
+type_init(riscv_sifive_u_machine_init_register_types)
diff --git a/include/hw/riscv/sifive_u.h b/include/hw/riscv/sifive_u.h
index 0062276190..794b958dcc 100644
--- a/include/hw/riscv/sifive_u.h
+++ b/include/hw/riscv/sifive_u.h
@@ -44,12 +44,17 @@ typedef struct SiFiveUSoCState {
     CadenceGEMState gem;
 } SiFiveUSoCState;
 
+#define TYPE_RISCV_U_MACHINE MACHINE_TYPE_NAME("sifive_u")
+#define RISCV_U_MACHINE(obj) \
+    OBJECT_CHECK(SiFiveUState, (obj), TYPE_RISCV_U_MACHINE)
+
 typedef struct SiFiveUState {
     /*< private >*/
-    SysBusDevice parent_obj;
+    MachineState parent_obj;
 
     /*< public >*/
     SiFiveUSoCState soc;
+
     void *fdt;
     int fdt_size;
 } SiFiveUState;
-- 
2.21.0


