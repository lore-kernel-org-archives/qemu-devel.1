Received: from eggs.gnu.org ([2001:4830:134:3::10]:51250)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gZ6pr-0005rp-M1
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 23:18:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gZ6pp-0007cH-Rm
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 23:18:23 -0500
Received: from mx1.redhat.com ([209.132.183.28]:38026)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1gZ6pp-0007aL-0Z
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 23:18:21 -0500
Date: Mon, 17 Dec 2018 23:18:17 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20181218041625.24969-23-mst@redhat.com>
References: <20181218041625.24969-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181218041625.24969-1-mst@redhat.com>
Subject: [Qemu-devel] [PULL 22/31] intel_iommu: turn on IR by default
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Peter Xu <peterx@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>

From: Peter Xu <peterx@redhat.com>

IR has been there for a long time and long time no bug reported.
Let's turn it on by default to match general hardwares.  Providing
compatibility bit for QEMU<=3.1.

Signed-off-by: Peter Xu <peterx@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/hw/i386/pc.h | 4 ++++
 hw/i386/x86-iommu.c  | 2 +-
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
index c7c0c944e8..ed958b9af1 100644
--- a/include/hw/i386/pc.h
+++ b/include/hw/i386/pc.h
@@ -300,6 +300,10 @@ bool e820_get_entry(int, uint32_t, uint64_t *, uint64_t *);
         .driver   = "intel-iommu",\
         .property = "dma-drain",\
         .value    = "off",\
+    },{\
+        .driver   = "x86-iommu",\
+        .property = "intremap",\
+        .value    = "off",\
     },
 
 #define PC_COMPAT_3_0 \
diff --git a/hw/i386/x86-iommu.c b/hw/i386/x86-iommu.c
index abc3c03158..0150ceda14 100644
--- a/hw/i386/x86-iommu.c
+++ b/hw/i386/x86-iommu.c
@@ -135,7 +135,7 @@ static void x86_iommu_realize(DeviceState *dev, Error **errp)
 }
 
 static Property x86_iommu_properties[] = {
-    DEFINE_PROP_BOOL("intremap", X86IOMMUState, intr_supported, false),
+    DEFINE_PROP_BOOL("intremap", X86IOMMUState, intr_supported, true),
     DEFINE_PROP_BOOL("device-iotlb", X86IOMMUState, dt_supported, false),
     DEFINE_PROP_BOOL("pt", X86IOMMUState, pt_supported, true),
     DEFINE_PROP_END_OF_LIST(),
-- 
MST
