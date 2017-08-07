Received: from eggs.gnu.org ([2001:4830:134:3::10]:39399)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1demZs-0006ML-Kh
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 14:16:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1demZn-0008AL-D6
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 14:16:32 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48720)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1demZn-00089O-3o
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 14:16:27 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id DDDF4883C4
	for <qemu-devel@nongnu.org>; Mon,  7 Aug 2017 18:16:25 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Mon,  7 Aug 2017 20:16:11 +0200
Message-Id: <20170807181618.22562-2-marcandre.lureau@redhat.com>
In-Reply-To: <20170807181618.22562-1-marcandre.lureau@redhat.com>
References: <20170807181618.22562-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v5 1/8] fw_cfg: rename read callback
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: imammedo@redhat.com, berrange@redhat.com, ehabkost@redhat.com, mst@redhat.com, anderson@redhat.com, lersek@redhat.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

The callback is called on select.

Furthermore, the next patch introduced a new callback, so rename the
function type with a generic name.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 include/hw/loader.h       |  2 +-
 include/hw/nvram/fw_cfg.h |  7 ++++---
 hw/core/loader.c          |  2 +-
 hw/nvram/fw_cfg.c         | 30 ++++++++++++++++--------------
 4 files changed, 22 insertions(+), 19 deletions(-)

diff --git a/include/hw/loader.h b/include/hw/loader.h
index 490c9ff8e6..355fe0f5a2 100644
--- a/include/hw/loader.h
+++ b/include/hw/loader.h
@@ -192,7 +192,7 @@ int rom_add_file(const char *file, const char *fw_dir=
,
 MemoryRegion *rom_add_blob(const char *name, const void *blob, size_t le=
n,
                            size_t max_len, hwaddr addr,
                            const char *fw_file_name,
-                           FWCfgReadCallback fw_callback,
+                           FWCfgCallback fw_callback,
                            void *callback_opaque, AddressSpace *as,
                            bool read_only);
 int rom_add_elf_program(const char *name, void *data, size_t datasize,
diff --git a/include/hw/nvram/fw_cfg.h b/include/hw/nvram/fw_cfg.h
index b77ea48abb..f50d068563 100644
--- a/include/hw/nvram/fw_cfg.h
+++ b/include/hw/nvram/fw_cfg.h
@@ -44,7 +44,7 @@ typedef struct FWCfgDmaAccess {
     uint64_t address;
 } QEMU_PACKED FWCfgDmaAccess;
=20
-typedef void (*FWCfgReadCallback)(void *opaque);
+typedef void (*FWCfgCallback)(void *opaque);
=20
 struct FWCfgState {
     /*< private >*/
@@ -182,7 +182,7 @@ void fw_cfg_add_file(FWCfgState *s, const char *filen=
ame, void *data,
  * fw_cfg_add_file_callback:
  * @s: fw_cfg device being modified
  * @filename: name of new fw_cfg file item
- * @callback: callback function
+ * @select_cb: callback function when selecting
  * @callback_opaque: argument to be passed into callback function
  * @data: pointer to start of item data
  * @len: size of item data
@@ -201,7 +201,8 @@ void fw_cfg_add_file(FWCfgState *s, const char *filen=
ame, void *data,
  * with FW_CFG_DMA_CTL_SELECT).
  */
 void fw_cfg_add_file_callback(FWCfgState *s, const char *filename,
-                              FWCfgReadCallback callback, void *callback=
_opaque,
+                              FWCfgCallback select_cb,
+                              void *callback_opaque,
                               void *data, size_t len, bool read_only);
=20
 /**
diff --git a/hw/core/loader.c b/hw/core/loader.c
index ebe574c7ea..4593061445 100644
--- a/hw/core/loader.c
+++ b/hw/core/loader.c
@@ -989,7 +989,7 @@ err:
=20
 MemoryRegion *rom_add_blob(const char *name, const void *blob, size_t le=
n,
                    size_t max_len, hwaddr addr, const char *fw_file_name=
,
-                   FWCfgReadCallback fw_callback, void *callback_opaque,
+                   FWCfgCallback fw_callback, void *callback_opaque,
                    AddressSpace *as, bool read_only)
 {
     MachineClass *mc =3D MACHINE_GET_CLASS(qdev_get_machine());
diff --git a/hw/nvram/fw_cfg.c b/hw/nvram/fw_cfg.c
index 5bd904487f..e3bd626b8c 100644
--- a/hw/nvram/fw_cfg.c
+++ b/hw/nvram/fw_cfg.c
@@ -55,7 +55,7 @@ struct FWCfgEntry {
     bool allow_write;
     uint8_t *data;
     void *callback_opaque;
-    FWCfgReadCallback read_callback;
+    FWCfgCallback select_cb;
 };
=20
 #define JPG_FILE 0
@@ -236,8 +236,8 @@ static int fw_cfg_select(FWCfgState *s, uint16_t key)
         /* entry successfully selected, now run callback if present */
         arch =3D !!(key & FW_CFG_ARCH_LOCAL);
         e =3D &s->entries[arch][key & FW_CFG_ENTRY_MASK];
-        if (e->read_callback) {
-            e->read_callback(e->callback_opaque);
+        if (e->select_cb) {
+            e->select_cb(e->callback_opaque);
         }
     }
=20
@@ -568,11 +568,11 @@ static const VMStateDescription vmstate_fw_cfg =3D =
{
     }
 };
=20
-static void fw_cfg_add_bytes_read_callback(FWCfgState *s, uint16_t key,
-                                           FWCfgReadCallback callback,
-                                           void *callback_opaque,
-                                           void *data, size_t len,
-                                           bool read_only)
+static void fw_cfg_add_bytes_callback(FWCfgState *s, uint16_t key,
+                                      FWCfgCallback select_cb,
+                                      void *callback_opaque,
+                                      void *data, size_t len,
+                                      bool read_only)
 {
     int arch =3D !!(key & FW_CFG_ARCH_LOCAL);
=20
@@ -583,7 +583,7 @@ static void fw_cfg_add_bytes_read_callback(FWCfgState=
 *s, uint16_t key,
=20
     s->entries[arch][key].data =3D data;
     s->entries[arch][key].len =3D (uint32_t)len;
-    s->entries[arch][key].read_callback =3D callback;
+    s->entries[arch][key].select_cb =3D select_cb;
     s->entries[arch][key].callback_opaque =3D callback_opaque;
     s->entries[arch][key].allow_write =3D !read_only;
 }
@@ -610,7 +610,7 @@ static void *fw_cfg_modify_bytes_read(FWCfgState *s, =
uint16_t key,
=20
 void fw_cfg_add_bytes(FWCfgState *s, uint16_t key, void *data, size_t le=
n)
 {
-    fw_cfg_add_bytes_read_callback(s, key, NULL, NULL, data, len, true);
+    fw_cfg_add_bytes_callback(s, key, NULL, NULL, data, len, true);
 }
=20
 void fw_cfg_add_string(FWCfgState *s, uint16_t key, const char *value)
@@ -736,7 +736,8 @@ static int get_fw_cfg_order(FWCfgState *s, const char=
 *name)
 }
=20
 void fw_cfg_add_file_callback(FWCfgState *s,  const char *filename,
-                              FWCfgReadCallback callback, void *callback=
_opaque,
+                              FWCfgCallback select_cb,
+                              void *callback_opaque,
                               void *data, size_t len, bool read_only)
 {
     int i, index, count;
@@ -798,9 +799,10 @@ void fw_cfg_add_file_callback(FWCfgState *s,  const =
char *filename,
         }
     }
=20
-    fw_cfg_add_bytes_read_callback(s, FW_CFG_FILE_FIRST + index,
-                                   callback, callback_opaque, data, len,
-                                   read_only);
+    fw_cfg_add_bytes_callback(s, FW_CFG_FILE_FIRST + index,
+                              select_cb,
+                              callback_opaque, data, len,
+                              read_only);
=20
     s->files->f[index].size   =3D cpu_to_be32(len);
     s->files->f[index].select =3D cpu_to_be16(FW_CFG_FILE_FIRST + index)=
;
--=20
2.14.0.1.geff633fa0
