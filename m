Return-Path: <SRS0=V8KP=YZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 697CFCA9ECF
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Nov 2019 10:07:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 342AE2086D
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Nov 2019 10:07:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GttoklKS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 342AE2086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37210 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iQTq4-0003OP-Av
	for qemu-devel@archiver.kernel.org; Fri, 01 Nov 2019 06:07:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40483)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iQTk4-0007Li-GS
 for qemu-devel@nongnu.org; Fri, 01 Nov 2019 06:01:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iQTk1-0006oq-8v
 for qemu-devel@nongnu.org; Fri, 01 Nov 2019 06:01:15 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:37162
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1iQTjw-00068C-Sm
 for qemu-devel@nongnu.org; Fri, 01 Nov 2019 06:01:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1572602456;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CSfDgngGZU4Dl9sNhabdfyOvZuYyfclSjEtzmRhnADY=;
 b=GttoklKSG2Fu5ECDKsIXM4CkpUN/NvCNS65BXuL4JhRu+3l6iXyTS5uZKxHs+765u4U0dA
 v4CPnRbSl9n4yfYYZRtfhgTUEvzPhhNODPLXP4DhzS5aJ43Sy8KpVMiqm4/oVpbpfhjAHH
 tS+a2OnkHSoK0GzhVKr70Rz3L/j/zWU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-228-2rhOLzh1P56fZs8QHJF0lw-1; Fri, 01 Nov 2019 06:00:52 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 54FFE2A3;
 Fri,  1 Nov 2019 10:00:51 +0000 (UTC)
Received: from localhost (ovpn-117-28.ams2.redhat.com [10.36.117.28])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 3332860C18;
 Fri,  1 Nov 2019 10:00:43 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH for-4.2 4/4] block/file-posix: Let post-EOF fallocate serialize
Date: Fri,  1 Nov 2019 11:00:19 +0100
Message-Id: <20191101100019.9512-5-mreitz@redhat.com>
In-Reply-To: <20191101100019.9512-1-mreitz@redhat.com>
References: <20191101100019.9512-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: 2rhOLzh1P56fZs8QHJF0lw-1
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
Cc: Kevin Wolf <kwolf@redhat.com>, Anton Nefedov <anton.nefedov@virtuozzo.com>,
 qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The XFS kernel driver has a bug that may cause data loss when using
fallocate() in an I/O path, i.e. writing zeroes.  We can work around it
by treating post-EOF fallocates as serializing up until infinity
(INT64_MAX in practice).

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 block/file-posix.c | 38 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/block/file-posix.c b/block/file-posix.c
index 0b7e904d48..d5460f3e45 100644
--- a/block/file-posix.c
+++ b/block/file-posix.c
@@ -2721,6 +2721,44 @@ raw_do_pwrite_zeroes(BlockDriverState *bs, int64_t o=
ffset, int bytes,
     RawPosixAIOData acb;
     ThreadPoolFunc *handler;
=20
+#ifdef CONFIG_FALLOCATE
+    if (offset + bytes > bs->total_sectors * BDRV_SECTOR_SIZE) {
+        BdrvTrackedRequest *req;
+        uint64_t end;
+
+        /*
+         * This is a workaround for a bug in the Linux XFS driver,
+         * where writes submitted through the AIO interface will be
+         * discarded if they happen beyond a concurrently running
+         * fallocate() that increases the file length (i.e., both the
+         * write and the fallocate() happen beyond the EOF).
+         *
+         * To work around it, we extend the tracked request for this
+         * zero write until INT64_MAX (effectively infinity), and mark
+         * it as serializing.
+         *
+         * We have to enable this workaround for all filesystems and
+         * AIO modes (not just XFS with aio=3Dnative), because for
+         * remote filesystems we do not know the host configuration.
+         * However, this should have no effect as long as no block
+         * driver submits zero writes beyond the EOF.
+         */
+
+        req =3D bdrv_co_get_self_request(bs);
+        assert(req);
+        assert(req->type =3D=3D BDRV_TRACKED_WRITE);
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


