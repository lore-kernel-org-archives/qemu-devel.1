Return-Path: <SRS0=ry7b=4B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F14DEC2BA83
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 17:18:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BCA3D206DB
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 17:18:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="DbqPIwZ6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BCA3D206DB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56256 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j2I7y-0006Bp-VM
	for qemu-devel@archiver.kernel.org; Thu, 13 Feb 2020 12:18:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33297)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berto@igalia.com>) id 1j2I76-0005dN-Np
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 12:17:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berto@igalia.com>) id 1j2I75-000408-H1
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 12:17:20 -0500
Received: from fanzine.igalia.com ([178.60.130.6]:57914)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <berto@igalia.com>)
 id 1j2I74-0003a7-WA; Thu, 13 Feb 2020 12:17:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
 s=20170329; 
 h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:From;
 bh=VW0xZuhRsG4PibYDsRGfffGxJBPLKMsp0cRTwwaNPlc=; 
 b=DbqPIwZ6+mnI0EUzT7vAfQprDcd3fi1e4DMXy1HQGTP0IvJBjOGQUVnuICZBh+jvExf6CdBPaSUjQ5+Mh3PUK9MqLUFPqBMc4gm+46YqUGXjL2iWEgvUaX5yyggT/VBIavf4YiFgB8kuwqHkrirrfbTYCLZwclVja6PxxK4JTYsimn1qN2prKT2x9+aOVgrvKfGnXaQbxc5PIzpG4clZLWqCOdlhNIXSjabCiuMjl2n6epu6PjHveYUkFLhih9ddCwts405mZ8Iq2doziuM5J6thK7gKjv8YbPHmJckZyediHQT6vp4mNS06SVzHjio5TEjHSR7qP26Gh4V6R43+PQ==;
Received: from [192.168.12.213] (helo=perseus.local)
 by fanzine.igalia.com with esmtpsa 
 (Cipher TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim)
 id 1j2I6l-0007cD-1X; Thu, 13 Feb 2020 18:16:59 +0100
Received: from berto by perseus.local with local (Exim 4.92)
 (envelope-from <berto@igalia.com>)
 id 1j2I6c-00049S-W0; Thu, 13 Feb 2020 18:16:50 +0100
From: Alberto Garcia <berto@igalia.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] qcow2: Fix alignment checks in encrypted images
Date: Thu, 13 Feb 2020 18:16:46 +0100
Message-Id: <20200213171646.15876-1-berto@igalia.com>
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
Cc: Kevin Wolf <kwolf@redhat.com>, Alberto Garcia <berto@igalia.com>,
 qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

I/O requests to encrypted media should be aligned to the sector size
used by the underlying encryption method, not to BDRV_SECTOR_SIZE.
Fortunately this doesn't break anything at the moment because
both existing QCRYPTO_BLOCK_*_SECTOR_SIZE have the same value as
BDRV_SECTOR_SIZE.

The checks in qcow2_co_preadv_encrypted() are also unnecessary because
they are repeated immediately afterwards in qcow2_co_encdec().

Signed-off-by: Alberto Garcia <berto@igalia.com>
---
 block/qcow2-threads.c | 12 ++++++++----
 block/qcow2.c         |  2 --
 2 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/block/qcow2-threads.c b/block/qcow2-threads.c
index 8f5a0d1ebe..77bb578cdf 100644
--- a/block/qcow2-threads.c
+++ b/block/qcow2-threads.c
@@ -246,12 +246,15 @@ qcow2_co_encdec(BlockDriverState *bs, uint64_t host_offset,
         .len = len,
         .func = func,
     };
+    uint64_t sector_size;
 
-    assert(QEMU_IS_ALIGNED(guest_offset, BDRV_SECTOR_SIZE));
-    assert(QEMU_IS_ALIGNED(host_offset, BDRV_SECTOR_SIZE));
-    assert(QEMU_IS_ALIGNED(len, BDRV_SECTOR_SIZE));
     assert(s->crypto);
 
+    sector_size = qcrypto_block_get_sector_size(s->crypto);
+    assert(QEMU_IS_ALIGNED(guest_offset, sector_size));
+    assert(QEMU_IS_ALIGNED(host_offset, sector_size));
+    assert(QEMU_IS_ALIGNED(len, sector_size));
+
     return len == 0 ? 0 : qcow2_co_process(bs, qcow2_encdec_pool_func, &arg);
 }
 
@@ -270,7 +273,8 @@ qcow2_co_encdec(BlockDriverState *bs, uint64_t host_offset,
  *        will be written to the underlying storage device at
  *        @host_offset
  *
- * @len - length of the buffer (must be a BDRV_SECTOR_SIZE multiple)
+ * @len - length of the buffer (must be a multiple of the encryption
+ *        sector size)
  *
  * Depending on the encryption method, @host_offset and/or @guest_offset
  * may be used for generating the initialization vector for
diff --git a/block/qcow2.c b/block/qcow2.c
index ef96606f8d..8dcee5efec 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -2068,8 +2068,6 @@ qcow2_co_preadv_encrypted(BlockDriverState *bs,
         goto fail;
     }
 
-    assert(QEMU_IS_ALIGNED(offset, BDRV_SECTOR_SIZE));
-    assert(QEMU_IS_ALIGNED(bytes, BDRV_SECTOR_SIZE));
     if (qcow2_co_decrypt(bs,
                          file_cluster_offset + offset_into_cluster(s, offset),
                          offset, buf, bytes) < 0)
-- 
2.20.1


