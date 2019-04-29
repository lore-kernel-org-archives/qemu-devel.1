Return-Path: <SRS0=sEuR=S7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E8B4C43219
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2019 18:47:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E690E205ED
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2019 18:47:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="rUGhH5aB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E690E205ED
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:33759 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hLBJB-0006Oa-8h
	for qemu-devel@archiver.kernel.org; Mon, 29 Apr 2019 14:47:21 -0400
Received: from eggs.gnu.org ([209.51.188.92]:56762)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1hLBF1-0003Hc-Om
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 14:43:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1hLBF0-0002Qa-QX
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 14:43:03 -0400
Received: from fanzine.igalia.com ([91.117.99.155]:54751)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <berto@igalia.com>)
	id 1hLBF0-0002Pa-8l; Mon, 29 Apr 2019 14:43:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; 
	h=References:In-Reply-To:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From;
	bh=qPSLlGkl+4wX47R8brHXCYj560PZNri44VYQ96nZux4=; 
	b=rUGhH5aBf1WaCUoEjvQwM0uDYSFgpkM08IKZOXSwlq3/teR/c032IDFtKxrQ6Ax8/5alASLtcZlMh/itWU5CYTgx/nj3stQq9Q5WoPb4AG+r2vbrf23VNGvGpexxoGX9olSgJIA/XbCH1E+Woio/Y29Z95vq8Z/bMxDu4qd00lj/WnYbfEW+rbRj5vzmYSr769Rg96S2YGoOiomzHGDEAn4rGRFQWWey1BpkVaPp5tW59tNOWSkxwFQy/3gGRs2WbxMlLZZhGcIk2DLnY9xGI4FpR9+0ziD4f5XnzrZZ1qaXyjZKyVjhxn+VKWcMpisFKcggkkgsQGCacALdTdBZbg==;
Received: from static-191-95-145-212.ipcom.comunitel.net ([212.145.95.191]
	helo=perseus.local) by fanzine.igalia.com with esmtpsa 
	(Cipher TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim)
	id 1hLBEx-0006XG-Jk; Mon, 29 Apr 2019 20:42:59 +0200
Received: from berto by perseus.local with local (Exim 4.89)
	(envelope-from <berto@igalia.com>)
	id 1hLBEl-0002ZN-3P; Mon, 29 Apr 2019 21:42:47 +0300
From: Alberto Garcia <berto@igalia.com>
To: qemu-devel@nongnu.org
Date: Mon, 29 Apr 2019 20:42:37 +0200
Message-Id:
 <e5e1571c583874454760dc738ef3ea3470ea96e7.1556562150.git.berto@igalia.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <cover.1556562150.git.berto@igalia.com>
References: <cover.1556562150.git.berto@igalia.com>
In-Reply-To: <cover.1556562150.git.berto@igalia.com>
References: <cover.1556562150.git.berto@igalia.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x (no
	timestamps) [generic] [fuzzy]
X-Received-From: 91.117.99.155
Subject: [Qemu-devel] [PATCH 2/5] vdi: Replace bdrv_{read,
 write}() with bdrv_{pread, pwrite}()
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Kevin Wolf <kwolf@redhat.com>, Alberto Garcia <berto@igalia.com>,
	qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190429184237.jXrtdx9fBzpxUY4V6OyU59_qVSC0T8CoFwU_BhOlMb0@z>

There's only a couple of bdrv_read() and bdrv_write() calls left in
the vdi code, and they can be trivially replaced with the byte-based
bdrv_pread() and bdrv_pwrite().

Signed-off-by: Alberto Garcia <berto@igalia.com>
---
 block/vdi.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/block/vdi.c b/block/vdi.c
index e1c42ad732..8d849b2754 100644
--- a/block/vdi.c
+++ b/block/vdi.c
@@ -384,7 +384,7 @@ static int vdi_open(BlockDriverState *bs, QDict *options, int flags,
 
     logout("\n");
 
-    ret = bdrv_read(bs->file, 0, (uint8_t *)&header, 1);
+    ret = bdrv_pread(bs->file, 0, (uint8_t *)&header, sizeof(header));
     if (ret < 0) {
         goto fail;
     }
@@ -484,8 +484,8 @@ static int vdi_open(BlockDriverState *bs, QDict *options, int flags,
         goto fail;
     }
 
-    ret = bdrv_read(bs->file, s->bmap_sector, (uint8_t *)s->bmap,
-                    bmap_size);
+    ret = bdrv_pread(bs->file, header.offset_bmap, (uint8_t *)s->bmap,
+                     bmap_size * SECTOR_SIZE);
     if (ret < 0) {
         goto fail_free_bmap;
     }
@@ -704,7 +704,7 @@ nonallocating_write:
         assert(VDI_IS_ALLOCATED(bmap_first));
         *header = s->header;
         vdi_header_to_le(header);
-        ret = bdrv_write(bs->file, 0, block, 1);
+        ret = bdrv_pwrite(bs->file, 0, block, sizeof(*block));
         g_free(block);
         block = NULL;
 
@@ -722,7 +722,8 @@ nonallocating_write:
         base = ((uint8_t *)&s->bmap[0]) + bmap_first * SECTOR_SIZE;
         logout("will write %u block map sectors starting from entry %u\n",
                n_sectors, bmap_first);
-        ret = bdrv_write(bs->file, offset, base, n_sectors);
+        ret = bdrv_pwrite(bs->file, offset * SECTOR_SIZE, base,
+                          n_sectors * SECTOR_SIZE);
     }
 
     return ret;
-- 
2.11.0


