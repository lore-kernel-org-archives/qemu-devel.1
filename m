Received: from eggs.gnu.org ([2001:4830:134:3::10]:54414)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gVJLm-0001e8-Mh
	for qemu-devel@nongnu.org; Fri, 07 Dec 2018 11:51:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gVJLh-0006Y2-6W
	for qemu-devel@nongnu.org; Fri, 07 Dec 2018 11:51:34 -0500
Received: from mx1.redhat.com ([209.132.183.28]:59750)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gVJLd-0006Iw-8L
	for qemu-devel@nongnu.org; Fri, 07 Dec 2018 11:51:31 -0500
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Date: Fri,  7 Dec 2018 17:51:02 +0100
Message-Id: <20181207165103.3992-4-philmd@redhat.com>
In-Reply-To: <20181207165103.3992-1-philmd@redhat.com>
References: <20181207165103.3992-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 3/4] hw/smbios: Remove "smbios_ipmi.h"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, Corey Minyard <minyard@acm.org>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>, qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>, Laszlo Ersek <lersek@redhat.com>

This header only declare a single function: smbios_build_type_38_table().
We already have a header that declares such functions: "smbios_build.h".
Move the declaration and remove the header.

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 hw/smbios/smbios.c              |  1 -
 hw/smbios/smbios_build.h        |  4 ++++
 hw/smbios/smbios_ipmi.h         | 15 ---------------
 hw/smbios/smbios_type_38-stub.c |  2 +-
 hw/smbios/smbios_type_38.c      |  1 -
 5 files changed, 5 insertions(+), 18 deletions(-)
 delete mode 100644 hw/smbios/smbios_ipmi.h

diff --git a/hw/smbios/smbios.c b/hw/smbios/smbios.c
index 30bd4731cf..9d737642cb 100644
--- a/hw/smbios/smbios.c
+++ b/hw/smbios/smbios.c
@@ -28,7 +28,6 @@
 #include "hw/loader.h"
 #include "exec/cpu-common.h"
 #include "smbios_build.h"
-#include "smbios_ipmi.h"
=20
 /* legacy structures and constants for <=3D 2.0 machines */
 struct smbios_header {
diff --git a/hw/smbios/smbios_build.h b/hw/smbios/smbios_build.h
index 93b360d520..56b5a1e3f3 100644
--- a/hw/smbios/smbios_build.h
+++ b/hw/smbios/smbios_build.h
@@ -3,6 +3,7 @@
  *
  * Copyright (C) 2009 Hewlett-Packard Development Company, L.P.
  * Copyright (C) 2013 Red Hat, Inc.
+ * Copyright (c) 2015,2016 Corey Minyard, MontaVista Software, LLC
  *
  * Authors:
  *  Alex Williamson <alex.williamson@hp.com>
@@ -96,4 +97,7 @@ extern unsigned smbios_table_cnt;
         smbios_table_cnt++;                                             =
  \
     } while (0)
=20
+/* IPMI SMBIOS firmware handling */
+void smbios_build_type_38_table(void);
+
 #endif /* QEMU_SMBIOS_BUILD_H */
diff --git a/hw/smbios/smbios_ipmi.h b/hw/smbios/smbios_ipmi.h
deleted file mode 100644
index 1c9aae38f2..0000000000
--- a/hw/smbios/smbios_ipmi.h
+++ /dev/null
@@ -1,15 +0,0 @@
-/*
- * IPMI SMBIOS firmware handling
- *
- * Copyright (c) 2015,2016 Corey Minyard, MontaVista Software, LLC
- *
- * This work is licensed under the terms of the GNU GPL, version 2 or la=
ter.
- * See the COPYING file in the top-level directory.
- */
-
-#ifndef QEMU_SMBIOS_IPMI_H
-#define QEMU_SMBIOS_IPMI_H
-
-void smbios_build_type_38_table(void);
-
-#endif /* QEMU_SMBIOS_IPMI_H */
diff --git a/hw/smbios/smbios_type_38-stub.c b/hw/smbios/smbios_type_38-s=
tub.c
index fc4516bc8a..14b53d004b 100644
--- a/hw/smbios/smbios_type_38-stub.c
+++ b/hw/smbios/smbios_type_38-stub.c
@@ -8,7 +8,7 @@
  */
=20
 #include "qemu/osdep.h"
-#include "smbios_ipmi.h"
+#include "smbios_build.h"
=20
 void smbios_build_type_38_table(void)
 {
diff --git a/hw/smbios/smbios_type_38.c b/hw/smbios/smbios_type_38.c
index d84e87d608..a1ad28d059 100644
--- a/hw/smbios/smbios_type_38.c
+++ b/hw/smbios/smbios_type_38.c
@@ -12,7 +12,6 @@
 #include "hw/smbios/smbios.h"
 #include "qemu/error-report.h"
 #include "smbios_build.h"
-#include "smbios_ipmi.h"
=20
 /* SMBIOS type 38 - IPMI */
 struct smbios_type_38 {
--=20
2.17.2
