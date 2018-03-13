Received: from eggs.gnu.org ([2001:4830:134:3::10]:60398)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1evjUV-0001Ax-2P
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 08:57:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1evjUU-0000fc-0Z
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 08:57:19 -0400
Received: from mail-wr0-x241.google.com ([2a00:1450:400c:c0c::241]:33250)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1evjUT-0000f9-PS
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 08:57:17 -0400
Received: by mail-wr0-x241.google.com with SMTP id r8so7234110wrg.0
	for <qemu-devel@nongnu.org>; Tue, 13 Mar 2018 05:57:17 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 13 Mar 2018 13:56:19 +0100
Message-Id: <1520945798-50640-4-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1520945798-50640-1-git-send-email-pbonzini@redhat.com>
References: <1520945798-50640-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 03/22] machine: add memory-encryption option
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Brijesh Singh <brijesh.singh@amd.com>, Eduardo Habkost <ehabkost@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, Stefan Hajnoczi <stefanha@gmail.com>

From: Brijesh Singh <brijesh.singh@amd.com>

When CPU supports memory encryption feature, the property can be used to
specify the encryption object to use when launching an encrypted guest.

Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Eduardo Habkost <ehabkost@redhat.com>
Cc: Marcel Apfelbaum <marcel@redhat.com>
Cc: Stefan Hajnoczi <stefanha@gmail.com>
Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/core/machine.c   | 22 ++++++++++++++++++++++
 include/hw/boards.h |  1 +
 qemu-options.hx     |  5 ++++-
 3 files changed, 27 insertions(+), 1 deletion(-)

diff --git a/hw/core/machine.c b/hw/core/machine.c
index 5e2bbcd..2040177 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -334,6 +334,22 @@ static bool machine_get_enforce_config_section(Object *obj, Error **errp)
     return ms->enforce_config_section;
 }
 
+static char *machine_get_memory_encryption(Object *obj, Error **errp)
+{
+    MachineState *ms = MACHINE(obj);
+
+    return g_strdup(ms->memory_encryption);
+}
+
+static void machine_set_memory_encryption(Object *obj, const char *value,
+                                        Error **errp)
+{
+    MachineState *ms = MACHINE(obj);
+
+    g_free(ms->memory_encryption);
+    ms->memory_encryption = g_strdup(value);
+}
+
 void machine_class_allow_dynamic_sysbus_dev(MachineClass *mc, const char *type)
 {
     strList *item = g_new0(strList, 1);
@@ -612,6 +628,12 @@ static void machine_class_init(ObjectClass *oc, void *data)
         &error_abort);
     object_class_property_set_description(oc, "enforce-config-section",
         "Set on to enforce configuration section migration", &error_abort);
+
+    object_class_property_add_str(oc, "memory-encryption",
+        machine_get_memory_encryption, machine_set_memory_encryption,
+        &error_abort);
+    object_class_property_set_description(oc, "memory-encryption",
+        "Set memory encyption object to use", &error_abort);
 }
 
 static void machine_class_base_init(ObjectClass *oc, void *data)
diff --git a/include/hw/boards.h b/include/hw/boards.h
index efb0a9e..8ce9a7a 100644
--- a/include/hw/boards.h
+++ b/include/hw/boards.h
@@ -243,6 +243,7 @@ struct MachineState {
     bool suppress_vmdesc;
     bool enforce_config_section;
     bool enable_graphics;
+    char *memory_encryption;
 
     ram_addr_t ram_size;
     ram_addr_t maxram_size;
diff --git a/qemu-options.hx b/qemu-options.hx
index 6585058..4c28014 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -43,7 +43,8 @@ DEF("machine", HAS_ARG, QEMU_OPTION_machine, \
     "                suppress-vmdesc=on|off disables self-describing migration (default=off)\n"
     "                nvdimm=on|off controls NVDIMM support (default=off)\n"
     "                enforce-config-section=on|off enforce configuration section migration (default=off)\n"
-    "                s390-squash-mcss=on|off (deprecated) controls support for squashing into default css (default=off)\n",
+    "                s390-squash-mcss=on|off (deprecated) controls support for squashing into default css (default=off)\n"
+    "                memory-encryption=@var{} memory encryption object to use (default=none)\n",
     QEMU_ARCH_ALL)
 STEXI
 @item -machine [type=]@var{name}[,prop=@var{value}[,...]]
@@ -110,6 +111,8 @@ code to send configuration section even if the machine-type sets the
 @option{migration.send-configuration} property to @var{off}.
 NOTE: this parameter is deprecated. Please use @option{-global}
 @option{migration.send-configuration}=@var{on|off} instead.
+@item memory-encryption=@var{}
+Memory encryption object to use. The default is none.
 @end table
 ETEXI
 
-- 
1.8.3.1
