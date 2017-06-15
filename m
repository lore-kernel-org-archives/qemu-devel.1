Received: from eggs.gnu.org ([2001:4830:134:3::10]:34857)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bharata@linux.vnet.ibm.com>) id 1dLNaI-0006kR-MQ
	for qemu-devel@nongnu.org; Thu, 15 Jun 2017 01:44:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bharata@linux.vnet.ibm.com>) id 1dLNaG-00075Z-Vh
	for qemu-devel@nongnu.org; Thu, 15 Jun 2017 01:44:46 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:38478
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bharata@linux.vnet.ibm.com>)
	id 1dLNaG-00075V-Px
	for qemu-devel@nongnu.org; Thu, 15 Jun 2017 01:44:44 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v5F5ho05074691
	for <qemu-devel@nongnu.org>; Thu, 15 Jun 2017 01:44:44 -0400
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2b3ep5cj92-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 15 Jun 2017 01:44:43 -0400
Received: from localhost
	by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <bharata@linux.vnet.ibm.com>;
	Thu, 15 Jun 2017 15:44:39 +1000
From: Bharata B Rao <bharata@linux.vnet.ibm.com>
Date: Thu, 15 Jun 2017 11:14:24 +0530
Message-Id: <1497505464-12796-1-git-send-email-bharata@linux.vnet.ibm.com>
Subject: [Qemu-devel] [FIX PATCH] target/ppc: Proper cleanup when
 ppc_cpu_realizefn fails
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, david@gibson.dropbear.id.au, Bharata B Rao <bharata@linux.vnet.ibm.com>

If ppc_cpu_realizefn() fails after cpu_exec_realizefn() has been
called, we will have to undo whatever cpu_exec_realizefn() did
by explicitly calling cpu_exec_unrealizeffn() which is currently
missing. Failure to do this proper cleanup will result in CPU
which was never fully realized to linger on the cpus list causing
SIGSEGV later (for eg when running "info cpus").

Signed-off-by: Bharata B Rao <bharata@linux.vnet.ibm.com>
---
 target/ppc/translate_init.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/target/ppc/translate_init.c b/target/ppc/translate_init.c
index e837cd2..53aff5a 100644
--- a/target/ppc/translate_init.c
+++ b/target/ppc/translate_init.c
@@ -9825,14 +9825,14 @@ static void ppc_cpu_realizefn(DeviceState *dev, Error **errp)
         error_append_hint(errp, "Adjust the number of cpus to %d "
                           "or try to raise the number of threads per core\n",
                           cpu->cpu_dt_id * smp_threads / max_smt);
-        return;
+        goto unrealize;
     }
 #endif
 
     if (tcg_enabled()) {
         if (ppc_fixup_cpu(cpu) != 0) {
             error_setg(errp, "Unable to emulate selected CPU with TCG");
-            return;
+            goto unrealize;
         }
     }
 
@@ -9841,14 +9841,14 @@ static void ppc_cpu_realizefn(DeviceState *dev, Error **errp)
         error_setg(errp, "CPU does not possess a BookE or 4xx MMU. "
                    "Please use qemu-system-ppc or qemu-system-ppc64 instead "
                    "or choose another CPU model.");
-        return;
+        goto unrealize;
     }
 #endif
 
     create_ppc_opcodes(cpu, &local_err);
     if (local_err != NULL) {
         error_propagate(errp, local_err);
-        return;
+        goto unrealize;
     }
     init_ppc_proc(cpu);
 
@@ -10033,6 +10033,10 @@ static void ppc_cpu_realizefn(DeviceState *dev, Error **errp)
         fflush(stdout);
     }
 #endif
+    return;
+
+unrealize:
+    cpu_exec_unrealizefn(cs);
 }
 
 static void ppc_cpu_unrealizefn(DeviceState *dev, Error **errp)
-- 
2.7.4
