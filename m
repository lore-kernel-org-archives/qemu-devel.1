Received: from eggs.gnu.org ([2001:4830:134:3::10]:49509)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1et3ny-0001YE-V6
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 23:02:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1et3nx-0004W2-Jb
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 23:02:22 -0500
From: David Gibson <david@gibson.dropbear.id.au>
Date: Tue,  6 Mar 2018 15:01:51 +1100
Message-Id: <20180306040154.3669-28-david@gibson.dropbear.id.au>
In-Reply-To: <20180306040154.3669-1-david@gibson.dropbear.id.au>
References: <20180306040154.3669-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 27/30] hw/ppc/spapr,
 e500: Use new property "stdout-path" for boot console
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org, groug@kaod.org
Cc: agraf@suse.de, surajjs@au1.ibm.com, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>, David Gibson <david@gibson.dropbear.id.au>

From: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>

Linux kernel commit 2a9d832cc9aae21ea827520fef635b6c49a06c6d
(of: Add bindings for chosen node, stdout-path) deprecated chosen property
"linux,stdout-path" and "stdout".

Introduce the new property "stdout-path" and continue supporting the older
property to remain compatible with existing/older firmware. This older property
can be deprecated after 5 years.

Signed-off-by: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/e500.c  | 7 +++++++
 hw/ppc/spapr.c | 7 +++++++
 2 files changed, 14 insertions(+)

diff --git a/hw/ppc/e500.c b/hw/ppc/e500.c
index 13a34f50b7..ef541a00be 100644
--- a/hw/ppc/e500.c
+++ b/hw/ppc/e500.c
@@ -120,7 +120,14 @@ static void dt_serial_create(void *fdt, unsigned long long offset,
     qemu_fdt_setprop_string(fdt, "/aliases", alias, ser);
 
     if (defcon) {
+        /*
+         * "linux,stdout-path" and "stdout" properties are deprecated by linux
+         * kernel. New platforms should only use the "stdout-path" property. Set
+         * the new property and continue using older property to remain
+         * compatible with the existing firmware.
+         */
         qemu_fdt_setprop_string(fdt, "/chosen", "linux,stdout-path", ser);
+        qemu_fdt_setprop_string(fdt, "/chosen", "stdout-path", ser);
     }
 }
 
diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 1b6ddd827e..7e1c858566 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -1053,7 +1053,14 @@ static void spapr_dt_chosen(sPAPRMachineState *spapr, void *fdt)
     }
 
     if (!spapr->has_graphics && stdout_path) {
+        /*
+         * "linux,stdout-path" and "stdout" properties are deprecated by linux
+         * kernel. New platforms should only use the "stdout-path" property. Set
+         * the new property and continue using older property to remain
+         * compatible with the existing firmware.
+         */
         _FDT(fdt_setprop_string(fdt, chosen, "linux,stdout-path", stdout_path));
+        _FDT(fdt_setprop_string(fdt, chosen, "stdout-path", stdout_path));
     }
 
     spapr_dt_ov5_platform_support(fdt, chosen);
-- 
2.14.3
