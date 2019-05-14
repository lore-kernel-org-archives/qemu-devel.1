Return-Path: <SRS0=VR7F=TO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A080EC04AB4
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2019 18:51:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 37FE521734
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2019 18:51:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 37FE521734
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:52634 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hQcWl-0003uH-6R
	for qemu-devel@archiver.kernel.org; Tue, 14 May 2019 14:51:51 -0400
Received: from eggs.gnu.org ([209.51.188.92]:42520)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1hQcS0-0000oE-Vb
	for qemu-devel@nongnu.org; Tue, 14 May 2019 14:46:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1hQcRz-00026D-VI
	for qemu-devel@nongnu.org; Tue, 14 May 2019 14:46:56 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49274)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alex.williamson@redhat.com>)
	id 1hQcRz-00025W-Q7
	for qemu-devel@nongnu.org; Tue, 14 May 2019 14:46:55 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C84EF81F1B;
	Tue, 14 May 2019 18:46:54 +0000 (UTC)
Received: from gimli.home (ovpn-117-92.phx2.redhat.com [10.3.117.92])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 4DA625C28E;
	Tue, 14 May 2019 18:46:47 +0000 (UTC)
From: Alex Williamson <alex.williamson@redhat.com>
To: qemu-devel@nongnu.org
Date: Tue, 14 May 2019 12:46:47 -0600
Message-ID: <155785957030.10526.15982471144880782730.stgit@gimli.home>
User-Agent: StGit/0.19-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.26]);
	Tue, 14 May 2019 18:46:54 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH for-4.1] q35: Revert to kernel irqchip
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: ehabkost@redhat.com, mst@redhat.com, peterx@redhat.com, pbonzini@redhat.com,
	rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Commit b2fc91db8447 ("q35: set split kernel irqchip as default") changed
the default for the pc-q35-4.0 machine type to use split irqchip, which
turned out to have disasterous effects on vfio-pci INTx support.  KVM
resampling irqfds are registered for handling these interrupts, but
these are non-functional in split irqchip mode.  We can't simply test
for split irqchip in QEMU as userspace handling of this interrupt is a
significant performance regression versus KVM handling (GeForce GPUs
assigned to Windows VMs are non-functional without forcing MSI mode or
re-enabling kernel irqchip).

The resolution is to revert the change in default irqchip mode in the
pc-q35-4.1 machine type.  The qemu-q35-4.0 machine type should not be
used in vfio-pci configurations for devices requiring legacy INTx
support without explicitly modifying the VM configuration to use KVM
irqchip.  A new pc-q35-4.0.1 machine type is submitted to resolve this
in the stable branch.

Link: https://bugs.launchpad.net/qemu/+bug/1826422
Fixes: b2fc91db8447 ("q35: set split kernel irqchip as default")
Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
---
 hw/i386/pc_q35.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
index 37dd350511a9..9f90dc72a53f 100644
--- a/hw/i386/pc_q35.c
+++ b/hw/i386/pc_q35.c
@@ -357,7 +357,7 @@ static void pc_q35_machine_options(MachineClass *m)
     m->units_per_default_bus = 1;
     m->default_machine_opts = "firmware=bios-256k.bin";
     m->default_display = "std";
-    m->default_kernel_irqchip_split = true;
+    m->default_kernel_irqchip_split = false;
     m->no_floppy = 1;
     machine_class_allow_dynamic_sysbus_dev(m, TYPE_AMD_IOMMU_DEVICE);
     machine_class_allow_dynamic_sysbus_dev(m, TYPE_INTEL_IOMMU_DEVICE);
@@ -377,6 +377,7 @@ DEFINE_Q35_MACHINE(v4_1, "pc-q35-4.1", NULL,
 static void pc_q35_4_0_machine_options(MachineClass *m)
 {
     pc_q35_4_1_machine_options(m);
+    m->default_kernel_irqchip_split = true;
     m->alias = NULL;
     compat_props_add(m->compat_props, hw_compat_4_0, hw_compat_4_0_len);
     compat_props_add(m->compat_props, pc_compat_4_0, pc_compat_4_0_len);


