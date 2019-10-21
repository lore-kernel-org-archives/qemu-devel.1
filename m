Return-Path: <SRS0=8ZcK=YO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 234A6CA9EAF
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2019 11:25:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E1E1B2089C
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2019 11:25:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Vxel41EF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1E1B2089C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38250 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iMVos-0006Yb-2a
	for qemu-devel@archiver.kernel.org; Mon, 21 Oct 2019 07:25:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46385)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1iMVPp-0003YF-PU
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 06:59:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1iMVPo-0003vR-Oa
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 06:59:57 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:53054
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1iMVPo-0003vI-K3
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 06:59:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1571655596;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UIS6TS+ggxWVAEjL01jbX6O+YpQZCzADmmL29vkj6uc=;
 b=Vxel41EFsiqvkwX7vNG0jr1QIVJuFSwgtUR4uFH3IBZRsdvMu/0/cFS8+1vkL9AsmMt9QG
 oSJDZSkZf5GI4PZmC/nOR8SDC0ueJ636Fb5XLeAILU+CoMm1YmMOjhFdHI6xTfnCe9IbzL
 8F8Fn3rhQYkgIoUpdRmUq5kTgHf4VO4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-326-R1-ZKHHqNlCY-28snGzQgg-1; Mon, 21 Oct 2019 06:59:52 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6461F800D41;
 Mon, 21 Oct 2019 10:59:51 +0000 (UTC)
Received: from dgilbert-t580.localhost (ovpn-117-232.ams2.redhat.com
 [10.36.117.232])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B6C56614C1;
 Mon, 21 Oct 2019 10:59:42 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
To: qemu-devel@nongnu.org, mst@redhat.com, marcandre.lureau@redhat.com,
 stefanha@redhat.com
Subject: [PATCH 11/30] virtiofsd: fuse: Make iov_length usable outside
 fuse_lowlevel.c
Date: Mon, 21 Oct 2019 11:58:13 +0100
Message-Id: <20191021105832.36574-12-dgilbert@redhat.com>
In-Reply-To: <20191021105832.36574-1-dgilbert@redhat.com>
References: <20191021105832.36574-1-dgilbert@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: R1-ZKHHqNlCY-28snGzQgg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
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
Cc: piaojun@huawei.com, eguan@linux.alibaba.com, vgoyal@Redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 contrib/virtiofsd/fuse_lowlevel.c | 2 +-
 contrib/virtiofsd/fuse_lowlevel.h | 9 +++++++++
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/contrib/virtiofsd/fuse_lowlevel.c b/contrib/virtiofsd/fuse_low=
level.c
index 5ea113ab49..ff68ec0c9d 100644
--- a/contrib/virtiofsd/fuse_lowlevel.c
+++ b/contrib/virtiofsd/fuse_lowlevel.c
@@ -74,7 +74,7 @@ static void convert_attr(const struct fuse_setattr_in *at=
tr, struct stat *stbuf)
 =09ST_CTIM_NSEC_SET(stbuf, attr->ctimensec);
 }
=20
-static=09size_t iov_length(const struct iovec *iov, size_t count)
+size_t iov_length(const struct iovec *iov, size_t count)
 {
 =09size_t seg;
 =09size_t ret =3D 0;
diff --git a/contrib/virtiofsd/fuse_lowlevel.h b/contrib/virtiofsd/fuse_low=
level.h
index 018e7c0be0..84379a4761 100644
--- a/contrib/virtiofsd/fuse_lowlevel.h
+++ b/contrib/virtiofsd/fuse_lowlevel.h
@@ -2000,6 +2000,15 @@ void fuse_session_process_buf(struct fuse_session *s=
e,
  */
 int fuse_session_receive_buf(struct fuse_session *se, struct fuse_buf *buf=
);
=20
+/**
+ * General utility to get the length of an iov, not Fuse specific
+ *
+ * @param iov The iovec to get the length of
+ * @param count Number of entries in the iovec
+ * @return the total length of iov in bytes
+ */
+size_t iov_length(const struct iovec *iov, size_t count);
+
 #ifdef __cplusplus
 }
 #endif
--=20
2.23.0


