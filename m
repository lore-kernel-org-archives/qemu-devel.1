Return-Path: <SRS0=wgY8=XI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FF60C49ED7
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Sep 2019 15:34:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2364620693
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Sep 2019 15:34:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2364620693
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45350 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i8naR-00072I-62
	for qemu-devel@archiver.kernel.org; Fri, 13 Sep 2019 11:34:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53499)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mlevitsk@redhat.com>) id 1i8nUx-0001K0-HH
 for qemu-devel@nongnu.org; Fri, 13 Sep 2019 11:28:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mlevitsk@redhat.com>) id 1i8nUw-0004i9-CU
 for qemu-devel@nongnu.org; Fri, 13 Sep 2019 11:28:35 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54284)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mlevitsk@redhat.com>)
 id 1i8nUr-0004gK-HK; Fri, 13 Sep 2019 11:28:29 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id D62631DB0;
 Fri, 13 Sep 2019 15:28:28 +0000 (UTC)
Received: from maximlenovopc.usersys.redhat.com (unknown [10.35.206.39])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7CBD55B681;
 Fri, 13 Sep 2019 15:28:23 +0000 (UTC)
From: Maxim Levitsky <mlevitsk@redhat.com>
To: qemu-devel@nongnu.org
Date: Fri, 13 Sep 2019 18:28:16 +0300
Message-Id: <20190913152818.17843-2-mlevitsk@redhat.com>
In-Reply-To: <20190913152818.17843-1-mlevitsk@redhat.com>
References: <20190913152818.17843-1-mlevitsk@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.71]); Fri, 13 Sep 2019 15:28:28 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v5 1/3] Fix qcow2+luks corruption introduced by
 commit 8ac0f15f335
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
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-block@nongnu.org, qemu-stable <qemu-stable@nongnu.org>,
 Max Reitz <mreitz@redhat.com>, Maxim Levitsky <mlevitsk@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This fixes subtle corruption introduced by luks threaded encryption
in commit 8ac0f15f335

Bugzilla: https://bugzilla.redhat.com/show_bug.cgi?id=1745922

The corruption happens when we do a write that
   * writes to two or more unallocated clusters at once
   * doesn't fully cover the first sector
   * doesn't fully cover the last sector

In this case, when allocating the new clusters we COW both areas
prior to the write and after the write, and we encrypt them.

The above mentioned commit accidentally made it so we encrypt the
second COW area using the physical cluster offset of the first area.

The problem is that offset_in_cluster in do_perform_cow_encrypt
can be larger that the cluster size, thus cluster_offset
will no longer point to the start of the cluster at which encrypted
area starts.

Next patch in this series will refactor the code to avoid all these
assumptions.

In the bugreport that was triggered by rebasing a luks image to new,
zero filled base, which lot of such writes, and causes some files
with zero areas to contain garbage there instead.
But as described above it can happen elsewhere as well


Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
---
 block/qcow2-cluster.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/block/qcow2-cluster.c b/block/qcow2-cluster.c
index dcacd3c450..bfeb0241d7 100644
--- a/block/qcow2-cluster.c
+++ b/block/qcow2-cluster.c
@@ -474,9 +474,10 @@ static bool coroutine_fn do_perform_cow_encrypt(BlockDriverState *bs,
         assert((offset_in_cluster & ~BDRV_SECTOR_MASK) == 0);
         assert((bytes & ~BDRV_SECTOR_MASK) == 0);
         assert(s->crypto);
-        if (qcow2_co_encrypt(bs, cluster_offset,
-                             src_cluster_offset + offset_in_cluster,
-                             buffer, bytes) < 0) {
+        if (qcow2_co_encrypt(bs,
+                start_of_cluster(s, cluster_offset + offset_in_cluster),
+                src_cluster_offset + offset_in_cluster,
+                buffer, bytes) < 0) {
             return false;
         }
     }
-- 
2.17.2


