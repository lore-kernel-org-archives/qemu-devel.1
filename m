Return-Path: <SRS0=zEF8=7V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 738EFC433DF
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2020 11:44:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3B7D32074B
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2020 11:44:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nuviainc-com.20150623.gappssmtp.com header.i=@nuviainc-com.20150623.gappssmtp.com header.b="xL+R7nqn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B7D32074B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=nuviainc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40214 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jiGCA-000479-Hl
	for qemu-devel@archiver.kernel.org; Mon, 08 Jun 2020 07:44:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33540)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leif@nuviainc.com>) id 1jiG8q-00089H-5t
 for qemu-devel@nongnu.org; Mon, 08 Jun 2020 07:40:36 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:38596)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <leif@nuviainc.com>) id 1jiG8p-0003dC-4e
 for qemu-devel@nongnu.org; Mon, 08 Jun 2020 07:40:35 -0400
Received: by mail-wr1-x444.google.com with SMTP id e1so17038965wrt.5
 for <qemu-devel@nongnu.org>; Mon, 08 Jun 2020 04:40:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=nuviainc-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=r1862+GaCeD5wjtcdsVBrJdgJrDEKBNZHNQ90XZwnrY=;
 b=xL+R7nqnPTn/XmS1NNzKgIxtOkDDz4dJJViyl137ms4PuuS1x+jwT+qYCzLwpuVmkh
 w87WTK5XyCQmQDoMxJE1gq+JJ74iTkJjf+rMKoHyOXXwW2xgYUrr486S3XQ8fKeUGPnO
 YzJ5BXLLxLy5eHuv0XKiUnmMKKN7xQOvhblxV4CWXzRxwPqDGhaG1xGsqeWdbpbApRRA
 +/hpl/WCuMQ5HyuGd9qfm+AwWm47a3iZUGOIH8lYbRj4/r+sJXM0iO6054yNkUd0Lvhz
 DEjqubtxD165ZEt0l6BvupxQ4m481ZrO4S3JJK99K8omRFg/CRwtDrCQssM9eiPln5Ru
 HUfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=r1862+GaCeD5wjtcdsVBrJdgJrDEKBNZHNQ90XZwnrY=;
 b=Yk20tZHrQPW8Lboc0JuMwWOP56VDtceAsPvDZpDj/zMoLzQVZsYObLOjg8XpALYi7z
 YfxzJyyLy7nGTvMHpaRXC/E+CSzs4gSN4ClwVoss0Gpzsm2k9G2SD3Gi3/Bp12EnF/+M
 1nZRNLkVWqWmXT+G5SuVpIQaAAsAnT4i1XbhDvL20KnkWvH1p89SMVMaUlkeF6qzm0Z9
 qk98eu1vnY/vdRMhUXAz8XHAC0Goz6EyF9S/UGScu8+EZd7S87+puHxdVxiOLkZ3P6d6
 GGleHuQjAl+JI7JQwAd84Iw0QkIPZudgVH3iPsFiQBP7V1kI2z/fvYpthWsoLToup46l
 I3lA==
X-Gm-Message-State: AOAM530v9jwYOCcHnZVnS82w11wzt53hTtjWuh50QJ/2mm4wekB2ZupT
 JbE0jpp918Kt0RwbMRxvM/fLou98HYNeej0sciFI+uTHNOKF/Gvlbwd/9eeuUmVUzvv94+JZOHa
 x3vw4SXcN43KXlnFymnuFgoG2BFFFWiIRD1pb8N/ugW2uUPkyJ5+AYldA7h3A2fT0
X-Google-Smtp-Source: ABdhPJxTEBq4LZ7/2n16NwtEvJrSIRfstjgLkoL67I6PwvF+70dg08ykyAsGpMkStBub8lEYkhli6g==
X-Received: by 2002:a05:6000:1c7:: with SMTP id
 t7mr22944357wrx.14.1591616433083; 
 Mon, 08 Jun 2020 04:40:33 -0700 (PDT)
Received: from vanye.hemma.eciton.net
 (cpc92302-cmbg19-2-0-cust304.5-4.cable.virginm.net. [82.1.209.49])
 by smtp.gmail.com with ESMTPSA id y5sm24225932wrs.63.2020.06.08.04.40.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Jun 2020 04:40:32 -0700 (PDT)
From: Leif Lindholm <leif@nuviainc.com>
To: QEMU Developers <qemu-devel@nongnu.org>
Subject: [RFC PATCH 3/3] target/arm: use cortex...common_init for cpu64 max
Date: Mon,  8 Jun 2020 12:40:28 +0100
Message-Id: <20200608114028.25345-4-leif@nuviainc.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200608114028.25345-1-leif@nuviainc.com>
References: <20200608114028.25345-1-leif@nuviainc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::444;
 envelope-from=leif@nuviainc.com; helo=mail-wr1-x444.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Andrew Jones <drjones@redhat.com>,
 qemu-arm@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Drop the call to aarch64_a57_initfn from aarch64_max_initfn, replacing it
with calls to aarch64_cpu_common_init and cortex_a72_a57_a53_common_init.

Cache and GIC configuration is now set directly, using aarch64_a72_initfn
as a template.
Set cpu->dtb_compatible to "qemu,aarch64-max".

This has the following effects apart from the ones mentioned above:
- kvm_target will no longer be explicitly initialized for cpu max in tcg
  mode.
- id_mmfr0 will now be set to an architecturally permitted value.
- define_arm_cp_regs() is no longer called, since those registers are
  implementation defined and specific to the supported cortex-a
  processors.

Signed-off-by: Leif Lindholm <leif@nuviainc.com>
---
 target/arm/cpu64.c | 24 +++++++++++++++---------
 1 file changed, 15 insertions(+), 9 deletions(-)

diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
index 9927c1f75d..452efe78bf 100644
--- a/target/arm/cpu64.c
+++ b/target/arm/cpu64.c
@@ -561,26 +561,20 @@ static void aarch64_max_initfn(Object *obj)
     } else {
         uint64_t t;
         uint32_t u;
-        aarch64_a57_initfn(obj);
 
+        cpu->dtb_compatible = "qemu,aarch64-max";
         /*
          * Reset MIDR so the guest doesn't mistake our 'max' CPU type for a real
          * one and try to apply errata workarounds or use impdef features we
          * don't provide.
          * An IMPLEMENTER field of 0 means "reserved for software use";
-         * ARCHITECTURE must be 0xf indicating "v7 or later, check ID registers
-         * to see which features are present";
          * the VARIANT, PARTNUM and REVISION fields are all implementation
          * defined and we choose to define PARTNUM just in case guest
          * code needs to distinguish this QEMU CPU from other software
          * implementations, though this shouldn't be needed.
          */
-        t = FIELD_DP64(0, MIDR_EL1, IMPLEMENTER, 0);
-        t = FIELD_DP64(t, MIDR_EL1, ARCHITECTURE, 0xf);
-        t = FIELD_DP64(t, MIDR_EL1, PARTNUM, 'Q');
-        t = FIELD_DP64(t, MIDR_EL1, VARIANT, 0);
-        t = FIELD_DP64(t, MIDR_EL1, REVISION, 0);
-        cpu->midr = t;
+        aarch64_cpu_common_init(obj, 0, 'Q', 0, 0);
+        cortex_a72_a57_a53_common_init(cpu);
 
         t = cpu->isar.id_aa64isar0;
         t = FIELD_DP64(t, ID_AA64ISAR0, AES, 2); /* AES + PMULL */
@@ -680,12 +674,24 @@ static void aarch64_max_initfn(Object *obj)
          * and enabling SVE in system mode is more useful in the short term.
          */
 
+        cpu->reset_fpsid = 0x41034080;
+        cpu->clidr = 0x0a200023;
+        cpu->ccsidr[0] = 0x701fe00a; /* 32KB L1 dcache */
+        cpu->ccsidr[1] = 0x201fe012; /* 48KB L1 icache */
+        cpu->ccsidr[2] = 0x707fe07a; /* 1MB L2 cache */
+        cpu->gic_num_lrs = 4;
+        cpu->gic_vpribits = 5;
+        cpu->gic_vprebits = 5;
+
 #ifdef CONFIG_USER_ONLY
         /* For usermode -cpu max we can use a larger and more efficient DCZ
          * blocksize since we don't have to follow what the hardware does.
          */
         cpu->ctr = 0x80038003; /* 32 byte I and D cacheline size, VIPT icache */
         cpu->dcz_blocksize = 7; /*  512 bytes */
+#else
+        cpu->ctr = 0x8444c004;
+        cpu->dcz_blocksize = 4; /* 64 bytes */
 #endif
     }
 
-- 
2.20.1


