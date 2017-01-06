Received: from eggs.gnu.org ([2001:4830:134:3::10]:46966)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cPWsD-0003uA-EX
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 10:56:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cPWsC-0004vc-Lo
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 10:56:09 -0500
Received: from mx1.redhat.com ([209.132.183.28]:41724)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1cPWsC-0004vA-FM
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 10:56:08 -0500
Received: from int-mx11.intmail.prod.int.phx2.redhat.com
	(int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 900C52CFC07
	for <qemu-devel@nongnu.org>; Fri,  6 Jan 2017 15:56:08 +0000 (UTC)
From: "Daniel P. Berrange" <berrange@redhat.com>
Date: Fri,  6 Jan 2017 15:55:07 +0000
Message-Id: <20170106155543.12827-12-berrange@redhat.com>
In-Reply-To: <20170106155543.12827-1-berrange@redhat.com>
References: <20170106155543.12827-1-berrange@redhat.com>
Subject: [Qemu-devel] [PATCH v2 11/47] trace: switch hw/virtio/ directory to
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

Switch files in the hw/virtio/ directory to include the
hw/virtio/trace.h file instead of the global trace.h
file.

Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
---
 Makefile.objs              | 2 +-
 hw/virtio/Makefile.objs    | 2 ++
 hw/virtio/virtio-balloon.c | 2 +-
 hw/virtio/virtio-rng.c     | 2 +-
 hw/virtio/virtio.c         | 2 +-
 5 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/Makefile.objs b/Makefile.objs
index 9c0aefa..f5ecfbf 100644
--- a/Makefile.objs
+++ b/Makefile.objs
@@ -129,7 +129,7 @@ trace-events-subdirs += hw/block
 trace-events-subdirs += hw/char
 trace-events-subdirs += hw/intc
 trace-events-subdirs += hw/net
-trace-events-y += hw/virtio/trace-events
+trace-events-subdirs += hw/virtio
 trace-events-y += hw/audio/trace-events
 trace-events-y += hw/misc/trace-events
 trace-events-y += hw/usb/trace-events
diff --git a/hw/virtio/Makefile.objs b/hw/virtio/Makefile.objs
index 95c4c30..9e5a3a4 100644
--- a/hw/virtio/Makefile.objs
+++ b/hw/virtio/Makefile.objs
@@ -2,6 +2,8 @@ common-obj-y += virtio-rng.o
 common-obj-$(CONFIG_VIRTIO_PCI) += virtio-pci.o
 common-obj-y += virtio-bus.o
 common-obj-y += virtio-mmio.o
+trace-obj-y += trace.o
+trace-obj-$(CONFIG_TRACE_DTRACE) += trace-dtrace.o
 
 obj-y += virtio.o virtio-balloon.o 
 obj-$(CONFIG_LINUX) += vhost.o vhost-backend.o vhost-user.o
diff --git a/hw/virtio/virtio-balloon.c b/hw/virtio/virtio-balloon.c
index 884570a..ee6fccd 100644
--- a/hw/virtio/virtio-balloon.c
+++ b/hw/virtio/virtio-balloon.c
@@ -25,7 +25,7 @@
 #include "exec/address-spaces.h"
 #include "qapi/visitor.h"
 #include "qapi-event.h"
-#include "trace.h"
+#include "hw/virtio/trace.h"
 
 #include "hw/virtio/virtio-bus.h"
 #include "hw/virtio/virtio-access.h"
diff --git a/hw/virtio/virtio-rng.c b/hw/virtio/virtio-rng.c
index 9639f4e..c19b186 100644
--- a/hw/virtio/virtio-rng.c
+++ b/hw/virtio/virtio-rng.c
@@ -17,7 +17,7 @@
 #include "hw/virtio/virtio-rng.h"
 #include "sysemu/rng.h"
 #include "qom/object_interfaces.h"
-#include "trace.h"
+#include "hw/virtio/trace.h"
 
 static bool is_guest_ready(VirtIORNG *vrng)
 {
diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index d40711a..f7502c2 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -15,7 +15,7 @@
 #include "qapi/error.h"
 #include "qemu-common.h"
 #include "cpu.h"
-#include "trace.h"
+#include "hw/virtio/trace.h"
 #include "exec/address-spaces.h"
 #include "qemu/error-report.h"
 #include "hw/virtio/virtio.h"
-- 
2.9.3
