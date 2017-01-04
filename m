Received: from eggs.gnu.org ([2001:4830:134:3::10]:52403)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cOlhv-0007am-R5
	for qemu-devel@nongnu.org; Wed, 04 Jan 2017 08:34:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cOlhr-0000hS-IL
	for qemu-devel@nongnu.org; Wed, 04 Jan 2017 08:34:23 -0500
Received: from mx1.redhat.com ([209.132.183.28]:35028)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1cOlhr-0000hD-CT
	for qemu-devel@nongnu.org; Wed, 04 Jan 2017 08:34:19 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Wed,  4 Jan 2017 13:34:01 +0000
Message-Id: <20170104133414.6524-2-stefanha@redhat.com>
In-Reply-To: <20170104133414.6524-1-stefanha@redhat.com>
References: <20170104133414.6524-1-stefanha@redhat.com>
Subject: [Qemu-devel] [PULL 01/14] HACKING: document #include order
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Stefan Hajnoczi <stefanha@redhat.com>, Fam Zheng <famz@redhat.com>, Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>

It was not obvious to me why "qemu/osdep.h" must be the first #include.
This documents the rationale and the overall #include order.

Cc: Fam Zheng <famz@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>
Cc: Eric Blake <eblake@redhat.com>
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Message-id: 1479307161-24658-1-git-send-email-stefanha@redhat.com
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 HACKING | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/HACKING b/HACKING
index 20a9101..4125c97 100644
--- a/HACKING
+++ b/HACKING
@@ -1,10 +1,28 @@
 1. Preprocessor
 
+1.1. Variadic macros
+
 For variadic macros, stick with this C99-like syntax:
 
 #define DPRINTF(fmt, ...)                                       \
     do { printf("IRQ: " fmt, ## __VA_ARGS__); } while (0)
 
+1.2. Include directives
+
+Order include directives as follows:
+
+#include "qemu/osdep.h"  /* Always first... */
+#include <...>           /* then system headers... */
+#include "..."           /* and finally QEMU headers. */
+
+The "qemu/osdep.h" header contains preprocessor macros that affect the behavior
+of core system headers like <stdint.h>.  It must be the first include so that
+core system headers included by external libraries get the preprocessor macros
+that QEMU depends on.
+
+Do not include "qemu/osdep.h" from header files since the .c file will have
+already included it.
+
 2. C types
 
 It should be common sense to use the right type, but we have collected
-- 
2.9.3
