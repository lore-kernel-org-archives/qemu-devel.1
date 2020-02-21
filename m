Return-Path: <SRS0=IEfc=4J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15B2DC11D00
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2020 03:38:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D929A24650
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2020 03:38:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="hBgRM5sZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D929A24650
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51690 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j4z97-00041l-Tt
	for qemu-devel@archiver.kernel.org; Thu, 20 Feb 2020 22:38:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48718)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1j4z7p-0001vy-FB
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 22:37:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1j4z7o-00086W-4K
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 22:37:13 -0500
Received: from bilbo.ozlabs.org ([2401:3900:2:1::2]:57821 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1j4z7n-0007xJ-PG; Thu, 20 Feb 2020 22:37:12 -0500
Received: by ozlabs.org (Postfix, from userid 1007)
 id 48NxwC2yr6z9sRk; Fri, 21 Feb 2020 14:36:59 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1582256219;
 bh=DEHDVMalz9zs15THZDn1i6nHVsdLT9AX731WB3rmaXk=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=hBgRM5sZDlWBwD68nrPnTOeu23WhYAiq4VVQAys6GxMY5a+JBZCUZG8sgXihVX9yk
 Y/8xTyMDPKKt9TF3EhILQa5wjfDVxOfUAyaKgrjWns90UzN1ROhvx0TzIKCXzpWHsy
 mNnqrz8EehgiYJ/MSqLg5qw7yYbw28W9/CpnKPXY=
From: David Gibson <david@gibson.dropbear.id.au>
To: peter.maydell@linaro.org
Subject: [PULL 05/20] mem: move nvdimm_device_list to utilities
Date: Fri, 21 Feb 2020 14:36:35 +1100
Message-Id: <20200221033650.444386-6-david@gibson.dropbear.id.au>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200221033650.444386-1-david@gibson.dropbear.id.au>
References: <20200221033650.444386-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2401:3900:2:1::2
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
Cc: lvivier@redhat.com, Shivaprasad G Bhat <sbhat@linux.ibm.com>, aik@ozlabs.ru,
 qemu-devel@nongnu.org, groug@kaod.org, qemu-ppc@nongnu.org, clg@kaod.org,
 Igor Mammedov <imammedo@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Shivaprasad G Bhat <sbhat@linux.ibm.com>

nvdimm_device_list is required for parsing the list for devices
in subsequent patches. Move it to common utility area.

Signed-off-by: Shivaprasad G Bhat <sbhat@linux.ibm.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
Message-Id: <158131055857.2897.15658377276504711773.stgit@lep8c.aus.stgla=
bs.ibm.com>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/acpi/nvdimm.c            | 28 +---------------------------
 include/qemu/nvdimm-utils.h |  7 +++++++
 util/Makefile.objs          |  1 +
 util/nvdimm-utils.c         | 29 +++++++++++++++++++++++++++++
 4 files changed, 38 insertions(+), 27 deletions(-)
 create mode 100644 include/qemu/nvdimm-utils.h
 create mode 100644 util/nvdimm-utils.c

diff --git a/hw/acpi/nvdimm.c b/hw/acpi/nvdimm.c
index 9fdad6dc3f..5219dd0e2e 100644
--- a/hw/acpi/nvdimm.c
+++ b/hw/acpi/nvdimm.c
@@ -32,33 +32,7 @@
 #include "hw/acpi/bios-linker-loader.h"
 #include "hw/nvram/fw_cfg.h"
 #include "hw/mem/nvdimm.h"
-
-static int nvdimm_device_list(Object *obj, void *opaque)
-{
-    GSList **list =3D opaque;
-
-    if (object_dynamic_cast(obj, TYPE_NVDIMM)) {
-        *list =3D g_slist_append(*list, DEVICE(obj));
-    }
-
-    object_child_foreach(obj, nvdimm_device_list, opaque);
-    return 0;
-}
-
-/*
- * inquire NVDIMM devices and link them into the list which is
- * returned to the caller.
- *
- * Note: it is the caller's responsibility to free the list to avoid
- * memory leak.
- */
-static GSList *nvdimm_get_device_list(void)
-{
-    GSList *list =3D NULL;
-
-    object_child_foreach(qdev_get_machine(), nvdimm_device_list, &list);
-    return list;
-}
+#include "qemu/nvdimm-utils.h"
=20
 #define NVDIMM_UUID_LE(a, b, c, d0, d1, d2, d3, d4, d5, d6, d7)         =
    \
    { (a) & 0xff, ((a) >> 8) & 0xff, ((a) >> 16) & 0xff, ((a) >> 24) & 0x=
ff, \
diff --git a/include/qemu/nvdimm-utils.h b/include/qemu/nvdimm-utils.h
new file mode 100644
index 0000000000..4b8b198ba7
--- /dev/null
+++ b/include/qemu/nvdimm-utils.h
@@ -0,0 +1,7 @@
+#ifndef NVDIMM_UTILS_H
+#define NVDIMM_UTILS_H
+
+#include "qemu/osdep.h"
+
+GSList *nvdimm_get_device_list(void);
+#endif
diff --git a/util/Makefile.objs b/util/Makefile.objs
index 11262aafaf..6b38b67cf1 100644
--- a/util/Makefile.objs
+++ b/util/Makefile.objs
@@ -20,6 +20,7 @@ util-obj-y +=3D envlist.o path.o module.o
 util-obj-y +=3D host-utils.o
 util-obj-y +=3D bitmap.o bitops.o hbitmap.o
 util-obj-y +=3D fifo8.o
+util-obj-y +=3D nvdimm-utils.o
 util-obj-y +=3D cacheinfo.o
 util-obj-y +=3D error.o qemu-error.o
 util-obj-y +=3D qemu-print.o
diff --git a/util/nvdimm-utils.c b/util/nvdimm-utils.c
new file mode 100644
index 0000000000..5cc768ca47
--- /dev/null
+++ b/util/nvdimm-utils.c
@@ -0,0 +1,29 @@
+#include "qemu/nvdimm-utils.h"
+#include "hw/mem/nvdimm.h"
+
+static int nvdimm_device_list(Object *obj, void *opaque)
+{
+    GSList **list =3D opaque;
+
+    if (object_dynamic_cast(obj, TYPE_NVDIMM)) {
+        *list =3D g_slist_append(*list, DEVICE(obj));
+    }
+
+    object_child_foreach(obj, nvdimm_device_list, opaque);
+    return 0;
+}
+
+/*
+ * inquire NVDIMM devices and link them into the list which is
+ * returned to the caller.
+ *
+ * Note: it is the caller's responsibility to free the list to avoid
+ * memory leak.
+ */
+GSList *nvdimm_get_device_list(void)
+{
+    GSList *list =3D NULL;
+
+    object_child_foreach(qdev_get_machine(), nvdimm_device_list, &list);
+    return list;
+}
--=20
2.24.1


