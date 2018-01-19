Received: from eggs.gnu.org ([2001:4830:134:3::10]:56965)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <tcminyard@gmail.com>) id 1ecLuW-0004oI-9P
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 20:56:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <tcminyard@gmail.com>) id 1ecLuV-0000Xd-5b
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 20:56:04 -0500
Received: from mail-pf0-x244.google.com ([2607:f8b0:400e:c00::244]:37794)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <tcminyard@gmail.com>) id 1ecLuU-0000XJ-Ut
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 20:56:03 -0500
Received: by mail-pf0-x244.google.com with SMTP id p1so202984pfh.4
	for <qemu-devel@nongnu.org>; Thu, 18 Jan 2018 17:56:02 -0800 (PST)
Sender: Corey Minyard <tcminyard@gmail.com>
From: minyard@acm.org
Date: Thu, 18 Jan 2018 19:55:41 -0600
Message-Id: <1516326941-11832-1-git-send-email-minyard@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH] Revert "smbus: do not immediately complete
 commands"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, "Michael S . Tsirkin" <mst@redhat.com>
Cc: Corey Minyard <cminyard@mvista.com>, =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>

From: Corey Minyard <cminyard@mvista.com>

This reverts commit 880b1ffe6ec2f0ae25cc4175716227ad275e8b8a.

The commit being reverted says:

    PIIX4 errata says that "immediate polling of the Host Status Register BUSY
    bit may indicate that the SMBus is NOT busy."
    Due to this, some code does the following steps:
    (a) set parameters
    (b) start command
    (c) check for smbus busy bit set (to know that command started)
    (d) check for smbus busy bit not set (to know that command finished)

    Let (c) happen, by immediately setting the busy bit, and really executing
    the command when status register has been read once.

    This fixes a problem with AMIBIOS, which can now properly initialize the
    PIIX4.

Emulating bad hardware so badly written software will work doesn't sound
like a good idea to me.  I have patches that add interrupt capability
to pm_smbus, but this change breaks that because the Linux driver
starts the transaction then waits for interrupts before reading the
status register.  That obviously won't work with these changes.

The right way to fix this in AMIBIOS is to ignore the host busy bit
and use the other bits in the host status register to tell if the
transaction has completed.  Using host busy is racy, anyway, if you
get interrupted or something while processing, you may miss step (c)
in your algorithm and fail.

Cc: Hervé Poussineau <hpoussin@reactos.org>
Cc: Philippe Mathieu-Daudé <f4bug@amsat.org>
Signed-off-by: Corey Minyard <cminyard@mvista.com>
---
 hw/i2c/pm_smbus.c | 16 +---------------
 1 file changed, 1 insertion(+), 15 deletions(-)

diff --git a/hw/i2c/pm_smbus.c b/hw/i2c/pm_smbus.c
index 0d26e0f..a044dd1 100644
--- a/hw/i2c/pm_smbus.c
+++ b/hw/i2c/pm_smbus.c
@@ -62,9 +62,6 @@ static void smb_transaction(PMSMBus *s)
     I2CBus *bus = s->smbus;
     int ret;
 
-    assert(s->smb_stat & STS_HOST_BUSY);
-    s->smb_stat &= ~STS_HOST_BUSY;
-
     SMBUS_DPRINTF("SMBus trans addr=0x%02x prot=0x%02x\n", addr, prot);
     /* Transaction isn't exec if STS_DEV_ERR bit set */
     if ((s->smb_stat & STS_DEV_ERR) != 0)  {
@@ -137,13 +134,6 @@ error:
 
 }
 
-static void smb_transaction_start(PMSMBus *s)
-{
-    /* Do not execute immediately the command ; it will be
-     * executed when guest will read SMB_STAT register */
-    s->smb_stat |= STS_HOST_BUSY;
-}
-
 static void smb_ioport_writeb(void *opaque, hwaddr addr, uint64_t val,
                               unsigned width)
 {
@@ -159,7 +149,7 @@ static void smb_ioport_writeb(void *opaque, hwaddr addr, uint64_t val,
     case SMBHSTCNT:
         s->smb_ctl = val;
         if (val & 0x40)
-            smb_transaction_start(s);
+            smb_transaction(s);
         break;
     case SMBHSTCMD:
         s->smb_cmd = val;
@@ -191,10 +181,6 @@ static uint64_t smb_ioport_readb(void *opaque, hwaddr addr, unsigned width)
     switch(addr) {
     case SMBHSTSTS:
         val = s->smb_stat;
-        if (s->smb_stat & STS_HOST_BUSY) {
-            /* execute command now */
-            smb_transaction(s);
-        }
         break;
     case SMBHSTCNT:
         s->smb_index = 0;
-- 
2.7.4
