Return-Path: <SRS0=hQJD=5C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B12BC1975A
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 21:17:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 01FAF20409
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 21:17:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KjWL1PPC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 01FAF20409
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41580 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jEJaE-00070M-3h
	for qemu-devel@archiver.kernel.org; Tue, 17 Mar 2020 17:17:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51478)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1jEJL9-0002p9-JX
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 17:01:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1jEJL4-0002jr-VC
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 17:01:30 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:39181)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1jEJL4-0002eB-Gq
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 17:01:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584478886;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UB4K6xtam6AnuPFf59x9xIu63zWJz+6nnRoPcRwGZ04=;
 b=KjWL1PPCSD7Ci9NKEUWLgUTnl0XkLjl/mjaQmdO7LDSeuaiGN7ubqArrrCm5NjwQwh0xvx
 O2vcQBxJ+VXtjJuI6T945PewYY5UNY3wa+7Iih2yEQWN3LrGsgCug4cUDvmuoeBSd6NASv
 GenfX584Nyzlu7gCXjk4/p+wpYTtzH8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-26-dRhWCYf8OlOCuapIDIXbDQ-1; Tue, 17 Mar 2020 17:01:24 -0400
X-MC-Unique: dRhWCYf8OlOCuapIDIXbDQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5461C10509A0
 for <qemu-devel@nongnu.org>; Tue, 17 Mar 2020 21:01:23 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-130.ams2.redhat.com
 [10.36.112.130])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C541F5C1BB;
 Tue, 17 Mar 2020 21:01:22 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 9D5791135243; Tue, 17 Mar 2020 22:01:15 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 27/30] qapi: Mark deprecated QMP parts with feature 'deprecated'
Date: Tue, 17 Mar 2020 22:01:12 +0100
Message-Id: <20200317210115.8864-28-armbru@redhat.com>
In-Reply-To: <20200317210115.8864-1-armbru@redhat.com>
References: <20200317210115.8864-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 63.128.21.74
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

Management applications could conceivably use this for static
checking.

The deprecated commands are change, cpu-add, migrate-set-cache-size,
migrate_set_downtime, migrate_set_speed, query-cpus, query-events,
query-migrate-cache-size.

The deprecated command arguments are block-commit arguments @base and
@top, and block_set_io_throttle, blockdev-change-medium,
blockdev-close-tray, blockdev-open-tray, eject argument @device.

The deprecated command results are query-cpus-fast result @arch,
query-block result @dirty-bitmaps, query-named-block-nodes result
@encryption_key_missing and result @dirty-bitmaps's member @status.
Same for query-block result @inserted, which mirrors
query-named-block-nodes.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Message-Id: <20200317115459.31821-27-armbru@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 qapi/block-core.json | 48 ++++++++++++++++++++++++++++++++++----------
 qapi/block.json      | 30 ++++++++++++++++++---------
 qapi/control.json    | 11 ++++++----
 qapi/machine.json    | 34 +++++++++++++++++--------------
 qapi/migration.json  | 36 ++++++++++++++++++++++-----------
 qapi/misc.json       | 13 ++++++------
 6 files changed, 115 insertions(+), 57 deletions(-)

diff --git a/qapi/block-core.json b/qapi/block-core.json
index 91586fb1fb..943df1926a 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -297,7 +297,7 @@
 #
 # @encrypted: true if the backing device is encrypted
 #
-# @encryption_key_missing: Deprecated; always false
+# @encryption_key_missing: always false
 #
 # @detect_zeroes: detect and optimize zero writes (Since 2.1)
 #
@@ -363,13 +363,19 @@
 # @dirty-bitmaps: dirty bitmaps information (only present if node
 #                 has one or more dirty bitmaps) (Since 4.2)
 #
+# Features:
+# @deprecated: Member @encryption_key_missing is deprecated.  It is
+#     always false.
+#
 # Since: 0.14.0
 #
 ##
 { 'struct': 'BlockDeviceInfo',
   'data': { 'file': 'str', '*node-name': 'str', 'ro': 'bool', 'drv': 'str'=
,
             '*backing_file': 'str', 'backing_file_depth': 'int',
-            'encrypted': 'bool', 'encryption_key_missing': 'bool',
+            'encrypted': 'bool',
+            'encryption_key_missing': { 'type': 'bool',
+                                        'features': [ 'deprecated' ] },
             'detect_zeroes': 'BlockdevDetectZeroesOptions',
             'bps': 'int', 'bps_rd': 'int', 'bps_wr': 'int',
             'iops': 'int', 'iops_rd': 'int', 'iops_wr': 'int',
@@ -475,7 +481,7 @@
 #
 # @granularity: granularity of the dirty bitmap in bytes (since 1.4)
 #
-# @status: Deprecated in favor of @recording and @locked. (since 2.4)
+# @status: current status of the dirty bitmap (since 2.4)
 #
 # @recording: true if the bitmap is recording new writes from the guest.
 #             Replaces `active` and `disabled` statuses. (since 4.0)
@@ -492,11 +498,17 @@
 #                @busy to be false. This bitmap cannot be used. To remove
 #                it, use @block-dirty-bitmap-remove. (Since 4.0)
 #
+# Features:
+# @deprecated: Member @status is deprecated.  Use @recording and
+#     @locked instead.
+#
 # Since: 1.3
 ##
 { 'struct': 'BlockDirtyInfo',
   'data': {'*name': 'str', 'count': 'int', 'granularity': 'uint32',
-           'recording': 'bool', 'busy': 'bool', 'status': 'DirtyBitmapStat=
us',
+           'recording': 'bool', 'busy': 'bool',
+           'status': { 'type': 'DirtyBitmapStatus',
+                       'features': [ 'deprecated' ] },
            'persistent': 'bool', '*inconsistent': 'bool' } }
=20
 ##
@@ -587,7 +599,6 @@
 #
 # @dirty-bitmaps: dirty bitmaps information (only present if the
 #                 driver has one or more dirty bitmaps) (Since 2.0)
-#                 Deprecated in 4.2; see BlockDeviceInfo instead.
 #
 # @io-status: @BlockDeviceIoStatus. Only present if the device
 #             supports it and the VM is configured to stop on errors
@@ -597,13 +608,18 @@
 # @inserted: @BlockDeviceInfo describing the device if media is
 #            present
 #
+# Features:
+# @deprecated: Member @dirty-bitmaps is deprecated.  Use @inserted
+#     member @dirty-bitmaps instead.
+#
 # Since:  0.14.0
 ##
 { 'struct': 'BlockInfo',
   'data': {'device': 'str', '*qdev': 'str', 'type': 'str', 'removable': 'b=
ool',
            'locked': 'bool', '*inserted': 'BlockDeviceInfo',
            '*tray_open': 'bool', '*io-status': 'BlockDeviceIoStatus',
-           '*dirty-bitmaps': ['BlockDirtyInfo'] } }
+           '*dirty-bitmaps': { 'type': ['BlockDirtyInfo'],
+                               'features': [ 'deprecated' ] } } }
=20
 ##
 # @BlockMeasureInfo:
@@ -1551,7 +1567,7 @@
 # @base: Same as @base-node, except that it is a file name rather than a n=
ode
 #        name. This must be the exact filename string that was used to ope=
n the
 #        node; other strings, even if addressing the same file, are not
-#        accepted (deprecated, use @base-node instead)
+#        accepted
 #
 # @top-node: The node name of the backing image within the image chain
 #            which contains the topmost data to be committed down. If
@@ -1560,7 +1576,7 @@
 # @top: Same as @top-node, except that it is a file name rather than a nod=
e
 #       name. This must be the exact filename string that was used to open=
 the
 #       node; other strings, even if addressing the same file, are not
-#       accepted (deprecated, use @base-node instead)
+#       accepted
 #
 # @backing-file: The backing file string to write into the overlay
 #                image of 'top'.  If 'top' is the active layer,
@@ -1614,6 +1630,10 @@
 #                list without user intervention.
 #                Defaults to true. (Since 3.1)
 #
+# Features:
+# @deprecated: Members @base and @top are deprecated.  Use @base-node
+#     and @top-node instead.
+#
 # Returns: - Nothing on success
 #          - If @device does not exist, DeviceNotFound
 #          - Any other error returns a GenericError.
@@ -1630,7 +1650,9 @@
 ##
 { 'command': 'block-commit',
   'data': { '*job-id': 'str', 'device': 'str', '*base-node': 'str',
-            '*base': 'str', '*top-node': 'str', '*top': 'str',
+            '*base': { 'type': 'str', 'features': [ 'deprecated' ] },
+            '*top-node': 'str',
+            '*top': { 'type': 'str', 'features': [ 'deprecated' ] },
             '*backing-file': 'str', '*speed': 'int',
             '*on-error': 'BlockdevOnError',
             '*filter-node-name': 'str',
@@ -2296,7 +2318,7 @@
 #
 # A set of parameters describing block throttling.
 #
-# @device: Block device name (deprecated, use @id instead)
+# @device: Block device name
 #
 # @id: The name or QOM path of the guest device (since: 2.8)
 #
@@ -2364,10 +2386,14 @@
 #
 # @group: throttle group name (Since 2.4)
 #
+# Features:
+# @deprecated: Member @device is deprecated.  Use @id instead.
+#
 # Since: 1.1
 ##
 { 'struct': 'BlockIOThrottle',
-  'data': { '*device': 'str', '*id': 'str', 'bps': 'int', 'bps_rd': 'int',
+  'data': { '*device': { 'type': 'str', 'features': [ 'deprecated' ] },
+            '*id': 'str', 'bps': 'int', 'bps_rd': 'int',
             'bps_wr': 'int', 'iops': 'int', 'iops_rd': 'int', 'iops_wr': '=
int',
             '*bps_max': 'int', '*bps_rd_max': 'int',
             '*bps_wr_max': 'int', '*iops_max': 'int',
diff --git a/qapi/block.json b/qapi/block.json
index 97bf52b7c7..2ddbfa8306 100644
--- a/qapi/block.json
+++ b/qapi/block.json
@@ -90,15 +90,18 @@
 ##
 # @eject:
 #
-# Ejects a device from a removable drive.
+# Ejects the medium from a removable drive.
 #
-# @device: Block device name (deprecated, use @id instead)
+# @device: Block device name
 #
 # @id: The name or QOM path of the guest device (since: 2.8)
 #
 # @force: If true, eject regardless of whether the drive is locked.
 #         If not specified, the default value is false.
 #
+# Features:
+# @deprecated: Member @device is deprecated.  Use @id instead.
+#
 # Returns: - Nothing on success
 #          - If @device is not a valid block device, DeviceNotFound
 # Notes:    Ejecting a device with no media results in success
@@ -111,7 +114,7 @@
 # <- { "return": {} }
 ##
 { 'command': 'eject',
-  'data': { '*device': 'str',
+  'data': { '*device': { 'type': 'str', 'features': [ 'deprecated' ] },
             '*id': 'str',
             '*force': 'bool' } }
=20
@@ -134,7 +137,7 @@
 #   to it
 # - if the guest device does not have an actual tray
 #
-# @device: Block device name (deprecated, use @id instead)
+# @device: Block device name
 #
 # @id: The name or QOM path of the guest device (since: 2.8)
 #
@@ -143,6 +146,9 @@
 #         immediately); if true, the tray will be opened regardless of whe=
ther
 #         it is locked
 #
+# Features:
+# @deprecated: Member @device is deprecated.  Use @id instead.
+#
 # Since: 2.5
 #
 # Example:
@@ -161,7 +167,7 @@
 #
 ##
 { 'command': 'blockdev-open-tray',
-  'data': { '*device': 'str',
+  'data': { '*device': { 'type': 'str', 'features': [ 'deprecated' ] },
             '*id': 'str',
             '*force': 'bool' } }
=20
@@ -174,10 +180,13 @@
 #
 # If the tray was already closed before, this will be a no-op.
 #
-# @device: Block device name (deprecated, use @id instead)
+# @device: Block device name
 #
 # @id: The name or QOM path of the guest device (since: 2.8)
 #
+# Features:
+# @deprecated: Member @device is deprecated.  Use @id instead.
+#
 # Since: 2.5
 #
 # Example:
@@ -196,7 +205,7 @@
 #
 ##
 { 'command': 'blockdev-close-tray',
-  'data': { '*device': 'str',
+  'data': { '*device': { 'type': 'str', 'features': [ 'deprecated' ] },
             '*id': 'str' } }
=20
 ##
@@ -303,7 +312,7 @@
 # combines blockdev-open-tray, blockdev-remove-medium, blockdev-insert-med=
ium
 # and blockdev-close-tray).
 #
-# @device: Block device name (deprecated, use @id instead)
+# @device: Block device name
 #
 # @id: The name or QOM path of the guest device
 #      (since: 2.8)
@@ -316,6 +325,9 @@
 # @read-only-mode: change the read-only mode of the device; defaults
 #                  to 'retain'
 #
+# Features:
+# @deprecated: Member @device is deprecated.  Use @id instead.
+#
 # Since: 2.5
 #
 # Examples:
@@ -350,7 +362,7 @@
 #
 ##
 { 'command': 'blockdev-change-medium',
-  'data': { '*device': 'str',
+  'data': { '*device': { 'type': 'str', 'features': [ 'deprecated' ] },
             '*id': 'str',
             'filename': 'str',
             '*format': 'str',
diff --git a/qapi/control.json b/qapi/control.json
index 85b12fe0fb..6b816bb61f 100644
--- a/qapi/control.json
+++ b/qapi/control.json
@@ -174,13 +174,15 @@
 #
 # Return information on QMP events.
 #
+# Features:
+# @deprecated: This command is deprecated, because its output doesn't
+#     reflect compile-time configuration.  Use 'query-qmp-schema'
+#     instead.
+#
 # Returns: A list of @EventInfo.
 #
 # Since: 1.2.0
 #
-# Note: This command is deprecated, because its output doesn't reflect
-#       compile-time configuration.  Use query-qmp-schema instead.
-#
 # Example:
 #
 # -> { "execute": "query-events" }
@@ -198,7 +200,8 @@
 # Note: This example has been shortened as the real response is too long.
 #
 ##
-{ 'command': 'query-events', 'returns': ['EventInfo'] }
+{ 'command': 'query-events', 'returns': ['EventInfo'],
+  'features': [ 'deprecated' ] }
=20
 ##
 # @quit:
diff --git a/qapi/machine.json b/qapi/machine.json
index 6c11e3cf3a..0da3f3adc4 100644
--- a/qapi/machine.json
+++ b/qapi/machine.json
@@ -184,8 +184,11 @@
 # This command causes vCPU threads to exit to userspace, which causes
 # a small interruption to guest CPU execution. This will have a negative
 # impact on realtime guests and other latency sensitive guest workloads.
-# It is recommended to use @query-cpus-fast instead of this command to
-# avoid the vCPU interruption.
+#
+# Features:
+# @deprecated: This command is deprecated, because it interferes with
+#     the guest.  Use 'query-cpus-fast' instead to avoid the vCPU
+#     interruption.
 #
 # Returns: a list of @CpuInfo for each virtual CPU
 #
@@ -216,12 +219,9 @@
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
@@ -237,12 +237,14 @@
 # @props: properties describing to which node/socket/core/thread
 #         virtual CPU belongs to, provided if supported by board
 #
-# @arch: base architecture of the cpu; deprecated since 3.0.0 in favor
-#        of @target
+# @arch: base architecture of the cpu
 #
 # @target: the QEMU system emulation target, which determines which
 #          additional fields will be listed (since 3.0)
 #
+# Features:
+# @deprecated: Member @arch is deprecated.  Use @target instead.
+#
 # Since: 2.12
 #
 ##
@@ -251,7 +253,8 @@
                       'qom-path'     : 'str',
                       'thread-id'    : 'int',
                       '*props'       : 'CpuInstanceProperties',
-                      'arch'         : 'CpuInfoArch',
+                      'arch'         : { 'type': 'CpuInfoArch',
+                                         'features': [ 'deprecated' ] },
                       'target'       : 'SysEmuTarget' },
   'discriminator' : 'target',
   'data'          : { 's390x'        : 'CpuInfoS390' } }
@@ -307,21 +310,22 @@
 #
 # @id: ID of CPU to be created, valid values [0..max_cpus)
 #
+# Features:
+# @deprecated: This command is deprecated.  Use `device_add` instead.
+#     See the `query-hotpluggable-cpus` command for details.
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
index 0d1c0712ca..eca2981d0a 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -1210,9 +1210,11 @@
 #
 # @value: maximum downtime in seconds
 #
-# Returns: nothing on success
+# Features:
+# @deprecated: This command is deprecated.  Use
+#     'migrate-set-parameters' instead.
 #
-# Notes: This command is deprecated in favor of 'migrate-set-parameters'
+# Returns: nothing on success
 #
 # Since: 0.14.0
 #
@@ -1222,7 +1224,8 @@
 # <- { "return": {} }
 #
 ##
-{ 'command': 'migrate_set_downtime', 'data': {'value': 'number'} }
+{ 'command': 'migrate_set_downtime', 'data': {'value': 'number'},
+  'features': [ 'deprecated' ] }
=20
 ##
 # @migrate_set_speed:
@@ -1231,9 +1234,11 @@
 #
 # @value: maximum speed in bytes per second.
 #
-# Returns: nothing on success
+# Features:
+# @deprecated: This command is deprecated.  Use
+#     'migrate-set-parameters' instead.
 #
-# Notes: This command is deprecated in favor of 'migrate-set-parameters'
+# Returns: nothing on success
 #
 # Since: 0.14.0
 #
@@ -1243,7 +1248,8 @@
 # <- { "return": {} }
 #
 ##
-{ 'command': 'migrate_set_speed', 'data': {'value': 'int'} }
+{ 'command': 'migrate_set_speed', 'data': {'value': 'int'},
+  'features': [ 'deprecated' ] }
=20
 ##
 # @migrate-set-cache-size:
@@ -1252,13 +1258,15 @@
 #
 # @value: cache size in bytes
 #
+# Features:
+# @deprecated: This command is deprecated.  Use
+#     'migrate-set-parameters' instead.
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
@@ -1268,17 +1276,20 @@
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
+# @deprecated: This command is deprecated.  Use
+#     'query-migrate-parameters' instead.
+#
 # Returns: XBZRLE cache size in bytes
 #
-# Notes: This command is deprecated in favor of 'query-migrate-parameters'
-#
 # Since: 1.2
 #
 # Example:
@@ -1287,7 +1298,8 @@
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
index c18fe681fb..99b90ac80b 100644
--- a/qapi/misc.json
+++ b/qapi/misc.json
@@ -872,14 +872,14 @@
 #       If @device is 'vnc' and @target is 'password', this is the new VNC
 #       password to set.  See change-vnc-password for additional notes.
 #
+# Features:
+# @deprecated: This command is deprecated.  For changing block
+#     devices, use 'blockdev-change-medium' instead; for changing VNC
+#     parameters, use 'change-vnc-password' instead.
+#
 # Returns: - Nothing on success.
 #          - If @device is not a valid block device, DeviceNotFound
 #
-# Notes: This interface is deprecated, and it is strongly recommended that=
 you
-#        avoid using it.  For changing block devices, use
-#        blockdev-change-medium; for changing VNC parameters, use
-#        change-vnc-password.
-#
 # Since: 0.14.0
 #
 # Example:
@@ -900,7 +900,8 @@
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
2.21.1


