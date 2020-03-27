Return-Path: <SRS0=t76e=5M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1C30C43331
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2020 15:19:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7474B206F2
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2020 15:19:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=aepfle.de header.i=@aepfle.de header.b="j+Ob3+cv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7474B206F2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=aepfle.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42894 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jHqlu-0005rW-Hl
	for qemu-devel@archiver.kernel.org; Fri, 27 Mar 2020 11:19:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40702)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <olaf@aepfle.de>) id 1jHql9-00052G-1Z
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 11:19:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <olaf@aepfle.de>) id 1jHql7-0001Q8-IY
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 11:18:58 -0400
Received: from mo6-p01-ob.smtp.rzone.de ([2a01:238:20a:202:5301::7]:14715)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <olaf@aepfle.de>) id 1jHql2-0001DT-D7
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 11:18:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1585322324;
 s=strato-dkim-0002; d=aepfle.de;
 h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
 X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
 bh=7CWXkZFBhdzbpdJQ+xcVi50FudACmaZA3FqCSFoWCjc=;
 b=j+Ob3+cvXXU3BsDIPm/YXBSEOYYXI70YbsQW9wcB8P4GI8DCoGarMufjbOV8e72KQN
 VO/5CkfPf1gn+1IHnc0/+s/NV1tCesyB7MT86lX3daHsJ9L6qExQWwPHuBKd6+dexkNC
 uMj3fsAvOyayT9UiJ7jw5aly4d1ZzwNX/XACBQqalk3DfPlAu1u6ZPoGr4VBKRPoUWbs
 l5tJcPRflLmtM18H91PvCZDwGesX1+b6fpKcfkIw+d0KqfDKhuBC2Ir7HtcdoaLwM1/C
 hiYzQ4kuHD0Boy9NoHgcWTpmoWIKjLSFcHcMfYMuyW88uIvKjSnvCh2Hcql57H1loBOp
 YQSg==
X-RZG-AUTH: ":P2EQZWCpfu+qG7CngxMFH1J+3q8wa/QXkBR9MXjAuzBW/OdlBZQ4AHSS1Wwg"
X-RZG-CLASS-ID: mo00
Received: from sender by smtp.strato.de (RZmta 46.2.1 DYNA|AUTH)
 with ESMTPSA id 204e5fw2RFIh4X2
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256 bits))
 (Client did not present a certificate);
 Fri, 27 Mar 2020 16:18:43 +0100 (CET)
From: Olaf Hering <olaf@aepfle.de>
To: Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>,
 Eduardo Habkost <ehabkost@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 qemu-devel@nongnu.org (open list:All patches CC here)
Subject: [PATCH v4] piix: fix xenfv regression, add compat machine xenfv-qemu4
Date: Fri, 27 Mar 2020 16:18:40 +0100
Message-Id: <20200327151841.13877-1-olaf@aepfle.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20200113174521.3336-1-olaf@aepfle.de>
References: <20200113174521.3336-1-olaf@aepfle.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 2a01:238:20a:202:5301::7
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
Cc: Olaf Hering <olaf@aepfle.de>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

With qemu4 an incompatible change was added to pc_piix, which makes it
practical impossible to migrate domUs started with qemu2 or qemu3 to
newer qemu versions. Commit 7fccf2a06890e3bc3b30e29827ad3fb93fe88fea
added and enabled a new member "smbus_no_migration_support". In commit
4ab2f2a8aabfea95cc53c64e13b3f67960b27fdf the vmstate_acpi got new
elements, which are conditionally filled. As a result, an incoming
migration expected smbus related data unless smbus migration was
disabled for a given MachineClass. Since first commit forgot to handle
'xenfv', domUs started with qemu4 are incompatible with their qemu3
siblings.

Using other existing machine types, such as 'pc-i440fx-3.1', is not
possible because 'xenfv' creates the 'xen-platform' PCI device at
00:02.0, while all other variants to run a domU would create it at
00:04.0.

To cover both the existing and the broken case of 'xenfv' in a single
qemu binary, a new compatibility variant of 'xenfv-qemu4' must be added
which targets domUs started with qemu-4.0, qemu-4.1 and qemu-4.2. The
existing 'xenfv' restores compatibility of qemu5+ with qemu2/3.

Host admins who started domUs with qemu-4.x have to use a wrapper script
which appends '-machine xenfv-qemu4' to the device-model command line.
This is only required if there is no maintenance window which allows to
temporary shutdown the domU and restart it with a fixed device-model.

The wrapper script is as simple as this:
  #!/bin/sh
  exec /usr/bin/qemu-system-i386 "$@" -machine xenfv-qemu4

With xl this script will be enabled with device_model_override=, see
xl.cfg(5). To live migrate a domU, adjust the existing domU.cfg and pass
it to xl migrate or xl save/restore:
  xl migrate -C new-domU.cfg domU remote-host
  xl save domU CheckpointFile new-domU.cfg
  xl restore new-domU.cfg CheckpointFile

With libvirt this script will be enabled with the <emulator> element in
domU.xml. Use 'virsh edit' prior 'virsh migrate' to replace the existing
<emulator> element to point it to the wrapper script.

Signed-off-by: Olaf Hering <olaf@aepfle.de>
---
 hw/i386/pc_piix.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index e6756216f9..c565f41791 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -948,8 +948,21 @@ DEFINE_PC_MACHINE(isapc, "isapc", pc_init_isa,
 
 
 #ifdef CONFIG_XEN
+static void xenfv_qemu_4_x_machine_options(MachineClass *m)
+{
+    pc_i440fx_4_2_machine_options(m);
+    m->desc = "Xen Fully-virtualized PC (qemu 4.x compat)";
+    m->max_cpus = HVM_MAX_VCPUS;
+    m->default_machine_opts = "accel=xen";
+    m->smbus_no_migration_support = false;
+}
+
+DEFINE_PC_MACHINE(xenfv_qemu4, "xenfv-qemu4", pc_xen_hvm_init,
+                  xenfv_qemu_4_x_machine_options);
+
 static void xenfv_machine_options(MachineClass *m)
 {
+    pc_i440fx_3_1_machine_options(m);
     m->desc = "Xen Fully-virtualized PC";
     m->max_cpus = HVM_MAX_VCPUS;
     m->default_machine_opts = "accel=xen";

