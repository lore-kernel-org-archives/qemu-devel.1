Received: from eggs.gnu.org ([2001:4830:134:3::10]:32912)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dverma@redhat.com>) id 1di0s3-0002Nj-9f
	for qemu-devel@nongnu.org; Wed, 16 Aug 2017 12:08:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dverma@redhat.com>) id 1di0s0-000751-4C
	for qemu-devel@nongnu.org; Wed, 16 Aug 2017 12:08:39 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59182)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dverma@redhat.com>) id 1di0rz-00074o-Qs
	for qemu-devel@nongnu.org; Wed, 16 Aug 2017 12:08:36 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 46B35C05A1DB
	for <qemu-devel@nongnu.org>; Wed, 16 Aug 2017 15:59:38 +0000 (UTC)
From: dverma <dverma@redhat.com>
Date: Wed, 16 Aug 2017 11:59:28 -0400
Message-Id: <1502899168-19852-4-git-send-email-dverma@redhat.com>
In-Reply-To: <1502899168-19852-1-git-send-email-dverma@redhat.com>
References: <1502899168-19852-1-git-send-email-dverma@redhat.com>
Subject: [Qemu-devel] [PATCH v2 3/3] Add new functions for whitelisting and
 their calls
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: jen@redhat.com, dgilbert@redhat.com, quintela@redhat.com, dverma <dverma@redhat.com>

The 'check_updated_properties' function keeps track of properties
that were added/removed from fields across qemu versions. The
'check_updated_sizes' function reduces false positives generated
especially while testing backward migration by keeping a list
of common size/version changes. The 'check_new_sections' function
is used to check for sections that got deprecated or were introduced
in different versions of qemu and will show as false positives while
testing forward migration. Improved the variable names and added
multiple blank newlines to keep Python PEP8 warning away.

Changes v1->v2:
1. Fix patchew warnings about exceeding 80 characters

Signed-off-by: Deepak Verma <dverma@redhat.com>
---
 scripts/vmstate-static-checker.py | 254 ++++++++++++++++++++++++++++++--------
 1 file changed, 200 insertions(+), 54 deletions(-)

diff --git a/scripts/vmstate-static-checker.py b/scripts/vmstate-static-checker.py
index ae41e44..ebcc133 100755
--- a/scripts/vmstate-static-checker.py
+++ b/scripts/vmstate-static-checker.py
@@ -40,6 +40,108 @@ def bump_taint():
     if taint < 255:
         taint = taint + 1
 
+# Sections gain/lose new fields with time.
+# These are not name changes thats handled by another list.
+# These will be 'missing' or 'not found' in different versions of qemu
+
+
+def check_updated_properties(src_desc, field):
+    src_desc = str(src_desc)
+    field = str(field)
+    updated_property = {
+      'ICH9LPC': ['ICH9LPC/smi_feat'],
+      'ide_bus/error': ['retry_sector_num', 'retry_nsector', 'retry_unit'],
+      'e1000': ['e1000/full_mac_state'],
+      'ich9_pm': ['ich9_pm/tco', 'ich9_pm/cpuhp']
+    }
+
+    if src_desc in updated_property and field in updated_property[src_desc]:
+        return True
+
+    return False
+
+
+# A lot of errors are generated due to differences in sizes some of which are
+# false positives. This list is used to save those common changes
+def check_updated_sizes(field, old_size, new_size):
+    new_sizes_list = {
+            'tally_counters.TxOk': [8, 64],
+            'intel-iommu': [0, 1],
+            'iommu-intel': [0, 1]
+            }
+
+    if field not in new_sizes_list:
+        return False
+
+    if(old_size in new_sizes_list[field] and new_size in
+            new_sizes_list[field]):
+        return True
+
+    return False
+
+
+# With time new sections/hardwares supported and old ones are depreciated on
+# chipsets.
+# There is no separate list for new or dead sections as it's relative to which
+# qemu version you compare too.
+# Update this list with such sections.
+# some items in this list might overlap with changed sections names.
+def check_new_sections(sec):
+    new_sections_list = [
+            'virtio-balloon-device',
+            'virtio-rng-device',
+            'virtio-scsi-device',
+            'virtio-blk-device',
+            'virtio-serial-device',
+            'virtio-net-device',
+            'vhost-vsock-device',
+            'virtio-input-host-device',
+            'virtio-input-hid-device',
+            'virtio-mouse-device',
+            'virtio-keyboard-device',
+            'virtio-vga',
+            'virtio-input-device',
+            'virtio-gpu-device',
+            'virtio-tablet-device',
+            'isa-pcspk',
+            'qemu-xhci',
+            'base-xhci',
+            'vmgenid',
+            'intel-iommu',
+            'i8257',
+            'i82801b11-bridge',
+            'ivshmem',
+            'ivshmem-doorbell',
+            'ivshmem-plain',
+            'usb-storage-device',
+            'usb-storage-dev',
+            'pci-qxl',
+            'pci-uhci-usb',
+            'pci-piix3',
+            'pci-vga',
+            'pci-bridge-seat',
+            'pcie-root-port',
+            'fw_cfg_io',
+            'fw_cfg_mem',
+            'exynos4210-ehci-usb',
+            'sysbus-ehci-usb',
+            'tegra2-ehci-usb',
+            'kvm-apic',
+            'fusbh200-ehci-usb',
+            'apic',
+            'apic-common',
+            'xlnx,ps7-usb',
+            'e1000e',
+            'e1000-82544gc',
+            'e1000-82545em']
+
+    if sec in new_sections_list:
+        return True
+
+    return False
+
+# Fields might change name with time across qemu versions.
+
 
 def check_fields_match(name, s_field, d_field):
     if s_field == d_field:
@@ -57,7 +159,7 @@ def check_fields_match(name, s_field, d_field):
         'ioh-3240-express-root-port': ['port.br.dev',
                                        'parent_obj.parent_obj.parent_obj',
                                        'port.br.dev.exp.aer_log',
-                                'parent_obj.parent_obj.parent_obj.exp.aer_log'],
+                            'parent_obj.parent_obj.parent_obj.exp.aer_log'],
         'cirrus_vga': ['hw_cursor_x', 'vga.hw_cursor_x',
                        'hw_cursor_y', 'vga.hw_cursor_y'],
         'lsiscsi': ['dev', 'parent_obj'],
@@ -73,7 +175,8 @@ def check_fields_match(name, s_field, d_field):
                      'tmr.overflow_time', 'ar.tmr.overflow_time',
                      'gpe', 'ar.gpe'],
         'qxl': ['num_surfaces', 'ssd.num_surfaces'],
-        'usb-ccid': ['abProtocolDataStructure', 'abProtocolDataStructure.data'],
+        'usb-ccid': ['abProtocolDataStructure',
+                     'abProtocolDataStructure.data'],
         'usb-host': ['dev', 'parent_obj'],
         'usb-mouse': ['usb-ptr-queue', 'HIDPointerEventQueue'],
         'usb-tablet': ['usb-ptr-queue', 'HIDPointerEventQueue'],
@@ -84,7 +187,7 @@ def check_fields_match(name, s_field, d_field):
         'xio3130-express-downstream-port': ['port.br.dev',
                                             'parent_obj.parent_obj.parent_obj',
                                             'port.br.dev.exp.aer_log',
-                                'parent_obj.parent_obj.parent_obj.exp.aer_log'],
+                            'parent_obj.parent_obj.parent_obj.exp.aer_log'],
         'xio3130-downstream': ['PCIDevice', 'PCIEDevice'],
         'xio3130-express-upstream-port': ['br.dev', 'parent_obj.parent_obj',
                                           'br.dev.exp.aer_log',
@@ -95,7 +198,8 @@ def check_fields_match(name, s_field, d_field):
                       'io_win_addr', 'mig_io_win_addr',
                       'io_win_size', 'mig_io_win_size'],
         'rtl8139': ['dev', 'parent_obj'],
-        'e1000e': ['PCIDevice', 'PCIEDevice', 'intr_state', 'redhat_7_3_intr_state'],
+        'e1000e': ['PCIDevice', 'PCIEDevice', 'intr_state',
+                   'redhat_7_3_intr_state'],
         'nec-usb-xhci': ['PCIDevice', 'PCIEDevice'],
         'xhci-intr': ['er_full_unused', 'er_full'],
         'e1000': ['dev', 'parent_obj',
@@ -225,7 +329,8 @@ def check_fields(src_fields, dest_fields, desc, sec):
                 if unused_count < 0:
                     print('Section "' + sec + '", '
                           'Description "' + desc + '": '
-                          'unused size mismatch near "' + s_item["field"] + '"')
+                          'unused size mismatch near "' +
+                          s_item["field"] + '"')
                     bump_taint()
                     break
                 continue
@@ -238,7 +343,8 @@ def check_fields(src_fields, dest_fields, desc, sec):
                 if unused_count < 0:
                     print('Section "' + sec + '", '
                           'Description "' + desc + '": '
-                          'unused size mismatch near "' + d_item["field"] + '"')
+                          'unused size mismatch near "' + d_item["field"] +
+                          '"')
                     bump_taint()
                     break
                 continue
@@ -286,12 +392,22 @@ def check_fields(src_fields, dest_fields, desc, sec):
                     unused_count = s_item["size"] - d_item["size"]
                     continue
 
-            print('Section "' + sec + '", '
-                  'Description "' + desc + '": '
-                  'expected field "' + s_item["field"] + '", '
-                  'got "' + d_item["field"] + '"; skipping rest')
-            bump_taint()
-            break
+            # commit 20daa90a20d, extra field 'config' was added in newer
+            # releases there will be a mismatch in the number of fields of
+            # irq_state and config it's a known false positive so skip it
+            if (desc in ["PCIDevice", "PCIEDevice"]):
+                if((s_item["field"] in ["irq_state", "config"]) and
+                   (d_item["field"] in ["irq_state", "config"])):
+                    break
+
+            # some fields are new some dead, but are not errors.
+            if not check_fields_match(desc, s_item["field"], d_item["field"]):
+                print('Section "' + sec + '", '
+                      'Description "' + desc + '": '
+                      'expected field "' + s_item["field"] + '", '
+                      'got "' + d_item["field"] + '"; skipping rest')
+                bump_taint()
+                break
 
         check_version(s_item, d_item, sec, desc)
 
@@ -312,7 +428,8 @@ def check_subsections(src_sub, dest_sub, desc, sec):
             found = True
             check_descriptions(s_item, d_item, sec)
 
-        if not found:
+        # check the updated properties list before throwing error
+        if not found and (not check_updated_properties(desc, s_item["name"])):
             print('Section "' + sec + '", '
                   'Description "' + desc + '": '
                   'Subsection "' + s_item["name"] + '" not found')
@@ -343,51 +460,66 @@ def check_descriptions(src_desc, dest_desc, sec):
         bump_taint()
         return
 
-    for f in src_desc:
-        if not f in dest_desc:
-            print('Section "' + sec + '" '
-                  'Description "' + src_desc["name"] + '": '
-                  'Entry "' + field + '" missing')
-            bump_taint()
-            continue
+    for field in src_desc:
+        if field not in dest_desc:
+            # check the updated list of changed properties
+            # before throwing error
+            if check_updated_properties(src_desc["name"], field):
+                continue
+            else:
+                print('Section "' + sec + '" '
+                      'Description "' + src_desc["name"] + '": '
+                      'Entry "' + field + '" missing')
+                bump_taint()
+                continue
 
-        if f == 'Fields':
-            check_fields(src_desc[f], dest_desc[f], src_desc["name"], sec)
+        if field == 'Fields':
+            check_fields(src_desc[field], dest_desc[field],
+                         src_desc["name"], sec)
 
-        if f == 'Subsections':
-            check_subsections(src_desc[f], dest_desc[f], src_desc["name"], sec)
+        if field == 'Subsections':
+            check_subsections(src_desc[field], dest_desc[field],
+                              src_desc["name"], sec)
 
 
-def check_version(s, d, sec, desc=None):
-    if s["version_id"] > d["version_id"]:
-        print "Section \"" + sec + "\"",
-        if desc:
-            print "Description \"" + desc + "\":",
-        print "version error:", s["version_id"], ">", d["version_id"]
-        bump_taint()
+def check_version(src_ver, dest_ver, sec, desc=None):
+    if src_ver["version_id"] > dest_ver["version_id"]:
+        if not check_updated_sizes(sec, src_ver["version_id"],
+                                   dest_ver["version_id"]):
+            print ('Section "' + sec + '"'),
+            if desc:
+                print ('Description "' + desc + '":'),
+            print ('version error: ' + str(src_ver["version_id"]) + ' > ' +
+                   str(dest_ver["version_id"]))
+            bump_taint()
 
     if "minimum_version_id" not in dest_ver:
         return
 
-    if s["version_id"] < d["minimum_version_id"]:
-        print "Section \"" + sec + "\"",
-        if desc:
-            print('Description "' + desc + '": ' +
-                  'minimum version error: ' + str(src_ver["version_id"]) + ' < ' +
-                  str(dest_ver["minimum_version_id"]))
-            bump_taint()
+    if src_ver["version_id"] < dest_ver["minimum_version_id"]:
+        if not check_updated_sizes(sec, src_ver["version_id"],
+                                   dest_ver["minimum_version_id"]):
+            print ('Section "' + sec + '"'),
+            if desc:
+                print('Description "' + desc + '": ' +
+                      'minimum version error: ' + str(src_ver["version_id"]) +
+                      ' < ' + str(dest_ver["minimum_version_id"]))
+                bump_taint()
 
 
-def check_size(s, d, sec, desc=None, field=None):
-    if s["size"] != d["size"]:
-        print "Section \"" + sec + "\"",
-        if desc:
-            print "Description \"" + desc + "\"",
-        if field:
-            print "Field \"" + field + "\"",
-        print "size mismatch:", s["size"], ",", d["size"]
-        bump_taint()
+def check_size(src, dest, sec, desc=None, field=None):
+    if src["size"] != dest["size"]:
+        # check updated sizes list before throwing error
 
+        if not check_updated_sizes(field, src["size"], dest["size"]):
+            print ('Section "' + sec + '"'),
+            if desc:
+                print ('Description "' + desc + '"'),
+            if field:
+                print ('Field "' + field + '"'),
+            print ('size mismatch: ' + str(src["size"]) + ' , ' +
+                   str(dest["size"]))
+            bump_taint()
 
 
 def check_machine_type(src, dest):
@@ -402,8 +534,8 @@ def main():
     "SRC and DEST.  Checks whether migration from SRC to DEST QEMU versions "
     "would break based on the VMSTATE information contained within the JSON "
     "outputs. The JSON output is created from a QEMU invocation with the "
-    "-dump-vmstate parameter and a filename argument to it. Other parameters to "
-    "QEMU do not matter, except the -M (machine type) parameter.")
+    "-dump-vmstate parameter and a filename argument to it. Other parameters "
+    " to QEMU do not matter, except the -M (machine type) parameter.")
 
     parser = argparse.ArgumentParser(description=help_text)
     parser.add_argument('-s', '--src', type=file, required=True,
@@ -428,13 +560,27 @@ def main():
     for sec in src_data:
         dest_sec = sec
         if dest_sec not in dest_data:
-            # Either the section name got changed, or the section
-            # doesn't exist in dest.
+            # Either the section name got changed, or
+            # the section doesn't exist in dest or
+            # section was newly supported.
             dest_sec = get_changed_sec_name(sec)
-            if dest_sec not in dest_data:
-                print('Section "' + sec + '" does not exist in dest')
-                bump_taint()
+            if dest_sec == "":
+                if not check_new_sections(sec):
+                    # section not in newly supported list and not in dest
+                    print('Section "' + sec + '" does not exist in dest')
+                    bump_taint()
                 continue
+            else:
+                # section name changed
+                if dest_sec not in dest_data:
+                    # new name not found in dest.
+                    if check_new_sections(dest_sec):
+                        continue
+                    else:
+                        # new name not in dest and not newly supported
+                        print('Section "' + sec + '" does not exist in dest')
+                        bump_taint()
+                        continue
 
         s = src_data[sec]
         d = dest_data[dest_sec]
-- 
1.8.3.1
