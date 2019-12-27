Return-Path: <SRS0=GTQb=2R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC71FC2D0C3
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Dec 2019 21:40:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7EDDC20740
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Dec 2019 21:40:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="C+e/0Lcu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7EDDC20740
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39012 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ikxLu-00027w-NQ
	for qemu-devel@archiver.kernel.org; Fri, 27 Dec 2019 16:40:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53712)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1ikxKn-0001WE-W3
 for qemu-devel@nongnu.org; Fri, 27 Dec 2019 16:39:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1ikxKm-0003jE-OF
 for qemu-devel@nongnu.org; Fri, 27 Dec 2019 16:39:49 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:45828
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1ikxKm-0003ip-Cp
 for qemu-devel@nongnu.org; Fri, 27 Dec 2019 16:39:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1577482787;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=JddPreseXa373G3sm6VTZnG8Rqhp56iCtGqja4H5xPc=;
 b=C+e/0LcuWqM/M7l/7qVAJ/2Evc9ybwu4Vbh/7a9nfTb/sSZj+74UzMz+7zct8j8dfxp3rI
 1/5T89sQGBciaxX/NF9ktUZinnXwyHcnK0JpZwSM5pViCtLmednH4sXKvjAGSMHDeujbGD
 XJtnM5Yq4FnpRJ0feODU2pgKNzTKf5s=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-422-CkIoTiKuNeybEZRY6p2ASw-1; Fri, 27 Dec 2019 16:39:45 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C258F1005513;
 Fri, 27 Dec 2019 21:39:44 +0000 (UTC)
Received: from x1w.redhat.com (ovpn-116-37.ams2.redhat.com [10.36.116.37])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 9327219C5B;
 Fri, 27 Dec 2019 21:39:34 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2] hw/i386: Allow building machines without IOMMU
Date: Fri, 27 Dec 2019 22:39:31 +0100
Message-Id: <20191227213931.6286-1-philmd@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: CkIoTiKuNeybEZRY6p2ASw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.61
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
 "Michael S. Tsirkin" <mst@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Commit 6c730e4af9 introduced a stub to build the MicroVM machine
without Intel IOMMU suppport. However when configure with
--without-default-devices, the build fails:

    LINK    x86_64-softmmu/qemu-system-x86_64
  /usr/bin/ld: hw/i386/pc.o: in function `pc_machine_done':
  hw/i386/pc.c:869: undefined reference to `x86_iommu_ir_supported'
  /usr/bin/ld: hw/i386/acpi-build.o: in function `acpi_build':
  hw/i386/acpi-build.c:2844: undefined reference to `x86_iommu_get_type'
  /usr/bin/ld: hw/i386/acpi-build.o: in function `build_dmar_q35':
  hw/i386/acpi-build.c:2478: undefined reference to `x86_iommu_ir_supported=
'
  /usr/bin/ld: hw/i386/acpi-build.o: in function `build_amd_iommu':
  hw/i386/acpi-build.c:2665: undefined reference to `x86_iommu_ir_supported=
'
  /usr/bin/ld: hw/i386/acpi-build.c:2700: undefined reference to `x86_iommu=
_ir_supported'
  collect2: error: ld returned 1 exit status
  make[1]: *** [Makefile:206: qemu-system-x86_64] Error 1

Since currently all PC machines can not be built without IOMMU,
select X86_IOMMU in the PC config, and remove the stubs.

Fixes: 6c730e4af9
Reported-by: Travis-CI
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
v2: simplify, remove the stub.
---
 hw/i386/x86-iommu-stub.c | 34 ----------------------------------
 hw/i386/Kconfig          |  2 +-
 hw/i386/Makefile.objs    |  1 -
 3 files changed, 1 insertion(+), 36 deletions(-)
 delete mode 100644 hw/i386/x86-iommu-stub.c

diff --git a/hw/i386/x86-iommu-stub.c b/hw/i386/x86-iommu-stub.c
deleted file mode 100644
index 03576cdccb..0000000000
--- a/hw/i386/x86-iommu-stub.c
+++ /dev/null
@@ -1,34 +0,0 @@
-/*
- * Stubs for X86 IOMMU emulation
- *
- * Copyright (C) 2019 Red Hat, Inc.
- *
- * Author: Paolo Bonzini <pbonzini@redhat.com>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
-
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
-
- * You should have received a copy of the GNU General Public License along
- * with this program; if not, see <http://www.gnu.org/licenses/>.
- */
-
-#include "qemu/osdep.h"
-#include "hw/i386/x86-iommu.h"
-
-void x86_iommu_iec_register_notifier(X86IOMMUState *iommu,
-                                     iec_notify_fn fn, void *data)
-{
-}
-
-X86IOMMUState *x86_iommu_get_default(void)
-{
-    return NULL;
-}
-
diff --git a/hw/i386/Kconfig b/hw/i386/Kconfig
index 91cf5843b4..e428322a2c 100644
--- a/hw/i386/Kconfig
+++ b/hw/i386/Kconfig
@@ -35,6 +35,7 @@ config PC
     select ACPI_PCI
     select ACPI_VMGENID
     select VIRTIO_PMEM_SUPPORTED
+    select X86_IOMMU
=20
 config PC_PCI
     bool
@@ -105,7 +106,6 @@ config MICROVM
=20
 config X86_IOMMU
     bool
-    depends on PC
=20
 config VTD
     bool
diff --git a/hw/i386/Makefile.objs b/hw/i386/Makefile.objs
index 8ce1b26533..6ebb6d0cf0 100644
--- a/hw/i386/Makefile.objs
+++ b/hw/i386/Makefile.objs
@@ -7,7 +7,6 @@ obj-$(CONFIG_Q35) +=3D pc_q35.o
 obj-$(CONFIG_MICROVM) +=3D microvm.o
 obj-y +=3D fw_cfg.o
 obj-$(CONFIG_X86_IOMMU) +=3D x86-iommu.o
-obj-$(call lnot,$(CONFIG_X86_IOMMU)) +=3D x86-iommu-stub.o
 obj-$(CONFIG_VTD) +=3D intel_iommu.o
 obj-$(CONFIG_AMD_IOMMU) +=3D amd_iommu.o
 obj-$(CONFIG_XEN) +=3D ../xenpv/ xen/
--=20
2.21.0


