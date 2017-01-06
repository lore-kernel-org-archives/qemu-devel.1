Received: from eggs.gnu.org ([2001:4830:134:3::10]:47501)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cPWt6-0005FN-Po
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 10:57:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cPWt6-0005V3-2e
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 10:57:04 -0500
Received: from mx1.redhat.com ([209.132.183.28]:36612)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1cPWt5-0005Un-T0
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 10:57:03 -0500
Received: from int-mx11.intmail.prod.int.phx2.redhat.com
	(int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 024DE8F02B
	for <qemu-devel@nongnu.org>; Fri,  6 Jan 2017 15:57:04 +0000 (UTC)
From: "Daniel P. Berrange" <berrange@redhat.com>
Date: Fri,  6 Jan 2017 15:55:40 +0000
Message-Id: <20170106155543.12827-45-berrange@redhat.com>
In-Reply-To: <20170106155543.12827-1-berrange@redhat.com>
References: <20170106155543.12827-1-berrange@redhat.com>
Subject: [Qemu-devel] [PATCH v2 44/47] trace: switch qapi/ directory to
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

Switch files in the qapi/ directory to include the
qapi/trace.h file instead of the global trace.h
file.

Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
---
 Makefile.objs          | 2 +-
 qapi/Makefile.objs     | 2 ++
 qapi/qapi-visit-core.c | 2 +-
 3 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/Makefile.objs b/Makefile.objs
index abdc0a8..e8cbaa2 100644
--- a/Makefile.objs
+++ b/Makefile.objs
@@ -162,7 +162,7 @@ trace-events-subdirs += target/s390x
 trace-events-subdirs += target/ppc
 trace-events-subdirs += qom
 trace-events-subdirs += linux-user
-trace-events-y += qapi/trace-events
+trace-events-subdirs += qapi
 
 trace-events-files = $(trace-events-y) $(trace-events-subdirs:%=%/trace-events)
 
diff --git a/qapi/Makefile.objs b/qapi/Makefile.objs
index 33906ff..3c85604 100644
--- a/qapi/Makefile.objs
+++ b/qapi/Makefile.objs
@@ -4,3 +4,5 @@ util-obj-y += string-input-visitor.o string-output-visitor.o
 util-obj-y += opts-visitor.o qapi-clone-visitor.o
 util-obj-y += qmp-event.o
 util-obj-y += qapi-util.o
+trace-obj-y += trace.o
+trace-obj-$(CONFIG_TRACE_DTRACE) += trace-dtrace.o
diff --git a/qapi/qapi-visit-core.c b/qapi/qapi-visit-core.c
index 63bd97b..052d4e1 100644
--- a/qapi/qapi-visit-core.c
+++ b/qapi/qapi-visit-core.c
@@ -19,7 +19,7 @@
 #include "qapi/qmp/qerror.h"
 #include "qapi/visitor.h"
 #include "qapi/visitor-impl.h"
-#include "trace.h"
+#include "qapi/trace.h"
 
 void visit_complete(Visitor *v, void *opaque)
 {
-- 
2.9.3
