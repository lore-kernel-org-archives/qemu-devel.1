Received: from eggs.gnu.org ([2001:4830:134:3::10]:44524)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bharata@linux.vnet.ibm.com>) id 1dLgDA-0006On-Q4
	for qemu-devel@nongnu.org; Thu, 15 Jun 2017 21:38:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bharata@linux.vnet.ibm.com>) id 1dLgD7-0006hn-KQ
	for qemu-devel@nongnu.org; Thu, 15 Jun 2017 21:38:08 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:49053
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bharata@linux.vnet.ibm.com>)
	id 1dLgD7-0006hM-EH
	for qemu-devel@nongnu.org; Thu, 15 Jun 2017 21:38:05 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v5G1YFEQ136343
	for <qemu-devel@nongnu.org>; Thu, 15 Jun 2017 21:38:04 -0400
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2b42v35gwt-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 15 Jun 2017 21:38:04 -0400
Received: from localhost
	by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <bharata@linux.vnet.ibm.com>;
	Fri, 16 Jun 2017 11:38:01 +1000
Date: Fri, 16 Jun 2017 07:07:53 +0530
From: Bharata B Rao <bharata@linux.vnet.ibm.com>
Reply-To: bharata@linux.vnet.ibm.com
References: <1497495164-9894-1-git-send-email-bharata@linux.vnet.ibm.com>
	<20170615093238.65532c77@bahia.ttt.fr.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170615093238.65532c77@bahia.ttt.fr.ibm.com>
Message-Id: <20170616013753.GA9658@in.ibm.com>
Subject: Re: [Qemu-devel] [FIX PATCH] spapr: prevent QEMU crash when CPU
 realization fails
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, david@gibson.dropbear.id.au

On Thu, Jun 15, 2017 at 09:32:38AM +0200, Greg Kurz wrote:
> On Thu, 15 Jun 2017 08:22:44 +0530
> Bharata B Rao <bharata@linux.vnet.ibm.com> wrote:
> 
> > ICPState objects were being allocated before CPU thread realization.
> > However commit 9ed656631d73 (xics: setup cpu at realize time) reversed it
> > by allocating ICPState objects after CPU thread is realized. But it
> > didn't take care to fix the error path because of which we observe
> > a SIGSEGV when CPU thread realization fails during cold/hotplug.
> > 
> > Fix this by ensuring that we do object_unparent() of ICPState object
> > only in case when is was created earlier.
> > 
> 
> Oops, my bad... my initial intent was to conditionally call object_unparent()
> and I simply forgot to put the "if (obj) { }". But your patch is valid as well
> of course. Maybe you can drop the initialization of obj to NULL on the way,
> since it really doesn't make sense anymore.

Here is the version w/o initializing obj to NULL.

>From cb9cc946df0d1c430cccb1463d78fa4b41e9f0ee Mon Sep 17 00:00:00 2001
From: Bharata B Rao <bharata@linux.vnet.ibm.com>
Date: Wed, 14 Jun 2017 19:24:43 +0530
Subject: [FIX PATCH v1] spapr: prevent QEMU crash when CPU realization
 fails

ICPState objects were being allocated before CPU thread realization.
However commit 9ed656631d73 (xics: setup cpu at realize time) reversed it
by allocating ICPState objects after CPU thread is realized. But it
didn't take care to fix the error path because of which we observe
a SIGSEGV when CPU thread realization fails during cold/hotplug.

Fix this by ensuring that we do object_unparent() of ICPState object
only in case when is was created earlier.

Signed-off-by: Bharata B Rao <bharata@linux.vnet.ibm.com>
Reviewed-by: Greg Kurz <groug@kaod.org>
---
 hw/ppc/spapr_cpu_core.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/hw/ppc/spapr_cpu_core.c b/hw/ppc/spapr_cpu_core.c
index d6719d5..ea278ce 100644
--- a/hw/ppc/spapr_cpu_core.c
+++ b/hw/ppc/spapr_cpu_core.c
@@ -178,7 +178,7 @@ static void spapr_cpu_core_realize_child(Object *child, Error **errp)
     sPAPRMachineState *spapr = SPAPR_MACHINE(qdev_get_machine());
     CPUState *cs = CPU(child);
     PowerPCCPU *cpu = POWERPC_CPU(cs);
-    Object *obj = NULL;
+    Object *obj;
 
     object_property_set_bool(child, true, "realized", &local_err);
     if (local_err) {
@@ -198,13 +198,14 @@ static void spapr_cpu_core_realize_child(Object *child, Error **errp)
     object_property_add_const_link(obj, ICP_PROP_CPU, child, &error_abort);
     object_property_set_bool(obj, true, "realized", &local_err);
     if (local_err) {
-        goto error;
+        goto free_icp;
     }
 
     return;
 
-error:
+free_icp:
     object_unparent(obj);
+error:
     error_propagate(errp, local_err);
 }
 
-- 
2.7.4
