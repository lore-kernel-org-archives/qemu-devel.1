Return-Path: <SRS0=bvyN=TX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D880C282DD
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2019 13:11:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1F5AB20851
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2019 13:11:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F5AB20851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:35871 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hTnVi-0000iu-5H
	for qemu-devel@archiver.kernel.org; Thu, 23 May 2019 09:11:54 -0400
Received: from eggs.gnu.org ([209.51.188.92]:51307)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hTnH2-0003rP-TP
	for qemu-devel@nongnu.org; Thu, 23 May 2019 08:56:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hTn4i-00013F-TB
	for qemu-devel@nongnu.org; Thu, 23 May 2019 08:44:01 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56256)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <philmd@redhat.com>)
	id 1hTn4i-00012w-Oq; Thu, 23 May 2019 08:44:00 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 0E1E7C02938A;
	Thu, 23 May 2019 12:44:00 +0000 (UTC)
Received: from x1w.redhat.com (unknown [10.40.205.5])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 95B165D9C3;
	Thu, 23 May 2019 12:43:56 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Date: Thu, 23 May 2019 14:43:09 +0200
Message-Id: <20190523124320.28726-5-philmd@redhat.com>
In-Reply-To: <20190523124320.28726-1-philmd@redhat.com>
References: <20190523124320.28726-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.32]);
	Thu, 23 May 2019 12:44:00 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 04/15] hw/i386: Implement fw_cfg_arch_key_name()
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
	"Michael S. Tsirkin" <mst@redhat.com>, Laszlo Ersek <lersek@redhat.com>,
	Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
	qemu-ppc@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>,
	Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>,
	=?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
	Artyom Tarasenko <atar4qemu@gmail.com>,
	David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Implement fw_cfg_arch_key_name(), which returns the name of a
i386-specific key.

Reviewed-by: Laszlo Ersek <lersek@redhat.com>
Message-Id: <20190422195020.1494-5-philmd@redhat.com>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 hw/i386/Makefile.objs |  2 +-
 hw/i386/fw_cfg.c      | 38 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 39 insertions(+), 1 deletion(-)
 create mode 100644 hw/i386/fw_cfg.c

diff --git a/hw/i386/Makefile.objs b/hw/i386/Makefile.objs
index 27248a0777..5d9c9efd5f 100644
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
index 0000000000..380a819230
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
+        {FW_CFG_E820_TABLE, "e820_table"},
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


