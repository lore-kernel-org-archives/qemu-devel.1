Return-Path: <SRS0=yZS3=YK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53EBEFA372A
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 13:21:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1CAA420869
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 13:21:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1CAA420869
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47226 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iL5ij-0004ZW-R4
	for qemu-devel@archiver.kernel.org; Thu, 17 Oct 2019 09:21:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60231)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1iL5ST-0001IL-Ta
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 09:04:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1iL5SN-00008y-LG
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 09:04:49 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46062)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>)
 id 1iL5SB-0008Uf-2H; Thu, 17 Oct 2019 09:04:31 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 4ABA2307D976;
 Thu, 17 Oct 2019 13:04:30 +0000 (UTC)
Received: from localhost.localdomain.com (ovpn-117-24.ams2.redhat.com
 [10.36.117.24])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B873710001BC;
 Thu, 17 Oct 2019 13:04:28 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Subject: [RFC PATCH 13/18] qapi: Create module 'monitor'
Date: Thu, 17 Oct 2019 15:01:59 +0200
Message-Id: <20191017130204.16131-14-kwolf@redhat.com>
In-Reply-To: <20191017130204.16131-1-kwolf@redhat.com>
References: <20191017130204.16131-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.48]); Thu, 17 Oct 2019 13:04:30 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: kwolf@redhat.com, pkrempa@redhat.com, qemu-devel@nongnu.org,
 armbru@redhat.com, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

misc.json contains definitions that are related to the system emulator,
so it can't be used for the storage daemon. This patch moves basic
functionality that is related to the monitor itself into a new
monitor.json, which could be used in tools as well.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 qapi/misc.json             | 212 ------------------------------------
 qapi/monitor.json          | 218 +++++++++++++++++++++++++++++++++++++
 qapi/qapi-schema.json      |   1 +
 monitor/monitor-internal.h |   1 +
 monitor/hmp-cmds.c         |   1 +
 monitor/qmp-cmds.c         |   1 +
 monitor/qmp.c              |   2 +-
 tests/qmp-test.c           |   2 +-
 ui/gtk.c                   |   1 +
 qapi/Makefile.objs         |   4 +-
 10 files changed, 227 insertions(+), 216 deletions(-)
 create mode 100644 qapi/monitor.json

diff --git a/qapi/misc.json b/qapi/misc.json
index 6bd11f50e6..7a05c286d5 100644
--- a/qapi/misc.json
+++ b/qapi/misc.json
@@ -7,159 +7,6 @@
=20
 { 'include': 'common.json' }
=20
-##
-# @qmp_capabilities:
-#
-# Enable QMP capabilities.
-#
-# Arguments:
-#
-# @enable:   An optional list of QMPCapability values to enable.  The
-#            client must not enable any capability that is not
-#            mentioned in the QMP greeting message.  If the field is not
-#            provided, it means no QMP capabilities will be enabled.
-#            (since 2.12)
-#
-# Example:
-#
-# -> { "execute": "qmp_capabilities",
-#      "arguments": { "enable": [ "oob" ] } }
-# <- { "return": {} }
-#
-# Notes: This command is valid exactly when first connecting: it must be
-# issued before any other command will be accepted, and will fail once t=
he
-# monitor is accepting other commands. (see qemu docs/interop/qmp-spec.t=
xt)
-#
-# The QMP client needs to explicitly enable QMP capabilities, otherwise
-# all the QMP capabilities will be turned off by default.
-#
-# Since: 0.13
-#
-##
-{ 'command': 'qmp_capabilities',
-  'data': { '*enable': [ 'QMPCapability' ] },
-  'allow-preconfig': true }
-
-##
-# @QMPCapability:
-#
-# Enumeration of capabilities to be advertised during initial client
-# connection, used for agreeing on particular QMP extension behaviors.
-#
-# @oob:   QMP ability to support out-of-band requests.
-#         (Please refer to qmp-spec.txt for more information on OOB)
-#
-# Since: 2.12
-#
-##
-{ 'enum': 'QMPCapability',
-  'data': [ 'oob' ] }
-
-##
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
-{ 'command': 'query-version', 'returns': 'VersionInfo',
-  'allow-preconfig': true }
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
-{ 'command': 'query-commands', 'returns': ['CommandInfo'],
-  'allow-preconfig': true }
-
 ##
 # @LostTickPolicy:
 #
@@ -300,48 +147,6 @@
 ##
 { 'command': 'query-uuid', 'returns': 'UuidInfo', 'allow-preconfig': tru=
e }
=20
-##
-# @EventInfo:
-#
-# Information about a QMP event
-#
-# @name: The event name
-#
-# Since: 1.2.0
-##
-{ 'struct': 'EventInfo', 'data': {'name': 'str'} }
-
-##
-# @query-events:
-#
-# Return information on QMP events.
-#
-# Returns: A list of @EventInfo.
-#
-# Since: 1.2.0
-#
-# Note: This command is deprecated, because its output doesn't reflect
-# compile-time configuration.  Use query-qmp-schema instead.
-#
-# Example:
-#
-# -> { "execute": "query-events" }
-# <- {
-#      "return": [
-#          {
-#             "name":"SHUTDOWN"
-#          },
-#          {
-#             "name":"RESET"
-#          }
-#       ]
-#    }
-#
-# Note: This example has been shortened as the real response is too long=
.
-#
-##
-{ 'command': 'query-events', 'returns': ['EventInfo'] }
-
 ##
 # @IOThreadInfo:
 #
@@ -764,23 +569,6 @@
 ##
 { 'command': 'query-pci', 'returns': ['PciInfo'] }
=20
-##
-# @quit:
-#
-# This command will cause the QEMU process to exit gracefully.  While ev=
ery
-# attempt is made to send the QMP response before terminating, this is n=
ot
-# guaranteed.  When using this interface, a premature EOF would not be
-# unexpected.
-#
-# Since: 0.14.0
-#
-# Example:
-#
-# -> { "execute": "quit" }
-# <- { "return": {} }
-##
-{ 'command': 'quit' }
-
 ##
 # @stop:
 #
diff --git a/qapi/monitor.json b/qapi/monitor.json
new file mode 100644
index 0000000000..a82a18da1a
--- /dev/null
+++ b/qapi/monitor.json
@@ -0,0 +1,218 @@
+# -*- Mode: Python -*-
+#
+
+##
+# =3D Monitor definitions (shared between system emulator and tools)
+##
+
+##
+# @qmp_capabilities:
+#
+# Enable QMP capabilities.
+#
+# Arguments:
+#
+# @enable:   An optional list of QMPCapability values to enable.  The
+#            client must not enable any capability that is not
+#            mentioned in the QMP greeting message.  If the field is not
+#            provided, it means no QMP capabilities will be enabled.
+#            (since 2.12)
+#
+# Example:
+#
+# -> { "execute": "qmp_capabilities",
+#      "arguments": { "enable": [ "oob" ] } }
+# <- { "return": {} }
+#
+# Notes: This command is valid exactly when first connecting: it must be
+# issued before any other command will be accepted, and will fail once t=
he
+# monitor is accepting other commands. (see qemu docs/interop/qmp-spec.t=
xt)
+#
+# The QMP client needs to explicitly enable QMP capabilities, otherwise
+# all the QMP capabilities will be turned off by default.
+#
+# Since: 0.13
+#
+##
+{ 'command': 'qmp_capabilities',
+  'data': { '*enable': [ 'QMPCapability' ] },
+  'allow-preconfig': true }
+
+##
+# @QMPCapability:
+#
+# Enumeration of capabilities to be advertised during initial client
+# connection, used for agreeing on particular QMP extension behaviors.
+#
+# @oob:   QMP ability to support out-of-band requests.
+#         (Please refer to qmp-spec.txt for more information on OOB)
+#
+# Since: 2.12
+#
+##
+{ 'enum': 'QMPCapability',
+  'data': [ 'oob' ] }
+
+##
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
+{ 'command': 'query-version', 'returns': 'VersionInfo',
+  'allow-preconfig': true }
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
+{ 'command': 'query-commands', 'returns': ['CommandInfo'],
+  'allow-preconfig': true }
+
+##
+# @EventInfo:
+#
+# Information about a QMP event
+#
+# @name: The event name
+#
+# Since: 1.2.0
+##
+{ 'struct': 'EventInfo', 'data': {'name': 'str'} }
+
+##
+# @query-events:
+#
+# Return information on QMP events.
+#
+# Returns: A list of @EventInfo.
+#
+# Since: 1.2.0
+#
+# Note: This command is deprecated, because its output doesn't reflect
+# compile-time configuration.  Use query-qmp-schema instead.
+#
+# Example:
+#
+# -> { "execute": "query-events" }
+# <- {
+#      "return": [
+#          {
+#             "name":"SHUTDOWN"
+#          },
+#          {
+#             "name":"RESET"
+#          }
+#       ]
+#    }
+#
+# Note: This example has been shortened as the real response is too long=
.
+#
+##
+{ 'command': 'query-events', 'returns': ['EventInfo'] }
+
+##
+# @quit:
+#
+# This command will cause the QEMU process to exit gracefully.  While ev=
ery
+# attempt is made to send the QMP response before terminating, this is n=
ot
+# guaranteed.  When using this interface, a premature EOF would not be
+# unexpected.
+#
+# Since: 0.14.0
+#
+# Example:
+#
+# -> { "execute": "quit" }
+# <- { "return": {} }
+##
+{ 'command': 'quit' }
diff --git a/qapi/qapi-schema.json b/qapi/qapi-schema.json
index 9751b11f8f..be90422ffe 100644
--- a/qapi/qapi-schema.json
+++ b/qapi/qapi-schema.json
@@ -103,6 +103,7 @@
 { 'include': 'qdev.json' }
 { 'include': 'machine.json' }
 { 'include': 'machine-target.json' }
+{ 'include': 'monitor.json' }
 { 'include': 'misc.json' }
 { 'include': 'misc-target.json' }
 { 'include': 'audio.json' }
diff --git a/monitor/monitor-internal.h b/monitor/monitor-internal.h
index d78f5ca190..451aa64c1a 100644
--- a/monitor/monitor-internal.h
+++ b/monitor/monitor-internal.h
@@ -27,6 +27,7 @@
=20
 #include "chardev/char-fe.h"
 #include "monitor/monitor.h"
+#include "qapi/qapi-types-monitor.h"
 #include "qapi/qmp/dispatch.h"
 #include "qapi/qmp/json-parser.h"
 #include "qemu/readline.h"
diff --git a/monitor/hmp-cmds.c b/monitor/hmp-cmds.c
index 22d7e6e222..ccdfb547d6 100644
--- a/monitor/hmp-cmds.c
+++ b/monitor/hmp-cmds.c
@@ -33,6 +33,7 @@
 #include "qapi/qapi-commands-char.h"
 #include "qapi/qapi-commands-migration.h"
 #include "qapi/qapi-commands-misc.h"
+#include "qapi/qapi-commands-monitor.h"
 #include "qapi/qapi-commands-net.h"
 #include "qapi/qapi-commands-rocker.h"
 #include "qapi/qapi-commands-run-state.h"
diff --git a/monitor/qmp-cmds.c b/monitor/qmp-cmds.c
index 0880341a2d..b40a9b74de 100644
--- a/monitor/qmp-cmds.c
+++ b/monitor/qmp-cmds.c
@@ -34,6 +34,7 @@
 #include "qapi/qapi-commands-block-core.h"
 #include "qapi/qapi-commands-machine.h"
 #include "qapi/qapi-commands-misc.h"
+#include "qapi/qapi-commands-monitor.h"
 #include "qapi/qapi-commands-ui.h"
 #include "qapi/qmp/qerror.h"
 #include "hw/mem/memory-device.h"
diff --git a/monitor/qmp.c b/monitor/qmp.c
index 9d9e5d8b27..6605f35048 100644
--- a/monitor/qmp.c
+++ b/monitor/qmp.c
@@ -27,7 +27,7 @@
 #include "chardev/char-io.h"
 #include "monitor-internal.h"
 #include "qapi/error.h"
-#include "qapi/qapi-commands-misc.h"
+#include "qapi/qapi-commands-monitor.h"
 #include "qapi/qmp/qdict.h"
 #include "qapi/qmp/qjson.h"
 #include "qapi/qmp/qlist.h"
diff --git a/tests/qmp-test.c b/tests/qmp-test.c
index 1b0eb69832..7fc646ffc2 100644
--- a/tests/qmp-test.c
+++ b/tests/qmp-test.c
@@ -13,7 +13,7 @@
 #include "qemu/osdep.h"
 #include "libqtest.h"
 #include "qapi/error.h"
-#include "qapi/qapi-visit-misc.h"
+#include "qapi/qapi-visit-monitor.h"
 #include "qapi/qmp/qdict.h"
 #include "qapi/qmp/qlist.h"
 #include "qapi/qobject-input-visitor.h"
diff --git a/ui/gtk.c b/ui/gtk.c
index 2f23922afc..d96a11deea 100644
--- a/ui/gtk.c
+++ b/ui/gtk.c
@@ -33,6 +33,7 @@
 #include "qemu/osdep.h"
 #include "qapi/error.h"
 #include "qapi/qapi-commands-misc.h"
+#include "qapi/qapi-commands-monitor.h"
 #include "qemu/cutils.h"
=20
 #include "ui/console.h"
diff --git a/qapi/Makefile.objs b/qapi/Makefile.objs
index dd3f5e6f94..519b6f1a8e 100644
--- a/qapi/Makefile.objs
+++ b/qapi/Makefile.objs
@@ -6,8 +6,8 @@ util-obj-y +=3D qmp-event.o
 util-obj-y +=3D qapi-util.o
=20
 QAPI_COMMON_MODULES =3D audio authz block-core block char common crypto
-QAPI_COMMON_MODULES +=3D dump error introspect job machine migration mis=
c net
-QAPI_COMMON_MODULES +=3D qdev qom rdma rocker run-state sockets tpm
+QAPI_COMMON_MODULES +=3D dump error introspect job machine migration mis=
c monitor
+QAPI_COMMON_MODULES +=3D net qdev qom rdma rocker run-state sockets tpm
 QAPI_COMMON_MODULES +=3D trace transaction ui
 QAPI_TARGET_MODULES =3D machine-target misc-target
 QAPI_MODULES =3D $(QAPI_COMMON_MODULES) $(QAPI_TARGET_MODULES)
--=20
2.20.1


