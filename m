Received: from eggs.gnu.org ([2001:4830:134:3::10]:54708)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1d84zX-0002Jj-6R
	for qemu-devel@nongnu.org; Tue, 09 May 2017 09:15:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1d84zU-0003Rm-1L
	for qemu-devel@nongnu.org; Tue, 09 May 2017 09:15:51 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50968)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1d84zT-0003QE-Og
	for qemu-devel@nongnu.org; Tue, 09 May 2017 09:15:47 -0400
Date: Tue, 9 May 2017 16:15:43 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <1494330527-24163-7-git-send-email-mst@redhat.com>
References: <1494330527-24163-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1494330527-24163-1-git-send-email-mst@redhat.com>
Subject: [Qemu-devel] [PULL 6/8] pc: add 2.10 machine type
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Peter Xu <peterx@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>

From: Peter Xu <peterx@redhat.com>

CC: "Michael S. Tsirkin" <mst@redhat.com>
CC: Paolo Bonzini <pbonzini@redhat.com>
CC: Richard Henderson <rth@twiddle.net>
CC: Eduardo Habkost <ehabkost@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/hw/i386/pc.h |  3 +++
 hw/i386/pc_piix.c    | 15 ++++++++++++---
 hw/i386/pc_q35.c     | 13 +++++++++++--
 3 files changed, 26 insertions(+), 5 deletions(-)

diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
index a57c607..6252e93 100644
--- a/include/hw/i386/pc.h
+++ b/include/hw/i386/pc.h
@@ -376,6 +376,9 @@ int e820_add_entry(uint64_t, uint64_t, uint32_t);
 int e820_get_num_entries(void);
 bool e820_get_entry(int, uint32_t, uint64_t *, uint64_t *);
 
+#define PC_COMPAT_2_9 \
+    HW_COMPAT_2_9 \
+
 #define PC_COMPAT_2_8 \
     HW_COMPAT_2_8 \
     {\
diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index a11190b..8f3d85c 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -437,21 +437,30 @@ static void pc_i440fx_machine_options(MachineClass *m)
     m->default_display = "std";
 }
 
-static void pc_i440fx_2_9_machine_options(MachineClass *m)
+static void pc_i440fx_2_10_machine_options(MachineClass *m)
 {
     pc_i440fx_machine_options(m);
     m->alias = "pc";
     m->is_default = 1;
 }
 
+DEFINE_I440FX_MACHINE(v2_10, "pc-i440fx-2.10", NULL,
+                      pc_i440fx_2_10_machine_options);
+
+static void pc_i440fx_2_9_machine_options(MachineClass *m)
+{
+    pc_i440fx_2_10_machine_options(m);
+    m->is_default = 0;
+    m->alias = NULL;
+    SET_MACHINE_COMPAT(m, PC_COMPAT_2_9);
+}
+
 DEFINE_I440FX_MACHINE(v2_9, "pc-i440fx-2.9", NULL,
                       pc_i440fx_2_9_machine_options);
 
 static void pc_i440fx_2_8_machine_options(MachineClass *m)
 {
     pc_i440fx_2_9_machine_options(m);
-    m->is_default = 0;
-    m->alias = NULL;
     SET_MACHINE_COMPAT(m, PC_COMPAT_2_8);
 }
 
diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
index 0a61a20..cf9a788 100644
--- a/hw/i386/pc_q35.c
+++ b/hw/i386/pc_q35.c
@@ -301,19 +301,28 @@ static void pc_q35_machine_options(MachineClass *m)
     m->max_cpus = 288;
 }
 
-static void pc_q35_2_9_machine_options(MachineClass *m)
+static void pc_q35_2_10_machine_options(MachineClass *m)
 {
     pc_q35_machine_options(m);
     m->alias = "q35";
 }
 
+DEFINE_Q35_MACHINE(v2_10, "pc-q35-2.10", NULL,
+                   pc_q35_2_10_machine_options);
+
+static void pc_q35_2_9_machine_options(MachineClass *m)
+{
+    pc_q35_2_10_machine_options(m);
+    m->alias = NULL;
+    SET_MACHINE_COMPAT(m, PC_COMPAT_2_9);
+}
+
 DEFINE_Q35_MACHINE(v2_9, "pc-q35-2.9", NULL,
                    pc_q35_2_9_machine_options);
 
 static void pc_q35_2_8_machine_options(MachineClass *m)
 {
     pc_q35_2_9_machine_options(m);
-    m->alias = NULL;
     SET_MACHINE_COMPAT(m, PC_COMPAT_2_8);
 }
 
-- 
MST
