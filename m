Return-Path: <SRS0=gzPR=WL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EFD5C3A589
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Aug 2019 16:40:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DB15A206C1
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Aug 2019 16:40:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB15A206C1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44332 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hyInV-0007YS-Qd
	for qemu-devel@archiver.kernel.org; Thu, 15 Aug 2019 12:40:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47407)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1hyIji-0002eG-Hg
 for qemu-devel@nongnu.org; Thu, 15 Aug 2019 12:36:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1hyIjb-0003Ef-JY
 for qemu-devel@nongnu.org; Thu, 15 Aug 2019 12:36:26 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44620)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1hyIjb-0003EM-CD
 for qemu-devel@nongnu.org; Thu, 15 Aug 2019 12:36:19 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id AACE02A09A2;
 Thu, 15 Aug 2019 16:36:18 +0000 (UTC)
Received: from dgilbert-t580.localhost (ovpn-117-19.ams2.redhat.com
 [10.36.117.19])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 18EC73737;
 Thu, 15 Aug 2019 16:36:15 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
To: qemu-devel@nongnu.org
Date: Thu, 15 Aug 2019 17:34:50 +0100
Message-Id: <20190815163504.18937-20-dgilbert@redhat.com>
In-Reply-To: <20190815163504.18937-1-dgilbert@redhat.com>
References: <20190815163504.18937-1-dgilbert@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.38]); Thu, 15 Aug 2019 16:36:18 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 19/33] migration/postcopy: make
 PostcopyDiscardState a static variable
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
Cc: quintela@redhat.com, yury-kotov@yandex-team.ru,
 richardw.yang@linux.intel.com, marcandre.lureau@redhat.com,
 ivanren@tencent.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Wei Yang <richardw.yang@linux.intel.com>

In postcopy-ram.c, we provide three functions to discard certain
RAMBlock range:

  * postcopy_discard_send_init()
  * postcopy_discard_send_range()
  * postcopy_discard_send_finish()

Currently, we allocate/deallocate PostcopyDiscardState for each RAMBlock
on sending discard information to destination. This is not necessary and
the same data area could be reused for each RAMBlock.

This patch defines PostcopyDiscardState a static variable. By doing so:

  1) avoid memory allocation and deallocation to the system
  2) avoid potential failure of memory allocation
  3) hide some details for their users

Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>

Message-Id: <20190724010721.2146-1-richardw.yang@linux.intel.com>
Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 migration/postcopy-ram.c | 70 +++++++++++++++++-----------------------
 migration/postcopy-ram.h | 13 +++-----
 migration/ram.c          | 30 +++++++----------
 3 files changed, 46 insertions(+), 67 deletions(-)

diff --git a/migration/postcopy-ram.c b/migration/postcopy-ram.c
index 9faacacc9e..2cb1a69752 100644
--- a/migration/postcopy-ram.c
+++ b/migration/postcopy-ram.c
@@ -1377,22 +1377,16 @@ void postcopy_fault_thread_notify(MigrationIncomi=
ngState *mis)
  *   asking to discard individual ranges.
  *
  * @ms: The current migration state.
- * @offset: the bitmap offset of the named RAMBlock in the migration
- *   bitmap.
+ * @offset: the bitmap offset of the named RAMBlock in the migration bit=
map.
  * @name: RAMBlock that discards will operate on.
- *
- * returns: a new PDS.
  */
-PostcopyDiscardState *postcopy_discard_send_init(MigrationState *ms,
-                                                 const char *name)
+static PostcopyDiscardState pds =3D {0};
+void postcopy_discard_send_init(MigrationState *ms, const char *name)
 {
-    PostcopyDiscardState *res =3D g_malloc0(sizeof(PostcopyDiscardState)=
);
-
-    if (res) {
-        res->ramblock_name =3D name;
-    }
-
-    return res;
+    pds.ramblock_name =3D name;
+    pds.cur_entry =3D 0;
+    pds.nsentwords =3D 0;
+    pds.nsentcmds =3D 0;
 }
=20
 /**
@@ -1401,30 +1395,29 @@ PostcopyDiscardState *postcopy_discard_send_init(=
MigrationState *ms,
  *   be sent later.
  *
  * @ms: Current migration state.
- * @pds: Structure initialised by postcopy_discard_send_init().
  * @start,@length: a range of pages in the migration bitmap in the
  *   RAM block passed to postcopy_discard_send_init() (length=3D1 is one=
 page)
  */
-void postcopy_discard_send_range(MigrationState *ms, PostcopyDiscardStat=
e *pds,
-                                unsigned long start, unsigned long lengt=
h)
+void postcopy_discard_send_range(MigrationState *ms, unsigned long start=
,
+                                 unsigned long length)
 {
     size_t tp_size =3D qemu_target_page_size();
     /* Convert to byte offsets within the RAM block */
-    pds->start_list[pds->cur_entry] =3D start  * tp_size;
-    pds->length_list[pds->cur_entry] =3D length * tp_size;
-    trace_postcopy_discard_send_range(pds->ramblock_name, start, length)=
;
-    pds->cur_entry++;
-    pds->nsentwords++;
+    pds.start_list[pds.cur_entry] =3D start  * tp_size;
+    pds.length_list[pds.cur_entry] =3D length * tp_size;
+    trace_postcopy_discard_send_range(pds.ramblock_name, start, length);
+    pds.cur_entry++;
+    pds.nsentwords++;
=20
-    if (pds->cur_entry =3D=3D MAX_DISCARDS_PER_COMMAND) {
+    if (pds.cur_entry =3D=3D MAX_DISCARDS_PER_COMMAND) {
         /* Full set, ship it! */
         qemu_savevm_send_postcopy_ram_discard(ms->to_dst_file,
-                                              pds->ramblock_name,
-                                              pds->cur_entry,
-                                              pds->start_list,
-                                              pds->length_list);
-        pds->nsentcmds++;
-        pds->cur_entry =3D 0;
+                                              pds.ramblock_name,
+                                              pds.cur_entry,
+                                              pds.start_list,
+                                              pds.length_list);
+        pds.nsentcmds++;
+        pds.cur_entry =3D 0;
     }
 }
=20
@@ -1433,24 +1426,21 @@ void postcopy_discard_send_range(MigrationState *=
ms, PostcopyDiscardState *pds,
  * bitmap code. Sends any outstanding discard messages, frees the PDS
  *
  * @ms: Current migration state.
- * @pds: Structure initialised by postcopy_discard_send_init().
  */
-void postcopy_discard_send_finish(MigrationState *ms, PostcopyDiscardSta=
te *pds)
+void postcopy_discard_send_finish(MigrationState *ms)
 {
     /* Anything unsent? */
-    if (pds->cur_entry) {
+    if (pds.cur_entry) {
         qemu_savevm_send_postcopy_ram_discard(ms->to_dst_file,
-                                              pds->ramblock_name,
-                                              pds->cur_entry,
-                                              pds->start_list,
-                                              pds->length_list);
-        pds->nsentcmds++;
+                                              pds.ramblock_name,
+                                              pds.cur_entry,
+                                              pds.start_list,
+                                              pds.length_list);
+        pds.nsentcmds++;
     }
=20
-    trace_postcopy_discard_send_finish(pds->ramblock_name, pds->nsentwor=
ds,
-                                       pds->nsentcmds);
-
-    g_free(pds);
+    trace_postcopy_discard_send_finish(pds.ramblock_name, pds.nsentwords=
,
+                                       pds.nsentcmds);
 }
=20
 /*
diff --git a/migration/postcopy-ram.h b/migration/postcopy-ram.h
index 9d55536fd1..9c8bd2bae0 100644
--- a/migration/postcopy-ram.h
+++ b/migration/postcopy-ram.h
@@ -43,10 +43,8 @@ int postcopy_ram_prepare_discard(MigrationIncomingStat=
e *mis);
=20
 /*
  * Called at the start of each RAMBlock by the bitmap code.
- * Returns a new PDS
  */
-PostcopyDiscardState *postcopy_discard_send_init(MigrationState *ms,
-                                                 const char *name);
+void postcopy_discard_send_init(MigrationState *ms, const char *name);
=20
 /*
  * Called by the bitmap code for each chunk to discard.
@@ -55,15 +53,14 @@ PostcopyDiscardState *postcopy_discard_send_init(Migr=
ationState *ms,
  * @start,@length: a range of pages in the migration bitmap in the
  *  RAM block passed to postcopy_discard_send_init() (length=3D1 is one =
page)
  */
-void postcopy_discard_send_range(MigrationState *ms, PostcopyDiscardStat=
e *pds,
-                                 unsigned long start, unsigned long leng=
th);
+void postcopy_discard_send_range(MigrationState *ms, unsigned long start=
,
+                                 unsigned long length);
=20
 /*
  * Called at the end of each RAMBlock by the bitmap code.
- * Sends any outstanding discard messages, frees the PDS.
+ * Sends any outstanding discard messages.
  */
-void postcopy_discard_send_finish(MigrationState *ms,
-                                  PostcopyDiscardState *pds);
+void postcopy_discard_send_finish(MigrationState *ms);
=20
 /*
  * Place a page (from) at (host) efficiently
diff --git a/migration/ram.c b/migration/ram.c
index a44e9c0abc..f428639af5 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -2850,12 +2850,9 @@ void ram_postcopy_migrated_memory_release(Migratio=
nState *ms)
  *       with the dirtymap; so a '1' means it's either dirty or unsent.
  *
  * @ms: current migration state
- * @pds: state for postcopy
  * @block: RAMBlock to discard
  */
-static int postcopy_send_discard_bm_ram(MigrationState *ms,
-                                        PostcopyDiscardState *pds,
-                                        RAMBlock *block)
+static int postcopy_send_discard_bm_ram(MigrationState *ms, RAMBlock *bl=
ock)
 {
     unsigned long end =3D block->used_length >> TARGET_PAGE_BITS;
     unsigned long current;
@@ -2876,7 +2873,7 @@ static int postcopy_send_discard_bm_ram(MigrationSt=
ate *ms,
         } else {
             discard_length =3D zero - one;
         }
-        postcopy_discard_send_range(ms, pds, one, discard_length);
+        postcopy_discard_send_range(ms, one, discard_length);
         current =3D one + discard_length;
     }
=20
@@ -2902,16 +2899,15 @@ static int postcopy_each_ram_send_discard(Migrati=
onState *ms)
     int ret;
=20
     RAMBLOCK_FOREACH_NOT_IGNORED(block) {
-        PostcopyDiscardState *pds =3D
-            postcopy_discard_send_init(ms, block->idstr);
+        postcopy_discard_send_init(ms, block->idstr);
=20
         /*
          * Postcopy sends chunks of bitmap over the wire, but it
          * just needs indexes at this point, avoids it having
          * target page specific code.
          */
-        ret =3D postcopy_send_discard_bm_ram(ms, pds, block);
-        postcopy_discard_send_finish(ms, pds);
+        ret =3D postcopy_send_discard_bm_ram(ms, block);
+        postcopy_discard_send_finish(ms);
         if (ret) {
             return ret;
         }
@@ -2934,11 +2930,9 @@ static int postcopy_each_ram_send_discard(Migratio=
nState *ms)
  * @unsent_pass: if true we need to canonicalize partially unsent host p=
ages
  *               otherwise we need to canonicalize partially dirty host =
pages
  * @block: block that contains the page we want to canonicalize
- * @pds: state for postcopy
  */
 static void postcopy_chunk_hostpages_pass(MigrationState *ms, bool unsen=
t_pass,
-                                          RAMBlock *block,
-                                          PostcopyDiscardState *pds)
+                                          RAMBlock *block)
 {
     RAMState *rs =3D ram_state;
     unsigned long *bitmap =3D block->bmap;
@@ -3018,8 +3012,7 @@ static void postcopy_chunk_hostpages_pass(Migration=
State *ms, bool unsent_pass,
                  *     (any partially sent pages were already discarded
                  *     by the previous unsent_pass)
                  */
-                postcopy_discard_send_range(ms, pds, fixup_start_addr,
-                                            host_ratio);
+                postcopy_discard_send_range(ms, fixup_start_addr, host_r=
atio);
             }
=20
             /* Clean up the bitmap */
@@ -3062,18 +3055,17 @@ static void postcopy_chunk_hostpages_pass(Migrati=
onState *ms, bool unsent_pass,
  */
 static int postcopy_chunk_hostpages(MigrationState *ms, RAMBlock *block)
 {
-    PostcopyDiscardState *pds =3D
-        postcopy_discard_send_init(ms, block->idstr);
+    postcopy_discard_send_init(ms, block->idstr);
=20
     /* First pass: Discard all partially sent host pages */
-    postcopy_chunk_hostpages_pass(ms, true, block, pds);
+    postcopy_chunk_hostpages_pass(ms, true, block);
     /*
      * Second pass: Ensure that all partially dirty host pages are made
      * fully dirty.
      */
-    postcopy_chunk_hostpages_pass(ms, false, block, pds);
+    postcopy_chunk_hostpages_pass(ms, false, block);
=20
-    postcopy_discard_send_finish(ms, pds);
+    postcopy_discard_send_finish(ms);
     return 0;
 }
=20
--=20
2.21.0


