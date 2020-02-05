Return-Path: <SRS0=Tmh/=3Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33D8FC35254
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2020 13:30:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F3B412072B
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2020 13:30:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="s2LAXePj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F3B412072B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=partner.samsung.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46990 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izKkm-00010C-6E
	for qemu-devel@archiver.kernel.org; Wed, 05 Feb 2020 08:30:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36765)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <i.kotrasinsk@partner.samsung.com>)
 id 1izKjY-0007ja-2E
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 08:28:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <i.kotrasinsk@partner.samsung.com>)
 id 1izKjX-0004po-25
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 08:28:47 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:50241)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <i.kotrasinsk@partner.samsung.com>)
 id 1izKjW-0004iI-Rz
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 08:28:46 -0500
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
 by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id
 20200205132844euoutp025efc8e25b65788585791270b251fc17f~whKemoDmH0775107751euoutp02R
 for <qemu-devel@nongnu.org>; Wed,  5 Feb 2020 13:28:44 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com
 20200205132844euoutp025efc8e25b65788585791270b251fc17f~whKemoDmH0775107751euoutp02R
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1580909324;
 bh=ibNqqK8kMJTR6I/8H1P2J6EA3/WKQtaT/ZbDNoeJndI=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=s2LAXePj2lM6gHNOVyeM1Me51FEMweHXtWrguf8NKJq5gYkm8LiP5WB5YNvjYItaU
 WvhXbkn0VfqcfS7NzjLF50SIHw68q6fYbdQ2DHAp71Wu2McPWmHLUjdRXP5FH9ftyC
 ntFuk7wS8wfcMEC0og5F9FFQaE9fHL1KNyKlDX/4=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
 eucas1p2.samsung.com (KnoxPortal) with ESMTP id
 20200205132844eucas1p25f7291c3af6cff3de61b3b4a223d3b27~whKeantb40492104921eucas1p2B;
 Wed,  5 Feb 2020 13:28:44 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
 eusmges2new.samsung.com (EUCPMTA) with SMTP id 04.5F.60679.C03CA3E5; Wed,  5
 Feb 2020 13:28:44 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
 eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
 20200205132844eucas1p244e4995a63149ee69cfcdb04b7ca0f64~whKeEMnpm0490904909eucas1p2B;
 Wed,  5 Feb 2020 13:28:44 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
 eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
 20200205132844eusmtrp286a12d3ad95dc8bf7822abdb19db33e9~whKd5ikQ42992629926eusmtrp2k;
 Wed,  5 Feb 2020 13:28:44 +0000 (GMT)
X-AuditID: cbfec7f4-0cbff7000001ed07-f6-5e3ac30ccab2
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
 eusmgms1.samsung.com (EUCPMTA) with SMTP id 42.00.08375.B03CA3E5; Wed,  5
 Feb 2020 13:28:44 +0000 (GMT)
Received: from AMDC3304.digital.local (unknown [106.120.51.21]) by
 eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
 20200205132843eusmtip2b86bc522d0209230a48c5e37d37b79e2~whKdhvBD60047800478eusmtip2Y;
 Wed,  5 Feb 2020 13:28:43 +0000 (GMT)
From: i.kotrasinsk@partner.samsung.com
To: qemu-devel@nongnu.org
Subject: [RFC PATCH v3 3/9] memory: Hack - use shared memory when possible
Date: Wed,  5 Feb 2020 14:28:31 +0100
Message-Id: <1580909317-23884-4-git-send-email-i.kotrasinsk@partner.samsung.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1580909317-23884-1-git-send-email-i.kotrasinsk@partner.samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrMIsWRmVeSWpSXmKPExsWy7djP87o8h63iDBZOlLXYc+Exm8W9mzeZ
 LfZv+8dqMefMAxaL4707WBxYPe5c28Pm8eTaZiaPg+/2MHm833eVzWP7yUlMAaxRXDYpqTmZ
 ZalF+nYJXBkrD3WxFHxnq5i3eiNjA+NPli5GTg4JAROJd70vGLsYuTiEBFYwStx8NA/K+cIo
 MWH7WxYI5zOjxO8DM9hhWnb+28kMkVjOKNG35CArSAKsZeNqNxCbTUBNYueRz4wgtoiApMTv
 rtNgDcwCDYwSj66fBUsIC3hJbNu0HewQFgFVicX/fjGD2LwCARLvm++wQWyTk7h5rhMszikQ
 KHH52RRWkEESAo/ZJH5df8UKUeQicffVOWYIW1ji1fEtUKfKSPzfOZ8Jwq6XaLmzgwmiuQPo
 7JXToTZYS3zZsBToCg6g8zQl1u/Shwg7ShxZ+YwdJCwhwCdx460gSJgZyJy0bTozRJhXoqNN
 CKJaT6L7yU0mmK3LGh9Bw9dD4uPJu0yQwFrCKLFg6mPWCYzysxCWLWBkXMUonlpanJueWmyU
 l1quV5yYW1yal66XnJ+7iRGYFE7/O/5lB+OuP0mHGAU4GJV4eFdMsowTYk0sK67MPcQowcGs
 JMJ7Xh8oxJuSWFmVWpQfX1Sak1p8iFGag0VJnNd40ctYIYH0xJLU7NTUgtQimCwTB6dUAyOn
 t4HxPV6tPVuXlrN/TzFb+UenPl73iNQHPjb+I5Ffl7fL2n6b68pffWpiuVKj3pcljdGZ4Z9m
 tzEf5C5fYeMht+2w04QS2QdxlzY8jzC5XeyzMemtOGu7AGt+8KzLzS9dl/QrMGR8kUxzbZCc
 l93/6IteMefmPvGQDruvcQqbrt1anp6vrMRSnJFoqMVcVJwIABn/jgkGAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrCLMWRmVeSWpSXmKPExsVy+t/xe7o8h63iDA7bWOy58JjN4t7Nm8wW
 +7f9Y7WYc+YBi8Xx3h0sDqwed67tYfN4cm0zk8fBd3uYPN7vu8rmsf3kJKYA1ig9m6L80pJU
 hYz84hJbpWhDCyM9Q0sLPSMTSz1DY/NYKyNTJX07m5TUnMyy1CJ9uwS9jJWHulgKvrNVzFu9
 kbGB8SdLFyMnh4SAicTOfzuZuxi5OIQEljJKTF7fyA6RkJH4cXoNG4QtLPHnWhcbRNEnRolP
 P+6CdbMJqEnsPPKZEcQWEZCU+N11GmwSs0ALo8SzJ+1MIAlhAS+JbZu2gzWwCKhKLP73ixnE
 5hUIkHjffAdqg5zEzXOdYHFOgUCJy8+msILYQkA1rydeYZ7AyLeAkWEVo0hqaXFuem6xoV5x
 Ym5xaV66XnJ+7iZGYIhuO/Zz8w7GSxuDDzEKcDAq8fCumGQZJ8SaWFZcmXuIUYKDWUmE97w+
 UIg3JbGyKrUoP76oNCe1+BCjKdBRE5mlRJPzgfGTVxJvaGpobmFpaG5sbmxmoSTO2yFwMEZI
 ID2xJDU7NbUgtQimj4mDU6qBUW/ynOe7frtM/Dht6tQbM+Z2qK66tUrSX2zLBlX/7VcfT90/
 8db/7Ucv636Z4568rKpzo2KG4s/IK7x+By6cceesKNKpbXpuoeKoHfZtu+SFuZ9uMR27vr/4
 yLzHD9LE2WNXuvYnLohgOqzNqnSGPaMrpDqmRroo4bmo4t4i8xieZK9zR+41XVJiKc5INNRi
 LipOBABBmjAnZwIAAA==
X-CMS-MailID: 20200205132844eucas1p244e4995a63149ee69cfcdb04b7ca0f64
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200205132844eucas1p244e4995a63149ee69cfcdb04b7ca0f64
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200205132844eucas1p244e4995a63149ee69cfcdb04b7ca0f64
References: <1580909317-23884-1-git-send-email-i.kotrasinsk@partner.samsung.com>
 <CGME20200205132844eucas1p244e4995a63149ee69cfcdb04b7ca0f64@eucas1p2.samsung.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 210.118.77.12
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
Cc: peter.maydell@linaro.org,
 Igor Kotrasinski <i.kotrasinsk@partner.samsung.com>, jan.kiszka@siemens.com,
 pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Igor Kotrasinski <i.kotrasinsk@partner.samsung.com>

Signed-off-by: Igor Kotrasinski <i.kotrasinsk@partner.samsung.com>
---
 hw/core/numa.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/core/numa.c b/hw/core/numa.c
index 0d1b4be..02fd7f5 100644
--- a/hw/core/numa.c
+++ b/hw/core/numa.c
@@ -785,8 +785,8 @@ static void allocate_system_memory_nonnuma(MemoryRegion *mr, Object *owner,
     if (mem_path) {
 #ifdef __linux__
         Error *err = NULL;
-        memory_region_init_ram_from_file(mr, owner, name, ram_size, 0, 0,
-                                         mem_path, &err);
+        memory_region_init_ram_from_file(mr, owner, name, ram_size, 0,
+                                         RAM_SHARED, mem_path, &err);
         if (err) {
             error_report_err(err);
             if (mem_prealloc) {
-- 
2.7.4


