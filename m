Received: from eggs.gnu.org ([209.51.188.92]:36948)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1gkBFf-0001u5-Vz
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 12:14:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1gkBFe-0007DN-R8
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 12:14:47 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:48598)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1gkBFe-0007CB-GD
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 12:14:46 -0500
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	x0HHETk6034071
	for <qemu-devel@nongnu.org>; Thu, 17 Jan 2019 12:14:44 -0500
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2q2u5m0a06-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 17 Jan 2019 12:14:43 -0500
Received: from localhost
	by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <groug@kaod.org>;
	Thu, 17 Jan 2019 17:14:40 -0000
From: Greg Kurz <groug@kaod.org>
Date: Thu, 17 Jan 2019 18:14:32 +0100
In-Reply-To: <154774526588.1208625.11295698301887807297.stgit@bahia.lan>
References: <154774526588.1208625.11295698301887807297.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <154774527276.1208625.13503150622689394843.stgit@bahia.lan>
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v3 01/19] ppc: Move spapr-related prototypes
 from xics.h into a seperate header file
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, qemu-s390x@nongnu.org, Greg Kurz <groug@kaod.org>, Alexey Kardashevskiy <aik@ozlabs.ru>, =?utf-8?q?C=C3=A9dric?= Le Goater <clg@kaod.org>, Michael Roth <mdroth@linux.vnet.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, David Hildenbrand <david@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Dmitry Fleytman <dmitry.fleytman@gmail.com>, Thomas Huth <thuth@redhat.com>

From: Thomas Huth <thuth@redhat.com>

When compiling with Clang in -std=3Dgnu99 mode, there is a warning/error:

  CC      ppc64-softmmu/hw/intc/xics_spapr.o
In file included from /home/thuth/devel/qemu/hw/intc/xics_spapr.c:34:
/home/thuth/devel/qemu/include/hw/ppc/xics.h:203:34: error: redefinition =
of typedef 'sPAPRMachineState' is a C11 feature
      [-Werror,-Wtypedef-redefinition]
typedef struct sPAPRMachineState sPAPRMachineState;
                                 ^
/home/thuth/devel/qemu/include/hw/ppc/spapr_irq.h:25:34: note: previous d=
efinition is here
typedef struct sPAPRMachineState sPAPRMachineState;
                                 ^

We have to remove the duplicated typedef here and include "spapr.h" inste=
ad.
But "spapr.h" should not be included for the pnv machine files. So move
the spapr-related prototypes into a new file called "xics_spapr.h" instea=
d.

Reviewed-by: Greg Kurz <groug@kaod.org>
Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>
Signed-off-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Signed-off-by: Greg Kurz <groug@kaod.org>
---

This patch should be merged through Thomas's tree soon. It is needed
because other patches in this series depend on it.
---
 hw/intc/xics_kvm.c          |    1 +
 hw/intc/xics_spapr.c        |    1 +
 hw/ppc/spapr_irq.c          |    1 +
 include/hw/ppc/xics.h       |    7 -------
 include/hw/ppc/xics_spapr.h |   37 +++++++++++++++++++++++++++++++++++++
 5 files changed, 40 insertions(+), 7 deletions(-)
 create mode 100644 include/hw/ppc/xics_spapr.h

diff --git a/hw/intc/xics_kvm.c b/hw/intc/xics_kvm.c
index ac94594b1919..dff13300504c 100644
--- a/hw/intc/xics_kvm.c
+++ b/hw/intc/xics_kvm.c
@@ -34,6 +34,7 @@
 #include "sysemu/kvm.h"
 #include "hw/ppc/spapr.h"
 #include "hw/ppc/xics.h"
+#include "hw/ppc/xics_spapr.h"
 #include "kvm_ppc.h"
 #include "qemu/config-file.h"
 #include "qemu/error-report.h"
diff --git a/hw/intc/xics_spapr.c b/hw/intc/xics_spapr.c
index 9c1a90d7094b..de6cc15b6474 100644
--- a/hw/intc/xics_spapr.c
+++ b/hw/intc/xics_spapr.c
@@ -32,6 +32,7 @@
 #include "qemu/timer.h"
 #include "hw/ppc/spapr.h"
 #include "hw/ppc/xics.h"
+#include "hw/ppc/xics_spapr.h"
 #include "hw/ppc/fdt.h"
 #include "qapi/visitor.h"
=20
diff --git a/hw/ppc/spapr_irq.c b/hw/ppc/spapr_irq.c
index 5fce72fe0f6c..1da7a32348fc 100644
--- a/hw/ppc/spapr_irq.c
+++ b/hw/ppc/spapr_irq.c
@@ -14,6 +14,7 @@
 #include "hw/ppc/spapr.h"
 #include "hw/ppc/spapr_xive.h"
 #include "hw/ppc/xics.h"
+#include "hw/ppc/xics_spapr.h"
 #include "sysemu/kvm.h"
=20
 #include "trace.h"
diff --git a/include/hw/ppc/xics.h b/include/hw/ppc/xics.h
index 07508cbd217e..fad786e8b22d 100644
--- a/include/hw/ppc/xics.h
+++ b/include/hw/ppc/xics.h
@@ -200,13 +200,6 @@ void ics_pic_print_info(ICSState *ics, Monitor *mon)=
;
 void ics_resend(ICSState *ics);
 void icp_resend(ICPState *ss);
=20
-typedef struct sPAPRMachineState sPAPRMachineState;
-
-void spapr_dt_xics(sPAPRMachineState *spapr, uint32_t nr_servers, void *=
fdt,
-                   uint32_t phandle);
-int xics_kvm_init(sPAPRMachineState *spapr, Error **errp);
-void xics_spapr_init(sPAPRMachineState *spapr);
-
 Object *icp_create(Object *cpu, const char *type, XICSFabric *xi,
                    Error **errp);
=20
diff --git a/include/hw/ppc/xics_spapr.h b/include/hw/ppc/xics_spapr.h
new file mode 100644
index 000000000000..b1ab27d022cf
--- /dev/null
+++ b/include/hw/ppc/xics_spapr.h
@@ -0,0 +1,37 @@
+/*
+ * QEMU PowerPC pSeries Logical Partition (aka sPAPR) hardware System Em=
ulator
+ *
+ * PAPR Virtualized Interrupt System, aka ICS/ICP aka xics
+ *
+ * Copyright (c) 2010, 2011 David Gibson, IBM Corporation.
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining=
 a copy
+ * of this software and associated documentation files (the "Software"),=
 to deal
+ * in the Software without restriction, including without limitation the=
 rights
+ * to use, copy, modify, merge, publish, distribute, sublicense, and/or =
sell
+ * copies of the Software, and to permit persons to whom the Software is
+ * furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be includ=
ed in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRE=
SS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILI=
TY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHA=
LL
+ * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR =
OTHER
+ * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISI=
NG FROM,
+ * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALING=
S IN
+ * THE SOFTWARE.
+ */
+
+#ifndef XICS_SPAPR_H
+#define XICS_SPAPR_H
+
+#include "hw/ppc/spapr.h"
+
+void spapr_dt_xics(sPAPRMachineState *spapr, uint32_t nr_servers, void *=
fdt,
+                   uint32_t phandle);
+int xics_kvm_init(sPAPRMachineState *spapr, Error **errp);
+void xics_spapr_init(sPAPRMachineState *spapr);
+
+#endif /* XICS_SPAPR_H */
