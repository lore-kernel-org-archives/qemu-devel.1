Received: from eggs.gnu.org ([2001:4830:134:3::10]:56505)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1dVyOx-0008Ev-1j
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 07:04:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1dVyOt-0003tn-S3
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 07:04:51 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:34295
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1dVyOt-0003ss-M5
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 07:04:47 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v6EB4kXZ084196
	for <qemu-devel@nongnu.org>; Fri, 14 Jul 2017 07:04:47 -0400
Received: from e06smtp10.uk.ibm.com (e06smtp10.uk.ibm.com [195.75.94.106])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2bpuk7tps4-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 14 Jul 2017 07:04:46 -0400
Received: from localhost
	by e06smtp10.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Fri, 14 Jul 2017 12:03:55 +0100
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Fri, 14 Jul 2017 12:40:38 +0200
In-Reply-To: <1500028867-134709-1-git-send-email-borntraeger@de.ibm.com>
References: <1500028867-134709-1-git-send-email-borntraeger@de.ibm.com>
Message-Id: <1500028867-134709-12-git-send-email-borntraeger@de.ibm.com>
Subject: [Qemu-devel] [PULL 11/40] s390x/css: update css_adapter_interrupt
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel <qemu-devel@nongnu.org>, Alexander Graf <agraf@suse.de>, Richard Henderson <rth@twiddle.net>, Cornelia Huck <cohuck@redhat.com>, Thomas Huth <thuth@redhat.com>, Yi Min Zhao <zyimin@linux.vnet.ibm.com>, Fei Li <sherrylf@linux.vnet.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>

From: Yi Min Zhao <zyimin@linux.vnet.ibm.com>

Let's use the new inject_airq callback of flic to inject adapter
interrupts. For kvm case, if the kernel flic doesn't support the new
interface, the irq routine remains unchanged. For non-kvm case,
qemu-flic handles the suppression process.

Signed-off-by: Yi Min Zhao <zyimin@linux.vnet.ibm.com>
Signed-off-by: Fei Li <sherrylf@linux.vnet.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 hw/s390x/css.c          | 18 ++++++++++++++++--
 hw/s390x/s390-pci-bus.c |  2 +-
 hw/s390x/virtio-ccw.c   |  2 +-
 include/hw/s390x/css.h  |  2 +-
 4 files changed, 19 insertions(+), 5 deletions(-)

diff --git a/hw/s390x/css.c b/hw/s390x/css.c
index 7b82176..1aed89f 100644
--- a/hw/s390x/css.c
+++ b/hw/s390x/css.c
@@ -547,12 +547,26 @@ out:
     return r;
 }
 
-void css_adapter_interrupt(uint8_t isc)
+void css_adapter_interrupt(CssIoAdapterType type, uint8_t isc)
 {
+    S390FLICState *fs = s390_get_flic();
+    S390FLICStateClass *fsc = S390_FLIC_COMMON_GET_CLASS(fs);
     uint32_t io_int_word = (isc << 27) | IO_INT_WORD_AI;
+    IoAdapter *adapter = channel_subsys.io_adapters[type][isc];
+
+    if (!adapter) {
+        return;
+    }
 
     trace_css_adapter_interrupt(isc);
-    s390_io_interrupt(0, 0, 0, io_int_word);
+    if (fs->ais_supported) {
+        if (fsc->inject_airq(fs, type, isc, adapter->flags)) {
+            error_report("Failed to inject airq with AIS supported");
+            exit(1);
+        }
+    } else {
+        s390_io_interrupt(0, 0, 0, io_int_word);
+    }
 }
 
 static void sch_handle_clear_func(SubchDev *sch)
diff --git a/hw/s390x/s390-pci-bus.c b/hw/s390x/s390-pci-bus.c
index b9603e7..2de4435 100644
--- a/hw/s390x/s390-pci-bus.c
+++ b/hw/s390x/s390-pci-bus.c
@@ -504,7 +504,7 @@ static void s390_msi_ctrl_write(void *opaque, hwaddr addr, uint64_t data,
                    0x80 >> ((ind_bit + vec) % 8));
     if (!set_ind_atomic(pbdev->routes.adapter.summary_addr + sum_bit / 8,
                                        0x80 >> (sum_bit % 8))) {
-        css_adapter_interrupt(pbdev->isc);
+        css_adapter_interrupt(CSS_IO_ADAPTER_PCI, pbdev->isc);
     }
 }
 
diff --git a/hw/s390x/virtio-ccw.c b/hw/s390x/virtio-ccw.c
index e18fd26..5afd9bb 100644
--- a/hw/s390x/virtio-ccw.c
+++ b/hw/s390x/virtio-ccw.c
@@ -1074,7 +1074,7 @@ static void virtio_ccw_notify(DeviceState *d, uint16_t vector)
                                   0x80 >> ((ind_bit + vector) % 8));
             if (!virtio_set_ind_atomic(sch, dev->summary_indicator->addr,
                                        0x01)) {
-                css_adapter_interrupt(dev->thinint_isc);
+                css_adapter_interrupt(CSS_IO_ADAPTER_VIRTIO, dev->thinint_isc);
             }
         } else {
             indicators = address_space_ldq(&address_space_memory,
diff --git a/include/hw/s390x/css.h b/include/hw/s390x/css.h
index 5ee6d52..dd36d39 100644
--- a/include/hw/s390x/css.h
+++ b/include/hw/s390x/css.h
@@ -155,7 +155,6 @@ void css_generate_sch_crws(uint8_t cssid, uint8_t ssid, uint16_t schid,
 void css_generate_chp_crws(uint8_t cssid, uint8_t chpid);
 void css_generate_css_crws(uint8_t cssid);
 void css_clear_sei_pending(void);
-void css_adapter_interrupt(uint8_t isc);
 int s390_ccw_cmd_request(ORB *orb, SCSW *scsw, void *data);
 int do_subchannel_work_virtual(SubchDev *sub, ORB *orb);
 int do_subchannel_work_passthrough(SubchDev *sub, ORB *orb);
@@ -166,6 +165,7 @@ typedef enum {
     CSS_IO_ADAPTER_TYPE_NUMS,
 } CssIoAdapterType;
 
+void css_adapter_interrupt(CssIoAdapterType type, uint8_t isc);
 int css_do_sic(CPUS390XState *env, uint8_t isc, uint16_t mode);
 uint32_t css_get_adapter_id(CssIoAdapterType type, uint8_t isc);
 void css_register_io_adapters(CssIoAdapterType type, bool swap, bool maskable,
-- 
2.7.4
