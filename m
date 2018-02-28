Received: from eggs.gnu.org ([2001:4830:134:3::10]:52953)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <brijesh.singh@amd.com>) id 1er90A-0001CO-In
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 16:11:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <brijesh.singh@amd.com>) id 1er907-0005ZU-2u
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 16:11:02 -0500
Received: from mail-sn1nam02on0055.outbound.protection.outlook.com
	([104.47.36.55]:37280
	helo=NAM02-SN1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <brijesh.singh@amd.com>)
	id 1er906-0005WK-Gf
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 16:10:58 -0500
From: Brijesh Singh <brijesh.singh@amd.com>
Date: Wed, 28 Feb 2018 15:10:05 -0600
Message-Id: <20180228211028.83970-6-brijesh.singh@amd.com>
In-Reply-To: <20180228211028.83970-1-brijesh.singh@amd.com>
References: <20180228211028.83970-1-brijesh.singh@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v10 05/28] machine: add -memory-encryption
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
Cc: Alistair Francis <alistair.francis@xilinx.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, "Daniel P . Berrange" <berrange@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>, Eduardo Habkost <ehabkost@redhat.com>, Eric Blake <eblake@redhat.com>, kvm@vger.kernel.org, Marcel Apfelbaum <marcel@redhat.com>, Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Peter Maydell <peter.maydell@linaro.org>, Richard Henderson <richard.henderson@linaro.org>, Stefan Hajnoczi <stefanha@gmail.com>, Thomas Lendacky <Thomas.Lendacky@amd.com>, Borislav Petkov <bp@suse.de>, Alexander Graf <agraf@suse.de>, Bruce Rogers <brogers@suse.com>, Brijesh Singh <brijesh.singh@amd.com>

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
 qemu-options.hx     |  5 ++++-
 3 files changed, 27 insertions(+), 1 deletion(-)

diff --git a/hw/core/machine.c b/hw/core/machine.c
index 5d445839e89e..414e6e71092d 100644
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
index 8ccd5dcaa61d..a6648ca073f2 100644
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
2.14.3
