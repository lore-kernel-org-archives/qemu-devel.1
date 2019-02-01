Received: from eggs.gnu.org ([209.51.188.92]:38436)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ppandit@redhat.com>) id 1gpe9G-0007FI-WE
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 14:06:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ppandit@redhat.com>) id 1gpe9B-0003XM-0p
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 14:06:42 -0500
From: P J P <ppandit@redhat.com>
Date: Sat,  2 Feb 2019 00:23:58 +0530
Message-Id: <20190201185358.6972-1-ppandit@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH] ppc: add host-serial and host-model machine
 attributes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Qemu Developers <qemu-devel@nongnu.org>
Cc: David Gibson <david@gibson.dropbear.id.au>, qemu-ppc@nongnu.org, "Daniel P . Berrange" <berrange@redhat.com>, Prasad J Pandit <pjp@fedoraproject.org>

From: Prasad J Pandit <pjp@fedoraproject.org>

On ppc hosts, hypervisor shares following system attributes

  - /proc/device-tree/system-id
  - /proc/device-tree/model

with a guest. This could lead to information leakage and misuse.[*]
Add machine attributes to control such system information exposure
to a guest.

[*] https://wiki.openstack.org/wiki/OSSN/OSSN-0028

Reported-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
Fix-suggested-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
Signed-off-by: Prasad J Pandit <pjp@fedoraproject.org>
---
 hw/core/machine.c   | 46 +++++++++++++++++++++++++++++++++++++++++++++
 hw/ppc/spapr.c      | 27 ++++++++++++++++++++++++--
 include/hw/boards.h |  2 ++
 qemu-options.hx     | 10 +++++++++-
 util/qemu-config.c  |  8 ++++++++
 5 files changed, 90 insertions(+), 3 deletions(-)

diff --git a/hw/core/machine.c b/hw/core/machine.c
index 2629515363..2d5a52476a 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -476,6 +476,38 @@ static void machine_set_memory_encryption(Object *ob=
j, const char *value,
     ms->memory_encryption =3D g_strdup(value);
 }
=20
+static char *machine_get_host_serial(Object *obj, Error **errp)
+{
+    MachineState *ms =3D MACHINE(obj);
+
+    return g_strdup(ms->host_serial);
+}
+
+static void machine_set_host_serial(Object *obj, const char *value,
+                                    Error **errp)
+{
+    MachineState *ms =3D MACHINE(obj);
+
+    g_free(ms->host_serial);
+    ms->host_serial =3D g_strdup(value);
+}
+
+static char *machine_get_host_model(Object *obj, Error **errp)
+{
+    MachineState *ms =3D MACHINE(obj);
+
+    return g_strdup(ms->host_model);
+}
+
+static void machine_set_host_model(Object *obj, const char *value,
+                                   Error **errp)
+{
+    MachineState *ms =3D MACHINE(obj);
+
+    g_free(ms->host_model);
+    ms->host_model =3D g_strdup(value);
+}
+
 void machine_class_allow_dynamic_sysbus_dev(MachineClass *mc, const char=
 *type)
 {
     strList *item =3D g_new0(strList, 1);
@@ -760,6 +792,18 @@ static void machine_class_init(ObjectClass *oc, void=
 *data)
         &error_abort);
     object_class_property_set_description(oc, "memory-encryption",
         "Set memory encryption object to use", &error_abort);
+
+    object_class_property_add_str(oc, "host-serial",
+        machine_get_host_serial, machine_set_host_serial,
+        &error_abort);
+    object_class_property_set_description(oc, "host-serial",
+        "Set host's system-id to use", &error_abort);
+
+    object_class_property_add_str(oc, "host-model",
+        machine_get_host_model, machine_set_host_model,
+        &error_abort);
+    object_class_property_set_description(oc, "host-model",
+        "Set host's model-id to use", &error_abort);
 }
=20
 static void machine_class_base_init(ObjectClass *oc, void *data)
@@ -785,6 +829,8 @@ static void machine_initfn(Object *obj)
     ms->dump_guest_core =3D true;
     ms->mem_merge =3D true;
     ms->enable_graphics =3D true;
+    ms->host_serial =3D NULL;
+    ms->host_model =3D NULL;
=20
     /* Register notifier when init is done for sysbus sanity checks */
     ms->sysbus_notifier.notify =3D machine_init_notify;
diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 0942f35bf8..b497fe1701 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -1249,11 +1249,34 @@ static void *spapr_build_fdt(sPAPRMachineState *s=
papr,
      * Add info to guest to indentify which host is it being run on
      * and what is the uuid of the guest
      */
-    if (kvmppc_get_host_model(&buf)) {
+    if (machine->host_model && !strcmp(machine->host_model, "none")) {
+        /* -M host-model=3Dnone =3D do not set host-model */
+    } else if (machine->host_model
+        && !strcmp(machine->host_model, "passthrough")) {
+        /* -M host-model=3Dpassthrough */
+        _FDT(fdt_setprop_string(fdt, 0, "host-model", buf));
+        g_free(buf);
+    } else if (machine->host_model) {
+        /* -M host-model=3D<user-string> */
+        _FDT(fdt_setprop_string(fdt, 0, "host-model", machine->host_mode=
l));
+    } else if (kvmppc_get_host_model(&buf)) {
+        /* -M host-model=3Dxxx attribute not supplied */
         _FDT(fdt_setprop_string(fdt, 0, "host-model", buf));
         g_free(buf);
     }
-    if (kvmppc_get_host_serial(&buf)) {
+
+    if (machine->host_serial && !strcmp(machine->host_serial, "none")) {
+        /* -M host-serial=3Dnone =3D do not set host-serial */
+    } else if (machine->host_serial
+        && !strcmp(machine->host_serial, "passthrough")) {
+        /* -M host-serial=3Dpassthrough */
+        _FDT(fdt_setprop_string(fdt, 0, "host-serial", buf));
+        g_free(buf);
+    } else if (machine->host_serial) {
+        /* -M host-serial=3D<user-string> */
+        _FDT(fdt_setprop_string(fdt, 0, "host-serial", machine->host_ser=
ial));
+    } else if (kvmppc_get_host_serial(&buf)) {
+        /* -M host-serial=3Dxxx attribute not supplied */
         _FDT(fdt_setprop_string(fdt, 0, "host-serial", buf));
         g_free(buf);
     }
diff --git a/include/hw/boards.h b/include/hw/boards.h
index 02f114085f..3e63dc4501 100644
--- a/include/hw/boards.h
+++ b/include/hw/boards.h
@@ -257,6 +257,8 @@ struct MachineState {
     bool enforce_config_section;
     bool enable_graphics;
     char *memory_encryption;
+    char *host_serial;
+    char *host_model;
     DeviceMemoryState *device_memory;
=20
     ram_addr_t ram_size;
diff --git a/qemu-options.hx b/qemu-options.hx
index 521511ec13..67ac1a9959 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -43,7 +43,9 @@ DEF("machine", HAS_ARG, QEMU_OPTION_machine, \
     "                suppress-vmdesc=3Don|off disables self-describing m=
igration (default=3Doff)\n"
     "                nvdimm=3Don|off controls NVDIMM support (default=3D=
off)\n"
     "                enforce-config-section=3Don|off enforce configurati=
on section migration (default=3Doff)\n"
-    "                memory-encryption=3D@var{} memory encryption object=
 to use (default=3Dnone)\n",
+    "                memory-encryption=3D@var{} memory encryption object=
 to use (default=3Dnone)\n"
+    "                host-serial=3Dnone|passthrough|string controls host=
 systemd-id (default=3Dpassthrough)\n"
+    "                host-model=3Dnone|passthrough|string controls host =
model-id (default=3Dpassthrough)\n",
     QEMU_ARCH_ALL)
 STEXI
 @item -machine [type=3D]@var{name}[,prop=3D@var{value}[,...]]
@@ -103,6 +105,12 @@ NOTE: this parameter is deprecated. Please use @opti=
on{-global}
 @option{migration.send-configuration}=3D@var{on|off} instead.
 @item memory-encryption=3D@var{}
 Memory encryption object to use. The default is none.
+@item host-serial=3Dnone|passthrough|string
+Pass 'system-id' parameter from host's device-tree to a guest. A user ma=
y
+disable it with 'none' or define a custom string for a guest.
+@item host-model=3Dnone|passthrough|string
+Pass 'model' paramter from host's device-tree to a guest. A user may dis=
able
+it with 'none' or define a custom string for a guest.
 @end table
 ETEXI
=20
diff --git a/util/qemu-config.c b/util/qemu-config.c
index 9d2e278e29..86483ded34 100644
--- a/util/qemu-config.c
+++ b/util/qemu-config.c
@@ -238,6 +238,14 @@ static QemuOptsList machine_opts =3D {
             .help =3D "Up to 8 chars in set of [A-Za-z0-9. ](lower case =
chars"
                     " converted to upper case) to pass to machine"
                     " loader, boot manager, and guest kernel",
+        },{
+            .name =3D "host-serial",
+            .type =3D QEMU_OPT_STRING,
+            .help =3D "host's system-id seen by guest",
+        },{
+            .name =3D "host-model",
+            .type =3D QEMU_OPT_STRING,
+            .help =3D "host's model-id seen by guest",
         },
         { /* End of list */ }
     }
--=20
2.20.1
