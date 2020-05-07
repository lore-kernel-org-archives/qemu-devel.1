Return-Path: <SRS0=s5cl=6V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 643B8C4724C
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2020 12:03:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2D8502073A
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2020 12:03:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NqZQkYSX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D8502073A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44676 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jWfFU-0002Xr-5q
	for qemu-devel@archiver.kernel.org; Thu, 07 May 2020 08:03:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37264)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1jWfAU-0006Og-9v
 for qemu-devel@nongnu.org; Thu, 07 May 2020 07:58:22 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:56592
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1jWfAT-00010T-9o
 for qemu-devel@nongnu.org; Thu, 07 May 2020 07:58:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588852700;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cnNQxNLTG/MaX3sowSlZFtncWas/A5GCzE/ggA+m9dY=;
 b=NqZQkYSXEXHz5VfHt/Ao8swzYslKwZweZStWaNHQhUbqzNHv1UjGOkwCjoYgz1Pj/y8ZyO
 OKuvU2RMnJ1J5pG4wwvtz+ArDv10GJBCVN07zLSszysaneCXScouxafVB06f255bjes23L
 cez0WdlPYC/Ovge6QokpMeXnO98hjUQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-182-H6U4Sve5NBOKm5W_JBFdwA-1; Thu, 07 May 2020 07:58:17 -0400
X-MC-Unique: H6U4Sve5NBOKm5W_JBFdwA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B6D5D18FE864;
 Thu,  7 May 2020 11:58:16 +0000 (UTC)
Received: from localhost.localdomain.com (unknown [10.36.110.63])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3FCAD62A42;
 Thu,  7 May 2020 11:58:14 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 4/5] block: luks: better error message when creating too large
 files
Date: Thu,  7 May 2020 12:58:02 +0100
Message-Id: <20200507115803.1122661-5-berrange@redhat.com>
In-Reply-To: <20200507115803.1122661-1-berrange@redhat.com>
References: <20200507115803.1122661-1-berrange@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.61; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/07 02:00:54
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: Kevin Wolf <kwolf@redhat.com>, Maxim Levitsky <mlevitsk@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Maxim Levitsky <mlevitsk@redhat.com>

Currently if you attampt to create too large file with luks you
get the following error message:

Formatting 'test.luks', fmt=3Dluks size=3D17592186044416 key-secret=3Dsec0
qemu-img: test.luks: Could not resize file: File too large

While for raw format the error message is
qemu-img: test.img: The image size is too large for file format 'raw'

The reason for this is that qemu-img checks for errono of the failure,
and presents the later error when it is -EFBIG

However crypto generic code 'swallows' the errno and replaces it
with -EIO.

As an attempt to make it better, we can make luks driver,
detect -EFBIG and in this case present a better error message,
which is what this patch does

The new error message is:

qemu-img: error creating test.luks: The requested file size is too large

Fixes: https://bugzilla.redhat.com/show_bug.cgi?id=3D1534898
Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
---
 block/crypto.c | 25 +++++++++++++++++++++----
 1 file changed, 21 insertions(+), 4 deletions(-)

diff --git a/block/crypto.c b/block/crypto.c
index ca44dae4f7..6b21d6bf6c 100644
--- a/block/crypto.c
+++ b/block/crypto.c
@@ -104,18 +104,35 @@ static ssize_t block_crypto_init_func(QCryptoBlock *b=
lock,
                                       Error **errp)
 {
     struct BlockCryptoCreateData *data =3D opaque;
+    Error *local_error =3D NULL;
+    int ret;
=20
     if (data->size > INT64_MAX || headerlen > INT64_MAX - data->size) {
-        error_setg(errp, "The requested file size is too large");
-        return -EFBIG;
+        ret =3D -EFBIG;
+        goto error;
     }
=20
     /* User provided size should reflect amount of space made
      * available to the guest, so we must take account of that
      * which will be used by the crypto header
      */
-    return blk_truncate(data->blk, data->size + headerlen, false,
-                        data->prealloc, 0, errp);
+    ret =3D blk_truncate(data->blk, data->size + headerlen, false,
+                       data->prealloc, 0, &local_error);
+
+    if (ret >=3D 0) {
+        return ret;
+    }
+
+error:
+    if (ret =3D=3D -EFBIG) {
+        /* Replace the error message with a better one */
+        error_free(local_error);
+        error_setg(errp, "The requested file size is too large");
+    } else {
+        error_propagate(errp, local_error);
+    }
+
+    return ret;
 }
=20
=20
--=20
2.26.2


