Received: from eggs.gnu.org ([2001:4830:134:3::10]:49622)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <brijesh.singh@amd.com>) id 1eMfvi-0005r6-BX
	for qemu-devel@nongnu.org; Wed, 06 Dec 2017 15:04:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <brijesh.singh@amd.com>) id 1eMfvf-0002Ri-5S
	for qemu-devel@nongnu.org; Wed, 06 Dec 2017 15:04:30 -0500
Received: from mail-dm3nam03on0084.outbound.protection.outlook.com
	([104.47.41.84]:45015
	helo=NAM03-DM3-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <brijesh.singh@amd.com>)
	id 1eMfve-0002RD-V3
	for qemu-devel@nongnu.org; Wed, 06 Dec 2017 15:04:27 -0500
From: Brijesh Singh <brijesh.singh@amd.com>
Date: Wed,  6 Dec 2017 14:03:29 -0600
Message-Id: <20171206200346.116537-7-brijesh.singh@amd.com>
In-Reply-To: <20171206200346.116537-1-brijesh.singh@amd.com>
References: <20171206200346.116537-1-brijesh.singh@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v5 06/23] machine: add -memory-encryption
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
Cc: Alistair Francis <alistair.francis@xilinx.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, "Daniel P . Berrange" <berrange@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, "Edgar E . Iglesias " <edgar.iglesias@xilinx.com>, Eduardo Habkost <ehabkost@redhat.com>, Eric Blake <eblake@redhat.com>, kvm@vger.kernel.org, Marcel Apfelbaum <marcel@redhat.com>, Markus Armbruster <armbru@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Peter Maydell <peter.maydell@linaro.org>, Richard Henderson <richard.henderson@linaro.org>, Richard Henderson <rth@twiddle.net>, Stefan Hajnoczi <stefanha@gmail.com>, Thomas Lendacky <Thomas.Lendacky@amd.com>, Borislav Petkov <bp@suse.de>, Brijesh Singh <brijesh.singh@amd.com>

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
index 36c2fb069c01..132c57bc5124 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -335,6 +335,22 @@ static bool machine_get_enforce_config_section(Object *obj, Error **errp)
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
 static void error_on_sysbus_device(SysBusDevice *sbdev, void *opaque)
 {
     error_report("Option '-device %s' cannot be handled by this machine",
@@ -598,6 +614,12 @@ static void machine_class_init(ObjectClass *oc, void *data)
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
index 156b16f7a6b5..41fa5779557c 100644
--- a/include/hw/boards.h
+++ b/include/hw/boards.h
@@ -238,6 +238,7 @@ struct MachineState {
     bool suppress_vmdesc;
     bool enforce_config_section;
     bool enable_graphics;
+    char *memory_encryption;
 
     ram_addr_t ram_size;
     ram_addr_t maxram_size;
diff --git a/qemu-options.hx b/qemu-options.hx
index f11c4ac960ff..5385832707e0 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -104,6 +104,8 @@ code to send configuration section even if the machine-type sets the
 @option{migration.send-configuration} property to @var{off}.
 NOTE: this parameter is deprecated. Please use @option{-global}
 @option{migration.send-configuration}=@var{on|off} instead.
+@item memory-encryption=@var{}
+Memory encryption object to use. The default is none.
 @end table
 ETEXI
 
-- 
2.9.5
