Received: from eggs.gnu.org ([2001:4830:134:3::10]:52031)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <tcminyard@gmail.com>) id 1frqll-0003Hs-Et
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 16:27:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <tcminyard@gmail.com>) id 1frqlY-0003ip-9w
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 16:27:14 -0400
Received: from mail-oi0-x232.google.com ([2607:f8b0:4003:c06::232]:34088)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <tcminyard@gmail.com>) id 1frqlM-0003Jq-Du
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 16:26:59 -0400
Received: by mail-oi0-x232.google.com with SMTP id 13-v6so28172335ois.1
	for <qemu-devel@nongnu.org>; Mon, 20 Aug 2018 13:26:56 -0700 (PDT)
Sender: Corey Minyard <tcminyard@gmail.com>
From: minyard@acm.org
Date: Mon, 20 Aug 2018 15:26:03 -0500
Message-Id: <1534796770-10295-4-git-send-email-minyard@acm.org>
In-Reply-To: <1534796770-10295-1-git-send-email-minyard@acm.org>
References: <1534796770-10295-1-git-send-email-minyard@acm.org>
Subject: [Qemu-devel] [PATCH v2 03/10] i2c:pm_smbus: Make the I2C block read
 command read-only
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Corey Minyard <cminyard@mvista.com>

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
index f1fe889..dc61f2c 100644
--- a/hw/i2c/pm_smbus.c
+++ b/hw/i2c/pm_smbus.c
@@ -55,7 +55,7 @@
 #define PROT_WORD_DATA      3
 #define PROT_PROC_CALL      4
 #define PROT_BLOCK_DATA     5
-#define PROT_I2C_BLOCK_DATA 6
+#define PROT_I2C_BLOCK_READ 6
 
 /*#define DEBUG*/
 
@@ -115,7 +115,7 @@ static void smb_transaction(PMSMBus *s)
             goto done;
         }
         break;
-    case PROT_I2C_BLOCK_DATA:
+    case PROT_I2C_BLOCK_READ:
         if (read) {
             int xfersize = s->smb_data0;
             if (xfersize > sizeof(s->smb_data)) {
@@ -125,9 +125,8 @@ static void smb_transaction(PMSMBus *s)
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
