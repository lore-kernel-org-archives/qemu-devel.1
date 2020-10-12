Return-Path: <SRS0=wjGh=DT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 166A4C433E7
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2020 20:44:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9333F2074F
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2020 20:44:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Eg+a8oL0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9333F2074F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54236 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kS4gQ-0001EE-MM
	for qemu-devel@archiver.kernel.org; Mon, 12 Oct 2020 16:44:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38010)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kS4WA-0002hB-2E
 for qemu-devel@nongnu.org; Mon, 12 Oct 2020 16:34:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:48723)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kS4W8-0002ew-5k
 for qemu-devel@nongnu.org; Mon, 12 Oct 2020 16:34:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602534839;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=D1HuS/ldYTqaXHMm2IQ3F6xjU2L7PLXN0yN5kW8hLwA=;
 b=Eg+a8oL0ANrOiylzuRsJm9ENqouWE9kupHXeDy/sUXeSORIH5rgobuI9wqi+Ww6kIRvFxU
 PGD4EJ3gsJFfkkruaW+QSkK+x3QeifSCZDOBlgw3r8+soxkKv7y1Cg6kZYpylP17MzklcS
 7QrOWpfZApymrot12FcpJqGV6iqlzrE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-78-SL_FxWQCPEiGCuc59sZoGg-1; Mon, 12 Oct 2020 16:33:57 -0400
X-MC-Unique: SL_FxWQCPEiGCuc59sZoGg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D3AEA18A8237
 for <qemu-devel@nongnu.org>; Mon, 12 Oct 2020 20:33:49 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com
 (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 70E1F5D9CD;
 Mon, 12 Oct 2020 20:33:49 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 10/38] hw/nvram: Always register FW_CFG_DATA_GENERATOR_INTERFACE
Date: Mon, 12 Oct 2020 16:33:15 -0400
Message-Id: <20201012203343.1105018-11-pbonzini@redhat.com>
In-Reply-To: <20201012203343.1105018-1-pbonzini@redhat.com>
References: <20201012203343.1105018-1-pbonzini@redhat.com>
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
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/12 16:33:53
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
Cc: Kevin Wolf <kwolf@redhat.com>, Laszlo Ersek <lersek@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <philmd@redhat.com>

While the FW_CFG_DATA_GENERATOR_INTERFACE is only consumed
by a device only available using system-mode (fw_cfg), it is
implemented by a crypto component (tls-cipher-suites) which
is always available when crypto is used.

Commit 69699f3055 introduced the following error in the
qemu-storage-daemon binary:

  $ echo -e \
    '{"execute": "qmp_capabilities"}\r\n{"execute": "qom-list-types"}\r\n{"execute": "quit"}\r\n' \
    | storage-daemon/qemu-storage-daemon --chardev stdio,id=qmp0  --monitor qmp0
  {"QMP": {"version": {"qemu": {"micro": 50, "minor": 1, "major": 5}, "package": ""}, "capabilities": ["oob"]}}
  {"return": {}}
  missing interface 'fw_cfg-data-generator' for object 'tls-creds'
  Aborted (core dumped)

Since QOM dependencies are resolved at runtime, this issue
could not be triggered at linktime, and we don't have test
running the qemu-storage-daemon binary.

Fix by always registering the QOM interface.

Reported-by: Kevin Wolf <kwolf@redhat.com>
Fixes: 69699f3055 ("crypto/tls-cipher-suites: Produce fw_cfg consumable blob")
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Laszlo Ersek <lersek@redhat.com>
Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
Message-Id: <20201006111909.2302081-2-philmd@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 MAINTAINERS                 |  2 +-
 hw/nvram/fw_cfg-interface.c | 23 +++++++++++++++++++++++
 hw/nvram/fw_cfg.c           |  7 -------
 hw/nvram/meson.build        |  3 +++
 4 files changed, 27 insertions(+), 8 deletions(-)
 create mode 100644 hw/nvram/fw_cfg-interface.c

diff --git a/MAINTAINERS b/MAINTAINERS
index e9d85cc873..8d50b96c33 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2055,7 +2055,7 @@ R: Laszlo Ersek <lersek@redhat.com>
 R: Gerd Hoffmann <kraxel@redhat.com>
 S: Supported
 F: docs/specs/fw_cfg.txt
-F: hw/nvram/fw_cfg.c
+F: hw/nvram/fw_cfg*.c
 F: stubs/fw_cfg.c
 F: include/hw/nvram/fw_cfg.h
 F: include/standard-headers/linux/qemu_fw_cfg.h
diff --git a/hw/nvram/fw_cfg-interface.c b/hw/nvram/fw_cfg-interface.c
new file mode 100644
index 0000000000..0e93feeae5
--- /dev/null
+++ b/hw/nvram/fw_cfg-interface.c
@@ -0,0 +1,23 @@
+/*
+ * QEMU Firmware configuration device emulation (QOM interfaces)
+ *
+ * Copyright 2020 Red Hat, Inc.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "hw/nvram/fw_cfg.h"
+
+static const TypeInfo fw_cfg_data_generator_interface_info = {
+    .parent = TYPE_INTERFACE,
+    .name = TYPE_FW_CFG_DATA_GENERATOR_INTERFACE,
+    .class_size = sizeof(FWCfgDataGeneratorClass),
+};
+
+static void fw_cfg_register_interfaces(void)
+{
+    type_register_static(&fw_cfg_data_generator_interface_info);
+}
+
+type_init(fw_cfg_register_interfaces)
diff --git a/hw/nvram/fw_cfg.c b/hw/nvram/fw_cfg.c
index 0e95d057fd..08539a1aab 100644
--- a/hw/nvram/fw_cfg.c
+++ b/hw/nvram/fw_cfg.c
@@ -1360,18 +1360,11 @@ static const TypeInfo fw_cfg_mem_info = {
     .class_init    = fw_cfg_mem_class_init,
 };
 
-static const TypeInfo fw_cfg_data_generator_interface_info = {
-    .parent = TYPE_INTERFACE,
-    .name = TYPE_FW_CFG_DATA_GENERATOR_INTERFACE,
-    .class_size = sizeof(FWCfgDataGeneratorClass),
-};
-
 static void fw_cfg_register_types(void)
 {
     type_register_static(&fw_cfg_info);
     type_register_static(&fw_cfg_io_info);
     type_register_static(&fw_cfg_mem_info);
-    type_register_static(&fw_cfg_data_generator_interface_info);
 }
 
 type_init(fw_cfg_register_types)
diff --git a/hw/nvram/meson.build b/hw/nvram/meson.build
index 1f2ed013b2..fd2951a860 100644
--- a/hw/nvram/meson.build
+++ b/hw/nvram/meson.build
@@ -1,3 +1,6 @@
+# QOM interfaces must be available anytime QOM is used.
+qom_ss.add(files('fw_cfg-interface.c'))
+
 softmmu_ss.add(files('fw_cfg.c'))
 softmmu_ss.add(when: 'CONFIG_CHRP_NVRAM', if_true: files('chrp_nvram.c'))
 softmmu_ss.add(when: 'CONFIG_DS1225Y', if_true: files('ds1225y.c'))
-- 
2.26.2



