Return-Path: <SRS0=dPN4=5U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29404C2BA16
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Apr 2020 08:33:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E4AA620709
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Apr 2020 08:33:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yqq14Mfj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E4AA620709
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36572 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jKeEg-0002Cf-0b
	for qemu-devel@archiver.kernel.org; Sat, 04 Apr 2020 04:33:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47590)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <arilou@gmail.com>) id 1jKeBC-0005pX-RQ
 for qemu-devel@nongnu.org; Sat, 04 Apr 2020 04:29:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <arilou@gmail.com>) id 1jKeBB-0001yN-QR
 for qemu-devel@nongnu.org; Sat, 04 Apr 2020 04:29:26 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:41764)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <arilou@gmail.com>) id 1jKeBB-0001xr-Kg
 for qemu-devel@nongnu.org; Sat, 04 Apr 2020 04:29:25 -0400
Received: by mail-wr1-x443.google.com with SMTP id h9so11244222wrc.8
 for <qemu-devel@nongnu.org>; Sat, 04 Apr 2020 01:29:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Hp0TKGKSi/gHtI8I2mIP8YOmXXrvnTmTwZnNNAObxR0=;
 b=Yqq14Mfj6E4jDQ5fGIZnCMe3xLJ+++52ranccfC+gqmvx4gadA3lZvvhIMX5oHunv8
 qfLQKoeeQXGoMw0LCH8EnPqe0Xi0LDozeUd3LuKiWXIzFzQhi8hkjPPk1ogpjQ/ouvbL
 O3qNt2vQfFGNuGp2Q2ZCJtkq6uoH9cPJyw0bVfskgQ7YrojXWIXrw9kbNos0UzSosvGy
 oXsjXB0lD9Bx/TWSZZ+uZGthHABRGO2xQwQRUDD02QdCD+rlyUKBPOe/+EPTHsbD/4UU
 i4fPYUTjYgBepfgL9sKlTmS6rpE6inG3IloIA5ttsHRlkVHixUmnHW27L8e7r2zZBWT9
 124w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Hp0TKGKSi/gHtI8I2mIP8YOmXXrvnTmTwZnNNAObxR0=;
 b=ZY6i4TaupOm4hqZ3KCQIOL5qFgc4Yl/2keK0ifbN/8/+gNuw8U/rJSZ4XVqB03NVxa
 kOEHmnnFKwZ4hQFbC2vTFqzSmgIyolfzjMycuqoTsXRnIfZMAwRftLDYqM87epTXlW2A
 tdbYXWk+VoCMKbcLTh2TDeExaA1WEcA8IdYfh3hAmnb8b+v8LBS3KACjhGJdmNcNNvNL
 ythUrPrTgcN4JZKo5ar0a9mR7J7G6LktvxQDsf1FaFsghYSjZ46WcHaIQcmFVW7oudgH
 zaAyR2aivcrS2xdc6Q0cc2goL/PeXdrDuBqilJAKo8aUb/evSjU0rl+nS3fJxywaiDyJ
 dlmg==
X-Gm-Message-State: AGi0PuYlw5l+fRCOHH3cRXGnlEaAmRVzsn3e3gvZJBGLt3bCVe6T7+Sc
 H+V9up5UIUFE7yhGzERS+rvd+n8/jeevDQ==
X-Google-Smtp-Source: APiQypLA+jEN+UJ5fUH6NjzWCD5UQwLEKAn369mXqSMvBrYSmUD3fZxv1I6oaYr1xGeQP7O9Mu4zNg==
X-Received: by 2002:adf:fe87:: with SMTP id l7mr12718581wrr.377.1585988964601; 
 Sat, 04 Apr 2020 01:29:24 -0700 (PDT)
Received: from jondnuc.lan (IGLD-84-229-155-40.inter.net.il. [84.229.155.40])
 by smtp.gmail.com with ESMTPSA id
 a10sm15884778wrm.87.2020.04.04.01.29.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 04 Apr 2020 01:29:24 -0700 (PDT)
From: Jon Doron <arilou@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 5/7] i386:pc: whitelist dynamic vmbus-bridge
Date: Sat,  4 Apr 2020 11:28:58 +0300
Message-Id: <20200404082900.33711-6-arilou@gmail.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200404082900.33711-1-arilou@gmail.com>
References: <20200404082900.33711-1-arilou@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::443
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
Cc: mail@maciej.szmigiero.name, eyakovlev@virtuozzo.com, ehabkost@redhat.com,
 rvkagan@gmail.com, liran.alon@oracle.com, Roman Kagan <rkagan@virtuozzo.com>,
 pbonzini@redhat.com, vkuznets@redhat.com,
 "Maciej S . Szmigiero" <maciej.szmigiero@oracle.com>,
 Jon Doron <arilou@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

As vmbus-bridge is derived from sysbus device, it has to be whitelisted
to be allowed to be created with -device.

Signed-off-by: Roman Kagan <rkagan@virtuozzo.com>
Signed-off-by: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>
Signed-off-by: Jon Doron <arilou@gmail.com>
---
 hw/i386/pc_piix.c | 2 ++
 hw/i386/pc_q35.c  | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index 9cceae3e2c..6daa0770fa 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -60,6 +60,7 @@
 #include "migration/global_state.h"
 #include "migration/misc.h"
 #include "sysemu/numa.h"
+#include "hw/hyperv/vmbus-bridge.h"
 #include "hw/mem/nvdimm.h"
 
 #define MAX_IDE_BUS 2
@@ -417,6 +418,7 @@ static void pc_i440fx_machine_options(MachineClass *m)
     m->default_machine_opts = "firmware=bios-256k.bin";
     m->default_display = "std";
     machine_class_allow_dynamic_sysbus_dev(m, TYPE_RAMFB_DEVICE);
+    machine_class_allow_dynamic_sysbus_dev(m, TYPE_VMBUS_BRIDGE);
 }
 
 static void pc_i440fx_5_0_machine_options(MachineClass *m)
diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
index d37c425e22..faaa39ced2 100644
--- a/hw/i386/pc_q35.c
+++ b/hw/i386/pc_q35.c
@@ -53,6 +53,7 @@
 #include "qapi/error.h"
 #include "qemu/error-report.h"
 #include "sysemu/numa.h"
+#include "hw/hyperv/vmbus-bridge.h"
 #include "hw/mem/nvdimm.h"
 
 /* ICH9 AHCI has 6 ports */
@@ -346,6 +347,7 @@ static void pc_q35_machine_options(MachineClass *m)
     machine_class_allow_dynamic_sysbus_dev(m, TYPE_AMD_IOMMU_DEVICE);
     machine_class_allow_dynamic_sysbus_dev(m, TYPE_INTEL_IOMMU_DEVICE);
     machine_class_allow_dynamic_sysbus_dev(m, TYPE_RAMFB_DEVICE);
+    machine_class_allow_dynamic_sysbus_dev(m, TYPE_VMBUS_BRIDGE);
     m->max_cpus = 288;
 }
 
-- 
2.24.1


