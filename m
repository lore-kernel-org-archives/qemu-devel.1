Return-Path: <SRS0=Szrt=YV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9807CA9EC0
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Oct 2019 13:14:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A404020717
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Oct 2019 13:14:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BzvKwnQB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A404020717
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53626 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iP4qa-0002Rp-Hx
	for qemu-devel@archiver.kernel.org; Mon, 28 Oct 2019 09:14:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51020)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iP3xO-0003YZ-8g
 for qemu-devel@nongnu.org; Mon, 28 Oct 2019 08:17:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iP3xI-0002EC-VN
 for qemu-devel@nongnu.org; Mon, 28 Oct 2019 08:17:07 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:27767
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1iP3xE-00029S-CK
 for qemu-devel@nongnu.org; Mon, 28 Oct 2019 08:17:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1572265018;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=d8nQl2CsqL3dQqVIsVKROXIrGrVJwou6Y9YYBNm5fVY=;
 b=BzvKwnQBfJYgsffVox5LrX20g7Zlwq+o8HOw7k9UC+Z1GRTD3mSv46G84ZEnKsjERwY5I6
 F7ZWaHBsrympoiktDk/qcTsUYA4fnANUcjimt1TMN9VqPc8xGgr0iukAmAsMtNXNFzN6Nd
 Y4CM0GBignFOnWOGUO9ivLh5Ef4auMk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-425-79GTOUHrM0CrHt9hsaSspg-1; Mon, 28 Oct 2019 08:16:54 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 203CF476;
 Mon, 28 Oct 2019 12:16:53 +0000 (UTC)
Received: from localhost (ovpn-117-83.ams2.redhat.com [10.36.117.83])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B92BE60BF7;
 Mon, 28 Oct 2019 12:16:52 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PULL 53/69] qcow2: Add qcow2_check_fix_snapshot_table()
Date: Mon, 28 Oct 2019 13:14:45 +0100
Message-Id: <20191028121501.15279-54-mreitz@redhat.com>
In-Reply-To: <20191028121501.15279-1-mreitz@redhat.com>
References: <20191028121501.15279-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: 79GTOUHrM0CrHt9hsaSspg-1
X-Mimecast-Spam-Score: 0
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

qcow2_check_read_snapshot_table() can perform consistency checks, but it
cannot fix everything.  Specifically, it cannot allocate new clusters,
because that should wait until the refcount structures are known to be
consistent (i.e., after qcow2_check_refcounts()).  Thus, it cannot call
qcow2_write_snapshots().

Do that in qcow2_check_fix_snapshot_table(), which is called after
qcow2_check_refcounts().

Currently, there is nothing that would set result->corruptions, so this
is a no-op.  A follow-up patch will change that.

Signed-off-by: Max Reitz <mreitz@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Message-id: 20191011152814.14791-10-mreitz@redhat.com
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 block/qcow2.h          |  3 +++
 block/qcow2-snapshot.c | 25 +++++++++++++++++++++++++
 block/qcow2.c          |  9 ++++++++-
 3 files changed, 36 insertions(+), 1 deletion(-)

diff --git a/block/qcow2.h b/block/qcow2.h
index adb5c3bc28..601c2e4c82 100644
--- a/block/qcow2.h
+++ b/block/qcow2.h
@@ -721,6 +721,9 @@ int qcow2_write_snapshots(BlockDriverState *bs);
 int coroutine_fn qcow2_check_read_snapshot_table(BlockDriverState *bs,
                                                  BdrvCheckResult *result,
                                                  BdrvCheckMode fix);
+int coroutine_fn qcow2_check_fix_snapshot_table(BlockDriverState *bs,
+                                                BdrvCheckResult *result,
+                                                BdrvCheckMode fix);
=20
 /* qcow2-cache.c functions */
 Qcow2Cache *qcow2_cache_create(BlockDriverState *bs, int num_tables,
diff --git a/block/qcow2-snapshot.c b/block/qcow2-snapshot.c
index d667bfd935..b526a8f819 100644
--- a/block/qcow2-snapshot.c
+++ b/block/qcow2-snapshot.c
@@ -380,6 +380,31 @@ int coroutine_fn qcow2_check_read_snapshot_table(Block=
DriverState *bs,
     return 0;
 }
=20
+int coroutine_fn qcow2_check_fix_snapshot_table(BlockDriverState *bs,
+                                                BdrvCheckResult *result,
+                                                BdrvCheckMode fix)
+{
+    BDRVQcow2State *s =3D bs->opaque;
+    int ret;
+
+    if (result->corruptions && (fix & BDRV_FIX_ERRORS)) {
+        qemu_co_mutex_unlock(&s->lock);
+        ret =3D qcow2_write_snapshots(bs);
+        qemu_co_mutex_lock(&s->lock);
+        if (ret < 0) {
+            result->check_errors++;
+            fprintf(stderr, "ERROR failed to update snapshot table: %s\n",
+                    strerror(-ret));
+            return ret;
+        }
+
+        result->corruptions_fixed +=3D result->corruptions;
+        result->corruptions =3D 0;
+    }
+
+    return 0;
+}
+
 static void find_new_snapshot_id(BlockDriverState *bs,
                                  char *id_str, int id_str_size)
 {
diff --git a/block/qcow2.c b/block/qcow2.c
index b0026e8a9a..8d4f38ae74 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -597,13 +597,20 @@ static int coroutine_fn qcow2_co_check_locked(BlockDr=
iverState *bs,
     memset(result, 0, sizeof(*result));
=20
     ret =3D qcow2_check_read_snapshot_table(bs, &snapshot_res, fix);
-    qcow2_add_check_result(result, &snapshot_res, false);
     if (ret < 0) {
+        qcow2_add_check_result(result, &snapshot_res, false);
         return ret;
     }
=20
     ret =3D qcow2_check_refcounts(bs, &refcount_res, fix);
     qcow2_add_check_result(result, &refcount_res, true);
+    if (ret < 0) {
+        qcow2_add_check_result(result, &snapshot_res, false);
+        return ret;
+    }
+
+    ret =3D qcow2_check_fix_snapshot_table(bs, &snapshot_res, fix);
+    qcow2_add_check_result(result, &snapshot_res, false);
     if (ret < 0) {
         return ret;
     }
--=20
2.21.0


