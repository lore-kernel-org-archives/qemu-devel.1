Return-Path: <SRS0=ZyMj=EB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F0B7C4363A
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 19:08:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DA704207C3
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 19:07:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="O95UQM8l"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA704207C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53052 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kX7qY-0002AM-LY
	for qemu-devel@archiver.kernel.org; Mon, 26 Oct 2020 15:07:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51734)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kX7oV-0008LS-VD
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 15:05:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:48811)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kX7oT-0006Xr-Hp
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 15:05:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603739147;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=DWNJgv6IDfd6jIm/7i4j4jkOeDgyzy1FGS1TsoQGhOo=;
 b=O95UQM8lE4t1aYdIrlrvpx4Ha6gnBWo7aO/IGQ3zOulFCjJKtd5OypdYNBlDOUR7NQXtrb
 agiUZMtfGVTx7tMJ5UWkacVn8QKVDWfFNH9O2qo3YoL1xqEX8zkgePl8Hm7X5e5Q63TmRC
 KLPYXYMt9OAaqbSJtDXJJBKVGBKuxrw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-288-h0OcpZbeMBa3MHkE_CViwA-1; Mon, 26 Oct 2020 15:05:42 -0400
X-MC-Unique: h0OcpZbeMBa3MHkE_CViwA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8B21E809DC0
 for <qemu-devel@nongnu.org>; Mon, 26 Oct 2020 19:05:41 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com
 (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 42D6D5D9CA;
 Mon, 26 Oct 2020 19:05:41 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2] rx: move BIOS load from MCU to board
Date: Mon, 26 Oct 2020 15:05:40 -0400
Message-Id: <20201026190540.3106013-1-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/25 21:03:19
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
Cc: philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The ROM loader state is global and not part of the MCU, and the
BIOS is in machine->firmware.  So just like the kernel case,
load it in the board.

Due to the ordering between CPU reset and ROM reset, the ROM
has to be registered before the CPU is realized, otherwise
the reset vector is loaded before the ROM is there.

Cc: Philippe Mathieu-Daudé <philmd@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/rx/rx-gdbsim.c | 10 ++++++++++
 hw/rx/rx62n.c     |  9 ---------
 2 files changed, 10 insertions(+), 9 deletions(-)

diff --git a/hw/rx/rx-gdbsim.c b/hw/rx/rx-gdbsim.c
index 417ec0564b..6bf4a620e1 100644
--- a/hw/rx/rx-gdbsim.c
+++ b/hw/rx/rx-gdbsim.c
@@ -106,6 +106,16 @@ static void rx_gdbsim_init(MachineState *machine)
                              rxc->xtal_freq_hz, &error_abort);
     object_property_set_bool(OBJECT(&s->mcu), "load-kernel",
                              kernel_filename != NULL, &error_abort);
+
+    if (!kernel_filename) {
+        if (machine->firmware) {
+            rom_add_file_fixed(machine->firmware, RX62N_CFLASH_BASE, 0);
+        } else if (!qtest_enabled()) {
+            error_report("No bios or kernel specified");
+            exit(1);
+        }
+    }
+
     qdev_realize(DEVICE(&s->mcu), NULL, &error_abort);
 
     /* Load kernel and dtb */
diff --git a/hw/rx/rx62n.c b/hw/rx/rx62n.c
index 6eb4eea700..17ec73fc7b 100644
--- a/hw/rx/rx62n.c
+++ b/hw/rx/rx62n.c
@@ -245,15 +245,6 @@ static void rx62n_realize(DeviceState *dev, Error **errp)
                            rxc->rom_flash_size, &error_abort);
     memory_region_add_subregion(s->sysmem, RX62N_CFLASH_BASE, &s->c_flash);
 
-    if (!s->kernel) {
-        if (bios_name) {
-            rom_add_file_fixed(bios_name, RX62N_CFLASH_BASE, 0);
-        }  else if (!qtest_enabled()) {
-            error_report("No bios or kernel specified");
-            exit(1);
-        }
-    }
-
     /* Initialize CPU */
     object_initialize_child(OBJECT(s), "cpu", &s->cpu, TYPE_RX62N_CPU);
     qdev_realize(DEVICE(&s->cpu), NULL, &error_abort);
-- 
2.26.2


