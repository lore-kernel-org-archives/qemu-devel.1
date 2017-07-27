Received: from eggs.gnu.org ([2001:4830:134:3::10]:33785)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bjsdjshi@linux.vnet.ibm.com>) id 1daY0z-0004iL-Es
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 21:55:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bjsdjshi@linux.vnet.ibm.com>) id 1daY0v-0006A8-EN
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 21:55:01 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:45452)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bjsdjshi@linux.vnet.ibm.com>)
	id 1daY0v-00069L-4A
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 21:54:57 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v6R1s39Y114378
	for <qemu-devel@nongnu.org>; Wed, 26 Jul 2017 21:54:55 -0400
Received: from e12.ny.us.ibm.com (e12.ny.us.ibm.com [129.33.205.202])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2by4fxwrp6-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 26 Jul 2017 21:54:55 -0400
Received: from localhost
	by e12.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <bjsdjshi@linux.vnet.ibm.com>;
	Wed, 26 Jul 2017 21:54:54 -0400
From: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
Date: Thu, 27 Jul 2017 03:54:18 +0200
In-Reply-To: <20170727015418.85407-1-bjsdjshi@linux.vnet.ibm.com>
References: <20170727015418.85407-1-bjsdjshi@linux.vnet.ibm.com>
Message-Id: <20170727015418.85407-4-bjsdjshi@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 3/3] s390x/css: generate channel path
 initialized CRW for channel path hotplug
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: cohuck@redhat.com, borntraeger@de.ibm.com, agraf@suse.de, rth@twiddle.net, bjsdjshi@linux.vnet.ibm.com, pasic@linux.vnet.ibm.com, pmorel@linux.vnet.ibm.com

When a channel path is hot plugged into a CSS, we should generate
a channel path initialized CRW (channel report word). The current
code does not do that, instead it puts a stub function with a TODO
reminder there.

This implements the css_generate_chp_crws() function by:
1. refactor the existing code.
2. add an @add parameter to provide future callers with the
   capability of generating channel path permanent error with
   facility not initialized CRW.
3. add a @hotplugged parameter, so to opt out generating initialized
   CRWs for predefined channel paths.

Signed-off-by: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
---
 hw/s390x/3270-ccw.c       |  3 ++-
 hw/s390x/css.c            | 55 ++++++++++++++++++++++++++++++++++++-----------
 hw/s390x/s390-ccw.c       |  2 +-
 hw/s390x/virtio-ccw.c     |  3 ++-
 include/hw/s390x/css.h    |  8 ++++---
 include/hw/s390x/ioinst.h |  1 +
 6 files changed, 53 insertions(+), 19 deletions(-)

diff --git a/hw/s390x/3270-ccw.c b/hw/s390x/3270-ccw.c
index 1554aa2484..20305b8554 100644
--- a/hw/s390x/3270-ccw.c
+++ b/hw/s390x/3270-ccw.c
@@ -125,7 +125,8 @@ static void emulated_ccw_3270_realize(DeviceState *ds, Error **errp)
     sch->id.reserved = 0xff;
     sch->id.cu_type = EMULATED_CCW_3270_CU_TYPE;
     css_sch_build_virtual_schib(sch, (uint8_t)chpid,
-                                EMULATED_CCW_3270_CHPID_TYPE);
+                                EMULATED_CCW_3270_CHPID_TYPE,
+                                parent->hotplugged);
     sch->do_subchannel_work = do_subchannel_work_virtual;
     sch->ccw_cb = emulated_ccw_3270_cb;
 
diff --git a/hw/s390x/css.c b/hw/s390x/css.c
index 60e1592d5c..ffa93e8a62 100644
--- a/hw/s390x/css.c
+++ b/hw/s390x/css.c
@@ -1745,11 +1745,8 @@ int css_do_rchp(uint8_t cssid, uint8_t chpid)
     }
 
     /* We don't really use a channel path, so we're done here. */
-    css_queue_crw(CRW_RSC_CHP, CRW_ERC_INIT, 1,
-                  channel_subsys.max_cssid > 0 ? 1 : 0, chpid);
-    if (channel_subsys.max_cssid > 0) {
-        css_queue_crw(CRW_RSC_CHP, CRW_ERC_INIT, 1, 0, real_cssid << 8);
-    }
+    css_generate_chp_crws(cssid, chpid, 0, 1, 1);
+
     return 0;
 }
 
@@ -1791,7 +1788,7 @@ unsigned int css_find_free_chpid(uint8_t cssid)
 }
 
 static int css_add_chpid(uint8_t cssid, uint8_t chpid, uint8_t type,
-                         bool is_virt)
+                         bool is_virt, int hotplugged)
 {
     CssImage *css;
 
@@ -1807,12 +1804,13 @@ static int css_add_chpid(uint8_t cssid, uint8_t chpid, uint8_t type,
     css->chpids[chpid].type = type;
     css->chpids[chpid].is_virtual = is_virt;
 
-    css_generate_chp_crws(cssid, chpid);
+    css_generate_chp_crws(cssid, chpid, hotplugged, 1, 0);
 
     return 0;
 }
 
-void css_sch_build_virtual_schib(SubchDev *sch, uint8_t chpid, uint8_t type)
+void css_sch_build_virtual_schib(SubchDev *sch, uint8_t chpid, uint8_t type,
+                                 int hotplugged)
 {
     PMCW *p = &sch->curr_status.pmcw;
     SCSW *s = &sch->curr_status.scsw;
@@ -1829,7 +1827,7 @@ void css_sch_build_virtual_schib(SubchDev *sch, uint8_t chpid, uint8_t type)
     p->pam = 0x80;
     p->chpid[0] = chpid;
     if (!css->chpids[chpid].in_use) {
-        css_add_chpid(sch->cssid, chpid, type, true);
+        css_add_chpid(sch->cssid, chpid, type, true, hotplugged);
     }
 
     memset(s, 0, sizeof(SCSW));
@@ -2098,9 +2096,40 @@ void css_generate_sch_crws(uint8_t cssid, uint8_t ssid, uint16_t schid,
     css_clear_io_interrupt(css_do_build_subchannel_id(cssid, ssid), schid);
 }
 
-void css_generate_chp_crws(uint8_t cssid, uint8_t chpid)
+void css_generate_chp_crws(uint8_t cssid, uint8_t chpid,
+                           int hotplugged, int add, int s)
 {
-    /* TODO */
+    uint8_t guest_cssid;
+    bool chain_crw;
+    int erc;
+
+    if (add && !s && !hotplugged) {
+        return;
+    }
+    if (channel_subsys.max_cssid == 0) {
+        /* Default cssid shows up as 0. */
+        guest_cssid = (cssid == channel_subsys.default_cssid) ? 0 : cssid;
+    } else {
+        /* Show real cssid to the guest. */
+        guest_cssid = cssid;
+    }
+    /*
+     * Only notify for higher subchannel sets/channel subsystems if the
+     * guest has enabled it.
+     */
+    if ((guest_cssid > channel_subsys.max_cssid) ||
+        ((channel_subsys.max_cssid == 0) &&
+         (cssid != channel_subsys.default_cssid))) {
+        return;
+    }
+
+    erc = add ? CRW_ERC_INIT : CRW_ERC_PERRN;
+    chain_crw = channel_subsys.max_cssid > 0;
+
+    css_queue_crw(CRW_RSC_CHP, erc, s, chain_crw ? 1 : 0, chpid);
+    if (chain_crw) {
+        css_queue_crw(CRW_RSC_CHP, erc, s, 0, cssid << 8);
+    }
 }
 
 void css_generate_css_crws(uint8_t cssid)
@@ -2433,7 +2462,7 @@ static int css_sch_get_chpid_type(uint8_t chpid, uint32_t *type,
  * guest subchannel information block without considering the migration feature.
  * We need to revisit this problem when we want to add migration support.
  */
-int css_sch_build_schib(SubchDev *sch, CssDevId *dev_id)
+int css_sch_build_schib(SubchDev *sch, CssDevId *dev_id, int hotplugged)
 {
     CssImage *css = channel_subsys.css[sch->cssid];
     PMCW *p = &sch->curr_status.pmcw;
@@ -2466,7 +2495,7 @@ int css_sch_build_schib(SubchDev *sch, CssDevId *dev_id)
             if (ret) {
                 return ret;
             }
-            css_add_chpid(sch->cssid, p->chpid[i], type, false);
+            css_add_chpid(sch->cssid, p->chpid[i], type, false, hotplugged);
         }
     }
 
diff --git a/hw/s390x/s390-ccw.c b/hw/s390x/s390-ccw.c
index 8614dda6f8..96d9a28719 100644
--- a/hw/s390x/s390-ccw.c
+++ b/hw/s390x/s390-ccw.c
@@ -86,7 +86,7 @@ static void s390_ccw_realize(S390CCWDevice *cdev, char *sysfsdev, Error **errp)
     sch->do_subchannel_work = do_subchannel_work_passthrough;
 
     ccw_dev->sch = sch;
-    ret = css_sch_build_schib(sch, &cdev->hostid);
+    ret = css_sch_build_schib(sch, &cdev->hostid, parent->hotplugged);
     if (ret) {
         error_setg_errno(&err, -ret, "%s: Failed to build initial schib",
                          __func__);
diff --git a/hw/s390x/virtio-ccw.c b/hw/s390x/virtio-ccw.c
index b1976fdd19..9c1642e51d 100644
--- a/hw/s390x/virtio-ccw.c
+++ b/hw/s390x/virtio-ccw.c
@@ -783,7 +783,8 @@ static void virtio_ccw_device_realize(VirtioCcwDevice *dev, Error **errp)
     ccw_dev->sch = sch;
     dev->indicators = NULL;
     dev->revision = -1;
-    css_sch_build_virtual_schib(sch, 0, VIRTIO_CCW_CHPID_TYPE);
+    css_sch_build_virtual_schib(sch, 0, VIRTIO_CCW_CHPID_TYPE,
+                                parent->hotplugged);
 
     trace_virtio_ccw_new_device(
         sch->cssid, sch->ssid, sch->schid, sch->devno,
diff --git a/include/hw/s390x/css.h b/include/hw/s390x/css.h
index d03b4ffeac..a8344ea360 100644
--- a/include/hw/s390x/css.h
+++ b/include/hw/s390x/css.h
@@ -142,8 +142,9 @@ int css_create_css_image(uint8_t cssid, bool default_image);
 bool css_devno_used(uint8_t cssid, uint8_t ssid, uint16_t devno);
 void css_subch_assign(uint8_t cssid, uint8_t ssid, uint16_t schid,
                       uint16_t devno, SubchDev *sch);
-void css_sch_build_virtual_schib(SubchDev *sch, uint8_t chpid, uint8_t type);
-int css_sch_build_schib(SubchDev *sch, CssDevId *dev_id);
+void css_sch_build_virtual_schib(SubchDev *sch, uint8_t chpid, uint8_t type,
+                                 int hotplugged);
+int css_sch_build_schib(SubchDev *sch, CssDevId *dev_id, int hotplugged);
 unsigned int css_find_free_chpid(uint8_t cssid);
 uint16_t css_build_subchannel_id(SubchDev *sch);
 void copy_scsw_to_guest(SCSW *dest, const SCSW *src);
@@ -153,7 +154,8 @@ void css_reset_sch(SubchDev *sch);
 void css_queue_crw(uint8_t rsc, uint8_t erc, int s, int chain, uint16_t rsid);
 void css_generate_sch_crws(uint8_t cssid, uint8_t ssid, uint16_t schid,
                            int hotplugged, int add);
-void css_generate_chp_crws(uint8_t cssid, uint8_t chpid);
+void css_generate_chp_crws(uint8_t cssid, uint8_t chpid,
+                           int hotplugged, int add, int s);
 void css_generate_css_crws(uint8_t cssid);
 void css_clear_sei_pending(void);
 int s390_ccw_cmd_request(ORB *orb, SCSW *scsw, void *data);
diff --git a/include/hw/s390x/ioinst.h b/include/hw/s390x/ioinst.h
index c1d1052279..ae2c230948 100644
--- a/include/hw/s390x/ioinst.h
+++ b/include/hw/s390x/ioinst.h
@@ -204,6 +204,7 @@ typedef struct CRW {
 #define CRW_ERC_EVENT  0x00
 #define CRW_ERC_INIT   0x02
 #define CRW_ERC_IPI    0x04
+#define CRW_ERC_PERRN  0x06
 
 #define CRW_RSC_SUBCH 0x3
 #define CRW_RSC_CHP   0x4
-- 
2.11.2
