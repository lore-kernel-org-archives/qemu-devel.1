Received: from eggs.gnu.org ([2001:4830:134:3::10]:40738)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1duT9Z-0004RY-NV
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 20:46:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1duT9T-0005h9-J6
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 20:46:12 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:51764
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1duT9T-0005et-D8
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 20:46:07 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v8K0hbF7041338
	for <qemu-devel@nongnu.org>; Tue, 19 Sep 2017 20:46:03 -0400
Received: from e16.ny.us.ibm.com (e16.ny.us.ibm.com [129.33.205.206])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2d3c3e5k7j-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 19 Sep 2017 20:46:03 -0400
Received: from localhost
	by e16.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Tue, 19 Sep 2017 20:46:03 -0400
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Tue, 19 Sep 2017 19:45:15 -0500
In-Reply-To: <20170920004521.9417-1-mdroth@linux.vnet.ibm.com>
References: <20170920004521.9417-1-mdroth@linux.vnet.ibm.com>
Message-Id: <20170920004521.9417-7-mdroth@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 06/12] hw/arm/allwinner-a10: Mark the
 allwinner-a10 device with user_creatable = false
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Thomas Huth <thuth@redhat.com>, Peter Maydell <peter.maydell@linaro.org>

From: Thomas Huth <thuth@redhat.com>

QEMU currently exits unexpectedly when the user accidentially
tries to do something like this:

$ aarch64-softmmu/qemu-system-aarch64 -S -M integratorcp -nographic
QEMU 2.9.93 monitor - type 'help' for more information
(qemu) device_add allwinner-a10
Unsupported NIC model: smc91c111

Exiting just due to a "device_add" should not happen. Looking closer
at the the realize and instance_init function of this device also
reveals that it is using serial_hds and nd_table directly there, so
this device is clearly not creatable by the user and should be marked
accordingly.

Signed-off-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>
Message-id: 1503416789-32080-1-git-send-email-thuth@redhat.com
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
(cherry picked from commit dc89a180caf143a5d596d3f2f776d13be83a687d)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 hw/arm/allwinner-a10.c    | 2 ++
 scripts/device-crash-test | 1 -
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/arm/allwinner-a10.c b/hw/arm/allwinner-a10.c
index f62a9a3541..43a3f01f45 100644
--- a/hw/arm/allwinner-a10.c
+++ b/hw/arm/allwinner-a10.c
@@ -118,6 +118,8 @@ static void aw_a10_class_init(ObjectClass *oc, void *data)
     DeviceClass *dc = DEVICE_CLASS(oc);
 
     dc->realize = aw_a10_realize;
+    /* Reason: Uses serial_hds in realize and nd_table in instance_init */
+    dc->user_creatable = false;
 }
 
 static const TypeInfo aw_a10_type_info = {
diff --git a/scripts/device-crash-test b/scripts/device-crash-test
index e77b693eb2..81d65b9617 100755
--- a/scripts/device-crash-test
+++ b/scripts/device-crash-test
@@ -187,7 +187,6 @@ ERROR_WHITELIST = [
     {'log':r"Device [\w.,-]+ can not be dynamically instantiated"},
     {'log':r"Platform Bus: Can not fit MMIO region of size "},
     # other more specific errors we will ignore:
-    {'device':'allwinner-a10', 'log':"Unsupported NIC model:"},
     {'device':'.*-spapr-cpu-core', 'log':r"CPU core type should be"},
     {'log':r"MSI(-X)? is not supported by interrupt controller"},
     {'log':r"pxb-pcie? devices cannot reside on a PCIe? bus"},
-- 
2.11.0
