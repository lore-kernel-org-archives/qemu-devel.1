Received: from eggs.gnu.org ([2001:4830:134:3::10]:47965)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fRLUJ-0002Un-8S
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 13:47:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fRLUG-0001dm-Uc
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 13:47:47 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:49390 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jsnow@redhat.com>) id 1fRLUG-0001cx-K6
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 13:47:44 -0400
From: John Snow <jsnow@redhat.com>
Date: Fri,  8 Jun 2018 13:47:27 -0400
Message-Id: <20180608174733.4936-25-jsnow@redhat.com>
In-Reply-To: <20180608174733.4936-1-jsnow@redhat.com>
References: <20180608174733.4936-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 24/30] libqos/ahci: track sector size
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: jsnow@redhat.com, peter.maydell@linaro.org

It's not always 512, and it does wind up mattering for PIO tranfers,
because this means DRQ blocks are four times as big for ATAPI.
Replace an instance of 2048 with the correct define, too.

This patch by itself winds changing no behavior. fis->count is ignored
for CMD_PACKET, and sect_count only gets used in non-ATAPI cases.

Signed-off-by: John Snow <jsnow@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Message-id: 20180606190955.20845-2-jsnow@redhat.com
Signed-off-by: John Snow <jsnow@redhat.com>
---
 tests/libqos/ahci.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/tests/libqos/ahci.c b/tests/libqos/ahci.c
index bc201d762b..63e1f9b92d 100644
--- a/tests/libqos/ahci.c
+++ b/tests/libqos/ahci.c
@@ -90,6 +90,7 @@ struct AHCICommand {
     uint32_t interrupts;
     uint64_t xbytes;
     uint32_t prd_size;
+    uint32_t sector_size;
     uint64_t buffer;
     AHCICommandProp *props;
     /* Data to be transferred to the guest */
@@ -796,7 +797,7 @@ static void command_header_init(AHCICommand *cmd)
 static void command_table_init(AHCICommand *cmd)
 {
     RegH2DFIS *fis =3D &(cmd->fis);
-    uint16_t sect_count =3D (cmd->xbytes / AHCI_SECTOR_SIZE);
+    uint16_t sect_count =3D (cmd->xbytes / cmd->sector_size);
=20
     fis->fis_type =3D REG_H2D_FIS;
     fis->flags =3D REG_H2D_FIS_CMD; /* "Command" bit */
@@ -819,7 +820,7 @@ static void command_table_init(AHCICommand *cmd)
         if (cmd->props->lba28 || cmd->props->lba48) {
             fis->device =3D ATA_DEVICE_LBA;
         }
-        fis->count =3D (cmd->xbytes / AHCI_SECTOR_SIZE);
+        fis->count =3D (cmd->xbytes / cmd->sector_size);
     }
     fis->icc =3D 0x00;
     fis->control =3D 0x00;
@@ -857,6 +858,7 @@ AHCICommand *ahci_command_create(uint8_t command_name=
)
     cmd->xbytes =3D props->size;
     cmd->prd_size =3D 4096;
     cmd->buffer =3D 0xabad1dea;
+    cmd->sector_size =3D props->atapi ? ATAPI_SECTOR_SIZE : AHCI_SECTOR_=
SIZE;
=20
     if (!cmd->props->ncq) {
         cmd->interrupts =3D AHCI_PX_IS_DHRS;
@@ -1033,7 +1035,7 @@ void ahci_command_set_buffer(AHCICommand *cmd, uint=
64_t buffer)
 static void ahci_atapi_set_size(AHCICommand *cmd, uint64_t xbytes)
 {
     unsigned char *cbd =3D cmd->atapi_cmd;
-    uint64_t nsectors =3D xbytes / 2048;
+    uint64_t nsectors =3D xbytes / ATAPI_SECTOR_SIZE;
     uint32_t tmp;
     g_assert(cbd);
=20
@@ -1080,7 +1082,7 @@ void ahci_command_set_sizes(AHCICommand *cmd, uint6=
4_t xbytes,
         cmd->prd_size =3D prd_size;
     }
     cmd->xbytes =3D xbytes;
-    sect_count =3D (cmd->xbytes / AHCI_SECTOR_SIZE);
+    sect_count =3D (cmd->xbytes / cmd->sector_size);
=20
     if (cmd->props->ncq) {
         NCQFIS *nfis =3D (NCQFIS *)&(cmd->fis);
--=20
2.14.3
