Received: from eggs.gnu.org ([2001:4830:134:3::10]:45112)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1eS1pM-0006n0-1z
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 09:28:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1eS1pK-0004oo-HA
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 09:28:04 -0500
Received: from mx1.redhat.com ([209.132.183.28]:51158)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1eS1pK-0004oM-7E
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 09:28:02 -0500
Date: Thu, 21 Dec 2017 16:27:58 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <1513866427-27125-2-git-send-email-mst@redhat.com>
References: <1513866427-27125-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1513866427-27125-1-git-send-email-mst@redhat.com>
Subject: [Qemu-devel] [PULL 01/25] smbios: support setting OEM strings table
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, "Daniel P. Berrange" <berrange@redhat.com>, Igor Mammedov <imammedo@redhat.com>

From: "Daniel P. Berrange" <berrange@redhat.com>

The cloud-init program currently allows fetching of its data by repurposing of
the 'system' type 'serial' field. This is a clear abuse of the serial field that
would clash with other valid usage a virt management app might have for that
field.

Fortunately the SMBIOS defines an "OEM Strings" table whose puporse is to allow
exposing of arbitrary vendor specific strings to the operating system. This is
perfect for use with cloud-init, or as a way to pass arguments to OS installers
such as anaconda.

This patch makes it easier to support this with QEMU. e.g.

  $QEMU -smbios type=11,value=Hello,value=World,value=Tricky,,value=test

Which results in the guest seeing dmidecode data

  Handle 0x0E00, DMI type 11, 5 bytes
  OEM Strings
          String 1: Hello
          String 2: World
          String 3: Tricky,value=test

It is suggested that any app wanting to make use of this OEM strings capability
for accepting data from the host mgmt layer should use its name as a string
prefix. e.g. to expose OEM strings targetting both cloud init and anaconda in
parallel the mgmt app could set

  $QEMU -smbios type=11,value=cloud-init:ds=nocloud-net;s=http://10.10.0.1:8000/,\
        value=anaconda:method=http://dl.fedoraproject.org/pub/fedora/linux/releases/25/x86_64/os

which would appear as

  Handle 0x0E00, DMI type 11, 5 bytes
  OEM Strings
          String 1: cloud-init:ds=nocloud-net;s=http://10.10.0.1:8000/
          String 2: anaconda:method=http://dl.fedoraproject.org/pub/fedora/linux/releases/25/x86_64/os

Use of such string prefixes means the app won't have to care which string slot
its data appears in.

Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/smbios/smbios_build.h   | 12 ++++++++
 include/hw/smbios/smbios.h |  6 ++++
 hw/smbios/smbios.c         | 72 ++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 90 insertions(+)

diff --git a/hw/smbios/smbios_build.h b/hw/smbios/smbios_build.h
index 68b8b72..93b360d 100644
--- a/hw/smbios/smbios_build.h
+++ b/hw/smbios/smbios_build.h
@@ -63,6 +63,18 @@ extern unsigned smbios_table_cnt;
         }                                                                 \
     } while (0)
 
+#define SMBIOS_TABLE_SET_STR_LIST(tbl_type, value)                        \
+    do {                                                                  \
+        int len = (value != NULL) ? strlen(value) + 1 : 0;                \
+        if (len > 1) {                                                    \
+            smbios_tables = g_realloc(smbios_tables,                      \
+                                      smbios_tables_len + len);           \
+            memcpy(smbios_tables + smbios_tables_len, value, len);        \
+            smbios_tables_len += len;                                     \
+            ++str_index;                                                  \
+        }                                                                 \
+    } while (0)
+
 #define SMBIOS_BUILD_TABLE_POST                                           \
     do {                                                                  \
         size_t term_cnt, t_size;                                          \
diff --git a/include/hw/smbios/smbios.h b/include/hw/smbios/smbios.h
index 31e8d5f..a83adb9 100644
--- a/include/hw/smbios/smbios.h
+++ b/include/hw/smbios/smbios.h
@@ -195,6 +195,12 @@ struct smbios_type_4 {
     uint16_t processor_family2;
 } QEMU_PACKED;
 
+/* SMBIOS type 11 - OEM strings */
+struct smbios_type_11 {
+    struct smbios_structure_header header;
+    uint8_t count;
+} QEMU_PACKED;
+
 /* SMBIOS type 16 - Physical Memory Array (v2.7) */
 struct smbios_type_16 {
     struct smbios_structure_header header;
diff --git a/hw/smbios/smbios.c b/hw/smbios/smbios.c
index 1a5437a..5d11f01 100644
--- a/hw/smbios/smbios.c
+++ b/hw/smbios/smbios.c
@@ -96,6 +96,11 @@ static struct {
 } type4;
 
 static struct {
+    size_t nvalues;
+    const char **values;
+} type11;
+
+static struct {
     const char *loc_pfx, *bank, *manufacturer, *serial, *asset, *part;
     uint16_t speed;
 } type17;
@@ -282,6 +287,14 @@ static const QemuOptDesc qemu_smbios_type4_opts[] = {
     { /* end of list */ }
 };
 
+static const QemuOptDesc qemu_smbios_type11_opts[] = {
+    {
+        .name = "value",
+        .type = QEMU_OPT_STRING,
+        .help = "OEM string data",
+    },
+};
+
 static const QemuOptDesc qemu_smbios_type17_opts[] = {
     {
         .name = "type",
@@ -590,6 +603,27 @@ static void smbios_build_type_4_table(unsigned instance)
     smbios_type4_count++;
 }
 
+static void smbios_build_type_11_table(void)
+{
+    char count_str[128];
+    size_t i;
+
+    if (type11.nvalues == 0) {
+        return;
+    }
+
+    SMBIOS_BUILD_TABLE_PRE(11, 0xe00, true); /* required */
+
+    snprintf(count_str, sizeof(count_str), "%zu", type11.nvalues);
+    t->count = type11.nvalues;
+
+    for (i = 0; i < type11.nvalues; i++) {
+        SMBIOS_TABLE_SET_STR_LIST(11, type11.values[i]);
+    }
+
+    SMBIOS_BUILD_TABLE_POST;
+}
+
 #define ONE_KB ((ram_addr_t)1 << 10)
 #define ONE_MB ((ram_addr_t)1 << 20)
 #define ONE_GB ((ram_addr_t)1 << 30)
@@ -832,6 +866,8 @@ void smbios_get_tables(const struct smbios_phys_mem_area *mem_array,
             smbios_build_type_4_table(i);
         }
 
+        smbios_build_type_11_table();
+
 #define MAX_DIMM_SZ (16ll * ONE_GB)
 #define GET_DIMM_SZ ((i < dimm_cnt - 1) ? MAX_DIMM_SZ \
                                         : ((ram_size - 1) % MAX_DIMM_SZ) + 1)
@@ -882,6 +918,38 @@ static void save_opt(const char **dest, QemuOpts *opts, const char *name)
     }
 }
 
+
+struct opt_list {
+    const char *name;
+    size_t *ndest;
+    const char ***dest;
+};
+
+static int save_opt_one(void *opaque,
+                        const char *name, const char *value,
+                        Error **errp)
+{
+    struct opt_list *opt = opaque;
+
+    if (!g_str_equal(name, opt->name)) {
+        return 0;
+    }
+
+    *opt->dest = g_renew(const char *, *opt->dest, (*opt->ndest) + 1);
+    (*opt->dest)[*opt->ndest] = value;
+    (*opt->ndest)++;
+    return 0;
+}
+
+static void save_opt_list(size_t *ndest, const char ***dest,
+                          QemuOpts *opts, const char *name)
+{
+    struct opt_list opt = {
+        name, ndest, dest,
+    };
+    qemu_opt_foreach(opts, save_opt_one, &opt, NULL);
+}
+
 void smbios_entry_add(QemuOpts *opts, Error **errp)
 {
     const char *val;
@@ -1035,6 +1103,10 @@ void smbios_entry_add(QemuOpts *opts, Error **errp)
             save_opt(&type4.asset, opts, "asset");
             save_opt(&type4.part, opts, "part");
             return;
+        case 11:
+            qemu_opts_validate(opts, qemu_smbios_type11_opts, &error_fatal);
+            save_opt_list(&type11.nvalues, &type11.values, opts, "value");
+            return;
         case 17:
             qemu_opts_validate(opts, qemu_smbios_type17_opts, &error_fatal);
             save_opt(&type17.loc_pfx, opts, "loc_pfx");
-- 
MST
