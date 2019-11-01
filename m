Return-Path: <SRS0=V8KP=YZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CA08CA9ECF
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Nov 2019 10:05:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E86422086D
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Nov 2019 10:05:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Hq2ZnV6X"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E86422086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37192 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iQToN-0001WZ-IH
	for qemu-devel@archiver.kernel.org; Fri, 01 Nov 2019 06:05:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40412)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iQTjb-000770-Ra
 for qemu-devel@nongnu.org; Fri, 01 Nov 2019 06:00:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iQTjZ-0005U0-KG
 for qemu-devel@nongnu.org; Fri, 01 Nov 2019 06:00:46 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:52744
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1iQTjZ-0005NY-CR
 for qemu-devel@nongnu.org; Fri, 01 Nov 2019 06:00:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1572602443;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=u4OEPj71kqlrt31oYuTE5It4Um95mf+PdKtBZRC/t5U=;
 b=Hq2ZnV6X13Y3LXI38DaRgT35IKIMFa5SnXdKOle4hXDZNWW+mX45i4Jl5r/ylcya5Usxpq
 tDIQWHHqaIGCvVXOHZq8aMfaIMTy1d4R4mbm0Hphj3wDHSNw7WoDBVFOpy9IxqqgByK7Mb
 /Ik4ao8Vo7+IolHGAaCtfS7w21GBeE8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-345-Doq3Ui9hPLSFppQ5m8WmFA-1; Fri, 01 Nov 2019 06:00:41 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AAC482A3;
 Fri,  1 Nov 2019 10:00:40 +0000 (UTC)
Received: from localhost (ovpn-117-28.ams2.redhat.com [10.36.117.28])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 2095B101E812;
 Fri,  1 Nov 2019 10:00:39 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH for-4.2 3/4] block: Add bdrv_co_get_self_request()
Date: Fri,  1 Nov 2019 11:00:18 +0100
Message-Id: <20191101100019.9512-4-mreitz@redhat.com>
In-Reply-To: <20191101100019.9512-1-mreitz@redhat.com>
References: <20191101100019.9512-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: Doq3Ui9hPLSFppQ5m8WmFA-1
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
Cc: Kevin Wolf <kwolf@redhat.com>, Anton Nefedov <anton.nefedov@virtuozzo.com>,
 qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 include/block/block_int.h |  1 +
 block/io.c                | 18 ++++++++++++++++++
 2 files changed, 19 insertions(+)

diff --git a/include/block/block_int.h b/include/block/block_int.h
index 32fa323b63..4fc531f9b2 100644
--- a/include/block/block_int.h
+++ b/include/block/block_int.h
@@ -1001,6 +1001,7 @@ void bdrv_unapply_subtree_drain(BdrvChild *child, Blo=
ckDriverState *old_parent);
=20
 bool coroutine_fn bdrv_wait_serialising_requests(BdrvTrackedRequest *self)=
;
 void bdrv_mark_request_serialising(BdrvTrackedRequest *req, uint64_t align=
);
+BdrvTrackedRequest *bdrv_co_get_self_request(BlockDriverState *bs);
=20
 int get_tmp_filename(char *filename, int size);
 BlockDriver *bdrv_probe_all(const uint8_t *buf, int buf_size,
diff --git a/block/io.c b/block/io.c
index 039c0d49c9..e9205994a8 100644
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
+BdrvTrackedRequest *bdrv_co_get_self_request(BlockDriverState *bs)
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


