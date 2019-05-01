Return-Path: <SRS0=aVj3=TB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E2B8C43219
	for <qemu-devel@archiver.kernel.org>; Wed,  1 May 2019 18:21:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 60CEB20675
	for <qemu-devel@archiver.kernel.org>; Wed,  1 May 2019 18:21:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="hXKrXsId"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 60CEB20675
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:38090 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hLtqm-0002wh-Fd
	for qemu-devel@archiver.kernel.org; Wed, 01 May 2019 14:21:00 -0400
Received: from eggs.gnu.org ([209.51.188.92]:45611)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1hLtkc-0007NH-4u
	for qemu-devel@nongnu.org; Wed, 01 May 2019 14:14:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1hLtkb-0002cK-4k
	for qemu-devel@nongnu.org; Wed, 01 May 2019 14:14:38 -0400
Received: from fanzine.igalia.com ([91.117.99.155]:38860)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <berto@igalia.com>)
	id 1hLtka-0002RH-RF; Wed, 01 May 2019 14:14:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; 
	h=References:In-Reply-To:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From;
	bh=yAyTw3ZPSaXiSS8D4mL6VTPvWr3OtM2rqBBfpDKFyPM=; 
	b=hXKrXsIdfYrQBxqOgTI4YwNzufWvVfWaiyOGUlefjkWG2awV7iFaQD+5wuRtiZT6r/LjjoMU4xrmZ2xXEDLxFLLNelZg18YR9CRS7YuSv7CyNIo5JJITvS4jLcHOcrLOfI7waTgif+hEBeG5F1DXRktpHGiATq4OZMeUhpNYS8WDSynb0GnyYE8YPZ++zv/f9tETnpFKkVqT/Ylbov0XbzjCJVwSCsxDV8wCyI5qizDFOSymBNV0L6StpoUM6CVWoO+LHYmMScf2ZIAAAm8F11KpBhZ5OaS542eKmDT0MQg2etU7uwsK9myOAQUjktxgmjEgWgjZSfW4foijHVzYnQ==;
Received: from 87-92-6-174.bb.dnainternet.fi ([87.92.6.174] helo=perseus.local)
	by fanzine.igalia.com with esmtpsa 
	(Cipher TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim)
	id 1hLtkH-0002EB-7K; Wed, 01 May 2019 20:14:17 +0200
Received: from berto by perseus.local with local (Exim 4.89)
	(envelope-from <berto@igalia.com>)
	id 1hLtk2-0002yL-Jb; Wed, 01 May 2019 21:14:02 +0300
From: Alberto Garcia <berto@igalia.com>
To: qemu-devel@nongnu.org
Date: Wed,  1 May 2019 21:13:56 +0300
Message-Id:
 <f64d9b6b1bc90d45c9be5aae63176b34879182c2.1556732434.git.berto@igalia.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <cover.1556732434.git.berto@igalia.com>
References: <cover.1556732434.git.berto@igalia.com>
In-Reply-To: <cover.1556732434.git.berto@igalia.com>
References: <cover.1556732434.git.berto@igalia.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x (no
	timestamps) [generic] [fuzzy]
X-Received-From: 91.117.99.155
Subject: [Qemu-devel] [PATCH v2 2/5] vdi: Replace bdrv_{read,
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
Message-ID: <20190501181356.T0HAgBZqTuW17J01LgAa0m44ujYwaaCKvhd9BBJAKCA@z>

There's only a couple of bdrv_read() and bdrv_write() calls left in
the vdi code, and they can be trivially replaced with the byte-based
bdrv_pread() and bdrv_pwrite().

Signed-off-by: Alberto Garcia <berto@igalia.com>
---
 block/vdi.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/block/vdi.c b/block/vdi.c
index e1c42ad732..9caeb50dd1 100644
--- a/block/vdi.c
+++ b/block/vdi.c
@@ -171,6 +171,8 @@ typedef struct {
     uint64_t unused2[7];
 } QEMU_PACKED VdiHeader;
 
+QEMU_BUILD_BUG_ON(sizeof(VdiHeader) != 512);
+
 typedef struct {
     /* The block map entries are little endian (even in memory). */
     uint32_t *bmap;
@@ -384,7 +386,7 @@ static int vdi_open(BlockDriverState *bs, QDict *options, int flags,
 
     logout("\n");
 
-    ret = bdrv_read(bs->file, 0, (uint8_t *)&header, 1);
+    ret = bdrv_pread(bs->file, 0, (uint8_t *)&header, sizeof(header));
     if (ret < 0) {
         goto fail;
     }
@@ -484,8 +486,8 @@ static int vdi_open(BlockDriverState *bs, QDict *options, int flags,
         goto fail;
     }
 
-    ret = bdrv_read(bs->file, s->bmap_sector, (uint8_t *)s->bmap,
-                    bmap_size);
+    ret = bdrv_pread(bs->file, header.offset_bmap, (uint8_t *)s->bmap,
+                     bmap_size * SECTOR_SIZE);
     if (ret < 0) {
         goto fail_free_bmap;
     }
@@ -704,7 +706,7 @@ nonallocating_write:
         assert(VDI_IS_ALLOCATED(bmap_first));
         *header = s->header;
         vdi_header_to_le(header);
-        ret = bdrv_write(bs->file, 0, block, 1);
+        ret = bdrv_pwrite(bs->file, 0, block, sizeof(VdiHeader));
         g_free(block);
         block = NULL;
 
@@ -722,10 +724,11 @@ nonallocating_write:
         base = ((uint8_t *)&s->bmap[0]) + bmap_first * SECTOR_SIZE;
         logout("will write %u block map sectors starting from entry %u\n",
                n_sectors, bmap_first);
-        ret = bdrv_write(bs->file, offset, base, n_sectors);
+        ret = bdrv_pwrite(bs->file, offset * SECTOR_SIZE, base,
+                          n_sectors * SECTOR_SIZE);
     }
 
-    return ret;
+    return ret < 0 ? ret : 0;
 }
 
 static int coroutine_fn vdi_co_do_create(BlockdevCreateOptions *create_options,
-- 
2.11.0


