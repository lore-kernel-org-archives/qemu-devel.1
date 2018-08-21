Received: from eggs.gnu.org ([2001:4830:134:3::10]:33703)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1fsA4n-0002IF-LU
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 13:04:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1fsA4W-0006pf-VQ
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 13:04:08 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:34303)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1fsA4V-0006bk-Ty
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 13:04:00 -0400
Received: by mail-wr1-x442.google.com with SMTP id g33-v6so6431637wrd.1
	for <qemu-devel@nongnu.org>; Tue, 21 Aug 2018 10:03:53 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 21 Aug 2018 19:02:17 +0200
Message-Id: <1534870966-9287-46-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1534870966-9287-1-git-send-email-pbonzini@redhat.com>
References: <1534870966-9287-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 45/74] spapr: do not use CPU_FOREACH_REVERSE
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: "Emilio G. Cota" <cota@braap.org>

From: "Emilio G. Cota" <cota@braap.org>

This paves the way for implementing the CPU list with an RCU list,
which cannot be traversed in reverse order.

Note that this is the only caller of CPU_FOREACH_REVERSE.

Acked-by: David Gibson <david@gibson.dropbear.id.au>
Signed-off-by: Emilio G. Cota <cota@braap.org>
Message-Id: <20180819091335.22863-11-cota@braap.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/ppc/spapr.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index e5d8253..ab9c04e 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -622,9 +622,12 @@ static void spapr_populate_cpu_dt(CPUState *cs, void *fdt, int offset,
 
 static void spapr_populate_cpus_dt_node(void *fdt, sPAPRMachineState *spapr)
 {
+    CPUState **rev;
     CPUState *cs;
+    int n_cpus;
     int cpus_offset;
     char *nodename;
+    int i;
 
     cpus_offset = fdt_add_subnode(fdt, 0, "cpus");
     _FDT(cpus_offset);
@@ -635,8 +638,19 @@ static void spapr_populate_cpus_dt_node(void *fdt, sPAPRMachineState *spapr)
      * We walk the CPUs in reverse order to ensure that CPU DT nodes
      * created by fdt_add_subnode() end up in the right order in FDT
      * for the guest kernel the enumerate the CPUs correctly.
+     *
+     * The CPU list cannot be traversed in reverse order, so we need
+     * to do extra work.
      */
-    CPU_FOREACH_REVERSE(cs) {
+    n_cpus = 0;
+    rev = NULL;
+    CPU_FOREACH(cs) {
+        rev = g_renew(CPUState *, rev, n_cpus + 1);
+        rev[n_cpus++] = cs;
+    }
+
+    for (i = n_cpus - 1; i >= 0; i--) {
+        CPUState *cs = rev[i];
         PowerPCCPU *cpu = POWERPC_CPU(cs);
         int index = spapr_get_vcpu_id(cpu);
         DeviceClass *dc = DEVICE_GET_CLASS(cs);
-- 
1.8.3.1
