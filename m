Return-Path: <SRS0=4Hnu=AF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0439C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2020 12:20:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6F9C720707
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2020 12:20:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=xen.org header.i=@xen.org header.b="IMWSEnAp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F9C720707
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xen.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42648 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jo4Nv-0002wr-Lk
	for qemu-devel@archiver.kernel.org; Wed, 24 Jun 2020 08:20:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53738)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <paul@xen.org>) id 1jo4Md-0001iq-JG
 for qemu-devel@nongnu.org; Wed, 24 Jun 2020 08:18:51 -0400
Received: from mail.xenproject.org ([104.130.215.37]:41822)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <paul@xen.org>) id 1jo4Mb-0004Uj-84
 for qemu-devel@nongnu.org; Wed, 24 Jun 2020 08:18:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=xen.org;
 s=20200302mail; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=WmkzEFnsGIT7sjSL+1trW0fIwoGyCpkoOnXxvyuh+2I=; b=IMWSEnAp8h0F/2AJelrjK/lD5Y
 XytjbgEbImgRnLyGQ1m8zFKYjRqaaP1EodKbhHxbGcHS3a6n26wzRt057a6vY5aGHuLNVPhaWrr58
 DzqCQmQuICWD58fsq5dry+Lf4PBdal4NM1X+u+cyrn22+nVRmKBWVY0Ggj1hrWaINn34=;
Received: from xenbits.xenproject.org ([104.239.192.120])
 by mail.xenproject.org with esmtp (Exim 4.92)
 (envelope-from <paul@xen.org>)
 id 1jo4MY-0000gH-PN; Wed, 24 Jun 2020 12:18:46 +0000
Received: from 54-240-197-224.amazon.com ([54.240.197.224]
 helo=u2f063a87eabd5f.cbg10.amazon.com)
 by xenbits.xenproject.org with esmtpsa
 (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim 4.92)
 (envelope-from <paul@xen.org>)
 id 1jo4MY-0005fi-Gg; Wed, 24 Jun 2020 12:18:46 +0000
From: Paul Durrant <paul@xen.org>
To: xen-devel@lists.xenproject.org,
	qemu-devel@nongnu.org
Subject: [PATCH 2/2] xen: cleanup unrealized flash devices
Date: Wed, 24 Jun 2020 13:18:41 +0100
Message-Id: <20200624121841.17971-3-paul@xen.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200624121841.17971-1-paul@xen.org>
References: <20200624121841.17971-1-paul@xen.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=104.130.215.37; envelope-from=paul@xen.org;
 helo=mail.xenproject.org
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/24 08:18:44
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
 "Michael S. Tsirkin" <mst@redhat.com>, Paul Durrant <pdurrant@amazon.com>,
 Jason Andryuk <jandryuk@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Paul Durrant <pdurrant@amazon.com>

The generic pc_machine_initfn() calls pc_system_flash_create() which creates
'system.flash0' and 'system.flash1' devices. These devices are then realized
by pc_system_flash_map() which is called from pc_system_firmware_init() which
itself is called via pc_memory_init(). The latter however is not called when
xen_enable() is true and hence the following assertion fails:

qemu-system-i386: hw/core/qdev.c:439: qdev_assert_realized_properly:
Assertion `dev->realized' failed

These flash devices are unneeded when using Xen so this patch avoids the
assertion by simply removing them using pc_system_flash_cleanup_unused().

Reported-by: Jason Andryuk <jandryuk@gmail.com>
Fixes: ebc29e1beab0 ("pc: Support firmware configuration with -blockdev")
Signed-off-by: Paul Durrant <pdurrant@amazon.com>
Tested-by: Jason Andryuk <jandryuk@gmail.com>
---
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Richard Henderson <rth@twiddle.net>
Cc: Eduardo Habkost <ehabkost@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
---
 hw/i386/pc_piix.c    | 9 ++++++---
 hw/i386/pc_sysfw.c   | 2 +-
 include/hw/i386/pc.h | 1 +
 3 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index 1497d0e4ae..977d40afb8 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -186,9 +186,12 @@ static void pc_init1(MachineState *machine,
     if (!xen_enabled()) {
         pc_memory_init(pcms, system_memory,
                        rom_memory, &ram_memory);
-    } else if (machine->kernel_filename != NULL) {
-        /* For xen HVM direct kernel boot, load linux here */
-        xen_load_linux(pcms);
+    } else {
+        pc_system_flash_cleanup_unused(pcms);
+        if (machine->kernel_filename != NULL) {
+            /* For xen HVM direct kernel boot, load linux here */
+            xen_load_linux(pcms);
+        }
     }
 
     gsi_state = pc_gsi_create(&x86ms->gsi, pcmc->pci_enabled);
diff --git a/hw/i386/pc_sysfw.c b/hw/i386/pc_sysfw.c
index ec2a3b3e7e..0ff47a4b59 100644
--- a/hw/i386/pc_sysfw.c
+++ b/hw/i386/pc_sysfw.c
@@ -108,7 +108,7 @@ void pc_system_flash_create(PCMachineState *pcms)
     }
 }
 
-static void pc_system_flash_cleanup_unused(PCMachineState *pcms)
+void pc_system_flash_cleanup_unused(PCMachineState *pcms)
 {
     char *prop_name;
     int i;
diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
index e6135c34d6..497f2b7ab7 100644
--- a/include/hw/i386/pc.h
+++ b/include/hw/i386/pc.h
@@ -187,6 +187,7 @@ int cmos_get_fd_drive_type(FloppyDriveType fd0);
 
 /* pc_sysfw.c */
 void pc_system_flash_create(PCMachineState *pcms);
+void pc_system_flash_cleanup_unused(PCMachineState *pcms);
 void pc_system_firmware_init(PCMachineState *pcms, MemoryRegion *rom_memory);
 
 /* acpi-build.c */
-- 
2.20.1


