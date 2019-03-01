Received: from eggs.gnu.org ([209.51.188.92]:59852)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1gziVy-0002w4-MY
	for qemu-devel@nongnu.org; Fri, 01 Mar 2019 08:47:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1gziVx-0002p3-Ls
	for qemu-devel@nongnu.org; Fri, 01 Mar 2019 08:47:50 -0500
From: Eric Auger <eric.auger@redhat.com>
Date: Fri,  1 Mar 2019 14:47:03 +0100
Message-Id: <20190301134709.4695-5-eric.auger@redhat.com>
In-Reply-To: <20190301134709.4695-1-eric.auger@redhat.com>
References: <20190301134709.4695-1-eric.auger@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v11 04/10] hw/boards: Add a MachineState
 parameter to kvm_type callback
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org, peter.maydell@linaro.org, shameerali.kolothum.thodi@huawei.com, imammedo@redhat.com, david@redhat.com
Cc: dgilbert@redhat.com, david@gibson.dropbear.id.au, drjones@redhat.com, pbonzini@redhat.com

On ARM, the kvm_type will be resolved by querying the KVMState.
Let's add the MachineState handle to the callback so that we
can retrieve the  KVMState handle. in kvm_init, when the callback
is called, the kvm_state variable is not yet set.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
Acked-by: David Gibson <david@gibson.dropbear.id.au>
[ppc parts]
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>

---
v7 -> v8: added Igor's R-b
v6 -> v7:
- add a comment for kvm_type
- use machine instead of ms in the declaration
- add Peter's R-b
---
 accel/kvm/kvm-all.c   | 2 +-
 hw/ppc/mac_newworld.c | 3 +--
 hw/ppc/mac_oldworld.c | 2 +-
 hw/ppc/spapr.c        | 2 +-
 include/hw/boards.h   | 5 ++++-
 5 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index fd92b6f375..241db496c3 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -1593,7 +1593,7 @@ static int kvm_init(MachineState *ms)
=20
     kvm_type =3D qemu_opt_get(qemu_get_machine_opts(), "kvm-type");
     if (mc->kvm_type) {
-        type =3D mc->kvm_type(kvm_type);
+        type =3D mc->kvm_type(ms, kvm_type);
     } else if (kvm_type) {
         ret =3D -EINVAL;
         fprintf(stderr, "Invalid argument kvm-type=3D%s\n", kvm_type);
diff --git a/hw/ppc/mac_newworld.c b/hw/ppc/mac_newworld.c
index 98461052ac..97e8817145 100644
--- a/hw/ppc/mac_newworld.c
+++ b/hw/ppc/mac_newworld.c
@@ -564,8 +564,7 @@ static char *core99_fw_dev_path(FWPathProvider *p, Bu=
sState *bus,
=20
     return NULL;
 }
-
-static int core99_kvm_type(const char *arg)
+static int core99_kvm_type(MachineState *machine, const char *arg)
 {
     /* Always force PR KVM */
     return 2;
diff --git a/hw/ppc/mac_oldworld.c b/hw/ppc/mac_oldworld.c
index 284431ddd6..cc1e463466 100644
--- a/hw/ppc/mac_oldworld.c
+++ b/hw/ppc/mac_oldworld.c
@@ -420,7 +420,7 @@ static char *heathrow_fw_dev_path(FWPathProvider *p, =
BusState *bus,
     return NULL;
 }
=20
-static int heathrow_kvm_type(const char *arg)
+static int heathrow_kvm_type(MachineState *machine, const char *arg)
 {
     /* Always force PR KVM */
     return 2;
diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index b6a571b6f1..d7850ada7d 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -3023,7 +3023,7 @@ static void spapr_machine_init(MachineState *machin=
e)
     }
 }
=20
-static int spapr_kvm_type(const char *vm_type)
+static int spapr_kvm_type(MachineState *machine, const char *vm_type)
 {
     if (!vm_type) {
         return 0;
diff --git a/include/hw/boards.h b/include/hw/boards.h
index b55c9cc087..f7ce553aa1 100644
--- a/include/hw/boards.h
+++ b/include/hw/boards.h
@@ -157,6 +157,9 @@ typedef struct {
  *    should instead use "unimplemented-device" for all memory ranges wh=
ere
  *    the guest will attempt to probe for a device that QEMU doesn't
  *    implement and a stub device is required.
+ * @kvm_type:
+ *    Return the type of KVM corresponding to the kvm-type string option=
 or
+ *    computed based on other criteria such as the host kernel capabilit=
ies.
  */
 struct MachineClass {
     /*< private >*/
@@ -172,7 +175,7 @@ struct MachineClass {
     void (*init)(MachineState *state);
     void (*reset)(void);
     void (*hot_add_cpu)(const int64_t id, Error **errp);
-    int (*kvm_type)(const char *arg);
+    int (*kvm_type)(MachineState *machine, const char *arg);
=20
     BlockInterfaceType block_default_type;
     int units_per_default_bus;
--=20
2.20.1
