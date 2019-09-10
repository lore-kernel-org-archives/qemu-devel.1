Return-Path: <SRS0=PbUj=XF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D113C49ED6
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 09:58:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EB8A92067B
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 09:58:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MHABNx7D"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB8A92067B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37058 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i7cuV-0001ND-U3
	for qemu-devel@archiver.kernel.org; Tue, 10 Sep 2019 05:58:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50766)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <beata.michalska@linaro.org>) id 1i7ct0-0008P8-PW
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 05:56:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <beata.michalska@linaro.org>) id 1i7csz-0002Xf-LQ
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 05:56:34 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:33382)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <beata.michalska@linaro.org>)
 id 1i7csz-0002X6-Fs
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 05:56:33 -0400
Received: by mail-wr1-x444.google.com with SMTP id u16so18897042wrr.0
 for <qemu-devel@nongnu.org>; Tue, 10 Sep 2019 02:56:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=V8rbWEWlHyHd4UbRaLskqjLUrYsGkHiX8TMo3VrUG1s=;
 b=MHABNx7DC1/9SGQ/iNb/c4Dte1b/++/wKMVMg8NIdcJVi0cLj517karVPxy6+Oc4eA
 YObSxH1pfn7gVTBaVjWWJlOWpueDwr+CyvAfxdMqoPajh0Tl4DMj5TPNZeP9zXU1bF/5
 keKzi/I/CGz6Uo9BCdEqly97R3w5TUXAzM2FwXQ8rzO784ExZV7E8XkzWZzldm2CMA2I
 xc7Aqf2x0jBsFjrvODEAA+pYfL1sOuwfpZSM+4olFXGDxm5d1eN3xjSr46Avrm7Jp1MW
 MIAOfVxbbK2pv8UEjFEYtnBzs9/oXpFlSyX2QVypvbhL4Cp+laFAYs8I7gfH4raERacn
 pNKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=V8rbWEWlHyHd4UbRaLskqjLUrYsGkHiX8TMo3VrUG1s=;
 b=Ge7Iy8w/rLJg8Wq0kIDFdoL62X46ng1aMMKMhTTnvPmnYx6AYZ+ePnLHzx578BiBKw
 gB6shkkK3IgkYv9+MHBT5mwAV3eYfzEkXomoGj+RIvtHc/xTfoHXImiZ8LC84oyicI5C
 t7VijwlN4DVKWRMD3eAiJZC0Nzqm04sDQ7JPxO6FamgExezTL7O1nLq93SB00WrVf4CY
 AY9EwJ6vH3XiTyCw4r0DePn1ARq9S6kbjOT0ezgqjrEZUlQtD5ymcVRgVhb/Ia5YDBuY
 w7yoRPSLl7fvk3TFjnAcIk5mLlEYoFGvA3V8YdQtwCq/I2HNMhbqTJ5Tklf998zA23Gd
 qRZg==
X-Gm-Message-State: APjAAAUHCjofJWVpLi7ti87N91pCM+DFxKZ5X/P4GxEp1UPoJZLqxJVD
 RK5qfC/wf53TToGUATEkltKn/ZVXjbrFcw==
X-Google-Smtp-Source: APXvYqwg3AXsD02hm5Ty4zNk5Ux9pNgo/7utw4vI1Y476GoPt7vIaiHCepvkDYXDl1Sf4h3LfoArjA==
X-Received: by 2002:adf:a4c8:: with SMTP id h8mr25265331wrb.293.1568109392396; 
 Tue, 10 Sep 2019 02:56:32 -0700 (PDT)
Received: from moi-XPS-13-9350.arm.com
 (host86-144-13-57.range86-144.btcentralplus.com. [86.144.13.57])
 by smtp.gmail.com with ESMTPSA id e30sm32403540wra.48.2019.09.10.02.56.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Sep 2019 02:56:31 -0700 (PDT)
From: Beata Michalska <beata.michalska@linaro.org>
To: qemu-devel@nongnu.org
Date: Tue, 10 Sep 2019 11:56:07 +0200
Message-Id: <20190910095610.4546-2-beata.michalska@linaro.org>
In-Reply-To: <20190910095610.4546-1-beata.michalska@linaro.org>
References: <20190910095610.4546-1-beata.michalska@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::444
Subject: [Qemu-devel] [PATCH 1/4] tcg: cputlb: Add probe_read
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
Cc: peter.maydell@linaro.org, Beata Michalska <beata.michalska@linaro.org>,
 quintela@redhat.com, richard.henderson@linaro.org, dgilbert@redhat.com,
 shameerali.kolothum.thodi@huawei.com, eric.auger@redhat.com,
 qemu-arm@nongnu.org, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Add probe_read alongside the write probing equivalent.

Signed-off-by: Beata Michalska <beata.michalska@linaro.org>
---
 include/exec/exec-all.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/include/exec/exec-all.h b/include/exec/exec-all.h
index 81b02eb2fe..e1785700c3 100644
--- a/include/exec/exec-all.h
+++ b/include/exec/exec-all.h
@@ -319,6 +319,12 @@ static inline void *probe_write(CPUArchState *env, target_ulong addr, int size,
     return probe_access(env, addr, size, MMU_DATA_STORE, mmu_idx, retaddr);
 }
 
+static inline void *probe_read(CPUArchState *env, target_ulong addr, int size,
+                               int mmu_idx, uintptr_t retaddr)
+{
+    return probe_access(env, addr, size, MMU_DATA_LOAD, mmu_idx, retaddr);
+}
+
 #define CODE_GEN_ALIGN           16 /* must be >= of the size of a icache line */
 
 /* Estimated block size for TB allocation.  */
-- 
2.17.1


