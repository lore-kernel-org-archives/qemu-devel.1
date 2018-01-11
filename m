Received: from eggs.gnu.org ([2001:4830:134:3::10]:52105)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1eZkXd-00008x-Uu
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 16:37:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1eZkXa-0007EH-7t
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 16:37:42 -0500
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Thu, 11 Jan 2018 22:32:47 +0100
Message-Id: <20180111213250.16511-49-marcandre.lureau@redhat.com>
In-Reply-To: <20180111213250.16511-1-marcandre.lureau@redhat.com>
References: <20180111213250.16511-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v4 48/51] qapi: make query-gic-capabilities
 depend on TARGET_ARM
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: eblake@redhat.com, armbru@redhat.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, "open list:ARM" <qemu-arm@nongnu.org>

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 qapi-schema.json     | 43 -------------------------------------------
 qapi/target.json     | 45 +++++++++++++++++++++++++++++++++++++++++++++
 monitor.c            | 11 -----------
 target/arm/monitor.c |  2 +-
 4 files changed, 46 insertions(+), 55 deletions(-)

diff --git a/qapi-schema.json b/qapi-schema.json
index ee9b2f53ff..f444e684c0 100644
--- a/qapi-schema.json
+++ b/qapi-schema.json
@@ -2899,49 +2899,6 @@
 ##
 { 'command': 'xen-load-devices-state', 'data': {'filename': 'str'} }
=20
-##
-# @GICCapability:
-#
-# The struct describes capability for a specific GIC (Generic
-# Interrupt Controller) version. These bits are not only decided by
-# QEMU/KVM software version, but also decided by the hardware that
-# the program is running upon.
-#
-# @version:  version of GIC to be described. Currently, only 2 and 3
-#            are supported.
-#
-# @emulated: whether current QEMU/hardware supports emulated GIC
-#            device in user space.
-#
-# @kernel:   whether current QEMU/hardware supports hardware
-#            accelerated GIC device in kernel.
-#
-# Since: 2.6
-##
-{ 'struct': 'GICCapability',
-  'data': { 'version': 'int',
-            'emulated': 'bool',
-            'kernel': 'bool' } }
-
-##
-# @query-gic-capabilities:
-#
-# This command is ARM-only. It will return a list of GICCapability
-# objects that describe its capability bits.
-#
-# Returns: a list of GICCapability objects.
-#
-# Since: 2.6
-#
-# Example:
-#
-# -> { "execute": "query-gic-capabilities" }
-# <- { "return": [{ "version": 2, "emulated": true, "kernel": false },
-#                 { "version": 3, "emulated": false, "kernel": true } ] =
}
-#
-##
-{ 'command': 'query-gic-capabilities', 'returns': ['GICCapability'] }
-
 ##
 # @CpuInstanceProperties:
 #
diff --git a/qapi/target.json b/qapi/target.json
index ca463a0854..7494a7e58f 100644
--- a/qapi/target.json
+++ b/qapi/target.json
@@ -132,3 +132,48 @@
             'modelb': 'CpuModelInfo' },
   'returns': 'CpuModelBaselineInfo',
   'if': 'defined(TARGET_S390X)' }
+
+##
+# @GICCapability:
+#
+# The struct describes capability for a specific GIC (Generic
+# Interrupt Controller) version. These bits are not only decided by
+# QEMU/KVM software version, but also decided by the hardware that
+# the program is running upon.
+#
+# @version:  version of GIC to be described. Currently, only 2 and 3
+#            are supported.
+#
+# @emulated: whether current QEMU/hardware supports emulated GIC
+#            device in user space.
+#
+# @kernel:   whether current QEMU/hardware supports hardware
+#            accelerated GIC device in kernel.
+#
+# Since: 2.6
+##
+{ 'struct': 'GICCapability',
+  'data': { 'version': 'int',
+            'emulated': 'bool',
+            'kernel': 'bool' },
+  'if': 'defined(TARGET_ARM)' }
+
+##
+# @query-gic-capabilities:
+#
+# This command is ARM-only. It will return a list of GICCapability
+# objects that describe its capability bits.
+#
+# Returns: a list of GICCapability objects.
+#
+# Since: 2.6
+#
+# Example:
+#
+# -> { "execute": "query-gic-capabilities" }
+# <- { "return": [{ "version": 2, "emulated": true, "kernel": false },
+#                 { "version": 3, "emulated": false, "kernel": true } ] =
}
+#
+##
+{ 'command': 'query-gic-capabilities', 'returns': ['GICCapability'],
+  'if': 'defined(TARGET_ARM)' }
diff --git a/monitor.c b/monitor.c
index 5d1ae89421..ed719651d9 100644
--- a/monitor.c
+++ b/monitor.c
@@ -971,9 +971,6 @@ static void qmp_query_qmp_schema(QDict *qdict, QObjec=
t **ret_data,
  */
 static void qmp_unregister_commands_hack(void)
 {
-#ifndef TARGET_ARM
-    qmp_unregister_command(&qmp_commands, "query-gic-capabilities");
-#endif
 #if !defined(TARGET_S390X) && !defined(TARGET_I386)
     qmp_unregister_command(&qmp_commands, "query-cpu-model-expansion");
 #endif
@@ -4135,14 +4132,6 @@ QemuOptsList qemu_mon_opts =3D {
     },
 };
=20
-#ifndef TARGET_ARM
-GICCapabilityList *qmp_query_gic_capabilities(Error **errp)
-{
-    error_setg(errp, QERR_FEATURE_DISABLED, "query-gic-capabilities");
-    return NULL;
-}
-#endif
-
 HotpluggableCPUList *qmp_query_hotpluggable_cpus(Error **errp)
 {
     MachineState *ms =3D MACHINE(qdev_get_machine());
diff --git a/target/arm/monitor.c b/target/arm/monitor.c
index 299cb80ae7..a46b0f98b4 100644
--- a/target/arm/monitor.c
+++ b/target/arm/monitor.c
@@ -20,7 +20,7 @@
  * THE SOFTWARE.
  */
 #include "qemu/osdep.h"
-#include "qmp-commands.h"
+#include "target-qmp-commands.h"
 #include "hw/boards.h"
 #include "kvm_arm.h"
=20
--=20
2.16.0.rc1.1.gef27df75a1
