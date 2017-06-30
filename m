Received: from eggs.gnu.org ([2001:4830:134:3::10]:34568)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dQtRp-00006H-16
	for qemu-devel@nongnu.org; Fri, 30 Jun 2017 06:46:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dQtRm-0007zY-T8
	for qemu-devel@nongnu.org; Fri, 30 Jun 2017 06:46:49 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Fri, 30 Jun 2017 20:46:23 +1000
Message-Id: <20170630104632.27942-13-david@gibson.dropbear.id.au>
In-Reply-To: <20170630104632.27942-1-david@gibson.dropbear.id.au>
References: <20170630104632.27942-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 12/21] target/ppc: Proper cleanup when
 ppc_cpu_realizefn fails
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: agraf@suse.de, thuth@redhat.com, lvivier@redhat.com, sursingh@redhat.com, sbobroff@redhat.com, mdroth@linux.vnet.ibm.com, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Bharata B Rao <bharata@linux.vnet.ibm.com>, David Gibson <david@gibson.dropbear.id.au>

From: Bharata B Rao <bharata@linux.vnet.ibm.com>

If ppc_cpu_realizefn() fails after cpu_exec_realizefn() has been
called, we will have to undo whatever cpu_exec_realizefn() did
by explicitly calling cpu_exec_unrealizeffn() which is currently
missing. Failure to do this proper cleanup will result in CPU
which was never fully realized to linger on the cpus list causing
SIGSEGV later (for eg when running "info cpus").

Signed-off-by: Bharata B Rao <bharata@linux.vnet.ibm.com>
Reviewed-by: Greg Kurz <groug@kaod.org>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 target/ppc/translate_init.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/target/ppc/translate_init.c b/target/ppc/translate_init.c
index ee84044..783bf98 100644
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
2.9.4
