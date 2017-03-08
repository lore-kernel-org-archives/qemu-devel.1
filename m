Received: from eggs.gnu.org ([2001:4830:134:3::10]:51902)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <brijesh.singh@amd.com>) id 1clj5G-0005T1-0X
	for qemu-devel@nongnu.org; Wed, 08 Mar 2017 16:25:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <brijesh.singh@amd.com>) id 1clj5C-0005M8-Lm
	for qemu-devel@nongnu.org; Wed, 08 Mar 2017 16:25:22 -0500
Received: from mail-sn1nam01on0055.outbound.protection.outlook.com
	([104.47.32.55]:37952
	helo=NAM01-SN1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <brijesh.singh@amd.com>)
	id 1clj5C-0005Lw-9S
	for qemu-devel@nongnu.org; Wed, 08 Mar 2017 16:25:18 -0500
From: Brijesh Singh <brijesh.singh@amd.com>
Date: Wed, 8 Mar 2017 15:52:37 -0500
Message-ID: <148900635729.27090.16897035853016859795.stgit@brijesh-build-machine>
In-Reply-To: <148900626714.27090.1616990932333159904.stgit@brijesh-build-machine>
References: <148900626714.27090.1616990932333159904.stgit@brijesh-build-machine>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [RFC PATCH v4 08/20] sev: add Secure Encrypted
 Virtulization (SEV) support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: ehabkost@redhat.com, crosthwaite.peter@gmail.com, armbru@redhat.com, mst@redhat.com, p.fedin@samsung.com, qemu-devel@nongnu.org, lcapitulino@redhat.com, pbonzini@redhat.com, rth@twiddle.net
Cc: Thomas.Lendacky@amd.com, brijesh.singh@amd.com

Adds initial support required to integrate Secure Encrypted Virtualization
(SEV) feature. SEV is an extension to the existing AMD-V technology found
on AMD processors. The SEV feature allows the memory contents of a virtual
machine to be transparently encrypted with a key unique to the guest VM.

In QEMU command line, SEV can be enabled via memory-encryption property
defined in security-policy object.

Patch adds the following new objects:

- sev-launch-info: provides the properties to get and set various parameters
  used to boot SEV guest from unencrypted boot images.

  In this mode the OS images (kernel, initrd and  bios) provides by guest
  owner are unencrypted. The SEV guest boot process would encrypt the
  images using the guest owners PDH key provided through this object.

- sev-guest: a top level object to transition a guest into SEV-enabled

e.g to launch SEV guest from unencrypted boot images
 # $QEMU \
    -object sev-launch-info,id=launch0 \
    -object sev-guest,id=sev0 \
    -object security-policy,id=secure0,memory-encryption=sev0 \
    -machine ....,security-policy=secure0

Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
---
 Makefile.target                |    2 
 docs/amd-memory-encryption.txt |  121 ++++++++++++++++++++++
 include/sysemu/sev.h           |   91 ++++++++++++++++
 kvm-all.c                      |   22 ++++
 kvm-stub.c                     |    5 +
 qemu-options.hx                |   27 +++++
 sev.c                          |  225 ++++++++++++++++++++++++++++++++++++++++
 7 files changed, 492 insertions(+), 1 deletion(-)
 create mode 100644 docs/amd-memory-encryption.txt
 create mode 100644 include/sysemu/sev.h
 create mode 100644 sev.c

diff --git a/Makefile.target b/Makefile.target
index 924304c..5150c12 100644
--- a/Makefile.target
+++ b/Makefile.target
@@ -142,7 +142,7 @@ ifdef CONFIG_SOFTMMU
 obj-y += arch_init.o cpus.o monitor.o gdbstub.o balloon.o ioport.o numa.o
 obj-y += qtest.o bootdevice.o
 obj-y += hw/
-obj-$(CONFIG_KVM) += kvm-all.o
+obj-$(CONFIG_KVM) += kvm-all.o sev.o
 obj-y += memory.o cputlb.o
 obj-y += memory_mapping.o
 obj-y += dump.o
diff --git a/docs/amd-memory-encryption.txt b/docs/amd-memory-encryption.txt
new file mode 100644
index 0000000..03e31c0
--- /dev/null
+++ b/docs/amd-memory-encryption.txt
@@ -0,0 +1,121 @@
+Secure Encrypted Virtualization (SEV) is a feature found on AMD processors.
+
+SEV feature allows the memory contents of a virtual machine (VM) to be
+transparently  encrypted with a key unique to the guest VM. The memory
+controller contains a high performance encryption engine which can be
+programmed with multiple keys for used by different VMs in the system.
+The programming and management of these keys is handled by the AMD  Secure
+Processor firmware which exposes commands for these tasks.
+
+At highest level the SEV key management APIs are divided into two sections:
+
+* Platform management commands
+* Guest management commands
+
+In this doc we will focus on Guest management commands. 
+
+SEV is capable of supporting both light-weight virtual containers as well as
+conventional VM within an enterprise cloud environment. In either case, there
+are two parties concerned in the deployment of SEV guest: the guest owner and
+the platform owner. For example, in a cloud environment, the platform owner
+would be cloud vendor and the guest owner would be the user that wishes to run
+their workload in the cloud.
+
+1. Guest Management Commands
+-----------------------------
+
+The guest management commands provide the support for common guest lifecycle
+events. These events include launching, running, snapshotting, migrating and
+decommission guest. The guest management commands are issued through
+KVM_MEMORY_ENCRYPTION_OPS ioctl.
+
+1.1 Launch
+
+When a guest is launched, its memory must first be encrypted using guest owners
+key before SEV can be enabled in hardware. There are two types of launches:
+
+1.1.1 unencrypted
+
+Boot images (such as bios, kernel, initrd) provided by the guest owner to
+bootstrap the guest is unencrypted. The firmware provides interfaces to
+bootstrap the memory encryption for this purpose: LAUNCH_START, LAUNCH_UPDATE,
+, LAUNCH_MEASURE and LAUNCH_FINISH. These four commands together generate a fresh
+memory encryption key for the guest, encrypt guest memory and provide an
+attestation of the successful launch.
+
+LAUNCH_START is called first to create a cryptographic launch context within the
+firmware. To create this context, guest owner must provide security policy,
+public Diffie-Hellman key (PDH defined in section 12 of SEV key API management)
+and session data. If PDH certificate blob is not provided by guest owner then
+firmware will auto generate a key and use that key for memory encryption. Guest
+owners PDH key is used to establish a cryptographic session with the guest owner
+to negotiate keys used for attestation. The guest security policy is a 4-byte
+data structure containing several flags that restrict what the hypervisor can do
+on the running SEV guest.  If the hypervisor requests this guest to share key
+with another SEV guest then hypervisor must set 'key-sharing' field in guest
+security policy and a shared SEV handle must be provided in LAUNCH_START command.
+
+LAUNCH_UPDATE_DATA encrypts the memory region using the cryptographic context
+created via LAUNCH_START command. If required this command can be called multiple
+times to encrypt different memory regions. The command also calculates the
+measurement of the memory contents as it encrypts.
+
+LAUNCH_MEASURE command can be used to retrieve the measurement of encrypted memory.
+This measurement is a signature of the memory contents that can be sent to the
+guest owner as an attestation that the memory was encrypted correctly by the
+firmware. The guest owner may wait to provide the guest confidential information
+until it can verify the attestation measurement. Since the guest owner knows the
+initial contents of the guest at boot, the attestation measurement can be
+verified by comparing it to what the guest owner expects.
+
+LAUNCH_FINISH command finalizes the guest launch and destory's the cryptographic
+context.
+
+See SEV API Spec [1] 'Launching a guest' usage flow (Appendix A) for the
+complete flow chart.
+
+SEV support can be enabled via 'memory-encryption' parameters defined in
+security-policy object.
+
+Input to LAUNCH_START command can be provided through the properties defined in
+'sev-launch-info' object.
+
+e.g to launch SEV guest from unencrypted boot images
+
+# ${QEMU} \
+      -object sev-launch-info,id=launch0\
+      -object sev-guest,id=sev0\
+      -object security-policy,id=mypolicy,memory-encryption=sev0\
+      -machine ...,security-policy=mypolicy
+
+1.1.2 pre-encrypted
+
+1.2 Snapshot
+
+1.3 Restore
+
+1.4 Live Migration
+
+1.5 Debugging
+
+Since memory contents of SEV guest is encrypted hence hypervisor access to the
+guest memory will get a cipher text. If guest policy allows debugging, then
+hypervisor can use SEV debug command to decrypt guest memory region for debug
+purposes.
+
+2. References
+-----------------
+
+AMD Memory Encryption whitepaper:
+http://amd-dev.wpengine.netdna-cdn.com/wordpress/media/2013/12/AMD_Memory_Encryption_Whitepaper_v7-Public.pdf
+
+Secure Encrypted Virutualization Key Management:
+[1] http://support.amd.com/TechDocs/55766_SEV-KM API_Specification.pdf
+
+KVM Forum slides:
+http://www.linux-kvm.org/images/7/74/02x08A-Thomas_Lendacky-AMDs_Virtualizatoin_Memory_Encryption_Technology.pdf
+
+AMD64 Architecture Programmer's Manual:
+   http://support.amd.com/TechDocs/24593.pdf
+   SME is section 7.10
+   SEV is section 15.34
diff --git a/include/sysemu/sev.h b/include/sysemu/sev.h
new file mode 100644
index 0000000..dbc3c6c
--- /dev/null
+++ b/include/sysemu/sev.h
@@ -0,0 +1,91 @@
+/*
+ * QEMU Secure Encrypted Virutualization (SEV) support
+ *
+ * Copyright: Advanced Micro Devices, 2016-2017
+ *
+ * Authors:
+ *  Brijesh Singh <brijesh.singh@amd.com>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ *
+ */
+
+#ifndef QEMU_SEV_H
+#define QEMU_SEV_H
+
+#include <linux/kvm.h>
+
+#include "qom/object.h"
+#include "qapi/error.h"
+#include "sysemu/kvm.h"
+
+#define TYPE_QSEV_LAUNCH_INFO "sev-launch-info"
+#define QSEV_LAUNCH_INFO(obj)                  \
+    OBJECT_CHECK(QSevLaunchInfo, (obj), TYPE_QSEV_LAUNCH_INFO)
+
+typedef struct QSevLaunchInfo QSevLaunchInfo;
+typedef struct QSevLaunchInfoClass QSevLaunchInfoClass;
+
+/**
+ * QSevLaunchInfo:
+ *
+ * The QSevLaunchInfo object provides parameters to launch a SEV
+ * guest from unnencrypted boot images. SEV will encrypt the boot images using
+ * guest owner's key before launching the guest.
+ *
+ * # $QEMU -object sev-launch-info,id=launch0,dh-cert=0000,session=abcd \
+ *         ....
+ */
+struct QSevLaunchInfo {
+    Object parent_obj;
+};
+
+struct QSevLaunchInfoClass {
+    ObjectClass parent_class;
+};
+
+#define TYPE_QSEV_GUEST_INFO "sev-guest"
+#define QSEV_GUEST_INFO(obj)                  \
+    OBJECT_CHECK(QSevGuestInfo, (obj), TYPE_QSEV_GUEST_INFO)
+
+typedef struct QSevGuestInfo QSevGuestInfo;
+typedef struct QSevGuestInfoClass QSevGuestInfoClass;
+
+/**
+ * QSevGuestInfo:
+ *
+ * The QSevGuestInfo object is used for creating a SEV guest.
+ *
+ * e.g to launch a SEV guest from unencrypted boot images
+ *
+ * # $QEMU -object sev-launch-info,id=launch0 \
+ *         -object sev-guest,id=sev0,sev-device=/dev/sev \
+ *         -object security-policy,id=secure0,memory-encryption=sev0 \
+ *         -machine ...security-policy=secure0
+ */
+struct QSevGuestInfo {
+    Object parent_obj;
+
+    char *sev_device;
+
+    QSevLaunchInfo *launch_info;
+};
+
+struct QSevGuestInfoClass {
+    ObjectClass parent_class;
+};
+
+struct SEVState {
+    QSevGuestInfo *sev_info;
+};
+
+typedef struct SEVState SEVState;
+
+
+bool sev_enabled(void);
+void *sev_guest_init(const char *keyid);
+void sev_set_debug_ops(void *handle, MemoryRegion *mr);
+
+#endif
+
diff --git a/kvm-all.c b/kvm-all.c
index bba0f39..1fa6413 100644
--- a/kvm-all.c
+++ b/kvm-all.c
@@ -37,6 +37,7 @@
 #include "trace-root.h"
 #include "hw/irq.h"
 #include "sysemu/security-policy.h"
+#include "sysemu/sev.h"
 
 #include "hw/boards.h"
 
@@ -1808,6 +1809,27 @@ static int kvm_init(MachineState *ms)
 
     kvm_state = s;
 
+    if (ms->security_policy) {
+        char *id;
+
+        /* if security-policy is enabled  then check whether memory encryption
+         * property is defined. If so, enable hardware memory encryption.
+         */
+        id = security_policy_get_memory_encryption_id(ms->security_policy);
+        if (id) {
+
+            /* check if its SEV guest policy */
+            kvm_state->ehandle = sev_guest_init(id);
+            if (!kvm_state->ehandle) {
+                fprintf(stderr,
+                        "failed to initialize SEV guest\n");
+                goto err;
+            }
+            kvm_state->memcrypt_debug_ops = sev_set_debug_ops;
+            g_free(id);
+        }
+    }
+
     if (kvm_eventfds_allowed) {
         s->memory_listener.listener.eventfd_add = kvm_mem_ioeventfd_add;
         s->memory_listener.listener.eventfd_del = kvm_mem_ioeventfd_del;
diff --git a/kvm-stub.c b/kvm-stub.c
index 20920aa..1a9838d 100644
--- a/kvm-stub.c
+++ b/kvm-stub.c
@@ -14,6 +14,7 @@
 #include "qemu-common.h"
 #include "cpu.h"
 #include "sysemu/kvm.h"
+#include "sysemu/sev.h"
 
 #ifndef CONFIG_USER_ONLY
 #include "hw/pci/msi.h"
@@ -135,6 +136,10 @@ int kvm_memcrypt_encrypt_launch_data(uint8_t *ptr, uint64_t len)
     return 1;
 }
 
+bool sev_enabled(void)
+{
+    return false;
+}
 
 #ifndef CONFIG_USER_ONLY
 int kvm_irqchip_add_msi_route(KVMState *s, int vector, PCIDevice *dev)
diff --git a/qemu-options.hx b/qemu-options.hx
index 536db1b..2b2d8c3 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -4161,6 +4161,33 @@ can be set to the unquie ID of memory encryption object.
 
 On AMD processor, memory encryption is supported via 'sev-guest' object.
 
+@item -object sev-guest,id=@var{id},sev-device=@var{string}
+
+Create a Secure Encrypted Virtualization (SEV) guest object, which be used to
+provide the memory encryption support on AMD processors.
+
+e.g to launch a SEV guest
+@example
+ # $QEMU \
+     -object sev-launch-info,id=launch0,sev-device=/dev/sev0 \
+     -object sev-guest-info,id=sev0 \
+     -object security-policy,id=secure0-guest,memory-encryption=sev0 \
+     -machine ...,security-policy=secure0
+@end example
+
+@item -object sev-launch-info,id=@var{id}
+
+Create a SEV launch info object, which can be used to pass various parameters
+required to boot SEV guest from  unencrypted boot images.
+The id parameter is a unique ID that should be used in sev-guest-info object
+when creating a unencrypted SEV guest.
+
+e.g to launch SEV guest from unencrypted boot images
+@example
+ # $QEMU \
+     -object sev-launch-info,id=launch0\
+     -object sev-guest,id=sev0 \
+@end example
 ETEXI
 
 
diff --git a/sev.c b/sev.c
new file mode 100644
index 0000000..3e02453
--- /dev/null
+++ b/sev.c
@@ -0,0 +1,225 @@
+/*
+ * QEMU SEV support
+ *
+ * Copyright Advanced Micro Devices 2016-2017
+ *
+ * Author:
+ *      Brijesh Singh <brijesh.singh@amd.com>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ *
+ */
+
+#include "qemu/osdep.h"
+#include "qapi/error.h"
+#include "qom/object_interfaces.h"
+#include "qemu/base64.h"
+#include "sysemu/kvm.h"
+#include "sysemu/sev.h"
+#include "sysemu/sysemu.h"
+#include "trace.h"
+
+#define DEBUG_SEV
+#ifdef DEBUG_SEV
+#define DPRINTF(fmt, ...) \
+    do { fprintf(stdout, fmt, ## __VA_ARGS__); } while (0)
+#else
+#define DPRINTF(fmt, ...) \
+    do { } while (0)
+#endif
+
+#define DEFAULT_SEV_DEVICE      "/dev/sev1"
+
+static MemoryRegionRAMReadWriteOps sev_ops;
+static bool sev_allowed;
+static int sev_fd;
+
+static void
+qsev_guest_finalize(Object *obj)
+{
+}
+
+static char *
+qsev_guest_get_sev_device(Object *obj, Error **errp)
+{
+    QSevGuestInfo *sev = QSEV_GUEST_INFO(obj);
+
+    return g_strdup(sev->sev_device);
+}
+
+static void
+qsev_guest_set_sev_device(Object *obj, const char *value, Error **errp)
+{
+    QSevGuestInfo *sev = QSEV_GUEST_INFO(obj);
+
+    sev->sev_device = g_strdup(value);
+}
+
+static void
+qsev_guest_class_init(ObjectClass *oc, void *data)
+{
+    object_class_property_add_str(oc, "sev-device",
+                                  qsev_guest_get_sev_device,
+                                  qsev_guest_set_sev_device,
+                                  NULL);
+    object_class_property_set_description(oc, "sev-device",
+            "device to use for SEV command", NULL);
+}
+
+static QSevGuestInfo *
+lookup_sev_guest_info(const char *id)
+{
+    Object *obj;
+    QSevGuestInfo *info;
+
+    obj = object_resolve_path_component(
+        object_get_objects_root(), id);
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
+static void
+qsev_guest_init(Object *obj)
+{
+    QSevGuestInfo *sev = QSEV_GUEST_INFO(obj);
+
+    object_property_add_link(obj, "launch", TYPE_QSEV_LAUNCH_INFO,
+                             (Object **)&sev->launch_info,
+                             object_property_allow_set_link,
+                             OBJ_PROP_LINK_UNREF_ON_RELEASE, NULL);
+
+    sev->sev_device = g_strdup(DEFAULT_SEV_DEVICE);
+}
+
+/* sev guest info */
+static const TypeInfo qsev_guest_info = {
+    .parent = TYPE_OBJECT,
+    .name = TYPE_QSEV_GUEST_INFO,
+    .instance_size = sizeof(QSevGuestInfo),
+    .instance_finalize = qsev_guest_finalize,
+    .class_size = sizeof(QSevGuestInfoClass),
+    .class_init = qsev_guest_class_init,
+    .instance_init = qsev_guest_init,
+    .interfaces = (InterfaceInfo[]) {
+        { TYPE_USER_CREATABLE },
+        { }
+    }
+};
+
+static void
+qsev_launch_finalize(Object *obj)
+{
+}
+
+static void
+qsev_launch_class_init(ObjectClass *oc, void *data)
+{
+    /* add launch properties */
+}
+
+static void
+qsev_launch_init(Object *obj)
+{
+}
+
+/* guest launch */
+static const TypeInfo qsev_launch_info = {
+    .parent = TYPE_OBJECT,
+    .name = TYPE_QSEV_LAUNCH_INFO,
+    .instance_size = sizeof(QSevLaunchInfo),
+    .instance_finalize = qsev_launch_finalize,
+    .class_size = sizeof(QSevLaunchInfoClass),
+    .class_init = qsev_launch_class_init,
+    .instance_init = qsev_launch_init,
+    .interfaces = (InterfaceInfo[]) {
+        { TYPE_USER_CREATABLE },
+        { }
+    }
+};
+
+static int
+sev_mem_write(uint8_t *dst, const uint8_t *src, uint32_t len, MemTxAttrs attrs)
+{
+    return 0;
+}
+
+static int
+sev_mem_read(uint8_t *dst, const uint8_t *src, uint32_t len, MemTxAttrs attrs)
+{
+    return 0;
+}
+
+void *
+sev_guest_init(const char *id)
+{
+    Object *obj;
+    SEVState *s;
+    char *sev_device_name;
+
+    s = g_malloc0(sizeof(SEVState));
+    if (!s) {
+        return NULL;
+    }
+
+    s->sev_info = lookup_sev_guest_info(id);
+    if (!s->sev_info) {
+        fprintf(stderr, "'%s' not a valid '%s' object\n",
+                id, TYPE_QSEV_GUEST_INFO);
+        goto err;
+    }
+
+    sev_device_name = object_property_get_str(OBJECT(s->sev_info),
+                                              "sev-device", NULL);
+    sev_fd = open(sev_device_name, O_RDWR);
+    if (sev_fd < 0) {
+        fprintf(stderr, "%s:%s\n", sev_device_name, strerror(errno));
+        goto err;
+    }
+    g_free(sev_device_name);
+
+    obj = object_resolve_path_type("", TYPE_QSEV_LAUNCH_INFO, NULL);
+    if (obj) {
+        object_property_set_link(OBJECT(s->sev_info), obj, "launch",
+                &error_abort);
+    }
+
+    sev_allowed = true;
+    return s;
+err:
+    g_free(s);
+    return NULL;
+}
+
+void
+sev_set_debug_ops(void *handle, MemoryRegion *mr)
+{
+    sev_ops.read = sev_mem_read;
+    sev_ops.write = sev_mem_write;
+
+    memory_region_set_ram_debug_ops(mr, &sev_ops);
+}
+
+bool
+sev_enabled(void)
+{
+    return sev_allowed;
+}
+
+static void
+sev_policy_register_types(void)
+{
+    type_register_static(&qsev_guest_info);
+    type_register_static(&qsev_launch_info);
+}
+
+type_init(sev_policy_register_types);
