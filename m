Received: from eggs.gnu.org ([2001:4830:134:3::10]:51537)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gZ6qE-0006Cp-PV
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 23:18:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gZ6qD-00081C-Lj
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 23:18:46 -0500
Received: from mx1.redhat.com ([209.132.183.28]:58282)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1gZ6qD-00080L-DI
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 23:18:45 -0500
Date: Mon, 17 Dec 2018 23:18:41 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20181218041625.24969-32-mst@redhat.com>
References: <20181218041625.24969-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181218041625.24969-1-mst@redhat.com>
Subject: [Qemu-devel] [PULL 31/31] hw/i386: Remove deprecated machines
 pc-0.10 and pc-0.11
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, libvir-list@redhat.com, Laurent Vivier <lvivier@redhat.com>

From: Thomas Huth <thuth@redhat.com>

They've been deprecated for two releases and nobody complained that they
are still required anymore, so it's time to remove these now.
And while we're at it, mark the other remaining old 0.x machine types
as deprecated (since they can not properly be used for live-migration
anyway).

Signed-off-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>
---
 hw/i386/pc_piix.c     | 70 ++-----------------------------------------
 tests/cpu-plug-test.c |  4 +--
 qemu-deprecated.texi  |  2 +-
 3 files changed, 4 insertions(+), 72 deletions(-)

diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index e000c7511a..7f1cb527b5 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -368,7 +368,7 @@ static void pc_compat_1_2(MachineState *machine)
     x86_cpu_change_kvm_default("kvm-pv-eoi", NULL);
 }
 
-/* PC compat function for pc-0.10 to pc-0.13 */
+/* PC compat function for pc-0.12 and pc-0.13 */
 static void pc_compat_0_13(MachineState *machine)
 {
     pc_compat_1_2(machine);
@@ -834,6 +834,7 @@ static void pc_i440fx_0_15_machine_options(MachineClass *m)
 {
     pc_i440fx_1_0_machine_options(m);
     m->hw_version = "0.15";
+    m->deprecation_reason = "use a newer machine type instead";
     SET_MACHINE_COMPAT(m, PC_COMPAT_0_15);
 }
 
@@ -951,73 +952,6 @@ static void pc_i440fx_0_12_machine_options(MachineClass *m)
 DEFINE_I440FX_MACHINE(v0_12, "pc-0.12", pc_compat_0_13,
                       pc_i440fx_0_12_machine_options);
 
-
-#define PC_COMPAT_0_11 \
-        PC_CPU_MODEL_IDS("0.11") \
-        {\
-            .driver   = "virtio-blk-pci",\
-            .property = "vectors",\
-            .value    = stringify(0),\
-        },{\
-            .driver   = TYPE_PCI_DEVICE,\
-            .property = "rombar",\
-            .value    = stringify(0),\
-        },{\
-            .driver   = "ide-drive",\
-            .property = "ver",\
-            .value    = "0.11",\
-        },{\
-            .driver   = "scsi-disk",\
-            .property = "ver",\
-            .value    = "0.11",\
-        },
-
-static void pc_i440fx_0_11_machine_options(MachineClass *m)
-{
-    pc_i440fx_0_12_machine_options(m);
-    m->hw_version = "0.11";
-    m->deprecation_reason = "use a newer machine type instead";
-    SET_MACHINE_COMPAT(m, PC_COMPAT_0_11);
-}
-
-DEFINE_I440FX_MACHINE(v0_11, "pc-0.11", pc_compat_0_13,
-                      pc_i440fx_0_11_machine_options);
-
-
-#define PC_COMPAT_0_10 \
-    PC_CPU_MODEL_IDS("0.10") \
-    {\
-        .driver   = "virtio-blk-pci",\
-        .property = "class",\
-        .value    = stringify(PCI_CLASS_STORAGE_OTHER),\
-    },{\
-        .driver   = "virtio-serial-pci",\
-        .property = "class",\
-        .value    = stringify(PCI_CLASS_DISPLAY_OTHER),\
-    },{\
-        .driver   = "virtio-net-pci",\
-        .property = "vectors",\
-        .value    = stringify(0),\
-    },{\
-        .driver   = "ide-drive",\
-        .property = "ver",\
-        .value    = "0.10",\
-    },{\
-        .driver   = "scsi-disk",\
-        .property = "ver",\
-        .value    = "0.10",\
-    },
-
-static void pc_i440fx_0_10_machine_options(MachineClass *m)
-{
-    pc_i440fx_0_11_machine_options(m);
-    m->hw_version = "0.10";
-    SET_MACHINE_COMPAT(m, PC_COMPAT_0_10);
-}
-
-DEFINE_I440FX_MACHINE(v0_10, "pc-0.10", pc_compat_0_13,
-                      pc_i440fx_0_10_machine_options);
-
 typedef struct {
     uint16_t gpu_device_id;
     uint16_t pch_device_id;
diff --git a/tests/cpu-plug-test.c b/tests/cpu-plug-test.c
index f4a677d238..668f00144e 100644
--- a/tests/cpu-plug-test.c
+++ b/tests/cpu-plug-test.c
@@ -157,9 +157,7 @@ static void add_pc_test_case(const char *mname)
         (strcmp(mname, "pc-0.15") == 0) ||
         (strcmp(mname, "pc-0.14") == 0) ||
         (strcmp(mname, "pc-0.13") == 0) ||
-        (strcmp(mname, "pc-0.12") == 0) ||
-        (strcmp(mname, "pc-0.11") == 0) ||
-        (strcmp(mname, "pc-0.10") == 0)) {
+        (strcmp(mname, "pc-0.12") == 0)) {
         path = g_strdup_printf("cpu-plug/%s/init/%ux%ux%u&maxcpus=%u",
                                mname, data->sockets, data->cores,
                                data->threads, data->maxcpus);
diff --git a/qemu-deprecated.texi b/qemu-deprecated.texi
index e362d37225..c3735b698e 100644
--- a/qemu-deprecated.texi
+++ b/qemu-deprecated.texi
@@ -134,7 +134,7 @@ their usecases.
 
 @section System emulator machines
 
-@subsection pc-0.10 and pc-0.11 (since 3.0)
+@subsection pc-0.12, pc-0.13, pc-0.14 and pc-0.15 (since 4.0)
 
 These machine types are very old and likely can not be used for live migration
 from old QEMU versions anymore. A newer machine type should be used instead.
-- 
MST
