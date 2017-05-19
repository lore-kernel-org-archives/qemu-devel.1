Received: from eggs.gnu.org ([2001:4830:134:3::10]:33620)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dBfCh-0000IX-Px
	for qemu-devel@nongnu.org; Fri, 19 May 2017 06:32:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dBfCe-0007iK-Hp
	for qemu-devel@nongnu.org; Fri, 19 May 2017 06:32:15 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:56902)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1dBfCe-0007i4-8Y
	for qemu-devel@nongnu.org; Fri, 19 May 2017 06:32:12 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v4JAO3CL097568
	for <qemu-devel@nongnu.org>; Fri, 19 May 2017 06:32:10 -0400
Received: from e38.co.us.ibm.com (e38.co.us.ibm.com [32.97.110.159])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2ahw45nbq6-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 19 May 2017 06:32:10 -0400
Received: from localhost
	by e38.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <groug@kaod.org>;
	Fri, 19 May 2017 04:32:10 -0600
From: Greg Kurz <groug@kaod.org>
Date: Fri, 19 May 2017 12:32:04 +0200
In-Reply-To: <149518991537.24289.6673616934370284758.stgit@bahia.lan>
References: <149518991537.24289.6673616934370284758.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <149518992406.24289.10624548011389715164.stgit@bahia.lan>
Subject: [Qemu-devel] [PATCH v2 1/4] spapr_cpu_core: drop reference on ICP
 object during CPU realization
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

When a piece of code allocates an object, it implicitely gets a reference
on it. If it then makes that object a child property of another object, it
should drop its own reference at some point otherwise the child object can
never be finalized. The current code hence leaks one ICP object per CPU
when hot-removing a core.

Failing to add a newly allocated ICP object to the CPU is a bug. While here,
let's ensure QEMU aborts if this ever happens.

Signed-off-by: Greg Kurz <groug@kaod.org>
---
 hw/ppc/spapr_cpu_core.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/ppc/spapr_cpu_core.c b/hw/ppc/spapr_cpu_core.c
index 1df1404ea52d..ff7058ecc00e 100644
--- a/hw/ppc/spapr_cpu_core.c
+++ b/hw/ppc/spapr_cpu_core.c
@@ -143,7 +143,8 @@ static void spapr_cpu_core_realize_child(Object *child, Error **errp)
     Object *obj;
 
     obj = object_new(spapr->icp_type);
-    object_property_add_child(OBJECT(cpu), "icp", obj, NULL);
+    object_property_add_child(OBJECT(cpu), "icp", obj, &error_abort);
+    object_unref(obj);
     object_property_add_const_link(obj, "xics", OBJECT(spapr), &error_abort);
     object_property_set_bool(obj, true, "realized", &local_err);
     if (local_err) {
