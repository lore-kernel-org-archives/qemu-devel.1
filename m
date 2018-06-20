Received: from eggs.gnu.org ([2001:4830:134:3::10]:50950)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1fVcq2-0004SL-IN
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 09:07:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1fVcq1-0005hV-D4
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 09:07:54 -0400
From: Eric Auger <eric.auger@redhat.com>
Date: Wed, 20 Jun 2018 15:07:29 +0200
Message-Id: <1529500053-21704-3-git-send-email-eric.auger@redhat.com>
In-Reply-To: <1529500053-21704-1-git-send-email-eric.auger@redhat.com>
References: <1529500053-21704-1-git-send-email-eric.auger@redhat.com>
Subject: [Qemu-devel] [RFC 2/6] hw/boards: Add a MachineState parameter to
 kvm_type callback
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org, peter.maydell@linaro.org
Cc: dgilbert@redhat.com, agraf@suse.de, david@gibson.dropbear.id.au, drjones@redhat.com, wei@redhat.com, suzuki.poulose@arm.com

On ARM, the kvm_type will be resolved by querying the KVMState.
Let's add the MachineState handle to the callback so that we
can retrieve the  KVMState handle. in kvm_init, when the callback
is called, the kvm_state variable is not yet set.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
---
 accel/kvm/kvm-all.c   | 2 +-
 hw/ppc/mac_newworld.c | 2 +-
 hw/ppc/mac_oldworld.c | 2 +-
 hw/ppc/spapr.c        | 2 +-
 include/hw/boards.h   | 2 +-
 5 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index ffee68e..0590986 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -1550,7 +1550,7 @@ static int kvm_init(MachineState *ms)
 
     kvm_type = qemu_opt_get(qemu_get_machine_opts(), "kvm-type");
     if (mc->kvm_type) {
-        type = mc->kvm_type(kvm_type);
+        type = mc->kvm_type(ms, kvm_type);
     } else if (kvm_type) {
         ret = -EINVAL;
         fprintf(stderr, "Invalid argument kvm-type=%s\n", kvm_type);
diff --git a/hw/ppc/mac_newworld.c b/hw/ppc/mac_newworld.c
index 744acdf..1409d9e 100644
--- a/hw/ppc/mac_newworld.c
+++ b/hw/ppc/mac_newworld.c
@@ -492,7 +492,7 @@ static void ppc_core99_init(MachineState *machine)
     qemu_register_boot_set(fw_cfg_boot_set, fw_cfg);
 }
 
-static int core99_kvm_type(const char *arg)
+static int core99_kvm_type(MachineState *ms, const char *arg)
 {
     /* Always force PR KVM */
     return 2;
diff --git a/hw/ppc/mac_oldworld.c b/hw/ppc/mac_oldworld.c
index 4608bab..1211fcd 100644
--- a/hw/ppc/mac_oldworld.c
+++ b/hw/ppc/mac_oldworld.c
@@ -363,7 +363,7 @@ static void ppc_heathrow_init(MachineState *machine)
     qemu_register_boot_set(fw_cfg_boot_set, fw_cfg);
 }
 
-static int heathrow_kvm_type(const char *arg)
+static int heathrow_kvm_type(MachineState *ms, const char *arg)
 {
     /* Always force PR KVM */
     return 2;
diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index f59999d..faf078e 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -2834,7 +2834,7 @@ static void spapr_machine_init(MachineState *machine)
     }
 }
 
-static int spapr_kvm_type(const char *vm_type)
+static int spapr_kvm_type(MachineState *ms, const char *vm_type)
 {
     if (!vm_type) {
         return 0;
diff --git a/include/hw/boards.h b/include/hw/boards.h
index ef7457f..78f90a1 100644
--- a/include/hw/boards.h
+++ b/include/hw/boards.h
@@ -170,7 +170,7 @@ struct MachineClass {
     void (*init)(MachineState *state);
     void (*reset)(void);
     void (*hot_add_cpu)(const int64_t id, Error **errp);
-    int (*kvm_type)(const char *arg);
+    int (*kvm_type)(MachineState *ms, const char *arg);
 
     BlockInterfaceType block_default_type;
     int units_per_default_bus;
-- 
2.5.5
