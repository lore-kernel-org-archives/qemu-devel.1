Return-Path: <SRS0=2IDT=CR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36AACC433E2
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2020 05:26:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 77FF721897
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2020 05:26:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="XThN45UP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 77FF721897
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56356 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFW8z-0008WI-Ew
	for qemu-devel@archiver.kernel.org; Tue, 08 Sep 2020 01:26:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57390)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1kFW3O-0006CI-FB; Tue, 08 Sep 2020 01:20:26 -0400
Received: from ozlabs.org ([2401:3900:2:1::2]:36395)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1kFW3M-0005y1-92; Tue, 08 Sep 2020 01:20:26 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 4Bltkm6GNHz9sVF; Tue,  8 Sep 2020 15:20:00 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1599542400;
 bh=K/XOjeGYSlZyMS1PfORGCBWpuW2vS31qvW4gcdn1dfM=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=XThN45UPri8jbVjiasQ/oHGBzHOiM7C+lDbHxCPo4iKsVS7HolQJM8PJn88yVS1Xn
 ymnH2jh6AMCDJd+2cPePrwXyI/g6Gw7gRudYUPdaL8oZxmHFHL7x2IiFZX+Pw0TB/E
 7Shh33sxobssEflt0Uzy3Yywi2asEyEilgx5IbP8=
From: David Gibson <david@gibson.dropbear.id.au>
To: peter.maydell@linaro.org
Subject: [PULL 14/33] ppc/spapr_nvdimm: do not enable support with 'nvdimm=off'
Date: Tue,  8 Sep 2020 15:19:34 +1000
Message-Id: <20200908051953.1616885-15-david@gibson.dropbear.id.au>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200908051953.1616885-1-david@gibson.dropbear.id.au>
References: <20200908051953.1616885-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2401:3900:2:1::2; envelope-from=dgibson@ozlabs.org;
 helo=ozlabs.org
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
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
Cc: danielhb413@gmail.com, qemu-devel@nongnu.org, groug@kaod.org,
 qemu-ppc@nongnu.org, bauerman@linux.ibm.com,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Daniel Henrique Barboza <danielhb413@gmail.com>

The NVDIMM support for pSeries was introduced in 5.1, but it
didn't contemplate the 'nvdimm' machine option that other
archs uses. For every other arch, if no '-machine nvdimm(=on)'
is present, it is assumed that the NVDIMM support is disabled.
The user must explictly inform that the machine supports
NVDIMM. For pseries-5.1 the 'nvdimm' option is completely
ignored, and support is always assumed to exist. This
leads to situations where the user is able to set 'nvdimm=off'
but the guest boots up with the NVDIMMs anyway.

Fixing this now, after 5.1 launch, can put the overall NVDIMM
support for pseries in a strange place regarding this 'nvdimm'
machine option. If we force everything to be like other archs,
existing pseries-5.1 guests that didn't use 'nvdimm' to use NVDIMM
devices will break. If we attempt to make the newer pseries
machines (5.2+) behave like everyone else, but keep pseries-5.1
untouched, we'll have consistency problems on machine upgrade
(5.1 will have different default values for NVDIMM support than
5.2).

The common ground here is, if the user sets 'nvdimm=off', we
must comply regardless of being 5.1 or 5.2+. This patch
changes spapr_nvdimm_validate() to verify if the user set
NVDIMM support off in the machine options and, in that
case, error out if we have a NVDIMM device. The default
value for 5.2+ pseries machines will still be 'nvdimm=on'
when there is no 'nvdimm' option declared, just like it is today
with pseries-5.1. In the end we'll have different default
semantics from everyone else in the absence of the 'nvdimm'
machine option, but this boat has sailed.

Fixes: https://bugzilla.redhat.com/show_bug.cgi?id=1848887
Signed-off-by: Daniel Henrique Barboza <danielhb413@gmail.com>
Message-Id: <20200825215749.213536-4-danielhb413@gmail.com>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/spapr_nvdimm.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/hw/ppc/spapr_nvdimm.c b/hw/ppc/spapr_nvdimm.c
index bc2b65420c..95cbc30528 100644
--- a/hw/ppc/spapr_nvdimm.c
+++ b/hw/ppc/spapr_nvdimm.c
@@ -27,13 +27,17 @@
 #include "hw/ppc/spapr_nvdimm.h"
 #include "hw/mem/nvdimm.h"
 #include "qemu/nvdimm-utils.h"
+#include "qemu/option.h"
 #include "hw/ppc/fdt.h"
 #include "qemu/range.h"
+#include "sysemu/sysemu.h"
 
 void spapr_nvdimm_validate(HotplugHandler *hotplug_dev, NVDIMMDevice *nvdimm,
                            uint64_t size, Error **errp)
 {
     const MachineClass *mc = MACHINE_GET_CLASS(hotplug_dev);
+    const MachineState *ms = MACHINE(hotplug_dev);
+    const char *nvdimm_opt = qemu_opt_get(qemu_get_machine_opts(), "nvdimm");
     g_autofree char *uuidstr = NULL;
     QemuUUID uuid;
     int ret;
@@ -43,6 +47,20 @@ void spapr_nvdimm_validate(HotplugHandler *hotplug_dev, NVDIMMDevice *nvdimm,
         return;
     }
 
+    /*
+     * NVDIMM support went live in 5.1 without considering that, in
+     * other archs, the user needs to enable NVDIMM support with the
+     * 'nvdimm' machine option and the default behavior is NVDIMM
+     * support disabled. It is too late to roll back to the standard
+     * behavior without breaking 5.1 guests. What we can do is to
+     * ensure that, if the user sets nvdimm=off, we error out
+     * regardless of being 5.1 or newer.
+     */
+    if (!ms->nvdimms_state->is_enabled && nvdimm_opt) {
+        error_setg(errp, "nvdimm device found but 'nvdimm=off' was set");
+        return;
+    }
+
     if (object_property_get_int(OBJECT(nvdimm), NVDIMM_LABEL_SIZE_PROP,
                                 &error_abort) == 0) {
         error_setg(errp, "PAPR requires NVDIMM devices to have label-size set");
-- 
2.26.2


