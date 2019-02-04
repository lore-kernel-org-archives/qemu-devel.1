Received: from eggs.gnu.org ([209.51.188.92]:59251)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gqj6r-00051y-0e
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 13:36:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gqj6p-0003TB-On
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 13:36:44 -0500
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336]:34976)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1gqj6n-0003QU-PW
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 13:36:43 -0500
Received: by mail-wm1-x336.google.com with SMTP id t200so1041427wmt.0
	for <qemu-devel@nongnu.org>; Mon, 04 Feb 2019 10:36:39 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon,  4 Feb 2019 19:35:19 +0100
Message-Id: <1549305379-51117-18-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1549305379-51117-1-git-send-email-pbonzini@redhat.com>
References: <1549305379-51117-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 17/77] linuxboot_dma: remove duplicate
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
Cc: Stefano Garzarella <sgarzare@redhat.com>

From: Stefano Garzarella <sgarzare@redhat.com>

FW_CFG_DMA_CTL_* bits and struct fw_cfg_dma_access are
defined in the qemu_fw_cfg.h header file already included
in linuxboot_dma.c, so we can remove the definition of
BIOS_CFG_DMA_CTL_* and struct FWCfgDmaAccess.

Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Liam Merwick <liam.merwick@oracle.com>
Based-on: <1547554687-12687-1-git-send-email-liam.merwick@oracle.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 pc-bios/optionrom/linuxboot_dma.c | 20 ++++----------------
 1 file changed, 4 insertions(+), 16 deletions(-)

diff --git a/pc-bios/optionrom/linuxboot_dma.c b/pc-bios/optionrom/linuxboot_dma.c
index d856d41..f728dc8 100644
--- a/pc-bios/optionrom/linuxboot_dma.c
+++ b/pc-bios/optionrom/linuxboot_dma.c
@@ -58,12 +58,6 @@ asm(
 "   jmp load_kernel\n"
 );
 
-/* QEMU_CFG_DMA_CONTROL bits */
-#define BIOS_CFG_DMA_CTL_ERROR   0x01
-#define BIOS_CFG_DMA_CTL_READ    0x02
-#define BIOS_CFG_DMA_CTL_SKIP    0x04
-#define BIOS_CFG_DMA_CTL_SELECT  0x08
-
 #define BIOS_CFG_DMA_ADDR_HIGH 0x514
 #define BIOS_CFG_DMA_ADDR_LOW  0x518
 
@@ -75,12 +69,6 @@ asm(
 
 #define barrier() asm("" : : : "memory")
 
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
-    uint32_t control = (entry << 16) | BIOS_CFG_DMA_CTL_SELECT
-                        | BIOS_CFG_DMA_CTL_READ;
+    struct fw_cfg_dma_access access;
+    uint32_t control = (entry << 16) | FW_CFG_DMA_CTL_SELECT
+                        | FW_CFG_DMA_CTL_READ;
 
     access.address = cpu_to_be64((uint64_t)(uint32_t)buf);
     access.length = cpu_to_be32(len);
@@ -165,7 +153,7 @@ void bios_cfg_read_entry(void *buf, uint16_t entry, uint32_t len)
 
     outl(cpu_to_be32((uint32_t)&access), BIOS_CFG_DMA_ADDR_LOW);
 
-    while (be32_to_cpu(access.control) & ~BIOS_CFG_DMA_CTL_ERROR) {
+    while (be32_to_cpu(access.control) & ~FW_CFG_DMA_CTL_ERROR) {
         barrier();
     }
 }
-- 
1.8.3.1
