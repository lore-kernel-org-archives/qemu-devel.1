Received: from eggs.gnu.org ([2001:4830:134:3::10]:35791)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cornelia.huck@de.ibm.com>) id 1cgVpi-0006eb-MP
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 07:15:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cornelia.huck@de.ibm.com>) id 1cgVpf-0003i2-Fi
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 07:15:46 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:55958)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cornelia.huck@de.ibm.com>)
	id 1cgVpf-0003hv-15
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 07:15:43 -0500
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v1MC9mwW014980
	for <qemu-devel@nongnu.org>; Wed, 22 Feb 2017 07:15:41 -0500
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
	by mx0a-001b2d01.pphosted.com with ESMTP id 28ruy0gcm6-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 22 Feb 2017 07:15:41 -0500
Received: from localhost
	by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <cornelia.huck@de.ibm.com>;
	Wed, 22 Feb 2017 12:15:38 -0000
From: Cornelia Huck <cornelia.huck@de.ibm.com>
Date: Wed, 22 Feb 2017 13:15:21 +0100
In-Reply-To: <20170222121527.7009-1-cornelia.huck@de.ibm.com>
References: <20170222121527.7009-1-cornelia.huck@de.ibm.com>
Message-Id: <20170222121527.7009-3-cornelia.huck@de.ibm.com>
Subject: [Qemu-devel] [PATCH 2/8] s390x/css: Add an algorithm to find a free
 chpid
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: borntraeger@de.ibm.com, agraf@suse.de, jfrei@linux.vnet.ibm.com, pbonzini@redhat.com, marcandre.lureau@redhat.com, Jing Liu <liujbjl@linux.vnet.ibm.com>, Cornelia Huck <cornelia.huck@de.ibm.com>

From: Jing Liu <liujbjl@linux.vnet.ibm.com>

This introduces a function named css_find_free_chpid() to find a
free channel path. Because virtio-ccw device used zero as its
channel path number, it would be sensible to skip the reserved one
and search upwards.

Signed-off-by: Jing Liu <liujbjl@linux.vnet.ibm.com>
Reviewed-by: QingFeng Hao <haoqf@linux.vnet.ibm.com>
Reviewed-by: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
---
 hw/s390x/css.c         | 21 +++++++++++++++++++++
 include/hw/s390x/css.h |  2 ++
 2 files changed, 23 insertions(+)

diff --git a/hw/s390x/css.c b/hw/s390x/css.c
index 0f2580d644..ecafaab096 100644
--- a/hw/s390x/css.c
+++ b/hw/s390x/css.c
@@ -1278,6 +1278,27 @@ bool css_schid_final(int m, uint8_t cssid, uint8_t ssid, uint16_t schid)
                                  (MAX_SCHID + 1) / sizeof(unsigned long));
 }
 
+unsigned int css_find_free_chpid(uint8_t cssid)
+{
+    CssImage *css = channel_subsys.css[cssid];
+    unsigned int chpid;
+
+    if (!css) {
+        return MAX_CHPID + 1;
+    }
+
+    for (chpid = 0; chpid <= MAX_CHPID; chpid++) {
+        /* skip reserved chpid */
+        if (chpid == VIRTIO_CCW_CHPID) {
+            continue;
+        }
+        if (!css->chpids[chpid].in_use) {
+            return chpid;
+        }
+    }
+    return MAX_CHPID + 1;
+}
+
 static int css_add_virtual_chpid(uint8_t cssid, uint8_t chpid, uint8_t type)
 {
     CssImage *css;
diff --git a/include/hw/s390x/css.h b/include/hw/s390x/css.h
index c96c862057..43b9d466fa 100644
--- a/include/hw/s390x/css.h
+++ b/include/hw/s390x/css.h
@@ -26,6 +26,7 @@
 #define MAX_CIWS 62
 
 #define VIRTUAL_CSSID 0xfe
+#define VIRTIO_CCW_CHPID 0   /* used by convention */
 
 typedef struct CIW {
     uint8_t type;
@@ -113,6 +114,7 @@ bool css_devno_used(uint8_t cssid, uint8_t ssid, uint16_t devno);
 void css_subch_assign(uint8_t cssid, uint8_t ssid, uint16_t schid,
                       uint16_t devno, SubchDev *sch);
 void css_sch_build_virtual_schib(SubchDev *sch, uint8_t chpid, uint8_t type);
+unsigned int css_find_free_chpid(uint8_t cssid);
 uint16_t css_build_subchannel_id(SubchDev *sch);
 void css_reset(void);
 void css_reset_sch(SubchDev *sch);
-- 
2.11.0
