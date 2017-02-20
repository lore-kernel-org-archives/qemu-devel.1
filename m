Received: from eggs.gnu.org ([2001:4830:134:3::10]:39322)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cornelia.huck@de.ibm.com>) id 1cfkj6-0003oD-LV
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 04:57:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cornelia.huck@de.ibm.com>) id 1cfkj2-0005ap-MC
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 04:57:48 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:53088
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cornelia.huck@de.ibm.com>)
	id 1cfkj2-0005ai-FE
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 04:57:44 -0500
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v1K9rarK100157
	for <qemu-devel@nongnu.org>; Mon, 20 Feb 2017 04:57:43 -0500
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
	by mx0b-001b2d01.pphosted.com with ESMTP id 28qsdd3by1-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 20 Feb 2017 04:57:43 -0500
Received: from localhost
	by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <cornelia.huck@de.ibm.com>;
	Mon, 20 Feb 2017 09:57:41 -0000
From: Cornelia Huck <cornelia.huck@de.ibm.com>
Date: Mon, 20 Feb 2017 10:57:24 +0100
In-Reply-To: <20170220095734.7890-1-cornelia.huck@de.ibm.com>
References: <20170220095734.7890-1-cornelia.huck@de.ibm.com>
Message-Id: <20170220095734.7890-3-cornelia.huck@de.ibm.com>
Subject: [Qemu-devel] [PATCH 02/12] s390x/kvm: detect some program check
 loops
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: borntraeger@de.ibm.com, agraf@suse.de, jfrei@linux.vnet.ibm.com, Cornelia Huck <cornelia.huck@de.ibm.com>

From: Christian Borntraeger <borntraeger@de.ibm.com>

Sometimes (e.g. early boot) a guest is broken in such ways that it loops
100% delivering operation exceptions (illegal operation) but the pgm new
PSW is not set properly. This will result in code being read from
address zero, which usually contains another illegal op. Let's detect
this case and put the guest in crashed state. Instead of only detecting
this for address zero apply a heuristic that will work for any program
check new psw so that it will also reach the crashed state if you
provide some random elf file to the -kernel option.
We do not want guest problem state to be able to trigger a guest panic,
e.g. by faulting on an address that is the same as the program check
new PSW, so we check for the problem state bit being off.

With this we
a: get rid of CPU consumption of such broken guests
b: keep the program old PSW. This allows to find out the original illegal
   operation - making debugging such early boot issues much easier than
   with single stepping

This relies on the kernel using a similar heuristic and passing such
operation exceptions to user space.

Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
---
 target/s390x/kvm.c | 43 ++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 40 insertions(+), 3 deletions(-)

diff --git a/target/s390x/kvm.c b/target/s390x/kvm.c
index 25367807f4..5ec050cf89 100644
--- a/target/s390x/kvm.c
+++ b/target/s390x/kvm.c
@@ -1867,6 +1867,40 @@ static void unmanageable_intercept(S390CPU *cpu, const char *str, int pswoffset)
     qemu_system_guest_panicked(NULL);
 }
 
+/* try to detect pgm check loops */
+static int handle_oper_loop(S390CPU *cpu, struct kvm_run *run)
+{
+    CPUState *cs = CPU(cpu);
+    PSW oldpsw, newpsw;
+
+    cpu_synchronize_state(cs);
+    newpsw.mask = ldq_phys(cs->as, cpu->env.psa +
+                           offsetof(LowCore, program_new_psw));
+    newpsw.addr = ldq_phys(cs->as, cpu->env.psa +
+                           offsetof(LowCore, program_new_psw) + 8);
+    oldpsw.mask  = run->psw_mask;
+    oldpsw.addr  = run->psw_addr;
+    /*
+     * Avoid endless loops of operation exceptions, if the pgm new
+     * PSW will cause a new operation exception.
+     * The heuristic checks if the pgm new psw is within 6 bytes before
+     * the faulting psw address (with same DAT, AS settings) and the
+     * new psw is not a wait psw and the fault was not triggered by
+     * problem state. In that case go into crashed state.
+     */
+
+    if (oldpsw.addr - newpsw.addr <= 6 &&
+        !(newpsw.mask & PSW_MASK_WAIT) &&
+        !(oldpsw.mask & PSW_MASK_PSTATE) &&
+        (newpsw.mask & PSW_MASK_ASC) == (oldpsw.mask & PSW_MASK_ASC) &&
+        (newpsw.mask & PSW_MASK_DAT) == (oldpsw.mask & PSW_MASK_DAT)) {
+        unmanageable_intercept(cpu, "operation exception loop",
+                               offsetof(LowCore, program_new_psw));
+        return EXCP_HALTED;
+    }
+    return 0;
+}
+
 static int handle_intercept(S390CPU *cpu)
 {
     CPUState *cs = CPU(cpu);
@@ -1914,11 +1948,14 @@ static int handle_intercept(S390CPU *cpu)
             r = EXCP_HALTED;
             break;
         case ICPT_OPEREXC:
-            /* currently only instr 0x0000 after enabled via capability */
+            /* check for break points */
             r = handle_sw_breakpoint(cpu, run);
             if (r == -ENOENT) {
-                enter_pgmcheck(cpu, PGM_OPERATION);
-                r = 0;
+                /* Then check for potential pgm check loops */
+                r = handle_oper_loop(cpu, run);
+                if (r == 0) {
+                    enter_pgmcheck(cpu, PGM_OPERATION);
+                }
             }
             break;
         case ICPT_SOFT_INTERCEPT:
-- 
2.11.0
