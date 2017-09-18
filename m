Received: from eggs.gnu.org ([2001:4830:134:3::10]:38017)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1dtyUu-0007s5-Jt
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 12:02:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1dtyUo-0008Kk-Tl
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 12:02:12 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43510)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>) id 1dtyUo-0008KV-O8
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 12:02:06 -0400
From: David Hildenbrand <david@redhat.com>
Date: Mon, 18 Sep 2017 18:00:09 +0200
Message-Id: <20170918160012.4317-25-david@redhat.com>
In-Reply-To: <20170918160012.4317-1-david@redhat.com>
References: <20170918160012.4317-1-david@redhat.com>
Subject: [Qemu-devel] [PATCH v1 24/27] s390x/tcg: flush the tlb on SIGP SET
 PREFIX
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, thuth@redhat.com, cohuck@redhat.com, david@redhat.com, borntraeger@de.ibm.com, Alexander Graf <agraf@suse.de>, Igor Mammedov <imammedo@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>, Matthew Rosato <mjrosato@linux.vnet.ibm.com>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

Thanks to Aurelien Jarno for doing this in his prototype.

We can flush the whole TLB as this should happen really rarely.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 target/s390x/sigp.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/target/s390x/sigp.c b/target/s390x/sigp.c
index 521dcc75f3..c5a5dac911 100644
--- a/target/s390x/sigp.c
+++ b/target/s390x/sigp.c
@@ -14,6 +14,7 @@
 #include "internal.h"
 #include "sysemu/hw_accel.h"
 #include "exec/address-spaces.h"
+#include "exec/exec-all.h"
 #include "sysemu/sysemu.h"
 #include "trace.h"
 
@@ -286,6 +287,7 @@ static void sigp_set_prefix(CPUState *cs, run_on_cpu_data arg)
     }
 
     cpu->env.psa = addr;
+    tlb_flush(cs);
     cpu_synchronize_post_init(cs);
     si->cc = SIGP_CC_ORDER_CODE_ACCEPTED;
 }
-- 
2.13.5
