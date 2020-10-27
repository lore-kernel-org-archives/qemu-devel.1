Return-Path: <SRS0=gwGE=EC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31A24C55178
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 14:43:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8D9BD20773
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 14:43:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="T8RSLp6X"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D9BD20773
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36000 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXQBt-0007kN-G8
	for qemu-devel@archiver.kernel.org; Tue, 27 Oct 2020 10:43:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42488)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1kXPnc-00029Z-1l; Tue, 27 Oct 2020 10:18:08 -0400
Received: from ozlabs.org ([203.11.71.1]:57891)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1kXPna-0007bN-68; Tue, 27 Oct 2020 10:18:07 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 4CLDLq6JM0z9shv; Wed, 28 Oct 2020 01:17:54 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1603808275;
 bh=X+kMfZmLTIB0C7yJqNGy2oI7Q3ouV2Gt6nNn3T3aoss=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=T8RSLp6XPkFRHF5KpSB893Aos3FXCz4/DyqhA2jJwTulT9jtgaGJpU+UlUCrIBpwZ
 uAqHjNqDwS3sgxAN6tcpF5euOTIGE/svfvpHtF8AD/Fc+AfBCAKvGIQl/AdIRkqEK1
 NaOmdPbGGN3WJjuYcqimLod+RGBNe8aU72nOARdg=
From: David Gibson <david@gibson.dropbear.id.au>
To: peter.maydell@linaro.org
Subject: [PULL 13/18] spapr: Pass &error_abort when getting some PC DIMM
 properties
Date: Wed, 28 Oct 2020 01:17:30 +1100
Message-Id: <20201027141735.728821-14-david@gibson.dropbear.id.au>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201027141735.728821-1-david@gibson.dropbear.id.au>
References: <20201027141735.728821-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=203.11.71.1; envelope-from=dgibson@ozlabs.org;
 helo=ozlabs.org
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/27 10:17:43
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: Igor Mammedov <imammedo@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org, groug@kaod.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Greg Kurz <groug@kaod.org>

Both PC_DIMM_SLOT_PROP and PC_DIMM_ADDR_PROP are defined in the
default property list of the PC DIMM device class:

    DEFINE_PROP_UINT64(PC_DIMM_ADDR_PROP, PCDIMMDevice, addr, 0),

    DEFINE_PROP_INT32(PC_DIMM_SLOT_PROP, PCDIMMDevice, slot,
                      PC_DIMM_UNASSIGNED_SLOT),

They should thus be always gettable for both PC DIMMs and NVDIMMs.
An error in getting them can only be the result of a programming
error. It doesn't make much sense to propagate the error in this
case. Abort instead.

Signed-off-by: Greg Kurz <groug@kaod.org>
Message-Id: <160309732180.2739814.7243774674998010907.stgit@bahia.lan>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/spapr.c | 17 +++--------------
 1 file changed, 3 insertions(+), 14 deletions(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index f8856ccf27..a5aef7a6ff 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -3443,19 +3443,13 @@ static void spapr_memory_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
 
     if (!is_nvdimm) {
         addr = object_property_get_uint(OBJECT(dimm),
-                                        PC_DIMM_ADDR_PROP, &local_err);
-        if (local_err) {
-            goto out_unplug;
-        }
+                                        PC_DIMM_ADDR_PROP, &error_abort);
         spapr_add_lmbs(dev, addr, size,
                        spapr_ovec_test(ms->ov5_cas, OV5_HP_EVT),
                        &local_err);
     } else {
         slot = object_property_get_int(OBJECT(dimm),
-                                       PC_DIMM_SLOT_PROP, &local_err);
-        if (local_err) {
-            goto out_unplug;
-        }
+                                       PC_DIMM_SLOT_PROP, &error_abort);
         /* We should have valid slot number at this point */
         g_assert(slot >= 0);
         spapr_add_nvdimm(dev, slot, &local_err);
@@ -3633,7 +3627,6 @@ static void spapr_memory_unplug_request(HotplugHandler *hotplug_dev,
                                         DeviceState *dev, Error **errp)
 {
     SpaprMachineState *spapr = SPAPR_MACHINE(hotplug_dev);
-    Error *local_err = NULL;
     PCDIMMDevice *dimm = PC_DIMM(dev);
     uint32_t nr_lmbs;
     uint64_t size, addr_start, addr;
@@ -3649,11 +3642,7 @@ static void spapr_memory_unplug_request(HotplugHandler *hotplug_dev,
     nr_lmbs = size / SPAPR_MEMORY_BLOCK_SIZE;
 
     addr_start = object_property_get_uint(OBJECT(dimm), PC_DIMM_ADDR_PROP,
-                                         &local_err);
-    if (local_err) {
-        error_propagate(errp, local_err);
-        return;
-    }
+                                          &error_abort);
 
     /*
      * An existing pending dimm state for this DIMM means that there is an
-- 
2.26.2


