Received: from eggs.gnu.org ([209.51.188.92]:38103)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1hEt3o-0001bj-ND
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 06:05:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1hEt3n-0004LF-Mj
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 06:05:28 -0400
From: Eric Auger <eric.auger@redhat.com>
Date: Fri, 12 Apr 2019 12:03:39 +0200
Message-Id: <20190412100354.6409-13-eric.auger@redhat.com>
In-Reply-To: <20190412100354.6409-1-eric.auger@redhat.com>
References: <20190412100354.6409-1-eric.auger@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [RFC v3 12/27] hw/arm/smmuv3: Store the PASID table
 GPA in the translation config
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org, peter.maydell@linaro.org
Cc: alex.williamson@redhat.com, mst@redhat.com, jean-philippe.brucker@arm.com, peterx@redhat.com, yi.l.liu@intel.com, vincent.stehle@arm.com

For VFIO integration we will need to pass the Context Descriptor (CD)
table GPA to the host. The CD table is also referred to as the PASID
table. Its GPA corresponds to the s1ctrptr field of the Stream Table
Entry. So let's decode and store it in the configuration structure.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
---
 hw/arm/smmuv3.c              | 1 +
 include/hw/arm/smmu-common.h | 1 +
 2 files changed, 2 insertions(+)

diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
index 1744874e72..96d4147533 100644
--- a/hw/arm/smmuv3.c
+++ b/hw/arm/smmuv3.c
@@ -351,6 +351,7 @@ static int decode_ste(SMMUv3State *s, SMMUTransCfg *c=
fg,
                       "SMMUv3 S1 stalling fault model not allowed yet\n"=
);
         goto bad_ste;
     }
+    cfg->s1ctxptr =3D STE_CTXPTR(ste);
     return 0;
=20
 bad_ste:
diff --git a/include/hw/arm/smmu-common.h b/include/hw/arm/smmu-common.h
index 2c7fbf4202..a1020b638c 100644
--- a/include/hw/arm/smmu-common.h
+++ b/include/hw/arm/smmu-common.h
@@ -68,6 +68,7 @@ typedef struct SMMUTransCfg {
     uint8_t tbi;               /* Top Byte Ignore */
     uint16_t asid;
     SMMUTransTableInfo tt[2];
+    dma_addr_t s1ctxptr;
     uint32_t iotlb_hits;       /* counts IOTLB hits for this asid */
     uint32_t iotlb_misses;     /* counts IOTLB misses for this asid */
 } SMMUTransCfg;
--=20
2.20.1
