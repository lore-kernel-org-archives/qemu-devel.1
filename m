Received: from eggs.gnu.org ([209.51.188.92]:40980)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sgarzare@redhat.com>) id 1guLSS-0004M1-Kh
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 13:10:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sgarzare@redhat.com>) id 1guLSR-0000nK-SQ
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 13:10:00 -0500
Received: from mx1.redhat.com ([209.132.183.28]:38290)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <sgarzare@redhat.com>) id 1guLSR-0000jG-MS
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 13:09:59 -0500
From: Stefano Garzarella <sgarzare@redhat.com>
Date: Thu, 14 Feb 2019 19:02:16 +0100
Message-Id: <20190214180216.246707-1-sgarzare@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH] hw/i386/pc: run the multiboot loader before
 the PVH loader
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <rth@twiddle.net>, Liam Merwick <liam.merwick@oracle.com>, Eduardo Habkost <ehabkost@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, "Michael S. Tsirkin" <mst@redhat.com>, George Kennedy <George.Kennedy@oracle.com>, Paolo Bonzini <pbonzini@redhat.com>

Some multiboot images could be in the ELF format. In the current
implementation QEMU fails because we try to load these images
as a PVH image.

In order to fix this issue, we should try multiboot first (we
already check the multiboot magic header before to load it).
If it is not a multiboot image, we can try the PVH loader.

Fixes: ab969087da6 ("pvh: Boot uncompressed kernel using direct boot ABI"=
, 2019-01-15)
Reported-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
 hw/i386/pc.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 3889eccdc3..207c267093 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -1209,6 +1209,17 @@ static void load_linux(PCMachineState *pcms,
     if (ldl_p(header+0x202) =3D=3D 0x53726448) {
         protocol =3D lduw_p(header+0x206);
     } else {
+        /*
+         * This could be a multiboot kernel. If it is, let's stop treati=
ng it
+         * like a Linux kernel.
+         * Note: some multiboot images could be in the ELF format (the s=
ame of
+         * PVH), so we try multiboot first since we check the multiboot =
magic
+         * header before to load it.
+         */
+        if (load_multiboot(fw_cfg, f, kernel_filename, initrd_filename,
+                           kernel_cmdline, kernel_size, header)) {
+            return;
+        }
         /*
          * Check if the file is an uncompressed kernel file (ELF) and lo=
ad it,
          * saving the PVH entry point used by the x86/HVM direct boot AB=
I.
@@ -1262,12 +1273,6 @@ static void load_linux(PCMachineState *pcms,
=20
             return;
         }
-        /* This looks like a multiboot kernel. If it is, let's stop
-           treating it like a Linux kernel. */
-        if (load_multiboot(fw_cfg, f, kernel_filename, initrd_filename,
-                           kernel_cmdline, kernel_size, header)) {
-            return;
-        }
         protocol =3D 0;
     }
=20
--=20
2.20.1
