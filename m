Received: from eggs.gnu.org ([2001:4830:134:3::10]:33653)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dBfCp-0000NV-OQ
	for qemu-devel@nongnu.org; Fri, 19 May 2017 06:32:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dBfCm-0007l2-JL
	for qemu-devel@nongnu.org; Fri, 19 May 2017 06:32:23 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:57742
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1dBfCm-0007kj-Ed
	for qemu-devel@nongnu.org; Fri, 19 May 2017 06:32:20 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v4JAO5c9061214
	for <qemu-devel@nongnu.org>; Fri, 19 May 2017 06:32:19 -0400
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2ahr3j21nc-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 19 May 2017 06:32:18 -0400
Received: from localhost
	by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <groug@kaod.org>;
	Fri, 19 May 2017 04:32:18 -0600
From: Greg Kurz <groug@kaod.org>
Date: Fri, 19 May 2017 12:32:12 +0200
In-Reply-To: <149518991537.24289.6673616934370284758.stgit@bahia.lan>
References: <149518991537.24289.6673616934370284758.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <149518993198.24289.7946457258780782948.stgit@bahia.lan>
Subject: [Qemu-devel] [PATCH v2 2/4] spapr: fix error reporting in
 xics_system_init()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Cc: Laurent Vivier <lvivier@redhat.com>, Bharata B Rao <bharata@linux.vnet.ibm.com>, Cedric Le Goater <clg@kaod.org>, David Gibson <david@gibson.dropbear.id.au>

If the user explicitely asked for kernel-irqchip support and "xics-kvm"
initialization fails, we shouldn't fallback to emulated "xics" as we
do now. It is also awkward to print an error message when we have an
errp pointer argument.

Let's use the errp argument to report the error and let the caller decide.
This simplifies the code as we don't need a local Error * here.

Signed-off-by: Greg Kurz <groug@kaod.org>
---
v2: - total rewrite
---
 hw/ppc/spapr.c |   13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 91f7434861a8..75e298b4c6be 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -128,18 +128,14 @@ static void xics_system_init(MachineState *machine, int nr_irqs, Error **errp)
     sPAPRMachineState *spapr = SPAPR_MACHINE(machine);
 
     if (kvm_enabled()) {
-        Error *err = NULL;
-
         if (machine_kernel_irqchip_allowed(machine) &&
             !xics_kvm_init(spapr, errp)) {
             spapr->icp_type = TYPE_KVM_ICP;
-            spapr->ics = spapr_ics_create(spapr, TYPE_ICS_KVM, nr_irqs, &err);
+            spapr->ics = spapr_ics_create(spapr, TYPE_ICS_KVM, nr_irqs, errp);
         }
         if (machine_kernel_irqchip_required(machine) && !spapr->ics) {
-            error_reportf_err(err,
-                              "kernel_irqchip requested but unavailable: ");
-        } else {
-            error_free(err);
+            error_prepend(errp, "kernel_irqchip requested but unavailable: ");
+            return;
         }
     }
 
@@ -147,6 +143,9 @@ static void xics_system_init(MachineState *machine, int nr_irqs, Error **errp)
         xics_spapr_init(spapr);
         spapr->icp_type = TYPE_ICP;
         spapr->ics = spapr_ics_create(spapr, TYPE_ICS_SIMPLE, nr_irqs, errp);
+        if (!spapr->ics) {
+            return;
+        }
     }
 }
 
