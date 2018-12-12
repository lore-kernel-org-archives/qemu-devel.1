Received: from eggs.gnu.org ([2001:4830:134:3::10]:43625)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gX1Eu-0006Aq-MK
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 04:55:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gX1Er-0006bx-QS
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 04:55:36 -0500
From: Cornelia Huck <cohuck@redhat.com>
Date: Wed, 12 Dec 2018 10:55:17 +0100
Message-Id: <20181212095519.6390-5-cohuck@redhat.com>
In-Reply-To: <20181212095519.6390-1-cohuck@redhat.com>
References: <20181212095519.6390-1-cohuck@redhat.com>
Subject: [Qemu-devel] [PULL 4/6] s390x/tod: Properly stop the KVM TOD while
 the guest is not running
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org, David Hildenbrand <david@redhat.com>, Cornelia Huck <cohuck@redhat.com>

From: David Hildenbrand <david@redhat.com>

Just like on other architectures, we should stop the clock while the guest
is not running. This is already properly done for TCG. Right now, doing an
offline migration (stop, migrate, cont) can easily trigger stalls in the
guest.

Even doing a
    (hmp) stop
    ... wait 2 minutes ...
    (hmp) cont
will already trigger stalls.

So whenever the guest stops, backup the KVM TOD. When continuing to run
the guest, restore the KVM TOD.

One special case is starting a simple VM: Reading the TOD from KVM to
stop it right away until the guest is actually started means that the
time of any simple VM will already differ to the host time. We can
simply leave the TOD running and the guest won't be able to recognize
it.

For migration, we actually want to keep the TOD stopped until really
starting the guest. To be able to catch most errors, we should however
try to set the TOD in addition to simply storing it. So we can still
catch basic migration problems.

If anything goes wrong while backing up/restoring the TOD, we have to
ignore it (but print a warning). This is then basically a fallback to
old behavior (TOD remains running).

I tested this very basically with an initrd:
    1. Start a simple VM. Observed that the TOD is kept running. Old
       behavior.
    2. Ordinary live migration. Observed that the TOD is temporarily
       stopped on the destination when setting the new value and
       correctly started when finally starting the guest.
    3. Offline live migration. (stop, migrate, cont). Observed that the
       TOD will be stopped on the source with the "stop" command. On the
       destination, the TOD is temporarily stopped when setting the new
       value and correctly started when finally starting the guest via
       "cont".
    4. Simple stop/cont correctly stops/starts the TOD. (multiple stops
       or conts in a row have no effect, so works as expected)

In the future, we might want to send the guest a special kind of time sync
interrupt under some conditions, so it can synchronize its tod to the
host tod. This is interesting for migration scenarios but also when we
get time sync interrupts ourselves. This however will most probably have
to be handled in KVM (e.g. when the tods differ too much) and is not
desired e.g. when debugging the guest (single stepping should not
result in permanent time syncs). I consider something like that an add-on
on top of this basic "don't break the guest" handling.

Signed-off-by: David Hildenbrand <david@redhat.com>
Message-Id: <20181130094957.4121-1-david@redhat.com>
Acked-by: Christian Borntraeger <borntraeger@de.ibm.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 hw/s390x/tod-kvm.c     | 102 ++++++++++++++++++++++++++++++++++++++++-
 include/hw/s390x/tod.h |   8 +++-
 2 files changed, 107 insertions(+), 3 deletions(-)

diff --git a/hw/s390x/tod-kvm.c b/hw/s390x/tod-kvm.c
index df564ab89c..2456bf7b24 100644
--- a/hw/s390x/tod-kvm.c
+++ b/hw/s390x/tod-kvm.c
@@ -10,10 +10,11 @@
 
 #include "qemu/osdep.h"
 #include "qapi/error.h"
+#include "sysemu/sysemu.h"
 #include "hw/s390x/tod.h"
 #include "kvm_s390x.h"
 
-static void kvm_s390_tod_get(const S390TODState *td, S390TOD *tod, Error **errp)
+static void kvm_s390_get_tod_raw(S390TOD *tod, Error **errp)
 {
     int r;
 
@@ -27,7 +28,17 @@ static void kvm_s390_tod_get(const S390TODState *td, S390TOD *tod, Error **errp)
     }
 }
 
-static void kvm_s390_tod_set(S390TODState *td, const S390TOD *tod, Error **errp)
+static void kvm_s390_tod_get(const S390TODState *td, S390TOD *tod, Error **errp)
+{
+    if (td->stopped) {
+        *tod = td->base;
+        return;
+    }
+
+    kvm_s390_get_tod_raw(tod, errp);
+}
+
+static void kvm_s390_set_tod_raw(const S390TOD *tod, Error **errp)
 {
     int r;
 
@@ -41,18 +52,105 @@ static void kvm_s390_tod_set(S390TODState *td, const S390TOD *tod, Error **errp)
     }
 }
 
+static void kvm_s390_tod_set(S390TODState *td, const S390TOD *tod, Error **errp)
+{
+    Error *local_err = NULL;
+
+    /*
+     * Somebody (e.g. migration) set the TOD. We'll store it into KVM to
+     * properly detect errors now but take a look at the runstate to decide
+     * whether really to keep the tod running. E.g. during migration, this
+     * is the point where we want to stop the initially running TOD to fire
+     * it back up when actually starting the migrated guest.
+     */
+    kvm_s390_set_tod_raw(tod, &local_err);
+    if (local_err) {
+        error_propagate(errp, local_err);
+        return;
+    }
+
+    if (runstate_is_running()) {
+        td->stopped = false;
+    } else {
+        td->stopped = true;
+        td->base = *tod;
+    }
+}
+
+static void kvm_s390_tod_vm_state_change(void *opaque, int running,
+                                         RunState state)
+{
+    S390TODState *td = opaque;
+    Error *local_err = NULL;
+
+    if (running && td->stopped) {
+        /* Set the old TOD when running the VM - start the TOD clock. */
+        kvm_s390_set_tod_raw(&td->base, &local_err);
+        if (local_err) {
+            warn_report_err(local_err);
+        }
+        /* Treat errors like the TOD was running all the time. */
+        td->stopped = false;
+    } else if (!running && !td->stopped) {
+        /* Store the TOD when stopping the VM - stop the TOD clock. */
+        kvm_s390_get_tod_raw(&td->base, &local_err);
+        if (local_err) {
+            /* Keep the TOD running in case we could not back it up. */
+            warn_report_err(local_err);
+        } else {
+            td->stopped = true;
+        }
+    }
+}
+
+static void kvm_s390_tod_realize(DeviceState *dev, Error **errp)
+{
+    S390TODState *td = S390_TOD(dev);
+    S390TODClass *tdc = S390_TOD_GET_CLASS(td);
+    Error *local_err = NULL;
+
+    tdc->parent_realize(dev, &local_err);
+    if (local_err) {
+        error_propagate(errp, local_err);
+        return;
+    }
+
+    /*
+     * We need to know when the VM gets started/stopped to start/stop the TOD.
+     * As we can never have more than one TOD instance (and that will never be
+     * removed), registering here and never unregistering is good enough.
+     */
+    qemu_add_vm_change_state_handler(kvm_s390_tod_vm_state_change, td);
+}
+
 static void kvm_s390_tod_class_init(ObjectClass *oc, void *data)
 {
     S390TODClass *tdc = S390_TOD_CLASS(oc);
 
+    device_class_set_parent_realize(DEVICE_CLASS(oc), kvm_s390_tod_realize,
+                                    &tdc->parent_realize);
     tdc->get = kvm_s390_tod_get;
     tdc->set = kvm_s390_tod_set;
 }
 
+static void kvm_s390_tod_init(Object *obj)
+{
+    S390TODState *td = S390_TOD(obj);
+
+    /*
+     * The TOD is initially running (value stored in KVM). Avoid needless
+     * loading/storing of the TOD when starting a simple VM, so let it
+     * run although the (never started) VM is stopped. For migration, we
+     * will properly set the TOD later.
+     */
+    td->stopped = false;
+}
+
 static TypeInfo kvm_s390_tod_info = {
     .name = TYPE_KVM_S390_TOD,
     .parent = TYPE_S390_TOD,
     .instance_size = sizeof(S390TODState),
+    .instance_init = kvm_s390_tod_init,
     .class_init = kvm_s390_tod_class_init,
     .class_size = sizeof(S390TODClass),
 };
diff --git a/include/hw/s390x/tod.h b/include/hw/s390x/tod.h
index 413c0d7c02..cbd7552e7a 100644
--- a/include/hw/s390x/tod.h
+++ b/include/hw/s390x/tod.h
@@ -31,13 +31,19 @@ typedef struct S390TODState {
     /* private */
     DeviceState parent_obj;
 
-    /* unused by KVM implementation */
+    /*
+     * Used by TCG to remember the time base. Used by KVM to backup the TOD
+     * while the TOD is stopped.
+     */
     S390TOD base;
+    /* Used by KVM to remember if the TOD is stopped and base is valid. */
+    bool stopped;
 } S390TODState;
 
 typedef struct S390TODClass {
     /* private */
     DeviceClass parent_class;
+    void (*parent_realize)(DeviceState *dev, Error **errp);
 
     /* public */
     void (*get)(const S390TODState *td, S390TOD *tod, Error **errp);
-- 
2.17.2
