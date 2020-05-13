Return-Path: <SRS0=Qw6D=63=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D2F8CA90AF
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2020 11:14:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 18530206E5
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2020 11:14:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GFQJvr2P"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 18530206E5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46852 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYpLe-0007Jm-4H
	for qemu-devel@archiver.kernel.org; Wed, 13 May 2020 07:14:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54790)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1jYpDf-0001wq-3k
 for qemu-devel@nongnu.org; Wed, 13 May 2020 07:06:35 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:32180
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1jYpDb-0003SC-Qt
 for qemu-devel@nongnu.org; Wed, 13 May 2020 07:06:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589367991;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RiV9t/X8/SNjNTwj/WuRxvvE7Tt61roe1Wlhx94cUPg=;
 b=GFQJvr2PLR9rgLxauXID7YJfKptq/sqSZ+SfhvoPwG/9SvCaS1/ar+kPpInM6ZZhwsqRPX
 RuNJYraJGDCUfo2f67qcl8eW1nI+AkSf6TRDwwfXmJPUZWNtiDqmBeQLWUqKzplIs1vi/1
 DYOysdJG+ve7g1rhwEti7FYuujYGQoo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-129-CGmRhL4bO02EXgw8TaF2Zg-1; Wed, 13 May 2020 07:06:28 -0400
X-MC-Unique: CGmRhL4bO02EXgw8TaF2Zg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E8E7739348;
 Wed, 13 May 2020 11:06:27 +0000 (UTC)
Received: from localhost (unknown [10.40.193.218])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 81BEF5D9C5;
 Wed, 13 May 2020 11:06:27 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH v4 15/34] block: Distinguish paths in *_format_default_perms
Date: Wed, 13 May 2020 13:05:25 +0200
Message-Id: <20200513110544.176672-16-mreitz@redhat.com>
In-Reply-To: <20200513110544.176672-1-mreitz@redhat.com>
References: <20200513110544.176672-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=mreitz@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/13 04:17:42
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

bdrv_format_default_perms() has one code path for backing files, and one
for storage files.  We want to pull them out into own functions, so
make sure they are completely distinct before so the next patches will
be a bit cleaner.

Signed-off-by: Max Reitz <mreitz@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 block.c | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/block.c b/block.c
index be9bfa9d46..b3e7ae70c7 100644
--- a/block.c
+++ b/block.c
@@ -2497,6 +2497,13 @@ void bdrv_format_default_perms(BlockDriverState *bs, BdrvChild *c,
             perm |= BLK_PERM_CONSISTENT_READ;
         }
         shared &= ~(BLK_PERM_WRITE | BLK_PERM_RESIZE);
+
+        if (bs->open_flags & BDRV_O_INACTIVE) {
+            shared |= BLK_PERM_WRITE | BLK_PERM_RESIZE;
+        }
+
+        *nperm = perm;
+        *nshared = shared;
     } else {
         /* We want consistent read from backing files if the parent needs it.
          * No other operations are performed on backing files. */
@@ -2513,14 +2520,14 @@ void bdrv_format_default_perms(BlockDriverState *bs, BdrvChild *c,
 
         shared |= BLK_PERM_CONSISTENT_READ | BLK_PERM_GRAPH_MOD |
                   BLK_PERM_WRITE_UNCHANGED;
-    }
 
-    if (bs->open_flags & BDRV_O_INACTIVE) {
-        shared |= BLK_PERM_WRITE | BLK_PERM_RESIZE;
-    }
+        if (bs->open_flags & BDRV_O_INACTIVE) {
+            shared |= BLK_PERM_WRITE | BLK_PERM_RESIZE;
+        }
 
-    *nperm = perm;
-    *nshared = shared;
+        *nperm = perm;
+        *nshared = shared;
+    }
 }
 
 uint64_t bdrv_qapi_perm_to_blk_perm(BlockPermission qapi_perm)
-- 
2.26.2


