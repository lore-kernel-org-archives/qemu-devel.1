Received: from eggs.gnu.org ([2001:4830:134:3::10]:56411)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mihajlov@de.ibm.com>) id 1f46UE-0001RF-Og
	for qemu-devel@nongnu.org; Thu, 05 Apr 2018 11:07:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mihajlov@de.ibm.com>) id 1f46UB-0007yd-IY
	for qemu-devel@nongnu.org; Thu, 05 Apr 2018 11:07:38 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:39044)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mihajlov@de.ibm.com>) id 1f46UB-0007yB-9n
	for qemu-devel@nongnu.org; Thu, 05 Apr 2018 11:07:35 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w35F6DP4067397
	for <qemu-devel@nongnu.org>; Thu, 5 Apr 2018 11:07:34 -0400
Received: from e06smtp12.uk.ibm.com (e06smtp12.uk.ibm.com [195.75.94.108])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2h5jxyaes7-1
	(version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 05 Apr 2018 11:07:33 -0400
Received: from localhost
	by e06smtp12.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mihajlov@de.ibm.com>;
	Thu, 5 Apr 2018 16:07:31 +0100
From: Viktor Mihajlovski <mihajlov@linux.vnet.ibm.com>
Date: Thu,  5 Apr 2018 17:07:23 +0200
In-Reply-To: <1522940844-12336-1-git-send-email-mihajlov@linux.vnet.ibm.com>
References: <1522940844-12336-1-git-send-email-mihajlov@linux.vnet.ibm.com>
Message-Id: <1522940844-12336-3-git-send-email-mihajlov@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 2/3] s390: Ensure IPL from SCSI works as
 expected
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: cohuck@redhat.com, borntraeger@de.ibm.com, agraf@suse.de, rth@twiddle.net, david@redhat.com, thuth@redhat.com, qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org

Operating systems may request an IPL from a virtio-scsi device
by specifying an IPL parameter type of CCW. In this case QEMU
won't set up the IPLB correctly. The BIOS will still detect
it's a SCSI device to boot from, but it will now have to search
for the first LUN and attempt to boot from there.
However this may not be the original boot LUN if there's more than
one SCSI disk attached to the HBA.

With this change QEMU will detect that the request is for a
SCSI device and will rebuild the initial IPL parameter info
if it's the SCSI device used for the first boot. In consequence
the BIOS can use the boot LUN from the IPL information block.

In case a different SCSI device has been set, the BIOS will find
and use the first available LUN.

Signed-off-by: Viktor Mihajlovski <mihajlov@linux.vnet.ibm.com>
---
 hw/s390x/ipl.c | 31 +++++++++++++++++++++++++++++--
 1 file changed, 29 insertions(+), 2 deletions(-)

diff --git a/hw/s390x/ipl.c b/hw/s390x/ipl.c
index 58e33c5..fb554ab 100644
--- a/hw/s390x/ipl.c
+++ b/hw/s390x/ipl.c
@@ -427,7 +427,8 @@ unref_mr:
     return img_size;
 }
 
-static bool is_virtio_net_device(IplParameterBlock *iplb)
+static bool is_virtio_ccw_device_of_type(IplParameterBlock *iplb,
+                                         int virtio_id)
 {
     uint8_t cssid;
     uint8_t ssid;
@@ -447,13 +448,23 @@ static bool is_virtio_net_device(IplParameterBlock *iplb)
             sch = css_find_subch(1, cssid, ssid, schid);
 
             if (sch && sch->devno == devno) {
-                return sch->id.cu_model == VIRTIO_ID_NET;
+                return sch->id.cu_model == virtio_id;
             }
         }
     }
     return false;
 }
 
+static bool is_virtio_net_device(IplParameterBlock *iplb)
+{
+    return is_virtio_ccw_device_of_type(iplb, VIRTIO_ID_NET);
+}
+
+static bool is_virtio_scsi_device(IplParameterBlock *iplb)
+{
+    return is_virtio_ccw_device_of_type(iplb, VIRTIO_ID_SCSI);
+}
+
 void s390_ipl_update_diag308(IplParameterBlock *iplb)
 {
     S390IPLState *ipl = get_ipl_device();
@@ -478,6 +489,22 @@ void s390_reipl_request(void)
     S390IPLState *ipl = get_ipl_device();
 
     ipl->reipl_requested = true;
+    if (ipl->iplb_valid &&
+        !ipl->netboot &&
+        ipl->iplb.pbt == S390_IPL_TYPE_CCW &&
+        is_virtio_scsi_device(&ipl->iplb)) {
+        CcwDevice *ccw_dev = s390_get_ccw_device(get_boot_device(0));
+
+        if (ccw_dev &&
+            cpu_to_be16(ccw_dev->sch->devno) == ipl->iplb.ccw.devno &&
+            (ccw_dev->sch->ssid & 3) == ipl->iplb.ccw.ssid) {
+            /*
+             * this is the original boot device's SCSI
+             * so restore IPL parameter info from it
+             */
+            ipl->iplb_valid = s390_gen_initial_iplb(ipl);
+        }
+    }
     qemu_system_reset_request(SHUTDOWN_CAUSE_GUEST_RESET);
 }
 
-- 
1.9.1
