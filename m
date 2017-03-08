Received: from eggs.gnu.org ([2001:4830:134:3::10]:51957)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <brijesh.singh@amd.com>) id 1clj5U-0005cp-DH
	for qemu-devel@nongnu.org; Wed, 08 Mar 2017 16:25:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <brijesh.singh@amd.com>) id 1clj5R-0005Tl-13
	for qemu-devel@nongnu.org; Wed, 08 Mar 2017 16:25:36 -0500
Received: from mail-by2nam03on0067.outbound.protection.outlook.com
	([104.47.42.67]:8043
	helo=NAM03-BY2-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <brijesh.singh@amd.com>)
	id 1clj5Q-0005RB-JG
	for qemu-devel@nongnu.org; Wed, 08 Mar 2017 16:25:32 -0500
From: Brijesh Singh <brijesh.singh@amd.com>
Date: Wed, 8 Mar 2017 15:52:09 -0500
Message-ID: <148900632968.27090.15435012868487968230.stgit@brijesh-build-machine>
In-Reply-To: <148900626714.27090.1616990932333159904.stgit@brijesh-build-machine>
References: <148900626714.27090.1616990932333159904.stgit@brijesh-build-machine>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [RFC PATCH v4 06/20] core: add new security-policy
 object
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

The object can be used to define global security policy for the guest.

object provides two properties:

 1) debug: can be used to disable guest memory access from hypervisor.

   e.g to disable guest memory debug accesses

    # $QEMU \
          -object security-policy,debug=false,id=mypolicy \
          -machine ...,security-policy=mypolicy

 2) memory-encryption: if hypervisor supports memory encryption then this
    property can be used to define object for encryption.

    # $QEMU \
        -object sev-guest,id=sev0 \
        -object security-policy,id=memory-encryption=sev0,id=mypolicy \
        -machine ...,security-policy=mypolicy

The memory-encryption property will be used for enabling AMD's SEV feature.

Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
---
 exec.c                           |    7 ++
 hw/core/Makefile.objs            |    1 
 hw/core/machine.c                |   22 +++++
 hw/core/security-policy.c        |  165 ++++++++++++++++++++++++++++++++++++++
 include/hw/boards.h              |    1 
 include/sysemu/security-policy.h |   75 +++++++++++++++++
 qemu-options.hx                  |   21 +++++
 7 files changed, 292 insertions(+)
 create mode 100644 hw/core/security-policy.c
 create mode 100644 include/sysemu/security-policy.h

diff --git a/exec.c b/exec.c
index 772a959..2c7c891 100644
--- a/exec.c
+++ b/exec.c
@@ -40,6 +40,7 @@
 #else /* !CONFIG_USER_ONLY */
 #include "hw/hw.h"
 #include "exec/memory.h"
+#include "sysemu/security-policy.h"
 #include "exec/ioport.h"
 #include "sysemu/dma.h"
 #include "sysemu/numa.h"
@@ -2926,6 +2927,12 @@ static inline void cpu_physical_memory_rw_debug_internal(AddressSpace *as,
     hwaddr addr1;
     MemoryRegion *mr;
 
+    /* Check if debug accesses is allowed */
+    if (attrs.debug &&
+        !security_policy_debug_allowed(current_machine->security_policy)) {
+        return;
+    }
+
     rcu_read_lock();
     while (len > 0) {
         l = len;
diff --git a/hw/core/Makefile.objs b/hw/core/Makefile.objs
index 91450b2..3c413b1 100644
--- a/hw/core/Makefile.objs
+++ b/hw/core/Makefile.objs
@@ -18,6 +18,7 @@ common-obj-$(CONFIG_SOFTMMU) += qdev-properties-system.o
 common-obj-$(CONFIG_SOFTMMU) += register.o
 common-obj-$(CONFIG_SOFTMMU) += or-irq.o
 common-obj-$(CONFIG_PLATFORM_BUS) += platform-bus.o
+common-obj-$(CONFIG_SOFTMMU) += security-policy.o
 
 obj-$(CONFIG_SOFTMMU) += generic-loader.o
 obj-$(CONFIG_SOFTMMU) += null-machine.o
diff --git a/hw/core/machine.c b/hw/core/machine.c
index 0699750..c14f59c 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -332,6 +332,23 @@ static bool machine_get_enforce_config_section(Object *obj, Error **errp)
     return ms->enforce_config_section;
 }
 
+static char *machine_get_security_policy(Object *obj, Error **errp)
+{
+    MachineState *ms = MACHINE(obj);
+
+    return g_strdup(ms->security_policy);
+}
+
+static void machine_set_security_policy(Object *obj,
+                                        const char *value, Error **errp)
+{
+    MachineState *ms = MACHINE(obj);
+
+    g_free(ms->security_policy);
+    ms->security_policy = g_strdup(value);
+}
+
+
 static void error_on_sysbus_device(SysBusDevice *sbdev, void *opaque)
 {
     error_report("Option '-device %s' cannot be handled by this machine",
@@ -493,6 +510,11 @@ static void machine_class_init(ObjectClass *oc, void *data)
         &error_abort);
     object_class_property_set_description(oc, "enforce-config-section",
         "Set on to enforce configuration section migration", &error_abort);
+
+    object_class_property_add_str(oc, "security-policy",
+            machine_get_security_policy, machine_set_security_policy, NULL);
+    object_class_property_set_description(oc, "security-policy",
+            "Set the security policy for the machine", NULL);
 }
 
 static void machine_class_base_init(ObjectClass *oc, void *data)
diff --git a/hw/core/security-policy.c b/hw/core/security-policy.c
new file mode 100644
index 0000000..4d4658e
--- /dev/null
+++ b/hw/core/security-policy.c
@@ -0,0 +1,165 @@
+/*
+ * QEMU security policy support
+ *
+ * Copyright (c) 2016 Advanced Micro Devices
+ *
+ * Author:
+ *      Brijesh Singh <brijesh.singh@amd.com>
+ *
+ * This library is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU Lesser General Public
+ * License as published by the Free Software Foundation; either
+ * version 2 of the License, or (at your option) any later version.
+ *
+ * This library is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * Lesser General Public License for more details.
+ *
+ * You should have received a copy of the GNU Lesser General Public
+ * License along with this library; if not, see <http://www.gnu.org/licenses/>.
+ *
+ */
+
+#include "qemu/osdep.h"
+#include "qapi/error.h"
+#include "qom/object_interfaces.h"
+#include "qemu/base64.h"
+
+#include "sysemu/security-policy.h"
+
+static SecurityPolicy *
+find_security_policy_obj(const char *name)
+{
+    Object *obj;
+    SecurityPolicy *policy;
+
+    if (!name) {
+        return NULL;
+    }
+
+    obj = object_resolve_path_component(
+        object_get_objects_root(), name);
+    if (!obj) {
+        return NULL;
+    }
+
+    policy = (SecurityPolicy *)
+        object_dynamic_cast(obj,
+                            TYPE_SECURITY_POLICY);
+    if (!policy) {
+        return NULL;
+    }
+
+    return policy;
+}
+
+bool
+security_policy_debug_allowed(const char *secure_policy_id)
+{
+    SecurityPolicy *policy = find_security_policy_obj(secure_policy_id);
+
+    /* if id is not a valid security policy then we return true */
+    return policy ? policy->debug : true;
+}
+
+char *
+security_policy_get_memory_encryption_id(const char *secure_policy_id)
+{
+    SecurityPolicy *policy = find_security_policy_obj(secure_policy_id);
+
+    return policy ? g_strdup(policy->memory_encryption) : NULL;
+}
+
+static bool
+security_policy_prop_get_debug(Object *obj,
+                               Error **errp G_GNUC_UNUSED)
+{
+    SecurityPolicy *policy = SECURITY_POLICY(obj);
+
+    return policy->debug;
+}
+
+
+static void
+security_policy_prop_set_debug(Object *obj,
+                               bool value,
+                               Error **errp G_GNUC_UNUSED)
+{
+    SecurityPolicy *policy = SECURITY_POLICY(obj);
+
+    policy->debug = value;
+}
+
+static char *
+sev_launch_get_memory_encryption(Object *obj, Error **errp)
+{
+    SecurityPolicy *policy = SECURITY_POLICY(obj);
+
+    return g_strdup(policy->memory_encryption);
+}
+
+static void
+sev_launch_set_memory_encryption(Object *obj, const char *value,
+                                 Error **errp)
+{
+    SecurityPolicy *policy = SECURITY_POLICY(obj);
+
+    policy->memory_encryption = g_strdup(value);
+}
+
+static void
+security_policy_init(Object *obj)
+{
+    SecurityPolicy *policy = SECURITY_POLICY(obj);
+
+    policy->debug = true;
+}
+
+static void
+security_policy_finalize(Object *obj)
+{
+}
+
+static void
+security_policy_class_init(ObjectClass *oc, void *data)
+{
+    object_class_property_add_bool(oc, "debug",
+                                   security_policy_prop_get_debug,
+                                   security_policy_prop_set_debug,
+                                   NULL);
+    object_class_property_set_description(oc, "debug",
+            "Set on/off if debugging is allowed on this guest (default on)",
+            NULL);
+    object_class_property_add_str(oc, "memory-encryption",
+                                  sev_launch_get_memory_encryption,
+                                  sev_launch_set_memory_encryption,
+                                  NULL);
+    object_class_property_set_description(oc, "memory-encryption",
+            "Set memory encryption object id (if supported by hardware)",
+            NULL);
+}
+
+static const TypeInfo security_policy_info = {
+    .parent = TYPE_OBJECT,
+    .name = TYPE_SECURITY_POLICY,
+    .instance_size = sizeof(SecurityPolicy),
+    .instance_init = security_policy_init,
+    .instance_finalize = security_policy_finalize,
+    .class_size = sizeof(SecurityPolicyClass),
+    .class_init = security_policy_class_init,
+    .interfaces = (InterfaceInfo[]) {
+        { TYPE_USER_CREATABLE },
+        { }
+    }
+};
+
+
+static void
+security_policy_register_types(void)
+{
+    type_register_static(&security_policy_info);
+}
+
+
+type_init(security_policy_register_types);
diff --git a/include/hw/boards.h b/include/hw/boards.h
index 269d0ba..a1c99a0 100644
--- a/include/hw/boards.h
+++ b/include/hw/boards.h
@@ -153,6 +153,7 @@ struct MachineState {
     /*< public >*/
 
     char *accel;
+    char *security_policy;
     bool kernel_irqchip_allowed;
     bool kernel_irqchip_required;
     bool kernel_irqchip_split;
diff --git a/include/sysemu/security-policy.h b/include/sysemu/security-policy.h
new file mode 100644
index 0000000..6d3789d
--- /dev/null
+++ b/include/sysemu/security-policy.h
@@ -0,0 +1,75 @@
+/*
+ * QEMU security policy support
+ *
+ * Copyright (c) 2016 Advanced Micro Devices
+ *
+ * Author:
+ *      Brijesh Singh <brijesh.singh@amd.com>
+ *
+ * This library is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU Lesser General Public
+ * License as published by the Free Software Foundation; either
+ * version 2 of the License, or (at your option) any later version.
+ *
+ * This library is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * Lesser General Public License for more details.
+ *
+ * You should have received a copy of the GNU Lesser General Public
+ * License along with this library; if not, see <http://www.gnu.org/licenses/>.
+ *
+ */
+
+#ifndef SECURITY_POLICY_H
+#define SECURITY_POLICY_H
+
+#include "qom/object.h"
+
+#define TYPE_SECURITY_POLICY "security-policy"
+#define SECURITY_POLICY(obj)                  \
+    OBJECT_CHECK(SecurityPolicy, (obj), TYPE_SECURITY_POLICY)
+
+typedef struct SecurityPolicy SecurityPolicy;
+typedef struct SecurityPolicyClass SecurityPolicyClass;
+
+/**
+ * SecurityPolicy:
+ *
+ * The SecurityPolicy object provides method to define
+ * various security releated policies for guest machine.
+ *
+ * e.g
+ * When launching QEMU, user can create a security policy
+ * to disallow memory dump and debug of guest
+ *
+ *  # $QEMU \
+ *      -object security-policy,id=mypolicy,debug=off \
+ *      -machine ...,security-policy=mypolicy
+ *
+ * If hardware supports memory encryption then user can set
+ * encryption policy of guest
+ *
+ * # $QEMU \
+ *    -object encrypt-policy,key=xxx,flags=xxxx,id=encrypt \
+ *    -object security-policy,debug=off,memory-encryption=encrypt,id=mypolicy \
+ *    -machine ...,security-policy=mypolicy
+ *
+ */
+
+struct SecurityPolicy {
+    Object parent_obj;
+
+    bool debug;
+    char *memory_encryption;
+};
+
+
+struct SecurityPolicyClass {
+    ObjectClass parent_class;
+};
+
+bool security_policy_debug_allowed(const char *name);
+char *security_policy_get_memory_encryption_id(const char *name);
+
+#endif /* SECURITY_POLICY_H */
diff --git a/qemu-options.hx b/qemu-options.hx
index 2292438..536db1b 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -4140,6 +4140,27 @@ contents of @code{iv.b64} to the second secret
 
 @end table
 
+@item -object security-policy,id=@var{id}[,debug=@var{bool}][,memory-encryption=@var{string}]
+
+Create a security policy object, which can be used to define guest security.
+The id parameter is a unique ID that will be used to reference this
+object when security-policy is applied via -machine argument.
+
+The 'debug' parameter can be defined to tell whether the debugging or memory
+dump is allowed through qemu monitor console.
+
+e.g to disable the guest memory dump
+@example
+ # $QEMU \
+     -object security-policy,id=secure0,debug=off \
+     -machine ...,security-policy=secure0
+@end example
+
+if hardware support guest memory encrytion, then 'memory-encryption' parameter
+can be set to the unquie ID of memory encryption object.
+
+On AMD processor, memory encryption is supported via 'sev-guest' object.
+
 ETEXI
 
 
