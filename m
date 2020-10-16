Return-Path: <SRS0=JoQ+=DX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D04AEC433E7
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2020 11:47:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4AABD20866
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2020 11:47:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WmxBbDAA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4AABD20866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34756 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kTOCb-0006uz-UC
	for qemu-devel@archiver.kernel.org; Fri, 16 Oct 2020 07:47:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60606)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1kTO4X-00078O-Ln
 for qemu-devel@nongnu.org; Fri, 16 Oct 2020 07:39:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:49468)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1kTO4R-0001aK-4a
 for qemu-devel@nongnu.org; Fri, 16 Oct 2020 07:38:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602848329;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aOb0XQ3gZP/giL1grdgen+q0rNnJLxXt1gCv3WbvHKc=;
 b=WmxBbDAAJYfB/z2wqW5YVzhCTdTMPSHW8aHLIs98sabBxtYKJPf4MNKLlBtejictxBEDtW
 WxpZgPUMoGVndhVaYHcLxjMTc9GjAqJYwT0KUpYtfgonGf3CNoxkn01P5Ql/53pnGQP14a
 QhNZ4uqvLYv3LibiTmge8Lpty8r37rc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-442-ceTmVLgJMyuAzCpmj1lsdg-1; Fri, 16 Oct 2020 07:38:48 -0400
X-MC-Unique: ceTmVLgJMyuAzCpmj1lsdg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E0B238015F5;
 Fri, 16 Oct 2020 11:38:46 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-112-56.ams2.redhat.com
 [10.36.112.56])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A28E773661;
 Fri, 16 Oct 2020 11:38:36 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id CA1219D8F; Fri, 16 Oct 2020 13:38:35 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 3/7] x86: make pci irqs runtime configurable
Date: Fri, 16 Oct 2020 13:38:31 +0200
Message-Id: <20201016113835.17465-4-kraxel@redhat.com>
In-Reply-To: <20201016113835.17465-1-kraxel@redhat.com>
References: <20201016113835.17465-1-kraxel@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=kraxel@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=63.128.21.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/16 03:57:19
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
 Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Add a variable to x86 machine state instead of
hard-coding the PCI interrupts.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 include/hw/i386/x86.h | 2 ++
 hw/i386/acpi-common.c | 3 +--
 hw/i386/x86.c         | 1 +
 3 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/include/hw/i386/x86.h b/include/hw/i386/x86.h
index d5dcf7a07fdc..bfa9cb2a258b 100644
--- a/include/hw/i386/x86.h
+++ b/include/hw/i386/x86.h
@@ -58,6 +58,7 @@ struct X86MachineState {
 
     /* CPU and apic information: */
     bool apic_xrupt_override;
+    unsigned pci_irq_mask;
     unsigned apic_id_limit;
     uint16_t boot_cpus;
     unsigned smp_dies;
@@ -114,6 +115,7 @@ bool x86_machine_is_acpi_enabled(const X86MachineState *x86ms);
 /* Global System Interrupts */
 
 #define GSI_NUM_PINS IOAPIC_NUM_PINS
+#define ACPI_BUILD_PCI_IRQS ((1<<5) | (1<<9) | (1<<10) | (1<<11))
 
 typedef struct GSIState {
     qemu_irq i8259_irq[ISA_NUM_IRQS];
diff --git a/hw/i386/acpi-common.c b/hw/i386/acpi-common.c
index ab9b00581a15..1584abb3e6b0 100644
--- a/hw/i386/acpi-common.c
+++ b/hw/i386/acpi-common.c
@@ -115,8 +115,7 @@ void acpi_build_madt(GArray *table_data, BIOSLinker *linker,
 
     if (has_pci) {
         for (i = 1; i < 16; i++) {
-#define ACPI_BUILD_PCI_IRQS ((1<<5) | (1<<9) | (1<<10) | (1<<11))
-            if (!(ACPI_BUILD_PCI_IRQS & (1 << i))) {
+            if (!(x86ms->pci_irq_mask & (1 << i))) {
                 /* No need for a INT source override structure. */
                 continue;
             }
diff --git a/hw/i386/x86.c b/hw/i386/x86.c
index 3137a2008588..5944fc44edca 100644
--- a/hw/i386/x86.c
+++ b/hw/i386/x86.c
@@ -1178,6 +1178,7 @@ static void x86_machine_initfn(Object *obj)
     x86ms->smm = ON_OFF_AUTO_AUTO;
     x86ms->acpi = ON_OFF_AUTO_AUTO;
     x86ms->smp_dies = 1;
+    x86ms->pci_irq_mask = ACPI_BUILD_PCI_IRQS;
 }
 
 static void x86_machine_class_init(ObjectClass *oc, void *data)
-- 
2.27.0


