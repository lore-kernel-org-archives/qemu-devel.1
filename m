Return-Path: <SRS0=PWAB=4X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A00CC10DCE
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2020 17:24:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 064B720658
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2020 17:24:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ba6jpOv1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 064B720658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39924 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jAGiT-0001qd-7H
	for qemu-devel@archiver.kernel.org; Fri, 06 Mar 2020 12:24:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48493)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1jAGZS-0004vT-Ps
 for qemu-devel@nongnu.org; Fri, 06 Mar 2020 12:15:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1jAGZP-0007o3-4u
 for qemu-devel@nongnu.org; Fri, 06 Mar 2020 12:15:34 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:52150
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1jAGZN-0007Si-9k
 for qemu-devel@nongnu.org; Fri, 06 Mar 2020 12:15:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583514922;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ledCnVT86UWg6PpI68aRbcjxettn9pRF0oqqQq3IUhE=;
 b=Ba6jpOv1hODjY+qg+43+AY4Hjo1n4NuAAnOHzhbHlw8gdhe81MZMSjonllsl+FbWuwtLa+
 aZhw9Ewg74NQX2N0m59KCyKfIY8syjZSpMXqrk7Ubdcq3zmGrCNrC8mte+XeYrQi1Ky7Sv
 shCoT3mTULz70k0MSGb8so0C6ewCn6g=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-392-zx_17npdNLqEvOOvGo8Ohw-1; Fri, 06 Mar 2020 12:15:20 -0500
X-MC-Unique: zx_17npdNLqEvOOvGo8Ohw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id ECD4C107ACCC;
 Fri,  6 Mar 2020 17:15:18 +0000 (UTC)
Received: from linux.fritz.box.com (unknown [10.36.118.33])
 by smtp.corp.redhat.com (Postfix) with ESMTP id F168573873;
 Fri,  6 Mar 2020 17:15:17 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Subject: [PULL 10/29] block: Move common QMP commands to block-core QAPI module
Date: Fri,  6 Mar 2020 18:14:39 +0100
Message-Id: <20200306171458.1848-11-kwolf@redhat.com>
In-Reply-To: <20200306171458.1848-1-kwolf@redhat.com>
References: <20200306171458.1848-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: kwolf@redhat.com, peter.maydell@linaro.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

block-core is for everything that isn't related to the system emulator.
Internal snapshots, the NBD server and quorum events make sense in the
tools, too, so move them to block-core.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Message-Id: <20200224143008.13362-5-kwolf@redhat.com>
Acked-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 qapi/block-core.json | 283 ++++++++++++++++++++++++++++++++++++++++++
 qapi/block.json      | 284 -------------------------------------------
 2 files changed, 283 insertions(+), 284 deletions(-)

diff --git a/qapi/block-core.json b/qapi/block-core.json
index 85e27bb61f..60860ead68 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -5447,3 +5447,286 @@
   'data' : { 'node-name': 'str',
              'iothread': 'StrOrNull',
              '*force': 'bool' } }
+
+##
+# @nbd-server-start:
+#
+# Start an NBD server listening on the given host and port.  Block
+# devices can then be exported using @nbd-server-add.  The NBD
+# server will present them as named exports; for example, another
+# QEMU instance could refer to them as "nbd:HOST:PORT:exportname=3DNAME".
+#
+# @addr: Address on which to listen.
+# @tls-creds: ID of the TLS credentials object (since 2.6).
+# @tls-authz: ID of the QAuthZ authorization object used to validate
+#             the client's x509 distinguished name. This object is
+#             is only resolved at time of use, so can be deleted and
+#             recreated on the fly while the NBD server is active.
+#             If missing, it will default to denying access (since 4.0).
+#
+# Returns: error if the server is already running.
+#
+# Since: 1.3.0
+##
+{ 'command': 'nbd-server-start',
+  'data': { 'addr': 'SocketAddressLegacy',
+            '*tls-creds': 'str',
+            '*tls-authz': 'str'} }
+
+##
+# @nbd-server-add:
+#
+# Export a block node to QEMU's embedded NBD server.
+#
+# @device: The device name or node name of the node to be exported
+#
+# @name: Export name. If unspecified, the @device parameter is used as the
+#        export name. (Since 2.12)
+#
+# @description: Free-form description of the export, up to 4096 bytes.
+#               (Since 5.0)
+#
+# @writable: Whether clients should be able to write to the device via the
+#            NBD connection (default false).
+#
+# @bitmap: Also export the dirty bitmap reachable from @device, so the
+#          NBD client can use NBD_OPT_SET_META_CONTEXT with
+#          "qemu:dirty-bitmap:NAME" to inspect the bitmap. (since 4.0)
+#
+# Returns: error if the server is not running, or export with the same nam=
e
+#          already exists.
+#
+# Since: 1.3.0
+##
+{ 'command': 'nbd-server-add',
+  'data': {'device': 'str', '*name': 'str', '*description': 'str',
+           '*writable': 'bool', '*bitmap': 'str' } }
+
+##
+# @NbdServerRemoveMode:
+#
+# Mode for removing an NBD export.
+#
+# @safe: Remove export if there are no existing connections, fail otherwis=
e.
+#
+# @hard: Drop all connections immediately and remove export.
+#
+# Potential additional modes to be added in the future:
+#
+# hide: Just hide export from new clients, leave existing connections as i=
s.
+# Remove export after all clients are disconnected.
+#
+# soft: Hide export from new clients, answer with ESHUTDOWN for all furthe=
r
+# requests from existing clients.
+#
+# Since: 2.12
+##
+{'enum': 'NbdServerRemoveMode', 'data': ['safe', 'hard']}
+
+##
+# @nbd-server-remove:
+#
+# Remove NBD export by name.
+#
+# @name: Export name.
+#
+# @mode: Mode of command operation. See @NbdServerRemoveMode description.
+#        Default is 'safe'.
+#
+# Returns: error if
+#            - the server is not running
+#            - export is not found
+#            - mode is 'safe' and there are existing connections
+#
+# Since: 2.12
+##
+{ 'command': 'nbd-server-remove',
+  'data': {'name': 'str', '*mode': 'NbdServerRemoveMode'} }
+
+##
+# @nbd-server-stop:
+#
+# Stop QEMU's embedded NBD server, and unregister all devices previously
+# added via @nbd-server-add.
+#
+# Since: 1.3.0
+##
+{ 'command': 'nbd-server-stop' }
+
+##
+# @QuorumOpType:
+#
+# An enumeration of the quorum operation types
+#
+# @read: read operation
+#
+# @write: write operation
+#
+# @flush: flush operation
+#
+# Since: 2.6
+##
+{ 'enum': 'QuorumOpType',
+  'data': [ 'read', 'write', 'flush' ] }
+
+##
+# @QUORUM_FAILURE:
+#
+# Emitted by the Quorum block driver if it fails to establish a quorum
+#
+# @reference: device name if defined else node name
+#
+# @sector-num: number of the first sector of the failed read operation
+#
+# @sectors-count: failed read operation sector count
+#
+# Note: This event is rate-limited.
+#
+# Since: 2.0
+#
+# Example:
+#
+# <- { "event": "QUORUM_FAILURE",
+#      "data": { "reference": "usr1", "sector-num": 345435, "sectors-count=
": 5 },
+#      "timestamp": { "seconds": 1344522075, "microseconds": 745528 } }
+#
+##
+{ 'event': 'QUORUM_FAILURE',
+  'data': { 'reference': 'str', 'sector-num': 'int', 'sectors-count': 'int=
' } }
+
+##
+# @QUORUM_REPORT_BAD:
+#
+# Emitted to report a corruption of a Quorum file
+#
+# @type: quorum operation type (Since 2.6)
+#
+# @error: error message. Only present on failure. This field
+#         contains a human-readable error message. There are no semantics =
other
+#         than that the block layer reported an error and clients should n=
ot
+#         try to interpret the error string.
+#
+# @node-name: the graph node name of the block driver state
+#
+# @sector-num: number of the first sector of the failed read operation
+#
+# @sectors-count: failed read operation sector count
+#
+# Note: This event is rate-limited.
+#
+# Since: 2.0
+#
+# Example:
+#
+# 1. Read operation
+#
+# { "event": "QUORUM_REPORT_BAD",
+#      "data": { "node-name": "node0", "sector-num": 345435, "sectors-coun=
t": 5,
+#                "type": "read" },
+#      "timestamp": { "seconds": 1344522075, "microseconds": 745528 } }
+#
+# 2. Flush operation
+#
+# { "event": "QUORUM_REPORT_BAD",
+#      "data": { "node-name": "node0", "sector-num": 0, "sectors-count": 2=
097120,
+#                "type": "flush", "error": "Broken pipe" },
+#      "timestamp": { "seconds": 1456406829, "microseconds": 291763 } }
+#
+##
+{ 'event': 'QUORUM_REPORT_BAD',
+  'data': { 'type': 'QuorumOpType', '*error': 'str', 'node-name': 'str',
+            'sector-num': 'int', 'sectors-count': 'int' } }
+
+##
+# @BlockdevSnapshotInternal:
+#
+# @device: the device name or node-name of a root node to generate the sna=
pshot
+#          from
+#
+# @name: the name of the internal snapshot to be created
+#
+# Notes: In transaction, if @name is empty, or any snapshot matching @name
+#        exists, the operation will fail. Only some image formats support =
it,
+#        for example, qcow2, rbd, and sheepdog.
+#
+# Since: 1.7
+##
+{ 'struct': 'BlockdevSnapshotInternal',
+  'data': { 'device': 'str', 'name': 'str' } }
+
+##
+# @blockdev-snapshot-internal-sync:
+#
+# Synchronously take an internal snapshot of a block device, when the
+# format of the image used supports it. If the name is an empty
+# string, or a snapshot with name already exists, the operation will
+# fail.
+#
+# For the arguments, see the documentation of BlockdevSnapshotInternal.
+#
+# Returns: - nothing on success
+#          - If @device is not a valid block device, GenericError
+#          - If any snapshot matching @name exists, or @name is empty,
+#            GenericError
+#          - If the format of the image used does not support it,
+#            BlockFormatFeatureNotSupported
+#
+# Since: 1.7
+#
+# Example:
+#
+# -> { "execute": "blockdev-snapshot-internal-sync",
+#      "arguments": { "device": "ide-hd0",
+#                     "name": "snapshot0" }
+#    }
+# <- { "return": {} }
+#
+##
+{ 'command': 'blockdev-snapshot-internal-sync',
+  'data': 'BlockdevSnapshotInternal' }
+
+##
+# @blockdev-snapshot-delete-internal-sync:
+#
+# Synchronously delete an internal snapshot of a block device, when the fo=
rmat
+# of the image used support it. The snapshot is identified by name or id o=
r
+# both. One of the name or id is required. Return SnapshotInfo for the
+# successfully deleted snapshot.
+#
+# @device: the device name or node-name of a root node to delete the snaps=
hot
+#          from
+#
+# @id: optional the snapshot's ID to be deleted
+#
+# @name: optional the snapshot's name to be deleted
+#
+# Returns: - SnapshotInfo on success
+#          - If @device is not a valid block device, GenericError
+#          - If snapshot not found, GenericError
+#          - If the format of the image used does not support it,
+#            BlockFormatFeatureNotSupported
+#          - If @id and @name are both not specified, GenericError
+#
+# Since: 1.7
+#
+# Example:
+#
+# -> { "execute": "blockdev-snapshot-delete-internal-sync",
+#      "arguments": { "device": "ide-hd0",
+#                     "name": "snapshot0" }
+#    }
+# <- { "return": {
+#                    "id": "1",
+#                    "name": "snapshot0",
+#                    "vm-state-size": 0,
+#                    "date-sec": 1000012,
+#                    "date-nsec": 10,
+#                    "vm-clock-sec": 100,
+#                    "vm-clock-nsec": 20
+#      }
+#    }
+#
+##
+{ 'command': 'blockdev-snapshot-delete-internal-sync',
+  'data': { 'device': 'str', '*id': 'str', '*name': 'str'},
+  'returns': 'SnapshotInfo' }
diff --git a/qapi/block.json b/qapi/block.json
index da19834db4..d2f3fc01ed 100644
--- a/qapi/block.json
+++ b/qapi/block.json
@@ -60,23 +60,6 @@
 { 'enum': 'FloppyDriveType',
   'data': ['144', '288', '120', 'none', 'auto']}
=20
-##
-# @BlockdevSnapshotInternal:
-#
-# @device: the device name or node-name of a root node to generate the sna=
pshot
-#          from
-#
-# @name: the name of the internal snapshot to be created
-#
-# Notes: In transaction, if @name is empty, or any snapshot matching @name
-#        exists, the operation will fail. Only some image formats support =
it,
-#        for example, qcow2, rbd, and sheepdog.
-#
-# Since: 1.7
-##
-{ 'struct': 'BlockdevSnapshotInternal',
-  'data': { 'device': 'str', 'name': 'str' } }
-
 ##
 # @PRManagerInfo:
 #
@@ -104,84 +87,6 @@
 { 'command': 'query-pr-managers', 'returns': ['PRManagerInfo'],
   'allow-preconfig': true }
=20
-
-##
-# @blockdev-snapshot-internal-sync:
-#
-# Synchronously take an internal snapshot of a block device, when the
-# format of the image used supports it. If the name is an empty
-# string, or a snapshot with name already exists, the operation will
-# fail.
-#
-# For the arguments, see the documentation of BlockdevSnapshotInternal.
-#
-# Returns: - nothing on success
-#          - If @device is not a valid block device, GenericError
-#          - If any snapshot matching @name exists, or @name is empty,
-#            GenericError
-#          - If the format of the image used does not support it,
-#            BlockFormatFeatureNotSupported
-#
-# Since: 1.7
-#
-# Example:
-#
-# -> { "execute": "blockdev-snapshot-internal-sync",
-#      "arguments": { "device": "ide-hd0",
-#                     "name": "snapshot0" }
-#    }
-# <- { "return": {} }
-#
-##
-{ 'command': 'blockdev-snapshot-internal-sync',
-  'data': 'BlockdevSnapshotInternal' }
-
-##
-# @blockdev-snapshot-delete-internal-sync:
-#
-# Synchronously delete an internal snapshot of a block device, when the fo=
rmat
-# of the image used support it. The snapshot is identified by name or id o=
r
-# both. One of the name or id is required. Return SnapshotInfo for the
-# successfully deleted snapshot.
-#
-# @device: the device name or node-name of a root node to delete the snaps=
hot
-#          from
-#
-# @id: optional the snapshot's ID to be deleted
-#
-# @name: optional the snapshot's name to be deleted
-#
-# Returns: - SnapshotInfo on success
-#          - If @device is not a valid block device, GenericError
-#          - If snapshot not found, GenericError
-#          - If the format of the image used does not support it,
-#            BlockFormatFeatureNotSupported
-#          - If @id and @name are both not specified, GenericError
-#
-# Since: 1.7
-#
-# Example:
-#
-# -> { "execute": "blockdev-snapshot-delete-internal-sync",
-#      "arguments": { "device": "ide-hd0",
-#                     "name": "snapshot0" }
-#    }
-# <- { "return": {
-#                    "id": "1",
-#                    "name": "snapshot0",
-#                    "vm-state-size": 0,
-#                    "date-sec": 1000012,
-#                    "date-nsec": 10,
-#                    "vm-clock-sec": 100,
-#                    "vm-clock-nsec": 20
-#      }
-#    }
-#
-##
-{ 'command': 'blockdev-snapshot-delete-internal-sync',
-  'data': { 'device': 'str', '*id': 'str', '*name': 'str'},
-  'returns': 'SnapshotInfo' }
-
 ##
 # @eject:
 #
@@ -210,111 +115,6 @@
             '*id': 'str',
             '*force': 'bool' } }
=20
-##
-# @nbd-server-start:
-#
-# Start an NBD server listening on the given host and port.  Block
-# devices can then be exported using @nbd-server-add.  The NBD
-# server will present them as named exports; for example, another
-# QEMU instance could refer to them as "nbd:HOST:PORT:exportname=3DNAME".
-#
-# @addr: Address on which to listen.
-# @tls-creds: ID of the TLS credentials object (since 2.6).
-# @tls-authz: ID of the QAuthZ authorization object used to validate
-#             the client's x509 distinguished name. This object is
-#             is only resolved at time of use, so can be deleted and
-#             recreated on the fly while the NBD server is active.
-#             If missing, it will default to denying access (since 4.0).
-#
-# Returns: error if the server is already running.
-#
-# Since: 1.3.0
-##
-{ 'command': 'nbd-server-start',
-  'data': { 'addr': 'SocketAddressLegacy',
-            '*tls-creds': 'str',
-            '*tls-authz': 'str'} }
-
-##
-# @nbd-server-add:
-#
-# Export a block node to QEMU's embedded NBD server.
-#
-# @device: The device name or node name of the node to be exported
-#
-# @name: Export name. If unspecified, the @device parameter is used as the
-#        export name. (Since 2.12)
-#
-# @description: Free-form description of the export, up to 4096 bytes.
-#               (Since 5.0)
-#
-# @writable: Whether clients should be able to write to the device via the
-#            NBD connection (default false).
-#
-# @bitmap: Also export the dirty bitmap reachable from @device, so the
-#          NBD client can use NBD_OPT_SET_META_CONTEXT with
-#          "qemu:dirty-bitmap:NAME" to inspect the bitmap. (since 4.0)
-#
-# Returns: error if the server is not running, or export with the same nam=
e
-#          already exists.
-#
-# Since: 1.3.0
-##
-{ 'command': 'nbd-server-add',
-  'data': {'device': 'str', '*name': 'str', '*description': 'str',
-           '*writable': 'bool', '*bitmap': 'str' } }
-
-##
-# @NbdServerRemoveMode:
-#
-# Mode for removing an NBD export.
-#
-# @safe: Remove export if there are no existing connections, fail otherwis=
e.
-#
-# @hard: Drop all connections immediately and remove export.
-#
-# Potential additional modes to be added in the future:
-#
-# hide: Just hide export from new clients, leave existing connections as i=
s.
-# Remove export after all clients are disconnected.
-#
-# soft: Hide export from new clients, answer with ESHUTDOWN for all furthe=
r
-# requests from existing clients.
-#
-# Since: 2.12
-##
-{'enum': 'NbdServerRemoveMode', 'data': ['safe', 'hard']}
-
-##
-# @nbd-server-remove:
-#
-# Remove NBD export by name.
-#
-# @name: Export name.
-#
-# @mode: Mode of command operation. See @NbdServerRemoveMode description.
-#        Default is 'safe'.
-#
-# Returns: error if
-#            - the server is not running
-#            - export is not found
-#            - mode is 'safe' and there are existing connections
-#
-# Since: 2.12
-##
-{ 'command': 'nbd-server-remove',
-  'data': {'name': 'str', '*mode': 'NbdServerRemoveMode'} }
-
-##
-# @nbd-server-stop:
-#
-# Stop QEMU's embedded NBD server, and unregister all devices previously
-# added via @nbd-server-add.
-#
-# Since: 1.3.0
-##
-{ 'command': 'nbd-server-stop' }
-
 ##
 # @DEVICE_TRAY_MOVED:
 #
@@ -367,87 +167,3 @@
 ##
 { 'event': 'PR_MANAGER_STATUS_CHANGED',
   'data': { 'id': 'str', 'connected': 'bool' } }
-
-##
-# @QuorumOpType:
-#
-# An enumeration of the quorum operation types
-#
-# @read: read operation
-#
-# @write: write operation
-#
-# @flush: flush operation
-#
-# Since: 2.6
-##
-{ 'enum': 'QuorumOpType',
-  'data': [ 'read', 'write', 'flush' ] }
-
-##
-# @QUORUM_FAILURE:
-#
-# Emitted by the Quorum block driver if it fails to establish a quorum
-#
-# @reference: device name if defined else node name
-#
-# @sector-num: number of the first sector of the failed read operation
-#
-# @sectors-count: failed read operation sector count
-#
-# Note: This event is rate-limited.
-#
-# Since: 2.0
-#
-# Example:
-#
-# <- { "event": "QUORUM_FAILURE",
-#      "data": { "reference": "usr1", "sector-num": 345435, "sectors-count=
": 5 },
-#      "timestamp": { "seconds": 1344522075, "microseconds": 745528 } }
-#
-##
-{ 'event': 'QUORUM_FAILURE',
-  'data': { 'reference': 'str', 'sector-num': 'int', 'sectors-count': 'int=
' } }
-
-##
-# @QUORUM_REPORT_BAD:
-#
-# Emitted to report a corruption of a Quorum file
-#
-# @type: quorum operation type (Since 2.6)
-#
-# @error: error message. Only present on failure. This field
-#         contains a human-readable error message. There are no semantics =
other
-#         than that the block layer reported an error and clients should n=
ot
-#         try to interpret the error string.
-#
-# @node-name: the graph node name of the block driver state
-#
-# @sector-num: number of the first sector of the failed read operation
-#
-# @sectors-count: failed read operation sector count
-#
-# Note: This event is rate-limited.
-#
-# Since: 2.0
-#
-# Example:
-#
-# 1. Read operation
-#
-# { "event": "QUORUM_REPORT_BAD",
-#      "data": { "node-name": "node0", "sector-num": 345435, "sectors-coun=
t": 5,
-#                "type": "read" },
-#      "timestamp": { "seconds": 1344522075, "microseconds": 745528 } }
-#
-# 2. Flush operation
-#
-# { "event": "QUORUM_REPORT_BAD",
-#      "data": { "node-name": "node0", "sector-num": 0, "sectors-count": 2=
097120,
-#                "type": "flush", "error": "Broken pipe" },
-#      "timestamp": { "seconds": 1456406829, "microseconds": 291763 } }
-#
-##
-{ 'event': 'QUORUM_REPORT_BAD',
-  'data': { 'type': 'QuorumOpType', '*error': 'str', 'node-name': 'str',
-            'sector-num': 'int', 'sectors-count': 'int' } }
--=20
2.20.1


