Return-Path: <SRS0=L+nc=BH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9A49C433E3
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2020 12:09:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 75ECC2065E
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2020 12:09:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ntcpcv18"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 75ECC2065E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45476 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k0OQ2-0008Jm-MK
	for qemu-devel@archiver.kernel.org; Tue, 28 Jul 2020 08:09:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48118)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1k0OP9-0006z3-KA
 for qemu-devel@nongnu.org; Tue, 28 Jul 2020 08:08:23 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:60565
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1k0OP8-0006YC-2i
 for qemu-devel@nongnu.org; Tue, 28 Jul 2020 08:08:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595938101;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GkFU7XQqzErmywaN2FDrnnVSpqyXImZjhBFs9rCnQGE=;
 b=Ntcpcv18+UgY6NbNIVCT3tFfvMgzZbDKWp2JBPsOs83E4T7uLM6J8zv/Gj0BHXksWFa8eL
 3JzE9AHh8Qw8N82wPDQhzRfxr6+s5BN22XgmvHAbXtkI/fjbQN7Wqr1dcsAndyHNgKrnqi
 1Z2Ft4FhBRoOEEiZLyn+Os662ZoRvxs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-81-_V5vf65VNLCRwVfwxvavEQ-1; Tue, 28 Jul 2020 08:08:17 -0400
X-MC-Unique: _V5vf65VNLCRwVfwxvavEQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 320F11005504;
 Tue, 28 Jul 2020 12:08:16 +0000 (UTC)
Received: from localhost (ovpn-112-145.ams2.redhat.com [10.36.112.145])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E32AB712EC;
 Tue, 28 Jul 2020 12:08:12 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH for-5.1 1/2] block: Fix bdrv_aligned_p*v() for qiov_offset != 0
Date: Tue, 28 Jul 2020 14:08:04 +0200
Message-Id: <20200728120806.265916-2-mreitz@redhat.com>
In-Reply-To: <20200728120806.265916-1-mreitz@redhat.com>
References: <20200728120806.265916-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mreitz@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=mreitz@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/27 23:55:28
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Kevin Wolf <kwolf@redhat.com>, Bruce Rogers <brogers@suse.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-stable@nongnu.org, qemu-devel@nongnu.org,
 Claudio Fontana <cfontana@suse.de>, Stefan Hajnoczi <stefanha@redhat.com>,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Since these functions take a @qiov_offset, they must always take it into
account when working with @qiov.  There are a couple of places where
they do not, but they should.

Fixes: 65cd4424b9df03bb5195351c33e04cbbecc0705c
Fixes: 28c4da28695bdbe04b336b2c9c463876cc3aaa6d
Reported-by: Claudio Fontana <cfontana@suse.de>
Reported-by: Bruce Rogers <brogers@suse.com>
Cc: qemu-stable@nongnu.org
Signed-off-by: Max Reitz <mreitz@redhat.com>
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


