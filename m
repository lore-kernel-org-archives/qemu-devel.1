Return-Path: <SRS0=sZ46=CY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28E9DC43461
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 03:17:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 90DB820672
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 03:17:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lReM+xXe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 90DB820672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37056 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kI1TK-0000Hk-Di
	for qemu-devel@archiver.kernel.org; Mon, 14 Sep 2020 23:17:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48038)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <haibo.xu@linaro.org>)
 id 1kI1O8-0000H8-MJ
 for qemu-devel@nongnu.org; Mon, 14 Sep 2020 23:12:12 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f]:44472)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <haibo.xu@linaro.org>)
 id 1kI1O6-0001h4-5U
 for qemu-devel@nongnu.org; Mon, 14 Sep 2020 23:12:12 -0400
Received: by mail-pf1-x42f.google.com with SMTP id o20so1089544pfp.11
 for <qemu-devel@nongnu.org>; Mon, 14 Sep 2020 20:12:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=9QKIG2CP5FsAJO1K1yLLKcM8WhKJpvUJh/YJzIciQaE=;
 b=lReM+xXelGsNPF4vWL0t5TX+kwVrfj1L95xQ0vopMAc4L0dPqxD7n6zkpBUwiV/Dz3
 22euqP3i6uymqRzuL3XM1y/J5AfJDdY15Bx7nmzor2pTp1fd/bOFSm3Ei8hZs1SN+pbB
 iVcRL/FbS7DT+dhaFvy6SfnWXrp+s2UZRlA+rZnGvd+GJ3IXM2pTPCJbZltuRHDouEBm
 M8hL1vF4+al0ND+0T0vP/yjpM9Blpwkp9wXUnYYbCJD2JqxUHE0h3Xt1m/95xyCWuz+f
 Ifiit+RPZYHGPrL6MnXkCODG1XsNnoti8rMfNa3GpTrQhn275mxR+7o7DNGJ2//FEBeo
 6kwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=9QKIG2CP5FsAJO1K1yLLKcM8WhKJpvUJh/YJzIciQaE=;
 b=Hs2rhEem0hMv9+2okDJxtd9r26xbklnUIiHGgdXdEzBO12rbErt1EY4sbMXdoa7pge
 s58J7CnQ6DfDqwr+5jfsqx2LV8dVjLzqE4hdZ/vsZhcfOgwqBFQ5NWE9VojTZW4BK5zm
 7IXBG/JAWACgtTjb9lcqgtOZBTy4/HTR61QSo9r93FQTk6fq1Ag5Q4EhwuN35usfjbxp
 FQvYifwm4d7qDohkEFqw4+ziwlu+Dthaqy21YJiS66r1O3qgABpShqrN8PVwIeCgLQOv
 ywSlPrTygZzcOuZRngz1rfWU5JX8G/bzpU+fvWELcP8S8x7maYV8f3YEF18yjHsrivW+
 Bnjg==
X-Gm-Message-State: AOAM531bnf+L/ocngyynoxgYSKsvZVFe/FhwgICJmNmiLsgfr6aZsqZh
 Dn6XYg6eqUhPAFM2ge3Sehktk0BIBzqA5BU=
X-Google-Smtp-Source: ABdhPJwzcELHdUBZj0OKiWALwi4hE/VYrFhdNnfmm1roO/9PdowVnggBaW3eqXLDeuZO+qm9o/A9YA==
X-Received: by 2002:a63:5043:: with SMTP id q3mr12880104pgl.293.1600139528926; 
 Mon, 14 Sep 2020 20:12:08 -0700 (PDT)
Received: from localhost.localdomain ([147.75.106.138])
 by smtp.gmail.com with ESMTPSA id g23sm11551776pfh.133.2020.09.14.20.12.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Sep 2020 20:12:08 -0700 (PDT)
From: Haibo Xu <haibo.xu@linaro.org>
To: drjones@redhat.com,
	richard.henderson@linaro.org
Subject: [PATCH v3 04/12] target/arm: spe: Only enable SPE from 5.2 compat
 machines.
Date: Tue, 15 Sep 2020 03:11:40 +0000
Message-Id: <6d88497a83105b3317bb39ce26d763b729a426eb.1600135462.git.haibo.xu@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1600135462.git.haibo.xu@linaro.org>
References: <cover.1600135462.git.haibo.xu@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=haibo.xu@linaro.org; helo=mail-pf1-x42f.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org, philmd@redhat.com,
 qemu-devel@nongnu.org, Haibo Xu <haibo.xu@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Reviewed-by: Andrew Jones <drjones@redhat.com>
Signed-off-by: Haibo Xu <haibo.xu@linaro.org>
---
 hw/arm/virt.c         | 7 +++++++
 include/hw/arm/virt.h | 1 +
 2 files changed, 8 insertions(+)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index acf9bfbece..3f6d26c531 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -1830,6 +1830,10 @@ static void machvirt_init(MachineState *machine)
             object_property_set_bool(cpuobj, "pmu", false, NULL);
         }
 
+        if (vmc->no_spe && object_property_find(cpuobj, "spe", NULL)) {
+            object_property_set_bool(cpuobj, "spe", false, NULL);
+        }
+
         if (object_property_find(cpuobj, "reset-cbar", NULL)) {
             object_property_set_int(cpuobj, "reset-cbar",
                                     vms->memmap[VIRT_CPUPERIPHS].base,
@@ -2553,8 +2557,11 @@ DEFINE_VIRT_MACHINE_AS_LATEST(5, 2)
 
 static void virt_machine_5_1_options(MachineClass *mc)
 {
+    VirtMachineClass *vmc = VIRT_MACHINE_CLASS(OBJECT_CLASS(mc));
+
     virt_machine_5_2_options(mc);
     compat_props_add(mc->compat_props, hw_compat_5_1, hw_compat_5_1_len);
+    vmc->no_spe = true;
 }
 DEFINE_VIRT_MACHINE(5, 1)
 
diff --git a/include/hw/arm/virt.h b/include/hw/arm/virt.h
index dff67e1bef..72c269aaa5 100644
--- a/include/hw/arm/virt.h
+++ b/include/hw/arm/virt.h
@@ -126,6 +126,7 @@ typedef struct {
     bool no_ged;   /* Machines < 4.2 has no support for ACPI GED device */
     bool kvm_no_adjvtime;
     bool acpi_expose_flash;
+    bool no_spe;
 } VirtMachineClass;
 
 typedef struct {
-- 
2.17.1


