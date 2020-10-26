Return-Path: <SRS0=ZyMj=EB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62783C4363A
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 12:04:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D34DE22281
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 12:04:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XuM5tAEm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D34DE22281
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39056 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kX1En-0002er-JE
	for qemu-devel@archiver.kernel.org; Mon, 26 Oct 2020 08:04:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40852)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1kX1DG-0000zE-GX
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 08:02:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:45508)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1kX1DD-0001ph-7r
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 08:02:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603713773;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=h8uXnxFwQZA0rxBmJzPi9mlR83+QQb3SlPu4A2ChkrY=;
 b=XuM5tAEmrIuneJO3g3LyZ1jpC5dVHJfoAiGXWZQcTlZzH2Gg9+kITXFkKRap6GMR4UVMfH
 sJ+rUOIXNViXXllo3fyVQhj8o1ayhcaFz9nMVGA968E/zgr6cFxMUIOhxmpdFKG6GNTjzt
 hnNbSNUAXOy2LUiKl0h9xw4d198PxUY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-80-KOIufmW0Ms26IGCMt-u0VQ-1; Mon, 26 Oct 2020 08:02:51 -0400
X-MC-Unique: KOIufmW0Ms26IGCMt-u0VQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A2FC4106BC77;
 Mon, 26 Oct 2020 12:02:48 +0000 (UTC)
Received: from blue.redhat.com (ovpn-112-145.phx2.redhat.com [10.3.112.145])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9600D10013D9;
 Mon, 26 Oct 2020 12:02:47 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 1/2] migration/block-dirty-bitmap: fix larger granularity
 bitmaps
Date: Mon, 26 Oct 2020 07:02:44 -0500
Message-Id: <20201026120245.25024-2-eblake@redhat.com>
In-Reply-To: <20201026120245.25024-1-eblake@redhat.com>
References: <20201026120245.25024-1-eblake@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=eblake@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=63.128.21.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/25 21:03:19
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Fam Zheng <fam@euphon.net>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "open list:Dirty Bitmaps" <qemu-block@nongnu.org>,
 Juan Quintela <quintela@redhat.com>, Stefan Reiter <s.reiter@proxmox.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Stefan Reiter <s.reiter@proxmox.com>

sectors_per_chunk is a 64 bit integer, but the calculation is done in 32
bits, leading to an overflow for coarse bitmap granularities.

If that results in the value 0, it leads to a hang where no progress is
made but send_bitmap_bits is constantly called with nr_sectors being 0.

Signed-off-by: Stefan Reiter <s.reiter@proxmox.com>
Message-Id: <20201021144456.1072-1-s.reiter@proxmox.com>
Fixes: b35ebdf07 migration: add postcopy migration of dirty bitmaps
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
[eblake: Use correct type for 8ULL, use () to avoid overflow]
Signed-off-by: Eric Blake <eblake@redhat.com>
---
 migration/block-dirty-bitmap.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/migration/block-dirty-bitmap.c b/migration/block-dirty-bitmap.c
index 5bef793ac0eb..98921db77271 100644
--- a/migration/block-dirty-bitmap.c
+++ b/migration/block-dirty-bitmap.c
@@ -562,8 +562,9 @@ static int add_bitmaps_to_list(DBMSaveState *s, BlockDriverState *bs,
         dbms->bitmap_alias = g_strdup(bitmap_alias);
         dbms->bitmap = bitmap;
         dbms->total_sectors = bdrv_nb_sectors(bs);
-        dbms->sectors_per_chunk = CHUNK_SIZE * 8 *
-            bdrv_dirty_bitmap_granularity(bitmap) >> BDRV_SECTOR_BITS;
+        dbms->sectors_per_chunk = CHUNK_SIZE * 8LLU *
+            (bdrv_dirty_bitmap_granularity(bitmap) >> BDRV_SECTOR_BITS);
+        assert(dbms->sectors_per_chunk != 0);
         if (bdrv_dirty_bitmap_enabled(bitmap)) {
             dbms->flags |= DIRTY_BITMAP_MIG_START_FLAG_ENABLED;
         }
-- 
2.29.0


