Return-Path: <SRS0=BocF=C2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8CA3C433E2
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2020 07:55:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4C3B320658
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2020 07:55:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=anisinha-ca.20150623.gappssmtp.com header.i=@anisinha-ca.20150623.gappssmtp.com header.b="XB1X0X3j"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C3B320658
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=anisinha.ca
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60612 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIolX-00011h-Kj
	for qemu-devel@archiver.kernel.org; Thu, 17 Sep 2020 03:55:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50706)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ani@anisinha.ca>) id 1kIoeM-0008Ea-Gq
 for qemu-devel@nongnu.org; Thu, 17 Sep 2020 03:48:15 -0400
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:35112)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ani@anisinha.ca>) id 1kIoeK-0004pX-B0
 for qemu-devel@nongnu.org; Thu, 17 Sep 2020 03:48:14 -0400
Received: by mail-pf1-x444.google.com with SMTP id k8so701444pfk.2
 for <qemu-devel@nongnu.org>; Thu, 17 Sep 2020 00:48:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=anisinha-ca.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=3FEAGZTRiJo1m9GRKiMyN5eMKGbq8bEI9StzUJ10IXc=;
 b=XB1X0X3jfgEYlAKewJsHGHpzKnmKRfzitEzgKRiiBQz2WzDVG21CW6/tFsUVUbEyDU
 qStpAN+IM0PNSlAPW3JCIwABL5+dsWRO62U+weM4MPimwlMtuh+NES9pGyWQarvyImry
 VwJtZQSqR3jj4p6m4uomWBLcUGN2zMJlSaRM+Nu1pnft7VEPQGbF36PNZphRQqdlB248
 cZCnnSanPveEr5rEPHyPzL2Ib2UI7WuCbfAoLRwm5pXIZeqst0JAypODil7eOjCJd4+q
 xoiO+LIKxj9T62qXlE0RBIcLHpGN+0pHMSJ/rxmo4i/vjCVp8qrVIqy5u8KmLYzcUBfy
 Vmaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=3FEAGZTRiJo1m9GRKiMyN5eMKGbq8bEI9StzUJ10IXc=;
 b=MhvznNBlAizO25rQQjPTmk2YOCWx/0PJ3fYAa0uAk8Lw9NEAwrrvbsrcAjvi+A/W1n
 BeGV99bEwKKs77/B21C/JmLFfsx5ejxPOurCDXQqyTUAe4gklI3U0HBzKvkQD9bw+FWF
 kO3fq7t+Mko+iv1Ao6D0+Vz0c4xBREceqQmd4gpMofZSoc7eYC/D8aBkRnWYjMbDH/Rv
 YtQK+ympypuP9/bYksWsKQV21+es9d26rvCHbBFOnG16oZT/J6o0IQe0Hl/p9DpacFoh
 2jva1C4UJJBhFavQ4cuWQARKFtqlO9thUIn6iTlqTe8zPQJ4smwnxEpr704k3JumaCJN
 uC4g==
X-Gm-Message-State: AOAM531ISUl7tEXPdYlrdeS+s+ehcepSBLRMOBnn8f878kv0cOuXTf8q
 znxkB3CI3RTAn/xlnhmwketAF/aZaT/Ys1E5
X-Google-Smtp-Source: ABdhPJx0j36Pw2f9nffuXP+z9jYtMHgyAj8j8iavRZuYGWsX1Hkq5ocVs8sYbH2RqrCxrZNNJCnrbw==
X-Received: by 2002:a63:4b63:: with SMTP id k35mr22299416pgl.235.1600328890678; 
 Thu, 17 Sep 2020 00:48:10 -0700 (PDT)
Received: from localhost.localdomain ([115.96.122.113])
 by smtp.googlemail.com with ESMTPSA id y3sm20572516pfb.18.2020.09.17.00.48.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Sep 2020 00:48:09 -0700 (PDT)
From: Ani Sinha <ani@anisinha.ca>
To: qemu-devel@nongnu.org
Subject: [PATCH v6 05/12] i440fx/acpi: do not add hotplug related amls for
 cold plugged bridges
Date: Thu, 17 Sep 2020 13:17:25 +0530
Message-Id: <20200917074733.13612-6-ani@anisinha.ca>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200917074733.13612-1-ani@anisinha.ca>
References: <20200917074733.13612-1-ani@anisinha.ca>
Received-SPF: none client-ip=2607:f8b0:4864:20::444;
 envelope-from=ani@anisinha.ca; helo=mail-pf1-x444.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Cc: Eduardo Habkost <ehabkost@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, jusual@redhat.com,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Ani Sinha <ani@anisinha.ca>,
 Igor Mammedov <imammedo@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Cold plugged bridges are not hot unpluggable, even when their hotplug
property (acpi-pci-hotplug-with-bridge-support) is turned off. Please see
the function acpi_pcihp_pc_no_hotplug(). However, with
the current implementaton, Windows would try to hot-unplug a pci bridge when
it's hotplug switch is off. This is regardless of whether there are devices
attached to the bridge since we add ACPI code like _EJ0 etc for the
pci slot where the bridge is cold plugged.

In this fix, we identify a cold plugged bridge and for cold plugged bridges,
we do not add the appropriate acpi methods that are used by the OS
to identify a hot-pluggable/unpluggable pci device. After this change, Windows
does not detect the cold plugged pci bridge as ejectable.

As a result of the patch, the following are the changes to the DSDT ACPI
table:

@@ -858,38 +858,33 @@
                     Return (Zero)
                 }

                 Method (_S2D, 0, NotSerialized)  // _S2D: S2 Device State
                 {
                     Return (Zero)
                 }

                 Method (_S3D, 0, NotSerialized)  // _S3D: S3 Device State
                 {
                     Return (Zero)
                 }
             }

             Device (S18)
             {
-                Name (_SUN, 0x03)  // _SUN: Slot User Number
                 Name (_ADR, 0x00030000)  // _ADR: Address
-                Method (_EJ0, 1, NotSerialized)  // _EJx: Eject Device
-                {
-                    PCEJ (BSEL, _SUN)
-                }
             }

             Device (S20)
             {
                 Name (_SUN, 0x04)  // _SUN: Slot User Number
                 Name (_ADR, 0x00040000)  // _ADR: Address
                 Method (_EJ0, 1, NotSerialized)  // _EJx: Eject Device
                 {
                     PCEJ (BSEL, _SUN)
                 }
             }

             Device (S28)
             {
                 Name (_SUN, 0x05)  // _SUN: Slot User Number
                 Name (_ADR, 0x00050000)  // _ADR: Address
@@ -1148,37 +1143,32 @@
                     PCEJ (BSEL, _SUN)
                 }
             }

             Device (SF8)
             {
                 Name (_SUN, 0x1F)  // _SUN: Slot User Number
                 Name (_ADR, 0x001F0000)  // _ADR: Address
                 Method (_EJ0, 1, NotSerialized)  // _EJx: Eject Device
                 {
                     PCEJ (BSEL, _SUN)
                 }
             }

             Method (DVNT, 2, NotSerialized)
             {
-                If ((Arg0 & 0x08))
-                {
-                    Notify (S18, Arg1)
-                }
-
                 If ((Arg0 & 0x10))
                 {
                     Notify (S20, Arg1)
                 }

                 If ((Arg0 & 0x20))
                 {
                     Notify (S28, Arg1)
                 }

                 If ((Arg0 & 0x40))
                 {
                     Notify (S30, Arg1)
                 }

                 If ((Arg0 & 0x80))

While at it, I have also updated a stale comment.

Signed-off-by: Ani Sinha <ani@anisinha.ca>
Suggested-by: Julia Suvorova <jusual@redhat.com>
Reviewed-by: Julia Suvorova <jusual@redhat.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
---
 hw/i386/acpi-build.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
index 7a5a8b3521..e079b686f5 100644
--- a/hw/i386/acpi-build.c
+++ b/hw/i386/acpi-build.c
@@ -359,6 +359,7 @@ static void build_append_pci_bus_devices(Aml *parent_scope, PCIBus *bus,
         int slot = PCI_SLOT(i);
         bool hotplug_enabled_dev;
         bool bridge_in_acpi;
+        bool cold_plugged_bridge;
 
         if (!pdev) {
             if (bsel) { /* add hotplug slots for non present devices */
@@ -380,15 +381,14 @@ static void build_append_pci_bus_devices(Aml *parent_scope, PCIBus *bus,
         pc = PCI_DEVICE_GET_CLASS(pdev);
         dc = DEVICE_GET_CLASS(pdev);
 
-        /* When hotplug for bridges is enabled, bridges are
-         * described in ACPI separately (see build_pci_bus_end).
-         * In this case they aren't themselves hot-pluggable.
+        /*
+         * Cold plugged bridges aren't themselves hot-pluggable.
          * Hotplugged bridges *are* hot-pluggable.
          */
-        bridge_in_acpi = pc->is_bridge && pcihp_bridge_en &&
-            !DEVICE(pdev)->hotplugged;
+        cold_plugged_bridge = pc->is_bridge && !DEVICE(pdev)->hotplugged;
+        bridge_in_acpi =  cold_plugged_bridge && pcihp_bridge_en;
 
-        hotplug_enabled_dev = bsel && dc->hotpluggable && !bridge_in_acpi;
+        hotplug_enabled_dev = bsel && dc->hotpluggable && !cold_plugged_bridge;
 
         if (pc->class_id == PCI_CLASS_BRIDGE_ISA) {
             continue;
-- 
2.17.1


