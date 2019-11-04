Return-Path: <SRS0=KlJF=Y4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3117CA9ED2
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2019 09:06:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C149F222CD
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2019 09:06:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="D5mlSGij"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C149F222CD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58614 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iRYJE-00011n-DD
	for qemu-devel@archiver.kernel.org; Mon, 04 Nov 2019 04:06:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34888)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iRYHb-0007Ri-Gq
 for qemu-devel@nongnu.org; Mon, 04 Nov 2019 04:04:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iRYHa-0003MZ-7x
 for qemu-devel@nongnu.org; Mon, 04 Nov 2019 04:04:19 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:46138
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1iRYHa-00032o-1G
 for qemu-devel@nongnu.org; Mon, 04 Nov 2019 04:04:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1572858241;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kjoRQxInG7FgLzMkntMX8CHdxFC9p5J7VjjpF3PLyEw=;
 b=D5mlSGijlr+iMADY9gEo56h9PX+0jvzLPtMeLKwNcbsgc65w/5GyqD0fZxObsItqWActYj
 HaCY7VPmosXez3LUWi+dS3PE3Y4n3ZAgbxc9qN7oznPOW1nb2dugA85w9P+EUKOxYeSuz5
 OfLnOI2kojsIsnimLj8Ea4nWEvlCSSY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-183-66HkISBmObmzzF0QHqDO8A-1; Mon, 04 Nov 2019 04:03:58 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6FFFC180496F;
 Mon,  4 Nov 2019 09:03:57 +0000 (UTC)
Received: from localhost (ovpn-117-85.ams2.redhat.com [10.36.117.85])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 0DFD260BF1;
 Mon,  4 Nov 2019 09:03:56 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PULL 4/5] block: Add bdrv_co_get_self_request()
Date: Mon,  4 Nov 2019 10:03:46 +0100
Message-Id: <20191104090347.27278-5-mreitz@redhat.com>
In-Reply-To: <20191104090347.27278-1-mreitz@redhat.com>
References: <20191104090347.27278-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: 66HkISBmObmzzF0QHqDO8A-1
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

Cc: qemu-stable@nongnu.org
Signed-off-by: Max Reitz <mreitz@redhat.com>
Message-id: 20191101152510.11719-3-mreitz@redhat.com
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 include/block/block_int.h |  1 +
 block/io.c                | 18 ++++++++++++++++++
 2 files changed, 19 insertions(+)

diff --git a/include/block/block_int.h b/include/block/block_int.h
index 32fa323b63..dd033d0b37 100644
--- a/include/block/block_int.h
+++ b/include/block/block_int.h
@@ -1001,6 +1001,7 @@ void bdrv_unapply_subtree_drain(BdrvChild *child, Blo=
ckDriverState *old_parent);
=20
 bool coroutine_fn bdrv_wait_serialising_requests(BdrvTrackedRequest *self)=
;
 void bdrv_mark_request_serialising(BdrvTrackedRequest *req, uint64_t align=
);
+BdrvTrackedRequest *coroutine_fn bdrv_co_get_self_request(BlockDriverState=
 *bs);
=20
 int get_tmp_filename(char *filename, int size);
 BlockDriver *bdrv_probe_all(const uint8_t *buf, int buf_size,
diff --git a/block/io.c b/block/io.c
index 039c0d49c9..f75777f5ea 100644
--- a/block/io.c
+++ b/block/io.c
@@ -742,6 +742,24 @@ static bool is_request_serialising_and_aligned(BdrvTra=
ckedRequest *req)
            (req->bytes =3D=3D req->overlap_bytes);
 }
=20
+/**
+ * Return the tracked request on @bs for the current coroutine, or
+ * NULL if there is none.
+ */
+BdrvTrackedRequest *coroutine_fn bdrv_co_get_self_request(BlockDriverState=
 *bs)
+{
+    BdrvTrackedRequest *req;
+    Coroutine *self =3D qemu_coroutine_self();
+
+    QLIST_FOREACH(req, &bs->tracked_requests, list) {
+        if (req->co =3D=3D self) {
+            return req;
+        }
+    }
+
+    return NULL;
+}
+
 /**
  * Round a region to cluster boundaries
  */
--=20
2.21.0


