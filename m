Received: from eggs.gnu.org ([2001:4830:134:3::10]:56302)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dn6Ep-0001JT-3Q
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 12:53:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dn6En-0004wD-3B
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 12:53:11 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43282)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1dn6Em-0004vu-QV
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 12:53:09 -0400
From: Cornelia Huck <cohuck@redhat.com>
Date: Wed, 30 Aug 2017 18:52:10 +0200
Message-Id: <20170830165252.13421-3-cohuck@redhat.com>
In-Reply-To: <20170830165252.13421-1-cohuck@redhat.com>
References: <20170830165252.13421-1-cohuck@redhat.com>
Subject: [Qemu-devel] [PULL 02/44] s390x/css: generate solicited crw for
 rchp completion signaling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org, rth@twiddle.net, agraf@suse.de, thuth@redhat.com, borntraeger@de.ibm.com, david@redhat.com, Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>, Cornelia Huck <cohuck@redhat.com>

From: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>

A successful completion of rchp should signal a solicited channel path
initialized CRW (channel report word), while the current implementation
always generates an un-solicited one. Let's fix this.

Reported-by: Halil Pasic <pasic@linux.vnet.ibm.com>
Signed-off-by: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
Reviewed-by: Halil Pasic <pasic@linux.vnet.ibm.com>
Message-Id: <20170803003527.86979-3-bjsdjshi@linux.vnet.ibm.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 hw/s390x/css.c         | 16 ++++++++++------
 include/hw/s390x/css.h |  3 ++-
 2 files changed, 12 insertions(+), 7 deletions(-)

diff --git a/hw/s390x/css.c b/hw/s390x/css.c
index 0be4eb093d..901dc6a0f3 100644
--- a/hw/s390x/css.c
+++ b/hw/s390x/css.c
@@ -1750,10 +1750,10 @@ int css_do_rchp(uint8_t cssid, uint8_t chpid)
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
@@ -2033,7 +2033,8 @@ void css_subch_assign(uint8_t cssid, uint8_t ssid, uint16_t schid,
     }
 }
 
-void css_queue_crw(uint8_t rsc, uint8_t erc, int chain, uint16_t rsid)
+void css_queue_crw(uint8_t rsc, uint8_t erc, int solicited,
+                   int chain, uint16_t rsid)
 {
     CrwContainer *crw_cont;
 
@@ -2045,6 +2046,9 @@ void css_queue_crw(uint8_t rsc, uint8_t erc, int chain, uint16_t rsid)
         return;
     }
     crw_cont->crw.flags = (rsc << 8) | erc;
+    if (solicited) {
+        crw_cont->crw.flags |= CRW_FLAGS_MASK_S;
+    }
     if (chain) {
         crw_cont->crw.flags |= CRW_FLAGS_MASK_C;
     }
@@ -2091,9 +2095,9 @@ void css_generate_sch_crws(uint8_t cssid, uint8_t ssid, uint16_t schid,
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
@@ -2108,7 +2112,7 @@ void css_generate_chp_crws(uint8_t cssid, uint8_t chpid)
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
2.13.5
