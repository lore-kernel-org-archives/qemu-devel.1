Return-Path: <SRS0=L+nc=BH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46C49C433E5
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2020 13:50:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 085C72075D
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2020 13:50:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NDJ5uhAq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 085C72075D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37908 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k0PzX-0001Rt-7n
	for qemu-devel@archiver.kernel.org; Tue, 28 Jul 2020 09:50:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47932)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1k0PyP-0008CS-UG
 for qemu-devel@nongnu.org; Tue, 28 Jul 2020 09:48:53 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:60187
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1k0PyN-0003tE-Fg
 for qemu-devel@nongnu.org; Tue, 28 Jul 2020 09:48:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595944130;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZWcaw+9QYRJWq7c/S4sft0iQIOuruhTzciGwRrLdre0=;
 b=NDJ5uhAq8K9il8UsD41kyGOgiyHjx192PhnBD9TzVASJFjUh8/rs6G64agwknUMnbNYZzd
 Y73mbmGIwISlr+mZAbMLfxwdxAr8lA8QT/00PlowahhSYclzMR/wJEqZnR9pKDfcEzyIeT
 i5bsv/XHYWOOLcmjavGNzS9kFsaYUOg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-474-k5IvCq7lMFezzJLTcMjR9A-1; Tue, 28 Jul 2020 09:48:48 -0400
X-MC-Unique: k5IvCq7lMFezzJLTcMjR9A-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6894E79EC0;
 Tue, 28 Jul 2020 13:48:44 +0000 (UTC)
Received: from localhost (ovpn-112-145.ams2.redhat.com [10.36.112.145])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 0367A5D9CD;
 Tue, 28 Jul 2020 13:48:43 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PULL 1/3] block: Fix bdrv_aligned_p*v() for qiov_offset != 0
Date: Tue, 28 Jul 2020 15:48:38 +0200
Message-Id: <20200728134840.1557546-2-mreitz@redhat.com>
In-Reply-To: <20200728134840.1557546-1-mreitz@redhat.com>
References: <20200728134840.1557546-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=mreitz@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/28 06:02:02
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Since these functions take a @qiov_offset, they must always take it into
account when working with @qiov.  There are a couple of places where
they do not, but they should.

Fixes: 65cd4424b9df03bb5195351c33e04cbbecc0705c
       ("block/io: bdrv_aligned_preadv: use and support qiov_offset")
Fixes: 28c4da28695bdbe04b336b2c9c463876cc3aaa6d
       ("block/io: bdrv_aligned_pwritev: use and support qiov_offset")
Reported-by: Claudio Fontana <cfontana@suse.de>
Reported-by: Bruce Rogers <brogers@suse.com>
Cc: qemu-stable@nongnu.org
Signed-off-by: Max Reitz <mreitz@redhat.com>
Message-Id: <20200728120806.265916-2-mreitz@redhat.com>
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Tested-by: Claudio Fontana <cfontana@suse.de>
Tested-by: Bruce Rogers <brogers@suse.com>
---
 block/io.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/block/io.c b/block/io.c
index b6564e34c5..ad3a51ed53 100644
--- a/block/io.c
+++ b/block/io.c
@@ -1524,12 +1524,13 @@ static int coroutine_fn bdrv_aligned_preadv(BdrvChild *child,
             assert(num);
 
             ret = bdrv_driver_preadv(bs, offset + bytes - bytes_remaining,
-                                     num, qiov, bytes - bytes_remaining, 0);
+                                     num, qiov,
+                                     qiov_offset + bytes - bytes_remaining, 0);
             max_bytes -= num;
         } else {
             num = bytes_remaining;
-            ret = qemu_iovec_memset(qiov, bytes - bytes_remaining, 0,
-                                    bytes_remaining);
+            ret = qemu_iovec_memset(qiov, qiov_offset + bytes - bytes_remaining,
+                                    0, bytes_remaining);
         }
         if (ret < 0) {
             goto out;
@@ -2032,7 +2033,8 @@ static int coroutine_fn bdrv_aligned_pwritev(BdrvChild *child,
             }
 
             ret = bdrv_driver_pwritev(bs, offset + bytes - bytes_remaining,
-                                      num, qiov, bytes - bytes_remaining,
+                                      num, qiov,
+                                      qiov_offset + bytes - bytes_remaining,
                                       local_flags);
             if (ret < 0) {
                 break;
-- 
2.26.2


