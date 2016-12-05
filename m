Received: from eggs.gnu.org ([2001:4830:134:3::10]:57275)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1cE2kb-0002qk-0A
	for qemu-devel@nongnu.org; Mon, 05 Dec 2016 18:32:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1cE2kZ-00062H-G3
	for qemu-devel@nongnu.org; Mon, 05 Dec 2016 18:32:49 -0500
Received: from mx1.redhat.com ([209.132.183.28]:48556)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1cE2kZ-00061z-7g
	for qemu-devel@nongnu.org; Mon, 05 Dec 2016 18:32:47 -0500
Received: from int-mx10.intmail.prod.int.phx2.redhat.com
	(int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 66A98C0AC361
	for <qemu-devel@nongnu.org>; Mon,  5 Dec 2016 23:32:46 +0000 (UTC)
From: Igor Mammedov <imammedo@redhat.com>
Date: Tue,  6 Dec 2016 00:32:29 +0100
Message-Id: <1480980749-182204-11-git-send-email-imammedo@redhat.com>
In-Reply-To: <1480980749-182204-1-git-send-email-imammedo@redhat.com>
References: <1480980749-182204-1-git-send-email-imammedo@redhat.com>
Subject: [Qemu-devel] [PATCH for-2.9 10/10] memhp: move DIMM devices into
 dedicated scope with related common methods
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>

Move DIMM devices from global _SB scope to a new \_SB.MHPC
container along with common methods used by DIMMs:
  MCRS, MRST, MPXM, MOST, MEJ00, MSCN, MTFY

this reduces AML size on 12 * #slots bytes,
i.e. up to 3072 bytes for 265 slots.

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
---
 hw/acpi/memory_hotplug.c | 190 ++++++++++++++++++++++++-----------------------
 1 file changed, 97 insertions(+), 93 deletions(-)

diff --git a/hw/acpi/memory_hotplug.c b/hw/acpi/memory_hotplug.c
index fb04d24..210073d 100644
--- a/hw/acpi/memory_hotplug.c
+++ b/hw/acpi/memory_hotplug.c
@@ -31,6 +31,7 @@
 #define MEMORY_SLOT_SCAN_METHOD      "MSCN"
 #define MEMORY_HOTPLUG_DEVICE        "MHPD"
 #define MEMORY_HOTPLUG_IO_LEN         24
+#define MEMORY_DEVICES_CONTAINER     "\\_SB.MHPC"
 
 static uint16_t memhp_io_base;
 
@@ -343,9 +344,8 @@ void build_memory_hotplug_aml(Aml *table, uint32_t nr_mem,
     int i;
     Aml *ifctx;
     Aml *method;
-    Aml *sb_scope;
+    Aml *dev_container;
     Aml *mem_ctrl_dev;
-    char *scan_path;
     char *mhp_res_path;
 
     if (!memhp_io_base) {
@@ -356,24 +356,11 @@ void build_memory_hotplug_aml(Aml *table, uint32_t nr_mem,
     mem_ctrl_dev = aml_device("%s", mhp_res_path);
     {
         Aml *crs;
-        Aml *field;
-        Aml *one = aml_int(1);
-        Aml *zero = aml_int(0);
-        Aml *ret_val = aml_local(0);
-        Aml *slot_arg0 = aml_arg(0);
-        Aml *slots_nr = aml_name(MEMORY_SLOTS_NUMBER);
-        Aml *ctrl_lock = aml_name(MEMORY_SLOT_LOCK);
-        Aml *slot_selector = aml_name(MEMORY_SLOT_SLECTOR);
 
         aml_append(mem_ctrl_dev, aml_name_decl("_HID", aml_string("PNP0A06")));
         aml_append(mem_ctrl_dev,
             aml_name_decl("_UID", aml_string("Memory hotplug resources")));
 
-        assert(nr_mem <= ACPI_MAX_RAM_SLOTS);
-        aml_append(mem_ctrl_dev,
-            aml_name_decl(MEMORY_SLOTS_NUMBER, aml_int(nr_mem))
-        );
-
         crs = aml_resource_template();
         aml_append(crs,
             aml_io(AML_DECODE16, memhp_io_base, memhp_io_base, 0,
@@ -386,7 +373,32 @@ void build_memory_hotplug_aml(Aml *table, uint32_t nr_mem,
             aml_int(memhp_io_base), MEMORY_HOTPLUG_IO_LEN)
         );
 
-        field = aml_field(MEMORY_HOTPLUG_IO_REGION, AML_DWORD_ACC,
+    }
+    aml_append(table, mem_ctrl_dev);
+
+    dev_container = aml_device(MEMORY_DEVICES_CONTAINER);
+    {
+        Aml *field;
+        Aml *one = aml_int(1);
+        Aml *zero = aml_int(0);
+        Aml *ret_val = aml_local(0);
+        Aml *slot_arg0 = aml_arg(0);
+        Aml *slots_nr = aml_name(MEMORY_SLOTS_NUMBER);
+        Aml *ctrl_lock = aml_name(MEMORY_SLOT_LOCK);
+        Aml *slot_selector = aml_name(MEMORY_SLOT_SLECTOR);
+        char *mmio_path = g_strdup_printf("%s." MEMORY_HOTPLUG_IO_REGION,
+                                          mhp_res_path);
+
+        aml_append(dev_container, aml_name_decl("_HID", aml_string("PNP0A06")));
+        aml_append(dev_container,
+            aml_name_decl("_UID", aml_string("DIMM devices")));
+
+        assert(nr_mem <= ACPI_MAX_RAM_SLOTS);
+        aml_append(dev_container,
+            aml_name_decl(MEMORY_SLOTS_NUMBER, aml_int(nr_mem))
+        );
+
+        field = aml_field(mmio_path, AML_DWORD_ACC,
                           AML_NOLOCK, AML_PRESERVE);
         aml_append(field, /* read only */
             aml_named_field(MEMORY_SLOT_ADDR_LOW, 32));
@@ -398,9 +410,9 @@ void build_memory_hotplug_aml(Aml *table, uint32_t nr_mem,
             aml_named_field(MEMORY_SLOT_SIZE_HIGH, 32));
         aml_append(field, /* read only */
             aml_named_field(MEMORY_SLOT_PROXIMITY, 32));
-        aml_append(mem_ctrl_dev, field);
+        aml_append(dev_container, field);
 
-        field = aml_field(MEMORY_HOTPLUG_IO_REGION, AML_BYTE_ACC,
+        field = aml_field(mmio_path, AML_BYTE_ACC,
                           AML_NOLOCK, AML_WRITE_AS_ZEROS);
         aml_append(field, aml_reserved_field(160 /* bits, Offset(20) */));
         aml_append(field, /* 1 if enabled, read only */
@@ -414,9 +426,9 @@ void build_memory_hotplug_aml(Aml *table, uint32_t nr_mem,
         aml_append(field,
             /* initiates device eject, write only */
             aml_named_field(MEMORY_SLOT_EJECT, 1));
-        aml_append(mem_ctrl_dev, field);
+        aml_append(dev_container, field);
 
-        field = aml_field(MEMORY_HOTPLUG_IO_REGION, AML_DWORD_ACC,
+        field = aml_field(mmio_path, AML_DWORD_ACC,
                           AML_NOLOCK, AML_PRESERVE);
         aml_append(field, /* DIMM selector, write only */
             aml_named_field(MEMORY_SLOT_SLECTOR, 32));
@@ -424,7 +436,8 @@ void build_memory_hotplug_aml(Aml *table, uint32_t nr_mem,
             aml_named_field(MEMORY_SLOT_OST_EVENT, 32));
         aml_append(field, /* _OST status code, write only */
             aml_named_field(MEMORY_SLOT_OST_STATUS, 32));
-        aml_append(mem_ctrl_dev, field);
+        aml_append(dev_container, field);
+        g_free(mmio_path);
 
         method = aml_method("_STA", 0, AML_NOTSERIALIZED);
         ifctx = aml_if(aml_equal(slots_nr, zero));
@@ -434,9 +447,9 @@ void build_memory_hotplug_aml(Aml *table, uint32_t nr_mem,
         aml_append(method, ifctx);
         /* present, functioning, decoding, not shown in UI */
         aml_append(method, aml_return(aml_int(0xB)));
-        aml_append(mem_ctrl_dev, method);
+        aml_append(dev_container, method);
 
-        aml_append(mem_ctrl_dev, aml_mutex(MEMORY_SLOT_LOCK, 0));
+        aml_append(dev_container, aml_mutex(MEMORY_SLOT_LOCK, 0));
 
         method = aml_method(MEMORY_SLOT_SCAN_METHOD, 0, AML_NOTSERIALIZED);
         {
@@ -492,7 +505,7 @@ void build_memory_hotplug_aml(Aml *table, uint32_t nr_mem,
             aml_append(method, aml_release(ctrl_lock));
             aml_append(method, aml_return(one));
         }
-        aml_append(mem_ctrl_dev, method);
+        aml_append(dev_container, method);
 
         method = aml_method(MEMORY_SLOT_STATUS_METHOD, 1, AML_NOTSERIALIZED);
         {
@@ -512,7 +525,7 @@ void build_memory_hotplug_aml(Aml *table, uint32_t nr_mem,
             aml_append(method, aml_release(ctrl_lock));
             aml_append(method, aml_return(ret_val));
         }
-        aml_append(mem_ctrl_dev, method);
+        aml_append(dev_container, method);
 
         method = aml_method(MEMORY_SLOT_CRS_METHOD, 1, AML_SERIALIZED);
         {
@@ -603,7 +616,7 @@ void build_memory_hotplug_aml(Aml *table, uint32_t nr_mem,
             aml_append(method, aml_release(ctrl_lock));
             aml_append(method, aml_return(mr64));
         }
-        aml_append(mem_ctrl_dev, method);
+        aml_append(dev_container, method);
 
         method = aml_method(MEMORY_SLOT_PROXIMITY_METHOD, 1,
                             AML_NOTSERIALIZED);
@@ -617,7 +630,7 @@ void build_memory_hotplug_aml(Aml *table, uint32_t nr_mem,
             aml_append(method, aml_release(ctrl_lock));
             aml_append(method, aml_return(ret_val));
         }
-        aml_append(mem_ctrl_dev, method);
+        aml_append(dev_container, method);
 
         method = aml_method(MEMORY_SLOT_OST_METHOD, 4, AML_NOTSERIALIZED);
         {
@@ -631,7 +644,7 @@ void build_memory_hotplug_aml(Aml *table, uint32_t nr_mem,
             aml_append(method, aml_store(aml_arg(2), ost_status));
             aml_append(method, aml_release(ctrl_lock));
         }
-        aml_append(mem_ctrl_dev, method);
+        aml_append(dev_container, method);
 
         method = aml_method(MEMORY_SLOT_EJECT_METHOD, 2, AML_NOTSERIALIZED);
         {
@@ -643,75 +656,66 @@ void build_memory_hotplug_aml(Aml *table, uint32_t nr_mem,
             aml_append(method, aml_store(one, eject));
             aml_append(method, aml_release(ctrl_lock));
         }
-        aml_append(mem_ctrl_dev, method);
-    }
-    aml_append(table, mem_ctrl_dev);
-
-    sb_scope = aml_scope("_SB");
-    /* build memory devices */
-    for (i = 0; i < nr_mem; i++) {
-        Aml *dev;
-        char *s;
-
-        dev = aml_device("MP%02X", i);
-        aml_append(dev, aml_name_decl("_UID", aml_string("0x%02X", i)));
-        aml_append(dev, aml_name_decl("_HID", aml_eisaid("PNP0C80")));
-
-        method = aml_method("_CRS", 0, AML_NOTSERIALIZED);
-        s = g_strdup_printf("%s.%s", mhp_res_path, MEMORY_SLOT_CRS_METHOD);
-        aml_append(method, aml_return(aml_call1(s, aml_name("_UID"))));
-        g_free(s);
-        aml_append(dev, method);
-
-        method = aml_method("_STA", 0, AML_NOTSERIALIZED);
-        s = g_strdup_printf("%s.%s", mhp_res_path, MEMORY_SLOT_STATUS_METHOD);
-        aml_append(method, aml_return(aml_call1(s, aml_name("_UID"))));
-        g_free(s);
-        aml_append(dev, method);
-
-        method = aml_method("_PXM", 0, AML_NOTSERIALIZED);
-        s = g_strdup_printf("%s.%s", mhp_res_path,
-                            MEMORY_SLOT_PROXIMITY_METHOD);
-        aml_append(method, aml_return(aml_call1(s, aml_name("_UID"))));
-        g_free(s);
-        aml_append(dev, method);
-
-        method = aml_method("_OST", 3, AML_NOTSERIALIZED);
-        s = g_strdup_printf("%s.%s", mhp_res_path, MEMORY_SLOT_OST_METHOD);
-        aml_append(method, aml_return(aml_call4(
-            s, aml_name("_UID"), aml_arg(0), aml_arg(1), aml_arg(2)
-        )));
-        g_free(s);
-        aml_append(dev, method);
-
-        method = aml_method("_EJ0", 1, AML_NOTSERIALIZED);
-        s = g_strdup_printf("%s.%s", mhp_res_path, MEMORY_SLOT_EJECT_METHOD);
-        aml_append(method, aml_return(aml_call2(
-                   s, aml_name("_UID"), aml_arg(0))));
-        g_free(s);
-        aml_append(dev, method);
-
-        aml_append(sb_scope, dev);
-    }
+        aml_append(dev_container, method);
+
+        /* build memory devices */
+        for (i = 0; i < nr_mem; i++) {
+            Aml *dev;
+            const char *s;
+
+            dev = aml_device("MP%02X", i);
+            aml_append(dev, aml_name_decl("_UID", aml_string("0x%02X", i)));
+            aml_append(dev, aml_name_decl("_HID", aml_eisaid("PNP0C80")));
+
+            method = aml_method("_CRS", 0, AML_NOTSERIALIZED);
+            s = MEMORY_SLOT_CRS_METHOD;
+            aml_append(method, aml_return(aml_call1(s, aml_name("_UID"))));
+            aml_append(dev, method);
+
+            method = aml_method("_STA", 0, AML_NOTSERIALIZED);
+            s = MEMORY_SLOT_STATUS_METHOD;
+            aml_append(method, aml_return(aml_call1(s, aml_name("_UID"))));
+            aml_append(dev, method);
+
+            method = aml_method("_PXM", 0, AML_NOTSERIALIZED);
+            s = MEMORY_SLOT_PROXIMITY_METHOD;
+            aml_append(method, aml_return(aml_call1(s, aml_name("_UID"))));
+            aml_append(dev, method);
+
+            method = aml_method("_OST", 3, AML_NOTSERIALIZED);
+            s = MEMORY_SLOT_OST_METHOD;
+            aml_append(method, aml_return(aml_call4(
+                s, aml_name("_UID"), aml_arg(0), aml_arg(1), aml_arg(2)
+            )));
+            aml_append(dev, method);
+
+            method = aml_method("_EJ0", 1, AML_NOTSERIALIZED);
+            s = MEMORY_SLOT_EJECT_METHOD;
+            aml_append(method, aml_return(aml_call2(
+                       s, aml_name("_UID"), aml_arg(0))));
+            aml_append(dev, method);
+
+            aml_append(dev_container, dev);
+        }
 
-    /* build Method(MEMORY_SLOT_NOTIFY_METHOD, 2) {
-     *     If (LEqual(Arg0, 0x00)) {Notify(MP00, Arg1)} ... }
-     */
-    method = aml_method(MEMORY_SLOT_NOTIFY_METHOD, 2, AML_NOTSERIALIZED);
-    for (i = 0; i < nr_mem; i++) {
-        ifctx = aml_if(aml_equal(aml_arg(0), aml_int(i)));
-        aml_append(ifctx,
-            aml_notify(aml_name("MP%.02X", i), aml_arg(1))
-        );
-        aml_append(method, ifctx);
+        /* build Method(MEMORY_SLOT_NOTIFY_METHOD, 2) {
+         *     If (LEqual(Arg0, 0x00)) {Notify(MP00, Arg1)} ... }
+         */
+        method = aml_method(MEMORY_SLOT_NOTIFY_METHOD, 2, AML_NOTSERIALIZED);
+        for (i = 0; i < nr_mem; i++) {
+            ifctx = aml_if(aml_equal(aml_arg(0), aml_int(i)));
+            aml_append(ifctx,
+                aml_notify(aml_name("MP%.02X", i), aml_arg(1))
+            );
+            aml_append(method, ifctx);
+        }
+        aml_append(dev_container, method);
     }
-    aml_append(sb_scope, method);
-    aml_append(table, sb_scope);
+    aml_append(table, dev_container);
 
     method = aml_method(event_handler_method, 0, AML_NOTSERIALIZED);
-    scan_path = g_strdup_printf("%s.%s", mhp_res_path, MEMORY_SLOT_SCAN_METHOD);
-    aml_append(method, aml_call0(scan_path));
-    g_free(scan_path);
+    aml_append(method,
+        aml_call0(MEMORY_DEVICES_CONTAINER "." MEMORY_SLOT_SCAN_METHOD));
     aml_append(table, method);
 
     g_free(mhp_res_path);
-- 
2.7.4
