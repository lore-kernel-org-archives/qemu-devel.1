Received: from eggs.gnu.org ([2001:4830:134:3::10]:39320)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bharat.bhushan@nxp.com>) id 1gRXEp-0004Pb-VF
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 01:52:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bharat.bhushan@nxp.com>) id 1gRXEo-0003fs-U8
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 01:52:51 -0500
From: Bharat Bhushan <bharat.bhushan@nxp.com>
Date: Tue, 27 Nov 2018 06:52:47 +0000
Message-ID: <20181127064101.25887-2-Bharat.Bhushan@nxp.com>
References: <20181127064101.25887-1-Bharat.Bhushan@nxp.com>
In-Reply-To: <20181127064101.25887-1-Bharat.Bhushan@nxp.com>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: [Qemu-devel] [PATCH RFC v5 1/5] hw/vfio/common: Do not print error
 when viommu translates into an mmio region
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "peter.maydell@linaro.org" <peter.maydell@linaro.org>, "alex.williamson@redhat.com" <alex.williamson@redhat.com>, "kevin.tian@intel.com" <kevin.tian@intel.com>, "mst@redhat.com" <mst@redhat.com>, "tn@semihalf.com" <tn@semihalf.com>, "drjones@redhat.com" <drjones@redhat.com>, "linu.cherian@cavium.com" <linu.cherian@cavium.com>, "linuc.decode@gmail.com" <linuc.decode@gmail.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>
Cc: "eric.auger.pro@gmail.com" <eric.auger.pro@gmail.com>, "peterx@redhat.com" <peterx@redhat.com>, "bharatb.yadav@gmail.com" <bharatb.yadav@gmail.com>, Eric Auger <eric.auger@redhat.com>, Bharat Bhushan <bharat.bhushan@nxp.com>

From: Eric Auger <eric.auger@redhat.com>

On ARM, the MSI doorbell is translated by the virtual IOMMU.
As such address_space_translate() returns the MSI controller
MMIO region and we get an "iommu map to non memory area"
message. Let's remove this latter.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Bharat Bhushan <Bharat.Bhushan@nxp.com>
---
v5:
 - Added thi patch from Eric previous series (Eric somehow dropped in
   last version and this is needed for VFIO.

 hw/vfio/common.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/hw/vfio/common.c b/hw/vfio/common.c
index 7c185e5a2e..fc40543121 100644
--- a/hw/vfio/common.c
+++ b/hw/vfio/common.c
@@ -328,8 +328,6 @@ static bool vfio_get_vaddr(IOMMUTLBEntry *iotlb, void *=
*vaddr,
                                  &xlat, &len, writable,
                                  MEMTXATTRS_UNSPECIFIED);
     if (!memory_region_is_ram(mr)) {
-        error_report("iommu map to non memory area %"HWADDR_PRIx"",
-                     xlat);
         return false;
     }
=20
--=20
2.19.1
