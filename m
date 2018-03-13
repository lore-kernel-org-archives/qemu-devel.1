Received: from eggs.gnu.org ([2001:4830:134:3::10]:60598)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1evjUd-0001Iv-9o
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 08:57:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1evjUZ-0000jU-5V
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 08:57:27 -0400
Received: from mail-wr0-x244.google.com ([2a00:1450:400c:c0c::244]:33253)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1evjUY-0000ig-RN
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 08:57:23 -0400
Received: by mail-wr0-x244.google.com with SMTP id r8so7234874wrg.0
	for <qemu-devel@nongnu.org>; Tue, 13 Mar 2018 05:57:22 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 13 Mar 2018 13:56:23 +0100
Message-Id: <1520945798-50640-8-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1520945798-50640-1-git-send-email-pbonzini@redhat.com>
References: <1520945798-50640-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 07/22] target/i386: add Secure Encrypted
 Virtualization (SEV) object
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

Add a new memory encryption object 'sev-guest'. The object will be used
to create encrypted VMs on AMD EPYC CPU. The object provides the properties
to pass guest owner's public Diffie-hellman key, guest policy and session
information required to create the memory encryption context within the
SEV firmware.

e.g to launch SEV guest
 # $QEMU \
    -object sev-guest,id=sev0 \
    -machine ....,memory-encryption=sev0

Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Richard Henderson <rth@twiddle.net>
Cc: Eduardo Habkost <ehabkost@redhat.com>
Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 default-configs/i386-softmmu.mak   |   1 +
 default-configs/x86_64-softmmu.mak |   1 +
 docs/amd-memory-encryption.txt     |  17 +++
 qemu-options.hx                    |  44 +++++++
 target/i386/Makefile.objs          |   1 +
 target/i386/sev.c                  | 228 +++++++++++++++++++++++++++++++++++++
 target/i386/sev_i386.h             |  61 ++++++++++
 7 files changed, 353 insertions(+)
 create mode 100644 target/i386/sev.c
 create mode 100644 target/i386/sev_i386.h

diff --git a/default-configs/i386-softmmu.mak b/default-configs/i386-softmmu.mak
index 3326e3e..8973579 100644
--- a/default-configs/i386-softmmu.mak
+++ b/default-configs/i386-softmmu.mak
@@ -63,3 +63,4 @@ CONFIG_PXB=y
 CONFIG_ACPI_VMGENID=y
 CONFIG_FW_CFG_DMA=y
 CONFIG_I2C=y
+CONFIG_SEV=$(CONFIG_KVM)
diff --git a/default-configs/x86_64-softmmu.mak b/default-configs/x86_64-softmmu.mak
index 1c6cda1..5e27a7a 100644
--- a/default-configs/x86_64-softmmu.mak
+++ b/default-configs/x86_64-softmmu.mak
@@ -63,3 +63,4 @@ CONFIG_PXB=y
 CONFIG_ACPI_VMGENID=y
 CONFIG_FW_CFG_DMA=y
 CONFIG_I2C=y
+CONFIG_SEV=$(CONFIG_KVM)
diff --git a/docs/amd-memory-encryption.txt b/docs/amd-memory-encryption.txt
index 9486a22..f483795 100644
--- a/docs/amd-memory-encryption.txt
+++ b/docs/amd-memory-encryption.txt
@@ -35,10 +35,21 @@ in bad measurement). The guest policy is a 4-byte data structure containing
 several flags that restricts what can be done on running SEV guest.
 See KM Spec section 3 and 6.2 for more details.
 
+The guest policy can be provided via the 'policy' property (see below)
+
+# ${QEMU} \
+   sev-guest,id=sev0,policy=0x1...\
+
 Guest owners provided DH certificate and session parameters will be used to
 establish a cryptographic session with the guest owner to negotiate keys used
 for the attestation.
 
+The DH certificate and session blob can be provided via 'dh-cert-file' and
+'session-file' property (see below
+
+# ${QEMU} \
+     sev-guest,id=sev0,dh-cert-file=<file1>,session-file=<file2>
+
 LAUNCH_UPDATE_DATA encrypts the memory region using the cryptographic context
 created via LAUNCH_START command. If required, this command can be called
 multiple times to encrypt different memory regions. The command also calculates
@@ -59,6 +70,12 @@ context.
 See SEV KM API Spec [1] 'Launching a guest' usage flow (Appendix A) for the
 complete flow chart.
 
+To launch a SEV guest
+
+# ${QEMU} \
+    -machine ...,memory-encryption=sev0 \
+    -object sev-guest,id=sev0,cbitpos=47,reduced-phys-bits=1
+
 Debugging
 -----------
 Since memory contents of SEV guest is encrypted hence hypervisor access to the
diff --git a/qemu-options.hx b/qemu-options.hx
index 4c28014..6113bce 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -4353,6 +4353,50 @@ contents of @code{iv.b64} to the second secret
          data=$SECRET,iv=$(<iv.b64)
 @end example
 
+@item -object sev-guest,id=@var{id},cbitpos=@var{cbitpos},reduced-phys-bits=@var{val},[sev-device=@var{string},policy=@var{policy},handle=@var{handle},dh-cert-file=@var{file},session-file=@var{file}]
+
+Create a Secure Encrypted Virtualization (SEV) guest object, which can be used
+to provide the guest memory encryption support on AMD processors.
+
+When memory encryption is enabled, one of the physical address bit (aka the
+C-bit) is utilized to mark if a memory page is protected. The @option{cbitpos}
+is used to provide the C-bit position. The C-bit position is Host family dependent
+hence user must provide this value. On EPYC, the value should be 47.
+
+When memory encryption is enabled, we loose certain bits in physical address space.
+The @option{reduced-phys-bits} is used to provide the number of bits we loose in
+physical address space. Similar to C-bit, the value is Host family dependent.
+On EPYC, the value should be 5.
+
+The @option{sev-device} provides the device file to use for communicating with
+the SEV firmware running inside AMD Secure Processor. The default device is
+'/dev/sev'. If hardware supports memory encryption then /dev/sev devices are
+created by CCP driver.
+
+The @option{policy} provides the guest policy to be enforced by the SEV firmware
+and restrict what configuration and operational commands can be performed on this
+guest by the hypervisor. The policy should be provided by the guest owner and is
+bound to the guest and cannot be changed throughout the lifetime of the guest.
+The default is 0.
+
+If guest @option{policy} allows sharing the key with another SEV guest then
+@option{handle} can be use to provide handle of the guest from which to share
+the key.
+
+The @option{dh-cert-file} and @option{session-file} provides the guest owner's
+Public Diffie-Hillman key defined in SEV spec. The PDH and session parameters
+are used for establishing a cryptographic session with the guest owner to
+negotiate keys used for attestation. The file must be encoded in base64.
+
+e.g to launch a SEV guest
+@example
+ # $QEMU \
+     ......
+     -object sev-guest,id=sev0,cbitpos=47,reduced-phys-bits=5 \
+     -machine ...,memory-encryption=sev0
+     .....
+
+@end example
 @end table
 
 ETEXI
diff --git a/target/i386/Makefile.objs b/target/i386/Makefile.objs
index f5c6ef2..d4697d8 100644
--- a/target/i386/Makefile.objs
+++ b/target/i386/Makefile.objs
@@ -5,6 +5,7 @@ obj-$(CONFIG_TCG) += int_helper.o mem_helper.o misc_helper.o mpx_helper.o
 obj-$(CONFIG_TCG) += seg_helper.o smm_helper.o svm_helper.o
 obj-$(CONFIG_SOFTMMU) += machine.o arch_memory_mapping.o arch_dump.o monitor.o
 obj-$(CONFIG_KVM) += kvm.o hyperv.o
+obj-$(CONFIG_SEV) += sev.o
 obj-$(call lnot,$(CONFIG_KVM)) += kvm-stub.o
 # HAX support
 ifdef CONFIG_WIN32
diff --git a/target/i386/sev.c b/target/i386/sev.c
new file mode 100644
index 0000000..ab42e4a
--- /dev/null
+++ b/target/i386/sev.c
@@ -0,0 +1,228 @@
+/*
+ * QEMU SEV support
+ *
+ * Copyright Advanced Micro Devices 2016-2018
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
+#include "sev_i386.h"
+#include "sysemu/sysemu.h"
+
+#define DEFAULT_GUEST_POLICY    0x1 /* disable debug */
+#define DEFAULT_SEV_DEVICE      "/dev/sev"
+
+static void
+qsev_guest_finalize(Object *obj)
+{
+}
+
+static char *
+qsev_guest_get_session_file(Object *obj, Error **errp)
+{
+    QSevGuestInfo *s = QSEV_GUEST_INFO(obj);
+
+    return s->session_file ? g_strdup(s->session_file) : NULL;
+}
+
+static void
+qsev_guest_set_session_file(Object *obj, const char *value, Error **errp)
+{
+    QSevGuestInfo *s = QSEV_GUEST_INFO(obj);
+
+    s->session_file = g_strdup(value);
+}
+
+static char *
+qsev_guest_get_dh_cert_file(Object *obj, Error **errp)
+{
+    QSevGuestInfo *s = QSEV_GUEST_INFO(obj);
+
+    return g_strdup(s->dh_cert_file);
+}
+
+static void
+qsev_guest_set_dh_cert_file(Object *obj, const char *value, Error **errp)
+{
+    QSevGuestInfo *s = QSEV_GUEST_INFO(obj);
+
+    s->dh_cert_file = g_strdup(value);
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
+            "SEV device to use", NULL);
+    object_class_property_add_str(oc, "dh-cert-file",
+                                  qsev_guest_get_dh_cert_file,
+                                  qsev_guest_set_dh_cert_file,
+                                  NULL);
+    object_class_property_set_description(oc, "dh-cert-file",
+            "guest owners DH certificate (encoded with base64)", NULL);
+    object_class_property_add_str(oc, "session-file",
+                                  qsev_guest_get_session_file,
+                                  qsev_guest_set_session_file,
+                                  NULL);
+    object_class_property_set_description(oc, "session-file",
+            "guest owners session parameters (encoded with base64)", NULL);
+}
+
+static void
+qsev_guest_set_handle(Object *obj, Visitor *v, const char *name,
+                      void *opaque, Error **errp)
+{
+    QSevGuestInfo *sev = QSEV_GUEST_INFO(obj);
+    uint32_t value;
+
+    visit_type_uint32(v, name, &value, errp);
+    sev->handle = value;
+}
+
+static void
+qsev_guest_set_policy(Object *obj, Visitor *v, const char *name,
+                      void *opaque, Error **errp)
+{
+    QSevGuestInfo *sev = QSEV_GUEST_INFO(obj);
+    uint32_t value;
+
+    visit_type_uint32(v, name, &value, errp);
+    sev->policy = value;
+}
+
+static void
+qsev_guest_set_cbitpos(Object *obj, Visitor *v, const char *name,
+                       void *opaque, Error **errp)
+{
+    QSevGuestInfo *sev = QSEV_GUEST_INFO(obj);
+    uint32_t value;
+
+    visit_type_uint32(v, name, &value, errp);
+    sev->cbitpos = value;
+}
+
+static void
+qsev_guest_set_reduced_phys_bits(Object *obj, Visitor *v, const char *name,
+                                   void *opaque, Error **errp)
+{
+    QSevGuestInfo *sev = QSEV_GUEST_INFO(obj);
+    uint32_t value;
+
+    visit_type_uint32(v, name, &value, errp);
+    sev->reduced_phys_bits = value;
+}
+
+static void
+qsev_guest_get_policy(Object *obj, Visitor *v, const char *name,
+                      void *opaque, Error **errp)
+{
+    uint32_t value;
+    QSevGuestInfo *sev = QSEV_GUEST_INFO(obj);
+
+    value = sev->policy;
+    visit_type_uint32(v, name, &value, errp);
+}
+
+static void
+qsev_guest_get_handle(Object *obj, Visitor *v, const char *name,
+                      void *opaque, Error **errp)
+{
+    uint32_t value;
+    QSevGuestInfo *sev = QSEV_GUEST_INFO(obj);
+
+    value = sev->handle;
+    visit_type_uint32(v, name, &value, errp);
+}
+
+static void
+qsev_guest_get_cbitpos(Object *obj, Visitor *v, const char *name,
+                       void *opaque, Error **errp)
+{
+    uint32_t value;
+    QSevGuestInfo *sev = QSEV_GUEST_INFO(obj);
+
+    value = sev->cbitpos;
+    visit_type_uint32(v, name, &value, errp);
+}
+
+static void
+qsev_guest_get_reduced_phys_bits(Object *obj, Visitor *v, const char *name,
+                                   void *opaque, Error **errp)
+{
+    uint32_t value;
+    QSevGuestInfo *sev = QSEV_GUEST_INFO(obj);
+
+    value = sev->reduced_phys_bits;
+    visit_type_uint32(v, name, &value, errp);
+}
+
+static void
+qsev_guest_init(Object *obj)
+{
+    QSevGuestInfo *sev = QSEV_GUEST_INFO(obj);
+
+    sev->sev_device = g_strdup(DEFAULT_SEV_DEVICE);
+    sev->policy = DEFAULT_GUEST_POLICY;
+    object_property_add(obj, "policy", "uint32", qsev_guest_get_policy,
+                        qsev_guest_set_policy, NULL, NULL, NULL);
+    object_property_add(obj, "handle", "uint32", qsev_guest_get_handle,
+                        qsev_guest_set_handle, NULL, NULL, NULL);
+    object_property_add(obj, "cbitpos", "uint32", qsev_guest_get_cbitpos,
+                        qsev_guest_set_cbitpos, NULL, NULL, NULL);
+    object_property_add(obj, "reduced-phys-bits", "uint32",
+                        qsev_guest_get_reduced_phys_bits,
+                        qsev_guest_set_reduced_phys_bits, NULL, NULL, NULL);
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
+sev_register_types(void)
+{
+    type_register_static(&qsev_guest_info);
+}
+
+type_init(sev_register_types);
diff --git a/target/i386/sev_i386.h b/target/i386/sev_i386.h
new file mode 100644
index 0000000..caf879c
--- /dev/null
+++ b/target/i386/sev_i386.h
@@ -0,0 +1,61 @@
+/*
+ * QEMU Secure Encrypted Virutualization (SEV) support
+ *
+ * Copyright: Advanced Micro Devices, 2016-2018
+ *
+ * Authors:
+ *  Brijesh Singh <brijesh.singh@amd.com>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ *
+ */
+
+#ifndef QEMU_SEV_I386_H
+#define QEMU_SEV_I386_H
+
+#include "qom/object.h"
+#include "qapi/error.h"
+#include "sysemu/kvm.h"
+#include "qemu/error-report.h"
+
+#define SEV_POLICY_NODBG        0x1
+#define SEV_POLICY_NOKS         0x2
+#define SEV_POLICY_ES           0x4
+#define SEV_POLICY_NOSEND       0x8
+#define SEV_POLICY_DOMAIN       0x10
+#define SEV_POLICY_SEV          0x20
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
+ * # $QEMU \
+ *         -object sev-guest,id=sev0 \
+ *         -machine ...,memory-encryption=sev0
+ */
+struct QSevGuestInfo {
+    Object parent_obj;
+
+    char *sev_device;
+    uint32_t policy;
+    uint32_t handle;
+    char *dh_cert_file;
+    char *session_file;
+    uint32_t cbitpos;
+    uint32_t reduced_phys_bits;
+};
+
+struct QSevGuestInfoClass {
+    ObjectClass parent_class;
+};
+
+#endif
-- 
1.8.3.1
