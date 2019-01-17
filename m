Received: from eggs.gnu.org ([209.51.188.92]:36678)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sgarzare@redhat.com>) id 1gk3ad-0003F1-Ii
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 04:03:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sgarzare@redhat.com>) id 1gk3ab-0004NA-Ga
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 04:03:55 -0500
Received: from mx1.redhat.com ([209.132.183.28]:60290)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <sgarzare@redhat.com>) id 1gk3ab-0004MO-0v
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 04:03:53 -0500
From: Stefano Garzarella <sgarzare@redhat.com>
Date: Thu, 17 Jan 2019 10:02:58 +0100
Message-Id: <20190117090259.32713-5-sgarzare@redhat.com>
In-Reply-To: <20190117090259.32713-1-sgarzare@redhat.com>
References: <20190117090259.32713-1-sgarzare@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v4 4/5] hw/i386/pc: use PVH option rom
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Maran Wilson <maran.wilson@oracle.com>, Eduardo Habkost <ehabkost@redhat.com>, Eric Blake <eblake@redhat.com>, Richard Henderson <rth@twiddle.net>, George Kennedy <george.kennedy@oracle.com>, Stefan Hajnoczi <stefanha@redhat.com>, Liam Merwick <liam.merwick@oracle.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Boris Ostrovsky <boris.ostrovsky@oracle.com>

Use pvh.bin option rom when we are booting an uncompressed
kernel using the x86/HVM direct boot ABI.

Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Liam Merwick <liam.merwick@oracle.com>
---
 hw/i386/pc.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 9ed5063de8..2833b130ba 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -1252,6 +1252,10 @@ static void load_linux(PCMachineState *pcms,
                                  initrd_size);
             }
=20
+            option_rom[nb_option_roms].bootindex =3D 0;
+            option_rom[nb_option_roms].name =3D "pvh.bin";
+            nb_option_roms++;
+
             return;
         }
         /* This looks like a multiboot kernel. If it is, let's stop
@@ -1703,6 +1707,7 @@ void xen_load_linux(PCMachineState *pcms)
     for (i =3D 0; i < nb_option_roms; i++) {
         assert(!strcmp(option_rom[i].name, "linuxboot.bin") ||
                !strcmp(option_rom[i].name, "linuxboot_dma.bin") ||
+               !strcmp(option_rom[i].name, "pvh.bin") ||
                !strcmp(option_rom[i].name, "multiboot.bin"));
         rom_add_option(option_rom[i].name, option_rom[i].bootindex);
     }
--=20
2.20.1
