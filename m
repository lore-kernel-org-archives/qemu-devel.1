Received: from eggs.gnu.org ([2001:4830:134:3::10]:42878)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1cHKC6-0003fN-5q
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 19:46:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1cHKC3-0001Rb-DY
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 19:46:46 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:57116)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1cHKC3-0001Qb-3C
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 19:46:43 -0500
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
	uBF0ha7r129104
	for <qemu-devel@nongnu.org>; Wed, 14 Dec 2016 19:46:42 -0500
Received: from e37.co.us.ibm.com (e37.co.us.ibm.com [32.97.110.158])
	by mx0a-001b2d01.pphosted.com with ESMTP id 27bdkw90ug-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 14 Dec 2016 19:46:41 -0500
Received: from localhost
	by e37.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Wed, 14 Dec 2016 17:46:41 -0700
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Wed, 14 Dec 2016 18:44:36 -0600
In-Reply-To: <1481762701-4587-1-git-send-email-mdroth@linux.vnet.ibm.com>
References: <1481762701-4587-1-git-send-email-mdroth@linux.vnet.ibm.com>
Message-Id: <1481762701-4587-43-git-send-email-mdroth@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 42/67] acpi/ipmi: Initialize the fwinfo before
 fetching it
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Corey Minyard <cminyard@mvista.com>, "Michael S. Tsirkin" <mst@redhat.com>

From: Corey Minyard <cminyard@mvista.com>

The initialization was missed before, resulting in some
bad data in the smbus case.

Signed-off-by: Corey Minyard <cminyard@mvista.com>
Cc: qemu-stable@nongnu.org
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
(cherry picked from commit 698ae42b9124dce23e03d0fea2e635b70540ef13)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 hw/acpi/ipmi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/acpi/ipmi.c b/hw/acpi/ipmi.c
index 7e74ce4..651e2e9 100644
--- a/hw/acpi/ipmi.c
+++ b/hw/acpi/ipmi.c
@@ -99,6 +99,7 @@ void build_acpi_ipmi_devices(Aml *scope, BusState *bus)
 
         ii = IPMI_INTERFACE(obj);
         iic = IPMI_INTERFACE_GET_CLASS(obj);
+        memset(&info, 0, sizeof(info));
         iic->get_fwinfo(ii, &info);
         aml_append(scope, aml_ipmi_device(&info));
     }
-- 
1.9.1
