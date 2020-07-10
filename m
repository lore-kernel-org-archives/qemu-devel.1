Return-Path: <SRS0=e3er=AV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82471C433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 13:29:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4D37B207BB
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 13:29:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b="X+HGq+nr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D37B207BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=citrix.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44302 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtt5c-0004R1-Jw
	for qemu-devel@archiver.kernel.org; Fri, 10 Jul 2020 09:29:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49916)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anthony.perard@citrix.com>)
 id 1jtsov-0004RA-1l
 for qemu-devel@nongnu.org; Fri, 10 Jul 2020 09:12:05 -0400
Received: from esa2.hc3370-68.iphmx.com ([216.71.145.153]:60236)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anthony.perard@citrix.com>)
 id 1jtsos-0001jb-Pf
 for qemu-devel@nongnu.org; Fri, 10 Jul 2020 09:12:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=citrix.com; s=securemail; t=1594386723;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=Nmb6NQAhCzH4JjUSe1UKDKjxPSYUFa2abwapsmcYj28=;
 b=X+HGq+nrL9+MxjAIoTpUoywlRWzufKxPaD/OLDoMP6TIm0+2+2T4CHoX
 s+djc9Cgtbo1YQK/+ZGLwHrx8GNHqp9cmbmmAitWWhoIZ0Yc21K9a9nWD
 fBy3dAmGQvJ4bnGJ/VCK8K38C3k2xuWR5g3MsyZXsHKGG5OMIZFbNvRCw I=;
Authentication-Results: esa2.hc3370-68.iphmx.com;
 dkim=none (message not signed) header.i=none
IronPort-SDR: 6NtbgrUcwTzHphZC00mVAgYezMiyjPFVaIvLjrIxDt0uyB1mfUWbETZ8MXofdy7WWIP/f99xNK
 THx3E4q70CtUqwk7DEhBuLQ5EN+Vd5dShH2ZMpXq31yq04fTUSoQ+TEUzEZv3Hsok6uMchbEkG
 3B/9g1pXg+gnbkdS4YFQspoSpXHGkTe2erQGk6bGKF7GheyyiXAJwhhCVV86RYTlRexKmmmI9V
 4Ie535q++HE0g7oRpfQCaITPndOvHl5VrsgJIDHFdaIYc4rcoLKeqP1Dw2MdwYhpziBU1WOcFb
 /88=
X-SBRS: 2.7
X-MesageID: 22068708
X-Ironport-Server: esa2.hc3370-68.iphmx.com
X-Remote-IP: 162.221.158.21
X-Policy: $RELAYED
X-IronPort-AV: E=Sophos;i="5.75,335,1589256000"; d="scan'208";a="22068708"
From: Anthony PERARD <anthony.perard@citrix.com>
To: <qemu-devel@nongnu.org>
Subject: [PULL 2/2] xen: cleanup unrealized flash devices
Date: Fri, 10 Jul 2020 14:11:45 +0100
Message-ID: <20200710131145.589476-3-anthony.perard@citrix.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200710131145.589476-1-anthony.perard@citrix.com>
References: <20200710131145.589476-1-anthony.perard@citrix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.71.145.153;
 envelope-from=anthony.perard@citrix.com; helo=esa2.hc3370-68.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/10 09:12:00
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -53
X-Spam_score: -5.4
X-Spam_bar: -----
X-Spam_report: (-5.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: Anthony PERARD <anthony.perard@citrix.com>,
 Peter Maydell <peter.maydell@linaro.org>, Paul Durrant <pdurrant@amazon.com>,
 xen-devel@lists.xenproject.org
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
Reviewed-by: Anthony PERARD <anthony.perard@citrix.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-Id: <20200624121841.17971-3-paul@xen.org>
Fixes: dfe8c79c4468 ("qdev: Assert onboard devices all get realized properly")
Signed-off-by: Anthony PERARD <anthony.perard@citrix.com>
---
 hw/i386/pc_piix.c    | 9 ++++++---
 hw/i386/pc_sysfw.c   | 2 +-
 include/hw/i386/pc.h | 1 +
 3 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index 2bb42a814144..3469b1fd1072 100644
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
index ec2a3b3e7eff..0ff47a4b5915 100644
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
index a802e699749a..3d7ed3a55e30 100644
--- a/include/hw/i386/pc.h
+++ b/include/hw/i386/pc.h
@@ -186,6 +186,7 @@ ISADevice *pc_find_fdc0(void);
 
 /* pc_sysfw.c */
 void pc_system_flash_create(PCMachineState *pcms);
+void pc_system_flash_cleanup_unused(PCMachineState *pcms);
 void pc_system_firmware_init(PCMachineState *pcms, MemoryRegion *rom_memory);
 
 /* acpi-build.c */
-- 
Anthony PERARD


