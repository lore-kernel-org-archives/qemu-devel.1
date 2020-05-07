Return-Path: <SRS0=s5cl=6V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99A2CC47257
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2020 05:09:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 63F6020838
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2020 05:09:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="G9ommfMx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 63F6020838
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60596 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jWYms-0000kC-FT
	for qemu-devel@archiver.kernel.org; Thu, 07 May 2020 01:09:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33606)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1jWYi1-0007nl-9r; Thu, 07 May 2020 01:04:33 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:50971 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1jWYi0-0007vZ-B0; Thu, 07 May 2020 01:04:32 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 49HhFq2BXHz9sTP; Thu,  7 May 2020 15:04:15 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1588827855;
 bh=Ac2LtnCm9+Y0a7siK0TCtnW7xvh2oSg1c3KoRJWx+N8=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=G9ommfMx7trhkQ+k6/OxseAhFdU7FvrCa3kXEhYJM4MQtLY+5VEQShKFEwUT1J7RS
 ZdquzWteoEe7+V1TFpPThPN2NtiTyW30nHOuQ8UglyQqqofAFVJmN2+bfwPDCLUV5e
 igl9AEN+chTpVRl8Nia3GK5hhTwEWo/wmkDL9BpI=
From: David Gibson <david@gibson.dropbear.id.au>
To: peter.maydell@linaro.org
Subject: [PULL 16/18] spapr_nvdimm.c: make 'label-size' mandatory
Date: Thu,  7 May 2020 15:02:26 +1000
Message-Id: <20200507050228.802395-17-david@gibson.dropbear.id.au>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200507050228.802395-1-david@gibson.dropbear.id.au>
References: <20200507050228.802395-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=203.11.71.1; envelope-from=dgibson@ozlabs.org;
 helo=ozlabs.org
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/07 01:04:14
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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
Cc: aik@ozlabs.ru, Daniel Henrique Barboza <danielhb413@gmail.com>,
 qemu-devel@nongnu.org, npiggin@gmail.com, groug@kaod.org, qemu-ppc@nongnu.org,
 clg@kaod.org, David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Daniel Henrique Barboza <danielhb413@gmail.com>

The pseries machine does not support NVDIMM modules without label.
Attempting to do so, even if the overall block size is aligned with
256MB, will seg fault the guest kernel during NVDIMM probe. This
can be avoided by forcing 'label-size' to always be present for
sPAPR NVDIMMs.

The verification was put before the alignment check because the
presence of label-size affects the alignment calculation, so
it's not optimal to warn the user about an alignment error,
then about the lack of label-size, then about a new alignment
error when the user sets a label-size.

Signed-off-by: Daniel Henrique Barboza <danielhb413@gmail.com>
Message-Id: <20200413203628.31636-1-danielhb413@gmail.com>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/spapr_nvdimm.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/hw/ppc/spapr_nvdimm.c b/hw/ppc/spapr_nvdimm.c
index 25be8082d7..9abcdcc26b 100644
--- a/hw/ppc/spapr_nvdimm.c
+++ b/hw/ppc/spapr_nvdimm.c
@@ -37,6 +37,12 @@ void spapr_nvdimm_validate_opts(NVDIMMDevice *nvdimm, uint64_t size,
     QemuUUID uuid;
     int ret;
 
+    if (object_property_get_int(OBJECT(nvdimm), NVDIMM_LABEL_SIZE_PROP,
+                                &error_abort) == 0) {
+        error_setg(errp, "NVDIMM device requires label-size to be set");
+        return;
+    }
+
     if (size % SPAPR_MINIMUM_SCM_BLOCK_SIZE) {
         error_setg(errp, "NVDIMM memory size excluding the label area"
                    " must be a multiple of %" PRIu64 "MB",
-- 
2.26.2


