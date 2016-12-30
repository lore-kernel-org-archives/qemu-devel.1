Received: from eggs.gnu.org ([2001:4830:134:3::10]:43249)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <tcminyard@gmail.com>) id 1cMz0O-0002Gn-SR
	for qemu-devel@nongnu.org; Fri, 30 Dec 2016 10:22:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <tcminyard@gmail.com>) id 1cMz0L-0000Ct-Ri
	for qemu-devel@nongnu.org; Fri, 30 Dec 2016 10:22:04 -0500
Received: from mail-pg0-x242.google.com ([2607:f8b0:400e:c05::242]:35905)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <tcminyard@gmail.com>) id 1cMz0L-0000CQ-MA
	for qemu-devel@nongnu.org; Fri, 30 Dec 2016 10:22:01 -0500
Received: by mail-pg0-x242.google.com with SMTP id n5so22380567pgh.3
	for <qemu-devel@nongnu.org>; Fri, 30 Dec 2016 07:22:00 -0800 (PST)
Sender: Corey Minyard <tcminyard@gmail.com>
From: minyard@acm.org
Date: Fri, 30 Dec 2016 09:21:36 -0600
Message-Id: <1483111310-24808-6-git-send-email-minyard@acm.org>
In-Reply-To: <1483111310-24808-1-git-send-email-minyard@acm.org>
References: <1483111310-24808-1-git-send-email-minyard@acm.org>
Subject: [Qemu-devel] [PATCH 05/19] i2c:pm_smbus: Make the I2C block read
 command read-only
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: minyard@acm.org, Corey Minyard <cminyard@mvista.com>

From: Corey Minyard <cminyard@mvista.com>

It did have write capability, but the manual says the behavior
with write enabled is undefined.  So just set an error in this
case.

Signed-off-by: Corey Minyard <cminyard@mvista.com>
---
 hw/i2c/pm_smbus.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/hw/i2c/pm_smbus.c b/hw/i2c/pm_smbus.c
index 679edbc..e7a8e92 100644
--- a/hw/i2c/pm_smbus.c
+++ b/hw/i2c/pm_smbus.c
@@ -56,7 +56,7 @@
 #define PROT_WORD_DATA      3
 #define PROT_PROC_CALL      4
 #define PROT_BLOCK_DATA     5
-#define PROT_I2C_BLOCK_DATA 6
+#define PROT_I2C_BLOCK_READ 6
 
 /*#define DEBUG*/
 
@@ -113,7 +113,7 @@ static void smb_transaction(PMSMBus *s)
             goto done;
         }
         break;
-    case PROT_I2C_BLOCK_DATA:
+    case PROT_I2C_BLOCK_READ:
         if (read) {
             int xfersize = s->smb_data0;
             if (xfersize > sizeof(s->smb_data)) {
@@ -123,9 +123,8 @@ static void smb_transaction(PMSMBus *s)
                                    xfersize, false, true);
             goto data8;
         } else {
-            ret = smbus_write_block(bus, addr, cmd, s->smb_data, s->smb_data0,
-                                    false);
-            goto done;
+            /* The manual says the behavior is undefined, just set DEV_ERR. */
+            goto error;
         }
         break;
     default:
-- 
2.7.4
