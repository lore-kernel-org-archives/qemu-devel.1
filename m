Received: from eggs.gnu.org ([2001:4830:134:3::10]:51502)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <nikunj@linux.vnet.ibm.com>) id 1erHM4-00024v-PP
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 01:06:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <nikunj@linux.vnet.ibm.com>) id 1erHM0-0004Fb-1S
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 01:06:12 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:33588
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <nikunj@linux.vnet.ibm.com>)
	id 1erHLz-0004EY-Sn
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 01:06:07 -0500
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w2165gcJ145278
	for <qemu-devel@nongnu.org>; Thu, 1 Mar 2018 01:06:06 -0500
Received: from e06smtp14.uk.ibm.com (e06smtp14.uk.ibm.com [195.75.94.110])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2ge96yncmy-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 01 Mar 2018 01:06:06 -0500
Received: from localhost
	by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <nikunj@linux.vnet.ibm.com>;
	Thu, 1 Mar 2018 06:06:04 -0000
From: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
Date: Thu,  1 Mar 2018 11:35:50 +0530
Message-Id: <20180301060550.14201-1-nikunj@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH] hw/ppc/spapr,
 e500: Use new property "stdout-path" for boot console
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-ppc@nongnu.org, david@gibson.dropbear.id.au
Cc: qemu-devel@nongnu.org, agraf@suse.de, benh@kernel.crashing.org, Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>

Linux kernel commit 2a9d832cc9aae21ea827520fef635b6c49a06c6d
(of: Add bindings for chosen node, stdout-path) deprecated chosen property
"linux,stdout-path" and "stdout".

Introduce the new property "stdout-path" and continue supporting the older
property to remain compatible with existing/older firmware. This older property
can be deprecated after 5 years.

Signed-off-by: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
---
 hw/ppc/e500.c  | 7 +++++++
 hw/ppc/spapr.c | 7 +++++++
 2 files changed, 14 insertions(+)

diff --git a/hw/ppc/e500.c b/hw/ppc/e500.c
index a40d3ec3e3..a325a95015 100644
--- a/hw/ppc/e500.c
+++ b/hw/ppc/e500.c
@@ -119,7 +119,14 @@ static void dt_serial_create(void *fdt, unsigned long long offset,
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
index 83c9d66dd5..58a44edc4a 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -1062,7 +1062,14 @@ static void spapr_dt_chosen(sPAPRMachineState *spapr, void *fdt)
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
