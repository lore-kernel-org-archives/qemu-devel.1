Received: from eggs.gnu.org ([2001:4830:134:3::10]:41998)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richiejp@f-m.fm>) id 1eYA0F-0005us-KS
	for qemu-devel@nongnu.org; Sun, 07 Jan 2018 07:24:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richiejp@f-m.fm>) id 1eYA0C-0006tp-Ea
	for qemu-devel@nongnu.org; Sun, 07 Jan 2018 07:24:39 -0500
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:34781)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <richiejp@f-m.fm>) id 1eYA0C-0006rb-5y
	for qemu-devel@nongnu.org; Sun, 07 Jan 2018 07:24:36 -0500
From: Richard Palethorpe <richiejp@f-m.fm>
Date: Sun,  7 Jan 2018 13:23:35 +0100
Message-Id: <20180107122336.29333-1-richiejp@f-m.fm>
Subject: [Qemu-devel] [PATCH 1/2] Add save-snapshot,
 load-snapshot and delete-snapshot to QAPI
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: quintela@redhat.com, dgilbert@redhat.com, eblake@redhat.com, armbru@redhat.com, rpalethorpe@suse.com, Richard Palethorpe <richiejp@f-m.fm>

Add QAPI wrapper functions for the existing snapshot functionality. These
functions behave the same way as the HMP savevm, loadvm and delvm
commands. This will allow applications, such as OpenQA, to programmatically
revert the VM to a previous state with no dependence on HMP or qemu-img.

I used the term snapshot instead of VM because I think it is less ambiguous
and matches the internal function names.

Signed-off-by: Richard Palethorpe <richiejp@f-m.fm>
---
 migration/savevm.c | 27 ++++++++++++++++++++++
 qapi-schema.json   | 66 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 93 insertions(+)

diff --git a/migration/savevm.c b/migration/savevm.c
index b7908f62be..d7bc0f0d41 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -2242,6 +2242,11 @@ int save_snapshot(const char *name, Error **errp)
     return ret;
 }
 
+void qmp_save_snapshot(const char *name, Error **errp)
+{
+    save_snapshot(name, errp);
+}
+
 void qmp_xen_save_devices_state(const char *filename, bool has_live, bool live,
                                 Error **errp)
 {
@@ -2404,6 +2409,28 @@ err_drain:
     return ret;
 }
 
+void qmp_load_snapshot(const char *name, Error **errp)
+{
+    int saved_vm_running = runstate_is_running();
+
+    vm_stop(RUN_STATE_RESTORE_VM);
+
+    if (!load_snapshot(name, errp) && saved_vm_running) {
+        vm_start();
+    }
+}
+
+void qmp_delete_snapshot(const char *name, Error **errp)
+{
+    BlockDriverState *bs;
+
+    if (bdrv_all_delete_snapshot(name, &bs, errp) < 0) {
+        error_prepend(errp,
+                      "Error while deleting snapshot on device '%s': ",
+                      bdrv_get_device_name(bs));
+    }
+}
+
 void vmstate_register_ram(MemoryRegion *mr, DeviceState *dev)
 {
     qemu_ram_set_idstr(mr->ram_block,
diff --git a/qapi-schema.json b/qapi-schema.json
index 5c06745c79..906f7c1f74 100644
--- a/qapi-schema.json
+++ b/qapi-schema.json
@@ -1125,6 +1125,72 @@
 { 'command': 'pmemsave',
   'data': {'val': 'int', 'size': 'int', 'filename': 'str'} }
 
+##
+# @save-snapshot:
+#
+# Save a snapshot of the entire Virtual Machine
+#
+# @name: A string identifying the snapshot. This can later be used with
+#        @load-snapshot or @delete-snapshot
+#
+# Since: 2.12.0
+#
+# Returns: If successful, nothing
+#
+# Notes: The equivalent HMP command is savevm. This stores all of the virtual
+#        machine's current state within the virtual machine's
+#        image(s)/storage. If the VM is currently running, this includes the
+#        state of the CPU and RAM. Later the VM can be reverted to this state.
+#
+#        qemu-img can also be used to manipulate snapshots.
+#
+# Examples:
+#
+# -> { "execute": "save-snapshot", "arguments": { "name": "lastgood" } }
+# <- { "return": {} }
+##
+{ 'command': 'save-snapshot',
+  'data': {'name': 'str'} }
+
+##
+# @load-snapshot:
+#
+# Load a snapshot of the entire Virtual Machine, completely reverting it to
+# that state
+#
+# Since: 2.12.0
+#
+# Returns: If successful, nothing
+#
+# Notes: The equivalent HMP command is loadvm. See the @save-snapshot notes.
+#
+# Examples:
+#
+# -> { "execute": "load-snapshot", "arguments": { "name": "lastgood" } }
+# <- { "return": {} }
+##
+{ 'command': 'load-snapshot',
+  'data': {'name': 'str'} }
+
+##
+# @delete-snapshot:
+#
+# Delete a VM snapshot
+#
+# Since: 2.12.0
+#
+# Returns: If successful, nothing
+#
+# Notes: The equivalent HMP command is delvm. See the @save-snapshot notes.
+#
+# Examples:
+#
+# -> { "execute": "delete-snapshot", "arguments": { "name": "lastgood" } }
+# <- { "return": {} }
+##
+{ 'command': 'delete-snapshot',
+  'data': {'name': 'str'} }
+
 ##
 # @cont:
 #
-- 
2.15.1
