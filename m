Received: from eggs.gnu.org ([2001:4830:134:3::10]:51532)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dno1N-0006eT-58
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 11:38:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dno1L-0001iB-IQ
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 11:38:13 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58408)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1dno1L-0001gz-5H
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 11:38:11 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 205AB7E430
	for <qemu-devel@nongnu.org>; Fri,  1 Sep 2017 15:38:10 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-75.ams2.redhat.com
	[10.36.116.75])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id BBD2B17C78
	for <qemu-devel@nongnu.org>; Fri,  1 Sep 2017 15:38:09 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Fri,  1 Sep 2017 17:37:41 +0200
Message-Id: <20170901153758.8628-31-armbru@redhat.com>
In-Reply-To: <20170901153758.8628-1-armbru@redhat.com>
References: <20170901153758.8628-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL v2 30/47] qapi-schema: Move queries from
 common.json to qapi-schema.json
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

query-version and query-commands are in common.json for no good
reason.  Several similar queries are in qapi-schema.json.  Move them
there.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Message-Id: <1503602048-12268-16-git-send-email-armbru@redhat.com>
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 qapi-schema.json | 103 +++++++++++++++++++++++++++++++++++++++++++++++++=
++++++
 qapi/common.json | 103 -------------------------------------------------=
------
 2 files changed, 103 insertions(+), 103 deletions(-)

diff --git a/qapi-schema.json b/qapi-schema.json
index 80c15dade3..7a393ec3e9 100644
--- a/qapi-schema.json
+++ b/qapi-schema.json
@@ -119,6 +119,109 @@
 { 'command': 'qmp_capabilities' }
=20
 ##
+# @VersionTriple:
+#
+# A three-part version number.
+#
+# @major:  The major version number.
+#
+# @minor:  The minor version number.
+#
+# @micro:  The micro version number.
+#
+# Since: 2.4
+##
+{ 'struct': 'VersionTriple',
+  'data': {'major': 'int', 'minor': 'int', 'micro': 'int'} }
+
+
+##
+# @VersionInfo:
+#
+# A description of QEMU's version.
+#
+# @qemu:        The version of QEMU.  By current convention, a micro
+#               version of 50 signifies a development branch.  A micro v=
ersion
+#               greater than or equal to 90 signifies a release candidat=
e for
+#               the next minor version.  A micro version of less than 50
+#               signifies a stable release.
+#
+# @package:     QEMU will always set this field to an empty string.  Dow=
nstream
+#               versions of QEMU should set this to a non-empty string. =
 The
+#               exact format depends on the downstream however it highly
+#               recommended that a unique name is used.
+#
+# Since: 0.14.0
+##
+{ 'struct': 'VersionInfo',
+  'data': {'qemu': 'VersionTriple', 'package': 'str'} }
+
+##
+# @query-version:
+#
+# Returns the current version of QEMU.
+#
+# Returns:  A @VersionInfo object describing the current version of QEMU=
.
+#
+# Since: 0.14.0
+#
+# Example:
+#
+# -> { "execute": "query-version" }
+# <- {
+#       "return":{
+#          "qemu":{
+#             "major":0,
+#             "minor":11,
+#             "micro":5
+#          },
+#          "package":""
+#       }
+#    }
+#
+##
+{ 'command': 'query-version', 'returns': 'VersionInfo' }
+
+##
+# @CommandInfo:
+#
+# Information about a QMP command
+#
+# @name: The command name
+#
+# Since: 0.14.0
+##
+{ 'struct': 'CommandInfo', 'data': {'name': 'str'} }
+
+##
+# @query-commands:
+#
+# Return a list of supported QMP commands by this server
+#
+# Returns: A list of @CommandInfo for all supported commands
+#
+# Since: 0.14.0
+#
+# Example:
+#
+# -> { "execute": "query-commands" }
+# <- {
+#      "return":[
+#         {
+#            "name":"query-balloon"
+#         },
+#         {
+#            "name":"system_powerdown"
+#         }
+#      ]
+#    }
+#
+# Note: This example has been shortened as the real response is too long=
.
+#
+##
+{ 'command': 'query-commands', 'returns': ['CommandInfo'] }
+
+##
 # @LostTickPolicy:
 #
 # Policy for handling lost ticks in timer devices.
diff --git a/qapi/common.json b/qapi/common.json
index fc72d7ec3d..0c67e4acf5 100644
--- a/qapi/common.json
+++ b/qapi/common.json
@@ -29,109 +29,6 @@
             'DeviceNotActive', 'DeviceNotFound', 'KVMMissingCap' ] }
=20
 ##
-# @VersionTriple:
-#
-# A three-part version number.
-#
-# @major:  The major version number.
-#
-# @minor:  The minor version number.
-#
-# @micro:  The micro version number.
-#
-# Since: 2.4
-##
-{ 'struct': 'VersionTriple',
-  'data': {'major': 'int', 'minor': 'int', 'micro': 'int'} }
-
-
-##
-# @VersionInfo:
-#
-# A description of QEMU's version.
-#
-# @qemu:        The version of QEMU.  By current convention, a micro
-#               version of 50 signifies a development branch.  A micro v=
ersion
-#               greater than or equal to 90 signifies a release candidat=
e for
-#               the next minor version.  A micro version of less than 50
-#               signifies a stable release.
-#
-# @package:     QEMU will always set this field to an empty string.  Dow=
nstream
-#               versions of QEMU should set this to a non-empty string. =
 The
-#               exact format depends on the downstream however it highly
-#               recommended that a unique name is used.
-#
-# Since: 0.14.0
-##
-{ 'struct': 'VersionInfo',
-  'data': {'qemu': 'VersionTriple', 'package': 'str'} }
-
-##
-# @query-version:
-#
-# Returns the current version of QEMU.
-#
-# Returns:  A @VersionInfo object describing the current version of QEMU=
.
-#
-# Since: 0.14.0
-#
-# Example:
-#
-# -> { "execute": "query-version" }
-# <- {
-#       "return":{
-#          "qemu":{
-#             "major":0,
-#             "minor":11,
-#             "micro":5
-#          },
-#          "package":""
-#       }
-#    }
-#
-##
-{ 'command': 'query-version', 'returns': 'VersionInfo' }
-
-##
-# @CommandInfo:
-#
-# Information about a QMP command
-#
-# @name: The command name
-#
-# Since: 0.14.0
-##
-{ 'struct': 'CommandInfo', 'data': {'name': 'str'} }
-
-##
-# @query-commands:
-#
-# Return a list of supported QMP commands by this server
-#
-# Returns: A list of @CommandInfo for all supported commands
-#
-# Since: 0.14.0
-#
-# Example:
-#
-# -> { "execute": "query-commands" }
-# <- {
-#      "return":[
-#         {
-#            "name":"query-balloon"
-#         },
-#         {
-#            "name":"system_powerdown"
-#         }
-#      ]
-#    }
-#
-# Note: This example has been shortened as the real response is too long=
.
-#
-##
-{ 'command': 'query-commands', 'returns': ['CommandInfo'] }
-
-##
 # @IoOperationType:
 #
 # An enumeration of the I/O operation types
--=20
2.13.5
