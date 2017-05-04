Received: from eggs.gnu.org ([2001:4830:134:3::10]:60062)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cornelia.huck@de.ibm.com>) id 1d6EJ1-0006rI-J6
	for qemu-devel@nongnu.org; Thu, 04 May 2017 06:48:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cornelia.huck@de.ibm.com>) id 1d6EIx-0005xo-Rw
	for qemu-devel@nongnu.org; Thu, 04 May 2017 06:48:19 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:57513
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cornelia.huck@de.ibm.com>)
	id 1d6EIx-0005vh-Lk
	for qemu-devel@nongnu.org; Thu, 04 May 2017 06:48:15 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v44AiCtj052250
	for <qemu-devel@nongnu.org>; Thu, 4 May 2017 06:48:14 -0400
Received: from e06smtp11.uk.ibm.com (e06smtp11.uk.ibm.com [195.75.94.107])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2a7w8kxs52-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 04 May 2017 06:48:14 -0400
Received: from localhost
	by e06smtp11.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <cornelia.huck@de.ibm.com>;
	Thu, 4 May 2017 11:48:13 +0100
From: Cornelia Huck <cornelia.huck@de.ibm.com>
Date: Thu,  4 May 2017 12:48:00 +0200
In-Reply-To: <20170504104806.8120-1-cornelia.huck@de.ibm.com>
References: <20170504104806.8120-1-cornelia.huck@de.ibm.com>
Message-Id: <20170504104806.8120-3-cornelia.huck@de.ibm.com>
Subject: [Qemu-devel] [PULL 2/8] s390x/css: Add an algorithm to find a free
 chpid
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: borntraeger@de.ibm.com, agraf@suse.de, qemu-devel@nongnu.org, Jing Liu <liujbjl@linux.vnet.ibm.com>, Cornelia Huck <cornelia.huck@de.ibm.com>

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
index c03bb20bc9..d94498a97b 100644
--- a/hw/s390x/css.c
+++ b/hw/s390x/css.c
@@ -1302,6 +1302,27 @@ bool css_schid_final(int m, uint8_t cssid, uint8_t ssid, uint16_t schid)
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
index f1f0d7f07a..e61fa74d9b 100644
--- a/include/hw/s390x/css.h
+++ b/include/hw/s390x/css.h
@@ -28,6 +28,7 @@
 #define MAX_CIWS 62
 
 #define VIRTUAL_CSSID 0xfe
+#define VIRTIO_CCW_CHPID 0   /* used by convention */
 
 typedef struct CIW {
     uint8_t type;
@@ -115,6 +116,7 @@ bool css_devno_used(uint8_t cssid, uint8_t ssid, uint16_t devno);
 void css_subch_assign(uint8_t cssid, uint8_t ssid, uint16_t schid,
                       uint16_t devno, SubchDev *sch);
 void css_sch_build_virtual_schib(SubchDev *sch, uint8_t chpid, uint8_t type);
+unsigned int css_find_free_chpid(uint8_t cssid);
 uint16_t css_build_subchannel_id(SubchDev *sch);
 void css_reset(void);
 void css_reset_sch(SubchDev *sch);
-- 
2.11.0
