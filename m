Received: from eggs.gnu.org ([2001:4830:134:3::10]:46491)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bjsdjshi@linux.vnet.ibm.com>) id 1d6SbX-0002FE-MK
	for qemu-devel@nongnu.org; Thu, 04 May 2017 22:04:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bjsdjshi@linux.vnet.ibm.com>) id 1d6SbT-0004DB-Lf
	for qemu-devel@nongnu.org; Thu, 04 May 2017 22:04:23 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:48945)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bjsdjshi@linux.vnet.ibm.com>)
	id 1d6SbT-0004Ct-Cw
	for qemu-devel@nongnu.org; Thu, 04 May 2017 22:04:19 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v4523aYf086457
	for <qemu-devel@nongnu.org>; Thu, 4 May 2017 22:04:18 -0400
Received: from e11.ny.us.ibm.com (e11.ny.us.ibm.com [129.33.205.201])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2a89ssy3mb-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 04 May 2017 22:04:18 -0400
Received: from localhost
	by e11.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <bjsdjshi@linux.vnet.ibm.com>;
	Thu, 4 May 2017 22:04:16 -0400
From: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
Date: Fri,  5 May 2017 04:03:43 +0200
In-Reply-To: <20170505020352.8984-1-bjsdjshi@linux.vnet.ibm.com>
References: <20170505020352.8984-1-bjsdjshi@linux.vnet.ibm.com>
Message-Id: <20170505020352.8984-5-bjsdjshi@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH v7 04/13] s390x/css: realize css_sch_build_schib
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: kvm@vger.kernel.org, linux-s390@vger.kernel.org, qemu-devel@nongnu.org
Cc: bjsdjshi@linux.vnet.ibm.com, cornelia.huck@de.ibm.com, borntraeger@de.ibm.com, agraf@suse.com, alex.williamson@redhat.com, eric.auger@redhat.com, Xiao Feng Ren <renxiaof@linux.vnet.ibm.com>

From: Xiao Feng Ren <renxiaof@linux.vnet.ibm.com>

The S390 virtual css support already has a mechanism to build virtual
Sub-Channel Information Block and provide virtual subchannels to the
guest. However, to pass-through subchannels to a guest, we need to
introduce a new mechanism to build its schib according to the real
device information. Thus we realize a new css_sch_build_schib function
to extract the path_masks, chpids, chpid type from sysfs. To reuse
the existing code, we refactor css_add_virtual_chpid to css_add_chpid.

Reviewed-by: Pierre Morel <pmorel@linux.vnet.ibm.com>
Signed-off-by: Xiao Feng Ren <renxiaof@linux.vnet.ibm.com>
Signed-off-by: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
---
 hw/s390x/css.c         | 153 ++++++++++++++++++++++++++++++++++++++++++++++++-
 include/hw/s390x/css.h |  36 ++++++------
 2 files changed, 169 insertions(+), 20 deletions(-)

diff --git a/hw/s390x/css.c b/hw/s390x/css.c
index c03bb20..748e2ad 100644
--- a/hw/s390x/css.c
+++ b/hw/s390x/css.c
@@ -13,6 +13,7 @@
 #include "qapi/error.h"
 #include "qapi/visitor.h"
 #include "hw/qdev.h"
+#include "qemu/error-report.h"
 #include "qemu/bitops.h"
 #include "exec/address-spaces.h"
 #include "cpu.h"
@@ -1302,7 +1303,8 @@ bool css_schid_final(int m, uint8_t cssid, uint8_t ssid, uint16_t schid)
                                  (MAX_SCHID + 1) / sizeof(unsigned long));
 }
 
-static int css_add_virtual_chpid(uint8_t cssid, uint8_t chpid, uint8_t type)
+static int css_add_chpid(uint8_t cssid, uint8_t chpid, uint8_t type,
+                         bool is_virt)
 {
     CssImage *css;
 
@@ -1316,7 +1318,7 @@ static int css_add_virtual_chpid(uint8_t cssid, uint8_t chpid, uint8_t type)
     }
     css->chpids[chpid].in_use = 1;
     css->chpids[chpid].type = type;
-    css->chpids[chpid].is_virtual = 1;
+    css->chpids[chpid].is_virtual = is_virt;
 
     css_generate_chp_crws(cssid, chpid);
 
@@ -1340,7 +1342,7 @@ void css_sch_build_virtual_schib(SubchDev *sch, uint8_t chpid, uint8_t type)
     p->pam = 0x80;
     p->chpid[0] = chpid;
     if (!css->chpids[chpid].in_use) {
-        css_add_virtual_chpid(sch->cssid, chpid, type);
+        css_add_chpid(sch->cssid, chpid, type, true);
     }
 
     memset(s, 0, sizeof(SCSW));
@@ -1954,3 +1956,148 @@ SubchDev *css_create_virtual_sch(CssDevId bus_id, Error **errp)
     css_subch_assign(sch->cssid, sch->ssid, schid, sch->devno, sch);
     return sch;
 }
+
+static int css_sch_get_chpids(SubchDev *sch, CssDevId *dev_id)
+{
+    char *fid_path;
+    FILE *fd;
+    uint32_t chpid[8];
+    int i;
+    PMCW *p = &sch->curr_status.pmcw;
+
+    fid_path = g_strdup_printf("/sys/bus/css/devices/%x.%x.%04x/chpids",
+                               dev_id->cssid, dev_id->ssid, dev_id->devid);
+    fd = fopen(fid_path, "r");
+    if (fd == NULL) {
+        error_report("%s: open %s failed", __func__, fid_path);
+        g_free(fid_path);
+        return -EINVAL;
+    }
+
+    if (fscanf(fd, "%x %x %x %x %x %x %x %x",
+        &chpid[0], &chpid[1], &chpid[2], &chpid[3],
+        &chpid[4], &chpid[5], &chpid[6], &chpid[7]) != 8) {
+        fclose(fd);
+        g_free(fid_path);
+        return -EINVAL;
+    }
+
+    for (i = 0; i < ARRAY_SIZE(p->chpid); i++) {
+        p->chpid[i] = chpid[i];
+    }
+
+    fclose(fd);
+    g_free(fid_path);
+
+    return 0;
+}
+
+static int css_sch_get_path_masks(SubchDev *sch, CssDevId *dev_id)
+{
+    char *fid_path;
+    FILE *fd;
+    uint32_t pim, pam, pom;
+    PMCW *p = &sch->curr_status.pmcw;
+
+    fid_path = g_strdup_printf("/sys/bus/css/devices/%x.%x.%04x/pimpampom",
+                               dev_id->cssid, dev_id->ssid, dev_id->devid);
+    fd = fopen(fid_path, "r");
+    if (fd == NULL) {
+        error_report("%s: open %s failed", __func__, fid_path);
+        g_free(fid_path);
+        return -EINVAL;
+    }
+
+    if (fscanf(fd, "%x %x %x", &pim, &pam, &pom) != 3) {
+        fclose(fd);
+        g_free(fid_path);
+        return -EINVAL;
+    }
+
+    p->pim = pim;
+    p->pam = pam;
+    p->pom = pom;
+    fclose(fd);
+    g_free(fid_path);
+
+    return 0;
+}
+
+static int css_sch_get_chpid_type(uint8_t chpid, uint32_t *type,
+                                  CssDevId *dev_id)
+{
+    char *fid_path;
+    FILE *fd;
+
+    fid_path = g_strdup_printf("/sys/devices/css%x/chp0.%02x/type",
+                               dev_id->cssid, chpid);
+    fd = fopen(fid_path, "r");
+    if (fd == NULL) {
+        error_report("%s: open %s failed", __func__, fid_path);
+        g_free(fid_path);
+        return -EINVAL;
+    }
+
+    if (fscanf(fd, "%x", type) != 1) {
+        fclose(fd);
+        g_free(fid_path);
+        return -EINVAL;
+    }
+
+    fclose(fd);
+    g_free(fid_path);
+
+    return 0;
+}
+
+/*
+ * We currently retrieve the real device information from sysfs to build the
+ * guest subchannel information block without considering the migration feature.
+ * If migrate, it won't be sure to use the real device information directly,
+ * this point will be handled in the future.
+ */
+int css_sch_build_schib(SubchDev *sch, CssDevId *dev_id)
+{
+    CssImage *css = channel_subsys.css[sch->cssid];
+    PMCW *p = &sch->curr_status.pmcw;
+    SCSW *s = &sch->curr_status.scsw;
+    uint32_t type;
+    int i, ret;
+
+    /* We are dealing with I/O subchannels only. */
+    assert(css != NULL);
+    memset(p, 0, sizeof(PMCW));
+    p->flags |= PMCW_FLAGS_MASK_DNV;
+    p->devno = sch->devno;
+
+    /* Grab path mask from sysfs. */
+    ret = css_sch_get_path_masks(sch, dev_id);
+    if (ret) {
+        return ret;
+    }
+
+    /* Grab chpids from sysfs. */
+    ret = css_sch_get_chpids(sch, dev_id);
+    if (ret) {
+        return ret;
+    }
+
+   /* Build chpid type. */
+    for (i = 0; i < ARRAY_SIZE(p->chpid); i++) {
+        if (p->chpid[i] && !css->chpids[p->chpid[i]].in_use) {
+            ret = css_sch_get_chpid_type(p->chpid[i], &type, dev_id);
+            if (ret) {
+                return ret;
+            }
+            css_add_chpid(sch->cssid, p->chpid[i], type, false);
+        }
+    }
+
+    memset(s, 0, sizeof(SCSW));
+    sch->curr_status.mba = 0;
+    for (i = 0; i < ARRAY_SIZE(sch->curr_status.mda); i++) {
+        sch->curr_status.mda[i] = 0;
+    }
+
+    return 0;
+}
diff --git a/include/hw/s390x/css.h b/include/hw/s390x/css.h
index f1f0d7f..868c6c7 100644
--- a/include/hw/s390x/css.h
+++ b/include/hw/s390x/css.h
@@ -94,6 +94,24 @@ struct SubchDev {
     void *driver_data;
 };
 
+/*
+ * Identify a device within the channel subsystem.
+ * Note that this can be used to identify either the subchannel or
+ * the attached I/O device, as there's always one I/O device per
+ * subchannel.
+ */
+typedef struct CssDevId {
+    uint8_t cssid;
+    uint8_t ssid;
+    uint16_t devid;
+    bool valid;
+} CssDevId;
+
+extern PropertyInfo css_devid_propinfo;
+
+#define DEFINE_PROP_CSS_DEV_ID(_n, _s, _f) \
+    DEFINE_PROP(_n, _s, _f, css_devid_propinfo, CssDevId)
+
 typedef struct IndAddr {
     hwaddr addr;
     uint64_t map;
@@ -115,6 +133,7 @@ bool css_devno_used(uint8_t cssid, uint8_t ssid, uint16_t devno);
 void css_subch_assign(uint8_t cssid, uint8_t ssid, uint16_t schid,
                       uint16_t devno, SubchDev *sch);
 void css_sch_build_virtual_schib(SubchDev *sch, uint8_t chpid, uint8_t type);
+int css_sch_build_schib(SubchDev *sch, CssDevId *dev_id);
 uint16_t css_build_subchannel_id(SubchDev *sch);
 void css_reset(void);
 void css_reset_sch(SubchDev *sch);
@@ -162,23 +181,6 @@ int css_do_rsch(SubchDev *sch);
 int css_do_rchp(uint8_t cssid, uint8_t chpid);
 bool css_present(uint8_t cssid);
 #endif
-/*
- * Identify a device within the channel subsystem.
- * Note that this can be used to identify either the subchannel or
- * the attached I/O device, as there's always one I/O device per
- * subchannel.
- */
-typedef struct CssDevId {
-    uint8_t cssid;
-    uint8_t ssid;
-    uint16_t devid;
-    bool valid;
-} CssDevId;
-
-extern PropertyInfo css_devid_propinfo;
-
-#define DEFINE_PROP_CSS_DEV_ID(_n, _s, _f) \
-    DEFINE_PROP(_n, _s, _f, css_devid_propinfo, CssDevId)
 
 extern PropertyInfo css_devid_ro_propinfo;
 
-- 
2.10.2
