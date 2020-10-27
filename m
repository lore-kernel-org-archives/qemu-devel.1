Return-Path: <SRS0=gwGE=EC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CAEBC55178
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 14:48:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6BCD0207DE
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 14:48:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="UQbSxGc0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6BCD0207DE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51142 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXQH4-0005mx-DW
	for qemu-devel@archiver.kernel.org; Tue, 27 Oct 2020 10:48:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42514)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1kXPnd-0002CR-B8; Tue, 27 Oct 2020 10:18:09 -0400
Received: from ozlabs.org ([203.11.71.1]:50479)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1kXPna-0007bM-D4; Tue, 27 Oct 2020 10:18:08 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 4CLDLp72fdz9shs; Wed, 28 Oct 2020 01:17:54 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1603808274;
 bh=sqpswRVphi8tlghBAsNJaqC6FpXSR7Yjv1p6rrNCzu8=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=UQbSxGc0zv3/7+EPbYtbYzshsw1NqRb9RTFM3Ny3cmURWozNVF1Bhmp8Y5uh6BR/W
 BpPmdfM+y4yUbOHZ9BFeL0mxEWv1xgMYgZnoLokiPnlL+0m8541KOIkk+wHC/8/GT5
 c567FQoYost9/AqvEgNgS5TmzAmh07oekZLQXpnw=
From: David Gibson <david@gibson.dropbear.id.au>
To: peter.maydell@linaro.org
Subject: [PULL 12/18] spapr: Use appropriate getter for PC_DIMM_SLOT_PROP
Date: Wed, 28 Oct 2020 01:17:29 +1100
Message-Id: <20201027141735.728821-13-david@gibson.dropbear.id.au>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201027141735.728821-1-david@gibson.dropbear.id.au>
References: <20201027141735.728821-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org, groug@kaod.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Greg Kurz <groug@kaod.org>

The PC_DIMM_SLOT_PROP property is defined as:

    DEFINE_PROP_INT32(PC_DIMM_SLOT_PROP, PCDIMMDevice, slot,
                      PC_DIMM_UNASSIGNED_SLOT),

Use object_property_get_int() instead of object_property_get_uint().
Since spapr_memory_plug() only gets called if pc_dimm_pre_plug()
succeeded, we expect to have a valid >= 0 slot number, either because
the user passed a valid slot number or because pc_dimm_get_free_slot()
picked one up for us.

Signed-off-by: Greg Kurz <groug@kaod.org>
Message-Id: <160309730758.2739814.15821922745424652642.stgit@bahia.lan>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/spapr.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index b2405599ad..f8856ccf27 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -3433,7 +3433,8 @@ static void spapr_memory_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
     Error *local_err = NULL;
     SpaprMachineState *ms = SPAPR_MACHINE(hotplug_dev);
     PCDIMMDevice *dimm = PC_DIMM(dev);
-    uint64_t size, addr, slot;
+    uint64_t size, addr;
+    int64_t slot;
     bool is_nvdimm = object_dynamic_cast(OBJECT(dev), TYPE_NVDIMM);
 
     size = memory_device_get_region_size(MEMORY_DEVICE(dev), &error_abort);
@@ -3450,11 +3451,13 @@ static void spapr_memory_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
                        spapr_ovec_test(ms->ov5_cas, OV5_HP_EVT),
                        &local_err);
     } else {
-        slot = object_property_get_uint(OBJECT(dimm),
-                                        PC_DIMM_SLOT_PROP, &local_err);
+        slot = object_property_get_int(OBJECT(dimm),
+                                       PC_DIMM_SLOT_PROP, &local_err);
         if (local_err) {
             goto out_unplug;
         }
+        /* We should have valid slot number at this point */
+        g_assert(slot >= 0);
         spapr_add_nvdimm(dev, slot, &local_err);
     }
 
-- 
2.26.2


