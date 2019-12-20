Return-Path: <SRS0=uEni=2K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0991C43603
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2019 14:28:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9C81E206A5
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2019 14:28:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NV0jlGRe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C81E206A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57116 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iiJGj-0006vx-Bc
	for qemu-devel@archiver.kernel.org; Fri, 20 Dec 2019 09:28:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41078)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iiJF5-0004sB-Ul
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 09:27:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iiJF4-0007L0-L8
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 09:26:59 -0500
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333]:51927)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iiJF4-0007HC-87
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 09:26:58 -0500
Received: by mail-wm1-x333.google.com with SMTP id d73so9139592wmd.1
 for <qemu-devel@nongnu.org>; Fri, 20 Dec 2019 06:26:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=GrBrv5e7u4SPBOvAwKw188o0mEz5dyTHcixqY4buFoM=;
 b=NV0jlGRe/1uoQSkWmTIsoO9O/PriK86L0iIm9x6RwdDXfFiPcW4Fx40c0/GLtfI1s3
 irkg3K865O409QXT9F9q4coKg80QAAhGHa3adWnmue5/9nsu+TLkbu6Yr8Gl5b8HEJjq
 9oh2fbI1cr+013vu9ihVLh9DJtzizjDRBWNHrfkCbaGCitdolI/xZVKQQGlS8nIVQzyB
 mv2ieWG85YZ1nZWcVzxDfFoVpaz1lib35jVs4bQa17NCjS/UuMBmQMlmV/Oh/4xVHJ67
 jQ2tv90JwCTjEWoUWSXienW7UDsWT5OSGFDd5zerexVYo9tbpnO9kwdjE82IWnew8YSh
 WnOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=GrBrv5e7u4SPBOvAwKw188o0mEz5dyTHcixqY4buFoM=;
 b=Une1NiQqONHMdW45nMuxQMpmgQeQNBp1oZaZCCW3obUiznMAEEbLqBoKRB4Fd4D/UG
 unY9RSobba0HTh4FC2CypV2XAj+NfgwBIwxQ8JgrUSoDBcU+LgGGZM3RCjL3QzRa93rc
 4Isn98cht3ErgtIfgCkNOrKCW2O1sStUYAG29aG2IWyn9wYy9op3AjmfpT6HnILjmgy+
 wiOwNtdCT+3tg3ESJiZ5R9PxbEQhM4sgAMeSuEqsDyUt0vr0jwYV8JTgBYS0LdXEqnPr
 I/V4SZk1xjty3kPSjMiAojITze/2iZRm/CUnXK6IPlaLX8+xS1X8csIs/qQKaSuk7lNr
 0DLg==
X-Gm-Message-State: APjAAAUxnqNJToeSR4g0P62r+ag7iAVU74FVzB86KVtrwJmXGSkdR8dt
 Bj/J7jkXnERy6IvO0GR13Cw2TFSfLSjEVQ==
X-Google-Smtp-Source: APXvYqzRDo/gUfdnTtCzQDyY/6wj+HEM0q9Z08uflyCfsBRj7Yyt1Ev3es6RGI9ByVmbD1SIxeU69A==
X-Received: by 2002:a1c:5f06:: with SMTP id t6mr16980412wmb.32.1576852016995; 
 Fri, 20 Dec 2019 06:26:56 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id t5sm9741814wrr.35.2019.12.20.06.26.55
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Dec 2019 06:26:55 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 07/12] hw/arm/smmuv3: Check stream IDs against actual table
 LOG2SIZE
Date: Fri, 20 Dec 2019 14:26:39 +0000
Message-Id: <20191220142644.31076-8-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191220142644.31076-1-peter.maydell@linaro.org>
References: <20191220142644.31076-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::333
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

From: Simon Veith <sveith@amazon.de>

When checking whether a stream ID is in range of the stream table, we
have so far been only checking it against our implementation limit
(SMMU_IDR1_SIDSIZE). However, the guest can program the
STRTAB_BASE_CFG.LOG2SIZE field to a size that is smaller than this
limit.

Check the stream ID against this limit as well to match the hardware
behavior of raising C_BAD_STREAMID events in case the limit is exceeded.
Also, ensure that we do not go one entry beyond the end of the table by
checking that its index is strictly smaller than the table size.

ref. ARM IHI 0070C, section 6.3.24.

Signed-off-by: Simon Veith <sveith@amazon.de>
Acked-by: Eric Auger <eric.auger@redhat.com>
Tested-by: Eric Auger <eric.auger@redhat.com>
Message-id: 1576509312-13083-4-git-send-email-sveith@amazon.de
Cc: Eric Auger <eric.auger@redhat.com>
Cc: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/smmuv3.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
index eef9a18d70f..727558bcfa5 100644
--- a/hw/arm/smmuv3.c
+++ b/hw/arm/smmuv3.c
@@ -377,11 +377,15 @@ static int smmu_find_ste(SMMUv3State *s, uint32_t sid, STE *ste,
                          SMMUEventInfo *event)
 {
     dma_addr_t addr;
+    uint32_t log2size;
     int ret;
 
     trace_smmuv3_find_ste(sid, s->features, s->sid_split);
-    /* Check SID range */
-    if (sid > (1 << SMMU_IDR1_SIDSIZE)) {
+    log2size = FIELD_EX32(s->strtab_base_cfg, STRTAB_BASE_CFG, LOG2SIZE);
+    /*
+     * Check SID range against both guest-configured and implementation limits
+     */
+    if (sid >= (1 << MIN(log2size, SMMU_IDR1_SIDSIZE))) {
         event->type = SMMU_EVT_C_BAD_STREAMID;
         return -EINVAL;
     }
-- 
2.20.1


