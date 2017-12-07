Received: from eggs.gnu.org ([2001:4830:134:3::10]:51302)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <tcminyard@gmail.com>) id 1eN3zz-000404-PM
	for qemu-devel@nongnu.org; Thu, 07 Dec 2017 16:46:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <tcminyard@gmail.com>) id 1eN3zw-0006JK-Lh
	for qemu-devel@nongnu.org; Thu, 07 Dec 2017 16:46:31 -0500
Received: from mail-pf0-x242.google.com ([2607:f8b0:400e:c00::242]:36362)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <tcminyard@gmail.com>) id 1eN3zw-0006Im-FJ
	for qemu-devel@nongnu.org; Thu, 07 Dec 2017 16:46:28 -0500
Received: by mail-pf0-x242.google.com with SMTP id p84so5683094pfd.3
	for <qemu-devel@nongnu.org>; Thu, 07 Dec 2017 13:46:28 -0800 (PST)
Sender: Corey Minyard <tcminyard@gmail.com>
From: minyard@acm.org
Date: Thu,  7 Dec 2017 15:46:10 -0600
Message-Id: <1512683181-8420-4-git-send-email-minyard@acm.org>
In-Reply-To: <1512683181-8420-1-git-send-email-minyard@acm.org>
References: <1512683181-8420-1-git-send-email-minyard@acm.org>
Subject: [Qemu-devel] [PATCH 03/14] i2c:pm_smbus: Make the I2C block read
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
Cc: Corey Minyard <cminyard@mvista.com>, "Michael S . Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

From: Corey Minyard <cminyard@mvista.com>

It did have write capability, but the manual says the behavior
with write enabled is undefined.  So just set an error in this
case.

Signed-off-by: Corey Minyard <cminyard@mvista.com>
Cc: Michael S. Tsirkin <mst@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
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
