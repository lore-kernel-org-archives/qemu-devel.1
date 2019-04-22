Return-Path: <SRS0=5Zkg=SY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEE21C10F11
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Apr 2019 19:53:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7EADB204EC
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Apr 2019 19:53:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7EADB204EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:43496 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hIezt-0005sJ-Nn
	for qemu-devel@archiver.kernel.org; Mon, 22 Apr 2019 15:53:01 -0400
Received: from eggs.gnu.org ([209.51.188.92]:58758)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hIey2-0004j2-Qb
	for qemu-devel@nongnu.org; Mon, 22 Apr 2019 15:51:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hIey1-0008Fc-PL
	for qemu-devel@nongnu.org; Mon, 22 Apr 2019 15:51:06 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40368)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <philmd@redhat.com>)
	id 1hIey1-0008FF-JB; Mon, 22 Apr 2019 15:51:05 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C6EC53082B6A;
	Mon, 22 Apr 2019 19:51:04 +0000 (UTC)
Received: from x1w.redhat.com (ovpn-204-61.brq.redhat.com [10.40.204.61])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 4A62C5D71E;
	Mon, 22 Apr 2019 19:50:58 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Date: Mon, 22 Apr 2019 21:50:17 +0200
Message-Id: <20190422195020.1494-5-philmd@redhat.com>
In-Reply-To: <20190422195020.1494-1-philmd@redhat.com>
References: <20190422195020.1494-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.45]);
	Mon, 22 Apr 2019 19:51:04 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v3 4/7] hw/i386: Implement
 fw_cfg_arch_key_name()
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
Cc: Eduardo Habkost <ehabkost@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	=?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
	Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
	qemu-ppc@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>,
	Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>,
	Laszlo Ersek <lersek@redhat.com>, Artyom Tarasenko <atar4qemu@gmail.com>,
	David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190422195017.oLVqd17ZWXfhU8EGWbZa7SyFOqU9aPzLKQLfB7QiCio@z>

Implement fw_cfg_arch_key_name(), which returns the name of a
i386-specific key.

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 hw/i386/Makefile.objs |  2 +-
 hw/i386/fw_cfg.c      | 38 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 39 insertions(+), 1 deletion(-)
 create mode 100644 hw/i386/fw_cfg.c

diff --git a/hw/i386/Makefile.objs b/hw/i386/Makefile.objs
index 27248a0777c..5d9c9efd5fa 100644
--- a/hw/i386/Makefile.objs
+++ b/hw/i386/Makefile.objs
@@ -3,7 +3,7 @@ obj-y +=3D multiboot.o
 obj-y +=3D pc.o
 obj-$(CONFIG_I440FX) +=3D pc_piix.o
 obj-$(CONFIG_Q35) +=3D pc_q35.o
-obj-y +=3D pc_sysfw.o
+obj-y +=3D fw_cfg.o pc_sysfw.o
 obj-y +=3D x86-iommu.o
 obj-$(CONFIG_VTD) +=3D intel_iommu.o
 obj-$(CONFIG_AMD_IOMMU) +=3D amd_iommu.o
diff --git a/hw/i386/fw_cfg.c b/hw/i386/fw_cfg.c
new file mode 100644
index 00000000000..c5e8b4ead0b
--- /dev/null
+++ b/hw/i386/fw_cfg.c
@@ -0,0 +1,38 @@
+/*
+ * QEMU fw_cfg helpers (X86 specific)
+ *
+ * Copyright (c) 2019 Red Hat, Inc.
+ *
+ * Author:
+ *   Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or la=
ter.
+ * See the COPYING file in the top-level directory.
+ */
+
+#include "qemu/osdep.h"
+#include "hw/i386/fw_cfg.h"
+#include "hw/nvram/fw_cfg.h"
+
+const char *fw_cfg_arch_key_name(uint16_t key)
+{
+    static const struct {
+        uint16_t key;
+        const char *name;
+    } fw_cfg_arch_wellknown_keys[] =3D {
+        {FW_CFG_ACPI_TABLES, "acpi_tables"},
+        {FW_CFG_SMBIOS_ENTRIES, "smbios_entries"},
+        {FW_CFG_IRQ0_OVERRIDE, "irq0_override"},
+        {FW_CFG_E820_TABLE, "e820_tables"},
+        {FW_CFG_HPET, "hpet"},
+    };
+
+    for (size_t i =3D 0; i < ARRAY_SIZE(fw_cfg_arch_wellknown_keys); i++=
) {
+        if (fw_cfg_arch_wellknown_keys[i].key =3D=3D key) {
+            return fw_cfg_arch_wellknown_keys[i].name;
+        }
+    }
+    return NULL;
+}
--=20
2.20.1


