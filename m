Return-Path: <SRS0=CnYV=4F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C110C35254
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 13:35:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CBC112070B
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 13:35:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Cig/l3ph"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CBC112070B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45630 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j3gYb-0006VU-00
	for qemu-devel@archiver.kernel.org; Mon, 17 Feb 2020 08:35:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54526)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1j3gRn-0004N3-4L
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 08:28:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1j3gRj-0000uf-Ay
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 08:28:26 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:39987
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1j3gRh-0000tM-Mh
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 08:28:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581946101;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wgXn2JGGxLFcZjMcijGFfxTN+fkV401bqeluv0SX930=;
 b=Cig/l3ph2iUDTz6oBTyGROHsUkvB5WT44/o09qm5zCpwHbaMBG3DUahkrbjcG+jWNdvI9k
 QKvVgezg9R2FXXOiv68is872ySoF1Vms4fet3GLaI3rwpyIfXelaQOCg4OrfeEET6+ON0N
 rMr4acIxkxweDw0kuYH0PWrbsTOGXoQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-262-sz9QGhALPc2l5mb8FrNrYw-1; Mon, 17 Feb 2020 08:28:17 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AB8FB477
 for <qemu-devel@nongnu.org>; Mon, 17 Feb 2020 13:28:16 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-117-234.ams2.redhat.com
 [10.36.117.234])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 2C6172CC39;
 Mon, 17 Feb 2020 13:28:16 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id A872511366C3; Mon, 17 Feb 2020 14:28:14 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL v2 2/5] qapi: Split control.json off misc.json
Date: Mon, 17 Feb 2020 14:28:11 +0100
Message-Id: <20200217132814.9018-3-armbru@redhat.com>
In-Reply-To: <20200217132814.9018-1-armbru@redhat.com>
References: <20200217132814.9018-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: sz9QGhALPc2l5mb8FrNrYw-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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
Cc: Kevin Wolf <kwolf@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Kevin Wolf <kwolf@redhat.com>

misc.json contains definitions that are related to the system emulator,
so it can't be used for other tools like the storage daemon. This patch
moves basic functionality that is shared between all tools (and mostly
related to the monitor itself) into a new control.json, which could be
used in tools as well.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Message-Id: <20200129102239.31435-3-kwolf@redhat.com>
[Commit message tweaked]
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 qapi/control.json          | 218 +++++++++++++++++++++++++++++++++++++
 qapi/misc.json             | 212 ------------------------------------
 qapi/qapi-schema.json      |   1 +
 monitor/monitor-internal.h |   1 +
 monitor/hmp-cmds.c         |   1 +
 monitor/misc.c             |   1 +
 monitor/qmp-cmds.c         |   1 +
 monitor/qmp.c              |   2 +-
 tests/qtest/qmp-test.c     |   2 +-
 ui/gtk.c                   |   1 +
 qapi/Makefile.objs         |   6 +-
 11 files changed, 229 insertions(+), 217 deletions(-)
 create mode 100644 qapi/control.json

diff --git a/qapi/control.json b/qapi/control.json
new file mode 100644
index 0000000000..759c20e76f
--- /dev/null
+++ b/qapi/control.json
@@ -0,0 +1,218 @@
+# -*- Mode: Python -*-
+#
+
+##
+# =3D QMP monitor control
+##
+
+##
+# @qmp_capabilities:
+#
+# Enable QMP capabilities.
+#
+# Arguments:
+#
+# @enable: An optional list of QMPCapability values to enable.  The
+#          client must not enable any capability that is not
+#          mentioned in the QMP greeting message.  If the field is not
+#          provided, it means no QMP capabilities will be enabled.
+#          (since 2.12)
+#
+# Example:
+#
+# -> { "execute": "qmp_capabilities",
+#      "arguments": { "enable": [ "oob" ] } }
+# <- { "return": {} }
+#
+# Notes: This command is valid exactly when first connecting: it must be
+#        issued before any other command will be accepted, and will fail o=
nce the
+#        monitor is accepting other commands. (see qemu docs/interop/qmp-s=
pec.txt)
+#
+#        The QMP client needs to explicitly enable QMP capabilities, other=
wise
+#        all the QMP capabilities will be turned off by default.
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
+# @oob: QMP ability to support out-of-band requests.
+#       (Please refer to qmp-spec.txt for more information on OOB)
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
+# @major: The major version number.
+#
+# @minor: The minor version number.
+#
+# @micro: The micro version number.
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
+# @qemu: The version of QEMU.  By current convention, a micro
+#        version of 50 signifies a development branch.  A micro version
+#        greater than or equal to 90 signifies a release candidate for
+#        the next minor version.  A micro version of less than 50
+#        signifies a stable release.
+#
+# @package: QEMU will always set this field to an empty string.  Downstrea=
m
+#           versions of QEMU should set this to a non-empty string.  The
+#           exact format depends on the downstream however it highly
+#           recommended that a unique name is used.
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
+# Returns: A @VersionInfo object describing the current version of QEMU.
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
+# Note: This example has been shortened as the real response is too long.
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
+#       compile-time configuration.  Use query-qmp-schema instead.
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
+# Note: This example has been shortened as the real response is too long.
+#
+##
+{ 'command': 'query-events', 'returns': ['EventInfo'] }
+
+##
+# @quit:
+#
+# This command will cause the QEMU process to exit gracefully.  While ever=
y
+# attempt is made to send the QMP response before terminating, this is not
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
diff --git a/qapi/misc.json b/qapi/misc.json
index af00279e7b..c18fe681fb 100644
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
-# @enable: An optional list of QMPCapability values to enable.  The
-#          client must not enable any capability that is not
-#          mentioned in the QMP greeting message.  If the field is not
-#          provided, it means no QMP capabilities will be enabled.
-#          (since 2.12)
-#
-# Example:
-#
-# -> { "execute": "qmp_capabilities",
-#      "arguments": { "enable": [ "oob" ] } }
-# <- { "return": {} }
-#
-# Notes: This command is valid exactly when first connecting: it must be
-#        issued before any other command will be accepted, and will fail o=
nce the
-#        monitor is accepting other commands. (see qemu docs/interop/qmp-s=
pec.txt)
-#
-#        The QMP client needs to explicitly enable QMP capabilities, other=
wise
-#        all the QMP capabilities will be turned off by default.
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
-# @oob: QMP ability to support out-of-band requests.
-#       (Please refer to qmp-spec.txt for more information on OOB)
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
-# @major: The major version number.
-#
-# @minor: The minor version number.
-#
-# @micro: The micro version number.
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
-# @qemu: The version of QEMU.  By current convention, a micro
-#        version of 50 signifies a development branch.  A micro version
-#        greater than or equal to 90 signifies a release candidate for
-#        the next minor version.  A micro version of less than 50
-#        signifies a stable release.
-#
-# @package: QEMU will always set this field to an empty string.  Downstrea=
m
-#           versions of QEMU should set this to a non-empty string.  The
-#           exact format depends on the downstream however it highly
-#           recommended that a unique name is used.
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
-# Returns: A @VersionInfo object describing the current version of QEMU.
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
-# Note: This example has been shortened as the real response is too long.
-#
-##
-{ 'command': 'query-commands', 'returns': ['CommandInfo'],
-  'allow-preconfig': true }
-
 ##
 # @LostTickPolicy:
 #
@@ -312,48 +159,6 @@
 ##
 { 'command': 'query-uuid', 'returns': 'UuidInfo', 'allow-preconfig': true =
}
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
-#       compile-time configuration.  Use query-qmp-schema instead.
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
-# Note: This example has been shortened as the real response is too long.
-#
-##
-{ 'command': 'query-events', 'returns': ['EventInfo'] }
-
 ##
 # @IOThreadInfo:
 #
@@ -774,23 +579,6 @@
 ##
 { 'command': 'query-pci', 'returns': ['PciInfo'] }
=20
-##
-# @quit:
-#
-# This command will cause the QEMU process to exit gracefully.  While ever=
y
-# attempt is made to send the QMP response before terminating, this is not
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
diff --git a/qapi/qapi-schema.json b/qapi/qapi-schema.json
index 9751b11f8f..fe980ce437 100644
--- a/qapi/qapi-schema.json
+++ b/qapi/qapi-schema.json
@@ -98,6 +98,7 @@
 { 'include': 'migration.json' }
 { 'include': 'transaction.json' }
 { 'include': 'trace.json' }
+{ 'include': 'control.json' }
 { 'include': 'introspect.json' }
 { 'include': 'qom.json' }
 { 'include': 'qdev.json' }
diff --git a/monitor/monitor-internal.h b/monitor/monitor-internal.h
index d78f5ca190..4d402ded85 100644
--- a/monitor/monitor-internal.h
+++ b/monitor/monitor-internal.h
@@ -27,6 +27,7 @@
=20
 #include "chardev/char-fe.h"
 #include "monitor/monitor.h"
+#include "qapi/qapi-types-control.h"
 #include "qapi/qmp/dispatch.h"
 #include "qapi/qmp/json-parser.h"
 #include "qemu/readline.h"
diff --git a/monitor/hmp-cmds.c b/monitor/hmp-cmds.c
index 558fe06b8f..b237613e0d 100644
--- a/monitor/hmp-cmds.c
+++ b/monitor/hmp-cmds.c
@@ -31,6 +31,7 @@
 #include "qapi/qapi-builtin-visit.h"
 #include "qapi/qapi-commands-block.h"
 #include "qapi/qapi-commands-char.h"
+#include "qapi/qapi-commands-control.h"
 #include "qapi/qapi-commands-migration.h"
 #include "qapi/qapi-commands-misc.h"
 #include "qapi/qapi-commands-net.h"
diff --git a/monitor/misc.c b/monitor/misc.c
index 9c3484d0a7..b4303d42d0 100644
--- a/monitor/misc.c
+++ b/monitor/misc.c
@@ -67,6 +67,7 @@
 #include "qemu/thread.h"
 #include "block/qapi.h"
 #include "qapi/qapi-commands-char.h"
+#include "qapi/qapi-commands-control.h"
 #include "qapi/qapi-commands-migration.h"
 #include "qapi/qapi-commands-misc.h"
 #include "qapi/qapi-commands-qom.h"
diff --git a/monitor/qmp-cmds.c b/monitor/qmp-cmds.c
index c6faa3eaf0..a55d2dffc2 100644
--- a/monitor/qmp-cmds.c
+++ b/monitor/qmp-cmds.c
@@ -32,6 +32,7 @@
 #include "sysemu/block-backend.h"
 #include "qapi/error.h"
 #include "qapi/qapi-commands-block-core.h"
+#include "qapi/qapi-commands-control.h"
 #include "qapi/qapi-commands-machine.h"
 #include "qapi/qapi-commands-misc.h"
 #include "qapi/qapi-commands-ui.h"
diff --git a/monitor/qmp.c b/monitor/qmp.c
index 54c06ba824..8379c8f96e 100644
--- a/monitor/qmp.c
+++ b/monitor/qmp.c
@@ -27,7 +27,7 @@
 #include "chardev/char-io.h"
 #include "monitor-internal.h"
 #include "qapi/error.h"
-#include "qapi/qapi-commands-misc.h"
+#include "qapi/qapi-commands-control.h"
 #include "qapi/qmp/qdict.h"
 #include "qapi/qmp/qjson.h"
 #include "qapi/qmp/qlist.h"
diff --git a/tests/qtest/qmp-test.c b/tests/qtest/qmp-test.c
index 1b0eb69832..1a8876b6ca 100644
--- a/tests/qtest/qmp-test.c
+++ b/tests/qtest/qmp-test.c
@@ -13,7 +13,7 @@
 #include "qemu/osdep.h"
 #include "libqtest.h"
 #include "qapi/error.h"
-#include "qapi/qapi-visit-misc.h"
+#include "qapi/qapi-visit-control.h"
 #include "qapi/qmp/qdict.h"
 #include "qapi/qmp/qlist.h"
 #include "qapi/qobject-input-visitor.h"
diff --git a/ui/gtk.c b/ui/gtk.c
index f3f0af8921..030b251c61 100644
--- a/ui/gtk.c
+++ b/ui/gtk.c
@@ -32,6 +32,7 @@
=20
 #include "qemu/osdep.h"
 #include "qapi/error.h"
+#include "qapi/qapi-commands-control.h"
 #include "qapi/qapi-commands-misc.h"
 #include "qemu/cutils.h"
=20
diff --git a/qapi/Makefile.objs b/qapi/Makefile.objs
index a8f1f4c35e..20fcc37c2c 100644
--- a/qapi/Makefile.objs
+++ b/qapi/Makefile.objs
@@ -5,9 +5,9 @@ util-obj-y +=3D opts-visitor.o qapi-clone-visitor.o
 util-obj-y +=3D qmp-event.o
 util-obj-y +=3D qapi-util.o
=20
-QAPI_COMMON_MODULES =3D audio authz block-core block char common crypto
-QAPI_COMMON_MODULES +=3D dump error introspect job machine migration misc =
net
-QAPI_COMMON_MODULES +=3D qdev qom rdma rocker run-state sockets tpm
+QAPI_COMMON_MODULES =3D audio authz block-core block char common control c=
rypto
+QAPI_COMMON_MODULES +=3D dump error introspect job machine migration misc
+QAPI_COMMON_MODULES +=3D net qdev qom rdma rocker run-state sockets tpm
 QAPI_COMMON_MODULES +=3D trace transaction ui
 QAPI_TARGET_MODULES =3D machine-target misc-target
 QAPI_MODULES =3D $(QAPI_COMMON_MODULES) $(QAPI_TARGET_MODULES)
--=20
2.21.1


