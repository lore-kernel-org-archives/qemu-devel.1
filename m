Received: from eggs.gnu.org ([2001:4830:134:3::10]:36087)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1gD9Kt-0005pn-OL
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 10:31:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1gD9Ks-0007C8-NP
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 10:31:39 -0400
From: Eric Auger <eric.auger@redhat.com>
Date: Thu, 18 Oct 2018 16:30:29 +0200
Message-Id: <20181018143042.29588-4-eric.auger@redhat.com>
In-Reply-To: <20181018143042.29588-1-eric.auger@redhat.com>
References: <20181018143042.29588-1-eric.auger@redhat.com>
Subject: [Qemu-devel] [RFC v4 03/16] hw/boards: Add a MachineState parameter
 to kvm_type callback
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org, peter.maydell@linaro.org, shameerali.kolothum.thodi@huawei.com, kwangwoo.lee@sk.com, imammedo@redhat.com, david@redhat.com
Cc: drjones@redhat.com, dgilbert@redhat.com, Suzuki.Poulose@arm.com

On ARM, the kvm_type will be resolved by querying the KVMState.
Let's add the MachineState handle to the callback so that we
can retrieve the  KVMState handle. in kvm_init, when the callback
is called, the kvm_state variable is not yet set.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
Acked-by: David Gibson <david@gibson.dropbear.id.au>
[ppc parts]
---
 accel/kvm/kvm-all.c   | 2 +-
 hw/ppc/mac_newworld.c | 3 +--
 hw/ppc/mac_oldworld.c | 2 +-
 hw/ppc/spapr.c        | 2 +-
 include/hw/boards.h   | 2 +-
 5 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index de12f78eb8..1505342ec5 100644
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
index a630cb81cd..5b897011db 100644
--- a/hw/ppc/mac_newworld.c
+++ b/hw/ppc/mac_newworld.c
@@ -569,8 +569,7 @@ static char *core99_fw_dev_path(FWPathProvider *p, BusState *bus,
 
     return NULL;
 }
-
-static int core99_kvm_type(const char *arg)
+static int core99_kvm_type(MachineState *ms, const char *arg)
 {
     /* Always force PR KVM */
     return 2;
diff --git a/hw/ppc/mac_oldworld.c b/hw/ppc/mac_oldworld.c
index 9891c325a9..67cbd06b0f 100644
--- a/hw/ppc/mac_oldworld.c
+++ b/hw/ppc/mac_oldworld.c
@@ -422,7 +422,7 @@ static char *heathrow_fw_dev_path(FWPathProvider *p, BusState *bus,
     return NULL;
 }
 
-static int heathrow_kvm_type(const char *arg)
+static int heathrow_kvm_type(MachineState *ms, const char *arg)
 {
     /* Always force PR KVM */
     return 2;
diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 98868d893a..18a9d2cf03 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -2821,7 +2821,7 @@ static void spapr_machine_init(MachineState *machine)
     }
 }
 
-static int spapr_kvm_type(const char *vm_type)
+static int spapr_kvm_type(MachineState *ms, const char *vm_type)
 {
     if (!vm_type) {
         return 0;
diff --git a/include/hw/boards.h b/include/hw/boards.h
index f82f28468b..8bc015fb7c 100644
--- a/include/hw/boards.h
+++ b/include/hw/boards.h
@@ -172,7 +172,7 @@ struct MachineClass {
     void (*init)(MachineState *state);
     void (*reset)(void);
     void (*hot_add_cpu)(const int64_t id, Error **errp);
-    int (*kvm_type)(const char *arg);
+    int (*kvm_type)(MachineState *ms, const char *arg);
 
     BlockInterfaceType block_default_type;
     int units_per_default_bus;
-- 
2.17.1
