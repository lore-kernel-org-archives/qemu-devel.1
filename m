Return-Path: <SRS0=l4AY=XG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0450FC49ED6
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2019 15:21:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BF3AD206A5
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2019 15:21:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="UxSmBBWH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF3AD206A5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52442 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i84Qf-0008LM-B5
	for qemu-devel@archiver.kernel.org; Wed, 11 Sep 2019 11:21:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52466)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berto@igalia.com>) id 1i84N9-0006Kc-W3
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 11:17:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berto@igalia.com>) id 1i84N2-0003RD-14
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 11:17:28 -0400
Received: from fanzine.igalia.com ([91.117.99.155]:33965)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <berto@igalia.com>)
 id 1i84Mv-0003HC-8K; Wed, 11 Sep 2019 11:17:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
 s=20170329; 
 h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:From;
 bh=3ky7uFhm3UvyPJzrvpGfefSmyjPnMHqJz5qM17R8OTc=; 
 b=UxSmBBWH2XaGi6a/t7gK5Pysn0NT/O2ix7HcWT4XkpwrZMa20JWR8McYUIS8TuVRYyAGY3sHAF2NHD3i4mJ2q2kWh/rryqid/3AVzWK79M+NWdBcpqEH2x6yIOhZ3K3ffX8l2VBtxFVGY37YCaOfLw+FXLxXfXNRYetCNHwejUYzIkJZ7Anz0xcdy47VWjT2df4HGfnfw0vBWXZlCWim0QprQ2wIq8MWAgn8e28Kf5rPPXVVs5exSuXBkbf3IDM/R0DI0EZB98uDN+U8dK8eRAn50QcDlBPusyzoMJdupNDzr2KFKKoFDzSOTMOEbiqgeU/U1ttTr/UJYe9v+XQ8aw==;
Received: from 82-181-154-206.bb.dnainternet.fi ([82.181.154.206]
 helo=perseus.local) by fanzine.igalia.com with esmtpsa 
 (Cipher TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim)
 id 1i84Ma-0001ZJ-Sh; Wed, 11 Sep 2019 17:16:57 +0200
Received: from berto by perseus.local with local (Exim 4.92)
 (envelope-from <berto@igalia.com>)
 id 1i84MC-0001mo-SS; Wed, 11 Sep 2019 18:16:32 +0300
From: Alberto Garcia <berto@igalia.com>
To: qemu-devel@nongnu.org
Date: Wed, 11 Sep 2019 18:16:26 +0300
Message-Id: <20190911151626.6823-1-berto@igalia.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x (no
 timestamps) [generic] [fuzzy]
X-Received-From: 91.117.99.155
Subject: [Qemu-devel] [PATCH] qcow2: Stop overwriting compressed clusters
 one by one
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

handle_alloc() tries to find as many contiguous clusters that need
copy-on-write as possible in order to allocate all of them at the same
time.

However, compressed clusters are only overwritten one by one, so let's
say that we have an image with 1024 consecutive compressed clusters:

   qemu-img create -f qcow2 hd.qcow2 64M
   for f in `seq 0 64 65472`; do
      qemu-io -c "write -c ${f}k 64k" hd.qcow2
   done

In this case trying to overwrite the whole image with one large write
request results in 1024 separate allocations:

   qemu-io -c "write 0 64M" hd.qcow2

This restriction comes from commit 095a9c58ce12afeeb90c2 from 2018.
Nowadays QEMU can overwrite multiple compressed clusters just fine,
and in fact it already does: as long as the first cluster that
handle_alloc() finds is not compressed, all other compressed clusters
in the same batch will be overwritten in one go:

   qemu-img create -f qcow2 hd.qcow2 64M
   qemu-io -c "write -z 0 64k" hd.qcow2
   for f in `seq 64 64 65472`; do
      qemu-io -c "write -c ${f}k 64k" hd.qcow2
   done

Compared to the previous one, overwriting this image on my computer
goes from 8.35s down to 230ms.

Signed-off-by: Alberto Garcia <berto@igalia.com>
---
 block/qcow2-cluster.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/block/qcow2-cluster.c b/block/qcow2-cluster.c
index f09cc992af..dcacd3c450 100644
--- a/block/qcow2-cluster.c
+++ b/block/qcow2-cluster.c
@@ -1351,13 +1351,7 @@ static int handle_alloc(BlockDriverState *bs, uint64_t guest_offset,
     }
 
     entry = be64_to_cpu(l2_slice[l2_index]);
-
-    /* For the moment, overwrite compressed clusters one by one */
-    if (entry & QCOW_OFLAG_COMPRESSED) {
-        nb_clusters = 1;
-    } else {
-        nb_clusters = count_cow_clusters(bs, nb_clusters, l2_slice, l2_index);
-    }
+    nb_clusters = count_cow_clusters(bs, nb_clusters, l2_slice, l2_index);
 
     /* This function is only called when there were no non-COW clusters, so if
      * we can't find any unallocated or COW clusters either, something is
-- 
2.20.1


