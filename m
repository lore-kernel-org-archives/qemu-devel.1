Return-Path: <SRS0=EIn8=4Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7139FC3F2D2
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2020 16:40:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 37D6420732
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2020 16:40:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nM4d+fck"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 37D6420732
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50138 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j7igG-0000hm-C8
	for qemu-devel@archiver.kernel.org; Fri, 28 Feb 2020 11:40:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56399)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j7if4-0007Ei-8B
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 11:38:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j7if3-0001nR-0M
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 11:38:50 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334]:40083)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j7if2-0001my-QH
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 11:38:48 -0500
Received: by mail-wm1-x334.google.com with SMTP id d138so2302924wmd.5
 for <qemu-devel@nongnu.org>; Fri, 28 Feb 2020 08:38:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=A5mwcI/ZKfr3Tx2KU66kVPbnF23MRJiSSiyB+hKM2CQ=;
 b=nM4d+fcknakBsqL9wyxhzJT2RzyVjLOGS2qg/4JqBsOAh82YqanlOr51BWUbEBceEz
 eq5T5m7uuryLQOaPUFORQIccCk2yG/1jQuMnenT8HKyBl+f6CaCx980uxkkq6fF3mKTO
 dH/W7qejJdrRLq5phLA6zVgOuVT4TI0nRsuHV5E7uhXbkINPEzifQRw45vBWrH1bYvfJ
 HVb/k3oyzSwkSxtLH8QxUZPN3YYsbyG241SvuXq09Mv3+xyAki0nyL99z32jlIx1hoPj
 rckezZavDsA7OQYalPesDckOZS2fbRtb7Y4nS1AMh/XZhcUegr9iNsd0ME9S8GiG4Rej
 yyqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=A5mwcI/ZKfr3Tx2KU66kVPbnF23MRJiSSiyB+hKM2CQ=;
 b=XhD9rF2bV6fP+wmhbGNUNpzIQTmtJgQoTPtpVglOubf1eMoD6FLTWzkRfWZTTf2PSS
 N1Qfx1gvEJOwkzZc6Vs1lacLmkibX84RVb3dcjnzu2gmQnKdJ4YCZu4fDANA/yICpWMQ
 RGhZj+OZaUO+aYWaT9EnvOuxy7tqX7tiO3aS/Hy4g6KvXwAn7rljNEvXpuNDSdqtYsrV
 a/m7St2qQ2FKDyCO0n+VKovuH6E852XuFh6i+vdE37Qzx+tOScss2BLe1EzJ42fSLKeD
 3MJBMqEtd7GXMjwrmaUan7ivqQzssY3+jgiokXgmVQ8oCPaRpL1MNTGE60dP5bHHSJEg
 Az5w==
X-Gm-Message-State: APjAAAUZzGATT2v10HVi9ZMHHbRRQZAI9OCqUe7NwaHLu3l07m0xhWYf
 UArB6XFNBgmlH1N0ZuP7apsZMYrMXMZ6uA==
X-Google-Smtp-Source: APXvYqzu/nX+vUqm+o7lq7cOBxBXzkS6R7+0elAYGTOeBvXadvnOwFlnWqwYmIO0ps65jlZ6wwTUWQ==
X-Received: by 2002:a7b:cbcf:: with SMTP id n15mr5572752wmi.21.1582907927354; 
 Fri, 28 Feb 2020 08:38:47 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id c9sm13335214wrq.44.2020.02.28.08.38.46
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Feb 2020 08:38:46 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 04/33] arm_gic: Mask the un-supported priority bits
Date: Fri, 28 Feb 2020 16:38:11 +0000
Message-Id: <20200228163840.23585-5-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200228163840.23585-1-peter.maydell@linaro.org>
References: <20200228163840.23585-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::334
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

From: Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>

The GICv2 allows the implementation to implement a variable number
of priority bits; unimplemented bits in the priority registers
are read as zeros, writes ignored. We were previously always
implementing a full 8 bits of priority, which is allowed but not
what the real hardware typically does (which is usually to have
4 or 5 bits of priority).

Add a new device property to allow the number of implemented
property bits to be specified.

Signed-off-by: Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>
Message-id: 1582537164-764-2-git-send-email-sai.pavan.boddu@xilinx.com
Suggested-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
[PMM: improved commit message]
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/intc/arm_gic.h        |  2 ++
 include/hw/intc/arm_gic_common.h |  1 +
 hw/intc/arm_gic.c                | 33 ++++++++++++++++++++++++++++++--
 hw/intc/arm_gic_common.c         |  1 +
 4 files changed, 35 insertions(+), 2 deletions(-)

diff --git a/include/hw/intc/arm_gic.h b/include/hw/intc/arm_gic.h
index ed703a17203..303b9748cbb 100644
--- a/include/hw/intc/arm_gic.h
+++ b/include/hw/intc/arm_gic.h
@@ -68,6 +68,8 @@
 
 /* Number of SGI target-list bits */
 #define GIC_TARGETLIST_BITS 8
+#define GIC_MAX_PRIORITY_BITS 8
+#define GIC_MIN_PRIORITY_BITS 4
 
 #define TYPE_ARM_GIC "arm_gic"
 #define ARM_GIC(obj) \
diff --git a/include/hw/intc/arm_gic_common.h b/include/hw/intc/arm_gic_common.h
index b5585fec451..6e0d6b8a889 100644
--- a/include/hw/intc/arm_gic_common.h
+++ b/include/hw/intc/arm_gic_common.h
@@ -96,6 +96,7 @@ typedef struct GICState {
     uint16_t priority_mask[GIC_NCPU_VCPU];
     uint16_t running_priority[GIC_NCPU_VCPU];
     uint16_t current_pending[GIC_NCPU_VCPU];
+    uint32_t n_prio_bits;
 
     /* If we present the GICv2 without security extensions to a guest,
      * the guest can configure the GICC_CTLR to configure group 1 binary point
diff --git a/hw/intc/arm_gic.c b/hw/intc/arm_gic.c
index 1d7da7baa20..c60dc6b5e6e 100644
--- a/hw/intc/arm_gic.c
+++ b/hw/intc/arm_gic.c
@@ -641,6 +641,23 @@ uint32_t gic_acknowledge_irq(GICState *s, int cpu, MemTxAttrs attrs)
     return ret;
 }
 
+static uint32_t gic_fullprio_mask(GICState *s, int cpu)
+{
+    /*
+     * Return a mask word which clears the unimplemented priority
+     * bits from a priority value for an interrupt. (Not to be
+     * confused with the group priority, whose mask depends on BPR.)
+     */
+    int priBits;
+
+    if (gic_is_vcpu(cpu)) {
+        priBits = GIC_VIRT_MAX_GROUP_PRIO_BITS;
+    } else {
+        priBits = s->n_prio_bits;
+    }
+    return ~0U << (8 - priBits);
+}
+
 void gic_dist_set_priority(GICState *s, int cpu, int irq, uint8_t val,
                       MemTxAttrs attrs)
 {
@@ -651,6 +668,8 @@ void gic_dist_set_priority(GICState *s, int cpu, int irq, uint8_t val,
         val = 0x80 | (val >> 1); /* Non-secure view */
     }
 
+    val &= gic_fullprio_mask(s, cpu);
+
     if (irq < GIC_INTERNAL) {
         s->priority1[irq][cpu] = val;
     } else {
@@ -669,7 +688,7 @@ static uint32_t gic_dist_get_priority(GICState *s, int cpu, int irq,
         }
         prio = (prio << 1) & 0xff; /* Non-secure view */
     }
-    return prio;
+    return prio & gic_fullprio_mask(s, cpu);
 }
 
 static void gic_set_priority_mask(GICState *s, int cpu, uint8_t pmask,
@@ -684,7 +703,7 @@ static void gic_set_priority_mask(GICState *s, int cpu, uint8_t pmask,
             return;
         }
     }
-    s->priority_mask[cpu] = pmask;
+    s->priority_mask[cpu] = pmask & gic_fullprio_mask(s, cpu);
 }
 
 static uint32_t gic_get_priority_mask(GICState *s, int cpu, MemTxAttrs attrs)
@@ -2055,6 +2074,16 @@ static void arm_gic_realize(DeviceState *dev, Error **errp)
         return;
     }
 
+    if (s->n_prio_bits > GIC_MAX_PRIORITY_BITS ||
+       (s->virt_extn ? s->n_prio_bits < GIC_VIRT_MAX_GROUP_PRIO_BITS :
+        s->n_prio_bits < GIC_MIN_PRIORITY_BITS)) {
+        error_setg(errp, "num-priority-bits cannot be greater than %d"
+                   " or less than %d", GIC_MAX_PRIORITY_BITS,
+                   s->virt_extn ? GIC_VIRT_MAX_GROUP_PRIO_BITS :
+                   GIC_MIN_PRIORITY_BITS);
+        return;
+    }
+
     /* This creates distributor, main CPU interface (s->cpuiomem[0]) and if
      * enabled, virtualization extensions related interfaces (main virtual
      * interface (s->vifaceiomem[0]) and virtual CPU interface).
diff --git a/hw/intc/arm_gic_common.c b/hw/intc/arm_gic_common.c
index e6c4fe7a5a4..7b44d5625b6 100644
--- a/hw/intc/arm_gic_common.c
+++ b/hw/intc/arm_gic_common.c
@@ -357,6 +357,7 @@ static Property arm_gic_common_properties[] = {
     DEFINE_PROP_BOOL("has-security-extensions", GICState, security_extn, 0),
     /* True if the GIC should implement the virtualization extensions */
     DEFINE_PROP_BOOL("has-virtualization-extensions", GICState, virt_extn, 0),
+    DEFINE_PROP_UINT32("num-priority-bits", GICState, n_prio_bits, 8),
     DEFINE_PROP_END_OF_LIST(),
 };
 
-- 
2.20.1


