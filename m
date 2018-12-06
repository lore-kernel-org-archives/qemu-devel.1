Received: from eggs.gnu.org ([2001:4830:134:3::10]:47555)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ppandit@redhat.com>) id 1gUsgX-0000y7-03
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 07:23:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ppandit@redhat.com>) id 1gUse3-0006fU-9p
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 07:20:49 -0500
Received: from mx1.redhat.com ([209.132.183.28]:56262)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ppandit@redhat.com>) id 1gUse3-0006ee-3W
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 07:20:43 -0500
From: P J P <ppandit@redhat.com>
Date: Thu,  6 Dec 2018 17:48:30 +0530
Message-Id: <20181206121830.6177-1-ppandit@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v1] i2c: pm_smbus: check smb_index before block
 transfer write
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Qemu Developers <qemu-devel@nongnu.org>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Michael Hanselmann <public@hansmi.ch>, Peter Maydell <peter.maydell@linaro.org>, Igor Mammedov <imammedo@redhat.com>, Prasad J Pandit <pjp@fedoraproject.org>

From: Prasad J Pandit <pjp@fedoraproject.org>

While performing block transfer write in smb_ioport_writeb(),
'smb_index' is incremented and used to index smb_data[] array.
Check 'smb_index' value to avoid OOB access.

Note that this bug is exploitable by a guest to escape
from the virtual machine. However the commit which
introduced the bug was only made after the 3.0 release,
and so it is not present in any released QEMU versions.

Fixes: 38ad4fae43 i2c: pm_smbus: Add block transfer capability
Reported-by: Michael Hanselmann <public@hansmi.ch>
Signed-off-by: Prasad J Pandit <pjp@fedoraproject.org>
---
 hw/i2c/pm_smbus.c | 3 +++
 1 file changed, 3 insertions(+)

Update v1: add note about issue being introduced after 3.0 release
  -> https://lists.gnu.org/archive/html/qemu-devel/2018-12/msg01115.html

diff --git a/hw/i2c/pm_smbus.c b/hw/i2c/pm_smbus.c
index 685a2378ed..03062740cc 100644
--- a/hw/i2c/pm_smbus.c
+++ b/hw/i2c/pm_smbus.c
@@ -240,6 +240,9 @@ static void smb_ioport_writeb(void *opaque, hwaddr ad=
dr, uint64_t val,
             uint8_t read =3D s->smb_addr & 0x01;
=20
             s->smb_index++;
+            if (s->smb_index >=3D PM_SMBUS_MAX_MSG_SIZE) {
+                s->smb_index =3D 0;
+            }
             if (!read && s->smb_index =3D=3D s->smb_data0) {
                 uint8_t prot =3D (s->smb_ctl >> 2) & 0x07;
                 uint8_t cmd =3D s->smb_cmd;
--=20
2.19.2
