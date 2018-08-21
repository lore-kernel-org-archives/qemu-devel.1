Received: from eggs.gnu.org ([2001:4830:134:3::10]:34069)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1fsA57-0002a8-03
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 13:04:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1fsA4o-0007C0-4D
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 13:04:31 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429]:37168)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1fsA4m-000743-QZ
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 13:04:17 -0400
Received: by mail-wr1-x429.google.com with SMTP id u12-v6so16463124wrr.4
	for <qemu-devel@nongnu.org>; Tue, 21 Aug 2018 10:04:12 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 21 Aug 2018 19:02:36 +0200
Message-Id: <1534870966-9287-65-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1534870966-9287-1-git-send-email-pbonzini@redhat.com>
References: <1534870966-9287-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 64/74] i2c: pm_smbus: Make the I2C block read
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
Cc: Corey Minyard <cminyard@mvista.com>, "Michael S. Tsirkin" <mst@redhat.com>

From: Corey Minyard <cminyard@mvista.com>

It did have write capability, but the manual says the behavior
with write enabled is undefined.  So just set an error in this
case.

Signed-off-by: Corey Minyard <cminyard@mvista.com>
Cc: Michael S. Tsirkin <mst@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Message-Id: <1534796770-10295-4-git-send-email-minyard@acm.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
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
1.8.3.1
