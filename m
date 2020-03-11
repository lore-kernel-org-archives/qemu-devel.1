Return-Path: <SRS0=QLzr=44=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01380C10F27
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2020 14:04:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C0C2820873
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2020 14:04:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GtmvrMKo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C0C2820873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52752 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jC1xn-0000ty-Q5
	for qemu-devel@archiver.kernel.org; Wed, 11 Mar 2020 10:03:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36338)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1jC1n2-0004Gt-Vz
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 09:52:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1jC1n0-0002eR-FQ
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 09:52:52 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:32264
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1jC1n0-0002dM-BP
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 09:52:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583934770;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tRN4EUcrPRh8eKR7KMfsL9d2OqQY+/CgfGBxmUQmmhY=;
 b=GtmvrMKoOH5oLPQm7bKgcdr5oY6DYnCmiKB4WAOPVD6/WWTBxyVX8SP8CU9tJMj2ZvLQsK
 lZV7tiNVKdI6tVHqPe6GRyoNFUaRN7ckhPSeZanmKf1mn3s02fmanAniV3i6w5GdUCGE9v
 6aSB5IUwdVSiFY4fN0SKBmsIuo6CeTg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-473-LqRdiAoZO6q70Pzrladl_Q-1; Wed, 11 Mar 2020 09:52:47 -0400
X-MC-Unique: LqRdiAoZO6q70Pzrladl_Q-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B616B8017CC;
 Wed, 11 Mar 2020 13:52:46 +0000 (UTC)
Received: from localhost (ovpn-117-216.ams2.redhat.com [10.36.117.216])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 5348C60C99;
 Wed, 11 Mar 2020 13:52:45 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PULL 10/19] block/qcow2-threads: fix qcow2_decompress
Date: Wed, 11 Mar 2020 14:52:04 +0100
Message-Id: <20200311135213.1242028-11-mreitz@redhat.com>
In-Reply-To: <20200311135213.1242028-1-mreitz@redhat.com>
References: <20200311135213.1242028-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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

From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

On success path we return what inflate() returns instead of 0. And it
most probably works for Z_STREAM_END as it is positive, but is
definitely broken for Z_BUF_ERROR.

While being here, switch to errno return code, to be closer to
qcow2_compress API (and usual expectations).

Revert condition in if to be more positive. Drop dead initialization of
ret.

Cc: qemu-stable@nongnu.org # v4.0
Fixes: 341926ab83e2b
Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-Id: <20200302150930.16218-1-vsementsov@virtuozzo.com>
Reviewed-by: Alberto Garcia <berto@igalia.com>
Reviewed-by: J=C3=A1n Tomko <jtomko@redhat.com>
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 block/qcow2-threads.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/block/qcow2-threads.c b/block/qcow2-threads.c
index 77bb578cdf..a68126f291 100644
--- a/block/qcow2-threads.c
+++ b/block/qcow2-threads.c
@@ -128,12 +128,12 @@ static ssize_t qcow2_compress(void *dest, size_t dest=
_size,
  * @src - source buffer, @src_size bytes
  *
  * Returns: 0 on success
- *          -1 on fail
+ *          -EIO on fail
  */
 static ssize_t qcow2_decompress(void *dest, size_t dest_size,
                                 const void *src, size_t src_size)
 {
-    int ret =3D 0;
+    int ret;
     z_stream strm;
=20
     memset(&strm, 0, sizeof(strm));
@@ -144,17 +144,19 @@ static ssize_t qcow2_decompress(void *dest, size_t de=
st_size,
=20
     ret =3D inflateInit2(&strm, -12);
     if (ret !=3D Z_OK) {
-        return -1;
+        return -EIO;
     }
=20
     ret =3D inflate(&strm, Z_FINISH);
-    if ((ret !=3D Z_STREAM_END && ret !=3D Z_BUF_ERROR) || strm.avail_out =
!=3D 0) {
+    if ((ret =3D=3D Z_STREAM_END || ret =3D=3D Z_BUF_ERROR) && strm.avail_=
out =3D=3D 0) {
         /*
          * We approve Z_BUF_ERROR because we need @dest buffer to be fille=
d, but
          * @src buffer may be processed partly (because in qcow2 we know s=
ize of
          * compressed data with precision of one sector)
          */
-        ret =3D -1;
+        ret =3D 0;
+    } else {
+        ret =3D -EIO;
     }
=20
     inflateEnd(&strm);
--=20
2.24.1


