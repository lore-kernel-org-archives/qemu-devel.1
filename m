Received: from eggs.gnu.org ([2001:4830:134:3::10]:37528)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1diP9U-00044k-ED
	for qemu-devel@nongnu.org; Thu, 17 Aug 2017 14:04:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1diP9T-0005MX-81
	for qemu-devel@nongnu.org; Thu, 17 Aug 2017 14:04:16 -0400
Received: from mail-wr0-x236.google.com ([2a00:1450:400c:c0c::236]:35804)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1diP9T-0005Lh-11
	for qemu-devel@nongnu.org; Thu, 17 Aug 2017 14:04:15 -0400
Received: by mail-wr0-x236.google.com with SMTP id 49so41959017wrw.2
	for <qemu-devel@nongnu.org>; Thu, 17 Aug 2017 11:04:14 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Thu, 17 Aug 2017 19:04:03 +0100
Message-Id: <20170817180404.29334-9-alex.bennee@linaro.org>
In-Reply-To: <20170817180404.29334-1-alex.bennee@linaro.org>
References: <20170817180404.29334-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [RFC PATCH 8/9] target/arm/helpers: introduce ADVSIMD
 flags
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: rth@twiddle.net, cota@braap.org, batuzovk@ispras.ru
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Peter Maydell <peter.maydell@linaro.org>

This is used to pass constant information to the helper. This includes
immediate data and element counts/offsets.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 target/arm/advsimd_helper_flags.h | 50 +++++++++++++++++++++++++++++++++++++++
 target/arm/helper-a64.c           |  1 +
 target/arm/translate-a64.c        |  2 ++
 3 files changed, 53 insertions(+)
 create mode 100644 target/arm/advsimd_helper_flags.h

diff --git a/target/arm/advsimd_helper_flags.h b/target/arm/advsimd_helper_flags.h
new file mode 100644
index 0000000000..47429e6fd1
--- /dev/null
+++ b/target/arm/advsimd_helper_flags.h
@@ -0,0 +1,50 @@
+/*
+ *  AArch64 Vector Flags
+ *
+ *  Copyright (c) 2017 Linaro
+ *  Author: Alex Bennée <alex.bennee@linaro.org>
+ *
+ * This library is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU Lesser General Public
+ * License as published by the Free Software Foundation; either
+ * version 2 of the License, or (at your option) any later version.
+ *
+ * This library is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * Lesser General Public License for more details.
+ *
+ * You should have received a copy of the GNU Lesser General Public
+ * License along with this library; if not, see <http://www.gnu.org/licenses/>.
+ */
+
+/* AdvSIMD element data
+ *
+ * We pack all the additional information for elements into a single
+ * 32 bit constant passed by register. Hopefully for groups of
+ * identical operations on different registers this should propergate
+ * nicely in the TCG.
+ *
+ * The following control element iteration:
+ *   ADVSIMD_OPR_ELT  - the count of elements affected
+ *   ADVSIMD_ALL_ELT  - the total count of elements (e.g. clear all-opr elements)
+ *   ADVSIMD_DOFF_ELT - the offset for the destination register (e.g. foo2 ops)
+ *
+ * We encode immediate data in:
+ *   ADVSIMD_DATA
+ *
+ * Typically this is things like shift counts and the like.
+ */
+
+#define ADVSIMD_OPR_ELT_BITS      5
+#define ADVSIMD_OPR_ELT_SHIFT     0
+#define ADVSIMD_ALL_ELT_BITS      5
+#define ADVSIMD_ALL_ELT_SHIFT     5
+#define ADVSIMD_DOFF_ELT_BITS     5
+#define ADVSIMD_DOFF_ELT_SHIFT   10
+#define ADVSIMD_DATA_BITS        16
+#define ADVSIMD_DATA_SHIFT       16
+
+#define GET_SIMD_DATA(t, d) extract32(d,    \
+        ADVSIMD_ ## t ## _SHIFT,            \
+        ADVSIMD_ ## t ## _BITS)
diff --git a/target/arm/helper-a64.c b/target/arm/helper-a64.c
index d9df82cff5..17b1edfb5f 100644
--- a/target/arm/helper-a64.c
+++ b/target/arm/helper-a64.c
@@ -30,6 +30,7 @@
 #include "exec/exec-all.h"
 #include "exec/cpu_ldst.h"
 #include "qemu/int128.h"
+#include "advsimd_helper_flags.h"
 #include "tcg.h"
 #include <zlib.h> /* For crc32 */
 
diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index b5f48605a7..f474c5008b 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -34,6 +34,8 @@
 #include "exec/helper-gen.h"
 #include "exec/log.h"
 
+#include "advsimd_helper_flags.h"
+
 #include "trace-tcg.h"
 
 /* Global registers */
-- 
2.13.0
