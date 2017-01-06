Received: from eggs.gnu.org ([2001:4830:134:3::10]:47223)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cPWsh-0004ck-Gx
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 10:56:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cPWsg-0005CJ-9q
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 10:56:39 -0500
Received: from mx1.redhat.com ([209.132.183.28]:39354)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1cPWsg-0005Bk-4F
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 10:56:38 -0500
Received: from int-mx11.intmail.prod.int.phx2.redhat.com
	(int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 36F7B21725
	for <qemu-devel@nongnu.org>; Fri,  6 Jan 2017 15:56:38 +0000 (UTC)
From: "Daniel P. Berrange" <berrange@redhat.com>
Date: Fri,  6 Jan 2017 15:55:24 +0000
Message-Id: <20170106155543.12827-29-berrange@redhat.com>
In-Reply-To: <20170106155543.12827-1-berrange@redhat.com>
References: <20170106155543.12827-1-berrange@redhat.com>
Subject: [Qemu-devel] [PATCH v2 28/47] trace: switch hw/pci/ directory to
 modular trace.h file
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>

Switch files in the hw/pci/ directory to include the
hw/pci/trace.h file instead of the global trace.h
file.

Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
---
 Makefile.objs        | 2 +-
 hw/pci/Makefile.objs | 2 ++
 hw/pci/pci.c         | 2 +-
 hw/pci/pci_host.c    | 2 +-
 4 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/Makefile.objs b/Makefile.objs
index 42cd94e..66ffeca 100644
--- a/Makefile.objs
+++ b/Makefile.objs
@@ -146,7 +146,7 @@ trace-events-subdirs += hw/mem
 trace-events-subdirs += hw/i386
 trace-events-subdirs += hw/9pfs
 trace-events-subdirs += hw/ppc
-trace-events-y += hw/pci/trace-events
+trace-events-subdirs += hw/pci
 trace-events-y += hw/s390x/trace-events
 trace-events-y += hw/vfio/trace-events
 trace-events-y += hw/acpi/trace-events
diff --git a/hw/pci/Makefile.objs b/hw/pci/Makefile.objs
index 9f905e6..b075774 100644
--- a/hw/pci/Makefile.objs
+++ b/hw/pci/Makefile.objs
@@ -7,3 +7,5 @@ common-obj-$(CONFIG_PCI) += pcie.o pcie_aer.o pcie_port.o
 
 common-obj-$(call lnot,$(CONFIG_PCI)) += pci-stub.o
 common-obj-$(CONFIG_ALL) += pci-stub.o
+trace-obj-y += trace.o
+trace-obj-$(CONFIG_TRACE_DTRACE) += trace-dtrace.o
diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index 24fae16..8c1c7b9 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -34,7 +34,7 @@
 #include "qemu/error-report.h"
 #include "qemu/range.h"
 #include "qmp-commands.h"
-#include "trace.h"
+#include "hw/pci/trace.h"
 #include "hw/pci/msi.h"
 #include "hw/pci/msix.h"
 #include "exec/address-spaces.h"
diff --git a/hw/pci/pci_host.c b/hw/pci/pci_host.c
index 5eaa935..2ecf5b9 100644
--- a/hw/pci/pci_host.c
+++ b/hw/pci/pci_host.c
@@ -22,7 +22,7 @@
 #include "hw/pci/pci.h"
 #include "hw/pci/pci_host.h"
 #include "hw/pci/pci_bus.h"
-#include "trace.h"
+#include "hw/pci/trace.h"
 
 /* debug PCI */
 //#define DEBUG_PCI
-- 
2.9.3
