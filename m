Return-Path: <SRS0=bySr=YS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92FC9CA9EA0
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 13:52:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5C1EF20679
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 13:52:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Moeou/1k"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C1EF20679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60252 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iO01C-0005m1-2z
	for qemu-devel@archiver.kernel.org; Fri, 25 Oct 2019 09:52:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36893)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1iNzvP-0006C3-Ao
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 09:46:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1iNzvO-0000Jg-0K
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 09:46:43 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:57900
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1iNzvM-0000J5-SR
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 09:46:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1572011200;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2sxaBtjqvWi0knoDK0jTZDUTA3XjcjVZyQ8KlH5tC24=;
 b=Moeou/1kB862CZH4U1H09nW6CbhRoJnZsXEEWoV4CRDf6CHJuZ5WvhnLDnEm71FlkXR+fD
 bbnxJcGMNb+S6OWxOQfEUsPBWoxO0pNHGFPtjFPRxHZY/rzAShYKtom2fLd/y4zXXUCB0z
 rwzXjqLRWPSdE1ZsRCE/MMebf4/P+8c=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-208-D5kpB_suO2eoFYR8e9If0A-1; Fri, 25 Oct 2019 09:46:31 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id ED26647B;
 Fri, 25 Oct 2019 13:46:29 +0000 (UTC)
Received: from localhost.localdomain.com (ovpn-117-223.ams2.redhat.com
 [10.36.117.223])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E472D5D70E;
 Fri, 25 Oct 2019 13:46:28 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Subject: [PULL 7/7] qcow2: Fix corruption bug in
 qcow2_detect_metadata_preallocation()
Date: Fri, 25 Oct 2019 15:46:11 +0200
Message-Id: <20191025134611.25920-8-kwolf@redhat.com>
In-Reply-To: <20191025134611.25920-1-kwolf@redhat.com>
References: <20191025134611.25920-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: D5kpB_suO2eoFYR8e9If0A-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Reported-by: Michael Weiser <michael.weiser@gmx.de>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Tested-by: Michael Weiser <michael.weiser@gmx.de>
Reviewed-by: Michael Weiser <michael.weiser@gmx.de>
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
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


