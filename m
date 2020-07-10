Return-Path: <SRS0=e3er=AV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0C5AC433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 16:34:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6879E20657
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 16:34:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="G+At/Kjl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6879E20657
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48452 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtvyO-0005vU-KR
	for qemu-devel@archiver.kernel.org; Fri, 10 Jul 2020 12:34:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43790)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1jtvjH-00023M-RN
 for qemu-devel@nongnu.org; Fri, 10 Jul 2020 12:18:28 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:53687
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1jtvjF-0005ZX-PN
 for qemu-devel@nongnu.org; Fri, 10 Jul 2020 12:18:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594397905;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dAtE3nRtKly27eAVEbJcOtjuQfHpPIur9lrVJrUO+YQ=;
 b=G+At/KjlxOukizbqvH7rgwgJSC7fLpyDiEeh7b7duyfXs+Z9KXDb+yDvcRXQd3GeiBkSHy
 tgYho4DBZdksXAYgnFJweH3zfe+Pk+931u+QJyJ/Hfh4UHmBOPms2X9gjZpDJG5T4M9lR3
 2cBu4rCQ2jA3yZXbf/RTFZnqXNNXSPU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-318-TWPrGYW5ODCvp4z3fLWl5w-1; Fri, 10 Jul 2020 12:17:14 -0400
X-MC-Unique: TWPrGYW5ODCvp4z3fLWl5w-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0749A193F561;
 Fri, 10 Jul 2020 16:17:13 +0000 (UTC)
Received: from dell-r430-03.lab.eng.brq.redhat.com
 (dell-r430-03.lab.eng.brq.redhat.com [10.37.153.18])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0829E7EFA5;
 Fri, 10 Jul 2020 16:17:11 +0000 (UTC)
From: Igor Mammedov <imammedo@redhat.com>
To: qemu-devel@nongnu.org
Subject: [RFC 2/3] x86: cphp: prevent guest crash on CPU hotplug when
 broadcast SMI is in use
Date: Fri, 10 Jul 2020 12:17:03 -0400
Message-Id: <20200710161704.309824-3-imammedo@redhat.com>
In-Reply-To: <20200710161704.309824-1-imammedo@redhat.com>
References: <20200710161704.309824-1-imammedo@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=imammedo@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/10 04:36:30
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: lersek@redhat.com, boris.ostrovsky@oracle.com, liran.alon@oracle.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

There were reports of guest crash on CPU hotplug, when using q35 machine
type and QVMF with Secure Boot, due to hotplugged CPU trying to process SMI
at default SMI handler location without it being relocated by firmware first.

Fix it by refusing hotplug if firmware hasn't negotiatiad CPU hotplug SMI
support while SMI broadcast is in use.

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
---
 hw/acpi/ich9.c | 12 +++++++++++-
 hw/i386/pc.c   | 11 +++++++++++
 2 files changed, 22 insertions(+), 1 deletion(-)

diff --git a/hw/acpi/ich9.c b/hw/acpi/ich9.c
index 2d204babc6..a22b434e0b 100644
--- a/hw/acpi/ich9.c
+++ b/hw/acpi/ich9.c
@@ -408,10 +408,20 @@ void ich9_pm_device_pre_plug_cb(HotplugHandler *hotplug_dev, DeviceState *dev,
     ICH9LPCState *lpc = ICH9_LPC_DEVICE(hotplug_dev);
 
     if (object_dynamic_cast(OBJECT(dev), TYPE_PC_DIMM) &&
-        !lpc->pm.acpi_memory_hotplug.is_enabled)
+        !lpc->pm.acpi_memory_hotplug.is_enabled) {
         error_setg(errp,
                    "memory hotplug is not enabled: %s.memory-hotplug-support "
                    "is not set", object_get_typename(OBJECT(lpc)));
+    } else if (object_dynamic_cast(OBJECT(dev), TYPE_CPU)) {
+        uint64_t negotiated = lpc->smi_negotiated_features;
+
+        if (negotiated & BIT_ULL(ICH9_LPC_SMI_F_BROADCAST_BIT) &&
+            !(negotiated & BIT_ULL(ICH9_LPC_SMI_F_CPU_HOTPLUG_BIT))) {
+            error_setg(errp, "cpu hotplug SMI was not enabled by firmware");
+            error_append_hint(errp, "update machine type to newer than 5.0 "
+                "and firmware that suppors CPU hotplug in Secure Boot mode");
+        }
+    }
 }
 
 void ich9_pm_device_plug_cb(HotplugHandler *hotplug_dev, DeviceState *dev,
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 6fe80c84d7..dc1e9157d7 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -1508,6 +1508,17 @@ static void pc_cpu_pre_plug(HotplugHandler *hotplug_dev,
         return;
     }
 
+    if (pcms->acpi_dev) {
+        Error *local_err = NULL;
+
+        hotplug_handler_pre_plug(HOTPLUG_HANDLER(pcms->acpi_dev), dev,
+                                 &local_err);
+        if (local_err) {
+            error_propagate(errp, local_err);
+            return;
+        }
+    }
+
     init_topo_info(&topo_info, x86ms);
 
     env->nr_dies = x86ms->smp_dies;
-- 
2.26.2


