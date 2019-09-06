Return-Path: <SRS0=KBml=XB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E9F8C43331
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Sep 2019 20:00:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C408220650
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Sep 2019 20:00:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C408220650
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59866 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i6KPd-0005E9-JH
	for qemu-devel@archiver.kernel.org; Fri, 06 Sep 2019 16:00:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52475)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mlevitsk@redhat.com>) id 1i6KMv-0002zE-P0
 for qemu-devel@nongnu.org; Fri, 06 Sep 2019 15:58:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mlevitsk@redhat.com>) id 1i6KMu-0003Sv-6D
 for qemu-devel@nongnu.org; Fri, 06 Sep 2019 15:58:05 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57644)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mlevitsk@redhat.com>)
 id 1i6KMr-0003Nd-9F; Fri, 06 Sep 2019 15:58:01 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 8AAD63DE31;
 Fri,  6 Sep 2019 19:58:00 +0000 (UTC)
Received: from maximlenovopc.usersys.redhat.com (unknown [10.35.206.83])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 46E5A60BF1;
 Fri,  6 Sep 2019 19:57:58 +0000 (UTC)
From: Maxim Levitsky <mlevitsk@redhat.com>
To: qemu-devel@nongnu.org
Date: Fri,  6 Sep 2019 22:57:49 +0300
Message-Id: <20190906195750.17651-3-mlevitsk@redhat.com>
In-Reply-To: <20190906195750.17651-1-mlevitsk@redhat.com>
References: <20190906195750.17651-1-mlevitsk@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.29]); Fri, 06 Sep 2019 19:58:00 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v2 2/3] block/qcow2: fix the corruption when
 rebasing luks encrypted files
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

Fix this by:
 * Remove the offset_in_cluster parameter of do_perform_cow_encrypt,
   since it is misleading. That offset can be larger than cluster size
   currently.

   Instead just add the start and the end COW area offsets to both host
   and guest offsets that do_perform_cow_encrypt receives.

*  in do_perform_cow_encrypt, remove the cluster offset from the host_offset,
   and thus pass correctly to the qcow2_co_encrypt, the host cluster offset
   and full guest offset

In the bugreport that was triggered by rebasing a luks image to new,
zero filled base, which lot of such writes, and causes some files
with zero areas to contain garbage there instead.
But as described above it can happen elsewhere as well


Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
---
 block/qcow2-cluster.c | 28 ++++++++++++++++------------
 1 file changed, 16 insertions(+), 12 deletions(-)

diff --git a/block/qcow2-cluster.c b/block/qcow2-cluster.c
index 1989b423da..6df17dd296 100644
--- a/block/qcow2-cluster.c
+++ b/block/qcow2-cluster.c
@@ -463,20 +463,20 @@ static int coroutine_fn do_perform_cow_read(BlockDriverState *bs,
 }
 
 static bool coroutine_fn do_perform_cow_encrypt(BlockDriverState *bs,
-                                                uint64_t guest_cluster_offset,
-                                                uint64_t host_cluster_offset,
-                                                unsigned offset_in_cluster,
+                                                uint64_t guest_offset,
+                                                uint64_t host_offset,
                                                 uint8_t *buffer,
                                                 unsigned bytes)
 {
     if (bytes && bs->encrypted) {
         BDRVQcow2State *s = bs->opaque;
-        assert((offset_in_cluster & ~BDRV_SECTOR_MASK) == 0);
-        assert((bytes & ~BDRV_SECTOR_MASK) == 0);
+
+        assert(QEMU_IS_ALIGNED(guest_offset | host_offset | bytes,
+               BDRV_SECTOR_SIZE));
         assert(s->crypto);
-        if (qcow2_co_encrypt(bs, host_cluster_offset,
-                             guest_cluster_offset + offset_in_cluster,
-                             buffer, bytes) < 0) {
+
+        if (qcow2_co_encrypt(bs, start_of_cluster(s, host_offset),
+                             guest_offset, buffer, bytes) < 0) {
             return false;
         }
     }
@@ -890,11 +890,15 @@ static int perform_cow(BlockDriverState *bs, QCowL2Meta *m)
 
     /* Encrypt the data if necessary before writing it */
     if (bs->encrypted) {
-        if (!do_perform_cow_encrypt(bs, m->offset, m->alloc_offset,
-                                    start->offset, start_buffer,
+        if (!do_perform_cow_encrypt(bs,
+                                    m->offset + start->offset,
+                                    m->alloc_offset + start->offset,
+                                    start_buffer,
                                     start->nb_bytes) ||
-            !do_perform_cow_encrypt(bs, m->offset, m->alloc_offset,
-                                    end->offset, end_buffer, end->nb_bytes)) {
+            !do_perform_cow_encrypt(bs,
+                                    m->offset + end->offset,
+                                    m->alloc_offset + end->offset,
+                                    end_buffer, end->nb_bytes)) {
             ret = -EIO;
             goto fail;
         }
-- 
2.17.2


