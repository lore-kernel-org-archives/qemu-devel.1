Received: from eggs.gnu.org ([2001:4830:134:3::10]:39484)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1dema3-0006dz-HD
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 14:16:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1demZy-0008NQ-8L
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 14:16:43 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39780)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1demZx-0008Mi-Vh
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 14:16:38 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 07A2B7EA95
	for <qemu-devel@nongnu.org>; Mon,  7 Aug 2017 18:16:37 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Mon,  7 Aug 2017 20:16:13 +0200
Message-Id: <20170807181618.22562-4-marcandre.lureau@redhat.com>
In-Reply-To: <20170807181618.22562-1-marcandre.lureau@redhat.com>
References: <20170807181618.22562-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v5 3/8] fw_cfg: add vmcoreinfo file
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

See docs/specs/fw_cfg.txt for details.

The "etc/vmcoreinfo" is added when using "-global
fw_cfg.vmcoreinfo=3Don" qemu option.

Disabled by default for machine types v2.9 and older.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 include/hw/compat.h       |  8 ++++++++
 include/hw/nvram/fw_cfg.h |  9 +++++++++
 hw/nvram/fw_cfg.c         | 20 ++++++++++++++++++++
 docs/specs/fw_cfg.txt     | 16 ++++++++++++++++
 4 files changed, 53 insertions(+)

diff --git a/include/hw/compat.h b/include/hw/compat.h
index 08f36004da..317fd2e2e3 100644
--- a/include/hw/compat.h
+++ b/include/hw/compat.h
@@ -18,6 +18,14 @@
         .driver   =3D "pcie-root-port",\
         .property =3D "x-migrate-msix",\
         .value    =3D "false",\
+    },{\
+        .driver   =3D "fw_cfg_mem",\
+        .property =3D "vmcoreinfo",\
+        .value    =3D "off",\
+    },{\
+        .driver   =3D "fw_cfg_io",\
+        .property =3D "vmcoreinfo",\
+        .value    =3D "off",\
     },
=20
 #define HW_COMPAT_2_8 \
diff --git a/include/hw/nvram/fw_cfg.h b/include/hw/nvram/fw_cfg.h
index 3527cd51d8..a35f47405d 100644
--- a/include/hw/nvram/fw_cfg.h
+++ b/include/hw/nvram/fw_cfg.h
@@ -30,6 +30,11 @@ typedef struct FWCfgFile {
 void fw_cfg_set_order_override(FWCfgState *fw_cfg, int order);
 void fw_cfg_reset_order_override(FWCfgState *fw_cfg);
=20
+typedef struct FWCfgVMCoreInfo {
+    uint64_t paddr;
+    uint32_t size;
+} QEMU_PACKED FWCfgVMCoreInfo;
+
 typedef struct FWCfgFiles {
     uint32_t  count;
     FWCfgFile f[];
@@ -65,6 +70,10 @@ struct FWCfgState {
     dma_addr_t dma_addr;
     AddressSpace *dma_as;
     MemoryRegion dma_iomem;
+
+    bool vmcoreinfo_enabled;
+    bool has_vmcoreinfo;
+    FWCfgVMCoreInfo vmcoreinfo;
 };
=20
 struct FWCfgIoState {
diff --git a/hw/nvram/fw_cfg.c b/hw/nvram/fw_cfg.c
index 28780088b9..342afc4ed2 100644
--- a/hw/nvram/fw_cfg.c
+++ b/hw/nvram/fw_cfg.c
@@ -504,6 +504,7 @@ static void fw_cfg_reset(DeviceState *d)
=20
     /* we never register a read callback for FW_CFG_SIGNATURE */
     fw_cfg_select(s, FW_CFG_SIGNATURE);
+    s->has_vmcoreinfo =3D false;
 }
=20
 /* Save restore 32 bit int as uint16_t
@@ -869,7 +870,12 @@ static void fw_cfg_machine_ready(struct Notifier *n,=
 void *data)
     qemu_register_reset(fw_cfg_machine_reset, s);
 }
=20
+static void fw_cfg_vmci_written(void *dev)
+{
+    FWCfgState *s =3D FW_CFG(dev);
=20
+    s->has_vmcoreinfo =3D true;
+}
=20
 static void fw_cfg_common_realize(DeviceState *dev, Error **errp)
 {
@@ -895,6 +901,16 @@ static void fw_cfg_common_realize(DeviceState *dev, =
Error **errp)
=20
     fw_cfg_add_i32(s, FW_CFG_ID, version);
=20
+    if (s->vmcoreinfo_enabled) {
+        if (!s->dma_enabled) {
+            error_setg(errp, "vmcoreinfo requires dma_enabled");
+            return;
+        }
+        fw_cfg_add_file_callback(s, "etc/vmcoreinfo",
+                                 NULL, fw_cfg_vmci_written, s,
+                                 &s->vmcoreinfo, sizeof(s->vmcoreinfo), =
false);
+    }
+
     s->machine_ready.notify =3D fw_cfg_machine_ready;
     qemu_add_machine_init_done_notifier(&s->machine_ready);
 }
@@ -1031,6 +1047,8 @@ static void fw_cfg_file_slots_allocate(FWCfgState *=
s, Error **errp)
 static Property fw_cfg_io_properties[] =3D {
     DEFINE_PROP_BOOL("dma_enabled", FWCfgIoState, parent_obj.dma_enabled=
,
                      true),
+    DEFINE_PROP_BOOL("vmcoreinfo", FWCfgIoState, parent_obj.vmcoreinfo_e=
nabled,
+                     true),
     DEFINE_PROP_UINT16("x-file-slots", FWCfgIoState, parent_obj.file_slo=
ts,
                        FW_CFG_FILE_SLOTS_DFLT),
     DEFINE_PROP_END_OF_LIST(),
@@ -1082,6 +1100,8 @@ static Property fw_cfg_mem_properties[] =3D {
     DEFINE_PROP_UINT32("data_width", FWCfgMemState, data_width, -1),
     DEFINE_PROP_BOOL("dma_enabled", FWCfgMemState, parent_obj.dma_enable=
d,
                      true),
+    DEFINE_PROP_BOOL("vmcoreinfo", FWCfgMemState, parent_obj.vmcoreinfo_=
enabled,
+                     true),
     DEFINE_PROP_UINT16("x-file-slots", FWCfgMemState, parent_obj.file_sl=
ots,
                        FW_CFG_FILE_SLOTS_DFLT),
     DEFINE_PROP_END_OF_LIST(),
diff --git a/docs/specs/fw_cfg.txt b/docs/specs/fw_cfg.txt
index 08c00bdf44..37d0f9f40a 100644
--- a/docs/specs/fw_cfg.txt
+++ b/docs/specs/fw_cfg.txt
@@ -136,6 +136,22 @@ struct FWCfgFile {		/* an individual file entry, 64 =
bytes total */
     char name[56];		/* fw_cfg item name, NUL-terminated ascii */
 };
=20
+=3D=3D=3D etc/vmcoreinfo =3D=3D=3D
+
+A guest may use this entry to add information details to qemu
+dumps. The entry gives location and size of an ELF note that is
+appended in qemu dumps.
+
+The entry is of 12 bytes with this format:
+
+struct FWCfgVMCoreInfo {
+    uint64_t paddr;             /* physical address of ELF note, LE */
+    uint32_t size;              /* size of ELF note region, LE */
+};
+
+The note format/class must be of the target bitness and the size must
+be less than 1Mb.
+
 =3D=3D=3D All Other Data Items =3D=3D=3D
=20
 Please consult the QEMU source for the most up-to-date and authoritative=
 list
--=20
2.14.0.1.geff633fa0
