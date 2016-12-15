Received: from eggs.gnu.org ([2001:4830:134:3::10]:43432)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1cHKCN-0004tl-5I
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 19:47:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1cHKCJ-0001fP-Sc
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 19:47:03 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:44775)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1cHKCJ-0001eR-JZ
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 19:46:59 -0500
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
	uBF0jmxP130273
	for <qemu-devel@nongnu.org>; Wed, 14 Dec 2016 19:46:58 -0500
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
	by mx0a-001b2d01.pphosted.com with ESMTP id 27bdku13bx-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 14 Dec 2016 19:46:58 -0500
Received: from localhost
	by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Wed, 14 Dec 2016 17:46:57 -0700
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Wed, 14 Dec 2016 18:44:53 -0600
In-Reply-To: <1481762701-4587-1-git-send-email-mdroth@linux.vnet.ibm.com>
References: <1481762701-4587-1-git-send-email-mdroth@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Message-Id: <1481762701-4587-60-git-send-email-mdroth@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 59/67] ivshmem: Fix 64 bit memory bar
 configuration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Zhuang Yanying <ann.zhuangyanying@huawei.com>, "Michael S. Tsirkin" <mst@redhat.com>

From: Zhuang Yanying <ann.zhuangyanying@huawei.com>

Device ivshmem property use64=3D0 is designed to make the device
expose a 32 bit shared memory BAR instead of 64 bit one.  The
default is a 64 bit BAR, except pc-1.2 and older retain a 32 bit
BAR.  A 32 bit BAR can support only up to 1 GiB of shared memory.

This worked as designed until commit 5400c02 accidentally flipped
its sense: since then, we misinterpret use64=3D0 as use64=3D1 and vice
versa.  Worse, the default got flipped as well.  Devices
ivshmem-plain and ivshmem-doorbell are not affected.

Fix by restoring the test of IVShmemState member not_legacy_32bit
that got messed up in commit 5400c02.  Also update its
initialization for devices ivhsmem-plain and ivshmem-doorbell.
Without that, they'd regress to 32 bit BARs.

Cc: qemu-stable@nongnu.org
Signed-off-by: Zhuang Yanying <ann.zhuangyanying@huawei.com>
Reviewed-by: Gonglei <arei.gonglei@huawei.com>
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
(cherry picked from commit be4e0d737527d8670dc271712faae0de6a181b4e)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 hw/misc/ivshmem.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/hw/misc/ivshmem.c b/hw/misc/ivshmem.c
index 40a2ebc..81783d5 100644
--- a/hw/misc/ivshmem.c
+++ b/hw/misc/ivshmem.c
@@ -859,7 +859,7 @@ static void ivshmem_common_realize(PCIDevice *dev, Er=
ror **errp)
     pci_register_bar(dev, 0, PCI_BASE_ADDRESS_SPACE_MEMORY,
                      &s->ivshmem_mmio);
=20
-    if (!s->not_legacy_32bit) {
+    if (s->not_legacy_32bit) {
         attr |=3D PCI_BASE_ADDRESS_MEM_TYPE_64;
     }
=20
@@ -1045,6 +1045,7 @@ static void ivshmem_plain_init(Object *obj)
                              ivshmem_check_memdev_is_busy,
                              OBJ_PROP_LINK_UNREF_ON_RELEASE,
                              &error_abort);
+    s->not_legacy_32bit =3D 1;
 }
=20
 static void ivshmem_plain_realize(PCIDevice *dev, Error **errp)
@@ -1116,6 +1117,7 @@ static void ivshmem_doorbell_init(Object *obj)
=20
     s->features |=3D (1 << IVSHMEM_MSI);
     s->legacy_size =3D SIZE_MAX;  /* whatever the server sends */
+    s->not_legacy_32bit =3D 1;
 }
=20
 static void ivshmem_doorbell_realize(PCIDevice *dev, Error **errp)
--=20
1.9.1
