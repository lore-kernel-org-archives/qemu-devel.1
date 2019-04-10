Return-Path: <SRS0=gZkW=SM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90E0DC10F11
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Apr 2019 21:00:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6025D204EC
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Apr 2019 21:00:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6025D204EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:37807 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hEKKI-0002MP-Lw
	for qemu-devel@archiver.kernel.org; Wed, 10 Apr 2019 17:00:10 -0400
Received: from eggs.gnu.org ([209.51.188.92]:42724)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1hEKHm-0000jo-Lp
	for qemu-devel@nongnu.org; Wed, 10 Apr 2019 16:57:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1hEKHl-0008CU-Mj
	for qemu-devel@nongnu.org; Wed, 10 Apr 2019 16:57:34 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36350)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mreitz@redhat.com>)
	id 1hEKHj-0008Aa-HP; Wed, 10 Apr 2019 16:57:31 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C0C3D308CF80;
	Wed, 10 Apr 2019 20:57:30 +0000 (UTC)
Received: from localhost (unknown [10.40.205.69])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 566B717996;
	Wed, 10 Apr 2019 20:57:30 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Date: Wed, 10 Apr 2019 22:57:14 +0200
Message-Id: <20190410205715.2209-6-mreitz@redhat.com>
In-Reply-To: <20190410205715.2209-1-mreitz@redhat.com>
References: <20190410205715.2209-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.44]);
	Wed, 10 Apr 2019 20:57:30 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v2 5/6] blkdebug: Inject errors on
 .bdrv_co_block_status()
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Kevin Wolf <kwolf@redhat.com>,
	Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
	qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>,
	"Denis V . Lunev" <den@openvz.org>,
	Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190410205714.fkjCUxPVmtGCeTuUx-Z8FvOyaYvPiQ_lfOXrf_TgZAg@z>

Signed-off-by: Max Reitz <mreitz@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 qapi/block-core.json | 5 ++++-
 block/blkdebug.c     | 8 ++++++++
 2 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/qapi/block-core.json b/qapi/block-core.json
index 717b13f7f5..2aa675a192 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -3252,10 +3252,13 @@
 #
 # @flush: .bdrv_co_flush_to_disk()
 #
+# @block-status: .bdrv_co_block_status()
+#
 # Since: 4.1
 ##
 { 'enum': 'BlkdebugIOType',
-  'data': [ 'read', 'write', 'write-zeroes', 'discard', 'flush' ] }
+  'data': [ 'read', 'write', 'write-zeroes', 'discard', 'flush',
+            'block-status' ] }
=20
 ##
 # @BlkdebugInjectErrorOptions:
diff --git a/block/blkdebug.c b/block/blkdebug.c
index 69c608be6f..df9c8b1673 100644
--- a/block/blkdebug.c
+++ b/block/blkdebug.c
@@ -670,7 +670,15 @@ static int coroutine_fn blkdebug_co_block_status(Blo=
ckDriverState *bs,
                                                  int64_t *map,
                                                  BlockDriverState **file=
)
 {
+    int err;
+
     assert(QEMU_IS_ALIGNED(offset | bytes, bs->bl.request_alignment));
+
+    err =3D rule_check(bs, offset, bytes, BLKDEBUGIO_TYPE_BLOCK_STATUS);
+    if (err) {
+        return err;
+    }
+
     return bdrv_co_block_status_from_file(bs, want_zero, offset, bytes,
                                           pnum, map, file);
 }
--=20
2.20.1


