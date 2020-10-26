Return-Path: <SRS0=ZyMj=EB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC9D0C4363A
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 10:18:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 41F3622242
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 10:18:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iD5BuVUg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 41F3622242
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37972 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kWzac-0001Sd-6f
	for qemu-devel@archiver.kernel.org; Mon, 26 Oct 2020 06:18:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39010)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kWzPK-0002un-Bl
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 06:07:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:60128)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kWzPH-0006ku-Sw
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 06:07:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603706834;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:in-reply-to:in-reply-to:
 references:references; bh=aucPwhwUbR6TENYaHakJx2OXhB3AYMAGQa1dTFTAkjM=;
 b=iD5BuVUgnk4sKaATh17zDsszzFgeWhoNO1uJxOnNcfDLLdVJX9bbg+bGqI4+KgTD+3DLmW
 1ePgAFHsEcVB+AvfRFpxIhTXMREzVq12GQ9MJvi7Nd1goVQMpvNyN53PlXZl0csSA8uga7
 kH4Vs857MYy10gU3q61kB5KYHwQ7qts=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-448-ZU975xKaMJ6vbG4swPYuTw-1; Mon, 26 Oct 2020 06:07:10 -0400
X-MC-Unique: ZU975xKaMJ6vbG4swPYuTw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BB868835BAE;
 Mon, 26 Oct 2020 10:07:09 +0000 (UTC)
Received: from thuth.com (ovpn-112-104.ams2.redhat.com [10.36.112.104])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 70BE48B848;
 Mon, 26 Oct 2020 10:07:08 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 22/31] fuzz: add generic-fuzz configs for oss-fuzz
Date: Mon, 26 Oct 2020 11:06:23 +0100
Message-Id: <20201026100632.212530-23-thuth@redhat.com>
In-Reply-To: <20201026100632.212530-1-thuth@redhat.com>
References: <20201026100632.212530-1-thuth@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=thuth@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=63.128.21.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/25 21:03:19
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: Alexander Bulekov <alxndr@bu.edu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Alexander Bulekov <alxndr@bu.edu>

Predefine some generic-fuzz configs. For each of these, we will create a
separate FuzzTarget that can be selected through argv0 and, therefore,
fuzzed on oss-fuzz.

Reviewed-by: Darren Kenny <darren.kenny@oracle.com>
Signed-off-by: Alexander Bulekov <alxndr@bu.edu>
Message-Id: <20201023150746.107063-15-alxndr@bu.edu>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/qtest/fuzz/generic_fuzz_configs.h | 121 ++++++++++++++++++++++++
 1 file changed, 121 insertions(+)
 create mode 100644 tests/qtest/fuzz/generic_fuzz_configs.h

diff --git a/tests/qtest/fuzz/generic_fuzz_configs.h b/tests/qtest/fuzz/generic_fuzz_configs.h
new file mode 100644
index 0000000000..c4d925f9e6
--- /dev/null
+++ b/tests/qtest/fuzz/generic_fuzz_configs.h
@@ -0,0 +1,121 @@
+/*
+ * Generic Virtual-Device Fuzzing Target Configs
+ *
+ * Copyright Red Hat Inc., 2020
+ *
+ * Authors:
+ *  Alexander Bulekov   <alxndr@bu.edu>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ */
+
+#ifndef GENERIC_FUZZ_CONFIGS_H
+#define GENERIC_FUZZ_CONFIGS_H
+
+#include "qemu/osdep.h"
+
+typedef struct generic_fuzz_config {
+    const char *name, *args, *objects;
+} generic_fuzz_config;
+
+const generic_fuzz_config predefined_configs[] = {
+    {
+        .name = "virtio-net-pci-slirp",
+        .args = "-M q35 -nodefaults "
+        "-device virtio-net,netdev=net0 -netdev user,id=net0",
+        .objects = "virtio*",
+    },{
+        .name = "virtio-blk",
+        .args = "-machine q35 -device virtio-blk,drive=disk0 "
+        "-drive file=null-co://,id=disk0,if=none,format=raw",
+        .objects = "virtio*",
+    },{
+        .name = "virtio-scsi",
+        .args = "-machine q35 -device virtio-scsi,num_queues=8 "
+        "-device scsi-hd,drive=disk0 "
+        "-drive file=null-co://,id=disk0,if=none,format=raw",
+        .objects = "scsi* virtio*",
+    },{
+        .name = "virtio-gpu",
+        .args = "-machine q35 -nodefaults -device virtio-gpu",
+        .objects = "virtio*",
+    },{
+        .name = "virtio-vga",
+        .args = "-machine q35 -nodefaults -device virtio-vga",
+        .objects = "virtio*",
+    },{
+        .name = "virtio-rng",
+        .args = "-machine q35 -nodefaults -device virtio-rng",
+        .objects = "virtio*",
+    },{
+        .name = "virtio-balloon",
+        .args = "-machine q35 -nodefaults -device virtio-balloon",
+        .objects = "virtio*",
+    },{
+        .name = "virtio-serial",
+        .args = "-machine q35 -nodefaults -device virtio-serial",
+        .objects = "virtio*",
+    },{
+        .name = "virtio-mouse",
+        .args = "-machine q35 -nodefaults -device virtio-mouse",
+        .objects = "virtio*",
+    },{
+        .name = "e1000",
+        .args = "-M q35 -nodefaults "
+        "-device e1000,netdev=net0 -netdev user,id=net0",
+        .objects = "e1000",
+    },{
+        .name = "e1000e",
+        .args = "-M q35 -nodefaults "
+        "-device e1000e,netdev=net0 -netdev user,id=net0",
+        .objects = "e1000e",
+    },{
+        .name = "cirrus-vga",
+        .args = "-machine q35 -nodefaults -device cirrus-vga",
+        .objects = "cirrus*",
+    },{
+        .name = "bochs-display",
+        .args = "-machine q35 -nodefaults -device bochs-display",
+        .objects = "bochs*",
+    },{
+        .name = "intel-hda",
+        .args = "-machine q35 -nodefaults -device intel-hda,id=hda0 "
+        "-device hda-output,bus=hda0.0 -device hda-micro,bus=hda0.0 "
+        "-device hda-duplex,bus=hda0.0",
+        .objects = "intel-hda",
+    },{
+        .name = "ide-hd",
+        .args = "-machine q35 -nodefaults "
+        "-drive file=null-co://,if=none,format=raw,id=disk0 "
+        "-device ide-hd,drive=disk0",
+        .objects = "ahci*",
+    },{
+        .name = "floppy",
+        .args = "-machine pc -nodefaults -device floppy,id=floppy0 "
+        "-drive id=disk0,file=null-co://,file.read-zeroes=on,if=none "
+        "-device floppy,drive=disk0,drive-type=288",
+        .objects = "fd* floppy*",
+    },{
+        .name = "xhci",
+        .args = "-machine q35 -nodefaults "
+        "-drive file=null-co://,if=none,format=raw,id=disk0 "
+        "-device qemu-xhci,id=xhci -device usb-tablet,bus=xhci.0 "
+        "-device usb-bot -device usb-storage,drive=disk0 "
+        "-chardev null,id=cd0 -chardev null,id=cd1 "
+        "-device usb-braille,chardev=cd0 -device usb-ccid -device usb-ccid "
+        "-device usb-kbd -device usb-mouse -device usb-serial,chardev=cd1 "
+        "-device usb-tablet -device usb-wacom-tablet -device usb-audio",
+        .objects = "*usb* *uhci* *xhci*",
+    },{
+        .name = "pc-i440fx",
+        .args = "-machine pc",
+        .objects = "*",
+    },{
+        .name = "pc-q35",
+        .args = "-machine q35",
+        .objects = "*",
+    }
+};
+
+#endif
-- 
2.18.2


