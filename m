Received: from eggs.gnu.org ([209.51.188.92]:58914)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1h24Q7-0004AZ-Fj
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 20:35:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1h24Q3-00034I-Ho
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 20:35:29 -0500
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Date: Fri,  8 Mar 2019 02:32:17 +0100
Message-Id: <20190308013222.12524-14-philmd@redhat.com>
In-Reply-To: <20190308013222.12524-1-philmd@redhat.com>
References: <20190308013222.12524-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 13/18] hw/nvram/fw_cfg: Add QMP 'info
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
Add a QMP command which returns the most useful fields.
Since the QMP protocol is not designed for passing stream data,
we don't display a fw_cfg item data, only it's size:

{ "execute": "query-fw_cfg-items" }
{
    "return": [
        {
            "architecture_specific": false,
            "key": 0,
            "writeable": false,
            "size": 4,
            "keyname": "signature"
        },
        {
            "architecture_specific": false,
            "key": 1,
            "writeable": false,
            "size": 4,
            "keyname": "id"
        },
        {
            "architecture_specific": false,
            "key": 2,
            "writeable": false,
            "size": 16,
            "keyname": "uuid"
        },
        ...
        {
            "order": 40,
            "architecture_specific": false,
            "key": 36,
            "writeable": false,
            "path": "etc/e820",
            "size": 20,
            "keyname": "file"
        },
        {
            "order": 30,
            "architecture_specific": false,
            "key": 37,
            "writeable": false,
            "path": "etc/smbios/smbios-anchor",
            "size": 31,
            "keyname": "file"
        },
        ...
        {
            "architecture_specific": true,
            "key": 3,
            "writeable": false,
            "size": 324,
            "keyname": "e820_tables"
        },
        {
            "architecture_specific": true,
            "key": 4,
            "writeable": false,
            "size": 121,
            "keyname": "hpet"
        }
    ]
}

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
v2: New commit, asked by Eric/Michael, using Laszlo suggestions
---
 hw/nvram/fw_cfg.c | 76 +++++++++++++++++++++++++++++++++++++++++++++++
 qapi/misc.json    | 44 +++++++++++++++++++++++++++
 2 files changed, 120 insertions(+)

diff --git a/hw/nvram/fw_cfg.c b/hw/nvram/fw_cfg.c
index fc392cb7e0..2a8d69ba07 100644
--- a/hw/nvram/fw_cfg.c
+++ b/hw/nvram/fw_cfg.c
@@ -35,6 +35,7 @@
 #include "qemu/config-file.h"
 #include "qemu/cutils.h"
 #include "qapi/error.h"
+#include "qapi/qapi-commands-misc.h"
=20
 #define FW_CFG_FILE_SLOTS_DFLT 0x20
=20
@@ -1229,3 +1230,78 @@ static void fw_cfg_register_types(void)
 }
=20
 type_init(fw_cfg_register_types)
+
+static FirmwareConfigurationItem *create_qmp_fw_cfg_item(FWCfgState *s,
+                                                         FWCfgEntry *e,
+                                                         bool is_arch_sp=
ecific,
+                                                         uint16_t key,
+                                                         size_t hex_leng=
th)
+{
+    FirmwareConfigurationItem *item =3D g_malloc0(sizeof(*item));
+
+    item->key =3D key;
+    item->writeable =3D e->allow_write;
+    item->architecture_specific =3D is_arch_specific;
+    item->size =3D e->len;
+    if (hex_length) {
+        item->has_data =3D true;
+        item->data =3D qemu_strdup_hexlify(e->data, hex_length);
+    }
+
+    if (!is_arch_specific && key >=3D FW_CFG_FILE_FIRST) {
+        int id =3D key - FW_CFG_FILE_FIRST;
+        const char *path =3D s->files->f[id].name;
+
+        item->has_keyname =3D true;
+        item->keyname =3D g_strdup("file");
+        item->has_order =3D true;
+        item->order =3D get_fw_cfg_order(s, path);
+        item->has_path =3D true;
+        item->path =3D g_strdup(path);
+    } else {
+        const char *name;
+
+        if (is_arch_specific) {
+            key |=3D FW_CFG_ARCH_LOCAL;
+        }
+        name =3D key_name(key);
+        if (name) {
+            item->has_keyname =3D true;
+            item->keyname =3D g_strdup(name);
+        }
+    }
+    return item;
+}
+
+FirmwareConfigurationItemList *qmp_query_fw_cfg_items(Error **errp)
+{
+    FirmwareConfigurationItemList *item_list =3D NULL;
+    uint32_t max_entries;
+    int arch, key;
+    FWCfgState *s =3D fw_cfg_find();
+
+    if (s =3D=3D NULL) {
+        return NULL;
+    }
+
+    max_entries =3D fw_cfg_max_entry(s);
+    for (arch =3D ARRAY_SIZE(s->entries) - 1; arch >=3D 0 ; --arch) {
+        for (key =3D max_entries - 1; key >=3D 0; --key) {
+            FirmwareConfigurationItemList *info;
+            FWCfgEntry *e =3D &s->entries[arch][key];
+            size_t qmp_hex_length =3D 0;
+
+            if (!e->len) {
+                continue;
+            }
+
+            info =3D g_malloc0(sizeof(*info));
+            info->value =3D create_qmp_fw_cfg_item(s, e, arch, key,
+                                                 qmp_hex_length);
+            info->next =3D item_list;
+            item_list =3D info;
+        }
+    }
+
+    return item_list;
+}
diff --git a/qapi/misc.json b/qapi/misc.json
index 8b3ca4fdd3..9d1da7c766 100644
--- a/qapi/misc.json
+++ b/qapi/misc.json
@@ -3051,3 +3051,47 @@
   'data': 'NumaOptions',
   'allow-preconfig': true
 }
+
+##
+# @FirmwareConfigurationItem:
+#
+# Firmware Configuration (fw_cfg) item.
+#
+# @key: The uint16 selector key.
+# @keyname: The stringified name if the selector refers to a well-known
+#           numerically defined item.
+# @architecture_specific: Indicates whether the configuration setting is
+#                         architecture specific.
+#                  false: The item is a generic configuration item.
+#                  true:  The item is specific to a particular architect=
ure.
+# @writeable: Indicates whether the configuration setting is writeable b=
y
+#             the guest.
+# @size: The length of @data associated with the item.
+# @data: A string representating the firmware configuration data.
+#        Note: This field is currently not used.
+# @path: If the key is a 'file', the named file path.
+# @order: If the key is a 'file', the named file order.
+#
+# Since 4.0
+##
+{ 'struct': 'FirmwareConfigurationItem',
+  'data': { 'key': 'uint16',
+            '*keyname': 'str',
+            'architecture_specific': 'bool',
+            'writeable': 'bool',
+            '*data': 'str',
+            'size': 'int',
+            '*path': 'str',
+            '*order': 'int' } }
+
+
+##
+# @query-fw_cfg-items:
+#
+# Returns the list of Firmware Configuration items.
+#
+# Returns: A list of @FirmwareConfigurationItem for each entry.
+#
+# Since 4.0
+##
+{ 'command': 'query-fw_cfg-items', 'returns': ['FirmwareConfigurationIte=
m']}
--=20
2.20.1
