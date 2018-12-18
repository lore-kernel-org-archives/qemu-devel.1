Received: from eggs.gnu.org ([2001:4830:134:3::10]:50865)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gZ6on-0004gB-Ou
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 23:17:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gZ6oi-0006Zi-EA
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 23:17:17 -0500
Received: from mx1.redhat.com ([209.132.183.28]:57744)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1gZ6oi-0006YR-1L
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 23:17:12 -0500
Date: Mon, 17 Dec 2018 23:17:07 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20181218041625.24969-8-mst@redhat.com>
References: <20181218041625.24969-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181218041625.24969-1-mst@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 07/31] hw/smbios: Remove "smbios_ipmi.h"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>, Corey Minyard <cminyard@mvista.com>, Laszlo Ersek <lersek@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Corey Minyard <minyard@acm.org>

From: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

This header only declare a single function: smbios_build_type_38_table().
We already have a header that declares such functions: "smbios_build.h".
Move the declaration and remove the header.

Reviewed-by: Corey Minyard <cminyard@mvista.com>
Reviewed-by: Laszlo Ersek <lersek@redhat.com>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/smbios/smbios_build.h        |  4 ++++
 hw/smbios/smbios_ipmi.h         | 15 ---------------
 hw/smbios/smbios.c              |  1 -
 hw/smbios/smbios_type_38-stub.c |  2 +-
 hw/smbios/smbios_type_38.c      |  1 -
 5 files changed, 5 insertions(+), 18 deletions(-)
 delete mode 100644 hw/smbios/smbios_ipmi.h

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
diff --git a/hw/smbios/smbios.c b/hw/smbios/smbios.c
index 6fe5be3586..4bff9b5ea4 100644
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
MST
