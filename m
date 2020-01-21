Return-Path: <SRS0=2jXw=3K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71260C2D0CE
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2020 14:00:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3C41922314
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2020 14:00:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="J4sOMZY5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C41922314
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54498 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1itu55-0002F6-UQ
	for qemu-devel@archiver.kernel.org; Tue, 21 Jan 2020 09:00:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52986)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1itsiS-00049R-P9
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 07:33:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1itsiO-00056j-Qq
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 07:33:08 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:22071
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1itsiO-00056V-NF
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 07:33:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579609984;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=M09PrHXt8xNtKGyoZor/r7J30S63cknnYdNmtitr9tU=;
 b=J4sOMZY5j1c5EgTrg+hW1w64KX406MUdwRpRMlRj+x7INYkk19gmLljVs7TycnN7TQ8JWz
 2Zg73M7nfx3XWmQexN1q71qCQTggWmHEkLLDiLgAzFfRpJROL6J4m+TmbtMx6ReEv3BVIy
 oLyRS6NVS3QU61PgZ+mDlJNytjD//b4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-350-zvkhakUoP0qMG8MiR--QtQ-1; Tue, 21 Jan 2020 07:33:02 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CF0DD8017CC;
 Tue, 21 Jan 2020 12:33:01 +0000 (UTC)
Received: from dgilbert-t580.localhost (unknown [10.36.118.32])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B8EDC60BE0;
 Tue, 21 Jan 2020 12:32:59 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
To: qemu-devel@nongnu.org, stefanha@redhat.com, vgoyal@redhat.com,
 berrange@redhat.com, slp@redhat.com, philmd@redhat.com
Subject: [PATCH v2 107/109] virtiofsd/passthrough_ll: Pass errno to
 fuse_reply_err()
Date: Tue, 21 Jan 2020 12:24:31 +0000
Message-Id: <20200121122433.50803-108-dgilbert@redhat.com>
In-Reply-To: <20200121122433.50803-1-dgilbert@redhat.com>
References: <20200121122433.50803-1-dgilbert@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: zvkhakUoP0qMG8MiR--QtQ-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
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
Cc: m.mizuma@jp.fujitsu.com, misono.tomohiro@jp.fujitsu.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Xiao Yang <yangx.jy@cn.fujitsu.com>

lo_copy_file_range() passes -errno to fuse_reply_err() and then fuse_reply_=
err()
changes it to errno again, so that subsequent fuse_send_reply_iov_nofree() =
catches
the wrong errno.(i.e. reports "fuse: bad error value: ...").

Make fuse_send_reply_iov_nofree() accept the correct -errno by passing errn=
o
directly in lo_copy_file_range().

Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
Reviewed-by: Eryu Guan <eguan@linux.alibaba.com>

dgilbert: Sent upstream and now Merged as aa1185e153f774f1df65
---
 tools/virtiofsd/passthrough_ll.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/virtiofsd/passthrough_ll.c b/tools/virtiofsd/passthrough=
_ll.c
index 3c450c15b4..0666a8709d 100644
--- a/tools/virtiofsd/passthrough_ll.c
+++ b/tools/virtiofsd/passthrough_ll.c
@@ -2441,7 +2441,7 @@ static void lo_copy_file_range(fuse_req_t req, fuse_i=
no_t ino_in, off_t off_in,
=20
     res =3D copy_file_range(in_fd, &off_in, out_fd, &off_out, len, flags);
     if (res < 0) {
-        fuse_reply_err(req, -errno);
+        fuse_reply_err(req, errno);
     } else {
         fuse_reply_write(req, res);
     }
--=20
2.24.1


