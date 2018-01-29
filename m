Received: from eggs.gnu.org ([2001:4830:134:3::10]:49008)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <brijesh.singh@amd.com>) id 1egDRS-0005Zl-C7
	for qemu-devel@nongnu.org; Mon, 29 Jan 2018 12:42:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <brijesh.singh@amd.com>) id 1egDRO-0003MB-6W
	for qemu-devel@nongnu.org; Mon, 29 Jan 2018 12:42:02 -0500
Received: from mail-dm3nam03on0055.outbound.protection.outlook.com
	([104.47.41.55]:53115
	helo=NAM03-DM3-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <brijesh.singh@amd.com>)
	id 1egDRN-0003LQ-W4
	for qemu-devel@nongnu.org; Mon, 29 Jan 2018 12:41:58 -0500
From: Brijesh Singh <brijesh.singh@amd.com>
Date: Mon, 29 Jan 2018 11:41:15 -0600
Message-Id: <20180129174132.108925-7-brijesh.singh@amd.com>
In-Reply-To: <20180129174132.108925-1-brijesh.singh@amd.com>
References: <20180129174132.108925-1-brijesh.singh@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v6 06/23] machine: add -memory-encryption
 property
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>, Tom Lendacky <Thomas.Lendacky@amd.com>, Peter Maydell <peter.maydell@linaro.org>, Richard Henderson <richard.henderson@linaro.org>, "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Stefan Hajnoczi <stefanha@gmail.com>, Eric Blake <eblake@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>, Brijesh Singh <brijesh.singh@amd.com>, Marcel Apfelbaum <marcel@redhat.com>

When CPU supports memory encryption feature, the property can be used to
specify the encryption object to use when launching an encrypted guest.

Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Eduardo Habkost <ehabkost@redhat.com>
Cc: Marcel Apfelbaum <marcel@redhat.com>
Cc: Stefan Hajnoczi <stefanha@gmail.com>
Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
---
 hw/core/machine.c   | 22 ++++++++++++++++++++++
 include/hw/boards.h |  1 +
 qemu-options.hx     |  2 ++
 3 files changed, 25 insertions(+)

diff --git a/hw/core/machine.c b/hw/core/machine.c
index cdc1163dc6fb..e9940e58ad65 100644
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
index efb0a9edfdf1..8ce9a7a21d3d 100644
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
index 1d73fb151d87..bec3490d7b8d 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -110,6 +110,8 @@ code to send configuration section even if the machine-type sets the
 @option{migration.send-configuration} property to @var{off}.
 NOTE: this parameter is deprecated. Please use @option{-global}
 @option{migration.send-configuration}=@var{on|off} instead.
+@item memory-encryption=@var{}
+Memory encryption object to use. The default is none.
 @end table
 ETEXI
 
-- 
2.9.5
