Received: from eggs.gnu.org ([2001:4830:134:3::10]:38633)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <hpoussin@reactos.org>) id 1cfum4-0008DJ-PJ
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 15:41:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <hpoussin@reactos.org>) id 1cfum4-0007sv-4C
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 15:41:32 -0500
From: =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>
Date: Mon, 20 Feb 2017 21:41:19 +0100
Message-Id: <1487623279-29930-1-git-send-email-hpoussin@reactos.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2] vl: disable default cdrom when using
 explicitely scsi-hd
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>, Markus Armbruster <armbru@redhat.com>, John Snow <jsnow@redhat.com>, qemu-block@nongnu.org, =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>

In commit af6bf1328ef90fae617857c02697e0174b84d596 (May 2011),
ide-hd, ide-cd and scsi-cd have been added to disable default cdrom,
"or else you can't put one on secondary master without -nodefaults".

Make it the same for scsi-hd, so you can put one on scsi-id 2 without
using -nodefaults.
scsi-hd has probably been forgotten, as it has been added in the
preceding commit (b443ae67130d32ad06b06fc9aa6d04d05ccd93ce).

Affected users are the ones using a machine with SCSI devices and start Q=
EMU
with -device scsi-hd but without -device scsi-cd or -cdrom
In that case, the default cdrom device will disappear instead of being em=
pty.

Signed-off-by: Herv=C3=A9 Poussineau <hpoussin@reactos.org>
---
 vl.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/vl.c b/vl.c
index 27d9829..4af95b3 100644
--- a/vl.c
+++ b/vl.c
@@ -226,6 +226,7 @@ static struct {
     { .driver =3D "ide-hd",               .flag =3D &default_cdrom     }=
,
     { .driver =3D "ide-drive",            .flag =3D &default_cdrom     }=
,
     { .driver =3D "scsi-cd",              .flag =3D &default_cdrom     }=
,
+    { .driver =3D "scsi-hd",              .flag =3D &default_cdrom     }=
,
     { .driver =3D "virtio-serial-pci",    .flag =3D &default_virtcon   }=
,
     { .driver =3D "virtio-serial",        .flag =3D &default_virtcon   }=
,
     { .driver =3D "VGA",                  .flag =3D &default_vga       }=
,
--=20
2.1.4
