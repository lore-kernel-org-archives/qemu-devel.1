Return-Path: <SRS0=JiPe=DG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DC16C4346E
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 07:45:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 07999206DC
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 07:45:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QyEiTUBN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 07999206DC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33158 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNAK3-0002jz-LK
	for qemu-devel@archiver.kernel.org; Tue, 29 Sep 2020 03:45:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57990)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kN9yK-0004T3-7m
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 03:22:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:37606)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kN9yF-0001o7-TD
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 03:22:47 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601364162;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=rsPD3CZG5CQoW5hzq97OyG2RSXa8xe9oF7hjcd6thRw=;
 b=QyEiTUBNtcn/8e6IRAyN6IQaMfWcS8NW+dfGbfvnD5hYf3HuDYu6iLK/m7q6O2hwiQELiv
 9vDurdmMx5bFiRJ9SdPjaLpTl3NcP6oZIuzw6XpufyPh4e6UdGDHUJ7A5JH8DUKfK/AB2U
 2pQWpWgQkr6Lk0T3Xmfd+tTPQJpQQYY=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-264-EFDwoGv_M8KgNEGv7Weq6A-1; Tue, 29 Sep 2020 03:22:40 -0400
X-MC-Unique: EFDwoGv_M8KgNEGv7Weq6A-1
Received: by mail-wm1-f69.google.com with SMTP id m19so1454962wmg.6
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2020 00:22:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=rsPD3CZG5CQoW5hzq97OyG2RSXa8xe9oF7hjcd6thRw=;
 b=QkPcLUQ5BjTAiPtG+MiWkE+0Y61kuTbQs8qTikYRVO4BDjkMdCv9ZkEq6T70c7yKHh
 2oZix8hMGpFseUvXZVIcnILu8JklQVNQfZngGcWudTehrDoZlgH5GTNUMsph+/8HtRiz
 xIohE4rUuiP8DeEpGTFU0RS/fHtFimkQQCJQdfQfP91i3KDybRcO+/pQLinoPGAq7m/N
 foUN8inyxOnuJn6Or8jqmRWbeJMOIW3BzUPAMjIg4586cLE5XgTnRQ02DP+3pdlKGCMd
 8SP8uZfh5f9ROT9ln62Fek5FVaG8Ob3U6zipbi7aeJ8CMXpcYOSNV2syHw6Fc7BiBARy
 D+NA==
X-Gm-Message-State: AOAM533SYLjqs6sdiZkr7PjLB91T9rM35MszL8UPRp5cxUbSIDX2RfA8
 zUm46aGmrTSrnlKZjqcSF8GxNKcISuL/SQpkVqY86gBVCnxkGLRqgkB61WJqJRGUyQ0/h1F5du/
 sYjCnOunbxdY2hZw=
X-Received: by 2002:a5d:56cd:: with SMTP id m13mr2460526wrw.261.1601364159192; 
 Tue, 29 Sep 2020 00:22:39 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxTHn7Xx0TZ/ecrRo/084D4XVMhWjW1VfjjBR0tZyNsWx5TMOc2k2QXD5s4BPFtyFDQ1IR5Ag==
X-Received: by 2002:a5d:56cd:: with SMTP id m13mr2460503wrw.261.1601364158942; 
 Tue, 29 Sep 2020 00:22:38 -0700 (PDT)
Received: from redhat.com (bzq-79-179-71-128.red.bezeqint.net. [79.179.71.128])
 by smtp.gmail.com with ESMTPSA id v4sm3931525wml.46.2020.09.29.00.22.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2020 00:22:38 -0700 (PDT)
Date: Tue, 29 Sep 2020 03:22:36 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL v4 39/48] i440fx/acpi: do not add hotplug related amls for
 cold plugged bridges
Message-ID: <20200929071948.281157-40-mst@redhat.com>
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
 Eduardo Habkost <ehabkost@redhat.com>, Julia Suvorova <jusual@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <ani@anisinha.ca>,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Ani Sinha <ani@anisinha.ca>

Cold plugged bridges are not hot unpluggable, even when their hotplug
property (acpi-pci-hotplug-with-bridge-support) is turned off. Please see
the function acpi_pcihp_pc_no_hotplug(). However, with
the current implementaton, Windows would try to hot-unplug a pci bridge when
it's hotplug switch is off. This is regardless of whether there are devices
attached to the bridge. This is because we add ACPI code like _EJ0 etc for the
pci slot where the bridge is cold plugged.

In this fix, we identify a cold plugged bridge and for cold plugged bridges,
we do not add the appropriate ACPI methods that are used by the OS
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
Message-Id: <20200918084111.15339-6-ani@anisinha.ca>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/i386/acpi-build.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
index b49d360ab2..2b17843837 100644
--- a/hw/i386/acpi-build.c
+++ b/hw/i386/acpi-build.c
@@ -365,6 +365,7 @@ static void build_append_pci_bus_devices(Aml *parent_scope, PCIBus *bus,
         int slot = PCI_SLOT(i);
         bool hotplug_enabled_dev;
         bool bridge_in_acpi;
+        bool cold_plugged_bridge;
 
         if (!pdev) {
             if (bsel) { /* add hotplug slots for non present devices */
@@ -386,15 +387,14 @@ static void build_append_pci_bus_devices(Aml *parent_scope, PCIBus *bus,
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
MST


