Return-Path: <SRS0=By5p=5W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DECBAC2BA17
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Apr 2020 18:03:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ABDCF206F8
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Apr 2020 18:03:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mPn2hMxB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ABDCF206F8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36176 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jLW65-0003e1-SQ
	for qemu-devel@archiver.kernel.org; Mon, 06 Apr 2020 14:03:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36062)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jLVqz-0001qP-F8
 for qemu-devel@nongnu.org; Mon, 06 Apr 2020 13:48:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jLVqy-0002SD-5w
 for qemu-devel@nongnu.org; Mon, 06 Apr 2020 13:48:09 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:39146)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jLVqx-0002Oh-Vq; Mon, 06 Apr 2020 13:48:08 -0400
Received: by mail-wr1-x442.google.com with SMTP id p10so493622wrt.6;
 Mon, 06 Apr 2020 10:48:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=cLajudUBTjPPEHDWHNc0MGZvDpG60cDj46wJF9MFpFg=;
 b=mPn2hMxBiUQws0UYR6Oe4NESYpxvCpxXmuJs+beJFfV83Pl8Pqc2djjTCOaTwqk8t6
 a7wxDDAFDDOloUPL7ywMXu4jV/hGlOSGQ2A3N3FHeGmQMcG1SXkYIt3JCF5I/OMSuKuT
 uCkPKA0WR4Ueu9rKm//UzY3L+cmwSkw0U15BAZkKEId8jG29LFTUWmXeR3TCPyQAyjwH
 qoaJ1B/TISUK1IkiudVLOGJP0ahrbBevURnHGD+SVv6+R4Qawsiq82u75Rpp8Vfe+H+U
 KJoRb0NuOp9SQzIv8A6yYbGoE9JYC8x3mxiOqFyrv5ujo7oFg6d8V5RslC9NAJipZ9T8
 ppYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=cLajudUBTjPPEHDWHNc0MGZvDpG60cDj46wJF9MFpFg=;
 b=XSTzf9W6O7/mnuD6KpusXSgb878ZoUumwI6kV6anvDjQNIMsX9gZKOmmAaSjgueXQM
 gLy12iIXtIlOe9jWH4iCDHJxkjkxAImgXs6M55Ziv1/NT7fIEUbTT3l8k2ujox1hN3wt
 YCzSO40EGo1MJsPIS9mYXhNFAJuvse1EQZDLa13bFN0GTIG2ZZ6QgGraGOv8rsG0lsIc
 ILuf0zEKSlASQtMo4TAiUvyrw87LdUO9O4cmI/C5bujnxy4ZOaJno/GMpSoUt197wVwp
 Z24K/mNs+4HnM214np2hUx86U9qt++tXMVn5cXXyavkps+3pSeR8jGp/Oo1r16laonuX
 7ufw==
X-Gm-Message-State: AGi0PuZswiH+axm9c7sGSZoMHsGFm3ib/K+pEEzSsARzsDhS8VRICo9k
 AO2B/IEu8+EPpXPoCAH7uUg/RG1zGL8=
X-Google-Smtp-Source: APiQypLTfnnx/VjbqsCCPP45M4q/YCxxrLPNSMJd1B5BQrcuqyZGc8fG2cAiZEKx3yNBe5Q8EGG5Rg==
X-Received: by 2002:adf:a308:: with SMTP id c8mr391382wrb.302.1586195286691;
 Mon, 06 Apr 2020 10:48:06 -0700 (PDT)
Received: from x1w.redhat.com (116.red-83-42-57.dynamicip.rima-tde.net.
 [83.42.57.116])
 by smtp.gmail.com with ESMTPSA id a67sm364880wmc.30.2020.04.06.10.48.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Apr 2020 10:48:06 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org,
	Markus Armbruster <armbru@redhat.com>
Subject: [PATCH-for-5.1 v2 15/54] hw/arm/xlnx-zynqmp: Split
 xlnx_zynqmp_create_rpu() as init + realize
Date: Mon,  6 Apr 2020 19:47:04 +0200
Message-Id: <20200406174743.16956-16-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200406174743.16956-1-f4bug@amsat.org>
References: <20200406174743.16956-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::442
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 Alistair Francis <alistair@alistair23.me>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 "open list:Xilinx ZynqMP" <qemu-arm@nongnu.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Coccinelle failed at processing this file:

  $ spatch ... --timeout 60 --sp-file \
    scripts/coccinelle/simplify-init-realize-error_propagate.cocci
  HANDLING: ./hw/arm/xlnx-zynqmp.c
  EXN: Coccinelle_modules.Common.Timeout

We are going to manually add the missing propagate_error() calls.
Some functions can be called at init() time, reducing the need
to add extra Error checks at realize() time. Split create_rpu()
in init() and realize().

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/arm/xlnx-zynqmp.c | 45 +++++++++++++++++++++++++++-----------------
 1 file changed, 28 insertions(+), 17 deletions(-)

diff --git a/hw/arm/xlnx-zynqmp.c b/hw/arm/xlnx-zynqmp.c
index 43d57fa7de..457057198a 100644
--- a/hw/arm/xlnx-zynqmp.c
+++ b/hw/arm/xlnx-zynqmp.c
@@ -173,18 +173,9 @@ static inline int arm_gic_ppi_index(int cpu_nr, int ppi_index)
     return GIC_NUM_SPI_INTR + cpu_nr * GIC_INTERNAL + ppi_index;
 }
 
-static void xlnx_zynqmp_create_rpu(MachineState *ms, XlnxZynqMPState *s,
-                                   const char *boot_cpu, Error **errp)
+static void xlnx_zynqmp_rpu_init(XlnxZynqMPState *s, int num_rpus)
 {
-    Error *err = NULL;
     int i;
-    int num_rpus = MIN(ms->smp.cpus - XLNX_ZYNQMP_NUM_APU_CPUS,
-                       XLNX_ZYNQMP_NUM_RPU_CPUS);
-
-    if (num_rpus <= 0) {
-        /* Don't create rpu-cluster object if there's nothing to put in it */
-        return;
-    }
 
     object_initialize_child(OBJECT(s), "rpu-cluster", &s->rpu_cluster,
                             sizeof(s->rpu_cluster), TYPE_CPU_CLUSTER,
@@ -192,13 +183,25 @@ static void xlnx_zynqmp_create_rpu(MachineState *ms, XlnxZynqMPState *s,
     qdev_prop_set_uint32(DEVICE(&s->rpu_cluster), "cluster-id", 1);
 
     for (i = 0; i < num_rpus; i++) {
-        char *name;
-
         object_initialize_child(OBJECT(&s->rpu_cluster), "rpu-cpu[*]",
                                 &s->rpu_cpu[i], sizeof(s->rpu_cpu[i]),
                                 ARM_CPU_TYPE_NAME("cortex-r5f"),
                                 &error_abort, NULL);
 
+        object_property_set_bool(OBJECT(&s->rpu_cpu[i]), true, "reset-hivecs",
+                                 &error_abort);
+    }
+}
+
+static void xlnx_zynqmp_rpu_realize(XlnxZynqMPState *s, int num_rpus,
+                                    const char *boot_cpu, Error **errp)
+{
+    Error *err = NULL;
+    int i;
+
+    for (i = 0; i < num_rpus; i++) {
+        char *name;
+
         name = object_get_canonical_path_component(OBJECT(&s->rpu_cpu[i]));
         if (strcmp(name, boot_cpu)) {
             /* Secondary CPUs start in PSCI powered-down state */
@@ -209,8 +212,6 @@ static void xlnx_zynqmp_create_rpu(MachineState *ms, XlnxZynqMPState *s,
         }
         g_free(name);
 
-        object_property_set_bool(OBJECT(&s->rpu_cpu[i]), true, "reset-hivecs",
-                                 &error_abort);
         object_property_set_bool(OBJECT(&s->rpu_cpu[i]), true, "realized",
                                  &err);
         if (err) {
@@ -228,6 +229,8 @@ static void xlnx_zynqmp_init(Object *obj)
     XlnxZynqMPState *s = XLNX_ZYNQMP(obj);
     int i;
     int num_apus = MIN(ms->smp.cpus, XLNX_ZYNQMP_NUM_APU_CPUS);
+    int num_rpus = MIN(ms->smp.cpus - XLNX_ZYNQMP_NUM_APU_CPUS,
+                       XLNX_ZYNQMP_NUM_RPU_CPUS);
 
     object_initialize_child(obj, "apu-cluster", &s->apu_cluster,
                             sizeof(s->apu_cluster), TYPE_CPU_CLUSTER,
@@ -290,6 +293,10 @@ static void xlnx_zynqmp_init(Object *obj)
         sysbus_init_child_obj(obj, "adma[*]", &s->adma[i], sizeof(s->adma[i]),
                               TYPE_XLNX_ZDMA);
     }
+
+    if (num_rpus > 0) {
+        xlnx_zynqmp_rpu_init(s, num_rpus);
+    }
 }
 
 static void xlnx_zynqmp_realize(DeviceState *dev, Error **errp)
@@ -300,6 +307,8 @@ static void xlnx_zynqmp_realize(DeviceState *dev, Error **errp)
     uint8_t i;
     uint64_t ram_size;
     int num_apus = MIN(ms->smp.cpus, XLNX_ZYNQMP_NUM_APU_CPUS);
+    int num_rpus = MIN(ms->smp.cpus - XLNX_ZYNQMP_NUM_APU_CPUS,
+                       XLNX_ZYNQMP_NUM_RPU_CPUS);
     const char *boot_cpu = s->boot_cpu ? s->boot_cpu : "apu-cpu[0]";
     ram_addr_t ddr_low_size, ddr_high_size;
     qemu_irq gic_spi[GIC_NUM_SPI_INTR];
@@ -458,9 +467,11 @@ static void xlnx_zynqmp_realize(DeviceState *dev, Error **errp)
                     "RPUs just use -smp 6.");
     }
 
-    xlnx_zynqmp_create_rpu(ms, s, boot_cpu, &err);
-    if (err) {
-        goto out_propagate_error;
+    if (num_rpus > 0) {
+        xlnx_zynqmp_rpu_realize(s, num_rpus, boot_cpu, &err);
+        if (err) {
+            goto out_propagate_error;
+        }
     }
 
     if (!s->boot_cpu_ptr) {
-- 
2.21.1


