Return-Path: <SRS0=LLOU=EL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B367C4742C
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2020 13:41:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4E7C320729
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2020 13:41:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KgCZvX2z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E7C320729
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54034 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kafVj-00036I-RV
	for qemu-devel@archiver.kernel.org; Thu, 05 Nov 2020 08:41:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58318)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1kafUE-0001JL-H0
 for qemu-devel@nongnu.org; Thu, 05 Nov 2020 08:39:34 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:36592)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1kafU9-0003Qt-Bv
 for qemu-devel@nongnu.org; Thu, 05 Nov 2020 08:39:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604583568;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0TbG4AoAx/hvAhTH6MVEwrwEJ1wCnRZR07N8NUwtarU=;
 b=KgCZvX2zqaY6gxTELr/UbgEEvPVjyvRHYc+/czyBI84M4prRbgyNCZ77E16xu0nvZNMF9a
 JHLQ3wCI2y32grIR+S5aWnYyhrwmPuCn+nBRCy2lMmcqv9bNoCywziSTQwvsDa50oWvwYf
 O3udGjO5wfRBV6P12WQUzpFlKxAOIEA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-262-clGiJcTGM5WioF1Ld2HXpw-1; Thu, 05 Nov 2020 08:39:26 -0500
X-MC-Unique: clGiJcTGM5WioF1Ld2HXpw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B598E1084C8F;
 Thu,  5 Nov 2020 13:39:25 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-114-66.ams2.redhat.com
 [10.36.114.66])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6DA6719D6C;
 Thu,  5 Nov 2020 13:39:25 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id B5EAF9C87; Thu,  5 Nov 2020 14:39:23 +0100 (CET)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 05/12] microvm: make pcie irq base runtime configurable
Date: Thu,  5 Nov 2020 14:39:16 +0100
Message-Id: <20201105133923.23821-6-kraxel@redhat.com>
In-Reply-To: <20201105133923.23821-1-kraxel@redhat.com>
References: <20201105133923.23821-1-kraxel@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=kraxel@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=63.128.21.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/04 22:46:30
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, Sergio Lopez <slp@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
---
 include/hw/i386/microvm.h |  2 +-
 hw/i386/microvm.c         | 11 ++++++-----
 2 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/include/hw/i386/microvm.h b/include/hw/i386/microvm.h
index c5d60bacb5e8..f1e9db059b85 100644
--- a/include/hw/i386/microvm.h
+++ b/include/hw/i386/microvm.h
@@ -66,7 +66,6 @@
 #define PCIE_MMIO_SIZE        0x20000000
 #define PCIE_ECAM_BASE        0xe0000000
 #define PCIE_ECAM_SIZE        0x10000000
-#define PCIE_IRQ_BASE         12
 
 /* Machine type options */
 #define MICROVM_MACHINE_PIT                 "pit"
@@ -96,6 +95,7 @@ struct MicrovmMachineState {
     bool auto_kernel_cmdline;
 
     /* Machine state */
+    uint32_t pcie_irq_base;
     uint32_t virtio_irq_base;
     uint32_t virtio_num_transports;
     bool kernel_cmdline_fixed;
diff --git a/hw/i386/microvm.c b/hw/i386/microvm.c
index e92f236bf442..5e4182b47464 100644
--- a/hw/i386/microvm.c
+++ b/hw/i386/microvm.c
@@ -181,6 +181,7 @@ static void microvm_devices_init(MicrovmMachineState *mms)
     mms->virtio_irq_base = 5;
     mms->virtio_num_transports = 8;
     if (x86_machine_is_acpi_enabled(x86ms)) {
+        mms->pcie_irq_base = 12;
         mms->virtio_irq_base = 16;
     }
 
@@ -226,12 +227,12 @@ static void microvm_devices_init(MicrovmMachineState *mms)
         mms->gpex.mmio32.size = PCIE_MMIO_SIZE;
         mms->gpex.ecam.base   = PCIE_ECAM_BASE;
         mms->gpex.ecam.size   = PCIE_ECAM_SIZE;
-        mms->gpex.irq         = PCIE_IRQ_BASE;
+        mms->gpex.irq         = mms->pcie_irq_base;
         create_gpex(mms);
-        x86ms->pci_irq_mask = ((1 << (PCIE_IRQ_BASE + 0)) |
-                               (1 << (PCIE_IRQ_BASE + 1)) |
-                               (1 << (PCIE_IRQ_BASE + 2)) |
-                               (1 << (PCIE_IRQ_BASE + 3)));
+        x86ms->pci_irq_mask = ((1 << (mms->pcie_irq_base + 0)) |
+                               (1 << (mms->pcie_irq_base + 1)) |
+                               (1 << (mms->pcie_irq_base + 2)) |
+                               (1 << (mms->pcie_irq_base + 3)));
     } else {
         x86ms->pci_irq_mask = 0;
     }
-- 
2.27.0


