Return-Path: <SRS0=brme=YQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1B0BCA9EB6
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2019 16:29:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2F8082084C
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2019 16:29:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KTTlrEMA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F8082084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41206 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNJVg-0004ao-0w
	for qemu-devel@archiver.kernel.org; Wed, 23 Oct 2019 12:29:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39870)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1iNIXO-0005Os-Ct
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 11:27:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1iNIXN-0002mI-8Z
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 11:27:02 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:50531
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1iNIXN-0002lh-4t
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 11:27:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1571844420;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=90Ia9SFR3pnny2eRawjSZIKQHSdVWiZbhyuLrDWnZEI=;
 b=KTTlrEMAG3fZV/L5NIw5QNxUPoTlWfn/xso435sGei/Gd2eECBVIZOHRTAiLAahibhtZ/g
 wi4jyQLYV+3BWLsrF+PQrMRluZ/smGhJnjJVm1MV0q8LGMBuCqbAZY/kLXWyDfyzLGoK/2
 /5/ZRZst40RTCrFNugE4+1rulABo6gs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-213-r1svjNF2Nm2DQ-iOF2l_5Q-1; Wed, 23 Oct 2019 11:26:57 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D409C476;
 Wed, 23 Oct 2019 15:26:55 +0000 (UTC)
Received: from localhost.localdomain.com (ovpn-117-192.ams2.redhat.com
 [10.36.117.192])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9DCCC6061E;
 Wed, 23 Oct 2019 15:26:53 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH 3/3] qcow2: Fix corruption bug in
 qcow2_detect_metadata_preallocation()
Date: Wed, 23 Oct 2019 17:26:20 +0200
Message-Id: <20191023152620.13166-4-kwolf@redhat.com>
In-Reply-To: <20191023152620.13166-1-kwolf@redhat.com>
References: <20191023152620.13166-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: r1svjNF2Nm2DQ-iOF2l_5Q-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
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
Cc: kwolf@redhat.com, psyhomb@gmail.com, michael@weiser.dinsnail.net,
 vsementsov@virtuozzo.com, den@virtuozzo.com, qemu-devel@nongnu.org,
 qemu-stable@nongnu.org, dgilbert@redhat.com, mreitz@redhat.com,
 lersek@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

qcow2_detect_metadata_preallocation() calls qcow2_get_refcount() which
requires s->lock to be taken to protect its accesses to the refcount
table and refcount blocks. However, nothing in this code path actually
took the lock. This could cause the same cache entry to be used by two
requests at the same time, for different tables at different offsets,
resulting in image corruption.

As it would be preferable to base the detection on consistent data (even
though it's just heuristics), let's take the lock not only around the
qcow2_get_refcount() calls, but around the whole function.

This patch takes the lock in qcow2_co_block_status() earlier and asserts
in qcow2_detect_metadata_preallocation() that we hold the lock.

Fixes: 69f47505ee66afaa513305de0c1895a224e52c45
Cc: qemu-stable@nongnu.org
Reported-by: Michael Weiser <michael@weiser.dinsnail.net>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/qcow2-refcount.c | 2 ++
 block/qcow2.c          | 3 ++-
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/block/qcow2-refcount.c b/block/qcow2-refcount.c
index ef965d7895..0d64bf5a5e 100644
--- a/block/qcow2-refcount.c
+++ b/block/qcow2-refcount.c
@@ -3455,6 +3455,8 @@ int qcow2_detect_metadata_preallocation(BlockDriverSt=
ate *bs)
     int64_t i, end_cluster, cluster_count =3D 0, threshold;
     int64_t file_length, real_allocation, real_clusters;
=20
+    qemu_co_mutex_assert_locked(&s->lock);
+
     file_length =3D bdrv_getlength(bs->file->bs);
     if (file_length < 0) {
         return file_length;
diff --git a/block/qcow2.c b/block/qcow2.c
index 8b05933565..0bc69e6996 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -1916,6 +1916,8 @@ static int coroutine_fn qcow2_co_block_status(BlockDr=
iverState *bs,
     unsigned int bytes;
     int status =3D 0;
=20
+    qemu_co_mutex_lock(&s->lock);
+
     if (!s->metadata_preallocation_checked) {
         ret =3D qcow2_detect_metadata_preallocation(bs);
         s->metadata_preallocation =3D (ret =3D=3D 1);
@@ -1923,7 +1925,6 @@ static int coroutine_fn qcow2_co_block_status(BlockDr=
iverState *bs,
     }
=20
     bytes =3D MIN(INT_MAX, count);
-    qemu_co_mutex_lock(&s->lock);
     ret =3D qcow2_get_cluster_offset(bs, offset, &bytes, &cluster_offset);
     qemu_co_mutex_unlock(&s->lock);
     if (ret < 0) {
--=20
2.20.1


