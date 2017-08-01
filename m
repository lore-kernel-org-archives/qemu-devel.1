Received: from eggs.gnu.org ([2001:4830:134:3::10]:35533)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bjsdjshi@linux.vnet.ibm.com>) id 1dcS3s-0008Kf-2K
	for qemu-devel@nongnu.org; Tue, 01 Aug 2017 03:57:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bjsdjshi@linux.vnet.ibm.com>) id 1dcS3o-0006CZ-Vo
	for qemu-devel@nongnu.org; Tue, 01 Aug 2017 03:57:52 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:45166
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bjsdjshi@linux.vnet.ibm.com>)
	id 1dcS3o-0006By-QC
	for qemu-devel@nongnu.org; Tue, 01 Aug 2017 03:57:48 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v717rhbm101350
	for <qemu-devel@nongnu.org>; Tue, 1 Aug 2017 03:57:47 -0400
Received: from e13.ny.us.ibm.com (e13.ny.us.ibm.com [129.33.205.203])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2c2ngf8fjp-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 01 Aug 2017 03:57:46 -0400
Received: from localhost
	by e13.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <bjsdjshi@linux.vnet.ibm.com>;
	Tue, 1 Aug 2017 03:57:46 -0400
From: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
Date: Tue,  1 Aug 2017 09:57:27 +0200
In-Reply-To: <20170801075727.31335-1-bjsdjshi@linux.vnet.ibm.com>
References: <20170801075727.31335-1-bjsdjshi@linux.vnet.ibm.com>
Message-Id: <20170801075727.31335-3-bjsdjshi@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH v2 2/2] s390x/css: generate solicited crw for
 rchp completion signaling
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

A successful completion of rchp should signal a solicited channel path
initialized CRW (channel report word), while the current implementation
always generates an un-solicited one. Let's fix this.

Reported-by: Halil Pasic <pasic@linux.vnet.ibm.com>
Signed-off-by: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
---
 hw/s390x/css.c         | 16 ++++++++++------
 include/hw/s390x/css.h |  3 ++-
 2 files changed, 12 insertions(+), 7 deletions(-)

diff --git a/hw/s390x/css.c b/hw/s390x/css.c
index 5321ca016b..bfa56f4b12 100644
--- a/hw/s390x/css.c
+++ b/hw/s390x/css.c
@@ -1745,10 +1745,10 @@ int css_do_rchp(uint8_t cssid, uint8_t chpid)
     }
 
     /* We don't really use a channel path, so we're done here. */
-    css_queue_crw(CRW_RSC_CHP, CRW_ERC_INIT,
+    css_queue_crw(CRW_RSC_CHP, CRW_ERC_INIT, 1,
                   channel_subsys.max_cssid > 0 ? 1 : 0, chpid);
     if (channel_subsys.max_cssid > 0) {
-        css_queue_crw(CRW_RSC_CHP, CRW_ERC_INIT, 0, real_cssid << 8);
+        css_queue_crw(CRW_RSC_CHP, CRW_ERC_INIT, 1, 0, real_cssid << 8);
     }
     return 0;
 }
@@ -2028,7 +2028,8 @@ void css_subch_assign(uint8_t cssid, uint8_t ssid, uint16_t schid,
     }
 }
 
-void css_queue_crw(uint8_t rsc, uint8_t erc, int chain, uint16_t rsid)
+void css_queue_crw(uint8_t rsc, uint8_t erc, int solicited,
+                   int chain, uint16_t rsid)
 {
     CrwContainer *crw_cont;
 
@@ -2040,6 +2041,9 @@ void css_queue_crw(uint8_t rsc, uint8_t erc, int chain, uint16_t rsid)
         return;
     }
     crw_cont->crw.flags = (rsc << 8) | erc;
+    if (solicited) {
+        crw_cont->crw.flags |= CRW_FLAGS_MASK_S;
+    }
     if (chain) {
         crw_cont->crw.flags |= CRW_FLAGS_MASK_C;
     }
@@ -2086,9 +2090,9 @@ void css_generate_sch_crws(uint8_t cssid, uint8_t ssid, uint16_t schid,
     }
     chain_crw = (channel_subsys.max_ssid > 0) ||
             (channel_subsys.max_cssid > 0);
-    css_queue_crw(CRW_RSC_SUBCH, CRW_ERC_IPI, chain_crw ? 1 : 0, schid);
+    css_queue_crw(CRW_RSC_SUBCH, CRW_ERC_IPI, 0, chain_crw ? 1 : 0, schid);
     if (chain_crw) {
-        css_queue_crw(CRW_RSC_SUBCH, CRW_ERC_IPI, 0,
+        css_queue_crw(CRW_RSC_SUBCH, CRW_ERC_IPI, 0, 0,
                       (guest_cssid << 8) | (ssid << 4));
     }
     /* RW_ERC_IPI --> clear pending interrupts */
@@ -2103,7 +2107,7 @@ void css_generate_chp_crws(uint8_t cssid, uint8_t chpid)
 void css_generate_css_crws(uint8_t cssid)
 {
     if (!channel_subsys.sei_pending) {
-        css_queue_crw(CRW_RSC_CSS, CRW_ERC_EVENT, 0, cssid);
+        css_queue_crw(CRW_RSC_CSS, CRW_ERC_EVENT, 0, 0, cssid);
     }
     channel_subsys.sei_pending = true;
 }
diff --git a/include/hw/s390x/css.h b/include/hw/s390x/css.h
index 5c5fe6b202..5b017e1fc3 100644
--- a/include/hw/s390x/css.h
+++ b/include/hw/s390x/css.h
@@ -150,7 +150,8 @@ void copy_scsw_to_guest(SCSW *dest, const SCSW *src);
 void css_inject_io_interrupt(SubchDev *sch);
 void css_reset(void);
 void css_reset_sch(SubchDev *sch);
-void css_queue_crw(uint8_t rsc, uint8_t erc, int chain, uint16_t rsid);
+void css_queue_crw(uint8_t rsc, uint8_t erc, int solicited,
+                   int chain, uint16_t rsid);
 void css_generate_sch_crws(uint8_t cssid, uint8_t ssid, uint16_t schid,
                            int hotplugged, int add);
 void css_generate_chp_crws(uint8_t cssid, uint8_t chpid);
-- 
2.11.2
