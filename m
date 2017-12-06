Received: from eggs.gnu.org ([2001:4830:134:3::10]:49696)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <brijesh.singh@amd.com>) id 1eMfvo-0005z3-PS
	for qemu-devel@nongnu.org; Wed, 06 Dec 2017 15:04:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <brijesh.singh@amd.com>) id 1eMfvl-0002Ut-HD
	for qemu-devel@nongnu.org; Wed, 06 Dec 2017 15:04:36 -0500
Received: from mail-sn1nam01on0050.outbound.protection.outlook.com
	([104.47.32.50]:47424
	helo=NAM01-SN1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <brijesh.singh@amd.com>)
	id 1eMfvl-0002UU-93
	for qemu-devel@nongnu.org; Wed, 06 Dec 2017 15:04:33 -0500
From: Brijesh Singh <brijesh.singh@amd.com>
Date: Wed,  6 Dec 2017 14:03:32 -0600
Message-Id: <20171206200346.116537-10-brijesh.singh@amd.com>
In-Reply-To: <20171206200346.116537-1-brijesh.singh@amd.com>
References: <20171206200346.116537-1-brijesh.singh@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v5 09/23] accel: add Secure Encrypted
 Virtulization (SEV) object
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

Add a new memory encryption object 'sev-guest'. The object will be used
to create enrypted VMs on AMD EPYC CPU. The object provides the properties
to pass guest owner's public Diffie-hellman key, guest policy and session
information required to create the memory encryption context within the
SEV firmware.

e.g to launch SEV guest
 # $QEMU \
    -object sev-guest,id=sev0 \
    -machine ....,memory-encryption=sev0

Cc: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
---
 accel/kvm/Makefile.objs        |   2 +-
 accel/kvm/sev.c                | 179 +++++++++++++++++++++++++++++++++++++++++
 docs/amd-memory-encryption.txt |  17 ++++
 include/sysemu/sev.h           |  53 ++++++++++++
 qemu-options.hx                |  34 ++++++++
 5 files changed, 284 insertions(+), 1 deletion(-)
 create mode 100644 accel/kvm/sev.c
 create mode 100644 include/sysemu/sev.h

diff --git a/accel/kvm/Makefile.objs b/accel/kvm/Makefile.objs
index 85351e7de7e8..666ceef3dae3 100644
--- a/accel/kvm/Makefile.objs
+++ b/accel/kvm/Makefile.objs
@@ -1 +1 @@
-obj-$(CONFIG_KVM) += kvm-all.o
+obj-$(CONFIG_KVM) += kvm-all.o sev.o
diff --git a/accel/kvm/sev.c b/accel/kvm/sev.c
new file mode 100644
index 000000000000..a9b9a63c2da0
--- /dev/null
+++ b/accel/kvm/sev.c
@@ -0,0 +1,179 @@
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
diff --git a/docs/amd-memory-encryption.txt b/docs/amd-memory-encryption.txt
index 72a92b6c6353..1527f603ea2a 100644
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
+    -object sev-guest,id=sev0
+
 Debugging
 -----------
 Since memory contents of SEV guest is encrypted hence hypervisor access to the
diff --git a/include/sysemu/sev.h b/include/sysemu/sev.h
new file mode 100644
index 000000000000..e00794ec1805
--- /dev/null
+++ b/include/sysemu/sev.h
@@ -0,0 +1,53 @@
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
+#include "qom/object.h"
+#include "qapi/error.h"
+#include "sysemu/kvm.h"
+#include "qemu/error-report.h"
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
+};
+
+struct QSevGuestInfoClass {
+    ObjectClass parent_class;
+};
+
+#endif
+
diff --git a/qemu-options.hx b/qemu-options.hx
index 5385832707e0..4611db3c1d51 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -4470,6 +4470,40 @@ contents of @code{iv.b64} to the second secret
          data=$SECRET,iv=$(<iv.b64)
 @end example
 
+@item -object sev-guest,id=@var{id},sev-device=@var{string}[,policy=@var{policy},handle=@var{handle},dh-cert-file=@var{file},session-file=@var{file}]
+
+Create a Secure Encrypted Virtualization (SEV) guest object, which can be used
+to provide the guest memory encryption support on AMD processors.
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
+     -object sev-guest,id=sev0 \
+     -machine ...,memory-encryption=sev0
+     .....
+
+@end example
 @end table
 
 ETEXI
-- 
2.9.5
