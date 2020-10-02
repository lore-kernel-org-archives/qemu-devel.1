Return-Path: <SRS0=fJPX=DJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4699AC47428
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2020 14:49:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BE4EB208C7
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2020 14:49:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hrvI6uw8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE4EB208C7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44106 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kOMNf-0000qU-RR
	for qemu-devel@archiver.kernel.org; Fri, 02 Oct 2020 10:49:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34436)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1kOMI7-0001GM-0Y
 for qemu-devel@nongnu.org; Fri, 02 Oct 2020 10:44:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:59458)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1kOMI2-0004Vp-7g
 for qemu-devel@nongnu.org; Fri, 02 Oct 2020 10:44:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601649843;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qOLmxd9Ii3OcUSp51x9F8U6awMzrSfYzNCZ4u4kOzBY=;
 b=hrvI6uw8FepYKVQnuviRUdrGAmi3Z1oUTYIWud89+mZiP0R89GYoZ6lCcO/feY7WOSdWzb
 Gg/jPW9Zm0gDvFXVrO9atKgd6kA8xHDAdSTKKhH3/KNXM7o/O9Y4RNbjc4NeR0phJ90FR9
 8g6I6X3Jt2+IiIKsGM/EmDRxzuMNpHk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-574-YP1LBixsMryDvjTvtUu3Vg-1; Fri, 02 Oct 2020 10:43:59 -0400
X-MC-Unique: YP1LBixsMryDvjTvtUu3Vg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B2A0E80B727;
 Fri,  2 Oct 2020 14:43:58 +0000 (UTC)
Received: from linux.fritz.box.com (ovpn-112-139.ams2.redhat.com
 [10.36.112.139])
 by smtp.corp.redhat.com (Postfix) with ESMTP id BC47C5D9D3;
 Fri,  2 Oct 2020 14:43:57 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Subject: [PULL 06/37] qapi: Create block-export module
Date: Fri,  2 Oct 2020 16:43:14 +0200
Message-Id: <20201002144345.253865-7-kwolf@redhat.com>
In-Reply-To: <20201002144345.253865-1-kwolf@redhat.com>
References: <20201002144345.253865-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=kwolf@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=63.128.21.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/01 23:37:29
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: kwolf@redhat.com, peter.maydell@linaro.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Move all block export related types and commands from block-core to the
new QAPI module block-export.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Message-Id: <20200924152717.287415-3-kwolf@redhat.com>
Acked-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 qapi/block-core.json                 | 166 -------------------------
 qapi/block-export.json               | 174 +++++++++++++++++++++++++++
 qapi/qapi-schema.json                |   1 +
 include/block/nbd.h                  |   2 +-
 block/monitor/block-hmp-cmds.c       |   1 +
 blockdev-nbd.c                       |   2 +-
 storage-daemon/qemu-storage-daemon.c |   2 +-
 qapi/meson.build                     |   4 +-
 storage-daemon/qapi/qapi-schema.json |   1 +
 9 files changed, 183 insertions(+), 170 deletions(-)
 create mode 100644 qapi/block-export.json

diff --git a/qapi/block-core.json b/qapi/block-core.json
index 86ed72ef9f..12a24772b5 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -5194,172 +5194,6 @@
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
-# Keep this type consistent with the NbdServerOptions type. The only intended
-# difference is using SocketAddressLegacy instead of SocketAddress.
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
index 0000000000..b21b8e3f4d
--- /dev/null
+++ b/qapi/block-export.json
@@ -0,0 +1,174 @@
+# -*- Mode: Python -*-
+# vim: filetype=python
+
+##
+# == Block device exports
+##
+
+{ 'include': 'sockets.json' }
+
+##
+# @NbdServerOptions:
+#
+# Keep this type consistent with the nbd-server-start arguments. The only
+# intended difference is using SocketAddress instead of SocketAddressLegacy.
+#
+# @addr: Address on which to listen.
+# @tls-creds: ID of the TLS credentials object (since 2.6).
+# @tls-authz: ID of the QAuthZ authorization object used to validate
+#             the client's x509 distinguished name. This object is
+#             is only resolved at time of use, so can be deleted and
+#             recreated on the fly while the NBD server is active.
+#             If missing, it will default to denying access (since 4.0).
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
+# Keep this type consistent with the NbdServerOptions type. The only intended
+# difference is using SocketAddressLegacy instead of SocketAddress.
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
diff --git a/qapi/qapi-schema.json b/qapi/qapi-schema.json
index 0c6ca5c000..8d567e1386 100644
--- a/qapi/qapi-schema.json
+++ b/qapi/qapi-schema.json
@@ -66,6 +66,7 @@
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
index 4d3db5ed3c..6ce0f8f87c 100644
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
diff --git a/storage-daemon/qemu-storage-daemon.c b/storage-daemon/qemu-storage-daemon.c
index 7e9b0e0d3f..ed9d2afcf3 100644
--- a/storage-daemon/qemu-storage-daemon.c
+++ b/storage-daemon/qemu-storage-daemon.c
@@ -35,8 +35,8 @@
 #include "monitor/monitor-internal.h"
 
 #include "qapi/error.h"
-#include "qapi/qapi-visit-block.h"
 #include "qapi/qapi-visit-block-core.h"
+#include "qapi/qapi-visit-block-export.h"
 #include "qapi/qapi-visit-control.h"
 #include "qapi/qmp/qdict.h"
 #include "qapi/qmp/qstring.h"
diff --git a/qapi/meson.build b/qapi/meson.build
index 7c4a89a882..ea359a0148 100644
--- a/qapi/meson.build
+++ b/qapi/meson.build
@@ -17,8 +17,9 @@ qapi_all_modules = [
   'acpi',
   'audio',
   'authz',
-  'block-core',
   'block',
+  'block-core',
+  'block-export',
   'char',
   'common',
   'control',
@@ -49,6 +50,7 @@ qapi_all_modules = [
 
 qapi_storage_daemon_modules = [
   'block-core',
+  'block-export',
   'char',
   'common',
   'control',
diff --git a/storage-daemon/qapi/qapi-schema.json b/storage-daemon/qapi/qapi-schema.json
index 6100d1f0c9..c6ad5ae1e3 100644
--- a/storage-daemon/qapi/qapi-schema.json
+++ b/storage-daemon/qapi/qapi-schema.json
@@ -16,6 +16,7 @@
 { 'include': '../../qapi/pragma.json' }
 
 { 'include': '../../qapi/block-core.json' }
+{ 'include': '../../qapi/block-export.json' }
 { 'include': '../../qapi/char.json' }
 { 'include': '../../qapi/common.json' }
 { 'include': '../../qapi/control.json' }
-- 
2.25.4


