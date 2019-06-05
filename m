Return-Path: <SRS0=3v23=UE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF134C28CC5
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2019 11:55:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B8E342075B
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2019 11:55:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B8E342075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:39890 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hYUWD-0004zw-1r
	for qemu-devel@archiver.kernel.org; Wed, 05 Jun 2019 07:55:49 -0400
Received: from eggs.gnu.org ([209.51.188.92]:37297)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1hYUUK-0003pj-MH
	for qemu-devel@nongnu.org; Wed, 05 Jun 2019 07:53:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1hYUUG-0002km-RN
	for qemu-devel@nongnu.org; Wed, 05 Jun 2019 07:53:51 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46588)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1hYUUG-0002jj-Js
	for qemu-devel@nongnu.org; Wed, 05 Jun 2019 07:53:48 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 481E185546;
	Wed,  5 Jun 2019 11:53:46 +0000 (UTC)
Received: from localhost.localdomain (ovpn-116-241.ams2.redhat.com
	[10.36.116.241])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 038115D71A;
	Wed,  5 Jun 2019 11:53:43 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: qemu-devel@nongnu.org
Date: Wed,  5 Jun 2019 13:53:18 +0200
Message-Id: <20190605115318.9972-6-quintela@redhat.com>
In-Reply-To: <20190605115318.9972-1-quintela@redhat.com>
References: <20190605115318.9972-1-quintela@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.28]);
	Wed, 05 Jun 2019 11:53:47 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 5/5] migratioin/ram: leave RAMBlock->bmap blank
 on allocating
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
	zhanghailiang <zhang.zhanghailiang@huawei.com>,
	Juan Quintela <quintela@redhat.com>,
	"Dr. David Alan Gilbert" <dgilbert@redhat.com>,
	Markus Armbruster <armbru@redhat.com>,
	Wei Yang <richardw.yang@linux.intel.com>,
	Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Wei Yang <richardw.yang@linux.intel.com>

During migration, we would sync bitmap from ram_list.dirty_memory to
RAMBlock.bmap in cpu_physical_memory_sync_dirty_bitmap().

Since we set RAMBlock.bmap and ram_list.dirty_memory both to all 1, this
means at the first round this sync is meaningless and is a duplicated
work.

Leaving RAMBlock->bmap blank on allocating would have a side effect on
migration_dirty_pages, since it is calculated from the result of
cpu_physical_memory_sync_dirty_bitmap(). To keep it right, we need to
set migration_dirty_pages to 0 in ram_state_init().

Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Reviewed-by: Juan Quintela <quintela@redhat.com>
Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 migration/ram.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/migration/ram.c b/migration/ram.c
index 03a9cce9f9..082aea9d23 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -3173,11 +3173,11 @@ static int ram_state_init(RAMState **rsp)
     QSIMPLEQ_INIT(&(*rsp)->src_page_requests);
=20
     /*
-     * Count the total number of pages used by ram blocks not including =
any
-     * gaps due to alignment or unplugs.
+     * This must match with the initial values of dirty bitmap.
+     * Currently we initialize the dirty bitmap to all zeros so
+     * here the total dirty page count is zero.
      */
-    (*rsp)->migration_dirty_pages =3D ram_bytes_total() >> TARGET_PAGE_B=
ITS;
-
+    (*rsp)->migration_dirty_pages =3D 0;
     ram_state_reset(*rsp);
=20
     return 0;
@@ -3192,8 +3192,16 @@ static void ram_list_init_bitmaps(void)
     if (ram_bytes_total()) {
         RAMBLOCK_FOREACH_NOT_IGNORED(block) {
             pages =3D block->max_length >> TARGET_PAGE_BITS;
+            /*
+             * The initial dirty bitmap for migration must be set with a=
ll
+             * ones to make sure we'll migrate every guest RAM page to
+             * destination.
+             * Here we didn't set RAMBlock.bmap simply because it is alr=
eady
+             * set in ram_list.dirty_memory[DIRTY_MEMORY_MIGRATION] in
+             * ram_block_add, and that's where we'll sync the dirty bitm=
aps.
+             * Here setting RAMBlock.bmap would be fine too but not nece=
ssary.
+             */
             block->bmap =3D bitmap_new(pages);
-            bitmap_set(block->bmap, 0, pages);
             if (migrate_postcopy_ram()) {
                 block->unsentmap =3D bitmap_new(pages);
                 bitmap_set(block->unsentmap, 0, pages);
--=20
2.21.0


