Received: from eggs.gnu.org ([2001:4830:134:3::10]:33034)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gYX6x-0001Mh-PS
	for qemu-devel@nongnu.org; Sun, 16 Dec 2018 09:09:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gYX6v-000565-OA
	for qemu-devel@nongnu.org; Sun, 16 Dec 2018 09:09:39 -0500
Received: from mx1.redhat.com ([209.132.183.28]:38936)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1gYX6v-00055P-DV
	for qemu-devel@nongnu.org; Sun, 16 Dec 2018 09:09:37 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C16B389AD1
	for <qemu-devel@nongnu.org>; Sun, 16 Dec 2018 14:09:36 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Sun, 16 Dec 2018 18:08:55 +0400
Message-Id: <20181216140902.23986-7-marcandre.lureau@redhat.com>
In-Reply-To: <20181216140902.23986-1-marcandre.lureau@redhat.com>
References: <20181216140902.23986-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 06/13] qapi: make rtc-reset-reinjection and SEV
 depend on TARGET_I386
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: armbru@redhat.com

Move rtc-reset-reinjection and SEV in target.json and make them
conditional on TARGET_I386.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 qapi/misc.json         | 166 --------------------------------------
 qapi/target.json       | 175 ++++++++++++++++++++++++++++++++++++++++-
 target/i386/sev_i386.h |   2 +-
 hw/timer/mc146818rtc.c |   2 +-
 monitor.c              |  31 --------
 5 files changed, 175 insertions(+), 201 deletions(-)

diff --git a/qapi/misc.json b/qapi/misc.json
index 8325e0dc9c..688e874fb8 100644
--- a/qapi/misc.json
+++ b/qapi/misc.json
@@ -3053,24 +3053,6 @@
 { 'event': 'ACPI_DEVICE_OST',
      'data': { 'info': 'ACPIOSTInfo' } }
=20
-##
-# @rtc-reset-reinjection:
-#
-# This command will reset the RTC interrupt reinjection backlog.
-# Can be used if another mechanism to synchronize guest time
-# is in effect, for example QEMU guest agent's guest-set-time
-# command.
-#
-# Since: 2.1
-#
-# Example:
-#
-# -> { "execute": "rtc-reset-reinjection" }
-# <- { "return": {} }
-#
-##
-{ 'command': 'rtc-reset-reinjection' }
-
 ##
 # @RTC_CHANGE:
 #
@@ -3299,154 +3281,6 @@
 ##
 { 'command': 'query-vm-generation-id', 'returns': 'GuidInfo' }
=20
-
-##
-# @SevState:
-#
-# An enumeration of SEV state information used during @query-sev.
-#
-# @uninit: The guest is uninitialized.
-#
-# @launch-update: The guest is currently being launched; plaintext data =
and
-#                 register state is being imported.
-#
-# @launch-secret: The guest is currently being launched; ciphertext data
-#                 is being imported.
-#
-# @running: The guest is fully launched or migrated in.
-#
-# @send-update: The guest is currently being migrated out to another mac=
hine.
-#
-# @receive-update: The guest is currently being migrated from another ma=
chine.
-#
-# Since: 2.12
-##
-{ 'enum': 'SevState',
-  'data': ['uninit', 'launch-update', 'launch-secret', 'running',
-           'send-update', 'receive-update' ] }
-
-##
-# @SevInfo:
-#
-# Information about Secure Encrypted Virtualization (SEV) support
-#
-# @enabled: true if SEV is active
-#
-# @api-major: SEV API major version
-#
-# @api-minor: SEV API minor version
-#
-# @build-id: SEV FW build id
-#
-# @policy: SEV policy value
-#
-# @state: SEV guest state
-#
-# @handle: SEV firmware handle
-#
-# Since: 2.12
-##
-{ 'struct': 'SevInfo',
-    'data': { 'enabled': 'bool',
-              'api-major': 'uint8',
-              'api-minor' : 'uint8',
-              'build-id' : 'uint8',
-              'policy' : 'uint32',
-              'state' : 'SevState',
-              'handle' : 'uint32'
-            }
-}
-
-##
-# @query-sev:
-#
-# Returns information about SEV
-#
-# Returns: @SevInfo
-#
-# Since: 2.12
-#
-# Example:
-#
-# -> { "execute": "query-sev" }
-# <- { "return": { "enabled": true, "api-major" : 0, "api-minor" : 0,
-#                  "build-id" : 0, "policy" : 0, "state" : "running",
-#                  "handle" : 1 } }
-#
-##
-{ 'command': 'query-sev', 'returns': 'SevInfo' }
-
-##
-# @SevLaunchMeasureInfo:
-#
-# SEV Guest Launch measurement information
-#
-# @data: the measurement value encoded in base64
-#
-# Since: 2.12
-#
-##
-{ 'struct': 'SevLaunchMeasureInfo', 'data': {'data': 'str'} }
-
-##
-# @query-sev-launch-measure:
-#
-# Query the SEV guest launch information.
-#
-# Returns: The @SevLaunchMeasureInfo for the guest
-#
-# Since: 2.12
-#
-# Example:
-#
-# -> { "execute": "query-sev-launch-measure" }
-# <- { "return": { "data": "4l8LXeNlSPUDlXPJG5966/8%YZ" } }
-#
-##
-{ 'command': 'query-sev-launch-measure', 'returns': 'SevLaunchMeasureInf=
o' }
-
-##
-# @SevCapability:
-#
-# The struct describes capability for a Secure Encrypted Virtualization
-# feature.
-#
-# @pdh:  Platform Diffie-Hellman key (base64 encoded)
-#
-# @cert-chain:  PDH certificate chain (base64 encoded)
-#
-# @cbitpos: C-bit location in page table entry
-#
-# @reduced-phys-bits: Number of physical Address bit reduction when SEV =
is
-#                     enabled
-#
-# Since: 2.12
-##
-{ 'struct': 'SevCapability',
-  'data': { 'pdh': 'str',
-            'cert-chain': 'str',
-            'cbitpos': 'int',
-            'reduced-phys-bits': 'int'} }
-
-##
-# @query-sev-capabilities:
-#
-# This command is used to get the SEV capabilities, and is supported on =
AMD
-# X86 platforms only.
-#
-# Returns: SevCapability objects.
-#
-# Since: 2.12
-#
-# Example:
-#
-# -> { "execute": "query-sev-capabilities" }
-# <- { "return": { "pdh": "8CCDD8DDD", "cert-chain": "888CCCDDDEE",
-#                  "cbitpos": 47, "reduced-phys-bits": 5}}
-#
-##
-{ 'command': 'query-sev-capabilities', 'returns': 'SevCapability' }
-
 ##
 # @set-numa-node:
 #
diff --git a/qapi/target.json b/qapi/target.json
index be2360ca34..f277b69a2a 100644
--- a/qapi/target.json
+++ b/qapi/target.json
@@ -8,6 +8,177 @@
 { 'pragma': { 'top-unit': 'target' } }
=20
 ##
-# @DUMMY:
+# @rtc-reset-reinjection:
+#
+# This command will reset the RTC interrupt reinjection backlog.
+# Can be used if another mechanism to synchronize guest time
+# is in effect, for example QEMU guest agent's guest-set-time
+# command.
+#
+# Since: 2.1
+#
+# Example:
+#
+# -> { "execute": "rtc-reset-reinjection" }
+# <- { "return": {} }
+#
+##
+{ 'command': 'rtc-reset-reinjection',
+  'if': 'defined(TARGET_I386)' }
+
+
+##
+# @SevState:
+#
+# An enumeration of SEV state information used during @query-sev.
+#
+# @uninit: The guest is uninitialized.
+#
+# @launch-update: The guest is currently being launched; plaintext data =
and
+#                 register state is being imported.
+#
+# @launch-secret: The guest is currently being launched; ciphertext data
+#                 is being imported.
+#
+# @running: The guest is fully launched or migrated in.
+#
+# @send-update: The guest is currently being migrated out to another mac=
hine.
+#
+# @receive-update: The guest is currently being migrated from another ma=
chine.
+#
+# Since: 2.12
+##
+{ 'enum': 'SevState',
+  'data': ['uninit', 'launch-update', 'launch-secret', 'running',
+           'send-update', 'receive-update' ],
+  'if': 'defined(TARGET_I386)' }
+
+##
+# @SevInfo:
+#
+# Information about Secure Encrypted Virtualization (SEV) support
+#
+# @enabled: true if SEV is active
+#
+# @api-major: SEV API major version
+#
+# @api-minor: SEV API minor version
+#
+# @build-id: SEV FW build id
+#
+# @policy: SEV policy value
+#
+# @state: SEV guest state
+#
+# @handle: SEV firmware handle
+#
+# Since: 2.12
+##
+{ 'struct': 'SevInfo',
+    'data': { 'enabled': 'bool',
+              'api-major': 'uint8',
+              'api-minor' : 'uint8',
+              'build-id' : 'uint8',
+              'policy' : 'uint32',
+              'state' : 'SevState',
+              'handle' : 'uint32'
+            },
+  'if': 'defined(TARGET_I386)'
+}
+
+##
+# @query-sev:
+#
+# Returns information about SEV
+#
+# Returns: @SevInfo
+#
+# Since: 2.12
+#
+# Example:
+#
+# -> { "execute": "query-sev" }
+# <- { "return": { "enabled": true, "api-major" : 0, "api-minor" : 0,
+#                  "build-id" : 0, "policy" : 0, "state" : "running",
+#                  "handle" : 1 } }
+#
+##
+{ 'command': 'query-sev', 'returns': 'SevInfo',
+  'if': 'defined(TARGET_I386)' }
+
+
+##
+# @SevLaunchMeasureInfo:
+#
+# SEV Guest Launch measurement information
+#
+# @data: the measurement value encoded in base64
+#
+# Since: 2.12
+#
+##
+{ 'struct': 'SevLaunchMeasureInfo', 'data': {'data': 'str'},
+  'if': 'defined(TARGET_I386)' }
+
+##
+# @query-sev-launch-measure:
+#
+# Query the SEV guest launch information.
+#
+# Returns: The @SevLaunchMeasureInfo for the guest
+#
+# Since: 2.12
+#
+# Example:
+#
+# -> { "execute": "query-sev-launch-measure" }
+# <- { "return": { "data": "4l8LXeNlSPUDlXPJG5966/8%YZ" } }
+#
+##
+{ 'command': 'query-sev-launch-measure', 'returns': 'SevLaunchMeasureInf=
o',
+  'if': 'defined(TARGET_I386)' }
+
+
+##
+# @SevCapability:
+#
+# The struct describes capability for a Secure Encrypted Virtualization
+# feature.
+#
+# @pdh:  Platform Diffie-Hellman key (base64 encoded)
+#
+# @cert-chain:  PDH certificate chain (base64 encoded)
+#
+# @cbitpos: C-bit location in page table entry
+#
+# @reduced-phys-bits: Number of physical Address bit reduction when SEV =
is
+#                     enabled
+#
+# Since: 2.12
+##
+{ 'struct': 'SevCapability',
+  'data': { 'pdh': 'str',
+            'cert-chain': 'str',
+            'cbitpos': 'int',
+            'reduced-phys-bits': 'int'},
+  'if': 'defined(TARGET_I386)' }
+
+##
+# @query-sev-capabilities:
+#
+# This command is used to get the SEV capabilities, and is supported on =
AMD
+# X86 platforms only.
+#
+# Returns: SevCapability objects.
+#
+# Since: 2.12
+#
+# Example:
+#
+# -> { "execute": "query-sev-capabilities" }
+# <- { "return": { "pdh": "8CCDD8DDD", "cert-chain": "888CCCDDDEE",
+#                  "cbitpos": 47, "reduced-phys-bits": 5}}
+#
 ##
-{ 'event': 'DUMMY' }
+{ 'command': 'query-sev-capabilities', 'returns': 'SevCapability',
+  'if': 'defined(TARGET_I386)' }
diff --git a/target/i386/sev_i386.h b/target/i386/sev_i386.h
index b8622dfb1e..8f88f86952 100644
--- a/target/i386/sev_i386.h
+++ b/target/i386/sev_i386.h
@@ -19,7 +19,7 @@
 #include "sysemu/kvm.h"
 #include "sysemu/sev.h"
 #include "qemu/error-report.h"
-#include "qapi/qapi-commands-misc.h"
+#include "qapi/target-qapi-commands.h"
=20
 #define SEV_POLICY_NODBG        0x1
 #define SEV_POLICY_NOKS         0x2
diff --git a/hw/timer/mc146818rtc.c b/hw/timer/mc146818rtc.c
index e4e4de8b8a..a27b389f8e 100644
--- a/hw/timer/mc146818rtc.c
+++ b/hw/timer/mc146818rtc.c
@@ -31,7 +31,7 @@
 #include "sysemu/replay.h"
 #include "hw/timer/mc146818rtc.h"
 #include "qapi/error.h"
-#include "qapi/qapi-commands-misc.h"
+#include "qapi/target-qapi-commands.h"
 #include "qapi/qapi-events-misc.h"
 #include "qapi/visitor.h"
 #include "exec/address-spaces.h"
diff --git a/monitor.c b/monitor.c
index 86f3193158..4b3059614f 100644
--- a/monitor.c
+++ b/monitor.c
@@ -1218,12 +1218,6 @@ static void qmp_query_qmp_schema(QDict *qdict, QOb=
ject **ret_data,
  */
 static void qmp_unregister_commands_hack(void)
 {
-#ifndef TARGET_I386
-    qmp_unregister_command(&qmp_commands, "rtc-reset-reinjection");
-    qmp_unregister_command(&qmp_commands, "query-sev");
-    qmp_unregister_command(&qmp_commands, "query-sev-launch-measure");
-    qmp_unregister_command(&qmp_commands, "query-sev-capabilities");
-#endif
 #ifndef TARGET_S390X
     qmp_unregister_command(&qmp_commands, "dump-skeys");
 #endif
@@ -4740,31 +4734,6 @@ QemuOptsList qemu_mon_opts =3D {
     },
 };
=20
-#ifndef TARGET_I386
-void qmp_rtc_reset_reinjection(Error **errp)
-{
-    error_setg(errp, QERR_FEATURE_DISABLED, "rtc-reset-reinjection");
-}
-
-SevInfo *qmp_query_sev(Error **errp)
-{
-    error_setg(errp, QERR_FEATURE_DISABLED, "query-sev");
-    return NULL;
-}
-
-SevLaunchMeasureInfo *qmp_query_sev_launch_measure(Error **errp)
-{
-    error_setg(errp, QERR_FEATURE_DISABLED, "query-sev-launch-measure");
-    return NULL;
-}
-
-SevCapability *qmp_query_sev_capabilities(Error **errp)
-{
-    error_setg(errp, QERR_FEATURE_DISABLED, "query-sev-capabilities");
-    return NULL;
-}
-#endif
-
 #ifndef TARGET_S390X
 void qmp_dump_skeys(const char *filename, Error **errp)
 {
--=20
2.20.0
