Received: from eggs.gnu.org ([2001:4830:134:3::10]:47348)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cPWss-0004s5-4x
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 10:56:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cPWsr-0005K9-3V
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 10:56:50 -0500
Received: from mx1.redhat.com ([209.132.183.28]:41720)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1cPWsq-0005JL-RK
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 10:56:49 -0500
Received: from int-mx11.intmail.prod.int.phx2.redhat.com
	(int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id E669731B31F
	for <qemu-devel@nongnu.org>; Fri,  6 Jan 2017 15:56:48 +0000 (UTC)
From: "Daniel P. Berrange" <berrange@redhat.com>
Date: Fri,  6 Jan 2017 15:55:30 +0000
Message-Id: <20170106155543.12827-35-berrange@redhat.com>
In-Reply-To: <20170106155543.12827-1-berrange@redhat.com>
References: <20170106155543.12827-1-berrange@redhat.com>
Subject: [Qemu-devel] [PATCH v2 34/47] trace: switch ui/ directory to
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

Switch files in the ui/ directory to include the
ui/trace.h file instead of the global trace.h
file.

Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
---
 Makefile.objs      | 2 +-
 ui/Makefile.objs   | 3 +++
 ui/console.c       | 2 +-
 ui/gtk-egl.c       | 2 +-
 ui/gtk-gl-area.c   | 2 +-
 ui/gtk.c           | 2 +-
 ui/input.c         | 2 +-
 ui/spice-display.c | 2 +-
 ui/vnc.c           | 2 +-
 9 files changed, 11 insertions(+), 8 deletions(-)

diff --git a/Makefile.objs b/Makefile.objs
index 3a4abc7..355cb78 100644
--- a/Makefile.objs
+++ b/Makefile.objs
@@ -152,7 +152,7 @@ trace-events-subdirs += hw/vfio
 trace-events-subdirs += hw/acpi
 trace-events-subdirs += hw/arm
 trace-events-subdirs += hw/alpha
-trace-events-y += ui/trace-events
+trace-events-subdirs += ui
 trace-events-y += audio/trace-events
 trace-events-y += net/trace-events
 trace-events-y += target/arm/trace-events
diff --git a/ui/Makefile.objs b/ui/Makefile.objs
index dc936f1..c9d1847 100644
--- a/ui/Makefile.objs
+++ b/ui/Makefile.objs
@@ -51,3 +51,6 @@ gtk-egl.o-libs += $(OPENGL_LIBS)
 shader.o-libs += $(OPENGL_LIBS)
 console-gl.o-libs += $(OPENGL_LIBS)
 egl-helpers.o-libs += $(OPENGL_LIBS)
+
+trace-obj-y += trace.o
+trace-obj-$(CONFIG_TRACE_DTRACE) += trace-dtrace.o
diff --git a/ui/console.c b/ui/console.c
index ed888e5..73b8341 100644
--- a/ui/console.c
+++ b/ui/console.c
@@ -28,7 +28,7 @@
 #include "qemu/timer.h"
 #include "qmp-commands.h"
 #include "sysemu/char.h"
-#include "trace.h"
+#include "ui/trace.h"
 #include "exec/memory.h"
 
 #define DEFAULT_BACKSCROLL 512
diff --git a/ui/gtk-egl.c b/ui/gtk-egl.c
index 3f5d328..1c12d34 100644
--- a/ui/gtk-egl.c
+++ b/ui/gtk-egl.c
@@ -14,7 +14,7 @@
 #include "qemu/osdep.h"
 #include "qemu-common.h"
 
-#include "trace.h"
+#include "ui/trace.h"
 
 #include "ui/console.h"
 #include "ui/gtk.h"
diff --git a/ui/gtk-gl-area.c b/ui/gtk-gl-area.c
index 0df5a36..49c9e00 100644
--- a/ui/gtk-gl-area.c
+++ b/ui/gtk-gl-area.c
@@ -10,7 +10,7 @@
 #include "qemu/osdep.h"
 #include "qemu-common.h"
 
-#include "trace.h"
+#include "ui/trace.h"
 
 #include "ui/console.h"
 #include "ui/gtk.h"
diff --git a/ui/gtk.c b/ui/gtk.c
index a216216..1d71691 100644
--- a/ui/gtk.c
+++ b/ui/gtk.c
@@ -48,7 +48,7 @@
 #endif
 #include <math.h>
 
-#include "trace.h"
+#include "ui/trace.h"
 #include "ui/input.h"
 #include "sysemu/sysemu.h"
 #include "qmp-commands.h"
diff --git a/ui/input.c b/ui/input.c
index ed88cda..b3b881b 100644
--- a/ui/input.c
+++ b/ui/input.c
@@ -4,7 +4,7 @@
 #include "qapi-types.h"
 #include "qemu/error-report.h"
 #include "qmp-commands.h"
-#include "trace.h"
+#include "ui/trace.h"
 #include "ui/input.h"
 #include "ui/console.h"
 #include "sysemu/replay.h"
diff --git a/ui/spice-display.c b/ui/spice-display.c
index 5e6f78a..d8f13db 100644
--- a/ui/spice-display.c
+++ b/ui/spice-display.c
@@ -22,7 +22,7 @@
 #include "qemu/queue.h"
 #include "ui/console.h"
 #include "sysemu/sysemu.h"
-#include "trace.h"
+#include "ui/trace.h"
 
 #include "ui/spice-display.h"
 
diff --git a/ui/vnc.c b/ui/vnc.c
index 2c28a59..f715b48 100644
--- a/ui/vnc.c
+++ b/ui/vnc.c
@@ -27,7 +27,7 @@
 #include "qemu/osdep.h"
 #include "vnc.h"
 #include "vnc-jobs.h"
-#include "trace.h"
+#include "ui/trace.h"
 #include "hw/qdev.h"
 #include "sysemu/sysemu.h"
 #include "qemu/error-report.h"
-- 
2.9.3
