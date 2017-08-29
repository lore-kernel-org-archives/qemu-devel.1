Received: from eggs.gnu.org ([2001:4830:134:3::10]:49194)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1dmUD0-0001zN-Bv
	for qemu-devel@nongnu.org; Mon, 28 Aug 2017 20:16:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1dmUCw-0006MK-Aa
	for qemu-devel@nongnu.org; Mon, 28 Aug 2017 20:16:46 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:34486
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1dmUCw-0006Lk-1m
	for qemu-devel@nongnu.org; Mon, 28 Aug 2017 20:16:42 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v7T0E83x043864
	for <qemu-devel@nongnu.org>; Mon, 28 Aug 2017 20:16:41 -0400
Received: from e38.co.us.ibm.com (e38.co.us.ibm.com [32.97.110.159])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2cmu3kpexg-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 28 Aug 2017 20:16:41 -0400
Received: from localhost
	by e38.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Mon, 28 Aug 2017 18:16:40 -0600
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Mon, 28 Aug 2017 19:14:51 -0500
In-Reply-To: <1503965694-10794-1-git-send-email-mdroth@linux.vnet.ibm.com>
References: <1503965694-10794-1-git-send-email-mdroth@linux.vnet.ibm.com>
Message-Id: <1503965694-10794-77-git-send-email-mdroth@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 76/79] cpu: don't allow negative core id
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Laurent Vivier <lvivier@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>

From: Laurent Vivier <lvivier@redhat.com>

With pseries machine type a negative core-id is not managed properly:
-1 gives an inaccurate error message ("core -1 already populated"),
-2 crashes QEMU (core dump)

As it seems a negative value is invalid for any architecture,
instead of checking this in spapr_core_pre_plug() I think it's better
to check this in the generic part, core_prop_set_core_id()

Signed-off-by: Laurent Vivier <lvivier@redhat.com>
Message-Id: <20170802103259.25940-1-lvivier@redhat.com>
Reviewed-by: Greg Kurz <groug@kaod.org>
Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
(cherry picked from commit be2960baae07e5257cde8c814cbd91647e235147)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 hw/cpu/core.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/hw/cpu/core.c b/hw/cpu/core.c
index 2bf960d..bd578ab 100644
--- a/hw/cpu/core.c
+++ b/hw/cpu/core.c
@@ -33,6 +33,11 @@ static void core_prop_set_core_id(Object *obj, Visitor *v, const char *name,
         return;
     }
 
+    if (value < 0) {
+        error_setg(errp, "Invalid core id %"PRId64, value);
+        return;
+    }
+
     core->core_id = value;
 }
 
-- 
2.7.4
