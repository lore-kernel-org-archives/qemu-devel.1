Return-Path: <SRS0=SZz4=XU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 264A3C432C2
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2019 15:22:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EB2242054F
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2019 15:22:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB2242054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53588 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iD97g-0003Pv-Ua
	for qemu-devel@archiver.kernel.org; Wed, 25 Sep 2019 11:22:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57588)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1iD8ne-0000eO-Kq
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 11:01:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1iD8nc-0004aF-PI
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 11:01:50 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38965)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1iD8nc-0004Zn-GO
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 11:01:48 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id AB68930B6452;
 Wed, 25 Sep 2019 15:01:47 +0000 (UTC)
Received: from dgilbert-t580.localhost (ovpn-117-251.ams2.redhat.com
 [10.36.117.251])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4A0965C21F;
 Wed, 25 Sep 2019 15:01:46 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
To: qemu-devel@nongnu.org, quintela@redhat.com, peterx@redhat.com,
 marcandre.lureau@redhat.com, richardw.yang@linux.intel.com,
 alex.benee@linaro.org
Subject: [PULL 3/9] migration/postcopy: unsentmap is not necessary for postcopy
Date: Wed, 25 Sep 2019 16:01:24 +0100
Message-Id: <20190925150130.12303-4-dgilbert@redhat.com>
In-Reply-To: <20190925150130.12303-1-dgilbert@redhat.com>
References: <20190925150130.12303-1-dgilbert@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.47]); Wed, 25 Sep 2019 15:01:47 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Wei Yang <richardw.yang@linux.intel.com>

Commit f3f491fcd6dd594ba695 ('Postcopy: Maintain unsentmap') introduced
unsentmap to track not yet sent pages.

This is not necessary since:

    * unsentmap is a sub-set of bmap before postcopy start
    * unsentmap is the summation of bmap and unsentmap after canonicalizi=
ng

This patch just removes it.

Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
Message-Id: <20190819061843.28642-3-richardw.yang@linux.intel.com>
Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 include/exec/ram_addr.h |  6 ----
 migration/ram.c         | 80 ++++++++---------------------------------
 2 files changed, 14 insertions(+), 72 deletions(-)

diff --git a/include/exec/ram_addr.h b/include/exec/ram_addr.h
index a327a80cfe..e96e621de5 100644
--- a/include/exec/ram_addr.h
+++ b/include/exec/ram_addr.h
@@ -44,12 +44,6 @@ struct RAMBlock {
     size_t page_size;
     /* dirty bitmap used during migration */
     unsigned long *bmap;
-    /* bitmap of pages that haven't been sent even once
-     * only maintained and used in postcopy at the moment
-     * where it's used to send the dirtymap at the start
-     * of the postcopy phase
-     */
-    unsigned long *unsentmap;
     /* bitmap of already received pages in postcopy */
     unsigned long *receivedmap;
=20
diff --git a/migration/ram.c b/migration/ram.c
index 57d1a4627e..a8b1aa2597 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -2348,7 +2348,7 @@ static bool get_queued_page(RAMState *rs, PageSearc=
hStatus *pss)
             dirty =3D test_bit(page, block->bmap);
             if (!dirty) {
                 trace_get_queued_page_not_dirty(block->idstr, (uint64_t)=
offset,
-                       page, test_bit(page, block->unsentmap));
+                       page, test_bit(page, block->bmap));
             } else {
                 trace_get_queued_page(block->idstr, (uint64_t)offset, pa=
ge);
             }
@@ -2619,10 +2619,6 @@ static int ram_save_host_page(RAMState *rs, PageSe=
archStatus *pss,
         }
=20
         pages +=3D tmppages;
-        if (pss->block->unsentmap) {
-            clear_bit(pss->page, pss->block->unsentmap);
-        }
-
         pss->page++;
     } while ((pss->page & (pagesize_bits - 1)) &&
              offset_in_ramblock(pss->block, pss->page << TARGET_PAGE_BIT=
S));
@@ -2776,8 +2772,6 @@ static void ram_save_cleanup(void *opaque)
         block->clear_bmap =3D NULL;
         g_free(block->bmap);
         block->bmap =3D NULL;
-        g_free(block->unsentmap);
-        block->unsentmap =3D NULL;
     }
=20
     xbzrle_cleanup();
@@ -2857,8 +2851,6 @@ void ram_postcopy_migrated_memory_release(Migration=
State *ms)
  * Returns zero on success
  *
  * Callback from postcopy_each_ram_send_discard for each RAMBlock
- * Note: At this point the 'unsentmap' is the processed bitmap combined
- *       with the dirtymap; so a '1' means it's either dirty or unsent.
  *
  * @ms: current migration state
  * @block: RAMBlock to discard
@@ -2867,17 +2859,17 @@ static int postcopy_send_discard_bm_ram(Migration=
State *ms, RAMBlock *block)
 {
     unsigned long end =3D block->used_length >> TARGET_PAGE_BITS;
     unsigned long current;
-    unsigned long *unsentmap =3D block->unsentmap;
+    unsigned long *bitmap =3D block->bmap;
=20
     for (current =3D 0; current < end; ) {
-        unsigned long one =3D find_next_bit(unsentmap, end, current);
+        unsigned long one =3D find_next_bit(bitmap, end, current);
         unsigned long zero, discard_length;
=20
         if (one >=3D end) {
             break;
         }
=20
-        zero =3D find_next_zero_bit(unsentmap, end, one + 1);
+        zero =3D find_next_zero_bit(bitmap, end, one + 1);
=20
         if (zero >=3D end) {
             discard_length =3D end - one;
@@ -2938,16 +2930,12 @@ static int postcopy_each_ram_send_discard(Migrati=
onState *ms)
  * clean, not a mix.  This function canonicalizes the bitmaps.
  *
  * @ms: current migration state
- * @unsent_pass: if true we need to canonicalize partially unsent host p=
ages
- *               otherwise we need to canonicalize partially dirty host =
pages
  * @block: block that contains the page we want to canonicalize
  */
-static void postcopy_chunk_hostpages_pass(MigrationState *ms, bool unsen=
t_pass,
-                                          RAMBlock *block)
+static void postcopy_chunk_hostpages_pass(MigrationState *ms, RAMBlock *=
block)
 {
     RAMState *rs =3D ram_state;
     unsigned long *bitmap =3D block->bmap;
-    unsigned long *unsentmap =3D block->unsentmap;
     unsigned int host_ratio =3D block->page_size / TARGET_PAGE_SIZE;
     unsigned long pages =3D block->used_length >> TARGET_PAGE_BITS;
     unsigned long run_start;
@@ -2957,13 +2945,8 @@ static void postcopy_chunk_hostpages_pass(Migratio=
nState *ms, bool unsent_pass,
         return;
     }
=20
-    if (unsent_pass) {
-        /* Find a sent page */
-        run_start =3D find_next_zero_bit(unsentmap, pages, 0);
-    } else {
-        /* Find a dirty page */
-        run_start =3D find_next_bit(bitmap, pages, 0);
-    }
+    /* Find a dirty page */
+    run_start =3D find_next_bit(bitmap, pages, 0);
=20
     while (run_start < pages) {
=20
@@ -2973,11 +2956,7 @@ static void postcopy_chunk_hostpages_pass(Migratio=
nState *ms, bool unsent_pass,
          */
         if (QEMU_IS_ALIGNED(run_start, host_ratio)) {
             /* Find the end of this run */
-            if (unsent_pass) {
-                run_start =3D find_next_bit(unsentmap, pages, run_start =
+ 1);
-            } else {
-                run_start =3D find_next_zero_bit(bitmap, pages, run_star=
t + 1);
-            }
+            run_start =3D find_next_zero_bit(bitmap, pages, run_start + =
1);
             /*
              * If the end isn't at the start of a host page, then the
              * run doesn't finish at the end of a host page
@@ -2994,9 +2973,6 @@ static void postcopy_chunk_hostpages_pass(Migration=
State *ms, bool unsent_pass,
             /* Clean up the bitmap */
             for (page =3D fixup_start_addr;
                  page < fixup_start_addr + host_ratio; page++) {
-                /* All pages in this host page are now not sent */
-                set_bit(page, unsentmap);
-
                 /*
                  * Remark them as dirty, updating the count for any page=
s
                  * that weren't previously dirty.
@@ -3005,13 +2981,8 @@ static void postcopy_chunk_hostpages_pass(Migratio=
nState *ms, bool unsent_pass,
             }
         }
=20
-        if (unsent_pass) {
-            /* Find the next sent page for the next iteration */
-            run_start =3D find_next_zero_bit(unsentmap, pages, run_start=
);
-        } else {
-            /* Find the next dirty page for the next iteration */
-            run_start =3D find_next_bit(bitmap, pages, run_start);
-        }
+        /* Find the next dirty page for the next iteration */
+        run_start =3D find_next_bit(bitmap, pages, run_start);
     }
 }
=20
@@ -3033,13 +3004,10 @@ static int postcopy_chunk_hostpages(MigrationStat=
e *ms, RAMBlock *block)
 {
     postcopy_discard_send_init(ms, block->idstr);
=20
-    /* First pass: Discard all partially sent host pages */
-    postcopy_chunk_hostpages_pass(ms, true, block);
     /*
-     * Second pass: Ensure that all partially dirty host pages are made
-     * fully dirty.
+     * Ensure that all partially dirty host pages are made fully dirty.
      */
-    postcopy_chunk_hostpages_pass(ms, false, block);
+    postcopy_chunk_hostpages_pass(ms, block);
=20
     postcopy_discard_send_finish(ms);
     return 0;
@@ -3077,19 +3045,6 @@ int ram_postcopy_send_discard_bitmap(MigrationStat=
e *ms)
     rs->last_page =3D 0;
=20
     RAMBLOCK_FOREACH_NOT_IGNORED(block) {
-        unsigned long pages =3D block->used_length >> TARGET_PAGE_BITS;
-        unsigned long *bitmap =3D block->bmap;
-        unsigned long *unsentmap =3D block->unsentmap;
-
-        if (!unsentmap) {
-            /* We don't have a safe way to resize the sentmap, so
-             * if the bitmap was resized it will be NULL at this
-             * point.
-             */
-            error_report("migration ram resized during precopy phase");
-            rcu_read_unlock();
-            return -EINVAL;
-        }
         /* Deal with TPS !=3D HPS and huge pages */
         ret =3D postcopy_chunk_hostpages(ms, block);
         if (ret) {
@@ -3097,12 +3052,9 @@ int ram_postcopy_send_discard_bitmap(MigrationStat=
e *ms)
             return ret;
         }
=20
-        /*
-         * Update the unsentmap to be unsentmap =3D unsentmap | dirty
-         */
-        bitmap_or(unsentmap, unsentmap, bitmap, pages);
 #ifdef DEBUG_POSTCOPY
-        ram_debug_dump_bitmap(unsentmap, true, pages);
+        ram_debug_dump_bitmap(block->bmap, true,
+                              block->used_length >> TARGET_PAGE_BITS);
 #endif
     }
     trace_ram_postcopy_send_discard_bitmap();
@@ -3270,10 +3222,6 @@ static void ram_list_init_bitmaps(void)
             bitmap_set(block->bmap, 0, pages);
             block->clear_bmap_shift =3D shift;
             block->clear_bmap =3D bitmap_new(clear_bmap_size(pages, shif=
t));
-            if (migrate_postcopy_ram()) {
-                block->unsentmap =3D bitmap_new(pages);
-                bitmap_set(block->unsentmap, 0, pages);
-            }
         }
     }
 }
--=20
2.21.0


