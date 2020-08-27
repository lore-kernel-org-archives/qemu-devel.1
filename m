Return-Path: <SRS0=k4hX=CF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0724EC433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2020 12:52:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C394922BF5
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2020 12:52:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nuviainc-com.20150623.gappssmtp.com header.i=@nuviainc-com.20150623.gappssmtp.com header.b="hV97SJc9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C394922BF5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=nuviainc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34512 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBHOf-0005fe-3k
	for qemu-devel@archiver.kernel.org; Thu, 27 Aug 2020 08:52:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60342)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leif@nuviainc.com>) id 1kBHFo-0000nM-9f
 for qemu-devel@nongnu.org; Thu, 27 Aug 2020 08:43:44 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:34431)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <leif@nuviainc.com>) id 1kBHFl-0006ou-7R
 for qemu-devel@nongnu.org; Thu, 27 Aug 2020 08:43:43 -0400
Received: by mail-wr1-x443.google.com with SMTP id f7so5264862wrw.1
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2020 05:43:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=nuviainc-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=PeTro//U+ItdJy/4VEWKF3xKEFMPV5pkE6n1z5mnbVE=;
 b=hV97SJc9WGYDc4jLr0S3i3IIbkI3t8pg4F8eAtcbiRx7Ceb8jqifJ3bjAG4vQh3HIw
 0wqx73nA9bzP+VPbEQ0IJQ36lBGs5x+HROQvyNiE9Xv0j9FZj4fAqF/LrFb79yXFXs0I
 BpB1rbK6kJJqt6ve+cnSFqwQOF/FExZiV6FIPFqVkVNZ/PXg8dvfSo6xVe4XzLL4WkXy
 KgBubXULaetxU2Bd7QXMgdv2m3r2nYFHg5kLqDmz5FBlwFvk0e1w6+3z90lQc1Snn5gv
 XIyOB9Kq/74uCaGLvYNG/swmm3+KqUXZ3m0UaCp451t+Km/VvRgDXguDQ2cOK7EGhnVL
 Qk5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=PeTro//U+ItdJy/4VEWKF3xKEFMPV5pkE6n1z5mnbVE=;
 b=nLvUGRL0SsyhKQLSbcs/5Fbt2+xb560dYjwnDfl9XzYkR1T33qWx/03NcFh1RyDda/
 6OUaNKFgiRdPJQQZQN86hF9v95LszfV+PV5B7OAAeiCUL3u0KY7dMAO0vLqq9MYpCHxY
 Q9hMUqH9n5gG5xSBCGusf4XOfumqBzbf1hD6hfIDC4EZYNYlM9+AFZZv3Unqzwt12a5R
 ohJXOTp73Hm3aD+4b8J/RBtDpeDZh0LCEQg6cieNGwUexp4OsDJl6dh56cBbonMatEhl
 xdKPWerbqRmUvT73cVWbzunk1ijnH5K/xVYhYQRCCs3wuse82Q23TB+Ys7E5Z4EvSWEz
 eyiQ==
X-Gm-Message-State: AOAM5302DVp96UoKxb9Db865SNxHn4KUpOlJiqUIdmQyfRJ50NKB7f3A
 0FQbaGZ8X9pTaa6z20vQlAlkYA==
X-Google-Smtp-Source: ABdhPJzQYOkmZn7TJDBdXntVHQfheOZLJpuvVE6vyUzE5ZzGlVu+Nk3rtaQcaqtWRYoNnpqaicKtFg==
X-Received: by 2002:adf:db43:: with SMTP id f3mr21876595wrj.219.1598532216872; 
 Thu, 27 Aug 2020 05:43:36 -0700 (PDT)
Received: from vanye.hemma.eciton.net
 (cpc92302-cmbg19-2-0-cust304.5-4.cable.virginm.net. [82.1.209.49])
 by smtp.gmail.com with ESMTPSA id c205sm3889262wmd.33.2020.08.27.05.43.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Aug 2020 05:43:36 -0700 (PDT)
From: Leif Lindholm <leif@nuviainc.com>
To: qemu-arm@nongnu.org
Subject: [PATCH v2] hw/arm/sbsa-ref: add "reg" property to DT cpu nodes
Date: Thu, 27 Aug 2020 13:43:35 +0100
Message-Id: <20200827124335.30586-1-leif@nuviainc.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::443;
 envelope-from=leif@nuviainc.com; helo=mail-wr1-x443.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
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
Cc: Graeme Gregory <graeme@nuviainc.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Tanmay Jagdale <tanmay.jagdale@linaro.org>,
 Radoslaw Biernacki <rad@semihalf.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The sbsa-ref platform uses a minimal device tree to pass amount of memory
as well as number of cpus to the firmware. However, when dumping that
minimal dtb (with -M sbsa-virt,dumpdtb=<file>), the resulting blob
generates a warning when decompiled by dtc due to lack of reg property.

Add a simple reg property per cpu, representing a 64-bit MPIDR_EL1.

This also ends up being cleaner than having the firmware calculating its
own IDs for generating APCI.

Signed-off-by: Leif Lindholm <leif@nuviainc.com>
---

As per Graeme's feedback, properly represent the MPIDR topology info
in the reg property rather than just counting cores (and update the
commit message on why this is useful).
I'm using the local helper function sbsa_ref_cpu_mp_affinity() for this,
and moving it up somewhat rather than adding a forward declaration.

 hw/arm/sbsa-ref.c | 29 +++++++++++++++++++++++------
 1 file changed, 23 insertions(+), 6 deletions(-)

diff --git a/hw/arm/sbsa-ref.c b/hw/arm/sbsa-ref.c
index f030a416fd..3e65ded9a0 100644
--- a/hw/arm/sbsa-ref.c
+++ b/hw/arm/sbsa-ref.c
@@ -138,6 +138,12 @@ static const int sbsa_ref_irqmap[] = {
     [SBSA_EHCI] = 11,
 };
 
+static uint64_t sbsa_ref_cpu_mp_affinity(SBSAMachineState *sms, int idx)
+{
+    uint8_t clustersz = ARM_DEFAULT_CPUS_PER_CLUSTER;
+    return arm_cpu_mp_affinity(idx, clustersz);
+}
+
 /*
  * Firmware on this machine only uses ACPI table to load OS, these limited
  * device tree nodes are just to let firmware know the info which varies from
@@ -183,14 +189,31 @@ static void create_fdt(SBSAMachineState *sms)
         g_free(matrix);
     }
 
+    /*
+     * From Documentation/devicetree/bindings/arm/cpus.yaml
+     *  On ARM v8 64-bit systems this property is required
+     *    and matches the MPIDR_EL1 register affinity bits.
+     *
+     *    * If cpus node's #address-cells property is set to 2
+     *
+     *      The first reg cell bits [7:0] must be set to
+     *      bits [39:32] of MPIDR_EL1.
+     *
+     *      The second reg cell bits [23:0] must be set to
+     *      bits [23:0] of MPIDR_EL1.
+     */
     qemu_fdt_add_subnode(sms->fdt, "/cpus");
+    qemu_fdt_setprop_cell(sms->fdt, "/cpus", "#address-cells", 2);
+    qemu_fdt_setprop_cell(sms->fdt, "/cpus", "#size-cells", 0x0);
 
     for (cpu = sms->smp_cpus - 1; cpu >= 0; cpu--) {
         char *nodename = g_strdup_printf("/cpus/cpu@%d", cpu);
         ARMCPU *armcpu = ARM_CPU(qemu_get_cpu(cpu));
         CPUState *cs = CPU(armcpu);
+        uint64_t mpidr = sbsa_ref_cpu_mp_affinity(sms, cpu);
 
         qemu_fdt_add_subnode(sms->fdt, nodename);
+        qemu_fdt_setprop_u64(sms->fdt, nodename, "reg", mpidr);
 
         if (ms->possible_cpus->cpus[cs->cpu_index].props.has_node_id) {
             qemu_fdt_setprop_cell(sms->fdt, nodename, "numa-node-id",
@@ -717,12 +740,6 @@ static void sbsa_ref_init(MachineState *machine)
     arm_load_kernel(ARM_CPU(first_cpu), machine, &sms->bootinfo);
 }
 
-static uint64_t sbsa_ref_cpu_mp_affinity(SBSAMachineState *sms, int idx)
-{
-    uint8_t clustersz = ARM_DEFAULT_CPUS_PER_CLUSTER;
-    return arm_cpu_mp_affinity(idx, clustersz);
-}
-
 static const CPUArchIdList *sbsa_ref_possible_cpu_arch_ids(MachineState *ms)
 {
     unsigned int max_cpus = ms->smp.max_cpus;
-- 
2.20.1


