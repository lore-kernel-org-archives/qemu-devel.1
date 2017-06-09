Received: from eggs.gnu.org ([2001:4830:134:3::10]:49151)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dJCaq-0004Zo-14
	for qemu-devel@nongnu.org; Fri, 09 Jun 2017 01:36:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dJCao-0001OC-3R
	for qemu-devel@nongnu.org; Fri, 09 Jun 2017 01:36:20 -0400
Received: from mail-qt0-x243.google.com ([2607:f8b0:400d:c0d::243]:34558)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dJCan-0001O8-V6
	for qemu-devel@nongnu.org; Fri, 09 Jun 2017 01:36:18 -0400
Received: by mail-qt0-x243.google.com with SMTP id o21so13026551qtb.1
	for <qemu-devel@nongnu.org>; Thu, 08 Jun 2017 22:36:17 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Thu,  8 Jun 2017 22:36:02 -0700
Message-Id: <20170609053611.26032-2-rth@twiddle.net>
In-Reply-To: <20170609053611.26032-1-rth@twiddle.net>
References: <20170609053611.26032-1-rth@twiddle.net>
Subject: [Qemu-devel] [PATCH 1/3] Guess L1 cache linesize for aarch64
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: cota@braap.org, Marcus Shawcroft <marcus.shawcroft@arm.com>

Using the cache hierarchy linesize minimum in CTR_EL0.
See the comment within the code for rationale.

	* sysdeps/unix/sysv/linux/aarch64/sysconf.c: New file.

Cc: Marcus Shawcroft <marcus.shawcroft@arm.com>
---
 sysdeps/unix/sysv/linux/aarch64/sysconf.c | 55 +++++++++++++++++++++++++++++++
 1 file changed, 55 insertions(+)
 create mode 100644 sysdeps/unix/sysv/linux/aarch64/sysconf.c

diff --git a/sysdeps/unix/sysv/linux/aarch64/sysconf.c b/sysdeps/unix/sysv/linux/aarch64/sysconf.c
new file mode 100644
index 0000000..30608dd
--- /dev/null
+++ b/sysdeps/unix/sysv/linux/aarch64/sysconf.c
@@ -0,0 +1,55 @@
+/* Copyright (C) 2017 Free Software Foundation, Inc.
+   This file is part of the GNU C Library.
+
+   The GNU C Library is free software; you can redistribute it and/or
+   modify it under the terms of the GNU Lesser General Public
+   License as published by the Free Software Foundation; either
+   version 2.1 of the License, or (at your option) any later version.
+
+   The GNU C Library is distributed in the hope that it will be useful,
+   but WITHOUT ANY WARRANTY; without even the implied warranty of
+   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+   Lesser General Public License for more details.
+
+   You should have received a copy of the GNU Lesser General Public
+   License along with the GNU C Library.  If not, see
+   <http://www.gnu.org/licenses/>.  */
+
+#include <assert.h>
+#include <stdbool.h>
+#include <stdlib.h>
+#include <unistd.h>
+
+
+static long int linux_sysconf (int name);
+
+/* Get the value of the system variable NAME.  */
+long int
+__sysconf (int name)
+{
+  unsigned ctr;
+
+  /* Unfortunately, the registers that contain the actual cache info
+     (CCSIDR_EL1, CLIDR_EL1, and CSSELR_EL1) are protected by the Linux
+     kernel (though they need not have been).  However, CTR_EL0 contains
+     the *minimum* linesize in the entire cache hierarchy, and is
+     accessible to userland, for use in __aarch64_sync_cache_range,
+     and it is a reasonable assumption that the L1 cache will have that
+     minimum line size.  */
+  switch (name)
+    {
+    case _SC_LEVEL1_ICACHE_LINESIZE:
+      asm("mrs\t%0, ctr_el0" : "=r"(ctr));
+      return 4 << (ctr & 0xf);
+    case _SC_LEVEL1_DCACHE_LINESIZE:
+      asm("mrs\t%0, ctr_el0" : "=r"(ctr));
+      return 4 << ((ctr >> 16) & 0xf);
+    }
+
+  return linux_sysconf (name);
+}
+
+/* Now the generic Linux version.  */
+#undef __sysconf
+#define __sysconf static linux_sysconf
+#include <sysdeps/unix/sysv/linux/sysconf.c>
-- 
2.9.4
