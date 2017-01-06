Received: from eggs.gnu.org ([2001:4830:134:3::10]:46986)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cPWsF-0003vq-19
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 10:56:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cPWsE-0004wY-44
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 10:56:11 -0500
Received: from mx1.redhat.com ([209.132.183.28]:58714)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1cPWsD-0004vz-UW
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 10:56:10 -0500
Received: from int-mx11.intmail.prod.int.phx2.redhat.com
	(int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 0B73163147
	for <qemu-devel@nongnu.org>; Fri,  6 Jan 2017 15:56:10 +0000 (UTC)
From: "Daniel P. Berrange" <berrange@redhat.com>
Date: Fri,  6 Jan 2017 15:55:08 +0000
Message-Id: <20170106155543.12827-13-berrange@redhat.com>
In-Reply-To: <20170106155543.12827-1-berrange@redhat.com>
References: <20170106155543.12827-1-berrange@redhat.com>
Subject: [Qemu-devel] [PATCH v2 12/47] trace: switch hw/audio/ directory to
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

Switch files in the hw/audio/ directory to include the
hw/audio/trace.h file instead of the global trace.h
file.

Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
---
 Makefile.objs             | 2 +-
 hw/audio/Makefile.objs    | 3 +++
 hw/audio/cs4231.c         | 2 +-
 hw/audio/milkymist-ac97.c | 2 +-
 4 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/Makefile.objs b/Makefile.objs
index f5ecfbf..41ab795 100644
--- a/Makefile.objs
+++ b/Makefile.objs
@@ -130,7 +130,7 @@ trace-events-subdirs += hw/char
 trace-events-subdirs += hw/intc
 trace-events-subdirs += hw/net
 trace-events-subdirs += hw/virtio
-trace-events-y += hw/audio/trace-events
+trace-events-subdirs += hw/audio
 trace-events-y += hw/misc/trace-events
 trace-events-y += hw/usb/trace-events
 trace-events-y += hw/scsi/trace-events
diff --git a/hw/audio/Makefile.objs b/hw/audio/Makefile.objs
index 7ce85a2..d779550 100644
--- a/hw/audio/Makefile.objs
+++ b/hw/audio/Makefile.objs
@@ -16,3 +16,6 @@ common-obj-$(CONFIG_MARVELL_88W8618) += marvell_88w8618.o
 common-obj-$(CONFIG_MILKYMIST) += milkymist-ac97.o
 
 $(obj)/adlib.o $(obj)/fmopl.o: QEMU_CFLAGS += -DBUILD_Y8950=0
+
+trace-obj-y += trace.o
+trace-obj-$(CONFIG_TRACE_DTRACE) += trace-dtrace.o
diff --git a/hw/audio/cs4231.c b/hw/audio/cs4231.c
index 30690f9..8c7eb1e 100644
--- a/hw/audio/cs4231.c
+++ b/hw/audio/cs4231.c
@@ -24,7 +24,7 @@
 
 #include "qemu/osdep.h"
 #include "hw/sysbus.h"
-#include "trace.h"
+#include "hw/audio/trace.h"
 
 /*
  * In addition to Crystal CS4231 there is a DMA controller on Sparc.
diff --git a/hw/audio/milkymist-ac97.c b/hw/audio/milkymist-ac97.c
index bc8db71..fd994b4 100644
--- a/hw/audio/milkymist-ac97.c
+++ b/hw/audio/milkymist-ac97.c
@@ -24,7 +24,7 @@
 #include "qemu/osdep.h"
 #include "hw/hw.h"
 #include "hw/sysbus.h"
-#include "trace.h"
+#include "hw/audio/trace.h"
 #include "audio/audio.h"
 #include "qemu/error-report.h"
 
-- 
2.9.3
