Return-Path: <SRS0=xsRN=VS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB0F8C76195
	for <qemu-devel@archiver.kernel.org>; Sun, 21 Jul 2019 18:15:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8BC82206BF
	for <qemu-devel@archiver.kernel.org>; Sun, 21 Jul 2019 18:15:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8BC82206BF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57198 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hpGND-0004KB-9D
	for qemu-devel@archiver.kernel.org; Sun, 21 Jul 2019 14:15:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34706)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mlevitsk@redhat.com>) id 1hpGMh-0002w8-Nw
 for qemu-devel@nongnu.org; Sun, 21 Jul 2019 14:15:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mlevitsk@redhat.com>) id 1hpGMg-0001T5-Jw
 for qemu-devel@nongnu.org; Sun, 21 Jul 2019 14:15:19 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54242)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mlevitsk@redhat.com>)
 id 1hpGMe-0001RD-8L; Sun, 21 Jul 2019 14:15:16 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 84EAF3082DDD;
 Sun, 21 Jul 2019 18:15:15 +0000 (UTC)
Received: from maximlenovopc.usersys.redhat.com (unknown [10.35.206.70])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7CAFA1017E3F;
 Sun, 21 Jul 2019 18:15:13 +0000 (UTC)
From: Maxim Levitsky <mlevitsk@redhat.com>
To: qemu-devel@nongnu.org
Date: Sun, 21 Jul 2019 21:15:07 +0300
Message-Id: <20190721181508.28608-2-mlevitsk@redhat.com>
In-Reply-To: <20190721181508.28608-1-mlevitsk@redhat.com>
References: <20190721181508.28608-1-mlevitsk@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.46]); Sun, 21 Jul 2019 18:15:15 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH 1/2] LUKS: better error message when creating
 too large files
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 qemu-trivial@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>,
 Laurent Vivier <laurent@vivier.eu>, Max Reitz <mreitz@redhat.com>,
 Maxim Levitsky <mlevitsk@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Currently if you attampt to create too large file with luks you
get the following error message:

Formatting 'test.luks', fmt=luks size=17592186044416 key-secret=sec0
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

Fixes: https://bugzilla.redhat.com/show_bug.cgi?id=1534898
Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
---
 block/crypto.c | 25 +++++++++++++++++++++----
 1 file changed, 21 insertions(+), 4 deletions(-)

diff --git a/block/crypto.c b/block/crypto.c
index 8237424ae6..73b1013fa1 100644
--- a/block/crypto.c
+++ b/block/crypto.c
@@ -102,18 +102,35 @@ static ssize_t block_crypto_init_func(QCryptoBlock *block,
                                       Error **errp)
 {
     struct BlockCryptoCreateData *data = opaque;
+    Error *local_error = NULL;
+    int ret;
 
     if (data->size > INT64_MAX || headerlen > INT64_MAX - data->size) {
-        error_setg(errp, "The requested file size is too large");
-        return -EFBIG;
+        ret = -EFBIG;
+        goto error;
     }
 
     /* User provided size should reflect amount of space made
      * available to the guest, so we must take account of that
      * which will be used by the crypto header
      */
-    return blk_truncate(data->blk, data->size + headerlen, PREALLOC_MODE_OFF,
-                        errp);
+    ret = blk_truncate(data->blk, data->size + headerlen, PREALLOC_MODE_OFF,
+                       &local_error);
+
+    if (ret >= 0) {
+        return ret;
+    }
+
+error:
+    if (ret == -EFBIG) {
+        /* Replace the error message with a better one */
+        error_free(local_error);
+        error_setg(errp, "The requested file size is too large");
+    } else {
+        error_propagate(errp, local_error);
+    }
+
+    return ret;
 }
 
 
-- 
2.17.2


