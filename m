Return-Path: <SRS0=HfOj=DH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 718C5C4727E
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 12:17:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E56012071E
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 12:17:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ABraMrUn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E56012071E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53530 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNb3I-0001do-4r
	for qemu-devel@archiver.kernel.org; Wed, 30 Sep 2020 08:17:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43276)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1kNaxR-00048X-L5
 for qemu-devel@nongnu.org; Wed, 30 Sep 2020 08:11:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:48711)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1kNaxP-0007Au-DU
 for qemu-devel@nongnu.org; Wed, 30 Sep 2020 08:11:41 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601467898;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BxOifmMZB4JCULA4CJ3qPK76gnGagJOVBlZRpK0RkzQ=;
 b=ABraMrUnEfgN0t42gIA9Z4j4AIBGQbtHd5H6RQqUnmdJ7wQ7g70dS0LeVWrSZLHQq1bOOW
 0PQLaajx9PVRhdH3R/xv8Jq8v9srXwXpPwYA7SglrFG9M0pKuFE4YgNbnG2Sah+EHmLkRC
 RDgaaSS/AmICcT9uUD7B4+DCPn1McE4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-212-p46LjV7COYafxFY42S9oGw-1; Wed, 30 Sep 2020 08:11:27 -0400
X-MC-Unique: p46LjV7COYafxFY42S9oGw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F21201005E6F;
 Wed, 30 Sep 2020 12:11:25 +0000 (UTC)
Received: from blue.redhat.com (ovpn-112-208.phx2.redhat.com [10.3.112.208])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 913E660C05;
 Wed, 30 Sep 2020 12:11:22 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 5/5] nbd: Add 'qemu-nbd -A' to expose allocation depth
Date: Wed, 30 Sep 2020 07:11:05 -0500
Message-Id: <20200930121105.667049-6-eblake@redhat.com>
In-Reply-To: <20200930121105.667049-1-eblake@redhat.com>
References: <20200930121105.667049-1-eblake@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=eblake@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=63.128.21.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/30 00:31:59
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.469,
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
Cc: kwolf@redhat.com, pkrempa@redhat.com, qemu-block@nongnu.org,
 Markus Armbruster <armbru@redhat.com>, rjones@redhat.com,
 Max Reitz <mreitz@redhat.com>, vsementsov@virtuozzo.com, stefanha@redhat.com
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
---
 docs/tools/qemu-nbd.rst    |  6 ++++
 qapi/block-core.json       |  7 ++--
 qapi/block-export.json     |  6 +++-
 blockdev-nbd.c             |  2 ++
 nbd/server.c               |  2 ++
 qemu-nbd.c                 | 14 ++++++--
 tests/qemu-iotests/309     | 73 ++++++++++++++++++++++++++++++++++++++
 tests/qemu-iotests/309.out | 22 ++++++++++++
 tests/qemu-iotests/group   |  1 +
 9 files changed, 127 insertions(+), 6 deletions(-)
 create mode 100755 tests/qemu-iotests/309
 create mode 100644 tests/qemu-iotests/309.out

diff --git a/docs/tools/qemu-nbd.rst b/docs/tools/qemu-nbd.rst
index 667861cb22e9..0e545a97cfa3 100644
--- a/docs/tools/qemu-nbd.rst
+++ b/docs/tools/qemu-nbd.rst
@@ -72,6 +72,12 @@ driver options if ``--image-opts`` is specified.

   Export the disk as read-only.

+.. option:: -A, --allocation-depth
+
+  Expose allocation depth information via the
+  ``qemu:allocation-depth`` context accessible through
+  NBD_OPT_SET_META_CONTEXT.
+
 .. option:: -B, --bitmap=NAME

   If *filename* has a qcow2 persistent bitmap *NAME*, expose
diff --git a/qapi/block-core.json b/qapi/block-core.json
index d620bd1302b2..0379eb992db8 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -3874,9 +3874,12 @@
 #
 # @tls-creds: TLS credentials ID
 #
-# @x-dirty-bitmap: A "qemu:dirty-bitmap:NAME" string to query in place of
+# @x-dirty-bitmap: A metacontext name such as "qemu:dirty-bitmap:NAME" or
+#                  "qemu:allocation-depth" to query in place of the
 #                  traditional "base:allocation" block status (see
-#                  NBD_OPT_LIST_META_CONTEXT in the NBD protocol) (since 3.0)
+#                  NBD_OPT_LIST_META_CONTEXT in the NBD protocol; and
+#                  yes, naming this option x-context would have made
+#                  more sense) (since 3.0)
 #
 # @reconnect-delay: On an unexpected disconnect, the nbd client tries to
 #                   connect again until succeeding or encountering a serious
diff --git a/qapi/block-export.json b/qapi/block-export.json
index 2291d6cb0cbc..45e43984b11d 100644
--- a/qapi/block-export.json
+++ b/qapi/block-export.json
@@ -78,11 +78,15 @@
 #          NBD client can use NBD_OPT_SET_META_CONTEXT with
 #          "qemu:dirty-bitmap:NAME" to inspect the bitmap. (since 4.0)
 #
+# @alloc: Also export the allocation map for @device, so the NBD client
+#         can use NBD_OPT_SET_META_CONTEXT with "qemu:allocation-depth"
+#         to inspect allocation details. (since 5.2)
+#
 # Since: 5.0
 ##
 { 'struct': 'BlockExportOptionsNbd',
   'data': { '*name': 'str', '*description': 'str',
-            '*bitmap': 'str' } }
+            '*bitmap': 'str', '*alloc': 'bool' } }

 ##
 # @NbdServerAddOptions:
diff --git a/blockdev-nbd.c b/blockdev-nbd.c
index 8174023e5c47..f9012f93e2bb 100644
--- a/blockdev-nbd.c
+++ b/blockdev-nbd.c
@@ -212,6 +212,8 @@ void qmp_nbd_server_add(NbdServerAddOptions *arg, Error **errp)
             .description        = g_strdup(arg->description),
             .has_bitmap         = arg->has_bitmap,
             .bitmap             = g_strdup(arg->bitmap),
+            .has_alloc          = arg->alloc,
+            .alloc              = arg->alloc,
         },
     };

diff --git a/nbd/server.c b/nbd/server.c
index 830b21000be3..11cdc2eab0b3 100644
--- a/nbd/server.c
+++ b/nbd/server.c
@@ -1598,6 +1598,8 @@ static int nbd_export_create(BlockExport *blk_exp, BlockExportOptions *exp_args,
         assert(strlen(exp->export_bitmap_context) < NBD_MAX_STRING_SIZE);
     }

+    exp->alloc_context = arg->alloc;
+
     blk_add_aio_context_notifier(blk, blk_aio_attached, blk_aio_detach, exp);

     QTAILQ_INSERT_TAIL(&exports, exp, next);
diff --git a/qemu-nbd.c b/qemu-nbd.c
index e7520261134f..3a92e00464de 100644
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
@@ -693,6 +696,9 @@ int main(int argc, char **argv)
             readonly = true;
             flags &= ~BDRV_O_RDWR;
             break;
+        case 'A':
+            alloc_depth = true;
+            break;
         case 'B':
             bitmap = optarg;
             break;
@@ -790,8 +796,8 @@ int main(int argc, char **argv)
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
@@ -1077,6 +1083,8 @@ int main(int argc, char **argv)
             .description        = g_strdup(export_description),
             .has_bitmap         = !!bitmap,
             .bitmap             = g_strdup(bitmap),
+            .has_alloc          = alloc_depth,
+            .alloc              = alloc_depth,
         },
     };
     blk_exp_add(export_opts, &error_fatal);
diff --git a/tests/qemu-iotests/309 b/tests/qemu-iotests/309
new file mode 100755
index 000000000000..16bd269ad2c1
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
+# Normal -f raw NBD block status loses access to allocation information
+$QEMU_IMG map --output=json -f qcow2 "$TEST_IMG"
+IMG="driver=nbd,server.type=unix,server.path=$nbd_unix_socket"
+nbd_server_start_unix_socket -r -f qcow2 -A "$TEST_IMG"
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


