Received: from eggs.gnu.org ([2001:4830:134:3::10]:37869)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bjsdjshi@linux.vnet.ibm.com>) id 1dd473-0005hA-Pg
	for qemu-devel@nongnu.org; Wed, 02 Aug 2017 20:35:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bjsdjshi@linux.vnet.ibm.com>) id 1dd46z-0005KC-NO
	for qemu-devel@nongnu.org; Wed, 02 Aug 2017 20:35:41 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:43313)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bjsdjshi@linux.vnet.ibm.com>)
	id 1dd46z-0005JJ-De
	for qemu-devel@nongnu.org; Wed, 02 Aug 2017 20:35:37 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v730YtVE002529
	for <qemu-devel@nongnu.org>; Wed, 2 Aug 2017 20:35:35 -0400
Received: from e16.ny.us.ibm.com (e16.ny.us.ibm.com [129.33.205.206])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2c3mbr4qjg-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 02 Aug 2017 20:35:35 -0400
Received: from localhost
	by e16.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <bjsdjshi@linux.vnet.ibm.com>;
	Wed, 2 Aug 2017 20:35:34 -0400
From: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
Date: Thu,  3 Aug 2017 02:35:26 +0200
In-Reply-To: <20170803003527.86979-1-bjsdjshi@linux.vnet.ibm.com>
References: <20170803003527.86979-1-bjsdjshi@linux.vnet.ibm.com>
Message-Id: <20170803003527.86979-2-bjsdjshi@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH v3 1/2] s390x/css: use macro for
 event-information pending error recover code
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

Let's use a macro for the ERC (error recover code) when generating a
Channel Subsystem Event-information pending CRW (channel report word).

While we are at it, let's also add all other ERCs.

Signed-off-by: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
Reviewed-by: Halil Pasic <pasic@linux.vnet.ibm.com>
---
 hw/s390x/css.c            |  2 +-
 include/hw/s390x/ioinst.h | 12 ++++++++++--
 2 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/hw/s390x/css.c b/hw/s390x/css.c
index 6a42b95cee..5321ca016b 100644
--- a/hw/s390x/css.c
+++ b/hw/s390x/css.c
@@ -2103,7 +2103,7 @@ void css_generate_chp_crws(uint8_t cssid, uint8_t chpid)
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
2.11.2
