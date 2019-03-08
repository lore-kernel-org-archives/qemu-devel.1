Received: from eggs.gnu.org ([209.51.188.92]:59086)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1h24QE-0004No-MF
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 20:35:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1h24QC-0003JG-OT
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 20:35:38 -0500
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Date: Fri,  8 Mar 2019 02:32:18 +0100
Message-Id: <20190308013222.12524-15-philmd@redhat.com>
In-Reply-To: <20190308013222.12524-1-philmd@redhat.com>
References: <20190308013222.12524-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 14/18] hw/nvram/fw_cfg: Add HMP 'info
 fw_cfg' command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laszlo Ersek <lersek@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org
Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Eduardo Habkost <ehabkost@redhat.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Artyom Tarasenko <atar4qemu@gmail.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, David Gibson <david@gibson.dropbear.id.au>, Igor Mammedov <imammedo@redhat.com>, Eric Blake <eblake@redhat.com>, qemu-ppc@nongnu.org, qemu-arm@nongnu.org, Markus Armbruster <armbru@redhat.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Thomas Huth <thuth@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>

When debugging a paravirtualized guest firmware, it results very
useful to dump the fw_cfg table.
Add a HMP command which displays the most useful fields.
We display each fw_cfg item data in hexadecimal (only the first 8
bytes):

$ (echo info fw_cfg; echo q) | qemu-system-x86_64 -S -monitor stdio
(qemu) info fw_cfg
Selector  Well-Known Key  Pathname ArchSpec Perm   Size Order Hex Data
 0x0000   signature                          RO       4       51454d55
 0x0001   id                                 RO       4       03000000
 0x0002   uuid                               RO      16       00000000000=
00000..
 0x0003   ram_size                           RO       8       00000008000=
00000
 0x0004   nographic                          RO       2       0000
 0x0005   nb_cpus                            RO       2       0100
 0x000d   numa                               RO      16       00000000000=
00000..
 0x000e   boot_menu                          RO       2       0000
 0x000f   max_cpus                           RO       2       0100
 0x0019   file_dir                           RO    2052       0000000b000=
00000..
 0x0021   file: etc/acpi/rsdp                RO      20  160  52534420505=
45220..
 0x0022   file: etc/acpi/tables              RO  131072  130  46414353400=
00000..
 0x0023   file: etc/boot-fail-wait           RO       4   15  ffffffff
 0x0024   file: etc/e820                     RO      20   40  00000000000=
00000..
 0x0025   file: etc/smbios/smbios-anchor     RO      31   30  5f534d5f001=
f0208..
 0x0026   file: etc/smbios/smbios-tables     RO     321   20  011b0001010=
20300..
 0x0027   file: etc/system-states            RO       6   90  80000081828=
0
 0x0028   file: etc/table-loader             RO    4096  140  01000000657=
4632f..
 0x002a   file: genroms/kvmvapic.bin         RO    9216   55  55aa12060e0=
731c0..
 0x0002   irq0_override                   *  RO       4       01000000
 0x0003   e820_tables                     *  RO     324       00000000000=
00000..
 0x0004   hpet                            *  RO     121       0101a286800=
000d0..
(qemu) q

$ (echo info fw_cfg; echo q) | qemu-system-mips -S -monitor stdio
(qemu) info fw_cfg
This machine does not use fw_cfg
(qemu) q

$ (echo info fw_cfg; echo q) | qemu-system-ppc -S -monitor stdio
(qemu) info fw_cfg
Selector  Well-Known Key  Pathname ArchSpec Perm   Size Order Hex Data
 0x0000   signature                          RO       4       51454d55
 0x0001   id                                 RO       4       01000000
 0x0002   uuid                               RO      16       00000000000=
00000..
 0x0003   ram_size                           RO       8       00000008000=
00000
 0x0004   nographic                          RO       2       0000
 0x0005   nb_cpus                            RO       2       0100
 0x0006   machine_id                         RO       2       0200
 0x0007   kernel_addr                        RO       4       00000000
 0x0008   kernel_size                        RO       4       00000000
 0x0009   kernel_cmdline                     RO       4       00000000
 0x000a   initrd_addr                        RO       4       00000000
 0x000b   initdr_size                        RO       4       00000000
 0x000c   boot_device                        RO       2       6300
 0x000e   boot_menu                          RO       2       0000
 0x000f   max_cpus                           RO       2       0100
 0x0019   file_dir                           RO    2052       00000002000=
00000..
 0x0021   file: etc/boot-fail-wait           RO       4   15  ffffffff
 0x0000   width                           *  RO       2       2003
 0x0001   height                          *  RO       2       5802
 0x0002   depth                           *  RO       2       2000
 0x0003   tbfreq                          *  RO       4       c04bfd00
 0x0004   clockfreq                       *  RO       4       80d6da0f
 0x0005   is_kvm                          *  RO       4       00000000
 0x0009   busfreq                         *  RO       4       8014ef03
(qemu) q

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
v2: Check fw_cfg !=3D NULL (Michael)
    Rename keys, display data in hexa (Laszlo)
---
 hmp-commands-info.hx      | 17 ++++++++++
 hw/nvram/fw_cfg.c         | 71 ++++++++++++++++++++++++++++++++++++++-
 include/hw/nvram/fw_cfg.h |  2 ++
 3 files changed, 89 insertions(+), 1 deletion(-)

diff --git a/hmp-commands-info.hx b/hmp-commands-info.hx
index cbee8b944d..2c9538c8da 100644
--- a/hmp-commands-info.hx
+++ b/hmp-commands-info.hx
@@ -916,6 +916,23 @@ STEXI
 @item info sev
 @findex info sev
 Show SEV information.
+ETEXI
+
+    {
+        .name       =3D "fw_cfg",
+        .args_type  =3D "",
+        .params     =3D "",
+        .help       =3D "Display the table firmware configuration entrie=
s "
+                      "registered by a paravirtualized machine. Helpful =
"
+                      "when debugging guest firmwares.",
+        .cmd        =3D hmp_info_fw_cfg,
+    },
+
+STEXI
+@item info fw_cfg
+@findex info fw_cfg
+Display the table firmware configuration entries registered by a paravir=
tualized
+machine. This information is useful when debugging guest firmwares.
 ETEXI
=20
 STEXI
diff --git a/hw/nvram/fw_cfg.c b/hw/nvram/fw_cfg.c
index 2a8d69ba07..4c82dcc125 100644
--- a/hw/nvram/fw_cfg.c
+++ b/hw/nvram/fw_cfg.c
@@ -35,6 +35,7 @@
 #include "qemu/config-file.h"
 #include "qemu/cutils.h"
 #include "qapi/error.h"
+#include "monitor/monitor.h"
 #include "qapi/qapi-commands-misc.h"
=20
 #define FW_CFG_FILE_SLOTS_DFLT 0x20
@@ -1273,7 +1274,18 @@ static FirmwareConfigurationItem *create_qmp_fw_cf=
g_item(FWCfgState *s,
     return item;
 }
=20
-FirmwareConfigurationItemList *qmp_query_fw_cfg_items(Error **errp)
+/**
+ * query_fw_cfg_items:
+ *
+ * @use_hexdump: Whether to populate the @data field with the hexadecima=
l
+ *               representation of the item data.
+ * @errp: Pointer to a NULL initialized error object.
+ *
+ * Returns: A list of @FirmwareConfigurationItem, reverse sorted by the
+ *          item selector key.
+ */
+static FirmwareConfigurationItemList *query_fw_cfg_items(bool use_hexdum=
p,
+                                                         Error **errp)
 {
     FirmwareConfigurationItemList *item_list =3D NULL;
     uint32_t max_entries;
@@ -1294,6 +1306,9 @@ FirmwareConfigurationItemList *qmp_query_fw_cfg_ite=
ms(Error **errp)
             if (!e->len) {
                 continue;
             }
+            if (use_hexdump) {
+                qmp_hex_length =3D MIN(e->len, 8);
+            }
=20
             info =3D g_malloc0(sizeof(*info));
             info->value =3D create_qmp_fw_cfg_item(s, e, arch, key,
@@ -1305,3 +1320,57 @@ FirmwareConfigurationItemList *qmp_query_fw_cfg_it=
ems(Error **errp)
=20
     return item_list;
 }
+
+FirmwareConfigurationItemList *qmp_query_fw_cfg_items(Error **errp)
+{
+    return query_fw_cfg_items(false, errp);
+}
+
+void hmp_info_fw_cfg(Monitor *mon, const QDict *qdict)
+{
+    FirmwareConfigurationItemList *item_list, *method;
+    Error *err =3D NULL;
+
+    item_list =3D query_fw_cfg_items(true, &err);
+    if (!item_list) {
+        monitor_printf(mon, "This machine does not use fw_cfg\n");
+        return;
+    }
+    if (err) {
+        monitor_printf(mon, "Could not query fw_cfg entries: %s\n",
+                       error_get_pretty(err));
+        error_free(err);
+        return;
+    }
+
+    monitor_printf(mon, "Selector  Well-Known Key  Pathname"
+                        " ArchSpec Perm   Size Order Hex Data\n");
+    for (method =3D item_list; method; method =3D method->next) {
+        if (method->value->has_path) {
+            monitor_printf(mon,
+                           " 0x%04x   file: %-28s %2s %7" PRId64
+                           "  %3" PRId64 "  %-16s%s\n",
+                           method->value->key,
+                           method->value->path,
+                           method->value->writeable ? "RW" : "RO",
+                           method->value->size,
+                           method->value->order,
+                           method->value->data,
+                           method->value->size > 8 ? ".." : "");
+        } else {
+            monitor_printf(mon,
+                           " 0x%04x   %-30s  %c  %2s %7" PRId64
+                           "       %-16s%s\n",
+                           method->value->key,
+                           method->value->has_keyname
+                                ? method->value->keyname : "",
+                           method->value->architecture_specific ? '*' : =
' ',
+                           method->value->writeable ? "RW" : "RO",
+                           method->value->size,
+                           method->value->data,
+                           method->value->size > 8 ? ".." : "");
+       }
+    }
+
+    qapi_free_FirmwareConfigurationItemList(item_list);
+}
diff --git a/include/hw/nvram/fw_cfg.h b/include/hw/nvram/fw_cfg.h
index 83a0540b6c..5ac9adfe1f 100644
--- a/include/hw/nvram/fw_cfg.h
+++ b/include/hw/nvram/fw_cfg.h
@@ -243,4 +243,6 @@ bool fw_cfg_dma_enabled(void *opaque);
  */
 const char *fw_cfg_arch_key_name(uint16_t key);
=20
+void hmp_info_fw_cfg(Monitor *mon, const QDict *qdict);
+
 #endif
--=20
2.20.1
