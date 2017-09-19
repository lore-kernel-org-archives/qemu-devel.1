Received: from eggs.gnu.org ([2001:4830:134:3::10]:42049)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1duOzH-000546-Cs
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 16:19:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1duOzG-0004Sx-BF
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 16:19:19 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44244)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1duOzG-0004Rz-3G
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 16:19:18 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Tue, 19 Sep 2017 17:18:44 -0300
Message-Id: <20170919201850.14772-7-ehabkost@redhat.com>
In-Reply-To: <20170919201850.14772-1-ehabkost@redhat.com>
References: <20170919201850.14772-1-ehabkost@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 06/12] vl.c: convert cpu_model to cpu type and
 set of global properties before machine_init()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Marcel Apfelbaum <marcel@redhat.com>, Igor Mammedov <imammedo@redhat.com>

From: Igor Mammedov <imammedo@redhat.com>

All machines that support user specified cpu_model either call
cpu_generic_init() or cpu_class_by_name()/CPUClass::parse_features
to parse feature string and to get CPU type to create.

Which leads to code duplication and hard-codding default CPU model
within machine_foo_init() code. Which makes it impossible to
get CPU type before machine_init() is run.

So instead of setting default CPUs models and doing parsing in
target specific machine_foo_init() in various ways, provide
a generic data driven cpu_model parsing before machine_init()
is called.

in follow up per target patches, it will allow to:
  * define default CPU type in consistent/generic manner
    per machine type and drop custom code that fallbacks
    to default if cpu_model is NULL
  * drop custom features parsing in targets and do it
    in centralized way.
  * for cases of
      cpu_generic_init(TYPE_BASE/DEFAULT_CPU, "some_cpu")
    replace it with
      cpu_create(machine->cpu_type) || cpu_create(TYPE_FOO)
    depending if CPU type is user settable or not.
    not doing useless parsing and clearly documenting where
    CPU model is user settable or fixed one.

Patch allows machine subclasses to define default CPU type
per machine class at class_init() time and if that is set
generic code will parse cpu_model into a MachineState::cpu_type
which will be used to create CPUs for that machine instance
and allows gradual per board conversion.

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
Message-Id: <1505318697-77161-4-git-send-email-imammedo@redhat.com>
Acked-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 include/hw/boards.h |  6 ++++++
 vl.c                | 10 ++++++++++
 2 files changed, 16 insertions(+)

diff --git a/include/hw/boards.h b/include/hw/boards.h
index 7f044d101d..6b67adaef6 100644
--- a/include/hw/boards.h
+++ b/include/hw/boards.h
@@ -125,6 +125,10 @@ typedef struct {
  *    Caller is responsible for freeing returned list.
  * @has_hotpluggable_cpus:
  *    If true, board supports CPUs creation with -device/device_add.
+ * @default_cpu_type:
+ *    specifies default CPU_TYPE, which will be used for parsing target
+ *    specific features and for creating CPUs if CPU name wasn't provide=
d
+ *    explicitly at CLI
  * @minimum_page_bits:
  *    If non-zero, the board promises never to create a CPU with a page =
size
  *    smaller than this, so QEMU can use a more efficient larger page
@@ -177,6 +181,7 @@ struct MachineClass {
     GArray *compat_props;
     const char *hw_version;
     ram_addr_t default_ram_size;
+    const char *default_cpu_type;
     bool option_rom_has_mr;
     bool rom_file_has_mr;
     int minimum_page_bits;
@@ -231,6 +236,7 @@ struct MachineState {
     char *kernel_cmdline;
     char *initrd_filename;
     const char *cpu_model;
+    const char *cpu_type;
     AccelState *accelerator;
     CPUArchIdList *possible_cpus;
 };
diff --git a/vl.c b/vl.c
index ad49314608..9bb5058c3a 100644
--- a/vl.c
+++ b/vl.c
@@ -4716,6 +4716,16 @@ int main(int argc, char **argv, char **envp)
     current_machine->boot_order =3D boot_order;
     current_machine->cpu_model =3D cpu_model;
=20
+
+    /* parse features once if machine provides default cpu_type */
+    if (machine_class->default_cpu_type) {
+        current_machine->cpu_type =3D machine_class->default_cpu_type;
+        if (cpu_model) {
+            current_machine->cpu_type =3D
+                cpu_parse_cpu_model(machine_class->default_cpu_type, cpu=
_model);
+        }
+    }
+
     machine_run_board_init(current_machine);
=20
     realtime_init();
--=20
2.13.5
