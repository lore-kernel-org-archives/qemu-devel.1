Received: from eggs.gnu.org ([2001:4830:134:3::10]:39338)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sbobroff@linux.ibm.com>) id 1fvG2m-00040f-8O
	for qemu-devel@nongnu.org; Thu, 30 Aug 2018 02:03:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sbobroff@linux.ibm.com>) id 1fvFuq-000538-3e
	for qemu-devel@nongnu.org; Thu, 30 Aug 2018 01:54:52 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:43512
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <sbobroff@linux.ibm.com>)
	id 1fvFup-00052d-Uz
	for qemu-devel@nongnu.org; Thu, 30 Aug 2018 01:54:48 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w7U5rqwR128737
	for <qemu-devel@nongnu.org>; Thu, 30 Aug 2018 01:54:46 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2m6a4shf3v-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 30 Aug 2018 01:54:46 -0400
Received: from localhost
	by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <sbobroff@linux.ibm.com>;
	Thu, 30 Aug 2018 06:54:44 +0100
From: Sam Bobroff <sbobroff@linux.ibm.com>
Date: Thu, 30 Aug 2018 15:54:40 +1000
Message-Id: <d14d97226c3b432fa70513dcd7bacf59c6881cbd.1535608432.git.sbobroff@linux.ibm.com>
Subject: [Qemu-devel] [PATCH 1/1] spapr: Correct reference count on
 spapr-cpu-core
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Cc: david@gibson.dropbear.id.au, lvivier@redhat.com

spapr_init_cpus() currently creates spapr-cpu-core objects via
object_new() and setting their realized property to true. This leaves
their reference count at two, because object_new() adds an initial
reference and the realization attaches them to a default parent object
which also increments the reference count.

This causes a problem if one of these cores is hot unplugged: no
delete event is generated for it because it's reference count doesn't
reach zero when it is detached from it's parent.

Correct this by adding a call to object_unref() in spapr_init_cpus().

Signed-off-by: Sam Bobroff <sbobroff@linux.ibm.com>
---
 hw/ppc/spapr.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 0d032a1ad0..fbb00f0c56 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -2502,6 +2502,8 @@ static void spapr_init_cpus(sPAPRMachineState *spapr)
             object_property_set_int(core, core_id, CPU_CORE_PROP_CORE_ID,
                                     &error_fatal);
             object_property_set_bool(core, true, "realized", &error_fatal);
+
+            object_unref(core);
         }
     }
 }
-- 
2.16.1.74.g9b0b1f47b
