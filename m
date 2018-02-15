Received: from eggs.gnu.org ([2001:4830:134:3::10]:35711)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <brijesh.singh@amd.com>) id 1emLeU-0004Ij-9S
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 10:40:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <brijesh.singh@amd.com>) id 1emLeN-0003UZ-NJ
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 10:40:50 -0500
Received: from mail-cys01nam02on0060.outbound.protection.outlook.com
	([104.47.37.60]:52287
	helo=NAM02-CY1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <brijesh.singh@amd.com>)
	id 1emLeN-0003SW-5n
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 10:40:43 -0500
From: Brijesh Singh <brijesh.singh@amd.com>
Date: Thu, 15 Feb 2018 09:39:36 -0600
Message-Id: <20180215153955.3253-11-brijesh.singh@amd.com>
In-Reply-To: <20180215153955.3253-1-brijesh.singh@amd.com>
References: <20180215153955.3253-1-brijesh.singh@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v9 10/29] sev/i386: add command to initialize
 the memory encryption context
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Alistair Francis <alistair.francis@xilinx.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, "Daniel P . Berrange" <berrange@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>, Eduardo Habkost <ehabkost@redhat.com>, Eric Blake <eblake@redhat.com>, kvm@vger.kernel.org, Marcel Apfelbaum <marcel@redhat.com>, Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Peter Maydell <peter.maydell@linaro.org>, Richard Henderson <richard.henderson@linaro.org>, Stefan Hajnoczi <stefanha@gmail.com>, Thomas Lendacky <Thomas.Lendacky@amd.com>, Borislav Petkov <bp@suse.de>, Alexander Graf <agraf@suse.de>, Bruce Rogers <brogers@suse.com>, Brijesh Singh <brijesh.singh@amd.com>, Richard Henderson <rth@twiddle.net>

When memory encryption is enabled, KVM_SEV_INIT command is used to
initialize the platform. The command loads the SEV related persistent
data from non-volatile storage and initializes the platform context.
This command should be first issued before invoking any other guest
commands provided by the SEV firmware.

Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Richard Henderson <rth@twiddle.net>
Cc: Eduardo Habkost <ehabkost@redhat.com>
Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
---
 accel/kvm/kvm-all.c      |  15 ++++
 include/sysemu/sev.h     |  19 +++++
 stubs/Makefile.objs      |   1 +
 stubs/sev.c              |  54 ++++++++++++++
 target/i386/sev.c        | 191 +++++++++++++++++++++++++++++++++++++++++++++++
 target/i386/trace-events |   3 +
 6 files changed, 283 insertions(+)
 create mode 100644 stubs/sev.c

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index b91fcb7160d3..300fc3cd44ce 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -38,6 +38,7 @@
 #include "qemu/event_notifier.h"
 #include "trace.h"
 #include "hw/irq.h"
+#include "sysemu/sev.h"
 
 #include "hw/boards.h"
 
@@ -103,6 +104,9 @@ struct KVMState
 #endif
     KVMMemoryListener memory_listener;
     QLIST_HEAD(, KVMParkedVcpu) kvm_parked_vcpus;
+
+    /* memory encryption */
+    void *memcrypt_handle;
 };
 
 KVMState *kvm_state;
@@ -1636,6 +1640,17 @@ static int kvm_init(MachineState *ms)
 
     kvm_state = s;
 
+    /*
+     * if memory encryption object is specified then initialize the memory
+     * encryption context.
+     */
+    if (ms->memory_encryption) {
+        kvm_state->memcrypt_handle = sev_guest_init(ms->memory_encryption);
+        if (!kvm_state->memcrypt_handle) {
+            goto err;
+        }
+    }
+
     ret = kvm_arch_init(ms, s);
     if (ret < 0) {
         goto err;
diff --git a/include/sysemu/sev.h b/include/sysemu/sev.h
index a1936a7a79aa..5c8c549b68ec 100644
--- a/include/sysemu/sev.h
+++ b/include/sysemu/sev.h
@@ -14,15 +14,26 @@
 #ifndef QEMU_SEV_H
 #define QEMU_SEV_H
 
+#include <linux/kvm.h>
+
 #include "qom/object.h"
 #include "qapi/error.h"
 #include "sysemu/kvm.h"
 #include "qemu/error-report.h"
+#include "qapi-types.h"
 
 #define TYPE_QSEV_GUEST_INFO "sev-guest"
 #define QSEV_GUEST_INFO(obj)                  \
     OBJECT_CHECK(QSevGuestInfo, (obj), TYPE_QSEV_GUEST_INFO)
 
+extern bool sev_enabled(void);
+extern uint64_t sev_get_me_mask(void);
+extern SevState sev_get_current_state(void);
+extern void sev_get_fw_version(uint8_t *major, uint8_t *minor, uint8_t *build);
+extern void sev_get_policy(uint32_t *policy);
+extern uint32_t sev_get_cbit_position(void);
+extern uint32_t sev_get_reduced_phys_bits(void);
+
 typedef struct QSevGuestInfo QSevGuestInfo;
 typedef struct QSevGuestInfoClass QSevGuestInfoClass;
 
@@ -51,4 +62,12 @@ struct QSevGuestInfoClass {
     ObjectClass parent_class;
 };
 
+struct SEVState {
+    QSevGuestInfo *sev_info;
+};
+
+typedef struct SEVState SEVState;
+
+void *sev_guest_init(const char *id);
+
 #endif
diff --git a/stubs/Makefile.objs b/stubs/Makefile.objs
index 2d59d8409162..31b36fdfdb88 100644
--- a/stubs/Makefile.objs
+++ b/stubs/Makefile.objs
@@ -43,3 +43,4 @@ stub-obj-y += xen-common.o
 stub-obj-y += xen-hvm.o
 stub-obj-y += pci-host-piix.o
 stub-obj-y += ram-block.o
+stub-obj-y += sev.o
diff --git a/stubs/sev.c b/stubs/sev.c
new file mode 100644
index 000000000000..24c7b0c3e04d
--- /dev/null
+++ b/stubs/sev.c
@@ -0,0 +1,54 @@
+/*
+ * QEMU SEV stub
+ *
+ * Copyright Advanced Micro Devices 2018
+ *
+ * Authors:
+ *      Brijesh Singh <brijesh.singh@amd.com>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ *
+ */
+
+#include "qemu/osdep.h"
+#include "qemu-common.h"
+#include "sysemu/sev.h"
+
+SevState sev_get_current_state(void)
+{
+    return SEV_STATE_UNINIT;
+}
+
+bool sev_enabled(void)
+{
+    return false;
+}
+
+void *sev_guest_init(const char *id)
+{
+    return NULL;
+}
+
+uint64_t sev_get_me_mask(void)
+{
+    return ~0UL;
+}
+
+uint32_t sev_get_cbit_position(void)
+{
+    return 0;
+}
+
+uint32_t sev_get_reduced_phys_bits(void)
+{
+    return 0;
+}
+
+void sev_get_fw_version(uint8_t *major, uint8_t *minor, uint8_t *build)
+{
+}
+
+void sev_get_policy(uint32_t *policy)
+{
+}
diff --git a/target/i386/sev.c b/target/i386/sev.c
index f07c6465777b..f9a8748d19c1 100644
--- a/target/i386/sev.c
+++ b/target/i386/sev.c
@@ -18,10 +18,76 @@
 #include "sysemu/kvm.h"
 #include "sysemu/sev.h"
 #include "sysemu/sysemu.h"
+#include "trace.h"
 
 #define DEFAULT_GUEST_POLICY    0x1 /* disable debug */
 #define DEFAULT_SEV_DEVICE      "/dev/sev"
 
+static uint64_t me_mask;
+static bool sev_active;
+static int sev_fd;
+static uint32_t x86_cbitpos;
+static uint32_t x86_reduced_phys_bits;
+
+static const char *const sev_fw_errlist[] = {
+    "",
+    "Platform state is invalid",
+    "Guest state is invalid",
+    "Platform configuration is invalid",
+    "Buffer too small",
+    "Platform is already owned",
+    "Certificate is invalid",
+    "Policy is not allowed",
+    "Guest is not active",
+    "Invalid address",
+    "Bad signature",
+    "Bad measurement",
+    "Asid is already owned",
+    "Invalid ASID",
+    "WBINVD is required",
+    "DF_FLUSH is required",
+    "Guest handle is invalid",
+    "Invalid command",
+    "Guest is active",
+    "Hardware error",
+    "Hardware unsafe",
+    "Feature not supported",
+    "Invalid parameter"
+};
+
+#define SEV_FW_MAX_ERROR      ARRAY_SIZE(sev_fw_errlist)
+
+static int
+sev_ioctl(int cmd, void *data, int *error)
+{
+    int r;
+    struct kvm_sev_cmd input;
+
+    memset(&input, 0x0, sizeof(input));
+
+    input.id = cmd;
+    input.sev_fd = sev_fd;
+    input.data = (__u64)data;
+
+    r = kvm_vm_ioctl(kvm_state, KVM_MEMORY_ENCRYPT_OP, &input);
+
+    if (error) {
+        *error = input.error;
+    }
+
+    return r;
+}
+
+static const char *
+fw_error_to_str(int code)
+{
+    if (code >= SEV_FW_MAX_ERROR) {
+        return "unknown error";
+    }
+
+    return sev_fw_errlist[code];
+}
+
 static void
 qsev_guest_finalize(Object *obj)
 {
@@ -219,6 +285,131 @@ static const TypeInfo qsev_guest_info = {
     }
 };
 
+static QSevGuestInfo *
+lookup_sev_guest_info(const char *id)
+{
+    Object *obj;
+    QSevGuestInfo *info;
+
+    obj = object_resolve_path_component(object_get_objects_root(), id);
+    if (!obj) {
+        return NULL;
+    }
+
+    info = (QSevGuestInfo *)
+            object_dynamic_cast(obj, TYPE_QSEV_GUEST_INFO);
+    if (!info) {
+        return NULL;
+    }
+
+    return info;
+}
+
+uint64_t
+sev_get_me_mask(void)
+{
+    return ~me_mask;
+}
+
+uint32_t
+sev_get_cbit_position(void)
+{
+    return x86_cbitpos;
+}
+
+uint32_t
+sev_get_reduced_phys_bits(void)
+{
+    return x86_reduced_phys_bits;
+}
+
+SevState
+sev_get_current_state(void)
+{
+    return SEV_STATE_UNINIT;
+}
+
+bool
+sev_enabled(void)
+{
+    return sev_active;
+}
+
+void
+sev_get_fw_version(uint8_t *major, uint8_t *minor, uint8_t *build)
+{
+}
+
+void
+sev_get_policy(uint32_t *policy)
+{
+}
+
+void *
+sev_guest_init(const char *id)
+{
+    SEVState *s;
+    char *devname;
+    int ret, fw_error;
+    uint32_t ebx;
+    uint32_t host_cbitpos, cbitpos;
+    uint32_t host_reduced_phys_bits, reduced_phys_bits;
+
+    s = g_new0(SEVState, 1);
+    s->sev_info = lookup_sev_guest_info(id);
+    if (!s->sev_info) {
+        error_report("%s: '%s' is not a valid '%s' object",
+                     __func__, id, TYPE_QSEV_GUEST_INFO);
+        goto err;
+    }
+
+    host_cpuid(0x8000001F, 0, NULL, &ebx, NULL, NULL);
+    host_cbitpos = ebx & 0x3f;
+    host_reduced_phys_bits = (ebx  >> 6) & 0x3f;
+
+    cbitpos = object_property_get_int(OBJECT(s->sev_info), "cbitpos", NULL);
+    if (host_cbitpos != cbitpos) {
+        error_report("%s: cbitpos check failed, host '%d' requested '%d'",
+                     __func__, host_cbitpos, cbitpos);
+        goto err;
+    }
+
+    reduced_phys_bits = object_property_get_int(OBJECT(s->sev_info),
+                                        "reduced-phys-bits", NULL);
+    if (host_reduced_phys_bits != reduced_phys_bits) {
+        error_report("%s: reduced_phys_bits check failed,"
+                     "host '%d' requested '%d'", __func__,
+                     host_reduced_phys_bits, reduced_phys_bits);
+        goto err;
+    }
+
+    devname = object_property_get_str(OBJECT(s->sev_info), "sev-device", NULL);
+    sev_fd = open(devname, O_RDWR);
+    if (sev_fd < 0) {
+        error_report("%s: Failed to open %s '%s'", __func__,
+                     devname, strerror(errno));
+        goto err;
+    }
+    g_free(devname);
+
+    trace_kvm_sev_init();
+    ret = sev_ioctl(KVM_SEV_INIT, NULL, &fw_error);
+    if (ret) {
+        error_report("%s: failed to initialize ret=%d fw_error=%d '%s'",
+                     __func__, ret, fw_error, fw_error_to_str(fw_error));
+        goto err;
+    }
+
+    me_mask = (1UL << cbitpos);
+    x86_reduced_phys_bits = reduced_phys_bits;
+    x86_cbitpos = cbitpos;
+    sev_active = true;
+    return s;
+err:
+    g_free(s);
+    return NULL;
+}
+
 static void
 sev_register_types(void)
 {
diff --git a/target/i386/trace-events b/target/i386/trace-events
index 3153fd445488..797b716751b7 100644
--- a/target/i386/trace-events
+++ b/target/i386/trace-events
@@ -5,3 +5,6 @@ kvm_x86_fixup_msi_error(uint32_t gsi) "VT-d failed to remap interrupt for GSI %"
 kvm_x86_add_msi_route(int virq) "Adding route entry for virq %d"
 kvm_x86_remove_msi_route(int virq) "Removing route entry for virq %d"
 kvm_x86_update_msi_routes(int num) "Updated %d MSI routes"
+
+# target/i386/sev.c
+kvm_sev_init(void) ""
-- 
2.14.3
