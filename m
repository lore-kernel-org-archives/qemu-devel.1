Received: from eggs.gnu.org ([209.51.188.92]:57446)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <farosas@linux.ibm.com>) id 1gkUok-00076n-08
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 09:08:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <farosas@linux.ibm.com>) id 1gkUoi-0002XU-2G
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 09:08:17 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:54042)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <farosas@linux.ibm.com>)
	id 1gkUog-0002Pq-Ie
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 09:08:15 -0500
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x0IDwkMr136466
	for <qemu-devel@nongnu.org>; Fri, 18 Jan 2019 09:08:11 -0500
Received: from e12.ny.us.ibm.com (e12.ny.us.ibm.com [129.33.205.202])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2q3fd1tgmt-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 18 Jan 2019 09:08:11 -0500
Received: from localhost
	by e12.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <farosas@linux.ibm.com>;
	Fri, 18 Jan 2019 14:08:10 -0000
From: Fabiano Rosas <farosas@linux.ibm.com>
Date: Fri, 18 Jan 2019 12:07:52 -0200
In-Reply-To: <20190118140758.829-1-farosas@linux.ibm.com>
References: <20190118140758.829-1-farosas@linux.ibm.com>
Message-Id: <20190118140758.829-2-farosas@linux.ibm.com>
Subject: [Qemu-devel] [RFC PATCH v3 1/7] target/ppc: Move exception vector
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
Cc: qemu-ppc@nongnu.org, philmd@redhat.com, pbonzini@redhat.com, crosthwaite.peter@gmail.com, rth@twiddle.net, david@gibson.dropbear.id.au, cohuck@redhat.com, aik@ozlabs.ru

Signed-off-by: Fabiano Rosas <farosas@linux.ibm.com>
---
 target/ppc/excp_helper.c | 31 ++++++++++++++++++++-----------
 1 file changed, 20 insertions(+), 11 deletions(-)

diff --git a/target/ppc/excp_helper.c b/target/ppc/excp_helper.c
index 0ec7ae1ad4..337a3ef8bb 100644
--- a/target/ppc/excp_helper.c
+++ b/target/ppc/excp_helper.c
@@ -65,6 +65,25 @@ static inline void dump_syscall(CPUPPCState *env)
                   ppc_dump_gpr(env, 6), env->nip);
 }
 
+static uint64_t ppc_excp_vector_offset(CPUState *cs, int ail)
+{
+    uint64_t offset;
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
+
 /* Note that this function should be greatly optimized
  * when called with a constant excp, from ppc_hw_interrupt
  */
@@ -685,17 +704,7 @@ static inline void powerpc_excp(PowerPCCPU *cpu, int excp_model, int excp)
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
2.17.1
