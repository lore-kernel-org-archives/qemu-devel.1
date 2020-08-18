Return-Path: <SRS0=kYy5=B4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB6E6C433E1
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2020 12:25:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A66162076D
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2020 12:25:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="J/289uLA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A66162076D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44332 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k80g2-0001aj-TP
	for qemu-devel@archiver.kernel.org; Tue, 18 Aug 2020 08:25:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60046)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1k80dC-0005HU-7I
 for qemu-devel@nongnu.org; Tue, 18 Aug 2020 08:22:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:59311)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1k80dA-0001uj-Hg
 for qemu-devel@nongnu.org; Tue, 18 Aug 2020 08:22:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597753339;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ngjltFjDGpueT3fX8n1U/9mQVt0Ckway8GzvKTbH3Qg=;
 b=J/289uLAOzFgvUqNUVAdjfOtsUm7LzNtMOKdqteyDl2ZWKCX5DEBNzF/8jRAPvBbPl4BKP
 NZEGBYe8PN2yPh6xxj5k0EcKYGTJM2gqi4iVk1W1PAzykwltiHsfiNTO6pdTo8kDacS1gE
 KjGEgGmfBK/w6GXX0mSZDE5qh5d0ooY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-386-snMUp7GuPEC5buHWr9KH5g-1; Tue, 18 Aug 2020 08:22:17 -0400
X-MC-Unique: snMUp7GuPEC5buHWr9KH5g-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DBA741DDF9;
 Tue, 18 Aug 2020 12:22:16 +0000 (UTC)
Received: from dell-r430-03.lab.eng.brq.redhat.com
 (dell-r430-03.lab.eng.brq.redhat.com [10.37.153.18])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A86B95C641;
 Tue, 18 Aug 2020 12:22:13 +0000 (UTC)
From: Igor Mammedov <imammedo@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 2/7] x86: cphp: prevent guest crash on CPU hotplug when
 broadcast SMI is in use
Date: Tue, 18 Aug 2020 08:22:03 -0400
Message-Id: <20200818122208.1243901-3-imammedo@redhat.com>
In-Reply-To: <20200818122208.1243901-1-imammedo@redhat.com>
References: <20200818122208.1243901-1-imammedo@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=imammedo@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=63.128.21.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/18 02:02:19
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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
Cc: boris.ostrovsky@oracle.com, lersek@redhat.com, aaron.young@oracle.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

There were reports of guest crash on CPU hotplug, when using q35 machine
type and OVMF with SMM, due to hotplugged CPU trying to process SMI at
default SMI handler location without it being relocated by firmware first.

Fix it by refusing hotplug if firmware hasn't negotiated CPU hotplug with
SMI support while SMI broadcast is in use.

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Laszlo Ersek <lersek@redhat.com>
Tested-by: Laszlo Ersek <lersek@redhat.com>
---
v1:
   fix typos an use suggested wording in commit and error msg
   s/secure boot/smm/; s/hotplug SMI/hotplug with SMI/
      (Laszlo Ersek <lersek@redhat.com>)
---
 hw/acpi/ich9.c | 12 +++++++++++-
 hw/i386/pc.c   | 11 +++++++++++
 2 files changed, 22 insertions(+), 1 deletion(-)

diff --git a/hw/acpi/ich9.c b/hw/acpi/ich9.c
index 6a19070cec..0acc9a3107 100644
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
+            error_setg(errp, "cpu hotplug with SMI wasn't enabled by firmware");
+            error_append_hint(errp, "update machine type to newer than 5.1 "
+                "and firmware that suppors CPU hotplug with SMM");
+        }
+    }
 }
 
 void ich9_pm_device_plug_cb(HotplugHandler *hotplug_dev, DeviceState *dev,
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 99c6bdbab4..f07a8ab6c4 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -1499,6 +1499,17 @@ static void pc_cpu_pre_plug(HotplugHandler *hotplug_dev,
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


