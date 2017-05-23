Received: from eggs.gnu.org ([2001:4830:134:3::10]:44044)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cornelia.huck@de.ibm.com>) id 1dD7l5-0007rh-UZ
	for qemu-devel@nongnu.org; Tue, 23 May 2017 07:13:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cornelia.huck@de.ibm.com>) id 1dD7l1-00034K-FZ
	for qemu-devel@nongnu.org; Tue, 23 May 2017 07:13:47 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:33943
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cornelia.huck@de.ibm.com>)
	id 1dD7l1-000349-9r
	for qemu-devel@nongnu.org; Tue, 23 May 2017 07:13:43 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v4NB4MQD038929
	for <qemu-devel@nongnu.org>; Tue, 23 May 2017 07:13:42 -0400
Received: from e06smtp10.uk.ibm.com (e06smtp10.uk.ibm.com [195.75.94.106])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2am85f3jyj-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 23 May 2017 07:13:42 -0400
Received: from localhost
	by e06smtp10.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <cornelia.huck@de.ibm.com>;
	Tue, 23 May 2017 12:13:38 +0100
From: Cornelia Huck <cornelia.huck@de.ibm.com>
Date: Tue, 23 May 2017 13:13:06 +0200
In-Reply-To: <20170523111306.25493-1-cornelia.huck@de.ibm.com>
References: <20170523111306.25493-1-cornelia.huck@de.ibm.com>
Message-Id: <20170523111306.25493-22-cornelia.huck@de.ibm.com>
Subject: [Qemu-devel] [PULL 21/21] s390/kvm: do not reset riccb on initial
 cpu reset
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org, stefanha@redhat.com
Cc: borntraeger@de.ibm.com, agraf@suse.de, qemu-devel@nongnu.org, Cornelia Huck <cornelia.huck@de.ibm.com>

From: Christian Borntraeger <borntraeger@de.ibm.com>

The riccb is kept unchanged during initial cpu reset. Move the data
structure to the other registers that are unchanged.

Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
---
 target/s390x/cpu.c | 7 ++++---
 target/s390x/cpu.h | 6 ++++--
 2 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/target/s390x/cpu.c b/target/s390x/cpu.c
index a1bf2ba5a7..a69005d9b5 100644
--- a/target/s390x/cpu.c
+++ b/target/s390x/cpu.c
@@ -92,9 +92,10 @@ static void s390_cpu_initial_reset(CPUState *s)
     int i;
 
     s390_cpu_reset(s);
-    /* initial reset does not touch regs,fregs and aregs */
-    memset(&env->fpc, 0, offsetof(CPUS390XState, end_reset_fields) -
-                         offsetof(CPUS390XState, fpc));
+    /* initial reset does not clear everything! */
+    memset(&env->start_initial_reset_fields, 0,
+        offsetof(CPUS390XState, end_reset_fields) -
+        offsetof(CPUS390XState, start_initial_reset_fields));
 
     /* architectured initial values for CR 0 and 14 */
     env->cregs[0] = CR0_RESET;
diff --git a/target/s390x/cpu.h b/target/s390x/cpu.h
index e27d9d874a..c74b4193ee 100644
--- a/target/s390x/cpu.h
+++ b/target/s390x/cpu.h
@@ -88,6 +88,10 @@ typedef struct CPUS390XState {
      */
     CPU_DoubleU vregs[32][2];  /* vector registers */
     uint32_t aregs[16];    /* access registers */
+    uint8_t riccb[64];     /* runtime instrumentation control */
+
+    /* Fields up to this point are not cleared by initial CPU reset */
+    struct {} start_initial_reset_fields;
 
     uint32_t fpc;          /* floating-point control register */
     uint32_t cc_op;
@@ -137,8 +141,6 @@ typedef struct CPUS390XState {
     uint64_t gbea;
     uint64_t pp;
 
-    uint8_t riccb[64];
-
     /* Fields up to this point are cleared by a CPU reset */
     struct {} end_reset_fields;
 
-- 
2.13.0
