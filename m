Received: from eggs.gnu.org ([2001:4830:134:3::10]:38477)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fa1L3-0004kc-Og
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 12:06:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fa1Ky-0005Tu-CG
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 12:06:05 -0400
Received: from mail-pg0-x230.google.com ([2607:f8b0:400e:c05::230]:37186)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fa1Ky-0005TO-6J
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 12:06:00 -0400
Received: by mail-pg0-x230.google.com with SMTP id n15-v6so4107458pgv.4
	for <qemu-devel@nongnu.org>; Mon, 02 Jul 2018 09:06:00 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Mon,  2 Jul 2018 09:05:46 -0700
Message-Id: <20180702160546.31969-7-richard.henderson@linaro.org>
In-Reply-To: <20180702160546.31969-1-richard.henderson@linaro.org>
References: <20180702160546.31969-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PULL 6/6] cpu: Assert asidx_from_attrs return value
 in range
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/qom/cpu.h | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/include/qom/cpu.h b/include/qom/cpu.h
index cce2fd6acc..bd796579ee 100644
--- a/include/qom/cpu.h
+++ b/include/qom/cpu.h
@@ -620,11 +620,13 @@ static inline hwaddr cpu_get_phys_page_debug(CPUState *cpu, vaddr addr)
 static inline int cpu_asidx_from_attrs(CPUState *cpu, MemTxAttrs attrs)
 {
     CPUClass *cc = CPU_GET_CLASS(cpu);
+    int ret = 0;
 
     if (cc->asidx_from_attrs) {
-        return cc->asidx_from_attrs(cpu, attrs);
+        ret = cc->asidx_from_attrs(cpu, attrs);
+        assert(ret < cpu->num_ases && ret >= 0);
     }
-    return 0;
+    return ret;
 }
 #endif
 
-- 
2.17.1
