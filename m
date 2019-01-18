Received: from eggs.gnu.org ([209.51.188.92]:55226)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gkXnL-00044f-HP
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 12:19:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gkXnJ-0006GM-L2
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 12:19:03 -0500
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:40869)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1gkXnF-0006Be-Rq
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 12:18:59 -0500
Received: by mail-wm1-x344.google.com with SMTP id f188so5175057wmf.5
	for <qemu-devel@nongnu.org>; Fri, 18 Jan 2019 09:18:56 -0800 (PST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Fri, 18 Jan 2019 17:18:48 +0000
Message-Id: <20190118171848.27332-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH] target/s390x: define TCG_GUEST_DEFAULT_MO for
 MTTCG
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, David Hildenbrand <david@redhat.com>, Richard Henderson <rth@twiddle.net>, Cornelia Huck <cohuck@redhat.com>, "open list:S390" <qemu-s390x@nongnu.org>

MTTCG should be enabled by default whenever the memory model allows
it. s390x was missing its definition of TCG_GUEST_DEFAULT_MO meaning
the user had to manually specify  --accel tcg,thread=multi.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Cc: David Hildenbrand <david@redhat.com>
---
 target/s390x/cpu.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/target/s390x/cpu.h b/target/s390x/cpu.h
index 8c2320e882..47d2c2e9cf 100644
--- a/target/s390x/cpu.h
+++ b/target/s390x/cpu.h
@@ -35,6 +35,10 @@
 #define CPUArchState struct CPUS390XState
 
 #include "exec/cpu-defs.h"
+
+/* The z/Architecture has a strong memory model with some store-after-load re-ordering */
+#define TCG_GUEST_DEFAULT_MO      (TCG_MO_ALL & ~TCG_MO_ST_LD)
+
 #define TARGET_PAGE_BITS 12
 
 #define TARGET_PHYS_ADDR_SPACE_BITS 64
-- 
2.17.1
