Received: from eggs.gnu.org ([2001:4830:134:3::10]:40740)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <den@openvz.org>) id 1ePrW7-0001eV-QG
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 10:03:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <den@openvz.org>) id 1ePrW2-0003dE-VL
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 10:03:15 -0500
Received: from mailhub.sw.ru ([195.214.232.25]:41925 helo=relay.sw.ru)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <den@openvz.org>) id 1ePrW2-0003W4-Jg
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 10:03:10 -0500
From: "Denis V. Lunev" <den@openvz.org>
Date: Fri, 15 Dec 2017 18:02:49 +0300
Message-Id: <1513350170-20168-2-git-send-email-den@openvz.org>
In-Reply-To: <1513350170-20168-1-git-send-email-den@openvz.org>
References: <1513350170-20168-1-git-send-email-den@openvz.org>
Subject: [Qemu-devel] [PATCH 1/2] pc, q35: add 2.12 machine types
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: "Denis V. Lunev" <den@openvz.org>, "Michael S. Tsirkin" <mst@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>

Signed-off-by: Denis V. Lunev <den@openvz.org>
CC: "Michael S. Tsirkin" <mst@redhat.com>
CC: Stefan Hajnoczi <stefanha@redhat.com>
CC: Kevin Wolf <kwolf@redhat.com>
CC: Max Reitz <mreitz@redhat.com>
CC: Paolo Bonzini <pbonzini@redhat.com>
CC: Richard Henderson <rth@twiddle.net>
CC: Eduardo Habkost <ehabkost@redhat.com>
---
 include/hw/compat.h  |  2 ++
 include/hw/i386/pc.h |  3 +++
 hw/i386/pc_piix.c    | 13 ++++++++++++-
 hw/i386/pc_q35.c     | 12 +++++++++++-
 4 files changed, 28 insertions(+), 2 deletions(-)

diff --git a/include/hw/compat.h b/include/hw/compat.h
index cf389b4..026fee9 100644
--- a/include/hw/compat.h
+++ b/include/hw/compat.h
@@ -1,6 +1,8 @@
 #ifndef HW_COMPAT_H
 #define HW_COMPAT_H
 
+#define HW_COMPAT_2_11 \
+
 #define HW_COMPAT_2_10 \
     {\
         .driver   = "virtio-mouse-device",\
diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
index ef438bd..e08c492 100644
--- a/include/hw/i386/pc.h
+++ b/include/hw/i386/pc.h
@@ -369,6 +369,9 @@ int e820_add_entry(uint64_t, uint64_t, uint32_t);
 int e820_get_num_entries(void);
 bool e820_get_entry(int, uint32_t, uint64_t *, uint64_t *);
 
+#define PC_COMPAT_2_11 \
+    HW_COMPAT_2_11 \
+
 #define PC_COMPAT_2_10 \
     HW_COMPAT_2_10 \
     {\
diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index 5e47528..25380b0 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -430,13 +430,24 @@ static void pc_i440fx_machine_options(MachineClass *m)
     m->default_display = "std";
 }
 
-static void pc_i440fx_2_11_machine_options(MachineClass *m)
+static void pc_i440fx_2_12_machine_options(MachineClass *m)
 {
     pc_i440fx_machine_options(m);
     m->alias = "pc";
     m->is_default = 1;
 }
 
+DEFINE_I440FX_MACHINE(v2_12, "pc-i440fx-2.12", NULL,
+                      pc_i440fx_2_12_machine_options);
+
+static void pc_i440fx_2_11_machine_options(MachineClass *m)
+{
+    pc_i440fx_2_12_machine_options(m);
+    m->is_default = 0;
+    m->alias = NULL;
+    SET_MACHINE_COMPAT(m, PC_COMPAT_2_11);
+}
+
 DEFINE_I440FX_MACHINE(v2_11, "pc-i440fx-2.11", NULL,
                       pc_i440fx_2_11_machine_options);
 
diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
index d606004..a9b9208 100644
--- a/hw/i386/pc_q35.c
+++ b/hw/i386/pc_q35.c
@@ -303,12 +303,22 @@ static void pc_q35_machine_options(MachineClass *m)
     m->max_cpus = 288;
 }
 
-static void pc_q35_2_11_machine_options(MachineClass *m)
+static void pc_q35_2_12_machine_options(MachineClass *m)
 {
     pc_q35_machine_options(m);
     m->alias = "q35";
 }
 
+DEFINE_Q35_MACHINE(v2_12, "pc-q35-2.12", NULL,
+                   pc_q35_2_12_machine_options);
+
+static void pc_q35_2_11_machine_options(MachineClass *m)
+{
+    pc_q35_2_12_machine_options(m);
+    m->alias = NULL;
+    SET_MACHINE_COMPAT(m, PC_COMPAT_2_11);
+}
+
 DEFINE_Q35_MACHINE(v2_11, "pc-q35-2.11", NULL,
                    pc_q35_2_11_machine_options);
 
-- 
2.7.4
