Return-Path: <SRS0=+QfZ=VN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB9AAC7618F
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2019 01:14:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 91DCC20693
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2019 01:14:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 91DCC20693
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44696 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hnC2f-0005rx-Kb
	for qemu-devel@archiver.kernel.org; Mon, 15 Jul 2019 21:14:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56747)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <jsnow@redhat.com>) id 1hnC2U-0005Mj-UC
 for qemu-devel@nongnu.org; Mon, 15 Jul 2019 21:13:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jsnow@redhat.com>) id 1hnC2T-0003SB-Nk
 for qemu-devel@nongnu.org; Mon, 15 Jul 2019 21:13:54 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44338)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jsnow@redhat.com>)
 id 1hnC2R-0003Qu-1G; Mon, 15 Jul 2019 21:13:51 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 263CEC057F2F;
 Tue, 16 Jul 2019 01:13:50 +0000 (UTC)
Received: from probe.bos.redhat.com (dhcp-17-130.bos.redhat.com [10.18.17.130])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B79F46085B;
 Tue, 16 Jul 2019 01:13:44 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-block@nongnu.org,
	qemu-devel@nongnu.org
Date: Mon, 15 Jul 2019 21:13:44 -0400
Message-Id: <20190716011344.25380-1-jsnow@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.32]); Tue, 16 Jul 2019 01:13:50 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v2] qapi: add dirty-bitmaps to
 query-named-block-nodes result
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 libvir-list@redhat.com, John Snow <jsnow@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

Let's add a possibility to query dirty-bitmaps not only on root nodes.
It is useful when dealing both with snapshots and incremental backups.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
[Added deprecation and feature flag information. --js]
Signed-off-by: John Snow <jsnow@redhat.com>
---
 block/qapi.c         |  5 +++++
 qapi/block-core.json | 14 +++++++++++++-
 qemu-deprecated.texi | 12 ++++++++++++
 3 files changed, 30 insertions(+), 1 deletion(-)

diff --git a/block/qapi.c b/block/qapi.c
index 917435f022..15f1030264 100644
--- a/block/qapi.c
+++ b/block/qapi.c
@@ -79,6 +79,11 @@ BlockDeviceInfo *bdrv_block_device_info(BlockBackend *=
blk,
         info->backing_file =3D g_strdup(bs->backing_file);
     }
=20
+    if (!QLIST_EMPTY(&bs->dirty_bitmaps)) {
+        info->has_dirty_bitmaps =3D true;
+        info->dirty_bitmaps =3D bdrv_query_dirty_bitmaps(bs);
+    }
+
     info->detect_zeroes =3D bs->detect_zeroes;
=20
     if (blk && blk_get_public(blk)->throttle_group_member.throttle_state=
) {
diff --git a/qapi/block-core.json b/qapi/block-core.json
index 0d43d4f37c..0d67dd245c 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -360,6 +360,16 @@
 # @write_threshold: configured write threshold for the device.
 #                   0 if disabled. (Since 2.3)
 #
+# @dirty-bitmaps: dirty bitmaps information (only present if node
+#                 has one or more dirty bitmaps) (Since 4.2)
+#
+# Features:
+# @node-dirty-bitmaps: Signals the capability to return dirty bitmap inf=
ormation
+#                      per-node instead of per-drive. If this flag is pr=
esent,
+#                      dirty-bitmaps should not be read from the BlockIn=
fo
+#                      structure, the top-level data for query-block.
+#                      (Since 4.2)
+#
 # Since: 0.14.0
 #
 ##
@@ -378,7 +388,8 @@
             '*bps_wr_max_length': 'int', '*iops_max_length': 'int',
             '*iops_rd_max_length': 'int', '*iops_wr_max_length': 'int',
             '*iops_size': 'int', '*group': 'str', 'cache': 'BlockdevCach=
eInfo',
-            'write_threshold': 'int' } }
+            'write_threshold': 'int', '*dirty-bitmaps': ['BlockDirtyInfo=
'] },
+  'features': [ { 'name': 'node-dirty-bitmaps' } ] }
=20
 ##
 # @BlockDeviceIoStatus:
@@ -656,6 +667,7 @@
 #
 # @dirty-bitmaps: dirty bitmaps information (only present if the
 #                 driver has one or more dirty bitmaps) (Since 2.0)
+#                 Deprecated in 4.2; see BlockDirtyInfo instead.
 #
 # @io-status: @BlockDeviceIoStatus. Only present if the device
 #             supports it and the VM is configured to stop on errors
diff --git a/qemu-deprecated.texi b/qemu-deprecated.texi
index c90b08d553..bc4e5ac1d7 100644
--- a/qemu-deprecated.texi
+++ b/qemu-deprecated.texi
@@ -134,6 +134,18 @@ The ``status'' field of the ``BlockDirtyInfo'' struc=
ture, returned by
 the query-block command is deprecated. Two new boolean fields,
 ``recording'' and ``busy'' effectively replace it.
=20
+@subsection query-block result field dirty-bitmaps (Since 4.2)
+
+The ``dirty-bitmaps`` field of the ``BlockInfo`` structure, returned by
+the query-block command is itself now deprecated. The ``dirty-bitmaps``
+field of the ``BlockDeviceInfo`` struct should be used instead, which is=
 the
+type of the ``inserted`` field in query-block replies, as well as the
+type of array items in query-named-block-nodes.
+
+In the absence of bitmaps on either structure, management APIs may use t=
he
+presence of the ``node-dirty-bitmaps`` feature flag on the ``BlockDevice=
Info``
+structure to know where to anticipate bitmap data when present.
+
 @subsection query-cpus (since 2.12.0)
=20
 The ``query-cpus'' command is replaced by the ``query-cpus-fast'' comman=
d.
--=20
2.21.0


