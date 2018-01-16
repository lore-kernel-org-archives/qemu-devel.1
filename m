Received: from eggs.gnu.org ([2001:4830:134:3::10]:59564)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <tcminyard@gmail.com>) id 1ebFZu-0007s9-AE
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 19:58:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <tcminyard@gmail.com>) id 1ebFZs-0000lS-Bq
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 19:58:14 -0500
Received: from mail-ot0-x242.google.com ([2607:f8b0:4003:c0f::242]:36511)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <tcminyard@gmail.com>) id 1ebFZs-0000kr-7V
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 19:58:12 -0500
Received: by mail-ot0-x242.google.com with SMTP id w4so12197116otg.3
	for <qemu-devel@nongnu.org>; Mon, 15 Jan 2018 16:58:12 -0800 (PST)
Sender: Corey Minyard <tcminyard@gmail.com>
From: minyard@acm.org
Date: Mon, 15 Jan 2018 18:57:57 -0600
Message-Id: <1516064279-14816-6-git-send-email-minyard@acm.org>
In-Reply-To: <1516064279-14816-1-git-send-email-minyard@acm.org>
References: <1516064279-14816-1-git-send-email-minyard@acm.org>
Subject: [Qemu-devel] [PATCH 5/7] ipmi: Fix macro issues
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, Eric Blake <eblake@redhat.com>, Corey Minyard <cminyard@mvista.com>

From: Corey Minyard <cminyard@mvista.com>

Macro parameters should almost always have () around them when used.
llvm reported an error on this.

Remove redundant parenthesis and put parenthesis around the entire
macros with assignments in case they are used in an expression.

The macros were doing ((v) & 1) for a binary input, but that only works
if v == 0 or if v & 1.  Changed to !!(v) so they work for all values.

Remove some unused macros.

Reported in https://bugs.launchpad.net/bugs/1651167

An audit of these changes found no semantic changes; this is just
cleanups for proper style and to avoid a compiler warning.

Signed-off-by: Corey Minyard <cminyard@mvista.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 hw/ipmi/isa_ipmi_bt.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/hw/ipmi/isa_ipmi_bt.c b/hw/ipmi/isa_ipmi_bt.c
index e098fd5..e946030 100644
--- a/hw/ipmi/isa_ipmi_bt.c
+++ b/hw/ipmi/isa_ipmi_bt.c
@@ -45,21 +45,21 @@
 #define IPMI_BT_B2H_ATN_MASK       (1 << IPMI_BT_B2H_ATN_BIT)
 #define IPMI_BT_GET_B2H_ATN(d)     (((d) >> IPMI_BT_B2H_ATN_BIT) & 0x1)
 #define IPMI_BT_SET_B2H_ATN(d, v)  ((d) = (((d) & ~IPMI_BT_B2H_ATN_MASK) | \
-                                        (((v) & 1) << IPMI_BT_B2H_ATN_BIT)))
+                                        (!!(v) << IPMI_BT_B2H_ATN_BIT)))
 
 #define IPMI_BT_SMS_ATN_MASK       (1 << IPMI_BT_SMS_ATN_BIT)
 #define IPMI_BT_GET_SMS_ATN(d)     (((d) >> IPMI_BT_SMS_ATN_BIT) & 0x1)
 #define IPMI_BT_SET_SMS_ATN(d, v)  ((d) = (((d) & ~IPMI_BT_SMS_ATN_MASK) | \
-                                        (((v) & 1) << IPMI_BT_SMS_ATN_BIT)))
+                                        (!!(v) << IPMI_BT_SMS_ATN_BIT)))
 
 #define IPMI_BT_HBUSY_MASK         (1 << IPMI_BT_HBUSY_BIT)
 #define IPMI_BT_GET_HBUSY(d)       (((d) >> IPMI_BT_HBUSY_BIT) & 0x1)
 #define IPMI_BT_SET_HBUSY(d, v)    ((d) = (((d) & ~IPMI_BT_HBUSY_MASK) | \
-                                       (((v) & 1) << IPMI_BT_HBUSY_BIT)))
+                                       (!!(v) << IPMI_BT_HBUSY_BIT)))
 
 #define IPMI_BT_BBUSY_MASK         (1 << IPMI_BT_BBUSY_BIT)
 #define IPMI_BT_SET_BBUSY(d, v)    ((d) = (((d) & ~IPMI_BT_BBUSY_MASK) | \
-                                       (((v) & 1) << IPMI_BT_BBUSY_BIT)))
+                                       (!!(v) << IPMI_BT_BBUSY_BIT)))
 
 
 /* Mask register */
@@ -69,12 +69,12 @@
 #define IPMI_BT_B2H_IRQ_EN_MASK      (1 << IPMI_BT_B2H_IRQ_EN_BIT)
 #define IPMI_BT_GET_B2H_IRQ_EN(d)    (((d) >> IPMI_BT_B2H_IRQ_EN_BIT) & 0x1)
 #define IPMI_BT_SET_B2H_IRQ_EN(d, v) ((d) = (((d) & ~IPMI_BT_B2H_IRQ_EN_MASK) |\
-                                        (((v) & 1) << IPMI_BT_B2H_IRQ_EN_BIT)))
+                                        (!!(v) << IPMI_BT_B2H_IRQ_EN_BIT)))
 
 #define IPMI_BT_B2H_IRQ_MASK         (1 << IPMI_BT_B2H_IRQ_BIT)
 #define IPMI_BT_GET_B2H_IRQ(d)       (((d) >> IPMI_BT_B2H_IRQ_BIT) & 0x1)
 #define IPMI_BT_SET_B2H_IRQ(d, v)    ((d) = (((d) & ~IPMI_BT_B2H_IRQ_MASK) | \
-                                        (((v) & 1) << IPMI_BT_B2H_IRQ_BIT)))
+                                        (!!(v) << IPMI_BT_B2H_IRQ_BIT)))
 
 typedef struct IPMIBT {
     IPMIBmc *bmc;
-- 
2.7.4
