Return-Path: <SRS0=KBml=XB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE3F2C43331
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Sep 2019 17:35:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 85F52206A1
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Sep 2019 17:35:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 85F52206A1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58964 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i6I9K-00084d-PX
	for qemu-devel@archiver.kernel.org; Fri, 06 Sep 2019 13:35:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46370)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mlevitsk@redhat.com>) id 1i6I60-0003qI-SW
 for qemu-devel@nongnu.org; Fri, 06 Sep 2019 13:32:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mlevitsk@redhat.com>) id 1i6I5y-0003D2-QI
 for qemu-devel@nongnu.org; Fri, 06 Sep 2019 13:32:28 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38754)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mlevitsk@redhat.com>)
 id 1i6I5q-00033u-04; Fri, 06 Sep 2019 13:32:19 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 49A45189DACE;
 Fri,  6 Sep 2019 17:32:14 +0000 (UTC)
Received: from maximlenovopc.usersys.redhat.com (unknown [10.35.206.83])
 by smtp.corp.redhat.com (Postfix) with ESMTP id EA13A5D9CA;
 Fri,  6 Sep 2019 17:32:08 +0000 (UTC)
From: Maxim Levitsky <mlevitsk@redhat.com>
To: qemu-devel@nongnu.org
Date: Fri,  6 Sep 2019 20:32:00 +0300
Message-Id: <20190906173201.7926-3-mlevitsk@redhat.com>
In-Reply-To: <20190906173201.7926-1-mlevitsk@redhat.com>
References: <20190906173201.7926-1-mlevitsk@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.63]); Fri, 06 Sep 2019 17:32:14 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH 2/3] block/qcow2: fix the corruption when
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
 Maxim Levitsky <mlevitsk@redhat.com>, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This fixes subltle corruption introduced by luks threaded encryption
in commit 8ac0f15f335

Bugzilla: https://bugzilla.redhat.com/show_bug.cgi?id=1745922

The corruption happens when we do
   * write to two or more unallocated clusters at once
   * write doesn't fully cover nether first nor last cluster

In this case, when allocating the new clusters we COW both area
prior to the write and after the write, and we encrypt them.

The above mentioned commit accidently made it so, we encrypt the
second COW are using the physical cluster offset of the first area.

Fix this by:
 * remove the offset_in_cluster parameter of do_perform_cow_encrypt
   since it is misleading. That offset can be larger that cluster size.
   instead just add the start and end COW are offsets to both host and guest offsets
   that do_perform_cow_encrypt receives.

*  in do_perform_cow_encrypt, remove the cluster offset from the host_offset
   And thus pass correctly to the qcow2_co_encrypt, the host cluster offset and full guest offset


Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
---
 block/qcow2-cluster.c | 26 +++++++++++++++-----------
 1 file changed, 15 insertions(+), 11 deletions(-)

diff --git a/block/qcow2-cluster.c b/block/qcow2-cluster.c
index b95e64c237..32477f0156 100644
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
+        assert((guest_offset & ~BDRV_SECTOR_MASK) == 0);
+        assert((host_offset & ~BDRV_SECTOR_MASK) == 0);
         assert((bytes & ~BDRV_SECTOR_MASK) == 0);
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


