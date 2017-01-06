Received: from eggs.gnu.org ([2001:4830:134:3::10]:47518)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cPWt8-0005Hl-W2
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 10:57:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cPWt4-0005UQ-6y
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 10:57:07 -0500
Received: from mx1.redhat.com ([209.132.183.28]:39570)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1cPWt4-0005Tc-1k
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 10:57:02 -0500
Received: from int-mx11.intmail.prod.int.phx2.redhat.com
	(int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 267167F7C8
	for <qemu-devel@nongnu.org>; Fri,  6 Jan 2017 15:57:02 +0000 (UTC)
From: "Daniel P. Berrange" <berrange@redhat.com>
Date: Fri,  6 Jan 2017 15:55:39 +0000
Message-Id: <20170106155543.12827-44-berrange@redhat.com>
In-Reply-To: <20170106155543.12827-1-berrange@redhat.com>
References: <20170106155543.12827-1-berrange@redhat.com>
Subject: [Qemu-devel] [PATCH v2 43/47] trace: switch linux-user/ directory
 to modular trace.h file
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

Switch files in the linux-user/ directory to include the
linux-user/trace.h file instead of the global trace.h
file.

Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
---
 Makefile.objs            | 2 +-
 linux-user/Makefile.objs | 2 ++
 linux-user/signal.c      | 2 +-
 3 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/Makefile.objs b/Makefile.objs
index cfef83b..abdc0a8 100644
--- a/Makefile.objs
+++ b/Makefile.objs
@@ -161,7 +161,7 @@ trace-events-subdirs += target/sparc
 trace-events-subdirs += target/s390x
 trace-events-subdirs += target/ppc
 trace-events-subdirs += qom
-trace-events-y += linux-user/trace-events
+trace-events-subdirs += linux-user
 trace-events-y += qapi/trace-events
 
 trace-events-files = $(trace-events-y) $(trace-events-subdirs:%=%/trace-events)
diff --git a/linux-user/Makefile.objs b/linux-user/Makefile.objs
index 8c93058..7a05775 100644
--- a/linux-user/Makefile.objs
+++ b/linux-user/Makefile.objs
@@ -6,3 +6,5 @@ obj-$(TARGET_HAS_BFLT) += flatload.o
 obj-$(TARGET_I386) += vm86.o
 obj-$(TARGET_ARM) += arm/nwfpe/
 obj-$(TARGET_M68K) += m68k-sim.o
+trace-obj-y += trace.o
+trace-obj-$(CONFIG_TRACE_DTRACE) += trace-dtrace.o
diff --git a/linux-user/signal.c b/linux-user/signal.c
index c750053..8bc327c 100644
--- a/linux-user/signal.c
+++ b/linux-user/signal.c
@@ -24,7 +24,7 @@
 #include "qemu.h"
 #include "qemu-common.h"
 #include "target_signal.h"
-#include "trace.h"
+#include "linux-user/trace.h"
 
 static struct target_sigaltstack target_sigaltstack_used = {
     .ss_sp = 0,
-- 
2.9.3
