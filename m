Return-Path: <SRS0=mO9Z=3M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28069C2D0DB
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 14:32:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E8BB52087E
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 14:32:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aI1Gg1az"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E8BB52087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58114 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iudX7-0002Ys-Qd
	for qemu-devel@archiver.kernel.org; Thu, 23 Jan 2020 09:32:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41824)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1iubAq-0004L6-Ci
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 07:01:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1iubAp-0006kn-B9
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 07:01:24 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:29441
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1iubAp-0006kG-68
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 07:01:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579780882;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2dozJRlZa0dl3m3ruapIUDG11IbtPuiqyFeJ966CdXs=;
 b=aI1Gg1az+cVkZ1/Q3EM2oGxMX70eL+NpaSLMrP+CfFfOUfTfisSVCo7T4ZmBIGefh2YuSw
 E3DgVe41cfhJEH8q4WC5jk5k8u9o1Wkl+pT0IPlY/XShtNs+WjdUdhjFk5enxUVZJjXnJA
 o95Ra+V1wOQspUPsP9EPoQfo/xND3bE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-352-IZsJPS7cPZudnKO5cpqoqw-1; Thu, 23 Jan 2020 07:01:21 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2B4C91005F68
 for <qemu-devel@nongnu.org>; Thu, 23 Jan 2020 12:01:20 +0000 (UTC)
Received: from dgilbert-t580.localhost (unknown [10.36.118.0])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 71A8D85754;
 Thu, 23 Jan 2020 12:01:19 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
To: qemu-devel@nongnu.org,
	stefanha@redhat.com
Subject: [PULL 109/111] virtiofsd/passthrough_ll: Pass errno to
 fuse_reply_err()
Date: Thu, 23 Jan 2020 11:58:39 +0000
Message-Id: <20200123115841.138849-110-dgilbert@redhat.com>
In-Reply-To: <20200123115841.138849-1-dgilbert@redhat.com>
References: <20200123115841.138849-1-dgilbert@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: IZsJPS7cPZudnKO5cpqoqw-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 tools/virtiofsd/passthrough_ll.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/virtiofsd/passthrough_ll.c b/tools/virtiofsd/passthrough=
_ll.c
index fc15d61510..e6f2399efc 100644
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


