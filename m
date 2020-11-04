Return-Path: <SRS0=hH57=EK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4639C4742C
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 15:08:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2BF682074B
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 15:08:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="e9WI6cD/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2BF682074B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37422 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kaKOG-0003Bn-O0
	for qemu-devel@archiver.kernel.org; Wed, 04 Nov 2020 10:08:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55420)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kaKIf-00037C-SM
 for qemu-devel@nongnu.org; Wed, 04 Nov 2020 10:02:14 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:29561)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kaKIX-00062u-E7
 for qemu-devel@nongnu.org; Wed, 04 Nov 2020 10:02:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604502124;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cu8ztXNhKaBbzFKvUo1XRUBn93MUJ6VPsbbGLiVNu5g=;
 b=e9WI6cD/ngk0wxL0CKD404FW3+Aau+DwQfdu91gFv/DRSNFmSRBWA62B7Q4X4e/48Xq0EV
 P8F0m8Ds+K73Yzb1rYTfxXmkfcHlSyg4HKG9p3LTxbxMmXqHrnUfIbIVK57csu8s5R8FLm
 4c/UetuhN1Xy+oeKQK1+wbvPPdCbw0s=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-408-naXDccTQNwqbysnmU2abWA-1; Wed, 04 Nov 2020 10:01:58 -0500
X-MC-Unique: naXDccTQNwqbysnmU2abWA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3FA658015AD;
 Wed,  4 Nov 2020 15:01:57 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com
 (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id AC0E61002D41;
 Wed,  4 Nov 2020 15:01:56 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 05/20] hw/isa/lpc_ich9: Ignore reserved/invalid SCI IRQ
Date: Wed,  4 Nov 2020 10:01:38 -0500
Message-Id: <20201104150153.541326-6-pbonzini@redhat.com>
In-Reply-To: <20201104150153.541326-1-pbonzini@redhat.com>
References: <20201104150153.541326-1-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/03 22:09:52
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
Cc: Alexander Bulekov <alxndr@bu.edu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 qemu-stable@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <f4bug@amsat.org>

libFuzzer triggered the following assertion:

  cat << EOF | qemu-system-i386 -M pc-q35-5.0 \
    -nographic -monitor none -serial none \
    -qtest stdio -d guest_errors -trace pci\*
  outl 0xcf8 0x8400f841
  outl 0xcfc 0xebed205d
  outl 0x5d02 0xedf82049
  EOF
  pci_cfg_write ICH9-LPC 31:0 @0x41 <- 0xebed205d
  hw/pci/pci.c:268: int pci_bus_get_irq_level(PCIBus *, int): Assertion `irq_num < bus->nirq' failed.

This is because ich9_lpc_sci_irq() returns -1 for reserved
(illegal) values, but ich9_lpc_pmbase_sci_update() considers
it valid and store it in a 8-bit unsigned type. Then the 255
value is used as GSI IRQ, resulting in a PIRQ value of 247,
more than ICH9_LPC_NB_PIRQS (8).

Fix by simply ignoring the invalid access (and reporting it):

  pci_cfg_write ICH9-LPC 31:0 @0x41 <- 0xebed205d
  ICH9 LPC: SCI IRQ SEL #3 is reserved
  pci_cfg_read mch 00:0 @0x0 -> 0x8086
  pci_cfg_read mch 00:0 @0x0 -> 0x29c08086
  ...

Cc: qemu-stable@nongnu.org
Reported-by: Alexander Bulekov <alxndr@bu.edu>
Fixes: 8f242cb724 ("ich9: implement SCI_IRQ_SEL register")
BugLink: https://bugs.launchpad.net/qemu/+bug/1878642
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Message-Id: <20200717151705.18611-1-f4bug@amsat.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/isa/lpc_ich9.c      | 14 +++++++++++---
 include/hw/i386/ich9.h |  1 +
 2 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/hw/isa/lpc_ich9.c b/hw/isa/lpc_ich9.c
index 04e5323140..087a18d04d 100644
--- a/hw/isa/lpc_ich9.c
+++ b/hw/isa/lpc_ich9.c
@@ -29,6 +29,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/log.h"
 #include "cpu.h"
 #include "qapi/visitor.h"
 #include "qemu/range.h"
@@ -312,10 +313,12 @@ void ich9_generate_smi(void)
     cpu_interrupt(first_cpu, CPU_INTERRUPT_SMI);
 }
 
+/* Returns -1 on error, IRQ number on success */
 static int ich9_lpc_sci_irq(ICH9LPCState *lpc)
 {
-    switch (lpc->d.config[ICH9_LPC_ACPI_CTRL] &
-            ICH9_LPC_ACPI_CTRL_SCI_IRQ_SEL_MASK) {
+    uint8_t sel = lpc->d.config[ICH9_LPC_ACPI_CTRL] &
+                  ICH9_LPC_ACPI_CTRL_SCI_IRQ_SEL_MASK;
+    switch (sel) {
     case ICH9_LPC_ACPI_CTRL_9:
         return 9;
     case ICH9_LPC_ACPI_CTRL_10:
@@ -328,6 +331,8 @@ static int ich9_lpc_sci_irq(ICH9LPCState *lpc)
         return 21;
     default:
         /* reserved */
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "ICH9 LPC: SCI IRQ SEL #%u is reserved\n", sel);
         break;
     }
     return -1;
@@ -459,7 +464,7 @@ ich9_lpc_pmbase_sci_update(ICH9LPCState *lpc)
 {
     uint32_t pm_io_base = pci_get_long(lpc->d.config + ICH9_LPC_PMBASE);
     uint8_t acpi_cntl = pci_get_long(lpc->d.config + ICH9_LPC_ACPI_CTRL);
-    uint8_t new_gsi;
+    int new_gsi;
 
     if (acpi_cntl & ICH9_LPC_ACPI_CTRL_ACPI_EN) {
         pm_io_base &= ICH9_LPC_PMBASE_BASE_ADDRESS_MASK;
@@ -470,6 +475,9 @@ ich9_lpc_pmbase_sci_update(ICH9LPCState *lpc)
     ich9_pm_iospace_update(&lpc->pm, pm_io_base);
 
     new_gsi = ich9_lpc_sci_irq(lpc);
+    if (new_gsi == -1) {
+        return;
+    }
     if (lpc->sci_level && new_gsi != lpc->sci_gsi) {
         qemu_set_irq(lpc->pm.irq, 0);
         lpc->sci_gsi = new_gsi;
diff --git a/include/hw/i386/ich9.h b/include/hw/i386/ich9.h
index 294024be5f..d1ea000d3d 100644
--- a/include/hw/i386/ich9.h
+++ b/include/hw/i386/ich9.h
@@ -144,6 +144,7 @@ struct ICH9LPCState {
 #define ICH9_LPC_PMBASE_BASE_ADDRESS_MASK       Q35_MASK(32, 15, 7)
 #define ICH9_LPC_PMBASE_RTE                     0x1
 #define ICH9_LPC_PMBASE_DEFAULT                 0x1
+
 #define ICH9_LPC_ACPI_CTRL                      0x44
 #define ICH9_LPC_ACPI_CTRL_ACPI_EN              0x80
 #define ICH9_LPC_ACPI_CTRL_SCI_IRQ_SEL_MASK     Q35_MASK(8, 2, 0)
-- 
2.26.2



