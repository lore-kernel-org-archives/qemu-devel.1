Return-Path: <SRS0=T5iq=DQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BF6CC433DF
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2020 21:57:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D73E521D6C
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2020 21:57:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KBRAQU3I"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D73E521D6C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47514 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kR0OM-0004XH-RX
	for qemu-devel@archiver.kernel.org; Fri, 09 Oct 2020 17:57:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50186)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1kR0Mg-0002mF-8N
 for qemu-devel@nongnu.org; Fri, 09 Oct 2020 17:55:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:57248)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1kR0Mb-0003Pu-F5
 for qemu-devel@nongnu.org; Fri, 09 Oct 2020 17:55:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602280544;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xtFbqdgu+FQB9WCHd4+3K/4zhYR7dn02KYNBDh4lN2o=;
 b=KBRAQU3I8IiYsRh+msOJ+VYloU4bW+dLJabJ142az72gW0HZenly4A1VuVsOWzMpbKt65A
 ixjfhjD1tcsrnptEKVx5Ph1KPHb6ufScS3rkGS6EcfFnDJKh/gC4Ll5/SE/V7gEh0C8nVs
 wuWLIb5m1Hx7OZSIByTZIBDEZbm3O0k=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-407-3bEi9PndMlWF4IFkP5pzsw-1; Fri, 09 Oct 2020 17:55:42 -0400
X-MC-Unique: 3bEi9PndMlWF4IFkP5pzsw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 548B21074643;
 Fri,  9 Oct 2020 21:55:41 +0000 (UTC)
Received: from blue.redhat.com (ovpn-113-14.phx2.redhat.com [10.3.113.14])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A7C6210013C4;
 Fri,  9 Oct 2020 21:55:40 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 3/7] nbd: Add 'qemu-nbd -A' to expose allocation depth
Date: Fri,  9 Oct 2020 16:55:29 -0500
Message-Id: <20201009215533.1194742-4-eblake@redhat.com>
In-Reply-To: <20201009215533.1194742-1-eblake@redhat.com>
References: <20201009215533.1194742-1-eblake@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=eblake@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=216.205.24.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/09 02:34:37
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: kwolf@redhat.com, vsementsov@virtuozzo.com, qemu-block@nongnu.org,
 rjones@redhat.com, Markus Armbruster <armbru@redhat.com>, stefanha@redhat.com,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Allow the server to expose an additional metacontext to be requested
by savvy clients.  qemu-nbd adds a new option -A to expose the
qemu:allocation-depth metacontext through NBD_CMD_BLOCK_STATUS; this
can also be set via QMP when using block-export-add.

qemu as client can be hacked into viewing this new context by using
the now-misnamed x-dirty-bitmap option when creating an NBD blockdev
(even though our x- naming means we could rename it, I did not think
it worth breaking back-compat of tools that have been using it while
waiting for a better solution).  It is worth noting the decoding of
how such context information will appear in 'qemu-img map
--output=json':

NBD_STATE_DEPTH_UNALLOC => "zero":false, "data":true
NBD_STATE_DEPTH_LOCAL   => "zero":false, "data":false
NBD_STATE_DEPTH_BACKING => "zero":true,  "data":true

libnbd as client is probably a nicer way to get at the information
without having to decipher such hacks in qemu as client. ;)

Signed-off-by: Eric Blake <eblake@redhat.com>
Message-Id: <20200930121105.667049-6-eblake@redhat.com>
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
[eblake: comment tweak suggested by Vladimir]
Signed-off-by: Eric Blake <eblake@redhat.com>
---
 docs/tools/qemu-nbd.rst    |  8 ++++-
 qapi/block-core.json       |  7 ++--
 qapi/block-export.json     | 12 +++++--
 nbd/server.c               |  2 ++
 qemu-nbd.c                 | 26 +++++++++-----
 tests/qemu-iotests/309     | 73 ++++++++++++++++++++++++++++++++++++++
 tests/qemu-iotests/309.out | 22 ++++++++++++
 tests/qemu-iotests/group   |  1 +
 8 files changed, 136 insertions(+), 15 deletions(-)
 create mode 100755 tests/qemu-iotests/309
 create mode 100644 tests/qemu-iotests/309.out

diff --git a/docs/tools/qemu-nbd.rst b/docs/tools/qemu-nbd.rst
index 667861cb22e9..fe41336dc550 100644
--- a/docs/tools/qemu-nbd.rst
+++ b/docs/tools/qemu-nbd.rst
@@ -72,10 +72,16 @@ driver options if ``--image-opts`` is specified.

   Export the disk as read-only.

+.. option:: -A, --allocation-depth
+
+  Expose allocation depth information via the
+  ``qemu:allocation-depth`` metadata context accessible through
+  NBD_OPT_SET_META_CONTEXT.
+
 .. option:: -B, --bitmap=NAME

   If *filename* has a qcow2 persistent bitmap *NAME*, expose
-  that bitmap via the ``qemu:dirty-bitmap:NAME`` context
+  that bitmap via the ``qemu:dirty-bitmap:NAME`` metadata context
   accessible through NBD_OPT_SET_META_CONTEXT.

 .. option:: -s, --snapshot
diff --git a/qapi/block-core.json b/qapi/block-core.json
index ee5ebef7f2ce..b6368f5fd9a1 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -3883,9 +3883,12 @@
 #
 # @tls-creds: TLS credentials ID
 #
-# @x-dirty-bitmap: A "qemu:dirty-bitmap:NAME" string to query in place of
+# @x-dirty-bitmap: A metadata context name such as "qemu:dirty-bitmap:NAME"
+#                  or "qemu:allocation-depth" to query in place of the
 #                  traditional "base:allocation" block status (see
-#                  NBD_OPT_LIST_META_CONTEXT in the NBD protocol) (since 3.0)
+#                  NBD_OPT_LIST_META_CONTEXT in the NBD protocol; and
+#                  yes, naming this option x-context would have made
+#                  more sense) (since 3.0)
 #
 # @reconnect-delay: On an unexpected disconnect, the nbd client tries to
 #                   connect again until succeeding or encountering a serious
diff --git a/qapi/block-export.json b/qapi/block-export.json
index 65804834d905..893d5cde5dfe 100644
--- a/qapi/block-export.json
+++ b/qapi/block-export.json
@@ -75,14 +75,20 @@
 #               (Since 5.0)
 #
 # @bitmap: Also export the dirty bitmap reachable from @device, so the
-#          NBD client can use NBD_OPT_SET_META_CONTEXT with
-#          "qemu:dirty-bitmap:NAME" to inspect the bitmap. (since 4.0)
+#          NBD client can use NBD_OPT_SET_META_CONTEXT with the
+#          metadata context name "qemu:dirty-bitmap:NAME" to inspect the
+#          bitmap. (since 4.0)
+#
+# @allocation-depth: Also export the allocation depth map for @device, so
+#                    the NBD client can use NBD_OPT_SET_META_CONTEXT with
+#                    the metadata context name "qemu:allocation-depth" to
+#                    inspect allocation details. (since 5.2)
 #
 # Since: 5.0
 ##
 { 'struct': 'BlockExportOptionsNbd',
   'data': { '*name': 'str', '*description': 'str',
-            '*bitmap': 'str' } }
+            '*bitmap': 'str', '*allocation-depth': 'bool' } }

 ##
 # @NbdServerAddOptions:
diff --git a/nbd/server.c b/nbd/server.c
index ae6f8a8e5429..30cfe0eee467 100644
--- a/nbd/server.c
+++ b/nbd/server.c
@@ -1597,6 +1597,8 @@ static int nbd_export_create(BlockExport *blk_exp, BlockExportOptions *exp_args,
         assert(strlen(exp->export_bitmap_context) < NBD_MAX_STRING_SIZE);
     }

+    exp->allocation_depth = arg->allocation_depth;
+
     blk_add_aio_context_notifier(blk, blk_aio_attached, blk_aio_detach, exp);

     QTAILQ_INSERT_TAIL(&exports, exp, next);
diff --git a/qemu-nbd.c b/qemu-nbd.c
index bc644a0670b6..847fde435a7f 100644
--- a/qemu-nbd.c
+++ b/qemu-nbd.c
@@ -99,6 +99,7 @@ static void usage(const char *name)
 "\n"
 "Exposing part of the image:\n"
 "  -o, --offset=OFFSET       offset into the image\n"
+"  -A, --allocation-depth    expose the allocation depth\n"
 "  -B, --bitmap=NAME         expose a persistent dirty bitmap\n"
 "\n"
 "General purpose options:\n"
@@ -519,7 +520,7 @@ int main(int argc, char **argv)
     char *device = NULL;
     QemuOpts *sn_opts = NULL;
     const char *sn_id_or_name = NULL;
-    const char *sopt = "hVb:o:p:rsnc:dvk:e:f:tl:x:T:D:B:L";
+    const char *sopt = "hVb:o:p:rsnc:dvk:e:f:tl:x:T:D:AB:L";
     struct option lopt[] = {
         { "help", no_argument, NULL, 'h' },
         { "version", no_argument, NULL, 'V' },
@@ -528,6 +529,7 @@ int main(int argc, char **argv)
         { "socket", required_argument, NULL, 'k' },
         { "offset", required_argument, NULL, 'o' },
         { "read-only", no_argument, NULL, 'r' },
+        { "allocation-depth", no_argument, NULL, 'A' },
         { "bitmap", required_argument, NULL, 'B' },
         { "connect", required_argument, NULL, 'c' },
         { "disconnect", no_argument, NULL, 'd' },
@@ -569,6 +571,7 @@ int main(int argc, char **argv)
     QDict *options = NULL;
     const char *export_name = NULL; /* defaults to "" later for server mode */
     const char *export_description = NULL;
+    bool alloc_depth = false;
     const char *bitmap = NULL;
     const char *tlscredsid = NULL;
     bool imageOpts = false;
@@ -694,6 +697,9 @@ int main(int argc, char **argv)
             readonly = true;
             flags &= ~BDRV_O_RDWR;
             break;
+        case 'A':
+            alloc_depth = true;
+            break;
         case 'B':
             bitmap = optarg;
             break;
@@ -791,8 +797,8 @@ int main(int argc, char **argv)
             exit(EXIT_FAILURE);
         }
         if (export_name || export_description || dev_offset ||
-            device || disconnect || fmt || sn_id_or_name || bitmap ||
-            seen_aio || seen_discard || seen_cache) {
+            device || disconnect || fmt || sn_id_or_name || alloc_depth ||
+            bitmap || seen_aio || seen_discard || seen_cache) {
             error_report("List mode is incompatible with per-device settings");
             exit(EXIT_FAILURE);
         }
@@ -1072,12 +1078,14 @@ int main(int argc, char **argv)
         .has_writable       = true,
         .writable           = !readonly,
         .u.nbd = {
-            .has_name           = true,
-            .name               = g_strdup(export_name),
-            .has_description    = !!export_description,
-            .description        = g_strdup(export_description),
-            .has_bitmap         = !!bitmap,
-            .bitmap             = g_strdup(bitmap),
+            .has_name             = true,
+            .name                 = g_strdup(export_name),
+            .has_description      = !!export_description,
+            .description          = g_strdup(export_description),
+            .has_bitmap           = !!bitmap,
+            .bitmap               = g_strdup(bitmap),
+            .has_allocation_depth = alloc_depth,
+            .allocation_depth     = alloc_depth,
         },
     };
     blk_exp_add(export_opts, &error_fatal);
diff --git a/tests/qemu-iotests/309 b/tests/qemu-iotests/309
new file mode 100755
index 000000000000..b6734794bb68
--- /dev/null
+++ b/tests/qemu-iotests/309
@@ -0,0 +1,73 @@
+#!/usr/bin/env bash
+#
+# Test qemu-nbd -A
+#
+# Copyright (C) 2018-2020 Red Hat, Inc.
+#
+# This program is free software; you can redistribute it and/or modify
+# it under the terms of the GNU General Public License as published by
+# the Free Software Foundation; either version 2 of the License, or
+# (at your option) any later version.
+#
+# This program is distributed in the hope that it will be useful,
+# but WITHOUT ANY WARRANTY; without even the implied warranty of
+# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+# GNU General Public License for more details.
+#
+# You should have received a copy of the GNU General Public License
+# along with this program.  If not, see <http://www.gnu.org/licenses/>.
+#
+
+seq="$(basename $0)"
+echo "QA output created by $seq"
+
+status=1 # failure is the default!
+
+_cleanup()
+{
+    _cleanup_test_img
+    nbd_server_stop
+}
+trap "_cleanup; exit \$status" 0 1 2 3 15
+
+# get standard environment, filters and checks
+. ./common.rc
+. ./common.filter
+. ./common.nbd
+
+_supported_fmt qcow2
+_supported_proto file
+_supported_os Linux
+_require_command QEMU_NBD
+
+echo
+echo "=== Initial image setup ==="
+echo
+
+TEST_IMG="$TEST_IMG.base" _make_test_img 4M
+$QEMU_IO -c 'w 0 2M' -f $IMGFMT "$TEST_IMG.base" | _filter_qemu_io
+_make_test_img -b "$TEST_IMG.base" -F $IMGFMT 4M
+$QEMU_IO -c 'w 1M 2M' -f $IMGFMT "$TEST_IMG" | _filter_qemu_io
+
+echo
+echo "=== Check allocation over NBD ==="
+echo
+
+$QEMU_IMG map --output=json -f qcow2 "$TEST_IMG"
+IMG="driver=nbd,server.type=unix,server.path=$nbd_unix_socket"
+nbd_server_start_unix_socket -r -f qcow2 -A "$TEST_IMG"
+# Normal -f raw NBD block status loses access to allocation information
+$QEMU_IMG map --output=json --image-opts \
+    "$IMG" | _filter_qemu_img_map
+# But since we used -A, and use x-dirty-bitmap as a hack for reading bitmaps,
+# we can reconstruct it, by abusing block status to report:
+#    NBD_STATE_DEPTH_UNALLOC => "zero":false, "data":true
+#    NBD_STATE_DEPTH_LOCAL   => "zero":false, "data":false
+#    NBD_STATE_DEPTH_BACKING => "zero":true,  "data":true
+$QEMU_IMG map --output=json --image-opts \
+    "$IMG,x-dirty-bitmap=qemu:allocation-depth" | _filter_qemu_img_map
+
+# success, all done
+echo '*** done'
+rm -f $seq.full
+status=0
diff --git a/tests/qemu-iotests/309.out b/tests/qemu-iotests/309.out
new file mode 100644
index 000000000000..db75bb6b0df9
--- /dev/null
+++ b/tests/qemu-iotests/309.out
@@ -0,0 +1,22 @@
+QA output created by 309
+
+=== Initial image setup ===
+
+Formatting 'TEST_DIR/t.IMGFMT.base', fmt=IMGFMT size=4194304
+wrote 2097152/2097152 bytes at offset 0
+2 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=4194304 backing_file=TEST_DIR/t.IMGFMT.base backing_fmt=IMGFMT
+wrote 2097152/2097152 bytes at offset 1048576
+2 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+
+=== Check allocation over NBD ===
+
+[{ "start": 0, "length": 1048576, "depth": 1, "zero": false, "data": true, "offset": 327680},
+{ "start": 1048576, "length": 2097152, "depth": 0, "zero": false, "data": true, "offset": 327680},
+{ "start": 3145728, "length": 1048576, "depth": 1, "zero": true, "data": false}]
+[{ "start": 0, "length": 3145728, "depth": 0, "zero": false, "data": true, "offset": OFFSET},
+{ "start": 3145728, "length": 1048576, "depth": 0, "zero": true, "data": false, "offset": OFFSET}]
+[{ "start": 0, "length": 1048576, "depth": 0, "zero": true, "data": true, "offset": OFFSET},
+{ "start": 1048576, "length": 2097152, "depth": 0, "zero": false, "data": false},
+{ "start": 3145728, "length": 1048576, "depth": 0, "zero": false, "data": true, "offset": OFFSET}]
+*** done
diff --git a/tests/qemu-iotests/group b/tests/qemu-iotests/group
index 9e4f7c01530d..a567fa97d7e5 100644
--- a/tests/qemu-iotests/group
+++ b/tests/qemu-iotests/group
@@ -315,3 +315,4 @@
 304 rw quick
 305 rw quick
 307 rw quick export
+309 rw auto quick
-- 
2.28.0


