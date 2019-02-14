Received: from eggs.gnu.org ([209.51.188.92]:54828)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1guIqu-0007ZN-P6
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 10:23:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1guIqs-0001aG-6p
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 10:23:04 -0500
Received: from mx1.redhat.com ([209.132.183.28]:45096)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1guIqr-0001Ug-Ph
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 10:23:02 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 1018981F25
	for <qemu-devel@nongnu.org>; Thu, 14 Feb 2019 15:22:59 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Thu, 14 Feb 2019 16:22:45 +0100
Message-Id: <20190214152251.2073-13-armbru@redhat.com>
In-Reply-To: <20190214152251.2073-1-armbru@redhat.com>
References: <20190214152251.2073-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v5 12/18] qapi: make query-gic-capabilities
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
Cc: marcandre.lureau@redhat.com, eblake@redhat.com

From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 monitor.c            | 11 -----------
 qapi/misc.json       | 43 ------------------------------------------
 qapi/target.json     | 45 ++++++++++++++++++++++++++++++++++++++++++++
 target/arm/monitor.c |  2 +-
 4 files changed, 46 insertions(+), 55 deletions(-)

diff --git a/monitor.c b/monitor.c
index 621e26cc94..33a0d81677 100644
--- a/monitor.c
+++ b/monitor.c
@@ -1145,9 +1145,6 @@ static void qmp_query_qmp_schema(QDict *qdict, QObj=
ect **ret_data,
  */
 static void qmp_unregister_commands_hack(void)
 {
-#ifndef TARGET_ARM
-    qmp_unregister_command(&qmp_commands, "query-gic-capabilities");
-#endif
 #if !defined(TARGET_S390X) && !defined(TARGET_I386)
     qmp_unregister_command(&qmp_commands, "query-cpu-model-expansion");
 #endif
@@ -4657,14 +4654,6 @@ QemuOptsList qemu_mon_opts =3D {
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
diff --git a/qapi/misc.json b/qapi/misc.json
index 431de64590..9df45a27ca 100644
--- a/qapi/misc.json
+++ b/qapi/misc.json
@@ -3044,49 +3044,6 @@
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
index 010df35ebb..f4a7054921 100644
--- a/qapi/target.json
+++ b/qapi/target.json
@@ -328,3 +328,48 @@
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
diff --git a/target/arm/monitor.c b/target/arm/monitor.c
index 4cdd2676dd..41b32b94b2 100644
--- a/target/arm/monitor.c
+++ b/target/arm/monitor.c
@@ -23,7 +23,7 @@
 #include "qemu/osdep.h"
 #include "hw/boards.h"
 #include "kvm_arm.h"
-#include "qapi/qapi-commands-misc.h"
+#include "qapi/qapi-commands-target.h"
=20
 static GICCapability *gic_cap_new(int version)
 {
--=20
2.17.2
