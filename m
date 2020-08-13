Return-Path: <SRS0=egLd=BX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6CD0C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2020 16:33:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6002F206A4
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2020 16:33:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AHpDSddj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6002F206A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54512 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k6GA7-0006vj-Dt
	for qemu-devel@archiver.kernel.org; Thu, 13 Aug 2020 12:33:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55270)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1k6G71-0001d8-N0
 for qemu-devel@nongnu.org; Thu, 13 Aug 2020 12:29:55 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:51439
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1k6G6z-0001C9-13
 for qemu-devel@nongnu.org; Thu, 13 Aug 2020 12:29:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597336192;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ndPcjpwoAM/JzDAfgWy554SdcHxBbhEn5xoFA7I7uZ4=;
 b=AHpDSddj5cEmCegwLfDuKj08+Pz7E4zstO8SHOC7pDc1Bo9pDvipmHHPetf5Sde2VC+G2F
 g/1nyx5WvJlTRrQ9L4DOZHI2baZ18Zih+jDElKEzTvvBNQqEnXZIWjsKE70N3kFkn62/zl
 2/5dzyL3zmt8TUgqYGATYR2UtWv/7AY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-282-CGTSaX2SNvWmZVsnQwSBaw-1; Thu, 13 Aug 2020 12:29:50 -0400
X-MC-Unique: CGTSaX2SNvWmZVsnQwSBaw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 972531835865;
 Thu, 13 Aug 2020 16:29:49 +0000 (UTC)
Received: from linux.fritz.box.com (ovpn-113-97.ams2.redhat.com [10.36.113.97])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7511F5C1A3;
 Thu, 13 Aug 2020 16:29:48 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Subject: [RFC PATCH 02/22] qapi: Create block-export module
Date: Thu, 13 Aug 2020 18:29:15 +0200
Message-Id: <20200813162935.210070-3-kwolf@redhat.com>
In-Reply-To: <20200813162935.210070-1-kwolf@redhat.com>
References: <20200813162935.210070-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=kwolf@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/13 12:29:49
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: kwolf@redhat.com, qemu-devel@nongnu.org, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Move all block export related types and commands from block-core to the
new QAPI module block-export.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 qapi/block-core.json                 | 166 --------------------------
 qapi/block-export.json               | 172 +++++++++++++++++++++++++++
 qapi/qapi-schema.json                |   1 +
 include/block/nbd.h                  |   2 +-
 block/monitor/block-hmp-cmds.c       |   1 +
 blockdev-nbd.c                       |   2 +-
 qemu-storage-daemon.c                |   2 +-
 qapi/Makefile.objs                   |   5 +-
 storage-daemon/qapi/qapi-schema.json |   1 +
 9 files changed, 181 insertions(+), 171 deletions(-)
 create mode 100644 qapi/block-export.json

diff --git a/qapi/block-core.json b/qapi/block-core.json
index ab7bf3c612..5c491d4cbd 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -5176,172 +5176,6 @@
              'iothread': 'StrOrNull',
              '*force': 'bool' } }
 
-##
-# @NbdServerOptions:
-#
-# @addr: Address on which to listen.
-# @tls-creds: ID of the TLS credentials object (since 2.6).
-# @tls-authz: ID of the QAuthZ authorization object used to validate
-#             the client's x509 distinguished name. This object is
-#             is only resolved at time of use, so can be deleted and
-#             recreated on the fly while the NBD server is active.
-#             If missing, it will default to denying access (since 4.0).
-#
-# Keep this type consistent with the nbd-server-start arguments. The only
-# intended difference is using SocketAddress instead of SocketAddressLegacy.
-#
-# Since: 4.2
-##
-{ 'struct': 'NbdServerOptions',
-  'data': { 'addr': 'SocketAddress',
-            '*tls-creds': 'str',
-            '*tls-authz': 'str'} }
-
-##
-# @nbd-server-start:
-#
-# Start an NBD server listening on the given host and port.  Block
-# devices can then be exported using @nbd-server-add.  The NBD
-# server will present them as named exports; for example, another
-# QEMU instance could refer to them as "nbd:HOST:PORT:exportname=NAME".
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
-# Keep this type consistent with the NbdServerOptions type. The only intended
-# difference is using SocketAddressLegacy instead of SocketAddress.
-#
-# Since: 1.3.0
-##
-{ 'command': 'nbd-server-start',
-  'data': { 'addr': 'SocketAddressLegacy',
-            '*tls-creds': 'str',
-            '*tls-authz': 'str'} }
-
-##
-# @BlockExportNbd:
-#
-# An NBD block export.
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
-# Since: 5.0
-##
-{ 'struct': 'BlockExportNbd',
-  'data': {'device': 'str', '*name': 'str', '*description': 'str',
-           '*writable': 'bool', '*bitmap': 'str' } }
-
-##
-# @nbd-server-add:
-#
-# Export a block node to QEMU's embedded NBD server.
-#
-# Returns: error if the server is not running, or export with the same name
-#          already exists.
-#
-# Since: 1.3.0
-##
-{ 'command': 'nbd-server-add',
-  'data': 'BlockExportNbd', 'boxed': true }
-
-##
-# @NbdServerRemoveMode:
-#
-# Mode for removing an NBD export.
-#
-# @safe: Remove export if there are no existing connections, fail otherwise.
-#
-# @hard: Drop all connections immediately and remove export.
-#
-# Potential additional modes to be added in the future:
-#
-# hide: Just hide export from new clients, leave existing connections as is.
-# Remove export after all clients are disconnected.
-#
-# soft: Hide export from new clients, answer with ESHUTDOWN for all further
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
-##
-# @BlockExportType:
-#
-# An enumeration of block export types
-#
-# @nbd: NBD export
-#
-# Since: 4.2
-##
-{ 'enum': 'BlockExportType',
-  'data': [ 'nbd' ] }
-
-##
-# @BlockExport:
-#
-# Describes a block export, i.e. how single node should be exported on an
-# external interface.
-#
-# Since: 4.2
-##
-{ 'union': 'BlockExport',
-  'base': { 'type': 'BlockExportType' },
-  'discriminator': 'type',
-  'data': {
-      'nbd': 'BlockExportNbd'
-   } }
-
 ##
 # @QuorumOpType:
 #
diff --git a/qapi/block-export.json b/qapi/block-export.json
new file mode 100644
index 0000000000..62f4938e83
--- /dev/null
+++ b/qapi/block-export.json
@@ -0,0 +1,172 @@
+##
+# == Block device exports
+##
+
+{ 'include': 'sockets.json' }
+
+##
+# @NbdServerOptions:
+#
+# @addr: Address on which to listen.
+# @tls-creds: ID of the TLS credentials object (since 2.6).
+# @tls-authz: ID of the QAuthZ authorization object used to validate
+#             the client's x509 distinguished name. This object is
+#             is only resolved at time of use, so can be deleted and
+#             recreated on the fly while the NBD server is active.
+#             If missing, it will default to denying access (since 4.0).
+#
+# Keep this type consistent with the nbd-server-start arguments. The only
+# intended difference is using SocketAddress instead of SocketAddressLegacy.
+#
+# Since: 4.2
+##
+{ 'struct': 'NbdServerOptions',
+  'data': { 'addr': 'SocketAddress',
+            '*tls-creds': 'str',
+            '*tls-authz': 'str'} }
+
+##
+# @nbd-server-start:
+#
+# Start an NBD server listening on the given host and port.  Block
+# devices can then be exported using @nbd-server-add.  The NBD
+# server will present them as named exports; for example, another
+# QEMU instance could refer to them as "nbd:HOST:PORT:exportname=NAME".
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
+# Keep this type consistent with the NbdServerOptions type. The only intended
+# difference is using SocketAddressLegacy instead of SocketAddress.
+#
+# Since: 1.3.0
+##
+{ 'command': 'nbd-server-start',
+  'data': { 'addr': 'SocketAddressLegacy',
+            '*tls-creds': 'str',
+            '*tls-authz': 'str'} }
+
+##
+# @BlockExportNbd:
+#
+# An NBD block export.
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
+# Since: 5.0
+##
+{ 'struct': 'BlockExportNbd',
+  'data': {'device': 'str', '*name': 'str', '*description': 'str',
+           '*writable': 'bool', '*bitmap': 'str' } }
+
+##
+# @nbd-server-add:
+#
+# Export a block node to QEMU's embedded NBD server.
+#
+# Returns: error if the server is not running, or export with the same name
+#          already exists.
+#
+# Since: 1.3.0
+##
+{ 'command': 'nbd-server-add',
+  'data': 'BlockExportNbd', 'boxed': true }
+
+##
+# @NbdServerRemoveMode:
+#
+# Mode for removing an NBD export.
+#
+# @safe: Remove export if there are no existing connections, fail otherwise.
+#
+# @hard: Drop all connections immediately and remove export.
+#
+# Potential additional modes to be added in the future:
+#
+# hide: Just hide export from new clients, leave existing connections as is.
+# Remove export after all clients are disconnected.
+#
+# soft: Hide export from new clients, answer with ESHUTDOWN for all further
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
+# @BlockExportType:
+#
+# An enumeration of block export types
+#
+# @nbd: NBD export
+#
+# Since: 4.2
+##
+{ 'enum': 'BlockExportType',
+  'data': [ 'nbd' ] }
+
+##
+# @BlockExport:
+#
+# Describes a block export, i.e. how single node should be exported on an
+# external interface.
+#
+# Since: 4.2
+##
+{ 'union': 'BlockExport',
+  'base': { 'type': 'BlockExportType' },
+  'discriminator': 'type',
+  'data': {
+      'nbd': 'BlockExportNbd'
+   } }
+
diff --git a/qapi/qapi-schema.json b/qapi/qapi-schema.json
index 43b0ba0dea..2b37f6eb88 100644
--- a/qapi/qapi-schema.json
+++ b/qapi/qapi-schema.json
@@ -63,6 +63,7 @@
 { 'include': 'run-state.json' }
 { 'include': 'crypto.json' }
 { 'include': 'block.json' }
+{ 'include': 'block-export.json' }
 { 'include': 'char.json' }
 { 'include': 'dump.json' }
 { 'include': 'job.json' }
diff --git a/include/block/nbd.h b/include/block/nbd.h
index 0451683d03..262f6da2ce 100644
--- a/include/block/nbd.h
+++ b/include/block/nbd.h
@@ -20,7 +20,7 @@
 #ifndef NBD_H
 #define NBD_H
 
-#include "qapi/qapi-types-block.h"
+#include "qapi/qapi-types-block-export.h"
 #include "io/channel-socket.h"
 #include "crypto/tlscreds.h"
 #include "qapi/error.h"
diff --git a/block/monitor/block-hmp-cmds.c b/block/monitor/block-hmp-cmds.c
index 4c8c375172..fb9d87ee89 100644
--- a/block/monitor/block-hmp-cmds.c
+++ b/block/monitor/block-hmp-cmds.c
@@ -40,6 +40,7 @@
 #include "sysemu/block-backend.h"
 #include "sysemu/blockdev.h"
 #include "qapi/qapi-commands-block.h"
+#include "qapi/qapi-commands-block-export.h"
 #include "qapi/qmp/qdict.h"
 #include "qapi/error.h"
 #include "qapi/qmp/qerror.h"
diff --git a/blockdev-nbd.c b/blockdev-nbd.c
index 1a95d89f00..0f6b80c58f 100644
--- a/blockdev-nbd.c
+++ b/blockdev-nbd.c
@@ -14,7 +14,7 @@
 #include "sysemu/block-backend.h"
 #include "hw/block/block.h"
 #include "qapi/error.h"
-#include "qapi/qapi-commands-block.h"
+#include "qapi/qapi-commands-block-export.h"
 #include "block/nbd.h"
 #include "io/channel-socket.h"
 #include "io/net-listener.h"
diff --git a/qemu-storage-daemon.c b/qemu-storage-daemon.c
index 7e9b0e0d3f..ed9d2afcf3 100644
--- a/qemu-storage-daemon.c
+++ b/qemu-storage-daemon.c
@@ -35,8 +35,8 @@
 #include "monitor/monitor-internal.h"
 
 #include "qapi/error.h"
-#include "qapi/qapi-visit-block.h"
 #include "qapi/qapi-visit-block-core.h"
+#include "qapi/qapi-visit-block-export.h"
 #include "qapi/qapi-visit-control.h"
 #include "qapi/qmp/qdict.h"
 #include "qapi/qmp/qstring.h"
diff --git a/qapi/Makefile.objs b/qapi/Makefile.objs
index 4673ab7490..c5093b4d61 100644
--- a/qapi/Makefile.objs
+++ b/qapi/Makefile.objs
@@ -5,7 +5,8 @@ util-obj-y += opts-visitor.o qapi-clone-visitor.o
 util-obj-y += qmp-event.o
 util-obj-y += qapi-util.o
 
-QAPI_COMMON_MODULES = audio authz block-core block char common control crypto
+QAPI_COMMON_MODULES = audio authz block-core block-export block char common
+QAPI_COMMON_MODULES += control crypto
 QAPI_COMMON_MODULES += dump error introspect job machine migration misc
 QAPI_COMMON_MODULES += net pragma qdev qom rdma rocker run-state sockets tpm
 QAPI_COMMON_MODULES += trace transaction ui
@@ -32,7 +33,7 @@ obj-y += $(QAPI_TARGET_MODULES:%=qapi-commands-%.o)
 obj-y += qapi-commands.o
 obj-y += qapi-init-commands.o
 
-QAPI_MODULES_STORAGE_DAEMON = block-core char common control crypto
+QAPI_MODULES_STORAGE_DAEMON = block-core block-export char common control crypto
 QAPI_MODULES_STORAGE_DAEMON += introspect job qom sockets pragma transaction
 
 storage-daemon-obj-y += $(QAPI_MODULES_STORAGE_DAEMON:%=qapi-commands-%.o)
diff --git a/storage-daemon/qapi/qapi-schema.json b/storage-daemon/qapi/qapi-schema.json
index 14f4f8fe61..9c7133724a 100644
--- a/storage-daemon/qapi/qapi-schema.json
+++ b/storage-daemon/qapi/qapi-schema.json
@@ -15,6 +15,7 @@
 { 'include': '../../qapi/pragma.json' }
 
 { 'include': '../../qapi/block-core.json' }
+{ 'include': '../../qapi/block-export.json' }
 { 'include': '../../qapi/char.json' }
 { 'include': '../../qapi/common.json' }
 { 'include': '../../qapi/control.json' }
-- 
2.25.4


