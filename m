Received: from eggs.gnu.org ([209.51.188.92]:35848)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1h3T6T-0000B7-Fy
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 18:09:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1h3T6R-0004f7-7D
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 18:09:01 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59028)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1h3T6P-0004dO-D3
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 18:08:57 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 8BD668762D
	for <qemu-devel@nongnu.org>; Mon, 11 Mar 2019 22:08:56 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Mon, 11 Mar 2019 23:08:32 +0100
Message-Id: <20190311220843.4026-17-armbru@redhat.com>
In-Reply-To: <20190311220843.4026-1-armbru@redhat.com>
References: <20190311220843.4026-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 16/27] qdev: Fix latent bug with compat_props
 and onboard devices
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

Compatibility properties started life as a qdev property thing: we
supported them only for qdev properties, and implemented them with the
machinery backing command line option -global.

Recent commit fa0cb34d221 put them to use (tacitly) with memory
backend objects (subtypes of TYPE_MEMORY_BACKEND).  To make that
possible, we first moved the work of applying them from the -global
machinery into TYPE_DEVICE's .instance_post_init() method
device_post_init(), in commits ea9ce8934c5 and b66bbee39f6, then made
it available to TYPE_MEMORY_BACKEND's .instance_post_init() method
host_memory_backend_post_init() as object_apply_compat_props(), in
commit 1c3994f6d2a.

Note the code smell: we now have function name starting with object_
in hw/core/qdev.c.  It has to be there rather than in qom/, because it
calls qdev_get_machine() to find the current accelerator's and
machine's compat_props.

Turns out calling qdev_get_machine() there is problematic.  If we
qdev_create() from a machine's .instance_init() method, we call
device_post_init() and thus qdev_get_machine() before main() can
create "/machine" in QOM.  qdev_get_machine() tries to get it with
container_get(), which "helpfully" creates it as "container" object,
and returns that.  object_apply_compat_props() tries to paper over the
problem by doing nothing when the value of qdev_get_machine() isn't a
TYPE_MACHINE.  But the damage is done already: when main() later
attempts to create the real "/machine", it fails with "attempt to add
duplicate property 'machine' to object (type 'container')", and
aborts.

Since no machine .instance_init() calls qdev_create() so far, the bug
is latent.  But since I want to do that, I get to fix the bug first.

Observe that object_apply_compat_props() doesn't actually need the
MachineState, only its the compat_props member of its MachineClass and
AccelClass.  This permits a simple fix: register MachineClass and
AccelClass compat_props with the object_apply_compat_props() machinery
right after these classes get selected.

This is actually similar to how things worked before commits
ea9ce8934c5 and b66bbee39f6, except we now register much earlier.  The
old code registered them only after the machine's .instance_init()
ran, which would've broken compatibility properties for any devices
created there.

Cc: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Message-Id: <20190308131445.17502-2-armbru@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
---
 accel/accel.c          |  1 +
 hw/core/qdev.c         | 48 ++++++++++++++++++++++++++++++++----------
 include/hw/qdev-core.h |  2 ++
 vl.c                   |  1 +
 4 files changed, 41 insertions(+), 11 deletions(-)

diff --git a/accel/accel.c b/accel/accel.c
index 0d5b370dfd..8deb475b5d 100644
--- a/accel/accel.c
+++ b/accel/accel.c
@@ -66,6 +66,7 @@ static int accel_init_machine(AccelClass *acc, MachineS=
tate *ms)
         *(acc->allowed) =3D false;
         object_unref(OBJECT(accel));
     }
+    object_set_accelerator_compat_props(acc->compat_props);
     return ret;
 }
=20
diff --git a/hw/core/qdev.c b/hw/core/qdev.c
index 512ce7ca7a..4f3200d54b 100644
--- a/hw/core/qdev.c
+++ b/hw/core/qdev.c
@@ -978,25 +978,51 @@ static void device_initfn(Object *obj)
     QLIST_INIT(&dev->gpios);
 }
=20
+/*
+ * Global property defaults
+ * Slot 0: accelerator's global property defaults
+ * Slot 1: machine's global property defaults
+ * Each is a GPtrArray of of GlobalProperty.
+ * Applied in order, later entries override earlier ones.
+ */
+static GPtrArray *object_compat_props[2];
+
+/*
+ * Set machine's global property defaults to @compat_props.
+ * May be called at most once.
+ */
+void object_set_machine_compat_props(GPtrArray *compat_props)
+{
+    assert(!object_compat_props[1]);
+    object_compat_props[1] =3D compat_props;
+}
+
+/*
+ * Set accelerator's global property defaults to @compat_props.
+ * May be called at most once.
+ */
+void object_set_accelerator_compat_props(GPtrArray *compat_props)
+{
+    assert(!object_compat_props[0]);
+    object_compat_props[0] =3D compat_props;
+}
+
 void object_apply_compat_props(Object *obj)
 {
-    if (object_dynamic_cast(qdev_get_machine(), TYPE_MACHINE)) {
-        MachineState *m =3D MACHINE(qdev_get_machine());
-        MachineClass *mc =3D MACHINE_GET_CLASS(m);
+    int i;
=20
-        if (m->accelerator) {
-            AccelClass *ac =3D ACCEL_GET_CLASS(m->accelerator);
-
-            if (ac->compat_props) {
-                object_apply_global_props(obj, ac->compat_props, &error_=
abort);
-            }
-        }
-        object_apply_global_props(obj, mc->compat_props, &error_abort);
+    for (i =3D 0; i < ARRAY_SIZE(object_compat_props); i++) {
+        object_apply_global_props(obj, object_compat_props[i],
+                                  &error_abort);
     }
 }
=20
 static void device_post_init(Object *obj)
 {
+    /*
+     * Note: ordered so that the user's global properties take
+     * precedence.
+     */
     object_apply_compat_props(obj);
     qdev_prop_set_globals(DEVICE(obj));
 }
diff --git a/include/hw/qdev-core.h b/include/hw/qdev-core.h
index 17f09aac72..aa8a3ea782 100644
--- a/include/hw/qdev-core.h
+++ b/include/hw/qdev-core.h
@@ -431,6 +431,8 @@ const char *qdev_fw_name(DeviceState *dev);
=20
 Object *qdev_get_machine(void);
=20
+void object_set_machine_compat_props(GPtrArray *compat_props);
+void object_set_accelerator_compat_props(GPtrArray *compat_props);
 void object_apply_compat_props(Object *obj);
=20
 /* FIXME: make this a link<> */
diff --git a/vl.c b/vl.c
index f46f8d769a..5278beaae0 100644
--- a/vl.c
+++ b/vl.c
@@ -3953,6 +3953,7 @@ int main(int argc, char **argv, char **envp)
     configure_rtc(qemu_find_opts_singleton("rtc"));
=20
     machine_class =3D select_machine();
+    object_set_machine_compat_props(machine_class->compat_props);
=20
     set_memory_options(&ram_slots, &maxram_size, machine_class);
=20
--=20
2.17.2
