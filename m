Received: from eggs.gnu.org ([2001:4830:134:3::10]:51098)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <tcminyard@gmail.com>) id 1cKQV9-0006c3-Nh
	for qemu-devel@nongnu.org; Fri, 23 Dec 2016 09:07:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <tcminyard@gmail.com>) id 1cKQV8-0001qj-DF
	for qemu-devel@nongnu.org; Fri, 23 Dec 2016 09:07:15 -0500
Received: from mail-pf0-x242.google.com ([2607:f8b0:400e:c00::242]:35803)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <tcminyard@gmail.com>) id 1cKQV8-0001qY-8d
	for qemu-devel@nongnu.org; Fri, 23 Dec 2016 09:07:14 -0500
Received: by mail-pf0-x242.google.com with SMTP id i88so13995345pfk.2
	for <qemu-devel@nongnu.org>; Fri, 23 Dec 2016 06:07:14 -0800 (PST)
Sender: Corey Minyard <tcminyard@gmail.com>
From: minyard@acm.org
Date: Fri, 23 Dec 2016 08:07:07 -0600
Message-Id: <1482502027-5544-1-git-send-email-minyard@acm.org>
In-Reply-To: <20161219154752.14563.46483.malonedeb@wampee.canonical.com>
References: <20161219154752.14563.46483.malonedeb@wampee.canonical.com>
Subject: [Qemu-devel] [PATCH v3] ipmi: Fix macro issues
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Bug 1651167 <1651167@bugs.launchpad.net>, qemu-devel@nongnu.org, Eric Blake <eblake@redhat.com>
Cc: Corey Minyard <cminyard@mvista.com>

From: Corey Minyard <cminyard@mvista.com>

Macro parameters should almost always have () around them when used.
llvm reported an error on this.

Remove redundant parenthesis and put parenthesis around the entire
macros with assignments in case they are used in an expression.

Remove some unused macros.

Reported in https://bugs.launchpad.net/bugs/1651167

Signed-off-by: Corey Minyard <cminyard@mvista.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 hw/ipmi/isa_ipmi_bt.c | 34 ++++++++++++----------------------
 1 file changed, 12 insertions(+), 22 deletions(-)

Changed in v3:
  * Add Eric's reviewed-by.  Thanks!

Changes in v2:
  * Put parenthesis around macros that had assignment in them.
  * Removed some redundant parenthesis.
  * Removed some macros that were not used.

diff --git a/hw/ipmi/isa_ipmi_bt.c b/hw/ipmi/isa_ipmi_bt.c
index f036617..68bf5cd 100644
--- a/hw/ipmi/isa_ipmi_bt.c
+++ b/hw/ipmi/isa_ipmi_bt.c
@@ -37,40 +37,30 @@
 #define IPMI_BT_HBUSY_BIT          6
 #define IPMI_BT_BBUSY_BIT          7
 
-#define IPMI_BT_CLR_WR_MASK        (1 << IPMI_BT_CLR_WR_BIT)
 #define IPMI_BT_GET_CLR_WR(d)      (((d) >> IPMI_BT_CLR_WR_BIT) & 0x1)
-#define IPMI_BT_SET_CLR_WR(d, v)   (d) = (((d) & ~IPMI_BT_CLR_WR_MASK) | \
-                                       (((v & 1) << IPMI_BT_CLR_WR_BIT)))
 
-#define IPMI_BT_CLR_RD_MASK        (1 << IPMI_BT_CLR_RD_BIT)
 #define IPMI_BT_GET_CLR_RD(d)      (((d) >> IPMI_BT_CLR_RD_BIT) & 0x1)
-#define IPMI_BT_SET_CLR_RD(d, v)   (d) = (((d) & ~IPMI_BT_CLR_RD_MASK) | \
-                                       (((v & 1) << IPMI_BT_CLR_RD_BIT)))
 
-#define IPMI_BT_H2B_ATN_MASK       (1 << IPMI_BT_H2B_ATN_BIT)
 #define IPMI_BT_GET_H2B_ATN(d)     (((d) >> IPMI_BT_H2B_ATN_BIT) & 0x1)
-#define IPMI_BT_SET_H2B_ATN(d, v)  (d) = (((d) & ~IPMI_BT_H2B_ATN_MASK) | \
-                                        (((v & 1) << IPMI_BT_H2B_ATN_BIT)))
 
 #define IPMI_BT_B2H_ATN_MASK       (1 << IPMI_BT_B2H_ATN_BIT)
 #define IPMI_BT_GET_B2H_ATN(d)     (((d) >> IPMI_BT_B2H_ATN_BIT) & 0x1)
-#define IPMI_BT_SET_B2H_ATN(d, v)  (d) = (((d) & ~IPMI_BT_B2H_ATN_MASK) | \
-                                        (((v & 1) << IPMI_BT_B2H_ATN_BIT)))
+#define IPMI_BT_SET_B2H_ATN(d, v)  ((d) = (((d) & ~IPMI_BT_B2H_ATN_MASK) | \
+                                        (((v) & 1) << IPMI_BT_B2H_ATN_BIT)))
 
 #define IPMI_BT_SMS_ATN_MASK       (1 << IPMI_BT_SMS_ATN_BIT)
 #define IPMI_BT_GET_SMS_ATN(d)     (((d) >> IPMI_BT_SMS_ATN_BIT) & 0x1)
-#define IPMI_BT_SET_SMS_ATN(d, v)  (d) = (((d) & ~IPMI_BT_SMS_ATN_MASK) | \
-                                        (((v & 1) << IPMI_BT_SMS_ATN_BIT)))
+#define IPMI_BT_SET_SMS_ATN(d, v)  ((d) = (((d) & ~IPMI_BT_SMS_ATN_MASK) | \
+                                        (((v) & 1) << IPMI_BT_SMS_ATN_BIT)))
 
 #define IPMI_BT_HBUSY_MASK         (1 << IPMI_BT_HBUSY_BIT)
 #define IPMI_BT_GET_HBUSY(d)       (((d) >> IPMI_BT_HBUSY_BIT) & 0x1)
-#define IPMI_BT_SET_HBUSY(d, v)    (d) = (((d) & ~IPMI_BT_HBUSY_MASK) | \
-                                       (((v & 1) << IPMI_BT_HBUSY_BIT)))
+#define IPMI_BT_SET_HBUSY(d, v)    ((d) = (((d) & ~IPMI_BT_HBUSY_MASK) | \
+                                       (((v) & 1) << IPMI_BT_HBUSY_BIT)))
 
 #define IPMI_BT_BBUSY_MASK         (1 << IPMI_BT_BBUSY_BIT)
-#define IPMI_BT_GET_BBUSY(d)       (((d) >> IPMI_BT_BBUSY_BIT) & 0x1)
-#define IPMI_BT_SET_BBUSY(d, v)    (d) = (((d) & ~IPMI_BT_BBUSY_MASK) | \
-                                       (((v & 1) << IPMI_BT_BBUSY_BIT)))
+#define IPMI_BT_SET_BBUSY(d, v)    ((d) = (((d) & ~IPMI_BT_BBUSY_MASK) | \
+                                       (((v) & 1) << IPMI_BT_BBUSY_BIT)))
 
 
 /* Mask register */
@@ -79,13 +69,13 @@
 
 #define IPMI_BT_B2H_IRQ_EN_MASK      (1 << IPMI_BT_B2H_IRQ_EN_BIT)
 #define IPMI_BT_GET_B2H_IRQ_EN(d)    (((d) >> IPMI_BT_B2H_IRQ_EN_BIT) & 0x1)
-#define IPMI_BT_SET_B2H_IRQ_EN(d, v) (d) = (((d) & ~IPMI_BT_B2H_IRQ_EN_MASK) | \
-                                        (((v & 1) << IPMI_BT_B2H_IRQ_EN_BIT)))
+#define IPMI_BT_SET_B2H_IRQ_EN(d, v) ((d) = (((d) & ~IPMI_BT_B2H_IRQ_EN_MASK) |\
+                                        (((v) & 1) << IPMI_BT_B2H_IRQ_EN_BIT)))
 
 #define IPMI_BT_B2H_IRQ_MASK         (1 << IPMI_BT_B2H_IRQ_BIT)
 #define IPMI_BT_GET_B2H_IRQ(d)       (((d) >> IPMI_BT_B2H_IRQ_BIT) & 0x1)
-#define IPMI_BT_SET_B2H_IRQ(d, v)    (d) = (((d) & ~IPMI_BT_B2H_IRQ_MASK) | \
-                                        (((v & 1) << IPMI_BT_B2H_IRQ_BIT)))
+#define IPMI_BT_SET_B2H_IRQ(d, v)    ((d) = (((d) & ~IPMI_BT_B2H_IRQ_MASK) | \
+                                        (((v) & 1) << IPMI_BT_B2H_IRQ_BIT)))
 
 typedef struct IPMIBT {
     IPMIBmc *bmc;
-- 
2.7.4
