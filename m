Received: from eggs.gnu.org ([2001:4830:134:3::10]:51615)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <brijesh.singh@amd.com>) id 1ejSFk-0005tb-4I
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 11:07:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <brijesh.singh@amd.com>) id 1ejSFg-0006uD-Ls
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 11:07:20 -0500
Received: from mail-by2nam01on0076.outbound.protection.outlook.com
	([104.47.34.76]:63904
	helo=NAM01-BY2-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <brijesh.singh@amd.com>)
	id 1ejSFg-0006tb-Dn
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 11:07:16 -0500
From: Brijesh Singh <brijesh.singh@amd.com>
Date: Wed,  7 Feb 2018 10:06:22 -0600
Message-Id: <20180207160638.98872-10-brijesh.singh@amd.com>
In-Reply-To: <20180207160638.98872-1-brijesh.singh@amd.com>
References: <20180207160638.98872-1-brijesh.singh@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v7 10/26] sev: add command to initialize the
 memory encryption context
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Alistair Francis <alistair.francis@xilinx.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, "Daniel P . Berrange" <berrange@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>, Eduardo Habkost <ehabkost@redhat.com>, Eric Blake <eblake@redhat.com>, kvm@vger.kernel.org, Marcel Apfelbaum <marcel@redhat.com>, Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Peter Maydell <peter.maydell@linaro.org>, Richard Henderson <richard.henderson@linaro.org>, Stefan Hajnoczi <stefanha@gmail.com>, Thomas Lendacky <Thomas.Lendacky@amd.com>, Borislav Petkov <bp@suse.de>, Brijesh Singh <brijesh.singh@amd.com>

When memory encryption is enabled, KVM_SEV_INIT command is used to
initialize the platform. The command loads the SEV related persistent
data from non-volatile storage and initializes the platform context.
This command should be first issued before invoking any other guest
commands provided by the SEV firmware.

Cc: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
---
 accel/kvm/kvm-all.c    |  15 +++++
 accel/kvm/sev.c        | 161 +++++++++++++++++++++++++++++++++++++++++++++++++
 accel/kvm/trace-events |   2 +
 accel/stubs/kvm-stub.c |  28 +++++++++
 include/sysemu/sev.h   |  16 +++++
 5 files changed, 222 insertions(+)

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index f290f487a573..6e5f3fd65066 100644
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
@@ -1632,6 +1636,17 @@ static int kvm_init(MachineState *ms)
 
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
diff --git a/accel/kvm/sev.c b/accel/kvm/sev.c
index 57e092a0bddd..d5fd975792b8 100644
--- a/accel/kvm/sev.c
+++ b/accel/kvm/sev.c
@@ -18,10 +18,74 @@
 #include "sysemu/kvm.h"
 #include "sysemu/sev.h"
 #include "sysemu/sysemu.h"
+#include "trace.h"
 
 #define DEFAULT_GUEST_POLICY    0x1 /* disable debug */
 #define DEFAULT_SEV_DEVICE      "/dev/sev"
 
+static uint64_t me_mask;
+static bool sev_active;
+static int sev_fd;
+
+#define SEV_FW_MAX_ERROR      0x17
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
@@ -205,6 +269,103 @@ static const TypeInfo qsev_guest_info = {
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
+void
+sev_get_current_state(char **state)
+{
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
+    uint32_t host_cbitpos, cbitpos;
+
+    s = g_new0(SEVState, 1);
+    s->sev_info = lookup_sev_guest_info(id);
+    if (!s->sev_info) {
+        error_report("%s: '%s' is not a valid '%s' object",
+                     __func__, id, TYPE_QSEV_GUEST_INFO);
+        goto err;
+    }
+
+    host_cbitpos = sev_get_host_cbitpos();
+    cbitpos = object_property_get_int(OBJECT(s->sev_info), "cbitpos", NULL);
+    if (host_cbitpos != cbitpos) {
+        error_report("%s: cbitpos check failed, host '%d' request '%d'",
+                     __func__, host_cbitpos, cbitpos);
+        goto err;
+    }
+
+    me_mask = (1UL << cbitpos);
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
diff --git a/accel/kvm/trace-events b/accel/kvm/trace-events
index f89ba5578dc1..ea487e5a5913 100644
--- a/accel/kvm/trace-events
+++ b/accel/kvm/trace-events
@@ -13,3 +13,5 @@ kvm_irqchip_add_msi_route(char *name, int vector, int virq) "dev %s vector %d vi
 kvm_irqchip_update_msi_route(int virq) "Updating MSI route virq=%d"
 kvm_irqchip_release_virq(int virq) "virq %d"
 
+# sev.c
+kvm_sev_init(void) ""
diff --git a/accel/stubs/kvm-stub.c b/accel/stubs/kvm-stub.c
index c964af3e1c97..bb78a1f1b950 100644
--- a/accel/stubs/kvm-stub.c
+++ b/accel/stubs/kvm-stub.c
@@ -14,6 +14,7 @@
 #include "qemu-common.h"
 #include "cpu.h"
 #include "sysemu/kvm.h"
+#include "sysemu/sev.h"
 
 #ifndef CONFIG_USER_ONLY
 #include "hw/pci/msi.h"
@@ -33,6 +34,11 @@ bool kvm_readonly_mem_allowed;
 bool kvm_ioeventfd_any_length_allowed;
 bool kvm_msi_use_devid;
 
+bool sev_allowed;
+uint8_t sev_fw_major;
+uint8_t sev_fw_minor;
+uint8_t sev_fw_build;
+
 int kvm_destroy_vcpu(CPUState *cpu)
 {
     return -ENOSYS;
@@ -105,6 +111,28 @@ int kvm_on_sigbus(int code, void *addr)
     return 1;
 }
 
+void sev_get_current_state(char **state)
+{
+}
+
+bool sev_enabled(void)
+{
+    return false;
+}
+
+uint64_t sev_get_me_mask(void)
+{
+    return ~0UL;
+}
+
+void sev_get_fw_version(uint8_t *major, uint8_t *minor, uint8_t *build)
+{
+}
+
+void sev_get_policy(uint32_t *policy)
+{
+}
+
 #ifndef CONFIG_USER_ONLY
 int kvm_irqchip_add_msi_route(KVMState *s, int vector, PCIDevice *dev)
 {
diff --git a/include/sysemu/sev.h b/include/sysemu/sev.h
index eed679653dbc..121e7e4aa44c 100644
--- a/include/sysemu/sev.h
+++ b/include/sysemu/sev.h
@@ -14,6 +14,8 @@
 #ifndef QEMU_SEV_H
 #define QEMU_SEV_H
 
+#include <linux/kvm.h>
+
 #include "qom/object.h"
 #include "qapi/error.h"
 #include "sysemu/kvm.h"
@@ -23,6 +25,12 @@
 #define QSEV_GUEST_INFO(obj)                  \
     OBJECT_CHECK(QSevGuestInfo, (obj), TYPE_QSEV_GUEST_INFO)
 
+extern bool sev_enabled(void);
+extern uint64_t sev_get_me_mask(void);
+extern void sev_get_current_state(char **state);
+extern void sev_get_fw_version(uint8_t *major, uint8_t *minor, uint8_t *build);
+extern void sev_get_policy(uint32_t *policy);
+
 typedef struct QSevGuestInfo QSevGuestInfo;
 typedef struct QSevGuestInfoClass QSevGuestInfoClass;
 
@@ -50,5 +58,13 @@ struct QSevGuestInfoClass {
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
 
-- 
2.14.3
