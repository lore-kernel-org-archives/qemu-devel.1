Received: from eggs.gnu.org ([2001:4830:134:3::10]:51526)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dno1N-0006eK-3K
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 11:38:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dno1L-0001hj-9i
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 11:38:13 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33988)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1dno1K-0001gV-VU
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 11:38:11 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id E627F5F7A9
	for <qemu-devel@nongnu.org>; Fri,  1 Sep 2017 15:38:09 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-75.ams2.redhat.com
	[10.36.116.75])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 8F2D317C34
	for <qemu-devel@nongnu.org>; Fri,  1 Sep 2017 15:38:09 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Fri,  1 Sep 2017 17:37:37 +0200
Message-Id: <20170901153758.8628-27-armbru@redhat.com>
In-Reply-To: <20170901153758.8628-1-armbru@redhat.com>
References: <20170901153758.8628-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL v2 26/47] qapi-schema: Collect TPM stuff in
 qapi/tpm.json
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Sadly, we don't have a TPM maintainer, not even a MAINTAINERS entry.
Create one, and mark it orphaned.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Message-Id: <1503602048-12268-12-git-send-email-armbru@redhat.com>
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 MAINTAINERS      |   8 ++++
 Makefile         |   1 +
 qapi-schema.json | 132 +------------------------------------------------=
----
 qapi/tpm.json    | 137 +++++++++++++++++++++++++++++++++++++++++++++++++=
++++++
 4 files changed, 147 insertions(+), 131 deletions(-)
 create mode 100644 qapi/tpm.json

diff --git a/MAINTAINERS b/MAINTAINERS
index 8cebd798ef..5ec945c9af 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1486,6 +1486,14 @@ F: scripts/tracetool/
 F: docs/tracing.txt
 T: git git://github.com/stefanha/qemu.git tracing
=20
+TPM
+S: Orphan
+F: tpm.c
+F: hw/tpm/*
+F: include/hw/acpi/tpm.h
+F: include/sysemu/tpm*
+F: qapi/tpm.json
+
 Checkpatch
 S: Odd Fixes
 F: scripts/checkpatch.pl
diff --git a/Makefile b/Makefile
index ea6de37197..3dde210662 100644
--- a/Makefile
+++ b/Makefile
@@ -418,6 +418,7 @@ qapi-modules =3D $(SRC_PATH)/qapi-schema.json $(SRC_P=
ATH)/qapi/common.json \
                $(SRC_PATH)/qapi/rocker.json \
                $(SRC_PATH)/qapi/run-state.json \
                $(SRC_PATH)/qapi/sockets.json \
+               $(SRC_PATH)/qapi/tpm.json \
                $(SRC_PATH)/qapi/trace.json \
                $(SRC_PATH)/qapi/transaction.json \
                $(SRC_PATH)/qapi/ui.json
diff --git a/qapi-schema.json b/qapi-schema.json
index 4108ef0cc8..0ad4e0237d 100644
--- a/qapi-schema.json
+++ b/qapi-schema.json
@@ -86,6 +86,7 @@
 { 'include': 'qapi/char.json' }
 { 'include': 'qapi/net.json' }
 { 'include': 'qapi/rocker.json' }
+{ 'include': 'qapi/tpm.json' }
 { 'include': 'qapi/ui.json' }
 { 'include': 'qapi/migration.json' }
 { 'include': 'qapi/transaction.json' }
@@ -2213,137 +2214,6 @@
 { 'command': 'query-target', 'returns': 'TargetInfo' }
=20
 ##
-# @TpmModel:
-#
-# An enumeration of TPM models
-#
-# @tpm-tis: TPM TIS model
-#
-# Since: 1.5
-##
-{ 'enum': 'TpmModel', 'data': [ 'tpm-tis' ] }
-
-##
-# @query-tpm-models:
-#
-# Return a list of supported TPM models
-#
-# Returns: a list of TpmModel
-#
-# Since: 1.5
-#
-# Example:
-#
-# -> { "execute": "query-tpm-models" }
-# <- { "return": [ "tpm-tis" ] }
-#
-##
-{ 'command': 'query-tpm-models', 'returns': ['TpmModel'] }
-
-##
-# @TpmType:
-#
-# An enumeration of TPM types
-#
-# @passthrough: TPM passthrough type
-#
-# Since: 1.5
-##
-{ 'enum': 'TpmType', 'data': [ 'passthrough' ] }
-
-##
-# @query-tpm-types:
-#
-# Return a list of supported TPM types
-#
-# Returns: a list of TpmType
-#
-# Since: 1.5
-#
-# Example:
-#
-# -> { "execute": "query-tpm-types" }
-# <- { "return": [ "passthrough" ] }
-#
-##
-{ 'command': 'query-tpm-types', 'returns': ['TpmType'] }
-
-##
-# @TPMPassthroughOptions:
-#
-# Information about the TPM passthrough type
-#
-# @path: string describing the path used for accessing the TPM device
-#
-# @cancel-path: string showing the TPM's sysfs cancel file
-#               for cancellation of TPM commands while they are executin=
g
-#
-# Since: 1.5
-##
-{ 'struct': 'TPMPassthroughOptions', 'data': { '*path' : 'str',
-                                             '*cancel-path' : 'str'} }
-
-##
-# @TpmTypeOptions:
-#
-# A union referencing different TPM backend types' configuration options
-#
-# @type: 'passthrough' The configuration options for the TPM passthrough=
 type
-#
-# Since: 1.5
-##
-{ 'union': 'TpmTypeOptions',
-   'data': { 'passthrough' : 'TPMPassthroughOptions' } }
-
-##
-# @TPMInfo:
-#
-# Information about the TPM
-#
-# @id: The Id of the TPM
-#
-# @model: The TPM frontend model
-#
-# @options: The TPM (backend) type configuration options
-#
-# Since: 1.5
-##
-{ 'struct': 'TPMInfo',
-  'data': {'id': 'str',
-           'model': 'TpmModel',
-           'options': 'TpmTypeOptions' } }
-
-##
-# @query-tpm:
-#
-# Return information about the TPM device
-#
-# Returns: @TPMInfo on success
-#
-# Since: 1.5
-#
-# Example:
-#
-# -> { "execute": "query-tpm" }
-# <- { "return":
-#      [
-#        { "model": "tpm-tis",
-#          "options":
-#            { "type": "passthrough",
-#              "data":
-#                { "cancel-path": "/sys/class/misc/tpm0/device/cancel",
-#                  "path": "/dev/tpm0"
-#                }
-#            },
-#          "id": "tpm0"
-#        }
-#      ]
-#    }
-#
-##
-{ 'command': 'query-tpm', 'returns': ['TPMInfo'] }
-
-##
 # @AcpiTableOptions:
 #
 # Specify an ACPI table on the command line to load.
diff --git a/qapi/tpm.json b/qapi/tpm.json
new file mode 100644
index 0000000000..e8b2d8dcb7
--- /dev/null
+++ b/qapi/tpm.json
@@ -0,0 +1,137 @@
+# -*- Mode: Python -*-
+#
+
+##
+# =3D TPM (trusted platform module) devices
+##
+
+##
+# @TpmModel:
+#
+# An enumeration of TPM models
+#
+# @tpm-tis: TPM TIS model
+#
+# Since: 1.5
+##
+{ 'enum': 'TpmModel', 'data': [ 'tpm-tis' ] }
+
+##
+# @query-tpm-models:
+#
+# Return a list of supported TPM models
+#
+# Returns: a list of TpmModel
+#
+# Since: 1.5
+#
+# Example:
+#
+# -> { "execute": "query-tpm-models" }
+# <- { "return": [ "tpm-tis" ] }
+#
+##
+{ 'command': 'query-tpm-models', 'returns': ['TpmModel'] }
+
+##
+# @TpmType:
+#
+# An enumeration of TPM types
+#
+# @passthrough: TPM passthrough type
+#
+# Since: 1.5
+##
+{ 'enum': 'TpmType', 'data': [ 'passthrough' ] }
+
+##
+# @query-tpm-types:
+#
+# Return a list of supported TPM types
+#
+# Returns: a list of TpmType
+#
+# Since: 1.5
+#
+# Example:
+#
+# -> { "execute": "query-tpm-types" }
+# <- { "return": [ "passthrough" ] }
+#
+##
+{ 'command': 'query-tpm-types', 'returns': ['TpmType'] }
+
+##
+# @TPMPassthroughOptions:
+#
+# Information about the TPM passthrough type
+#
+# @path: string describing the path used for accessing the TPM device
+#
+# @cancel-path: string showing the TPM's sysfs cancel file
+#               for cancellation of TPM commands while they are executin=
g
+#
+# Since: 1.5
+##
+{ 'struct': 'TPMPassthroughOptions', 'data': { '*path' : 'str',
+                                             '*cancel-path' : 'str'} }
+
+##
+# @TpmTypeOptions:
+#
+# A union referencing different TPM backend types' configuration options
+#
+# @type: 'passthrough' The configuration options for the TPM passthrough=
 type
+#
+# Since: 1.5
+##
+{ 'union': 'TpmTypeOptions',
+   'data': { 'passthrough' : 'TPMPassthroughOptions' } }
+
+##
+# @TPMInfo:
+#
+# Information about the TPM
+#
+# @id: The Id of the TPM
+#
+# @model: The TPM frontend model
+#
+# @options: The TPM (backend) type configuration options
+#
+# Since: 1.5
+##
+{ 'struct': 'TPMInfo',
+  'data': {'id': 'str',
+           'model': 'TpmModel',
+           'options': 'TpmTypeOptions' } }
+
+##
+# @query-tpm:
+#
+# Return information about the TPM device
+#
+# Returns: @TPMInfo on success
+#
+# Since: 1.5
+#
+# Example:
+#
+# -> { "execute": "query-tpm" }
+# <- { "return":
+#      [
+#        { "model": "tpm-tis",
+#          "options":
+#            { "type": "passthrough",
+#              "data":
+#                { "cancel-path": "/sys/class/misc/tpm0/device/cancel",
+#                  "path": "/dev/tpm0"
+#                }
+#            },
+#          "id": "tpm0"
+#        }
+#      ]
+#    }
+#
+##
+{ 'command': 'query-tpm', 'returns': ['TPMInfo'] }
--=20
2.13.5
