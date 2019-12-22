Return-Path: <SRS0=nsQZ=2M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E79B4C2D0C0
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Dec 2019 11:52:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AC6452070A
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Dec 2019 11:52:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="WFQdP98k"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC6452070A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46880 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iizmn-0001HC-Rf
	for qemu-devel@archiver.kernel.org; Sun, 22 Dec 2019 06:52:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41504)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berto@igalia.com>) id 1iizYp-0002nv-Dh
 for qemu-devel@nongnu.org; Sun, 22 Dec 2019 06:38:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berto@igalia.com>) id 1iizYn-0005cC-Vr
 for qemu-devel@nongnu.org; Sun, 22 Dec 2019 06:38:11 -0500
Received: from fanzine.igalia.com ([178.60.130.6]:34969)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <berto@igalia.com>)
 id 1iizYn-0004Uw-Dg; Sun, 22 Dec 2019 06:38:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
 s=20170329; 
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From;
 bh=Vrl3GLQfcFIv5bcPqB/dgOQOJJKXmkDxlI4dGSew4sk=; 
 b=WFQdP98koBD8QUEBF/zd6IXqKqDA0kQe7zq29Mew7zyA7dKSDJrf9sKLU7hsBlBoV2cSjkGKKP5SkqvPkp73VshzcFXUg6hHUOwY0QzzCs9ti9Cx5JFc4pvmJULQwbZt59ai9qTIUFmfbUvNgkLlAgqPwNO2UpFLuIjssescEKzor4y8HHWTBZmucQkCkT5k075wZAt7+ZXkh3V3N4vZZD6gfgglDf62ISnb8c7HmUvGZpu3LXYa5FjrKgUXN+V7xHaF8mflg5Fe/q+aU40qt747IbCfnfuNJaG/1CYVzBXYynbn85yRIEskl6Z38szD1B6jj+/dfWmGyH5PJuB/eQ==;
Received: from [80.30.182.172] (helo=perseus.local)
 by fanzine.igalia.com with esmtpsa 
 (Cipher TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim)
 id 1iizYU-0005dK-Ub; Sun, 22 Dec 2019 12:37:52 +0100
Received: from berto by perseus.local with local (Exim 4.92)
 (envelope-from <berto@igalia.com>)
 id 1iizXu-0001W2-PP; Sun, 22 Dec 2019 12:37:14 +0100
From: Alberto Garcia <berto@igalia.com>
To: qemu-devel@nongnu.org
Subject: [RFC PATCH v3 18/27] qcow2: Add subcluster support to
 check_refcounts_l2()
Date: Sun, 22 Dec 2019 12:36:59 +0100
Message-Id: <bc1167f14690fb0fad386765ce6c81b03ae7036e.1577014346.git.berto@igalia.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1577014346.git.berto@igalia.com>
References: <cover.1577014346.git.berto@igalia.com>
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
Cc: Kevin Wolf <kwolf@redhat.com>, Anton Nefedov <anton.nefedov@virtuozzo.com>,
 Alberto Garcia <berto@igalia.com>, qemu-block@nongnu.org,
 Max Reitz <mreitz@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "Denis V . Lunev" <den@openvz.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Setting the QCOW_OFLAG_ZERO bit of the L2 entry is forbidden if an
image has subclusters. Instead, the individual 'all zeroes' bits must
be used.

Signed-off-by: Alberto Garcia <berto@igalia.com>
---
 block/qcow2-refcount.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/block/qcow2-refcount.c b/block/qcow2-refcount.c
index de85ed29a4..65f4fc27c3 100644
--- a/block/qcow2-refcount.c
+++ b/block/qcow2-refcount.c
@@ -1685,8 +1685,13 @@ static int check_refcounts_l2(BlockDriverState *bs, BdrvCheckResult *res,
                         int ign = active ? QCOW2_OL_ACTIVE_L2 :
                                            QCOW2_OL_INACTIVE_L2;
 
-                        l2_entry = QCOW_OFLAG_ZERO;
-                        set_l2_entry(s, l2_table, i, l2_entry);
+                        if (has_subclusters(s)) {
+                            set_l2_entry(s, l2_table, i, 0);
+                            set_l2_bitmap(s, l2_table, i,
+                                          QCOW_L2_BITMAP_ALL_ZEROES);
+                        } else {
+                            set_l2_entry(s, l2_table, i, QCOW_OFLAG_ZERO);
+                        }
                         ret = qcow2_pre_write_overlap_check(bs, ign,
                                 l2e_offset, l2_entry_size(s), false);
                         if (ret < 0) {
-- 
2.20.1


