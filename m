Received: from eggs.gnu.org ([209.51.188.92]:54665)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1h1DHd-0001fI-Vw
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 11:51:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1h1DHc-0000yK-RL
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 11:51:13 -0500
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:38098)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1h1DHc-0000xg-Jz
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 11:51:12 -0500
Received: by mail-wm1-x343.google.com with SMTP id a188so3230617wmf.3
	for <qemu-devel@nongnu.org>; Tue, 05 Mar 2019 08:51:12 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
	by smtp.gmail.com with ESMTPSA id 2sm10071495wrg.89.2019.03.05.08.51.10
	for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 05 Mar 2019 08:51:10 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue,  5 Mar 2019 16:50:44 +0000
Message-Id: <20190305165051.26860-16-peter.maydell@linaro.org>
In-Reply-To: <20190305165051.26860-1-peter.maydell@linaro.org>
References: <20190305165051.26860-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 15/22] hw/boards: Add a MachineState parameter
 to kvm_type callback
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Eric Auger <eric.auger@redhat.com>

On ARM, the kvm_type will be resolved by querying the KVMState.
Let's add the MachineState handle to the callback so that we
can retrieve the  KVMState handle. in kvm_init, when the callback
is called, the kvm_state variable is not yet set.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
Acked-by: David Gibson <david@gibson.dropbear.id.au>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Message-id: 20190304101339.25970-5-eric.auger@redhat.com
[ppc parts]
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/boards.h   | 5 ++++-
 accel/kvm/kvm-all.c   | 2 +-
 hw/ppc/mac_newworld.c | 3 +--
 hw/ppc/mac_oldworld.c | 2 +-
 hw/ppc/spapr.c        | 2 +-
 5 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/include/hw/boards.h b/include/hw/boards.h
index 21212f08590..9690c71a6d7 100644
--- a/include/hw/boards.h
+++ b/include/hw/boards.h
@@ -156,6 +156,9 @@ typedef struct {
  *    should instead use "unimplemented-device" for all memory ranges where
  *    the guest will attempt to probe for a device that QEMU doesn't
  *    implement and a stub device is required.
+ * @kvm_type:
+ *    Return the type of KVM corresponding to the kvm-type string option or
+ *    computed based on other criteria such as the host kernel capabilities.
  */
 struct MachineClass {
     /*< private >*/
@@ -171,7 +174,7 @@ struct MachineClass {
     void (*init)(MachineState *state);
     void (*reset)(void);
     void (*hot_add_cpu)(const int64_t id, Error **errp);
-    int (*kvm_type)(const char *arg);
+    int (*kvm_type)(MachineState *machine, const char *arg);
 
     BlockInterfaceType block_default_type;
     int units_per_default_bus;
diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index fd92b6f3754..241db496c3d 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -1593,7 +1593,7 @@ static int kvm_init(MachineState *ms)
 
     kvm_type = qemu_opt_get(qemu_get_machine_opts(), "kvm-type");
     if (mc->kvm_type) {
-        type = mc->kvm_type(kvm_type);
+        type = mc->kvm_type(ms, kvm_type);
     } else if (kvm_type) {
         ret = -EINVAL;
         fprintf(stderr, "Invalid argument kvm-type=%s\n", kvm_type);
diff --git a/hw/ppc/mac_newworld.c b/hw/ppc/mac_newworld.c
index 98461052ac0..97e88171450 100644
--- a/hw/ppc/mac_newworld.c
+++ b/hw/ppc/mac_newworld.c
@@ -564,8 +564,7 @@ static char *core99_fw_dev_path(FWPathProvider *p, BusState *bus,
 
     return NULL;
 }
-
-static int core99_kvm_type(const char *arg)
+static int core99_kvm_type(MachineState *machine, const char *arg)
 {
     /* Always force PR KVM */
     return 2;
diff --git a/hw/ppc/mac_oldworld.c b/hw/ppc/mac_oldworld.c
index 284431ddd68..cc1e463466d 100644
--- a/hw/ppc/mac_oldworld.c
+++ b/hw/ppc/mac_oldworld.c
@@ -420,7 +420,7 @@ static char *heathrow_fw_dev_path(FWPathProvider *p, BusState *bus,
     return NULL;
 }
 
-static int heathrow_kvm_type(const char *arg)
+static int heathrow_kvm_type(MachineState *machine, const char *arg)
 {
     /* Always force PR KVM */
     return 2;
diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index b6a571b6f18..d7850ada7df 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -3023,7 +3023,7 @@ static void spapr_machine_init(MachineState *machine)
     }
 }
 
-static int spapr_kvm_type(const char *vm_type)
+static int spapr_kvm_type(MachineState *machine, const char *vm_type)
 {
     if (!vm_type) {
         return 0;
-- 
2.20.1
