Return-Path: <SRS0=bzpH=76=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CE5CC433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 16:12:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2845A2080D
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 16:12:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QfWC4brh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2845A2080D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50608 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlag6-0007EG-EW
	for qemu-devel@archiver.kernel.org; Wed, 17 Jun 2020 12:12:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36542)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <arilou@gmail.com>) id 1jlacw-0002WU-Gw
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 12:09:26 -0400
Received: from mail-ej1-x644.google.com ([2a00:1450:4864:20::644]:37639)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <arilou@gmail.com>) id 1jlacu-0008Fe-Vw
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 12:09:26 -0400
Received: by mail-ej1-x644.google.com with SMTP id mb16so2972948ejb.4
 for <qemu-devel@nongnu.org>; Wed, 17 Jun 2020 09:09:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=1GRIcuzG4DdAhxC4d6qYQFDt6LiehnQlar4uGfdpt2E=;
 b=QfWC4brhjXeHtmP7/y42LzDvS39A/0HvJYhs0ALyAR0FqCuXrQdNE6WnQMUH0mbWtZ
 VWEBfL40Qm7/PUqCQe5vzO+sFSgDoEEmsKwqKXnHo0KdcfrSe+b9eXtBzbTdPic6GvHI
 401DownIuXeB18+9RRW7geo5r2LtyVnD0VPMGqOW2WFyLPTehBZXMol4rxp/WlyEKB55
 +xwBnyLgJ9qYY7Iipb402x03fwgfVVdhsVTa8DmrlcVa6pP1uQ4+czLBz5BDGlacCUWG
 Ru/oaXjQyjszUExT1f+rDY1FD9mP4JfWghKP04HhFG/j5pjeKLAforeh5xHXl23trmL6
 OBaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=1GRIcuzG4DdAhxC4d6qYQFDt6LiehnQlar4uGfdpt2E=;
 b=bzjN61FXBT82U8vdRnGw96RPc1GvzBDYq4dLCa5eurEhVKMEmFoUknB9NpkwEHu8F8
 Ofo5Dtn5u1z2yhwEW14EP8ijSYfPv1QZI3dk59D7SVVUE8TJ8aSDSgKSzkgq8GvO/+MS
 1CLjh1avppzS9r51gTXc1a5rqnKh9HLswWEHpSisjWpeJRg3p8pp//hbRutP60UbFkEW
 P68x94tKcAW2nlEESoKJ4Amu3ge2t+y5XcFAP8QgKBx1/JCywkKfLZCrbO6n3J7P4bHx
 KbzG6pJ4UbrgDlj4TU9DtLj4khnvYwYUyIjPTUlfDNBxFDVigcL8ijn1Zt8B9DYbudl6
 8bBQ==
X-Gm-Message-State: AOAM5337drcQ3oB1nOh4Kqi28jhnTdMB7v9OscS+J9iLafGY2sqo3TCx
 wxebr8wRVR+X0qafGPGeKXPoJTjXLHk=
X-Google-Smtp-Source: ABdhPJxuoGe6UnW/uSeT8bqGQN1iXr6q9FZwQjHQoUNH8xwQf4c636VLhiKPHVyCoBvKz/U5MPdsig==
X-Received: by 2002:a17:907:20f4:: with SMTP id
 rh20mr7996254ejb.55.1592410163415; 
 Wed, 17 Jun 2020 09:09:23 -0700 (PDT)
Received: from jondnuc.lan (IGLD-84-229-154-20.inter.net.il. [84.229.154.20])
 by smtp.gmail.com with ESMTPSA id
 bs1sm65365edb.43.2020.06.17.09.09.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jun 2020 09:09:23 -0700 (PDT)
From: Jon Doron <arilou@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 3/3] acpi: i386: Move VMBus DSDT entry to SB
Date: Wed, 17 Jun 2020 19:09:04 +0300
Message-Id: <20200617160904.681845-4-arilou@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200617160904.681845-1-arilou@gmail.com>
References: <20200617160904.681845-1-arilou@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::644;
 envelope-from=arilou@gmail.com; helo=mail-ej1-x644.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: mail@maciej.szmigiero.name, Jon Doron <arilou@gmail.com>,
 rvkagan@yandex-team.ru, imammedo@redhat.com, pbonzini@redhat.com,
 vkuznets@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Jon Doron <arilou@gmail.com>
---
 hw/i386/acpi-build.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
index 6d9df38e31..38be9e5a58 100644
--- a/hw/i386/acpi-build.c
+++ b/hw/i386/acpi-build.c
@@ -1092,7 +1092,6 @@ static Aml *build_vmbus_device_aml(VMBusBridge *vmbus_bridge)
 static void build_isa_devices_aml(Aml *table)
 {
     ISADevice *fdc = pc_find_fdc0();
-    VMBusBridge *vmbus_bridge = vmbus_bridge_find();
     bool ambiguous;
 
     Aml *scope = aml_scope("_SB.PCI0.ISA");
@@ -1113,10 +1112,6 @@ static void build_isa_devices_aml(Aml *table)
         isa_build_aml(ISA_BUS(obj), scope);
     }
 
-    if (vmbus_bridge) {
-        aml_append(scope, build_vmbus_device_aml(vmbus_bridge));
-    }
-
     aml_append(table, scope);
 }
 
@@ -1661,6 +1656,7 @@ build_dsdt(GArray *table_data, BIOSLinker *linker,
     PCIBus *bus = NULL;
     TPMIf *tpm = tpm_find();
     int i;
+    VMBusBridge *vmbus_bridge = vmbus_bridge_find();
 
     dsdt = init_aml_allocator();
 
@@ -1675,6 +1671,9 @@ build_dsdt(GArray *table_data, BIOSLinker *linker,
         aml_append(dev, aml_name_decl("_ADR", aml_int(0)));
         aml_append(dev, aml_name_decl("_UID", aml_int(1)));
         aml_append(sb_scope, dev);
+        if (vmbus_bridge) {
+            aml_append(sb_scope, build_vmbus_device_aml(vmbus_bridge));
+        }
         aml_append(dsdt, sb_scope);
 
         build_hpet_aml(dsdt);
@@ -1692,6 +1691,9 @@ build_dsdt(GArray *table_data, BIOSLinker *linker,
         aml_append(dev, aml_name_decl("_UID", aml_int(1)));
         aml_append(dev, build_q35_osc_method());
         aml_append(sb_scope, dev);
+        if (vmbus_bridge) {
+            aml_append(sb_scope, build_vmbus_device_aml(vmbus_bridge));
+        }
         aml_append(dsdt, sb_scope);
 
         build_hpet_aml(dsdt);
-- 
2.24.1


