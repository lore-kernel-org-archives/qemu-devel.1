Return-Path: <SRS0=JiPe=DG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33B65C4346E
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 07:38:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D45F92083B
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 07:38:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IXqHejjd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D45F92083B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37452 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNADc-00010r-Up
	for qemu-devel@archiver.kernel.org; Tue, 29 Sep 2020 03:38:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57526)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kN9xc-0003W4-Ga
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 03:22:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:41360)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kN9xY-0001gH-Ln
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 03:22:04 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601364117;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=jSJn6oeFuRdQPsvZXqc86KYoAu1cV/dFDaiSPKGeOMg=;
 b=IXqHejjdpSZsHyX656uhuxm3XSMwuTuvWJIYUUN5MxtyUiRUDpRtKhE6IRSlUrNvQ8lsIw
 L6F6Mvz6kJCWHyEbNTn5d2uC6dnDF6kjxShcy5ZIjpoFp5fmR4KkiJ514+Hw8ZQ0HYgpKO
 YanuQ3bIgSS8XXHu5n1VxqZ8Rzr4N9s=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-322-iasf6RQzOq22r_cR-j7fxQ-1; Tue, 29 Sep 2020 03:21:55 -0400
X-MC-Unique: iasf6RQzOq22r_cR-j7fxQ-1
Received: by mail-wr1-f71.google.com with SMTP id o6so1364420wrp.1
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2020 00:21:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=jSJn6oeFuRdQPsvZXqc86KYoAu1cV/dFDaiSPKGeOMg=;
 b=GsXdH0UNk9lh8jBTSlF0/SBkkV0P+CWFnFO4kMtWFfSEeqieR78yGquZOYB4sz6Sh4
 n9b7+ObMJNcPAEdoVw9+32e/GcQxOu+ciGZogZ8akQeq6HflGKfiakSLmsPNmcSfbnia
 IKV81Ew0UmYgqhsLLUY//jo8alIdulroLv/NImkw7I/qU/2PoXXJhxpR5J8b9KxuiOEV
 +1FQz7XMLoilFhDIqmEN7Ko6z33i/Mht7yGAHfX6cxP6Rb34ECmHn1SiOCaQ74VTkaPY
 gJtH9qoFAuThyKH1X0HHSXPj9chES0vSGM623QHfZJPm3dc+q/r5ZM3PRCu6oeKL8mu0
 DeqQ==
X-Gm-Message-State: AOAM533DyzEC+AAyuSVUTGI+Zs6dPMn2oaju+rxWLjRofkXRoZPw7J9J
 /jsurTBYJCDk7V9YtEpmwxwtvt1BvF38CpYZKkEg4RTkwv2BHKkFMNDmRqr9Y6NqFEzO7dM76du
 Q8g5iDbZLLiBX1yI=
X-Received: by 2002:a7b:c21a:: with SMTP id x26mr1517812wmi.100.1601364114092; 
 Tue, 29 Sep 2020 00:21:54 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx6XIjt4DqEfnoo8IytXDSOngpQ4z2DhXu77HHopqGP5KaWDCK2xeh5rOTSn+4rijXXmq83bg==
X-Received: by 2002:a7b:c21a:: with SMTP id x26mr1517800wmi.100.1601364113898; 
 Tue, 29 Sep 2020 00:21:53 -0700 (PDT)
Received: from redhat.com (bzq-79-179-71-128.red.bezeqint.net. [79.179.71.128])
 by smtp.gmail.com with ESMTPSA id l18sm4720017wrp.84.2020.09.29.00.21.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2020 00:21:53 -0700 (PDT)
Date: Tue, 29 Sep 2020 03:21:51 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL v4 22/48] x86: cpuhp: prevent guest crash on CPU hotplug when
 broadcast SMI is in use
Message-ID: <20200929071948.281157-23-mst@redhat.com>
References: <20200929071948.281157-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200929071948.281157-1-mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=63.128.21.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/28 22:47:55
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.687,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Eduardo Habkost <ehabkost@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Laszlo Ersek <lersek@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Igor Mammedov <imammedo@redhat.com>

There were reports of guest crash on CPU hotplug, when using q35 machine
type and OVMF with SMM, due to hotplugged CPU trying to process SMI at
default SMI handler location without it being relocated by firmware first.

Fix it by refusing hotplug if firmware hasn't negotiated CPU hotplug with
SMI support while SMI broadcast is in use.

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Laszlo Ersek <lersek@redhat.com>
Tested-by: Laszlo Ersek <lersek@redhat.com>
Message-Id: <20200923094650.1301166-3-imammedo@redhat.com>
Tested-by: Laszlo Ersek <lersek@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/acpi/ich9.c | 12 +++++++++++-
 hw/i386/x86.c  | 11 +++++++++++
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
diff --git a/hw/i386/x86.c b/hw/i386/x86.c
index c2ea989579..403c2b1dad 100644
--- a/hw/i386/x86.c
+++ b/hw/i386/x86.c
@@ -279,6 +279,17 @@ void x86_cpu_pre_plug(HotplugHandler *hotplug_dev,
         return;
     }
 
+    if (x86ms->acpi_dev) {
+        Error *local_err = NULL;
+
+        hotplug_handler_pre_plug(HOTPLUG_HANDLER(x86ms->acpi_dev), dev,
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
MST


