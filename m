Return-Path: <SRS0=TP+Q=TA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44B2DC43219
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2019 19:28:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1075B2063F
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2019 19:28:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1075B2063F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:52209 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hLYQj-0006P7-Ao
	for qemu-devel@archiver.kernel.org; Tue, 30 Apr 2019 15:28:41 -0400
Received: from eggs.gnu.org ([209.51.188.92]:40850)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1hLYN2-0003MD-EX
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 15:24:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1hLYEX-0006wv-VX
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 15:16:08 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44672)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>)
	id 1hLYEU-0006t1-P7; Tue, 30 Apr 2019 15:16:03 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id E4F2230842A1;
	Tue, 30 Apr 2019 19:16:01 +0000 (UTC)
Received: from thuth.com (ovpn-116-21.ams2.redhat.com [10.36.116.21])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 33861438A;
	Tue, 30 Apr 2019 19:15:55 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, qemu-devel@nongnu.org
Date: Tue, 30 Apr 2019 21:15:52 +0200
Message-Id: <20190430191552.4027-1-thuth@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.40]);
	Tue, 30 Apr 2019 19:16:02 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v2] hw/pci-host: Use object_initialize_child
 for correct reference counting
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
Cc: Paul Burton <pburton@wavecomp.com>,
	Aleksandar Rikalo <arikalo@wavecomp.com>,
	Andrey Smirnov <andrew.smirnov@gmail.com>,
	qemu-trivial@nongnu.org, qemu-arm@nongnu.org,
	=?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190430191552.4G-pWBf3gIG8X6X86kMsOkS0YIRBnVsRCmHOE4CoSHY@z>

Both functions, object_initialize() and object_property_add_child() incre=
ase
the reference counter of the new object, so one of the references has to =
be
dropped afterwards to get the reference counting right. Otherwise the chi=
ld
object might not be properly cleaned up when the parent gets destroyed.
Some functions of the pci-host devices miss to drop one of the references=
.
Fix it by using object_initialize_child() instead, which takes care of
calling object_initialize(), object_property_add_child() and object_unref=
()
in the right order.

Suggested-by: Eduardo Habkost <ehabkost@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 v2: Added missing &error_abort parameter in xilinx-pcie.c

 hw/pci-host/designware.c  | 4 ++--
 hw/pci-host/gpex.c        | 5 +++--
 hw/pci-host/q35.c         | 4 ++--
 hw/pci-host/xilinx-pcie.c | 4 ++--
 4 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/hw/pci-host/designware.c b/hw/pci-host/designware.c
index 29ea313798..64ad21d295 100644
--- a/hw/pci-host/designware.c
+++ b/hw/pci-host/designware.c
@@ -721,8 +721,8 @@ static void designware_pcie_host_init(Object *obj)
     DesignwarePCIEHost *s =3D DESIGNWARE_PCIE_HOST(obj);
     DesignwarePCIERoot *root =3D &s->root;
=20
-    object_initialize(root, sizeof(*root), TYPE_DESIGNWARE_PCIE_ROOT);
-    object_property_add_child(obj, "root", OBJECT(root), NULL);
+    object_initialize_child(obj, "root",  root, sizeof(*root),
+                            TYPE_DESIGNWARE_PCIE_ROOT, &error_abort, NUL=
L);
     qdev_prop_set_int32(DEVICE(root), "addr", PCI_DEVFN(0, 0));
     qdev_prop_set_bit(DEVICE(root), "multifunction", false);
 }
diff --git a/hw/pci-host/gpex.c b/hw/pci-host/gpex.c
index 2583b151a4..1bafffcc34 100644
--- a/hw/pci-host/gpex.c
+++ b/hw/pci-host/gpex.c
@@ -29,6 +29,7 @@
  * http://www.firmware.org/1275/practice/imap/imap0_9d.pdf
  */
 #include "qemu/osdep.h"
+#include "qapi/error.h"
 #include "hw/hw.h"
 #include "hw/pci-host/gpex.h"
=20
@@ -120,8 +121,8 @@ static void gpex_host_initfn(Object *obj)
     GPEXHost *s =3D GPEX_HOST(obj);
     GPEXRootState *root =3D &s->gpex_root;
=20
-    object_initialize(root, sizeof(*root), TYPE_GPEX_ROOT_DEVICE);
-    object_property_add_child(obj, "gpex_root", OBJECT(root), NULL);
+    object_initialize_child(obj, "gpex_root",  root, sizeof(*root),
+                            TYPE_GPEX_ROOT_DEVICE, &error_abort, NULL);
     qdev_prop_set_int32(DEVICE(root), "addr", PCI_DEVFN(0, 0));
     qdev_prop_set_bit(DEVICE(root), "multifunction", false);
 }
diff --git a/hw/pci-host/q35.c b/hw/pci-host/q35.c
index 7b871b5734..960939f5ed 100644
--- a/hw/pci-host/q35.c
+++ b/hw/pci-host/q35.c
@@ -216,8 +216,8 @@ static void q35_host_initfn(Object *obj)
     memory_region_init_io(&phb->data_mem, obj, &pci_host_data_le_ops, ph=
b,
                           "pci-conf-data", 4);
=20
-    object_initialize(&s->mch, sizeof(s->mch), TYPE_MCH_PCI_DEVICE);
-    object_property_add_child(OBJECT(s), "mch", OBJECT(&s->mch), NULL);
+    object_initialize_child(OBJECT(s), "mch",  &s->mch, sizeof(s->mch),
+                            TYPE_MCH_PCI_DEVICE, &error_abort, NULL);
     qdev_prop_set_int32(DEVICE(&s->mch), "addr", PCI_DEVFN(0, 0));
     qdev_prop_set_bit(DEVICE(&s->mch), "multifunction", false);
     /* mch's object_initialize resets the default value, set it again */
diff --git a/hw/pci-host/xilinx-pcie.c b/hw/pci-host/xilinx-pcie.c
index 60309afe9e..ceb00e23e6 100644
--- a/hw/pci-host/xilinx-pcie.c
+++ b/hw/pci-host/xilinx-pcie.c
@@ -149,8 +149,8 @@ static void xilinx_pcie_host_init(Object *obj)
     XilinxPCIEHost *s =3D XILINX_PCIE_HOST(obj);
     XilinxPCIERoot *root =3D &s->root;
=20
-    object_initialize(root, sizeof(*root), TYPE_XILINX_PCIE_ROOT);
-    object_property_add_child(obj, "root", OBJECT(root), NULL);
+    object_initialize_child(obj, "root",  root, sizeof(*root),
+                            TYPE_XILINX_PCIE_ROOT, &error_abort, NULL);
     qdev_prop_set_int32(DEVICE(root), "addr", PCI_DEVFN(0, 0));
     qdev_prop_set_bit(DEVICE(root), "multifunction", false);
 }
--=20
2.21.0


