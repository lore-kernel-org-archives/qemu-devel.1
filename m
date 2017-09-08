Received: from eggs.gnu.org ([2001:4830:134:3::10]:48999)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1dqK7m-0006Yr-8W
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 10:19:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1dqK7g-0004om-Fo
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 10:19:14 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33992)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1dqK7g-0004nh-6F
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 10:19:08 -0400
Date: Fri, 8 Sep 2017 17:19:03 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <1504880304-12069-3-git-send-email-mst@redhat.com>
References: <1504880304-12069-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1504880304-12069-1-git-send-email-mst@redhat.com>
Subject: [Qemu-devel] [PULL 02/17] pc: add 2.11 machine types
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Marcel Apfelbaum <marcel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>

From: Marcel Apfelbaum <marcel@redhat.com>

Signed-off-by: Marcel Apfelbaum <marcel@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/hw/i386/pc.h |  3 +++
 hw/i386/pc_piix.c    | 15 ++++++++++++---
 hw/i386/pc_q35.c     | 13 +++++++++++--
 3 files changed, 26 insertions(+), 5 deletions(-)

diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
index d80859b..8226904 100644
--- a/include/hw/i386/pc.h
+++ b/include/hw/i386/pc.h
@@ -369,6 +369,9 @@ int e820_add_entry(uint64_t, uint64_t, uint32_t);
 int e820_get_num_entries(void);
 bool e820_get_entry(int, uint32_t, uint64_t *, uint64_t *);
 
+#define PC_COMPAT_2_10 \
+    HW_COMPAT_2_10 \
+
 #define PC_COMPAT_2_9 \
     HW_COMPAT_2_9 \
     {\
diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index 46dfd2c..b03cc04 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -436,21 +436,30 @@ static void pc_i440fx_machine_options(MachineClass *m)
     m->default_display = "std";
 }
 
-static void pc_i440fx_2_10_machine_options(MachineClass *m)
+static void pc_i440fx_2_11_machine_options(MachineClass *m)
 {
     pc_i440fx_machine_options(m);
     m->alias = "pc";
     m->is_default = 1;
 }
 
+DEFINE_I440FX_MACHINE(v2_11, "pc-i440fx-2.11", NULL,
+                      pc_i440fx_2_11_machine_options);
+
+static void pc_i440fx_2_10_machine_options(MachineClass *m)
+{
+    pc_i440fx_2_11_machine_options(m);
+    m->is_default = 0;
+    m->alias = NULL;
+    SET_MACHINE_COMPAT(m, PC_COMPAT_2_10);
+}
+
 DEFINE_I440FX_MACHINE(v2_10, "pc-i440fx-2.10", NULL,
                       pc_i440fx_2_10_machine_options);
 
 static void pc_i440fx_2_9_machine_options(MachineClass *m)
 {
     pc_i440fx_2_10_machine_options(m);
-    m->is_default = 0;
-    m->alias = NULL;
     SET_MACHINE_COMPAT(m, PC_COMPAT_2_9);
     m->numa_auto_assign_ram = numa_legacy_auto_assign_ram;
 }
diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
index 169a214..c1cba58 100644
--- a/hw/i386/pc_q35.c
+++ b/hw/i386/pc_q35.c
@@ -302,10 +302,20 @@ static void pc_q35_machine_options(MachineClass *m)
     m->max_cpus = 288;
 }
 
-static void pc_q35_2_10_machine_options(MachineClass *m)
+static void pc_q35_2_11_machine_options(MachineClass *m)
 {
     pc_q35_machine_options(m);
     m->alias = "q35";
+}
+
+DEFINE_Q35_MACHINE(v2_11, "pc-q35-2.11", NULL,
+                   pc_q35_2_11_machine_options);
+
+static void pc_q35_2_10_machine_options(MachineClass *m)
+{
+    pc_q35_2_11_machine_options(m);
+    m->alias = NULL;
+    SET_MACHINE_COMPAT(m, PC_COMPAT_2_10);
     m->numa_auto_assign_ram = numa_legacy_auto_assign_ram;
 }
 
@@ -315,7 +325,6 @@ DEFINE_Q35_MACHINE(v2_10, "pc-q35-2.10", NULL,
 static void pc_q35_2_9_machine_options(MachineClass *m)
 {
     pc_q35_2_10_machine_options(m);
-    m->alias = NULL;
     SET_MACHINE_COMPAT(m, PC_COMPAT_2_9);
 }
 
-- 
MST
