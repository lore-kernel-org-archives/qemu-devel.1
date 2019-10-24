Return-Path: <SRS0=Jnn8=YR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93D0ECA9EAF
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 13:28:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 60FE42084C
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 13:28:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="D4DmuWjB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 60FE42084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42610 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNdAL-0004Yo-5g
	for qemu-devel@archiver.kernel.org; Thu, 24 Oct 2019 09:28:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47693)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1iNcKg-0003qA-QZ
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 08:35:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1iNcKf-00068R-2t
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 08:35:14 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:57160
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1iNcKe-00067t-Uk
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 08:35:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1571920512;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=c+207YnY0Ct+qBVy2Eo1y/pQo+gHFJd33LWlUQYqF6E=;
 b=D4DmuWjBFsN22xU86J+kTpLDYO6bcmG/WrzkYktrndM/T9N+FKsnJS8OQZjOtmW320/I7z
 bkBJmjxdUGKaHvjttCrtfRJN4qZp6Be4tZEgKx3RS79TxCMzhfoi5SFBsS/rCS2CktchNL
 M1ptQyAKs3q5jBvku7DixsjiWncImIM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-226-zQty8r6DMbmdmKaYHv5mbA-1; Thu, 24 Oct 2019 08:35:09 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 45E88801E5F;
 Thu, 24 Oct 2019 12:35:08 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.36.118.123])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id DD4A5413A;
 Thu, 24 Oct 2019 12:35:07 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 2B2FB1130344; Thu, 24 Oct 2019 14:34:59 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [RFC PATCH 15/19] qapi: Mark deprecated QMP commands with feature
 'deprecated'
Date: Thu, 24 Oct 2019 14:34:54 +0200
Message-Id: <20191024123458.13505-16-armbru@redhat.com>
In-Reply-To: <20191024123458.13505-1-armbru@redhat.com>
References: <20191024123458.13505-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: zQty8r6DMbmdmKaYHv5mbA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.61
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
Cc: libvir-list@redhat.com, mdroth@linux.vnet.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Add feature 'deprecated' to the deprecated QMP commands, so their
deprecation becomes visible in output of query-qmp-schema.  Looks like
this:

    {"name": "query-cpus",
     "ret-type": "[164]",
     "meta-type": "command",
     "arg-type": "0",
---> "features": ["deprecated"]}

The deprecated commands are change, cpu-add, migrate-set-cache-size,
migrate_set_downtime, migrate_set_speed, query-cpus, query-events,
query-migrate-cache-size.

Management applications can use -compat deprecated-input=3D... to set
policy for these commands.  So far, the only available policy is
"accept", which doesn't change behavior.  The next few commits will
provide more interesting policies.

Command deprecation becomes visible in introspection.  Management
applications could conceivably use this for static checking.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 qapi/machine.json   | 24 ++++++++++++++----------
 qapi/migration.json | 36 ++++++++++++++++++++++++------------
 qapi/misc.json      | 25 +++++++++++++++----------
 3 files changed, 53 insertions(+), 32 deletions(-)

diff --git a/qapi/machine.json b/qapi/machine.json
index ca26779f1a..3913ef2138 100644
--- a/qapi/machine.json
+++ b/qapi/machine.json
@@ -189,6 +189,11 @@
 # It is recommended to use @query-cpus-fast instead of this command to
 # avoid the vCPU interruption.
 #
+# Features:
+# @deprecated: This interface is deprecated (since 2.12.0), and it is
+#     strongly recommended that you avoid using it.  Use
+#     @query-cpus-fast to obtain information about virtual CPUs.
+#
 # Returns: a list of @CpuInfo for each virtual CPU
 #
 # Since: 0.14.0
@@ -218,12 +223,9 @@
 #       ]
 #    }
 #
-# Notes: This interface is deprecated (since 2.12.0), and it is strongly
-#        recommended that you avoid using it. Use @query-cpus-fast to
-#        obtain information about virtual CPUs.
-#
 ##
-{ 'command': 'query-cpus', 'returns': ['CpuInfo'] }
+{ 'command': 'query-cpus', 'returns': ['CpuInfo'],
+  'features': [ 'deprecated' ] }
=20
 ##
 # @CpuInfoFast:
@@ -309,21 +311,23 @@
 #
 # @id: ID of CPU to be created, valid values [0..max_cpus)
 #
+# Features:
+# @deprecated: This command is deprecated.  The `device_add` command
+#     should be used instead.  See the `query-hotpluggable-cpus`
+#     command for details.
+#
 # Returns: Nothing on success
 #
 # Since: 1.5
 #
-# Note: This command is deprecated.  The `device_add` command should be
-#       used instead.  See the `query-hotpluggable-cpus` command for
-#       details.
-#
 # Example:
 #
 # -> { "execute": "cpu-add", "arguments": { "id": 2 } }
 # <- { "return": {} }
 #
 ##
-{ 'command': 'cpu-add', 'data': {'id': 'int'} }
+{ 'command': 'cpu-add', 'data': {'id': 'int'},
+  'features': [ 'deprecated' ] }
=20
 ##
 # @MachineInfo:
diff --git a/qapi/migration.json b/qapi/migration.json
index 82feb5bd39..a110948bfe 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -1119,9 +1119,11 @@
 #
 # @value: maximum downtime in seconds
 #
-# Returns: nothing on success
+# Features:
+# @deprecated: This command is deprecated in favor of
+#     'migrate-set-parameters'.
 #
-# Notes: This command is deprecated in favor of 'migrate-set-parameters'
+# Returns: nothing on success
 #
 # Since: 0.14.0
 #
@@ -1131,7 +1133,8 @@
 # <- { "return": {} }
 #
 ##
-{ 'command': 'migrate_set_downtime', 'data': {'value': 'number'} }
+{ 'command': 'migrate_set_downtime', 'data': {'value': 'number'},
+  'features': [ 'deprecated' ] }
=20
 ##
 # @migrate_set_speed:
@@ -1140,9 +1143,11 @@
 #
 # @value: maximum speed in bytes per second.
 #
-# Returns: nothing on success
+# Features:
+# @deprecated: This command is deprecated in favor of
+#     'migrate-set-parameters'.
 #
-# Notes: This command is deprecated in favor of 'migrate-set-parameters'
+# Returns: nothing on success
 #
 # Since: 0.14.0
 #
@@ -1152,7 +1157,8 @@
 # <- { "return": {} }
 #
 ##
-{ 'command': 'migrate_set_speed', 'data': {'value': 'int'} }
+{ 'command': 'migrate_set_speed', 'data': {'value': 'int'},
+  'features': [ 'deprecated' ] }
=20
 ##
 # @migrate-set-cache-size:
@@ -1161,13 +1167,15 @@
 #
 # @value: cache size in bytes
 #
+# Features:
+# @deprecated: This command is deprecated in favor of
+#     'migrate-set-parameters'.
+#
 # The size will be rounded down to the nearest power of 2.
 # The cache size can be modified before and during ongoing migration
 #
 # Returns: nothing on success
 #
-# Notes: This command is deprecated in favor of 'migrate-set-parameters'
-#
 # Since: 1.2
 #
 # Example:
@@ -1177,17 +1185,20 @@
 # <- { "return": {} }
 #
 ##
-{ 'command': 'migrate-set-cache-size', 'data': {'value': 'int'} }
+{ 'command': 'migrate-set-cache-size', 'data': {'value': 'int'},
+  'features': [ 'deprecated' ] }
=20
 ##
 # @query-migrate-cache-size:
 #
 # Query migration XBZRLE cache size
 #
+# Features:
+# @deprecated: This command is deprecated in favor of
+#     'query-migrate-parameters'.
+#
 # Returns: XBZRLE cache size in bytes
 #
-# Notes: This command is deprecated in favor of 'query-migrate-parameters'
-#
 # Since: 1.2
 #
 # Example:
@@ -1196,7 +1207,8 @@
 # <- { "return": 67108864 }
 #
 ##
-{ 'command': 'query-migrate-cache-size', 'returns': 'int' }
+{ 'command': 'query-migrate-cache-size', 'returns': 'int',
+  'features': [ 'deprecated' ] }
=20
 ##
 # @migrate:
diff --git a/qapi/misc.json b/qapi/misc.json
index 33b94e3589..abd2e5dc6e 100644
--- a/qapi/misc.json
+++ b/qapi/misc.json
@@ -316,13 +316,15 @@
 #
 # Return information on QMP events.
 #
+# Features:
+# @deprecated: This command is deprecated, because its output doesn't
+#     reflect compile-time configuration.  Use query-qmp-schema
+#     instead.
+#
 # Returns: A list of @EventInfo.
 #
 # Since: 1.2.0
 #
-# Note: This command is deprecated, because its output doesn't reflect
-# compile-time configuration.  Use query-qmp-schema instead.
-#
 # Example:
 #
 # -> { "execute": "query-events" }
@@ -340,7 +342,8 @@
 # Note: This example has been shortened as the real response is too long.
 #
 ##
-{ 'command': 'query-events', 'returns': ['EventInfo'] }
+{ 'command': 'query-events', 'returns': ['EventInfo'],
+  'features': [ 'deprecated' ] }
=20
 ##
 # @IOThreadInfo:
@@ -1074,14 +1077,15 @@
 #          If @device is 'vnc' and @target is 'password', this is the new =
VNC
 #          password to set.  See change-vnc-password for additional notes.
 #
+# Features:
+# @deprecated: This command is deprecated, and it is strongly
+#     recommended that you avoid using it.  For changing block
+#     devices, use blockdev-change-medium; for changing VNC
+#     parameters, use change-vnc-password.
+#
 # Returns: Nothing on success.
 #          If @device is not a valid block device, DeviceNotFound
 #
-# Notes:  This interface is deprecated, and it is strongly recommended tha=
t you
-#         avoid using it.  For changing block devices, use
-#         blockdev-change-medium; for changing VNC parameters, use
-#         change-vnc-password.
-#
 # Since: 0.14.0
 #
 # Example:
@@ -1102,7 +1106,8 @@
 #
 ##
 { 'command': 'change',
-  'data': {'device': 'str', 'target': 'str', '*arg': 'str'} }
+  'data': {'device': 'str', 'target': 'str', '*arg': 'str'},
+  'features': [ 'deprecated' ] }
=20
 ##
 # @xen-set-global-dirty-log:
--=20
2.21.0


