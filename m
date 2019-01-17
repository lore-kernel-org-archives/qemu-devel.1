Received: from eggs.gnu.org ([209.51.188.92]:36499)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sgarzare@redhat.com>) id 1gk3aM-0002yQ-7A
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 04:03:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sgarzare@redhat.com>) id 1gk3aI-00041F-JT
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 04:03:37 -0500
Received: from mx1.redhat.com ([209.132.183.28]:53498)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <sgarzare@redhat.com>) id 1gk3aH-0003pr-Sy
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 04:03:34 -0500
From: Stefano Garzarella <sgarzare@redhat.com>
Date: Thu, 17 Jan 2019 10:02:55 +0100
Message-Id: <20190117090259.32713-2-sgarzare@redhat.com>
In-Reply-To: <20190117090259.32713-1-sgarzare@redhat.com>
References: <20190117090259.32713-1-sgarzare@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v4 1/5] linuxboot_dma: remove duplicate
 definitions of FW_CFG
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

FW_CFG_DMA_CTL_* bits and struct fw_cfg_dma_access are
defined in the qemu_fw_cfg.h header file already included
in linuxboot_dma.c, so we can remove the definition of
BIOS_CFG_DMA_CTL_* and struct FWCfgDmaAccess.

Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Liam Merwick <liam.merwick@oracle.com>
---
 pc-bios/optionrom/linuxboot_dma.c | 20 ++++----------------
 1 file changed, 4 insertions(+), 16 deletions(-)

diff --git a/pc-bios/optionrom/linuxboot_dma.c b/pc-bios/optionrom/linuxb=
oot_dma.c
index d856d41b55..f728dc839f 100644
--- a/pc-bios/optionrom/linuxboot_dma.c
+++ b/pc-bios/optionrom/linuxboot_dma.c
@@ -58,12 +58,6 @@ asm(
 "   jmp load_kernel\n"
 );
=20
-/* QEMU_CFG_DMA_CONTROL bits */
-#define BIOS_CFG_DMA_CTL_ERROR   0x01
-#define BIOS_CFG_DMA_CTL_READ    0x02
-#define BIOS_CFG_DMA_CTL_SKIP    0x04
-#define BIOS_CFG_DMA_CTL_SELECT  0x08
-
 #define BIOS_CFG_DMA_ADDR_HIGH 0x514
 #define BIOS_CFG_DMA_ADDR_LOW  0x518
=20
@@ -75,12 +69,6 @@ asm(
=20
 #define barrier() asm("" : : : "memory")
=20
-typedef struct FWCfgDmaAccess {
-    uint32_t control;
-    uint32_t length;
-    uint64_t address;
-} __attribute__((packed)) FWCfgDmaAccess;
-
 static inline void outl(uint32_t value, uint16_t port)
 {
     asm("outl %0, %w1" : : "a"(value), "Nd"(port));
@@ -153,9 +141,9 @@ static inline uint32_t be32_to_cpu(uint32_t x)
 static __attribute__((__noinline__))
 void bios_cfg_read_entry(void *buf, uint16_t entry, uint32_t len)
 {
-    FWCfgDmaAccess access;
-    uint32_t control =3D (entry << 16) | BIOS_CFG_DMA_CTL_SELECT
-                        | BIOS_CFG_DMA_CTL_READ;
+    struct fw_cfg_dma_access access;
+    uint32_t control =3D (entry << 16) | FW_CFG_DMA_CTL_SELECT
+                        | FW_CFG_DMA_CTL_READ;
=20
     access.address =3D cpu_to_be64((uint64_t)(uint32_t)buf);
     access.length =3D cpu_to_be32(len);
@@ -165,7 +153,7 @@ void bios_cfg_read_entry(void *buf, uint16_t entry, u=
int32_t len)
=20
     outl(cpu_to_be32((uint32_t)&access), BIOS_CFG_DMA_ADDR_LOW);
=20
-    while (be32_to_cpu(access.control) & ~BIOS_CFG_DMA_CTL_ERROR) {
+    while (be32_to_cpu(access.control) & ~FW_CFG_DMA_CTL_ERROR) {
         barrier();
     }
 }
--=20
2.20.1
