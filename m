Received: from eggs.gnu.org ([2001:4830:134:3::10]:49894)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fUlEd-0005QH-2r
	for qemu-devel@nongnu.org; Sun, 17 Jun 2018 23:53:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fUlEb-00044J-9K
	for qemu-devel@nongnu.org; Sun, 17 Jun 2018 23:53:43 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Mon, 18 Jun 2018 13:53:19 +1000
Message-Id: <20180618035324.19907-24-david@gibson.dropbear.id.au>
In-Reply-To: <20180618035324.19907-1-david@gibson.dropbear.id.au>
References: <20180618035324.19907-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 23/28] spapr_cpu_core: fix potential leak in
 spapr_cpu_core_realize()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, groug@kaod.org, clg@kaod.org, agraf@suse.de, aik@ozlabs.ru, David Gibson <david@gibson.dropbear.id.au>

From: Greg Kurz <groug@kaod.org>

Commit 94ad93bd97684 (QEMU 2.12) switched to instantiate CPUs separately
but it missed to adapt the error path accordingly. If something fails in
the CPU creation loop, then the CPU object that was just created is leaked.

The error paths in this function are a bit obfuscated, and adding
yet another label to free this CPU object makes it worse. We should
move the block of the loop to a separate function, with a proper
rollback path, but this is a bigger cleanup.

For now, let's just fix the bug by adding the missing calls to
object_unref(). This will allow easier backport to older QEMU
versions.

Signed-off-by: Greg Kurz <groug@kaod.org>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/spapr_cpu_core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/hw/ppc/spapr_cpu_core.c b/hw/ppc/spapr_cpu_core.c
index ad404d13ec..a9bb2d61e8 100644
--- a/hw/ppc/spapr_cpu_core.c
+++ b/hw/ppc/spapr_cpu_core.c
@@ -187,6 +187,7 @@ static void spapr_cpu_core_realize(DeviceState *dev, Error **errp)
         cs->cpu_index = cc->core_id + i;
         spapr_set_vcpu_id(cpu, cs->cpu_index, &local_err);
         if (local_err) {
+            object_unref(obj);
             goto err;
         }
 
@@ -198,6 +199,7 @@ static void spapr_cpu_core_realize(DeviceState *dev, Error **errp)
         object_property_add_child(OBJECT(sc), id, obj, &local_err);
         g_free(id);
         if (local_err) {
+            object_unref(obj);
             goto err;
         }
         object_unref(obj);
-- 
2.17.1
