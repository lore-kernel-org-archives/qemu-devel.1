Return-Path: <SRS0=bySr=YS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 355B4CA9EA0
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 10:32:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ACC4420663
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 10:32:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LpB+bMJ3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ACC4420663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58346 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNwtR-0003sz-1G
	for qemu-devel@archiver.kernel.org; Fri, 25 Oct 2019 06:32:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60889)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iNwNN-0006lU-PT
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 05:59:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iNwNM-0004nZ-Lu
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 05:59:21 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:32049
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1iNwNM-0004mr-Ac
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 05:59:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1571997558;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XpsKnDhhSg9Wa3tqe3NS161Z+XJaiocRkSfdBx9/23U=;
 b=LpB+bMJ3a9LGKruUL84bm3sNPazEdvuv9TAo5hfCReDPyRjDxiKF+6jrUa2MCnx/zvSX4q
 QHG4i1ZG8QEIvEUm3tBGX20Lb4vNgGiqCWqeluEOkUFzi2i/vPiRkMcfoEiliXy8Ot/qYq
 GIZpOnqBMAT/Z6pQ81+Ol4XvwmrLPLI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-258-P_a8lt4PO8-w_kZgh-nW7w-1; Fri, 25 Oct 2019 05:59:15 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F0AD680183D;
 Fri, 25 Oct 2019 09:59:13 +0000 (UTC)
Received: from localhost (ovpn-117-205.ams2.redhat.com [10.36.117.205])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 099065C1B5;
 Fri, 25 Oct 2019 09:59:10 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [RFC 3/3] block/file-posix: Let post-EOF fallocate serialize
Date: Fri, 25 Oct 2019 11:58:49 +0200
Message-Id: <20191025095849.25283-4-mreitz@redhat.com>
In-Reply-To: <20191025095849.25283-1-mreitz@redhat.com>
References: <20191025095849.25283-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: P_a8lt4PO8-w_kZgh-nW7w-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.120
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
 Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org,
 Max Reitz <mreitz@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The XFS kernel driver has a bug that may cause data corruption for qcow2
images as of qemu commit c8bb23cbdbe32f.  We can work around it by
treating post-EOF fallocates as serializing up until infinity (INT64_MAX
in practice).

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 block/file-posix.c | 42 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/block/file-posix.c b/block/file-posix.c
index 5cd54c8bff..1f5a01df70 100644
--- a/block/file-posix.c
+++ b/block/file-posix.c
@@ -2713,6 +2713,48 @@ raw_do_pwrite_zeroes(BlockDriverState *bs, int64_t o=
ffset, int bytes,
     RawPosixAIOData acb;
     ThreadPoolFunc *handler;
=20
+#ifdef CONFIG_FALLOCATE
+    if (s->is_xfs && s->use_linux_aio &&
+        offset + bytes > bs->total_sectors * BDRV_SECTOR_SIZE)
+    {
+        BdrvTrackedRequest *req;
+        uint64_t end;
+
+        /*
+         * The Linux XFS driver has a bug where it will discard writes
+         * submitted through the AIO interface if they happen beyond a
+         * concurrently running fallocate() that increases the file
+         * length (i.e., both the write and the fallocate() happen
+         * beyond the EOF).
+         *
+         * To work around it, we look for the tracked request for this
+         * zero write, extend it until INT64_MAX (effectively
+         * infinity), and mark it as serializing.
+         *
+         * TODO: Detect whether this has been fixed in the XFS driver.
+         */
+
+        QLIST_FOREACH(req, &bs->tracked_requests, list) {
+            if (req->co =3D=3D qemu_coroutine_self() &&
+                req->type =3D=3D BDRV_TRACKED_WRITE)
+            {
+                break;
+            }
+        }
+
+        assert(req);
+        assert(req->offset <=3D offset);
+        assert(req->offset + req->bytes >=3D offset + bytes);
+
+        end =3D INT64_MAX & -(uint64_t)bs->bl.request_alignment;
+        req->bytes =3D end - req->offset;
+        req->overlap_bytes =3D req->bytes;
+
+        bdrv_mark_request_serialising(req, bs->bl.request_alignment);
+        bdrv_wait_serialising_requests(req);
+    }
+#endif
+
     acb =3D (RawPosixAIOData) {
         .bs             =3D bs,
         .aio_fildes     =3D s->fd,
--=20
2.21.0


