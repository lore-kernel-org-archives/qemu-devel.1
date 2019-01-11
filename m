Received: from eggs.gnu.org ([209.51.188.92]:35408)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <frankja@linux.ibm.com>) id 1ghv8B-00066P-8g
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 06:37:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <frankja@linux.ibm.com>) id 1ghv8A-0000Tq-4M
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 06:37:43 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:43630)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <frankja@linux.ibm.com>)
	id 1ghv89-0000Sv-L0
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 06:37:41 -0500
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	x0BBNmQv057719
	for <qemu-devel@nongnu.org>; Fri, 11 Jan 2019 06:37:40 -0500
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2pxrd8xem1-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 11 Jan 2019 06:37:39 -0500
Received: from localhost
	by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <frankja@linux.ibm.com>;
	Fri, 11 Jan 2019 11:37:37 -0000
From: Janosch Frank <frankja@linux.ibm.com>
Date: Fri, 11 Jan 2019 12:36:56 +0100
In-Reply-To: <20190111113657.66195-1-frankja@linux.ibm.com>
References: <20190111113657.66195-1-frankja@linux.ibm.com>
Message-Id: <20190111113657.66195-2-frankja@linux.ibm.com>
Subject: [Qemu-devel] [PATCH 1/2] s390x: Diag308 move common parameter
 checking into function
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: borntraeger@de.ibm.com, cohuck@redhat.com, david@redhat.com, qemu-s390x@nongnu.org, qemu-stable@nongnu.org

Let's make that switch statement a bit shorter.

Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
---
 target/s390x/diag.c | 34 ++++++++++++++++++----------------
 1 file changed, 18 insertions(+), 16 deletions(-)

diff --git a/target/s390x/diag.c b/target/s390x/diag.c
index acb0f3d4af..cfd7222ddd 100644
--- a/target/s390x/diag.c
+++ b/target/s390x/diag.c
@@ -53,6 +53,22 @@ int handle_diag_288(CPUS390XState *env, uint64_t r1, uint64_t r3)
 #define DIAG_308_RC_NO_CONF         0x0102
 #define DIAG_308_RC_INVALID         0x0402
 
+static int diag308_parm_check(CPUS390XState *env, uint64_t r1, uint64_t addr,
+                              uintptr_t ra)
+{
+    if ((r1 & 1) || (addr & 0x0fffULL)) {
+        s390_program_interrupt(env, PGM_SPECIFICATION, ILEN_AUTO, ra);
+        return -EINVAL;
+    }
+    if (!address_space_access_valid(&address_space_memory, addr,
+                                    sizeof(IplParameterBlock), true,
+                                    MEMTXATTRS_UNSPECIFIED)) {
+        s390_program_interrupt(env, PGM_ADDRESSING, ILEN_AUTO, ra);
+        return -EFAULT;
+    }
+    return 0;
+}
+
 void handle_diag_308(CPUS390XState *env, uint64_t r1, uint64_t r3, uintptr_t ra)
 {
     CPUState *cs = CPU(s390_env_get_cpu(env));
@@ -81,14 +97,7 @@ void handle_diag_308(CPUS390XState *env, uint64_t r1, uint64_t r3, uintptr_t ra)
         s390_ipl_reset_request(cs, S390_RESET_REIPL);
         break;
     case 5:
-        if ((r1 & 1) || (addr & 0x0fffULL)) {
-            s390_program_interrupt(env, PGM_SPECIFICATION, ILEN_AUTO, ra);
-            return;
-        }
-        if (!address_space_access_valid(&address_space_memory, addr,
-                                        sizeof(IplParameterBlock), false,
-                                        MEMTXATTRS_UNSPECIFIED)) {
-            s390_program_interrupt(env, PGM_ADDRESSING, ILEN_AUTO, ra);
+        if (diag308_parm_check(env, r1, addr, ra)) {
             return;
         }
         iplb = g_new0(IplParameterBlock, 1);
@@ -111,14 +120,7 @@ out:
         g_free(iplb);
         return;
     case 6:
-        if ((r1 & 1) || (addr & 0x0fffULL)) {
-            s390_program_interrupt(env, PGM_SPECIFICATION, ILEN_AUTO, ra);
-            return;
-        }
-        if (!address_space_access_valid(&address_space_memory, addr,
-                                        sizeof(IplParameterBlock), true,
-                                        MEMTXATTRS_UNSPECIFIED)) {
-            s390_program_interrupt(env, PGM_ADDRESSING, ILEN_AUTO, ra);
+        if (diag308_parm_check(env, r1, addr, ra)) {
             return;
         }
         iplb = s390_ipl_get_iplb();
-- 
2.14.3
