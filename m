Received: from eggs.gnu.org ([2001:4830:134:3::10]:44438)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bjsdjshi@linux.vnet.ibm.com>) id 1eZTB8-0004th-CR
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 22:05:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bjsdjshi@linux.vnet.ibm.com>) id 1eZTB6-000313-C7
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 22:05:18 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:54026)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bjsdjshi@linux.vnet.ibm.com>)
	id 1eZTB5-0002yc-Hn
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 22:05:15 -0500
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w0B34DiZ061209
	for <qemu-devel@nongnu.org>; Wed, 10 Jan 2018 22:05:13 -0500
Received: from e38.co.us.ibm.com (e38.co.us.ibm.com [32.97.110.159])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2fduc6sqpe-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 10 Jan 2018 22:05:12 -0500
Received: from localhost
	by e38.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <bjsdjshi@linux.vnet.ibm.com>;
	Wed, 10 Jan 2018 20:05:11 -0700
From: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
Date: Thu, 11 Jan 2018 04:04:56 +0100
In-Reply-To: <20180111030459.33757-1-bjsdjshi@linux.vnet.ibm.com>
References: <20180111030459.33757-1-bjsdjshi@linux.vnet.ibm.com>
Message-Id: <20180111030459.33757-3-bjsdjshi@linux.vnet.ibm.com>
Subject: [Qemu-devel] [RFC PATCH 2/5] vfio/ccw: get schib region info
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, kvm@vger.kernel.org, qemu-devel@nongnu.org, qemu-s390x@nongnu.org
Cc: cohuck@redhat.com, borntraeger@de.ibm.com, bjsdjshi@linux.vnet.ibm.com, pasic@linux.vnet.ibm.com, pmorel@linux.vnet.ibm.com

vfio-ccw provides an MMIO region for store subchannel
information. We fetch this information via ioctls here,
then we can use it to update schib for virtual subchannels
later on.

While we are at it, also modify the comment and error
message for the config region a bit, to make these unified
with the schib likeness.

Signed-off-by: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
---
 hw/vfio/ccw.c | 24 +++++++++++++++++++++++-
 1 file changed, 23 insertions(+), 1 deletion(-)

diff --git a/hw/vfio/ccw.c b/hw/vfio/ccw.c
index 16713f2c52..e673695509 100644
--- a/hw/vfio/ccw.c
+++ b/hw/vfio/ccw.c
@@ -32,6 +32,10 @@ typedef struct VFIOCCWDevice {
     uint64_t io_region_offset;
     struct ccw_io_region *io_region;
     EventNotifier io_notifier;
+
+    uint64_t schib_region_size;
+    uint64_t schib_region_offset;
+    struct ccw_schib_region *schib_region;
 } VFIOCCWDevice;
 
 static void vfio_ccw_compute_needs_reset(VFIODevice *vdev)
@@ -268,9 +272,10 @@ static void vfio_ccw_get_region(VFIOCCWDevice *vcdev, Error **errp)
         return;
     }
 
+    /* Get I/O region info. */
     ret = vfio_get_region_info(vdev, VFIO_CCW_CONFIG_REGION_INDEX, &info);
     if (ret) {
-        error_setg_errno(errp, -ret, "vfio: Error getting config info");
+        error_setg_errno(errp, -ret, "vfio: Error getting config region info");
         return;
     }
 
@@ -283,13 +288,30 @@ static void vfio_ccw_get_region(VFIOCCWDevice *vcdev, Error **errp)
 
     vcdev->io_region_offset = info->offset;
     vcdev->io_region = g_malloc0(info->size);
+    g_free(info);
 
+    /* Get SCHIB region info. */
+    ret = vfio_get_region_info(vdev, VFIO_CCW_SCHIB_REGION_INDEX, &info);
+    if (ret) {
+        error_setg_errno(errp, -ret, "vfio: Error getting schib region info");
+        return;
+    }
+
+    vcdev->schib_region_size = info->size;
+    if (sizeof(*vcdev->schib_region) != vcdev->schib_region_size) {
+        error_setg(errp, "vfio: Unexpected size of the schib region");
+        g_free(info);
+        return;
+    }
+    vcdev->schib_region_offset = info->offset;
+    vcdev->schib_region = g_malloc0(info->size);
     g_free(info);
 }
 
 static void vfio_ccw_put_region(VFIOCCWDevice *vcdev)
 {
     g_free(vcdev->io_region);
+    g_free(vcdev->schib_region);
 }
 
 static void vfio_put_device(VFIOCCWDevice *vcdev)
-- 
2.13.5
