Received: from eggs.gnu.org ([2001:4830:134:3::10]:47658)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1eS1sZ-0001Fn-Jz
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 09:31:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1eS1sY-0007Sq-Gn
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 09:31:23 -0500
Received: from mx1.redhat.com ([209.132.183.28]:37448)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1eS1sY-0007SR-9z
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 09:31:22 -0500
Date: Thu, 21 Dec 2017 16:31:18 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <1513866427-27125-26-git-send-email-mst@redhat.com>
References: <1513866427-27125-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1513866427-27125-1-git-send-email-mst@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 25/25] smbus: do not immediately complete
 commands
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, =?utf-8?B?SGVydsOp?= Poussineau <hpoussin@reactos.org>, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, Paolo Bonzini <pbonzini@redhat.com>

From: Herv=C3=A9 Poussineau <hpoussin@reactos.org>

PIIX4 errata says that "immediate polling of the Host Status Register BUS=
Y
bit may indicate that the SMBus is NOT busy."
Due to this, some code does the following steps:
(a) set parameters
(b) start command
(c) check for smbus busy bit set (to know that command started)
(d) check for smbus busy bit not set (to know that command finished)

Let (c) happen, by immediately setting the busy bit, and really executing
the command when status register has been read once.

This fixes a problem with AMIBIOS, which can now properly initialize the =
PIIX4.

Signed-off-by: Herv=C3=A9 Poussineau <hpoussin@reactos.org>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
---
 hw/i2c/pm_smbus.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/hw/i2c/pm_smbus.c b/hw/i2c/pm_smbus.c
index 6fc3923..ec060d5 100644
--- a/hw/i2c/pm_smbus.c
+++ b/hw/i2c/pm_smbus.c
@@ -63,6 +63,9 @@ static void smb_transaction(PMSMBus *s)
     I2CBus *bus =3D s->smbus;
     int ret;
=20
+    assert(s->smb_stat & STS_HOST_BUSY);
+    s->smb_stat &=3D ~STS_HOST_BUSY;
+
     SMBUS_DPRINTF("SMBus trans addr=3D0x%02x prot=3D0x%02x\n", addr, pro=
t);
     /* Transaction isn't exec if STS_DEV_ERR bit set */
     if ((s->smb_stat & STS_DEV_ERR) !=3D 0)  {
@@ -135,6 +138,13 @@ error:
=20
 }
=20
+static void smb_transaction_start(PMSMBus *s)
+{
+    /* Do not execute immediately the command ; it will be
+     * executed when guest will read SMB_STAT register */
+    s->smb_stat |=3D STS_HOST_BUSY;
+}
+
 static void smb_ioport_writeb(void *opaque, hwaddr addr, uint64_t val,
                               unsigned width)
 {
@@ -150,7 +160,7 @@ static void smb_ioport_writeb(void *opaque, hwaddr ad=
dr, uint64_t val,
     case SMBHSTCNT:
         s->smb_ctl =3D val;
         if (val & 0x40)
-            smb_transaction(s);
+            smb_transaction_start(s);
         break;
     case SMBHSTCMD:
         s->smb_cmd =3D val;
@@ -182,6 +192,10 @@ static uint64_t smb_ioport_readb(void *opaque, hwadd=
r addr, unsigned width)
     switch(addr) {
     case SMBHSTSTS:
         val =3D s->smb_stat;
+        if (s->smb_stat & STS_HOST_BUSY) {
+            /* execute command now */
+            smb_transaction(s);
+        }
         break;
     case SMBHSTCNT:
         s->smb_index =3D 0;
--=20
MST
