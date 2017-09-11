Received: from eggs.gnu.org ([2001:4830:134:3::10]:36809)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1drVz0-0007SL-NC
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 17:11:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1drVyw-00014t-Ky
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 17:11:06 -0400
Received: from 16.mo1.mail-out.ovh.net ([178.33.104.224]:34636)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1drVyw-000145-Dc
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 17:11:02 -0400
Received: from player169.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo1.mail-out.ovh.net (Postfix) with ESMTP id 090A7931F4
	for <qemu-devel@nongnu.org>; Mon, 11 Sep 2017 23:11:01 +0200 (CEST)
From: Greg Kurz <groug@kaod.org>
Date: Mon, 11 Sep 2017 23:10:57 +0200
Message-ID: <150516425752.1593.1536226898929735667.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH v2] spapr_cpu_core: cleaning up
 qdev_get_machine() calls
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>, Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>

This patch removes the qdev_get_machine() calls that are made
in spapr_cpu_core.c in situations where we can get an existing
pointer for the MachineState by either passing it as an argument
to the function or by using other already available pointers.

Credits to Daniel Henrique Barboza for the idea and the changelog
text.

Signed-off-by: Greg Kurz <groug@kaod.org>
---
v2: - fixed typo in spapr_cpu_reset()
---
 hw/ppc/spapr_cpu_core.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/hw/ppc/spapr_cpu_core.c b/hw/ppc/spapr_cpu_core.c
index dc9df0d393d1..0f32532abe99 100644
--- a/hw/ppc/spapr_cpu_core.c
+++ b/hw/ppc/spapr_cpu_core.c
@@ -73,8 +73,8 @@ void spapr_cpu_parse_features(sPAPRMachineState *spapr)
 
 static void spapr_cpu_reset(void *opaque)
 {
-    sPAPRMachineState *spapr = SPAPR_MACHINE(qdev_get_machine());
     PowerPCCPU *cpu = opaque;
+    sPAPRMachineState *spapr = SPAPR_MACHINE(cpu->vhyp);
     CPUState *cs = CPU(cpu);
     CPUPPCState *env = &cpu->env;
 
@@ -162,10 +162,10 @@ static void spapr_cpu_core_unrealizefn(DeviceState *dev, Error **errp)
     g_free(sc->threads);
 }
 
-static void spapr_cpu_core_realize_child(Object *child, Error **errp)
+static void spapr_cpu_core_realize_child(Object *child,
+                                         sPAPRMachineState *spapr, Error **errp)
 {
     Error *local_err = NULL;
-    sPAPRMachineState *spapr = SPAPR_MACHINE(qdev_get_machine());
     CPUState *cs = CPU(child);
     PowerPCCPU *cpu = POWERPC_CPU(cs);
     Object *obj;
@@ -254,7 +254,7 @@ static void spapr_cpu_core_realize(DeviceState *dev, Error **errp)
     for (j = 0; j < cc->nr_threads; j++) {
         obj = sc->threads + j * size;
 
-        spapr_cpu_core_realize_child(obj, &local_err);
+        spapr_cpu_core_realize_child(obj, spapr, &local_err);
         if (local_err) {
             goto err;
         }
