Received: from eggs.gnu.org ([2001:4830:134:3::10]:60672)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1evjUf-0001L5-8Y
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 08:57:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1evjUc-0000ms-Ka
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 08:57:29 -0400
Received: from mail-wr0-x243.google.com ([2a00:1450:400c:c0c::243]:44774)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1evjUc-0000lW-64
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 08:57:26 -0400
Received: by mail-wr0-x243.google.com with SMTP id v65so22375865wrc.11
	for <qemu-devel@nongnu.org>; Tue, 13 Mar 2018 05:57:25 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 13 Mar 2018 13:56:26 +0100
Message-Id: <1520945798-50640-11-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1520945798-50640-1-git-send-email-pbonzini@redhat.com>
References: <1520945798-50640-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 10/22] sev/i386: add command to initialize the
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
Cc: Brijesh Singh <brijesh.singh@amd.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>

From: Brijesh Singh <brijesh.singh@amd.com>

When memory encryption is enabled, KVM_SEV_INIT command is used to
initialize the platform. The command loads the SEV related persistent
data from non-volatile storage and initializes the platform context.
This command should be first issued before invoking any other guest
commands provided by the SEV firmware.

Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Richard Henderson <rth@twiddle.net>
Cc: Eduardo Habkost <ehabkost@redhat.com>
Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/Makefile.objs |   1 +
 target/i386/monitor.c     |  12 ++-
 target/i386/sev-stub.c    |  41 +++++++++
 target/i386/sev.c         | 224 ++++++++++++++++++++++++++++++++++++++++++++++
 target/i386/sev_i386.h    |  24 +++++
 target/i386/trace-events  |   3 +
 6 files changed, 303 insertions(+), 2 deletions(-)
 create mode 100644 target/i386/sev-stub.c

diff --git a/target/i386/Makefile.objs b/target/i386/Makefile.objs
index d4697d8..04678f5 100644
--- a/target/i386/Makefile.objs
+++ b/target/i386/Makefile.objs
@@ -7,6 +7,7 @@ obj-$(CONFIG_SOFTMMU) += machine.o arch_memory_mapping.o arch_dump.o monitor.o
 obj-$(CONFIG_KVM) += kvm.o hyperv.o
 obj-$(CONFIG_SEV) += sev.o
 obj-$(call lnot,$(CONFIG_KVM)) += kvm-stub.o
+obj-$(call lnot,$(CONFIG_SEV)) += sev-stub.o
 # HAX support
 ifdef CONFIG_WIN32
 obj-$(CONFIG_HAX) += hax-all.o hax-mem.o hax-windows.o
diff --git a/target/i386/monitor.c b/target/i386/monitor.c
index 0d1556f..4eae0a6 100644
--- a/target/i386/monitor.c
+++ b/target/i386/monitor.c
@@ -31,6 +31,7 @@
 #include "sysemu/kvm.h"
 #include "hmp.h"
 #include "qapi/error.h"
+#include "sev_i386.h"
 #include "qapi/qapi-commands-misc.h"
 
 
@@ -666,6 +667,13 @@ void hmp_info_io_apic(Monitor *mon, const QDict *qdict)
 
 SevInfo *qmp_query_sev(Error **errp)
 {
-    error_setg(errp, "SEV feature is not available");
-    return NULL;
+    SevInfo *info;
+
+    info = sev_get_info();
+    if (!info) {
+        error_setg(errp, "SEV feature is not available");
+        return NULL;
+    }
+
+    return info;
 }
diff --git a/target/i386/sev-stub.c b/target/i386/sev-stub.c
new file mode 100644
index 0000000..c86d8c1
--- /dev/null
+++ b/target/i386/sev-stub.c
@@ -0,0 +1,41 @@
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
+#include "sev_i386.h"
+
+SevInfo *sev_get_info(void)
+{
+    return NULL;
+}
+
+bool sev_enabled(void)
+{
+    return false;
+}
+
+uint64_t sev_get_me_mask(void)
+{
+    return ~0;
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
diff --git a/target/i386/sev.c b/target/i386/sev.c
index ab42e4a..91b5190 100644
--- a/target/i386/sev.c
+++ b/target/i386/sev.c
@@ -11,6 +11,11 @@
  *
  */
 
+#include <linux/kvm.h>
+#include <linux/psp-sev.h>
+
+#include <sys/ioctl.h>
+
 #include "qemu/osdep.h"
 #include "qapi/error.h"
 #include "qom/object_interfaces.h"
@@ -18,10 +23,88 @@
 #include "sysemu/kvm.h"
 #include "sev_i386.h"
 #include "sysemu/sysemu.h"
+#include "trace.h"
 
 #define DEFAULT_GUEST_POLICY    0x1 /* disable debug */
 #define DEFAULT_SEV_DEVICE      "/dev/sev"
 
+static SEVState *sev_state;
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
+sev_ioctl(int fd, int cmd, void *data, int *error)
+{
+    int r;
+    struct kvm_sev_cmd input;
+
+    memset(&input, 0x0, sizeof(input));
+
+    input.id = cmd;
+    input.sev_fd = fd;
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
+static int
+sev_platform_ioctl(int fd, int cmd, void *data, int *error)
+{
+    int r;
+    struct sev_issue_cmd arg;
+
+    arg.cmd = cmd;
+    arg.data = (unsigned long)data;
+    r = ioctl(fd, SEV_ISSUE_CMD, &arg);
+    if (error) {
+        *error = arg.error;
+    }
+
+    return r;
+}
+
+static const char *
+fw_error_to_str(int code)
+{
+    if (code < 0 || code >= SEV_FW_MAX_ERROR) {
+        return "unknown error";
+    }
+
+    return sev_fw_errlist[code];
+}
+
 static void
 qsev_guest_finalize(Object *obj)
 {
@@ -219,6 +302,147 @@ static const TypeInfo qsev_guest_info = {
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
+bool
+sev_enabled(void)
+{
+    return sev_state ? true : false;
+}
+
+uint64_t
+sev_get_me_mask(void)
+{
+    return sev_state ? sev_state->me_mask : ~0;
+}
+
+uint32_t
+sev_get_cbit_position(void)
+{
+    return sev_state ? sev_state->cbitpos : 0;
+}
+
+uint32_t
+sev_get_reduced_phys_bits(void)
+{
+    return sev_state ? sev_state->reduced_phys_bits : 0;
+}
+
+SevInfo *
+sev_get_info(void)
+{
+    SevInfo *info;
+
+    info = g_new0(SevInfo, 1);
+    info->enabled = sev_state ? true : false;
+
+    if (info->enabled) {
+        info->api_major = sev_state->api_major;
+        info->api_minor = sev_state->api_minor;
+        info->build_id = sev_state->build_id;
+        info->policy = sev_state->policy;
+        info->state = sev_state->state;
+        info->handle = sev_state->handle;
+    }
+
+    return info;
+}
+
+void *
+sev_guest_init(const char *id)
+{
+    SEVState *s;
+    char *devname;
+    int ret, fw_error;
+    uint32_t ebx;
+    uint32_t host_cbitpos;
+    struct sev_user_data_status status = {};
+
+    s = g_new0(SEVState, 1);
+    s->sev_info = lookup_sev_guest_info(id);
+    if (!s->sev_info) {
+        error_report("%s: '%s' is not a valid '%s' object",
+                     __func__, id, TYPE_QSEV_GUEST_INFO);
+        goto err;
+    }
+
+    sev_state = s;
+    s->state = SEV_STATE_UNINIT;
+
+    host_cpuid(0x8000001F, 0, NULL, &ebx, NULL, NULL);
+    host_cbitpos = ebx & 0x3f;
+
+    s->cbitpos = object_property_get_int(OBJECT(s->sev_info), "cbitpos", NULL);
+    if (host_cbitpos != s->cbitpos) {
+        error_report("%s: cbitpos check failed, host '%d' requested '%d'",
+                     __func__, host_cbitpos, s->cbitpos);
+        goto err;
+    }
+
+    s->reduced_phys_bits = object_property_get_int(OBJECT(s->sev_info),
+                                        "reduced-phys-bits", NULL);
+    if (s->reduced_phys_bits < 1) {
+        error_report("%s: reduced_phys_bits check failed, it should be >=1,"
+                     "' requested '%d'", __func__, s->reduced_phys_bits);
+        goto err;
+    }
+
+    s->me_mask = ~(1UL << s->cbitpos);
+
+    devname = object_property_get_str(OBJECT(s->sev_info), "sev-device", NULL);
+    s->sev_fd = open(devname, O_RDWR);
+    if (s->sev_fd < 0) {
+        error_report("%s: Failed to open %s '%s'", __func__,
+                     devname, strerror(errno));
+        goto err;
+    }
+    g_free(devname);
+
+    ret = sev_platform_ioctl(s->sev_fd, SEV_PLATFORM_STATUS, &status,
+                             &fw_error);
+    if (ret) {
+        error_report("%s: failed to get platform status ret=%d"
+                     "fw_error='%d: %s'", __func__, ret, fw_error,
+                     fw_error_to_str(fw_error));
+        goto err;
+    }
+    s->build_id = status.build;
+    s->api_major = status.api_major;
+    s->api_minor = status.api_minor;
+
+    trace_kvm_sev_init();
+    ret = sev_ioctl(s->sev_fd, KVM_SEV_INIT, NULL, &fw_error);
+    if (ret) {
+        error_report("%s: failed to initialize ret=%d fw_error=%d '%s'",
+                     __func__, ret, fw_error, fw_error_to_str(fw_error));
+        goto err;
+    }
+
+    return s;
+err:
+    g_free(sev_state);
+    sev_state = NULL;
+    return NULL;
+}
+
 static void
 sev_register_types(void)
 {
diff --git a/target/i386/sev_i386.h b/target/i386/sev_i386.h
index caf879c..924cebc 100644
--- a/target/i386/sev_i386.h
+++ b/target/i386/sev_i386.h
@@ -17,7 +17,9 @@
 #include "qom/object.h"
 #include "qapi/error.h"
 #include "sysemu/kvm.h"
+#include "sysemu/sev.h"
 #include "qemu/error-report.h"
+#include "qapi/qapi-commands-misc.h"
 
 #define SEV_POLICY_NODBG        0x1
 #define SEV_POLICY_NOKS         0x2
@@ -30,6 +32,12 @@
 #define QSEV_GUEST_INFO(obj)                  \
     OBJECT_CHECK(QSevGuestInfo, (obj), TYPE_QSEV_GUEST_INFO)
 
+extern bool sev_enabled(void);
+extern uint64_t sev_get_me_mask(void);
+extern SevInfo *sev_get_info(void);
+extern uint32_t sev_get_cbit_position(void);
+extern uint32_t sev_get_reduced_phys_bits(void);
+
 typedef struct QSevGuestInfo QSevGuestInfo;
 typedef struct QSevGuestInfoClass QSevGuestInfoClass;
 
@@ -58,4 +66,20 @@ struct QSevGuestInfoClass {
     ObjectClass parent_class;
 };
 
+struct SEVState {
+    QSevGuestInfo *sev_info;
+    uint8_t api_major;
+    uint8_t api_minor;
+    uint8_t build_id;
+    uint32_t policy;
+    uint64_t me_mask;
+    uint32_t cbitpos;
+    uint32_t reduced_phys_bits;
+    uint32_t handle;
+    int sev_fd;
+    SevState state;
+};
+
+typedef struct SEVState SEVState;
+
 #endif
diff --git a/target/i386/trace-events b/target/i386/trace-events
index 3153fd4..797b716 100644
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
1.8.3.1
