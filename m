Return-Path: <SRS0=Dndf=B6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57904C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2020 15:19:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 26868206DA
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2020 15:19:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nuviainc-com.20150623.gappssmtp.com header.i=@nuviainc-com.20150623.gappssmtp.com header.b="Vl/1FMvN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 26868206DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=nuviainc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37442 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k8mLj-0007Xh-F1
	for qemu-devel@archiver.kernel.org; Thu, 20 Aug 2020 11:19:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37504)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <graeme@nuviainc.com>)
 id 1k8kfu-0001RO-6n
 for qemu-devel@nongnu.org; Thu, 20 Aug 2020 09:32:14 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:35203)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <graeme@nuviainc.com>)
 id 1k8kfn-0002EF-WB
 for qemu-devel@nongnu.org; Thu, 20 Aug 2020 09:32:13 -0400
Received: by mail-wm1-x342.google.com with SMTP id o21so1612091wmc.0
 for <qemu-devel@nongnu.org>; Thu, 20 Aug 2020 06:32:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=nuviainc-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=XB8p7O0jl/F3z0IsjW/SDkKKV1PNjeynh1m5Jyrj5cg=;
 b=Vl/1FMvNiLpSqZvF6qlGe3poPI2innOs7lTJQ3o7ZHSNOynB55YOWR8xqddcCWMyaP
 lXcjwfVl0xGmLyvegg80J2oyaRlqGulPmOpt4jxSmlinPazycDI4j2wWCc8UJ3ar/bFp
 fipaWAXuM42jGe2BCl/kgzl7Moo7dhmFHQjfVq31fX17i/b6VO6/mQLcKZYaWNavb9+5
 SYtZYMi9DHLXoj4n/OcRDNMk4xVVY/d1MSR3o363rPFYJvT5CDf25GmUGj3C18N5IMue
 h4vgnERbOIzm9JrS8B/1o3U4rfmDGeDU5GVYMjV1CIhR7NUBO4xAXR4A57XN2FGyaliK
 uXsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=XB8p7O0jl/F3z0IsjW/SDkKKV1PNjeynh1m5Jyrj5cg=;
 b=nsdWYhBUUL5RgptCODatqO3nos0p6jMqHZJ0cG2ZNBNKOwCLrVy6aS/hPy+2kVzk8V
 n5vGF83yhxFAuJMMD23nysRcb+6jaqsj1TQ6qM6uym34OIS/n5t+qIQnk5xC6zRnCzsL
 BmsVnGt0Vep8bys83113VeL6zFWKbqkUGH5Wu75RImRNv+/BhjsA+3UjQmOjI/61feUL
 mMKwEKkIwwNdX8yOwUVdKLQQkIy7MU4g6rQnLwsnqcFZdsdTVY9KDPz1WRfn1iXd+33R
 rQByVqrh88Rp/C2fgcuALr0Qn0qzau2qxRNt1IKUk/doF3CeXRsbxZpAEaoBg3xjZFDA
 ZgPA==
X-Gm-Message-State: AOAM530hwCG6J8sHuBbItfkqGkrXCWut2GRe1jfQudJip+1YOodk8M87
 uRC5QC8w4FWfSUD+uzeJRiAxHw==
X-Google-Smtp-Source: ABdhPJwcwfWertMTAZStj5Ca1vjhddNQ9jmYgtUAFjOF99LGk5Fnn1T+j1rMOCAOj8QUXJ99artFYw==
X-Received: by 2002:a1c:18e:: with SMTP id 136mr3506889wmb.93.1597930325663;
 Thu, 20 Aug 2020 06:32:05 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8010:64d6::1d89])
 by smtp.gmail.com with ESMTPSA id h13sm4017903wrx.17.2020.08.20.06.32.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Aug 2020 06:32:05 -0700 (PDT)
From: Graeme Gregory <graeme@nuviainc.com>
To: qemu-arm@nongnu.org
Subject: [PATCH] hw/arm/sbsa-ref.c : Add a fake embedded controller
Date: Thu, 20 Aug 2020 14:32:01 +0100
Message-Id: <20200820133201.80577-1-graeme@nuviainc.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::342;
 envelope-from=graeme@nuviainc.com; helo=mail-wm1-x342.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Thu, 20 Aug 2020 11:15:42 -0400
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
Cc: Graeme Gregory <graeme@nuviainc.com>, peter.maydell@linaro.org,
 leif@nuviainc.com, rad@semihalf.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

A difference between sbsa platform and the virt platform is PSCI is
handled by ARM-TF in the sbsa platform. This means that the PSCI code
there needs to communicate some of the platform power changes down
to the qemu code for things like shutdown/reset control.

Space has been left to extend the EC if we find other use cases in
future where ARM-TF and qemu need to communicate.

Signed-off-by: Graeme Gregory <graeme@nuviainc.com>
---
 hw/arm/sbsa-ref.c | 95 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 95 insertions(+)

diff --git a/hw/arm/sbsa-ref.c b/hw/arm/sbsa-ref.c
index f030a416fd..c8743fc1d0 100644
--- a/hw/arm/sbsa-ref.c
+++ b/hw/arm/sbsa-ref.c
@@ -41,6 +41,7 @@
 #include "hw/usb.h"
 #include "hw/char/pl011.h"
 #include "net/net.h"
+#include "migration/vmstate.h"
 
 #define RAMLIMIT_GB 8192
 #define RAMLIMIT_BYTES (RAMLIMIT_GB * GiB)
@@ -62,6 +63,7 @@ enum {
     SBSA_CPUPERIPHS,
     SBSA_GIC_DIST,
     SBSA_GIC_REDIST,
+    SBSA_SECURE_EC,
     SBSA_SMMU,
     SBSA_UART,
     SBSA_RTC,
@@ -98,6 +100,14 @@ typedef struct {
 #define SBSA_MACHINE(obj) \
     OBJECT_CHECK(SBSAMachineState, (obj), TYPE_SBSA_MACHINE)
 
+typedef struct {
+    SysBusDevice parent_obj;
+    MemoryRegion iomem;
+} SECUREECState;
+
+#define TYPE_SECURE_EC      "sbsa-secure-ec"
+#define SECURE_EC(obj) OBJECT_CHECK(SECUREECState, (obj), TYPE_SECURE_EC)
+
 static const MemMapEntry sbsa_ref_memmap[] = {
     /* 512M boot ROM */
     [SBSA_FLASH] =              {          0, 0x20000000 },
@@ -107,6 +117,7 @@ static const MemMapEntry sbsa_ref_memmap[] = {
     [SBSA_CPUPERIPHS] =         { 0x40000000, 0x00040000 },
     [SBSA_GIC_DIST] =           { 0x40060000, 0x00010000 },
     [SBSA_GIC_REDIST] =         { 0x40080000, 0x04000000 },
+    [SBSA_SECURE_EC] =          { 0x50000000, 0x00001000 },
     [SBSA_UART] =               { 0x60000000, 0x00001000 },
     [SBSA_RTC] =                { 0x60010000, 0x00001000 },
     [SBSA_GPIO] =               { 0x60020000, 0x00001000 },
@@ -585,6 +596,65 @@ static void *sbsa_ref_dtb(const struct arm_boot_info *binfo, int *fdt_size)
     return board->fdt;
 }
 
+enum sbsa_secure_ec_powerstates {
+    SBSA_SECURE_EC_CMD_NULL,
+    SBSA_SECURE_EC_CMD_POWEROFF,
+    SBSA_SECURE_EC_CMD_REBOOT,
+};
+
+static uint64_t secure_ec_read(void *opaque, hwaddr offset, unsigned size)
+{
+    /* No use for this currently */
+    return 0;
+}
+
+static void secure_ec_write(void *opaque, hwaddr offset,
+                     uint64_t value, unsigned size)
+{
+    if (offset == 0) { /* PSCI machine power command register */
+        switch (value) {
+        case SBSA_SECURE_EC_CMD_NULL:
+            break;
+        case SBSA_SECURE_EC_CMD_POWEROFF:
+            qemu_system_shutdown_request(SHUTDOWN_CAUSE_GUEST_SHUTDOWN);
+            break;
+        case SBSA_SECURE_EC_CMD_REBOOT:
+            qemu_system_reset_request(SHUTDOWN_CAUSE_GUEST_RESET);
+            break;
+        default:
+            error_report("sbsa-ref: ERROR Unkown power command");
+        }
+    } else {
+        error_report("sbsa-ref: unknown EC register");
+    }
+}
+
+static const MemoryRegionOps secure_ec_ops = {
+    .read = secure_ec_read,
+    .write = secure_ec_write,
+    .endianness = DEVICE_NATIVE_ENDIAN,
+};
+
+static void secure_ec_init(Object *obj)
+{
+    SECUREECState *s = SECURE_EC(obj);
+    SysBusDevice *dev = SYS_BUS_DEVICE(obj);
+
+    memory_region_init_io(&s->iomem, obj, &secure_ec_ops, s, "secure-ec",
+                            0x1000);
+    sysbus_init_mmio(dev, &s->iomem);
+}
+
+static void create_secure_ec(MemoryRegion *mem)
+{
+    hwaddr base = sbsa_ref_memmap[SBSA_SECURE_EC].base;
+    DeviceState *dev = qdev_create(NULL, TYPE_SECURE_EC);
+    SysBusDevice *s = SYS_BUS_DEVICE(dev);
+
+    memory_region_add_subregion(mem, base,
+                                sysbus_mmio_get_region(s, 0));
+}
+
 static void sbsa_ref_init(MachineState *machine)
 {
     unsigned int smp_cpus = machine->smp.cpus;
@@ -708,6 +778,8 @@ static void sbsa_ref_init(MachineState *machine)
 
     create_pcie(sms);
 
+    create_secure_ec(secure_sysmem);
+
     sms->bootinfo.ram_size = machine->ram_size;
     sms->bootinfo.nb_cpus = smp_cpus;
     sms->bootinfo.board_id = -1;
@@ -798,8 +870,31 @@ static const TypeInfo sbsa_ref_info = {
     .instance_size = sizeof(SBSAMachineState),
 };
 
+static const VMStateDescription vmstate_secure_ec_info = {
+    .name = "sbsa-secure-ec",
+    .version_id = 0,
+    .minimum_version_id = 0,
+};
+
+static void secure_ec_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+
+    dc->vmsd = &vmstate_secure_ec_info;
+    dc->user_creatable = false;
+}
+
+static const TypeInfo secure_ec_info = {
+    .name          = TYPE_SECURE_EC,
+    .parent        = TYPE_SYS_BUS_DEVICE,
+    .instance_size = sizeof(SECUREECState),
+    .instance_init = secure_ec_init,
+    .class_init    = secure_ec_class_init,
+};
+
 static void sbsa_ref_machine_init(void)
 {
+    type_register_static(&secure_ec_info);
     type_register_static(&sbsa_ref_info);
 }
 
-- 
2.25.1


