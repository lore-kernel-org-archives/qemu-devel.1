Received: from eggs.gnu.org ([2001:4830:134:3::10]:34040)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1fsA53-0002Vl-4b
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 13:04:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1fsA4o-0007Ci-Ci
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 13:04:27 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:38391)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1fsA4n-00077J-HN
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 13:04:18 -0400
Received: by mail-wr1-x441.google.com with SMTP id w11-v6so13897592wrc.5
	for <qemu-devel@nongnu.org>; Tue, 21 Aug 2018 10:04:15 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 21 Aug 2018 19:02:39 +0200
Message-Id: <1534870966-9287-68-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1534870966-9287-1-git-send-email-pbonzini@redhat.com>
References: <1534870966-9287-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 67/74] i2c: pm_smbus: Don't delay host status
 register busy bit when interrupts are enabled
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Corey Minyard <cminyard@mvista.com>, =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>

From: Corey Minyard <cminyard@mvista.com>

Change 880b1ffe6ec2f0ae "smbus: do not immediately complete commands"
changed pm_smbus to delay setting the host busy bit until the status
register was read, to work around a bug in AMIBIOS.  Unfortunately,
when interrupts are enabled, the status register will never get read
and the processing will never happen.

Modify the code to only delay setting the host busy bit if interrupts
are not enabled.

Signed-off-by: Corey Minyard <cminyard@mvista.com>
Cc: Hervé Poussineau <hpoussin@reactos.org>
Cc: Philippe Mathieu-Daudé <f4bug@amsat.org>
Message-Id: <1534796770-10295-8-git-send-email-minyard@acm.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/i2c/pm_smbus.c | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/hw/i2c/pm_smbus.c b/hw/i2c/pm_smbus.c
index 6322f07..91ee444 100644
--- a/hw/i2c/pm_smbus.c
+++ b/hw/i2c/pm_smbus.c
@@ -80,9 +80,6 @@ static void smb_transaction(PMSMBus *s)
     I2CBus *bus = s->smbus;
     int ret;
 
-    assert(s->smb_stat & STS_HOST_BUSY);
-    s->smb_stat &= ~STS_HOST_BUSY;
-
     SMBUS_DPRINTF("SMBus trans addr=0x%02x prot=0x%02x\n", addr, prot);
     /* Transaction isn't exec if STS_DEV_ERR bit set */
     if ((s->smb_stat & STS_DEV_ERR) != 0)  {
@@ -209,9 +206,18 @@ error:
 
 static void smb_transaction_start(PMSMBus *s)
 {
-    /* Do not execute immediately the command ; it will be
-     * executed when guest will read SMB_STAT register */
-    s->smb_stat |= STS_HOST_BUSY;
+    if (s->smb_ctl & CTL_INTREN) {
+        smb_transaction(s);
+    } else {
+        /* Do not execute immediately the command; it will be
+         * executed when guest will read SMB_STAT register.  This
+         * is to work around a bug in AMIBIOS (that is working
+         * around another bug in some specific hardware) where
+         * it waits for STS_HOST_BUSY to be set before waiting
+         * checking for status.  If STS_HOST_BUSY doesn't get
+         * set, it gets stuck. */
+        s->smb_stat |= STS_HOST_BUSY;
+    }
 }
 
 static bool
@@ -330,6 +336,7 @@ static uint64_t smb_ioport_readb(void *opaque, hwaddr addr, unsigned width)
         val = s->smb_stat;
         if (s->smb_stat & STS_HOST_BUSY) {
             /* execute command now */
+            s->smb_stat &= ~STS_HOST_BUSY;
             smb_transaction(s);
         }
         break;
-- 
1.8.3.1
