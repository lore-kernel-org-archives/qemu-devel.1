Return-Path: <SRS0=PWAB=4X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B55FC10DCE
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2020 17:34:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B8C7C2051A
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2020 17:34:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KTtrnOGt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B8C7C2051A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40114 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jAGrM-0001RD-QZ
	for qemu-devel@archiver.kernel.org; Fri, 06 Mar 2020 12:34:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48684)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1jAGZY-00052t-F7
 for qemu-devel@nongnu.org; Fri, 06 Mar 2020 12:15:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1jAGZS-0007zD-0t
 for qemu-devel@nongnu.org; Fri, 06 Mar 2020 12:15:40 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:29187
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1jAGZR-0007Uw-NK
 for qemu-devel@nongnu.org; Fri, 06 Mar 2020 12:15:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583514923;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OcH8eKi4Qiy97MK/pvkScSLH84ymuY0qvlO8RIyaeec=;
 b=KTtrnOGtpMrXPcOlQmeTfxSHkN8/aROQ2Gv0tNB8S/JIXmUSH8wLYXtJfMPf15OGqam4uy
 XN9/DivluLsuqCjt9RDLzLm6e0PS5e32irHfvTgeRxonCcqar4dgH8qZKKvFSsNFIGmPJJ
 195rkPhwezEWwWMJn8e19lFEa73YnL0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-339-5rz8zRRLMuODSRccqYVl8A-1; Fri, 06 Mar 2020 12:15:21 -0500
X-MC-Unique: 5rz8zRRLMuODSRccqYVl8A-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3BDE4800053;
 Fri,  6 Mar 2020 17:15:20 +0000 (UTC)
Received: from linux.fritz.box.com (unknown [10.36.118.33])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 41E5C73873;
 Fri,  6 Mar 2020 17:15:19 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Subject: [PULL 11/29] block: Move sysemu QMP commands to QAPI block module
Date: Fri,  6 Mar 2020 18:14:40 +0100
Message-Id: <20200306171458.1848-12-kwolf@redhat.com>
In-Reply-To: <20200306171458.1848-1-kwolf@redhat.com>
References: <20200306171458.1848-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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

QMP commands that are related to the system emulator and don't make
sense in the context of tools such as qemu-storage-daemon should live in
qapi/block.json rather than qapi/block-core.json. Move them there.

The associated data types are actually also used in code shared with the
tools, so they stay in block-core.json.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Message-Id: <20200224143008.13362-6-kwolf@redhat.com>
Acked-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 qapi/block-core.json | 386 -------------------------------------------
 qapi/block.json      | 386 +++++++++++++++++++++++++++++++++++++++++++
 monitor/qmp-cmds.c   |   2 +-
 3 files changed, 387 insertions(+), 387 deletions(-)

diff --git a/qapi/block-core.json b/qapi/block-core.json
index 60860ead68..b65b6a9f49 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -563,78 +563,6 @@
 { 'struct': 'BlockLatencyHistogramInfo',
   'data': {'boundaries': ['uint64'], 'bins': ['uint64'] } }
=20
-##
-# @block-latency-histogram-set:
-#
-# Manage read, write and flush latency histograms for the device.
-#
-# If only @id parameter is specified, remove all present latency histogram=
s
-# for the device. Otherwise, add/reset some of (or all) latency histograms=
.
-#
-# @id: The name or QOM path of the guest device.
-#
-# @boundaries: list of interval boundary values (see description in
-#              BlockLatencyHistogramInfo definition). If specified, all
-#              latency histograms are removed, and empty ones created for =
all
-#              io types with intervals corresponding to @boundaries (excep=
t for
-#              io types, for which specific boundaries are set through the
-#              following parameters).
-#
-# @boundaries-read: list of interval boundary values for read latency
-#                   histogram. If specified, old read latency histogram is
-#                   removed, and empty one created with intervals
-#                   corresponding to @boundaries-read. The parameter has h=
igher
-#                   priority then @boundaries.
-#
-# @boundaries-write: list of interval boundary values for write latency
-#                    histogram.
-#
-# @boundaries-flush: list of interval boundary values for flush latency
-#                    histogram.
-#
-# Returns: error if device is not found or any boundary arrays are invalid=
.
-#
-# Since: 4.0
-#
-# Example: set new histograms for all io types with intervals
-# [0, 10), [10, 50), [50, 100), [100, +inf):
-#
-# -> { "execute": "block-latency-histogram-set",
-#      "arguments": { "id": "drive0",
-#                     "boundaries": [10, 50, 100] } }
-# <- { "return": {} }
-#
-# Example: set new histogram only for write, other histograms will remain
-# not changed (or not created):
-#
-# -> { "execute": "block-latency-histogram-set",
-#      "arguments": { "id": "drive0",
-#                     "boundaries-write": [10, 50, 100] } }
-# <- { "return": {} }
-#
-# Example: set new histograms with the following intervals:
-#   read, flush: [0, 10), [10, 50), [50, 100), [100, +inf)
-#   write: [0, 1000), [1000, 5000), [5000, +inf)
-#
-# -> { "execute": "block-latency-histogram-set",
-#      "arguments": { "id": "drive0",
-#                     "boundaries": [10, 50, 100],
-#                     "boundaries-write": [1000, 5000] } }
-# <- { "return": {} }
-#
-# Example: remove all latency histograms:
-#
-# -> { "execute": "block-latency-histogram-set",
-#      "arguments": { "id": "drive0" } }
-# <- { "return": {} }
-##
-{ 'command': 'block-latency-histogram-set',
-  'data': {'id': 'str',
-           '*boundaries': ['uint64'],
-           '*boundaries-read': ['uint64'],
-           '*boundaries-write': ['uint64'],
-           '*boundaries-flush': ['uint64'] } }
-
 ##
 # @BlockInfo:
 #
@@ -2356,78 +2284,6 @@
             '*copy-mode': 'MirrorCopyMode',
             '*auto-finalize': 'bool', '*auto-dismiss': 'bool' } }
=20
-##
-# @block_set_io_throttle:
-#
-# Change I/O throttle limits for a block drive.
-#
-# Since QEMU 2.4, each device with I/O limits is member of a throttle
-# group.
-#
-# If two or more devices are members of the same group, the limits
-# will apply to the combined I/O of the whole group in a round-robin
-# fashion. Therefore, setting new I/O limits to a device will affect
-# the whole group.
-#
-# The name of the group can be specified using the 'group' parameter.
-# If the parameter is unset, it is assumed to be the current group of
-# that device. If it's not in any group yet, the name of the device
-# will be used as the name for its group.
-#
-# The 'group' parameter can also be used to move a device to a
-# different group. In this case the limits specified in the parameters
-# will be applied to the new group only.
-#
-# I/O limits can be disabled by setting all of them to 0. In this case
-# the device will be removed from its group and the rest of its
-# members will not be affected. The 'group' parameter is ignored.
-#
-# Returns: - Nothing on success
-#          - If @device is not a valid block device, DeviceNotFound
-#
-# Since: 1.1
-#
-# Example:
-#
-# -> { "execute": "block_set_io_throttle",
-#      "arguments": { "id": "virtio-blk-pci0/virtio-backend",
-#                     "bps": 0,
-#                     "bps_rd": 0,
-#                     "bps_wr": 0,
-#                     "iops": 512,
-#                     "iops_rd": 0,
-#                     "iops_wr": 0,
-#                     "bps_max": 0,
-#                     "bps_rd_max": 0,
-#                     "bps_wr_max": 0,
-#                     "iops_max": 0,
-#                     "iops_rd_max": 0,
-#                     "iops_wr_max": 0,
-#                     "bps_max_length": 0,
-#                     "iops_size": 0 } }
-# <- { "return": {} }
-#
-# -> { "execute": "block_set_io_throttle",
-#      "arguments": { "id": "ide0-1-0",
-#                     "bps": 1000000,
-#                     "bps_rd": 0,
-#                     "bps_wr": 0,
-#                     "iops": 0,
-#                     "iops_rd": 0,
-#                     "iops_wr": 0,
-#                     "bps_max": 8000000,
-#                     "bps_rd_max": 0,
-#                     "bps_wr_max": 0,
-#                     "iops_max": 0,
-#                     "iops_rd_max": 0,
-#                     "iops_wr_max": 0,
-#                     "bps_max_length": 60,
-#                     "iops_size": 0 } }
-# <- { "return": {} }
-##
-{ 'command': 'block_set_io_throttle', 'boxed': true,
-  'data': 'BlockIOThrottle' }
-
 ##
 # @BlockIOThrottle:
 #
@@ -4757,248 +4613,6 @@
   'data': { 'job-id': 'str',
             'options': 'BlockdevCreateOptions' } }
=20
-##
-# @blockdev-open-tray:
-#
-# Opens a block device's tray. If there is a block driver state tree inser=
ted as
-# a medium, it will become inaccessible to the guest (but it will remain
-# associated to the block device, so closing the tray will make it accessi=
ble
-# again).
-#
-# If the tray was already open before, this will be a no-op.
-#
-# Once the tray opens, a DEVICE_TRAY_MOVED event is emitted. There are cas=
es in
-# which no such event will be generated, these include:
-#
-# - if the guest has locked the tray, @force is false and the guest does n=
ot
-#   respond to the eject request
-# - if the BlockBackend denoted by @device does not have a guest device at=
tached
-#   to it
-# - if the guest device does not have an actual tray
-#
-# @device: Block device name (deprecated, use @id instead)
-#
-# @id: The name or QOM path of the guest device (since: 2.8)
-#
-# @force: if false (the default), an eject request will be sent to
-#         the guest if it has locked the tray (and the tray will not be op=
ened
-#         immediately); if true, the tray will be opened regardless of whe=
ther
-#         it is locked
-#
-# Since: 2.5
-#
-# Example:
-#
-# -> { "execute": "blockdev-open-tray",
-#      "arguments": { "id": "ide0-1-0" } }
-#
-# <- { "timestamp": { "seconds": 1418751016,
-#                     "microseconds": 716996 },
-#      "event": "DEVICE_TRAY_MOVED",
-#      "data": { "device": "ide1-cd0",
-#                "id": "ide0-1-0",
-#                "tray-open": true } }
-#
-# <- { "return": {} }
-#
-##
-{ 'command': 'blockdev-open-tray',
-  'data': { '*device': 'str',
-            '*id': 'str',
-            '*force': 'bool' } }
-
-##
-# @blockdev-close-tray:
-#
-# Closes a block device's tray. If there is a block driver state tree asso=
ciated
-# with the block device (which is currently ejected), that tree will be lo=
aded
-# as the medium.
-#
-# If the tray was already closed before, this will be a no-op.
-#
-# @device: Block device name (deprecated, use @id instead)
-#
-# @id: The name or QOM path of the guest device (since: 2.8)
-#
-# Since: 2.5
-#
-# Example:
-#
-# -> { "execute": "blockdev-close-tray",
-#      "arguments": { "id": "ide0-1-0" } }
-#
-# <- { "timestamp": { "seconds": 1418751345,
-#                     "microseconds": 272147 },
-#      "event": "DEVICE_TRAY_MOVED",
-#      "data": { "device": "ide1-cd0",
-#                "id": "ide0-1-0",
-#                "tray-open": false } }
-#
-# <- { "return": {} }
-#
-##
-{ 'command': 'blockdev-close-tray',
-  'data': { '*device': 'str',
-            '*id': 'str' } }
-
-##
-# @blockdev-remove-medium:
-#
-# Removes a medium (a block driver state tree) from a block device. That b=
lock
-# device's tray must currently be open (unless there is no attached guest
-# device).
-#
-# If the tray is open and there is no medium inserted, this will be a no-o=
p.
-#
-# @id: The name or QOM path of the guest device
-#
-# Since: 2.12
-#
-# Example:
-#
-# -> { "execute": "blockdev-remove-medium",
-#      "arguments": { "id": "ide0-1-0" } }
-#
-# <- { "error": { "class": "GenericError",
-#                 "desc": "Tray of device 'ide0-1-0' is not open" } }
-#
-# -> { "execute": "blockdev-open-tray",
-#      "arguments": { "id": "ide0-1-0" } }
-#
-# <- { "timestamp": { "seconds": 1418751627,
-#                     "microseconds": 549958 },
-#      "event": "DEVICE_TRAY_MOVED",
-#      "data": { "device": "ide1-cd0",
-#                "id": "ide0-1-0",
-#                "tray-open": true } }
-#
-# <- { "return": {} }
-#
-# -> { "execute": "blockdev-remove-medium",
-#      "arguments": { "id": "ide0-1-0" } }
-#
-# <- { "return": {} }
-#
-##
-{ 'command': 'blockdev-remove-medium',
-  'data': { 'id': 'str' } }
-
-##
-# @blockdev-insert-medium:
-#
-# Inserts a medium (a block driver state tree) into a block device. That b=
lock
-# device's tray must currently be open (unless there is no attached guest
-# device) and there must be no medium inserted already.
-#
-# @id: The name or QOM path of the guest device
-#
-# @node-name: name of a node in the block driver state graph
-#
-# Since: 2.12
-#
-# Example:
-#
-# -> { "execute": "blockdev-add",
-#      "arguments": {
-#          "node-name": "node0",
-#          "driver": "raw",
-#          "file": { "driver": "file",
-#                    "filename": "fedora.iso" } } }
-# <- { "return": {} }
-#
-# -> { "execute": "blockdev-insert-medium",
-#      "arguments": { "id": "ide0-1-0",
-#                     "node-name": "node0" } }
-#
-# <- { "return": {} }
-#
-##
-{ 'command': 'blockdev-insert-medium',
-  'data': { 'id': 'str',
-            'node-name': 'str'} }
-
-
-##
-# @BlockdevChangeReadOnlyMode:
-#
-# Specifies the new read-only mode of a block device subject to the
-# @blockdev-change-medium command.
-#
-# @retain: Retains the current read-only mode
-#
-# @read-only: Makes the device read-only
-#
-# @read-write: Makes the device writable
-#
-# Since: 2.3
-#
-##
-{ 'enum': 'BlockdevChangeReadOnlyMode',
-  'data': ['retain', 'read-only', 'read-write'] }
-
-
-##
-# @blockdev-change-medium:
-#
-# Changes the medium inserted into a block device by ejecting the current =
medium
-# and loading a new image file which is inserted as the new medium (this c=
ommand
-# combines blockdev-open-tray, blockdev-remove-medium, blockdev-insert-med=
ium
-# and blockdev-close-tray).
-#
-# @device: Block device name (deprecated, use @id instead)
-#
-# @id: The name or QOM path of the guest device
-#      (since: 2.8)
-#
-# @filename: filename of the new image to be loaded
-#
-# @format: format to open the new image with (defaults to
-#          the probed format)
-#
-# @read-only-mode: change the read-only mode of the device; defaults
-#                  to 'retain'
-#
-# Since: 2.5
-#
-# Examples:
-#
-# 1. Change a removable medium
-#
-# -> { "execute": "blockdev-change-medium",
-#      "arguments": { "id": "ide0-1-0",
-#                     "filename": "/srv/images/Fedora-12-x86_64-DVD.iso",
-#                     "format": "raw" } }
-# <- { "return": {} }
-#
-# 2. Load a read-only medium into a writable drive
-#
-# -> { "execute": "blockdev-change-medium",
-#      "arguments": { "id": "floppyA",
-#                     "filename": "/srv/images/ro.img",
-#                     "format": "raw",
-#                     "read-only-mode": "retain" } }
-#
-# <- { "error":
-#      { "class": "GenericError",
-#        "desc": "Could not open '/srv/images/ro.img': Permission denied" =
} }
-#
-# -> { "execute": "blockdev-change-medium",
-#      "arguments": { "id": "floppyA",
-#                     "filename": "/srv/images/ro.img",
-#                     "format": "raw",
-#                     "read-only-mode": "read-only" } }
-#
-# <- { "return": {} }
-#
-##
-{ 'command': 'blockdev-change-medium',
-  'data': { '*device': 'str',
-            '*id': 'str',
-            'filename': 'str',
-            '*format': 'str',
-            '*read-only-mode': 'BlockdevChangeReadOnlyMode' } }
-
-
 ##
 # @BlockErrorAction:
 #
diff --git a/qapi/block.json b/qapi/block.json
index d2f3fc01ed..97bf52b7c7 100644
--- a/qapi/block.json
+++ b/qapi/block.json
@@ -115,6 +115,248 @@
             '*id': 'str',
             '*force': 'bool' } }
=20
+##
+# @blockdev-open-tray:
+#
+# Opens a block device's tray. If there is a block driver state tree inser=
ted as
+# a medium, it will become inaccessible to the guest (but it will remain
+# associated to the block device, so closing the tray will make it accessi=
ble
+# again).
+#
+# If the tray was already open before, this will be a no-op.
+#
+# Once the tray opens, a DEVICE_TRAY_MOVED event is emitted. There are cas=
es in
+# which no such event will be generated, these include:
+#
+# - if the guest has locked the tray, @force is false and the guest does n=
ot
+#   respond to the eject request
+# - if the BlockBackend denoted by @device does not have a guest device at=
tached
+#   to it
+# - if the guest device does not have an actual tray
+#
+# @device: Block device name (deprecated, use @id instead)
+#
+# @id: The name or QOM path of the guest device (since: 2.8)
+#
+# @force: if false (the default), an eject request will be sent to
+#         the guest if it has locked the tray (and the tray will not be op=
ened
+#         immediately); if true, the tray will be opened regardless of whe=
ther
+#         it is locked
+#
+# Since: 2.5
+#
+# Example:
+#
+# -> { "execute": "blockdev-open-tray",
+#      "arguments": { "id": "ide0-1-0" } }
+#
+# <- { "timestamp": { "seconds": 1418751016,
+#                     "microseconds": 716996 },
+#      "event": "DEVICE_TRAY_MOVED",
+#      "data": { "device": "ide1-cd0",
+#                "id": "ide0-1-0",
+#                "tray-open": true } }
+#
+# <- { "return": {} }
+#
+##
+{ 'command': 'blockdev-open-tray',
+  'data': { '*device': 'str',
+            '*id': 'str',
+            '*force': 'bool' } }
+
+##
+# @blockdev-close-tray:
+#
+# Closes a block device's tray. If there is a block driver state tree asso=
ciated
+# with the block device (which is currently ejected), that tree will be lo=
aded
+# as the medium.
+#
+# If the tray was already closed before, this will be a no-op.
+#
+# @device: Block device name (deprecated, use @id instead)
+#
+# @id: The name or QOM path of the guest device (since: 2.8)
+#
+# Since: 2.5
+#
+# Example:
+#
+# -> { "execute": "blockdev-close-tray",
+#      "arguments": { "id": "ide0-1-0" } }
+#
+# <- { "timestamp": { "seconds": 1418751345,
+#                     "microseconds": 272147 },
+#      "event": "DEVICE_TRAY_MOVED",
+#      "data": { "device": "ide1-cd0",
+#                "id": "ide0-1-0",
+#                "tray-open": false } }
+#
+# <- { "return": {} }
+#
+##
+{ 'command': 'blockdev-close-tray',
+  'data': { '*device': 'str',
+            '*id': 'str' } }
+
+##
+# @blockdev-remove-medium:
+#
+# Removes a medium (a block driver state tree) from a block device. That b=
lock
+# device's tray must currently be open (unless there is no attached guest
+# device).
+#
+# If the tray is open and there is no medium inserted, this will be a no-o=
p.
+#
+# @id: The name or QOM path of the guest device
+#
+# Since: 2.12
+#
+# Example:
+#
+# -> { "execute": "blockdev-remove-medium",
+#      "arguments": { "id": "ide0-1-0" } }
+#
+# <- { "error": { "class": "GenericError",
+#                 "desc": "Tray of device 'ide0-1-0' is not open" } }
+#
+# -> { "execute": "blockdev-open-tray",
+#      "arguments": { "id": "ide0-1-0" } }
+#
+# <- { "timestamp": { "seconds": 1418751627,
+#                     "microseconds": 549958 },
+#      "event": "DEVICE_TRAY_MOVED",
+#      "data": { "device": "ide1-cd0",
+#                "id": "ide0-1-0",
+#                "tray-open": true } }
+#
+# <- { "return": {} }
+#
+# -> { "execute": "blockdev-remove-medium",
+#      "arguments": { "id": "ide0-1-0" } }
+#
+# <- { "return": {} }
+#
+##
+{ 'command': 'blockdev-remove-medium',
+  'data': { 'id': 'str' } }
+
+##
+# @blockdev-insert-medium:
+#
+# Inserts a medium (a block driver state tree) into a block device. That b=
lock
+# device's tray must currently be open (unless there is no attached guest
+# device) and there must be no medium inserted already.
+#
+# @id: The name or QOM path of the guest device
+#
+# @node-name: name of a node in the block driver state graph
+#
+# Since: 2.12
+#
+# Example:
+#
+# -> { "execute": "blockdev-add",
+#      "arguments": {
+#          "node-name": "node0",
+#          "driver": "raw",
+#          "file": { "driver": "file",
+#                    "filename": "fedora.iso" } } }
+# <- { "return": {} }
+#
+# -> { "execute": "blockdev-insert-medium",
+#      "arguments": { "id": "ide0-1-0",
+#                     "node-name": "node0" } }
+#
+# <- { "return": {} }
+#
+##
+{ 'command': 'blockdev-insert-medium',
+  'data': { 'id': 'str',
+            'node-name': 'str'} }
+
+
+##
+# @BlockdevChangeReadOnlyMode:
+#
+# Specifies the new read-only mode of a block device subject to the
+# @blockdev-change-medium command.
+#
+# @retain: Retains the current read-only mode
+#
+# @read-only: Makes the device read-only
+#
+# @read-write: Makes the device writable
+#
+# Since: 2.3
+#
+##
+{ 'enum': 'BlockdevChangeReadOnlyMode',
+  'data': ['retain', 'read-only', 'read-write'] }
+
+
+##
+# @blockdev-change-medium:
+#
+# Changes the medium inserted into a block device by ejecting the current =
medium
+# and loading a new image file which is inserted as the new medium (this c=
ommand
+# combines blockdev-open-tray, blockdev-remove-medium, blockdev-insert-med=
ium
+# and blockdev-close-tray).
+#
+# @device: Block device name (deprecated, use @id instead)
+#
+# @id: The name or QOM path of the guest device
+#      (since: 2.8)
+#
+# @filename: filename of the new image to be loaded
+#
+# @format: format to open the new image with (defaults to
+#          the probed format)
+#
+# @read-only-mode: change the read-only mode of the device; defaults
+#                  to 'retain'
+#
+# Since: 2.5
+#
+# Examples:
+#
+# 1. Change a removable medium
+#
+# -> { "execute": "blockdev-change-medium",
+#      "arguments": { "id": "ide0-1-0",
+#                     "filename": "/srv/images/Fedora-12-x86_64-DVD.iso",
+#                     "format": "raw" } }
+# <- { "return": {} }
+#
+# 2. Load a read-only medium into a writable drive
+#
+# -> { "execute": "blockdev-change-medium",
+#      "arguments": { "id": "floppyA",
+#                     "filename": "/srv/images/ro.img",
+#                     "format": "raw",
+#                     "read-only-mode": "retain" } }
+#
+# <- { "error":
+#      { "class": "GenericError",
+#        "desc": "Could not open '/srv/images/ro.img': Permission denied" =
} }
+#
+# -> { "execute": "blockdev-change-medium",
+#      "arguments": { "id": "floppyA",
+#                     "filename": "/srv/images/ro.img",
+#                     "format": "raw",
+#                     "read-only-mode": "read-only" } }
+#
+# <- { "return": {} }
+#
+##
+{ 'command': 'blockdev-change-medium',
+  'data': { '*device': 'str',
+            '*id': 'str',
+            'filename': 'str',
+            '*format': 'str',
+            '*read-only-mode': 'BlockdevChangeReadOnlyMode' } }
+
+
 ##
 # @DEVICE_TRAY_MOVED:
 #
@@ -167,3 +409,147 @@
 ##
 { 'event': 'PR_MANAGER_STATUS_CHANGED',
   'data': { 'id': 'str', 'connected': 'bool' } }
+
+##
+# @block_set_io_throttle:
+#
+# Change I/O throttle limits for a block drive.
+#
+# Since QEMU 2.4, each device with I/O limits is member of a throttle
+# group.
+#
+# If two or more devices are members of the same group, the limits
+# will apply to the combined I/O of the whole group in a round-robin
+# fashion. Therefore, setting new I/O limits to a device will affect
+# the whole group.
+#
+# The name of the group can be specified using the 'group' parameter.
+# If the parameter is unset, it is assumed to be the current group of
+# that device. If it's not in any group yet, the name of the device
+# will be used as the name for its group.
+#
+# The 'group' parameter can also be used to move a device to a
+# different group. In this case the limits specified in the parameters
+# will be applied to the new group only.
+#
+# I/O limits can be disabled by setting all of them to 0. In this case
+# the device will be removed from its group and the rest of its
+# members will not be affected. The 'group' parameter is ignored.
+#
+# Returns: - Nothing on success
+#          - If @device is not a valid block device, DeviceNotFound
+#
+# Since: 1.1
+#
+# Example:
+#
+# -> { "execute": "block_set_io_throttle",
+#      "arguments": { "id": "virtio-blk-pci0/virtio-backend",
+#                     "bps": 0,
+#                     "bps_rd": 0,
+#                     "bps_wr": 0,
+#                     "iops": 512,
+#                     "iops_rd": 0,
+#                     "iops_wr": 0,
+#                     "bps_max": 0,
+#                     "bps_rd_max": 0,
+#                     "bps_wr_max": 0,
+#                     "iops_max": 0,
+#                     "iops_rd_max": 0,
+#                     "iops_wr_max": 0,
+#                     "bps_max_length": 0,
+#                     "iops_size": 0 } }
+# <- { "return": {} }
+#
+# -> { "execute": "block_set_io_throttle",
+#      "arguments": { "id": "ide0-1-0",
+#                     "bps": 1000000,
+#                     "bps_rd": 0,
+#                     "bps_wr": 0,
+#                     "iops": 0,
+#                     "iops_rd": 0,
+#                     "iops_wr": 0,
+#                     "bps_max": 8000000,
+#                     "bps_rd_max": 0,
+#                     "bps_wr_max": 0,
+#                     "iops_max": 0,
+#                     "iops_rd_max": 0,
+#                     "iops_wr_max": 0,
+#                     "bps_max_length": 60,
+#                     "iops_size": 0 } }
+# <- { "return": {} }
+##
+{ 'command': 'block_set_io_throttle', 'boxed': true,
+  'data': 'BlockIOThrottle' }
+
+##
+# @block-latency-histogram-set:
+#
+# Manage read, write and flush latency histograms for the device.
+#
+# If only @id parameter is specified, remove all present latency histogram=
s
+# for the device. Otherwise, add/reset some of (or all) latency histograms=
.
+#
+# @id: The name or QOM path of the guest device.
+#
+# @boundaries: list of interval boundary values (see description in
+#              BlockLatencyHistogramInfo definition). If specified, all
+#              latency histograms are removed, and empty ones created for =
all
+#              io types with intervals corresponding to @boundaries (excep=
t for
+#              io types, for which specific boundaries are set through the
+#              following parameters).
+#
+# @boundaries-read: list of interval boundary values for read latency
+#                   histogram. If specified, old read latency histogram is
+#                   removed, and empty one created with intervals
+#                   corresponding to @boundaries-read. The parameter has h=
igher
+#                   priority then @boundaries.
+#
+# @boundaries-write: list of interval boundary values for write latency
+#                    histogram.
+#
+# @boundaries-flush: list of interval boundary values for flush latency
+#                    histogram.
+#
+# Returns: error if device is not found or any boundary arrays are invalid=
.
+#
+# Since: 4.0
+#
+# Example: set new histograms for all io types with intervals
+# [0, 10), [10, 50), [50, 100), [100, +inf):
+#
+# -> { "execute": "block-latency-histogram-set",
+#      "arguments": { "id": "drive0",
+#                     "boundaries": [10, 50, 100] } }
+# <- { "return": {} }
+#
+# Example: set new histogram only for write, other histograms will remain
+# not changed (or not created):
+#
+# -> { "execute": "block-latency-histogram-set",
+#      "arguments": { "id": "drive0",
+#                     "boundaries-write": [10, 50, 100] } }
+# <- { "return": {} }
+#
+# Example: set new histograms with the following intervals:
+#   read, flush: [0, 10), [10, 50), [50, 100), [100, +inf)
+#   write: [0, 1000), [1000, 5000), [5000, +inf)
+#
+# -> { "execute": "block-latency-histogram-set",
+#      "arguments": { "id": "drive0",
+#                     "boundaries": [10, 50, 100],
+#                     "boundaries-write": [1000, 5000] } }
+# <- { "return": {} }
+#
+# Example: remove all latency histograms:
+#
+# -> { "execute": "block-latency-histogram-set",
+#      "arguments": { "id": "drive0" } }
+# <- { "return": {} }
+##
+{ 'command': 'block-latency-histogram-set',
+  'data': {'id': 'str',
+           '*boundaries': ['uint64'],
+           '*boundaries-read': ['uint64'],
+           '*boundaries-write': ['uint64'],
+           '*boundaries-flush': ['uint64'] } }
diff --git a/monitor/qmp-cmds.c b/monitor/qmp-cmds.c
index da7083087e..864cbfa32e 100644
--- a/monitor/qmp-cmds.c
+++ b/monitor/qmp-cmds.c
@@ -30,7 +30,7 @@
 #include "sysemu/blockdev.h"
 #include "sysemu/block-backend.h"
 #include "qapi/error.h"
-#include "qapi/qapi-commands-block-core.h"
+#include "qapi/qapi-commands-block.h"
 #include "qapi/qapi-commands-control.h"
 #include "qapi/qapi-commands-machine.h"
 #include "qapi/qapi-commands-misc.h"
--=20
2.20.1


