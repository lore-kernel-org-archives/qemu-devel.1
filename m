Received: from eggs.gnu.org ([2001:4830:134:3::10]:46869)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cPWs4-0003lW-53
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 10:56:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cPWs3-0004qF-3T
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 10:56:00 -0500
Received: from mx1.redhat.com ([209.132.183.28]:39030)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1cPWs2-0004p2-Qi
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 10:55:59 -0500
Received: from int-mx11.intmail.prod.int.phx2.redhat.com
	(int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id BEF227F7B7
	for <qemu-devel@nongnu.org>; Fri,  6 Jan 2017 15:55:56 +0000 (UTC)
From: "Daniel P. Berrange" <berrange@redhat.com>
Date: Fri,  6 Jan 2017 15:55:00 +0000
Message-Id: <20170106155543.12827-5-berrange@redhat.com>
In-Reply-To: <20170106155543.12827-1-berrange@redhat.com>
References: <20170106155543.12827-1-berrange@redhat.com>
Subject: [Qemu-devel] [PATCH v2 04/47] trace: switch crypto/ directory to
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

Switch files in the crypto/ directory to include the
crypto/trace.h file instead of the global trace.h
file.

Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
---
 Makefile.objs         | 2 +-
 crypto/Makefile.objs  | 2 ++
 crypto/secret.c       | 2 +-
 crypto/tlscreds.c     | 2 +-
 crypto/tlscredsanon.c | 2 +-
 crypto/tlscredsx509.c | 2 +-
 crypto/tlssession.c   | 2 +-
 7 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/Makefile.objs b/Makefile.objs
index e8f060e..735c4a9 100644
--- a/Makefile.objs
+++ b/Makefile.objs
@@ -121,7 +121,7 @@ ivshmem-server-obj-y = contrib/ivshmem-server/
 trace-events-subdirs =
 trace-events-y = trace-events
 trace-events-subdirs += util
-trace-events-y += crypto/trace-events
+trace-events-subdirs += crypto
 trace-events-subdirs += io
 trace-events-y += migration/trace-events
 trace-events-y += block/trace-events
diff --git a/crypto/Makefile.objs b/crypto/Makefile.objs
index 1f749f2..3cd9da0 100644
--- a/crypto/Makefile.objs
+++ b/crypto/Makefile.objs
@@ -30,6 +30,8 @@ crypto-obj-y += xts.o
 crypto-obj-y += block.o
 crypto-obj-y += block-qcow.o
 crypto-obj-y += block-luks.o
+trace-obj-y += trace.o
+trace-obj-$(CONFIG_TRACE_DTRACE) += trace-dtrace.o
 
 # Let the userspace emulators avoid linking gnutls/etc
 crypto-aes-obj-y = aes.o
diff --git a/crypto/secret.c b/crypto/secret.c
index 285ab7a..b936615 100644
--- a/crypto/secret.c
+++ b/crypto/secret.c
@@ -24,7 +24,7 @@
 #include "qapi/error.h"
 #include "qom/object_interfaces.h"
 #include "qemu/base64.h"
-#include "trace.h"
+#include "crypto/trace.h"
 
 
 static void
diff --git a/crypto/tlscreds.c b/crypto/tlscreds.c
index a896553..7e7f974 100644
--- a/crypto/tlscreds.c
+++ b/crypto/tlscreds.c
@@ -21,7 +21,7 @@
 #include "qemu/osdep.h"
 #include "qapi/error.h"
 #include "crypto/tlscredspriv.h"
-#include "trace.h"
+#include "crypto/trace.h"
 
 #define DH_BITS 2048
 
diff --git a/crypto/tlscredsanon.c b/crypto/tlscredsanon.c
index 1464220..c94c09b 100644
--- a/crypto/tlscredsanon.c
+++ b/crypto/tlscredsanon.c
@@ -23,7 +23,7 @@
 #include "crypto/tlscredspriv.h"
 #include "qapi/error.h"
 #include "qom/object_interfaces.h"
-#include "trace.h"
+#include "crypto/trace.h"
 
 
 #ifdef CONFIG_GNUTLS
diff --git a/crypto/tlscredsx509.c b/crypto/tlscredsx509.c
index 50eb54f..2a4c3bc 100644
--- a/crypto/tlscredsx509.c
+++ b/crypto/tlscredsx509.c
@@ -24,7 +24,7 @@
 #include "crypto/secret.h"
 #include "qapi/error.h"
 #include "qom/object_interfaces.h"
-#include "trace.h"
+#include "crypto/trace.h"
 
 
 #ifdef CONFIG_GNUTLS
diff --git a/crypto/tlssession.c b/crypto/tlssession.c
index 96a02de..95a6bda 100644
--- a/crypto/tlssession.c
+++ b/crypto/tlssession.c
@@ -24,7 +24,7 @@
 #include "crypto/tlscredsx509.h"
 #include "qapi/error.h"
 #include "qemu/acl.h"
-#include "trace.h"
+#include "crypto/trace.h"
 
 #ifdef CONFIG_GNUTLS
 
-- 
2.9.3
