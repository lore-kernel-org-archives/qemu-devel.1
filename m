Received: from eggs.gnu.org ([2001:4830:134:3::10]:34583)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1dQNHc-0001rk-Kq
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 20:26:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1dQNHX-00033I-I3
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 20:26:08 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:56031)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1dQNHX-000328-3C
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 20:26:03 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v5T0Nkib030675
	for <qemu-devel@nongnu.org>; Wed, 28 Jun 2017 20:26:01 -0400
Received: from e13.ny.us.ibm.com (e13.ny.us.ibm.com [129.33.205.203])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2bck158acd-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 28 Jun 2017 20:26:01 -0400
Received: from localhost
	by e13.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Wed, 28 Jun 2017 20:26:00 -0400
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Wed, 28 Jun 2017 19:24:57 -0500
In-Reply-To: <1498695900-1648-1-git-send-email-mdroth@linux.vnet.ibm.com>
References: <1498695900-1648-1-git-send-email-mdroth@linux.vnet.ibm.com>
Message-Id: <1498695900-1648-3-git-send-email-mdroth@linux.vnet.ibm.com>
Subject: [Qemu-devel] [RFC PATCH 2/5] qemu_hotplug: squash
 qemuDomainRemovePCIHostDevice into caller
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: libvir-list@redhat.com
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, aik@ozlabs.ru, alex.williamson@redhat.com, abologna@redhat.com, laine@laine.org, pkrempa@redhat.com, berrange@redhat.com, mprivozn@redhat.com, sbhat@linux.vnet.ibm.com

It's only called from one place, and only takes the extra step of
freeing the device alias after reattach. Since another path through
qemuDomainRemoveHostDevice introduced in a subsequent patch will also
need to free the device alias, it'll be more readable to just start
calling it directly.

Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 src/qemu/qemu_hotplug.c | 12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

diff --git a/src/qemu/qemu_hotplug.c b/src/qemu/qemu_hotplug.c
index a486fb4..b557e82 100644
--- a/src/qemu/qemu_hotplug.c
+++ b/src/qemu/qemu_hotplug.c
@@ -3805,15 +3805,6 @@ qemuDomainRemoveMemoryDevice(virQEMUDriverPtr driver,
 
 
 static void
-qemuDomainRemovePCIHostDevice(virQEMUDriverPtr driver,
-                              virDomainObjPtr vm,
-                              virDomainHostdevDefPtr hostdev)
-{
-    qemuHostdevReAttachPCIDevices(driver, vm->def->name, &hostdev, 1);
-    qemuDomainReleaseDeviceAddress(vm, hostdev->info, NULL);
-}
-
-static void
 qemuDomainRemoveUSBHostDevice(virQEMUDriverPtr driver,
                               virDomainObjPtr vm,
                               virDomainHostdevDefPtr hostdev)
@@ -3905,7 +3896,8 @@ qemuDomainRemoveHostDevice(virQEMUDriverPtr driver,
 
     switch ((virDomainHostdevSubsysType) hostdev->source.subsys.type) {
     case VIR_DOMAIN_HOSTDEV_SUBSYS_TYPE_PCI:
-        qemuDomainRemovePCIHostDevice(driver, vm, hostdev);
+        qemuHostdevReAttachPCIDevices(driver, vm->def->name, &hostdev, 1);
+        qemuDomainReleaseDeviceAddress(vm, hostdev->info, NULL);
         /* QEMU might no longer need to lock as much memory, eg. we just
          * detached the last VFIO device, so adjust the limit here */
         if (qemuDomainAdjustMaxMemLock(vm) < 0)
-- 
2.7.4
