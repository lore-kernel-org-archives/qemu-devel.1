Received: from eggs.gnu.org ([2001:4830:134:3::10]:47998)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1cRk3F-00011G-BO
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 13:24:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1cRk3C-0002Ma-7U
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 13:24:41 -0500
Received: from mx1.redhat.com ([209.132.183.28]:46540)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1cRk3B-0002MJ-UE
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 13:24:38 -0500
From: Laszlo Ersek <lersek@redhat.com>
Date: Thu, 12 Jan 2017 19:24:17 +0100
Message-Id: <20170112182417.9548-5-lersek@redhat.com>
In-Reply-To: <20170112182417.9548-1-lersek@redhat.com>
References: <20170112182417.9548-1-lersek@redhat.com>
Subject: [Qemu-devel] [PATCH v6 wave 1 4/4] fw-cfg: bump "x-file-slots" to
 0x20 for 2.9+ machine types
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu devel list <qemu-devel@nongnu.org>
Cc: "Gabriel L. Somlo" <somlo@cmu.edu>, "Michael S. Tsirkin" <mst@redhat.com>, Alexander Graf <agraf@suse.de>, Anthony Perard <anthony.perard@citrix.com>, Artyom Tarasenko <atar4qemu@gmail.com>, David Gibson <david@gibson.dropbear.id.au>, Eduardo Habkost <ehabkost@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Stefano Stabellini <sstabellini@kernel.org>

More precisely, the "x-file-slots" count is bumped for all machine types
that:
(a) use fw_cfg, and
(b) are not versioned (hence migration is not expected to work for them
    across QEMU releases anyway), or have version 2.9.

This affects machine types implemented in the following source files:

- "hw/arm/virt.c". The "virt-*" machine type is versioned, and the <= 2.8
  versions already depend on HW_COMPAT_2_8 (see commit e353aac51b944).
  Therefore adding the "x-file-slots" compat values to HW_COMPAT_2_8
  suffices.

- "hw/i386/pc.c". The "pc-i440fx-*" (including "pc-*") and "pc-q35-*"
  machine types are versioned. Modifying HW_COMPAT_2_8 is sufficient here
  too (see commit "pc: Add 2.9 machine-types"). The "isapc" machtype is
  not versioned. The "xenfv" machine type, which uses fw_cfg for direct
  kernel booting, is also not versioned.

- "hw/ppc/mac_newworld.c". The "mac99" machine type is not versioned.

- "hw/ppc/mac_oldworld.c". The "g3beige" machine type is not versioned.

- "hw/sparc/sun4m.c". None of the 9 machine types defined in this file
  appear versioned.

- "hw/sparc64/sun4u.c". None of the 3 machine types defined in this file
  appear versioned.

Cc: "Gabriel L. Somlo" <somlo@cmu.edu>
Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Alexander Graf <agraf@suse.de>
Cc: Anthony Perard <anthony.perard@citrix.com>
Cc: Artyom Tarasenko <atar4qemu@gmail.com>
Cc: David Gibson <david@gibson.dropbear.id.au>
Cc: Eduardo Habkost <ehabkost@redhat.com>
Cc: Gerd Hoffmann <kraxel@redhat.com>
Cc: Igor Mammedov <imammedo@redhat.com>
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>
Cc: Stefano Stabellini <sstabellini@kernel.org>
Signed-off-by: Laszlo Ersek <lersek@redhat.com>
Acked-by: Gabriel Somlo <somlo@cmu.edu>
Tested-by: Gabriel Somlo <somlo@cmu.edu>
---

Notes:
    v6:
    - rename the "file_slots" property to "x-file-slots" [Eduardo, Michael]
    - pick up Gabriel's A-b and T-b
    
    v5:
    - based on the previous patch from Eduardo, replace the following two
      patches from v4 [Igor]:
      * fw-cfg: expose "file_slots" parameter in fw_cfg_init_io_dma()
      * hw/i386/pc: introduce 2.9 machine types with 0x20 fw_cfg file slots

 docs/specs/fw_cfg.txt |  4 ++--
 include/hw/compat.h   | 10 +++++++++-
 hw/nvram/fw_cfg.c     |  6 ++++--
 3 files changed, 15 insertions(+), 5 deletions(-)

diff --git a/docs/specs/fw_cfg.txt b/docs/specs/fw_cfg.txt
index 9373bbc64743..08c00bdf44a2 100644
--- a/docs/specs/fw_cfg.txt
+++ b/docs/specs/fw_cfg.txt
@@ -155,8 +155,8 @@ Selector Reg.    Range Usage
                                  through the DMA interface in QEMU v2.9+)
 0xc000 - 0xffff  Arch. Specific (0x0000 - 0x3fff, RW, ignored in v2.4+)
 
-In practice, the number of allowed firmware configuration items is given
-by the value (FW_CFG_FILE_FIRST + FW_CFG_FILE_SLOTS_MIN) (see fw_cfg.h).
+In practice, the number of allowed firmware configuration items depends on the
+machine type/version.
 
 = Guest-side DMA Interface =
 
diff --git a/include/hw/compat.h b/include/hw/compat.h
index 4fe44d1c7a6c..34e9b4a660d0 100644
--- a/include/hw/compat.h
+++ b/include/hw/compat.h
@@ -2,7 +2,15 @@
 #define HW_COMPAT_H
 
 #define HW_COMPAT_2_8 \
-    /* empty */
+    {\
+        .driver   = "fw_cfg_mem",\
+        .property = "x-file-slots",\
+        .value    = stringify(0x10),\
+    },{\
+        .driver   = "fw_cfg_io",\
+        .property = "x-file-slots",\
+        .value    = stringify(0x10),\
+    },
 
 #define HW_COMPAT_2_7 \
     {\
diff --git a/hw/nvram/fw_cfg.c b/hw/nvram/fw_cfg.c
index bf75ef71d57e..523d585dcfed 100644
--- a/hw/nvram/fw_cfg.c
+++ b/hw/nvram/fw_cfg.c
@@ -35,6 +35,8 @@
 #include "qemu/cutils.h"
 #include "qapi/error.h"
 
+#define FW_CFG_FILE_SLOTS_DFLT 0x20
+
 #define FW_CFG_NAME "fw_cfg"
 #define FW_CFG_PATH "/machine/" FW_CFG_NAME
 
@@ -1058,7 +1060,7 @@ static Property fw_cfg_io_properties[] = {
     DEFINE_PROP_BOOL("dma_enabled", FWCfgIoState, parent_obj.dma_enabled,
                      true),
     DEFINE_PROP_UINT16("x-file-slots", FWCfgIoState, parent_obj.file_slots,
-                       FW_CFG_FILE_SLOTS_MIN),
+                       FW_CFG_FILE_SLOTS_DFLT),
     DEFINE_PROP_END_OF_LIST(),
 };
 
@@ -1110,7 +1112,7 @@ static Property fw_cfg_mem_properties[] = {
     DEFINE_PROP_BOOL("dma_enabled", FWCfgMemState, parent_obj.dma_enabled,
                      true),
     DEFINE_PROP_UINT16("x-file-slots", FWCfgMemState, parent_obj.file_slots,
-                       FW_CFG_FILE_SLOTS_MIN),
+                       FW_CFG_FILE_SLOTS_DFLT),
     DEFINE_PROP_END_OF_LIST(),
 };
 
-- 
2.9.3
