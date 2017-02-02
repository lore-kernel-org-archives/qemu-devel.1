Received: from eggs.gnu.org ([2001:4830:134:3::10]:52092)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cZ9k3-0007fF-3W
	for qemu-devel@nongnu.org; Thu, 02 Feb 2017 00:15:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cZ9jx-00042r-Pt
	for qemu-devel@nongnu.org; Thu, 02 Feb 2017 00:15:31 -0500
From: David Gibson <david@gibson.dropbear.id.au>
Date: Thu,  2 Feb 2017 16:14:08 +1100
Message-Id: <20170202051445.5735-71-david@gibson.dropbear.id.au>
In-Reply-To: <20170202051445.5735-1-david@gibson.dropbear.id.au>
References: <20170202051445.5735-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 070/107] host-utils: Move 128-bit guard macro to
 .c file
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: agraf@suse.de, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, thuth@redhat.com, lvivier@redhat.com, mdroth@linux.vnet.ibm.com, aik@ozlabs.ru, Jose Ricardo Ziviani <joserz@linux.vnet.ibm.com>, David Gibson <david@gibson.dropbear.id.au>

From: Jose Ricardo Ziviani <joserz@linux.vnet.ibm.com>

It is not possible to implement functions in host-utils.c for
architectures with quadwords because the guard is implemented in the
Makefile. This patch move the guard out of the Makefile to the
implementation file.

Signed-off-by: Jose Ricardo Ziviani <joserz@linux.vnet.ibm.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 util/Makefile.objs | 2 +-
 util/host-utils.c  | 2 ++
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/util/Makefile.objs b/util/Makefile.objs
index c1f247d..56c8c23 100644
--- a/util/Makefile.objs
+++ b/util/Makefile.objs
@@ -12,7 +12,7 @@ util-obj-$(CONFIG_POSIX) += memfd.o
 util-obj-$(CONFIG_WIN32) += oslib-win32.o
 util-obj-$(CONFIG_WIN32) += qemu-thread-win32.o
 util-obj-y += envlist.o path.o module.o
-util-obj-$(call lnot,$(CONFIG_INT128)) += host-utils.o
+util-obj-y += host-utils.o
 util-obj-y += bitmap.o bitops.o hbitmap.o
 util-obj-y += fifo8.o
 util-obj-y += acl.o
diff --git a/util/host-utils.c b/util/host-utils.c
index b166e57..3495262 100644
--- a/util/host-utils.c
+++ b/util/host-utils.c
@@ -26,6 +26,7 @@
 #include "qemu/osdep.h"
 #include "qemu/host-utils.h"
 
+#ifndef CONFIG_INT128
 /* Long integer helpers */
 static inline void mul64(uint64_t *plow, uint64_t *phigh,
                          uint64_t a, uint64_t b)
@@ -158,4 +159,5 @@ int divs128(int64_t *plow, int64_t *phigh, int64_t divisor)
 
     return overflow;
 }
+#endif
 
-- 
2.9.3
