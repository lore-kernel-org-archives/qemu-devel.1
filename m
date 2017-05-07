Received: from eggs.gnu.org ([2001:4830:134:3::10]:54389)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1d7GKy-0006er-Pl
	for qemu-devel@nongnu.org; Sun, 07 May 2017 03:10:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1d7GKv-0000iA-SB
	for qemu-devel@nongnu.org; Sun, 07 May 2017 03:10:36 -0400
From: Michael Tokarev <mjt@tls.msk.ru>
Date: Sun,  7 May 2017 10:02:18 +0300
Message-Id: <cdc68b9a77e0296e2491b893763779cf2fe7a7c5.1494140528.git.mjt@msgid.tls.msk.ru>
In-Reply-To: <cover.1494140527.git.mjt@msgid.tls.msk.ru>
References: <cover.1494140527.git.mjt@msgid.tls.msk.ru>
In-Reply-To: <cover.1494140527.git.mjt@msgid.tls.msk.ru>
References: <cover.1494140527.git.mjt@msgid.tls.msk.ru>
Subject: [Qemu-devel] [PULL 15/23] hw/core/generic-loader: Fix crash when
 running without CPU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, qemu-trivial@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>

From: Thomas Huth <thuth@redhat.com>

When running QEMU with "-M none -device loader,file=kernel.elf", it
currently crashes with a segmentation fault, because the "none"-machine
does not have any CPU by default and the generic loader code tries
to dereference s->cpu. Fix it by adding an appropriate check for a
NULL pointer.

Reported-by: Laurent Vivier <laurent@vivier.eu>
Signed-off-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Reviewed-by: Alistair Francis <alistair.francis@xilinx.com>
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
---
 hw/core/generic-loader.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/hw/core/generic-loader.c b/hw/core/generic-loader.c
index 58f1f02902..46012673c3 100644
--- a/hw/core/generic-loader.c
+++ b/hw/core/generic-loader.c
@@ -137,20 +137,21 @@ static void generic_loader_realize(DeviceState *dev, Error **errp)
 #endif
 
     if (s->file) {
+        AddressSpace *as = s->cpu ? s->cpu->as :  NULL;
+
         if (!s->force_raw) {
             size = load_elf_as(s->file, NULL, NULL, &entry, NULL, NULL,
-                               big_endian, 0, 0, 0, s->cpu->as);
+                               big_endian, 0, 0, 0, as);
 
             if (size < 0) {
                 size = load_uimage_as(s->file, &entry, NULL, NULL, NULL, NULL,
-                                      s->cpu->as);
+                                      as);
             }
         }
 
         if (size < 0 || s->force_raw) {
             /* Default to the maximum size being the machine's ram size */
-            size = load_image_targphys_as(s->file, s->addr, ram_size,
-                                          s->cpu->as);
+            size = load_image_targphys_as(s->file, s->addr, ram_size, as);
         } else {
             s->addr = entry;
         }
-- 
2.11.0
