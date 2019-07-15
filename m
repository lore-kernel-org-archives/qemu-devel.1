Return-Path: <SRS0=IjNW=VM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D30C6C76191
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jul 2019 13:54:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AF7C921530
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jul 2019 13:54:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF7C921530
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38980 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hn1QY-0008Rf-G1
	for qemu-devel@archiver.kernel.org; Mon, 15 Jul 2019 09:54:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54378)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <quintela@redhat.com>) id 1hn1Pz-0006RZ-Gs
 for qemu-devel@nongnu.org; Mon, 15 Jul 2019 09:53:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <quintela@redhat.com>) id 1hn1Py-0003ro-6o
 for qemu-devel@nongnu.org; Mon, 15 Jul 2019 09:53:27 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47416)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <quintela@redhat.com>) id 1hn1Px-0003rR-VM
 for qemu-devel@nongnu.org; Mon, 15 Jul 2019 09:53:26 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 3E0D9C04AC69;
 Mon, 15 Jul 2019 13:53:25 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.36.118.16])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0B5125D772;
 Mon, 15 Jul 2019 13:53:19 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: qemu-devel@nongnu.org
Date: Mon, 15 Jul 2019 15:51:25 +0200
Message-Id: <20190715135125.17770-22-quintela@redhat.com>
In-Reply-To: <20190715135125.17770-1-quintela@redhat.com>
References: <20190715135125.17770-1-quintela@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.31]); Mon, 15 Jul 2019 13:53:25 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 21/21] migration: always initial RAMBlock.bmap
 to 1 for new migration
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
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 kvm@vger.kernel.org, Juan Quintela <quintela@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Peter Xu <peterx@redhat.com>,
 Ivan Ren <renyime@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Ivan Ren <ivanren@tencent.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Ivan Ren <renyime@gmail.com>

Reproduce the problem:
migrate
migrate_cancel
migrate

Error happen for memory migration

The reason as follows:
1. qemu start, ram_list.dirty_memory[DIRTY_MEMORY_MIGRATION] all set to
   1 by a series of cpu_physical_memory_set_dirty_range
2. migration start:ram_init_bitmaps
   - memory_global_dirty_log_start: begin log diry
   - memory_global_dirty_log_sync: sync dirty bitmap to
     ram_list.dirty_memory[DIRTY_MEMORY_MIGRATION]
   - migration_bitmap_sync_range: sync ram_list.
     dirty_memory[DIRTY_MEMORY_MIGRATION] to RAMBlock.bmap
     and ram_list.dirty_memory[DIRTY_MEMORY_MIGRATION] is set to zero
3. migration data...
4. migrate_cancel, will stop log dirty
5. migration start:ram_init_bitmaps
   - memory_global_dirty_log_start: begin log diry
   - memory_global_dirty_log_sync: sync dirty bitmap to
     ram_list.dirty_memory[DIRTY_MEMORY_MIGRATION]
   - migration_bitmap_sync_range: sync ram_list.
     dirty_memory[DIRTY_MEMORY_MIGRATION] to RAMBlock.bmap
     and ram_list.dirty_memory[DIRTY_MEMORY_MIGRATION] is set to zero

   Here RAMBlock.bmap only have new logged dirty pages, don't contain
   the whole guest pages.

Signed-off-by: Ivan Ren <ivanren@tencent.com>
Reviewed-by: Juan Quintela <quintela@redhat.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
Message-Id: <1563115879-2715-1-git-send-email-ivanren@tencent.com>
Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 migration/ram.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/migration/ram.c b/migration/ram.c
index 85bc36101c..2b0774c2bf 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -3213,11 +3213,11 @@ static int ram_state_init(RAMState **rsp)
     QSIMPLEQ_INIT(&(*rsp)->src_page_requests);
=20
     /*
+     * Count the total number of pages used by ram blocks not including =
any
+     * gaps due to alignment or unplugs.
      * This must match with the initial values of dirty bitmap.
-     * Currently we initialize the dirty bitmap to all zeros so
-     * here the total dirty page count is zero.
      */
-    (*rsp)->migration_dirty_pages =3D 0;
+    (*rsp)->migration_dirty_pages =3D ram_bytes_total() >> TARGET_PAGE_B=
ITS;
     ram_state_reset(*rsp);
=20
     return 0;
@@ -3249,12 +3249,13 @@ static void ram_list_init_bitmaps(void)
              * The initial dirty bitmap for migration must be set with a=
ll
              * ones to make sure we'll migrate every guest RAM page to
              * destination.
-             * Here we didn't set RAMBlock.bmap simply because it is alr=
eady
-             * set in ram_list.dirty_memory[DIRTY_MEMORY_MIGRATION] in
-             * ram_block_add, and that's where we'll sync the dirty bitm=
aps.
-             * Here setting RAMBlock.bmap would be fine too but not nece=
ssary.
+             * Here we set RAMBlock.bmap all to 1 because when rebegin a
+             * new migration after a failed migration, ram_list.
+             * dirty_memory[DIRTY_MEMORY_MIGRATION] don't include the wh=
ole
+             * guest memory.
              */
             block->bmap =3D bitmap_new(pages);
+            bitmap_set(block->bmap, 0, pages);
             block->clear_bmap_shift =3D shift;
             block->clear_bmap =3D bitmap_new(clear_bmap_size(pages, shif=
t));
             if (migrate_postcopy_ram()) {
--=20
2.21.0


