Received: from eggs.gnu.org ([2001:4830:134:3::10]:39439)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1demZy-0006YX-7Z
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 14:16:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1demZs-0008Ip-NQ
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 14:16:38 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43178)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1demZs-0008Hz-Eu
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 14:16:32 -0400
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Mon,  7 Aug 2017 20:16:12 +0200
Message-Id: <20170807181618.22562-3-marcandre.lureau@redhat.com>
In-Reply-To: <20170807181618.22562-1-marcandre.lureau@redhat.com>
References: <20170807181618.22562-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v5 2/8] fw_cfg: add write callback
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: imammedo@redhat.com, berrange@redhat.com, ehabkost@redhat.com, mst@redhat.com, anderson@redhat.com, lersek@redhat.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Ben Warren <ben@skyportsystems.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>

Reintroduce the write callback that was removed when write support was
removed in commit 023e3148567ac898c7258138f8e86c3c2bb40d07.

The write_cb callback is called when a write reaches the end of file,
that is when the write pointer/offset reaches the size of the file.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 include/hw/nvram/fw_cfg.h |  2 ++
 hw/acpi/vmgenid.c         |  2 +-
 hw/core/loader.c          |  2 +-
 hw/i386/acpi-build.c      |  2 +-
 hw/isa/lpc_ich9.c         |  4 ++--
 hw/nvram/fw_cfg.c         | 18 ++++++++++++++----
 6 files changed, 21 insertions(+), 9 deletions(-)

diff --git a/include/hw/nvram/fw_cfg.h b/include/hw/nvram/fw_cfg.h
index f50d068563..3527cd51d8 100644
--- a/include/hw/nvram/fw_cfg.h
+++ b/include/hw/nvram/fw_cfg.h
@@ -183,6 +183,7 @@ void fw_cfg_add_file(FWCfgState *s, const char *filen=
ame, void *data,
  * @s: fw_cfg device being modified
  * @filename: name of new fw_cfg file item
  * @select_cb: callback function when selecting
+ * @write_cb: callback function when write reached EOF
  * @callback_opaque: argument to be passed into callback function
  * @data: pointer to start of item data
  * @len: size of item data
@@ -202,6 +203,7 @@ void fw_cfg_add_file(FWCfgState *s, const char *filen=
ame, void *data,
  */
 void fw_cfg_add_file_callback(FWCfgState *s, const char *filename,
                               FWCfgCallback select_cb,
+                              FWCfgCallback write_cb,
                               void *callback_opaque,
                               void *data, size_t len, bool read_only);
=20
diff --git a/hw/acpi/vmgenid.c b/hw/acpi/vmgenid.c
index a32b847fe0..c1e935da9f 100644
--- a/hw/acpi/vmgenid.c
+++ b/hw/acpi/vmgenid.c
@@ -124,7 +124,7 @@ void vmgenid_add_fw_cfg(VmGenIdState *vms, FWCfgState=
 *s, GArray *guid)
     fw_cfg_add_file(s, VMGENID_GUID_FW_CFG_FILE, guid->data,
                     VMGENID_FW_CFG_SIZE);
     /* Create a read-write fw_cfg file for Address */
-    fw_cfg_add_file_callback(s, VMGENID_ADDR_FW_CFG_FILE, NULL, NULL,
+    fw_cfg_add_file_callback(s, VMGENID_ADDR_FW_CFG_FILE, NULL, NULL, NU=
LL,
                              vms->vmgenid_addr_le,
                              ARRAY_SIZE(vms->vmgenid_addr_le), false);
 }
diff --git a/hw/core/loader.c b/hw/core/loader.c
index 4593061445..91669d65aa 100644
--- a/hw/core/loader.c
+++ b/hw/core/loader.c
@@ -1023,7 +1023,7 @@ MemoryRegion *rom_add_blob(const char *name, const =
void *blob, size_t len,
         }
=20
         fw_cfg_add_file_callback(fw_cfg, fw_file_name,
-                                 fw_callback, callback_opaque,
+                                 fw_callback, NULL, callback_opaque,
                                  data, rom->datasize, read_only);
     }
     return mr;
diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
index b9c245c9bb..be2992b708 100644
--- a/hw/i386/acpi-build.c
+++ b/hw/i386/acpi-build.c
@@ -2922,7 +2922,7 @@ void acpi_setup(void)
=20
         build_state->rsdp =3D g_memdup(tables.rsdp->data, rsdp_size);
         fw_cfg_add_file_callback(pcms->fw_cfg, ACPI_BUILD_RSDP_FILE,
-                                 acpi_build_update, build_state,
+                                 acpi_build_update, NULL, build_state,
                                  build_state->rsdp, rsdp_size, true);
         build_state->rsdp_mr =3D NULL;
     } else {
diff --git a/hw/isa/lpc_ich9.c b/hw/isa/lpc_ich9.c
index ac8416d42b..de8fbb7260 100644
--- a/hw/isa/lpc_ich9.c
+++ b/hw/isa/lpc_ich9.c
@@ -402,12 +402,12 @@ void ich9_lpc_pm_init(PCIDevice *lpc_pci, bool smm_=
enabled)
          * just link them into fw_cfg here.
          */
         fw_cfg_add_file_callback(fw_cfg, "etc/smi/requested-features",
-                                 NULL, NULL,
+                                 NULL, NULL, NULL,
                                  lpc->smi_guest_features_le,
                                  sizeof lpc->smi_guest_features_le,
                                  false);
         fw_cfg_add_file_callback(fw_cfg, "etc/smi/features-ok",
-                                 smi_features_ok_callback, lpc,
+                                 smi_features_ok_callback, NULL, lpc,
                                  &lpc->smi_features_ok,
                                  sizeof lpc->smi_features_ok,
                                  true);
diff --git a/hw/nvram/fw_cfg.c b/hw/nvram/fw_cfg.c
index e3bd626b8c..28780088b9 100644
--- a/hw/nvram/fw_cfg.c
+++ b/hw/nvram/fw_cfg.c
@@ -56,6 +56,7 @@ struct FWCfgEntry {
     uint8_t *data;
     void *callback_opaque;
     FWCfgCallback select_cb;
+    FWCfgCallback write_cb;
 };
=20
 #define JPG_FILE 0
@@ -384,6 +385,12 @@ static void fw_cfg_dma_transfer(FWCfgState *s)
     stl_be_dma(s->dma_as, dma_addr + offsetof(FWCfgDmaAccess, control),
                 dma.control);
=20
+    if (write &&
+        !(dma.control & FW_CFG_DMA_CTL_ERROR) &&
+        s->cur_offset =3D=3D e->len) {
+        e->write_cb(e->callback_opaque);
+    }
+
     trace_fw_cfg_read(s, 0);
 }
=20
@@ -570,6 +577,7 @@ static const VMStateDescription vmstate_fw_cfg =3D {
=20
 static void fw_cfg_add_bytes_callback(FWCfgState *s, uint16_t key,
                                       FWCfgCallback select_cb,
+                                      FWCfgCallback write_cb,
                                       void *callback_opaque,
                                       void *data, size_t len,
                                       bool read_only)
@@ -584,6 +592,7 @@ static void fw_cfg_add_bytes_callback(FWCfgState *s, =
uint16_t key,
     s->entries[arch][key].data =3D data;
     s->entries[arch][key].len =3D (uint32_t)len;
     s->entries[arch][key].select_cb =3D select_cb;
+    s->entries[arch][key].write_cb =3D write_cb;
     s->entries[arch][key].callback_opaque =3D callback_opaque;
     s->entries[arch][key].allow_write =3D !read_only;
 }
@@ -610,7 +619,7 @@ static void *fw_cfg_modify_bytes_read(FWCfgState *s, =
uint16_t key,
=20
 void fw_cfg_add_bytes(FWCfgState *s, uint16_t key, void *data, size_t le=
n)
 {
-    fw_cfg_add_bytes_callback(s, key, NULL, NULL, data, len, true);
+    fw_cfg_add_bytes_callback(s, key, NULL, NULL, NULL, data, len, true)=
;
 }
=20
 void fw_cfg_add_string(FWCfgState *s, uint16_t key, const char *value)
@@ -737,6 +746,7 @@ static int get_fw_cfg_order(FWCfgState *s, const char=
 *name)
=20
 void fw_cfg_add_file_callback(FWCfgState *s,  const char *filename,
                               FWCfgCallback select_cb,
+                              FWCfgCallback write_cb,
                               void *callback_opaque,
                               void *data, size_t len, bool read_only)
 {
@@ -800,7 +810,7 @@ void fw_cfg_add_file_callback(FWCfgState *s,  const c=
har *filename,
     }
=20
     fw_cfg_add_bytes_callback(s, FW_CFG_FILE_FIRST + index,
-                              select_cb,
+                              select_cb, write_cb,
                               callback_opaque, data, len,
                               read_only);
=20
@@ -815,7 +825,7 @@ void fw_cfg_add_file_callback(FWCfgState *s,  const c=
har *filename,
 void fw_cfg_add_file(FWCfgState *s,  const char *filename,
                      void *data, size_t len)
 {
-    fw_cfg_add_file_callback(s, filename, NULL, NULL, data, len, true);
+    fw_cfg_add_file_callback(s, filename, NULL, NULL, NULL, data, len, t=
rue);
 }
=20
 void *fw_cfg_modify_file(FWCfgState *s, const char *filename,
@@ -838,7 +848,7 @@ void *fw_cfg_modify_file(FWCfgState *s, const char *f=
ilename,
         }
     }
     /* add new one */
-    fw_cfg_add_file_callback(s, filename, NULL, NULL, data, len, true);
+    fw_cfg_add_file_callback(s, filename, NULL, NULL, NULL, data, len, t=
rue);
     return NULL;
 }
=20
--=20
2.14.0.1.geff633fa0
