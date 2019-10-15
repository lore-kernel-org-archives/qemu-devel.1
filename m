Return-Path: <SRS0=6OCO=YI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF94DECE588
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Oct 2019 15:38:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7AEF2205F4
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Oct 2019 15:38:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="jO14fM1z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7AEF2205F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48926 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iKOtu-00014M-17
	for qemu-devel@archiver.kernel.org; Tue, 15 Oct 2019 11:38:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48478)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berto@igalia.com>) id 1iKOhK-0003LG-Ti
 for qemu-devel@nongnu.org; Tue, 15 Oct 2019 11:25:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berto@igalia.com>) id 1iKOhJ-0003ra-Pi
 for qemu-devel@nongnu.org; Tue, 15 Oct 2019 11:25:18 -0400
Received: from fanzine.igalia.com ([178.60.130.6]:47181)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <berto@igalia.com>)
 id 1iKOhJ-0003cD-Cu; Tue, 15 Oct 2019 11:25:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
 s=20170329; 
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From;
 bh=ALYCPxryLvhmZ8GEEyTrPtMyD7kVHTkvn2pb/zgUGkM=; 
 b=jO14fM1zd5KrqiF+SeYOwlDFCeMY+cHial+dyNEDEiFSWanHgbuT9N8gOR0elwRXPE4HWCIKVhEaCTbefF2Mz3KE73UqAoMsZrv8g2lcNv/kUxBkjrwBO4wMbXRDdfF72+8IY1mIq75WUSYqcfskiLfCJL0KRgYHqd1DxWY2mGSHBd5nrx/cTQ21vjrTMYZIrOQMgbtDBic3ZG7aGafEPuyOXzeheK/3TjfFeV+RDiULNUFn8ZElSLg5YdJCw8TDeU3I38o78ra9KF3UZEVTCNEApFLBlmhJ/dFYQsmrUiaIxHoKZKzrJ72mO4D0OQCcXDYwa2QPA/MfLjEYJb0wjA==;
Received: from 82-181-115-92.bb.dnainternet.fi ([82.181.115.92]
 helo=perseus.local) by fanzine.igalia.com with esmtpsa 
 (Cipher TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim)
 id 1iKOge-0003af-4H; Tue, 15 Oct 2019 17:24:36 +0200
Received: from berto by perseus.local with local (Exim 4.92)
 (envelope-from <berto@igalia.com>)
 id 1iKOfn-00061p-28; Tue, 15 Oct 2019 18:23:43 +0300
From: Alberto Garcia <berto@igalia.com>
To: qemu-devel@nongnu.org
Subject: [RFC PATCH 18/23] qcow2: Add subcluster support to
 expand_zero_clusters_in_l1()
Date: Tue, 15 Oct 2019 18:23:29 +0300
Message-Id: <0cb50763f0b1d32cc9e1be9b4eb77a6dc3f461d1.1571152571.git.berto@igalia.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1571152571.git.berto@igalia.com>
References: <cover.1571152571.git.berto@igalia.com>
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
 Max Reitz <mreitz@redhat.com>, "Denis V . Lunev" <den@openvz.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Two changes are needed in order to add subcluster support to this
function: deallocated clusters must have their bitmaps cleared, and
expanded clusters must have all the "subcluster allocated" bits set.

Signed-off-by: Alberto Garcia <berto@igalia.com>
---
 block/qcow2-cluster.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/block/qcow2-cluster.c b/block/qcow2-cluster.c
index bf32447d18..dc72f0e595 100644
--- a/block/qcow2-cluster.c
+++ b/block/qcow2-cluster.c
@@ -2033,6 +2033,7 @@ static int expand_zero_clusters_in_l1(BlockDriverState *bs, uint64_t *l1_table,
                         /* not backed; therefore we can simply deallocate the
                          * cluster */
                         set_l2_entry(s, l2_slice, j, 0);
+                        set_l2_bitmap(s, l2_slice, j, 0);
                         l2_dirty = true;
                         continue;
                     }
@@ -2099,6 +2100,7 @@ static int expand_zero_clusters_in_l1(BlockDriverState *bs, uint64_t *l1_table,
                 } else {
                     set_l2_entry(s, l2_slice, j, offset);
                 }
+                set_l2_bitmap(s, l2_slice, j, QCOW_L2_BITMAP_ALL_ALLOC);
                 l2_dirty = true;
             }
 
-- 
2.20.1


