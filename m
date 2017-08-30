Received: from eggs.gnu.org ([2001:4830:134:3::10]:56269)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dn6Ej-0001E0-AV
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 12:53:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dn6Ei-0004up-GO
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 12:53:05 -0400
Received: from mx1.redhat.com ([209.132.183.28]:64580)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1dn6Ei-0004uQ-AB
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 12:53:04 -0400
From: Cornelia Huck <cohuck@redhat.com>
Date: Wed, 30 Aug 2017 18:52:09 +0200
Message-Id: <20170830165252.13421-2-cohuck@redhat.com>
In-Reply-To: <20170830165252.13421-1-cohuck@redhat.com>
References: <20170830165252.13421-1-cohuck@redhat.com>
Subject: [Qemu-devel] [PULL 01/44] s390x/css: use macro for
 event-information pending error recover code
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

Let's use a macro for the ERC (error recover code) when generating a
Channel Subsystem Event-information pending CRW (channel report word).

While we are at it, let's also add all other ERCs.

Signed-off-by: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
Reviewed-by: Halil Pasic <pasic@linux.vnet.ibm.com>
Message-Id: <20170803003527.86979-2-bjsdjshi@linux.vnet.ibm.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 hw/s390x/css.c            |  2 +-
 include/hw/s390x/ioinst.h | 12 ++++++++++--
 2 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/hw/s390x/css.c b/hw/s390x/css.c
index 1880b1a0ff..0be4eb093d 100644
--- a/hw/s390x/css.c
+++ b/hw/s390x/css.c
@@ -2108,7 +2108,7 @@ void css_generate_chp_crws(uint8_t cssid, uint8_t chpid)
 void css_generate_css_crws(uint8_t cssid)
 {
     if (!channel_subsys.sei_pending) {
-        css_queue_crw(CRW_RSC_CSS, 0, 0, cssid);
+        css_queue_crw(CRW_RSC_CSS, CRW_ERC_EVENT, 0, cssid);
     }
     channel_subsys.sei_pending = true;
 }
diff --git a/include/hw/s390x/ioinst.h b/include/hw/s390x/ioinst.h
index 92d15655e4..5f2db6949d 100644
--- a/include/hw/s390x/ioinst.h
+++ b/include/hw/s390x/ioinst.h
@@ -201,8 +201,16 @@ typedef struct CRW {
 #define CRW_FLAGS_MASK_A 0x0080
 #define CRW_FLAGS_MASK_ERC 0x003f
 
-#define CRW_ERC_INIT 0x02
-#define CRW_ERC_IPI  0x04
+#define CRW_ERC_EVENT    0x00 /* event information pending */
+#define CRW_ERC_AVAIL    0x01 /* available */
+#define CRW_ERC_INIT     0x02 /* initialized */
+#define CRW_ERC_TERROR   0x03 /* temporary error */
+#define CRW_ERC_IPI      0x04 /* installed parm initialized */
+#define CRW_ERC_TERM     0x05 /* terminal */
+#define CRW_ERC_PERRN    0x06 /* perm. error, facility not init */
+#define CRW_ERC_PERRI    0x07 /* perm. error, facility init */
+#define CRW_ERC_PMOD     0x08 /* installed parameters modified */
+#define CRW_ERC_IPR      0x0A /* installed parameters restored */
 
 #define CRW_RSC_SUBCH 0x3
 #define CRW_RSC_CHP   0x4
-- 
2.13.5
