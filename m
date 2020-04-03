Return-Path: <SRS0=URa6=5T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7679C2BA12
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Apr 2020 16:59:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A5886207FF
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Apr 2020 16:59:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="Zkzz8yuu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A5886207FF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58454 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jKPf9-0007KT-Kn
	for qemu-devel@archiver.kernel.org; Fri, 03 Apr 2020 12:59:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41992)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berto@igalia.com>) id 1jKPeH-0006dV-FO
 for qemu-devel@nongnu.org; Fri, 03 Apr 2020 12:58:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berto@igalia.com>) id 1jKPeE-0008Gt-H5
 for qemu-devel@nongnu.org; Fri, 03 Apr 2020 12:58:29 -0400
Received: from fanzine.igalia.com ([178.60.130.6]:57827)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <berto@igalia.com>)
 id 1jKPeD-000820-TS; Fri, 03 Apr 2020 12:58:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
 s=20170329; 
 h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:From;
 bh=NalIz72VH/2OkZ371CIWC2g6KS+Aj0H1cCbFcmGllPg=; 
 b=Zkzz8yuuVUJyxA/wYxLDfMv/4TxM6IRdAsYv7ldBbCj7yjyoWajn8ymroGUa8nzE/wiYTEDUgiXEpoWEXTS8wvRtO4vyxmV28a8xtAKKNypu3OInqR8qquPhNyfAgGUGL8Xr+X7VRd6OrVSv2EIsVknD9dPYvRaEtHNjuObW85c0pwHqxOyGTgfkMVhNAY3L6DfvoR37KkgXfquzU/DlXi6ha4AItpfHua3SIHvmYfKKc+H05Vu16vbok/vQa8zh+xqULqelXR3MOu0f+sNLfwDrdtjuMbJ4xfn0OQdoKi6Nf4IL7pYzwBrAdzE27nCm0OoSF/b8RY/zBJ53AqVB0A==;
Received: from [81.0.35.113] (helo=perseus.local)
 by fanzine.igalia.com with esmtpsa 
 (Cipher TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim)
 id 1jKPdv-0002GT-73; Fri, 03 Apr 2020 18:58:07 +0200
Received: from berto by perseus.local with local (Exim 4.92)
 (envelope-from <berto@igalia.com>)
 id 1jKPdh-0004hD-JC; Fri, 03 Apr 2020 18:57:53 +0200
From: Alberto Garcia <berto@igalia.com>
To: qemu-devel@nongnu.org
Subject: [PATCH for-5.0] qcow2: Check request size in
 qcow2_co_pwritev_compressed_part()
Date: Fri,  3 Apr 2020 18:57:52 +0200
Message-Id: <20200403165752.18009-1-berto@igalia.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x (no
 timestamps) [generic] [fuzzy]
X-Received-From: 178.60.130.6
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 Alberto Garcia <berto@igalia.com>, qemu-block@nongnu.org,
 Pavel Butsykin <pbutsykin@virtuozzo.com>, Max Reitz <mreitz@redhat.com>,
 Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

When issuing a compressed write request the number of bytes must be a
multiple of the cluster size.

With the current code such requests are allowed and we hit an
assertion:

   $ qemu-img create -f qcow2 img.qcow2 1M
   $ qemu-io -c 'write -c 0 32k' img.qcow2

   qemu-io: block/qcow2.c:4257: qcow2_co_pwritev_compressed_task:
   Assertion `bytes == s->cluster_size || (bytes < s->cluster_size &&
              (offset + bytes == bs->total_sectors << BDRV_SECTOR_BITS))' failed.
   Aborted

This patch fixes a regression introduced in 0d483dce38

Signed-off-by: Alberto Garcia <berto@igalia.com>
---
 block/qcow2.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/qcow2.c b/block/qcow2.c
index 2bb536b014..923ad428f0 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -4345,7 +4345,7 @@ qcow2_co_pwritev_compressed_part(BlockDriverState *bs,
         return bdrv_co_truncate(bs->file, len, false, PREALLOC_MODE_OFF, NULL);
     }
 
-    if (offset_into_cluster(s, offset)) {
+    if (offset_into_cluster(s, offset | bytes)) {
         return -EINVAL;
     }
 
-- 
2.20.1


