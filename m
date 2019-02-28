Received: from eggs.gnu.org ([209.51.188.92]:57690)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <farosas@linux.ibm.com>) id 1gzUd3-0002kb-U7
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 17:58:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <farosas@linux.ibm.com>) id 1gzUd3-0001m7-0V
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 17:58:13 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:33882
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <farosas@linux.ibm.com>)
	id 1gzUd2-0001le-LT
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 17:58:12 -0500
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x1SMsHZ5055836
	for <qemu-devel@nongnu.org>; Thu, 28 Feb 2019 17:58:12 -0500
Received: from e14.ny.us.ibm.com (e14.ny.us.ibm.com [129.33.205.204])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2qxnus8akd-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 28 Feb 2019 17:58:12 -0500
Received: from localhost
	by e14.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <farosas@linux.ibm.com>;
	Thu, 28 Feb 2019 22:58:11 -0000
From: Fabiano Rosas <farosas@linux.ibm.com>
Date: Thu, 28 Feb 2019 19:57:55 -0300
In-Reply-To: <20190228225759.21328-1-farosas@linux.ibm.com>
References: <20190228225759.21328-1-farosas@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <20190228225759.21328-2-farosas@linux.ibm.com>
Subject: [Qemu-devel] [RFC PATCH v4 1/5] target/ppc: Move exception vector
 offset computation into a function
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Alexey Kardashevskiy <aik@ozlabs.ru>

Signed-off-by: Fabiano Rosas <farosas@linux.ibm.com>
Reviewed-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---
 target/ppc/excp_helper.c | 30 +++++++++++++++++++-----------
 1 file changed, 19 insertions(+), 11 deletions(-)

diff --git a/target/ppc/excp_helper.c b/target/ppc/excp_helper.c
index 39bedbb11d..beafcf1ebd 100644
--- a/target/ppc/excp_helper.c
+++ b/target/ppc/excp_helper.c
@@ -107,6 +107,24 @@ static int powerpc_reset_wakeup(CPUState *cs, CPUPPCState *env, int excp,
     return POWERPC_EXCP_RESET;
 }
 
+static uint64_t ppc_excp_vector_offset(CPUState *cs, int ail)
+{
+    uint64_t offset = 0;
+
+    switch (ail) {
+    case AIL_0001_8000:
+        offset = 0x18000;
+        break;
+    case AIL_C000_0000_0000_4000:
+        offset = 0xc000000000004000ull;
+        break;
+    default:
+        cpu_abort(cs, "Invalid AIL combination %d\n", ail);
+        break;
+    }
+
+    return offset;
+}
 
 /* Note that this function should be greatly optimized
  * when called with a constant excp, from ppc_hw_interrupt
@@ -708,17 +726,7 @@ static inline void powerpc_excp(PowerPCCPU *cpu, int excp_model, int excp)
     /* Handle AIL */
     if (ail) {
         new_msr |= (1 << MSR_IR) | (1 << MSR_DR);
-        switch(ail) {
-        case AIL_0001_8000:
-            vector |= 0x18000;
-            break;
-        case AIL_C000_0000_0000_4000:
-            vector |= 0xc000000000004000ull;
-            break;
-        default:
-            cpu_abort(cs, "Invalid AIL combination %d\n", ail);
-            break;
-        }
+        vector |= ppc_excp_vector_offset(cs, ail);
     }
 
 #if defined(TARGET_PPC64)
-- 
2.20.1
