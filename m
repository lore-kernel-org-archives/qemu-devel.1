Return-Path: <SRS0=N0XV=XP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4497FC3A5A2
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Sep 2019 15:56:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 136052086A
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Sep 2019 15:56:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 136052086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32878 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iBLGi-0007ny-Jj
	for qemu-devel@archiver.kernel.org; Fri, 20 Sep 2019 11:56:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43947)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iBKpk-0000pP-1k
 for qemu-devel@nongnu.org; Fri, 20 Sep 2019 11:28:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iBKpi-0004Um-8u
 for qemu-devel@nongnu.org; Fri, 20 Sep 2019 11:28:31 -0400
Received: from mx1.redhat.com ([209.132.183.28]:21200)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1iBKpe-0004QY-PY; Fri, 20 Sep 2019 11:28:27 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 6B934C057F88;
 Fri, 20 Sep 2019 15:28:25 +0000 (UTC)
Received: from localhost (unknown [10.40.205.102])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id CB8B15D9C3;
 Fri, 20 Sep 2019 15:28:24 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH 08/22] quorum: Store children in own structure
Date: Fri, 20 Sep 2019 17:27:50 +0200
Message-Id: <20190920152804.12875-9-mreitz@redhat.com>
In-Reply-To: <20190920152804.12875-1-mreitz@redhat.com>
References: <20190920152804.12875-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.32]); Fri, 20 Sep 2019 15:28:25 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: Kevin Wolf <kwolf@redhat.com>, Alberto Garcia <berto@igalia.com>,
 qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This will be useful when we want to store additional attributes for each
child.

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 block/quorum.c | 58 ++++++++++++++++++++++++++++----------------------
 1 file changed, 33 insertions(+), 25 deletions(-)

diff --git a/block/quorum.c b/block/quorum.c
index 17b439056f..cf2171cc74 100644
--- a/block/quorum.c
+++ b/block/quorum.c
@@ -65,9 +65,13 @@ typedef struct QuorumVotes {
     bool (*compare)(QuorumVoteValue *a, QuorumVoteValue *b);
 } QuorumVotes;
=20
+typedef struct QuorumChild {
+    BdrvChild *child;
+} QuorumChild;
+
 /* the following structure holds the state of one quorum instance */
 typedef struct BDRVQuorumState {
-    BdrvChild **children;  /* children BlockDriverStates */
+    QuorumChild *children;
     int num_children;      /* children count */
     unsigned next_child_index;  /* the index of the next child that shou=
ld
                                  * be added
@@ -264,7 +268,7 @@ static void quorum_report_bad_versions(BDRVQuorumStat=
e *s,
         }
         QLIST_FOREACH(item, &version->items, next) {
             quorum_report_bad(QUORUM_OP_TYPE_READ, acb->offset, acb->byt=
es,
-                              s->children[item->index]->bs->node_name, 0=
);
+                              s->children[item->index].child->bs->node_n=
ame, 0);
         }
     }
 }
@@ -279,7 +283,7 @@ static void quorum_rewrite_entry(void *opaque)
      * corrupted data.
      * Mask out BDRV_REQ_WRITE_UNCHANGED because this overwrites the
      * area with different data from the other children. */
-    bdrv_co_pwritev(s->children[co->idx], acb->offset, acb->bytes,
+    bdrv_co_pwritev(s->children[co->idx].child, acb->offset, acb->bytes,
                     acb->qiov, acb->flags & ~BDRV_REQ_WRITE_UNCHANGED);
=20
     /* Wake up the caller after the last rewrite */
@@ -578,8 +582,8 @@ static void read_quorum_children_entry(void *opaque)
     int i =3D co->idx;
     QuorumChildRequest *sacb =3D &acb->qcrs[i];
=20
-    sacb->bs =3D s->children[i]->bs;
-    sacb->ret =3D bdrv_co_preadv(s->children[i], acb->offset, acb->bytes=
,
+    sacb->bs =3D s->children[i].child->bs;
+    sacb->ret =3D bdrv_co_preadv(s->children[i].child, acb->offset, acb-=
>bytes,
                                &acb->qcrs[i].qiov, 0);
=20
     if (sacb->ret =3D=3D 0) {
@@ -605,7 +609,8 @@ static int read_quorum_children(QuorumAIOCB *acb)
=20
     acb->children_read =3D s->num_children;
     for (i =3D 0; i < s->num_children; i++) {
-        acb->qcrs[i].buf =3D qemu_blockalign(s->children[i]->bs, acb->qi=
ov->size);
+        acb->qcrs[i].buf =3D qemu_blockalign(s->children[i].child->bs,
+                                           acb->qiov->size);
         qemu_iovec_init(&acb->qcrs[i].qiov, acb->qiov->niov);
         qemu_iovec_clone(&acb->qcrs[i].qiov, acb->qiov, acb->qcrs[i].buf=
);
     }
@@ -647,8 +652,8 @@ static int read_fifo_child(QuorumAIOCB *acb)
     /* We try to read the next child in FIFO order if we failed to read =
*/
     do {
         n =3D acb->children_read++;
-        acb->qcrs[n].bs =3D s->children[n]->bs;
-        ret =3D bdrv_co_preadv(s->children[n], acb->offset, acb->bytes,
+        acb->qcrs[n].bs =3D s->children[n].child->bs;
+        ret =3D bdrv_co_preadv(s->children[n].child, acb->offset, acb->b=
ytes,
                              acb->qiov, 0);
         if (ret < 0) {
             quorum_report_bad_acb(&acb->qcrs[n], ret);
@@ -688,8 +693,8 @@ static void write_quorum_entry(void *opaque)
     int i =3D co->idx;
     QuorumChildRequest *sacb =3D &acb->qcrs[i];
=20
-    sacb->bs =3D s->children[i]->bs;
-    sacb->ret =3D bdrv_co_pwritev(s->children[i], acb->offset, acb->byte=
s,
+    sacb->bs =3D s->children[i].child->bs;
+    sacb->ret =3D bdrv_co_pwritev(s->children[i].child, acb->offset, acb=
->bytes,
                                 acb->qiov, acb->flags);
     if (sacb->ret =3D=3D 0) {
         acb->success_count++;
@@ -743,12 +748,12 @@ static int64_t quorum_getlength(BlockDriverState *b=
s)
     int i;
=20
     /* check that all file have the same length */
-    result =3D bdrv_getlength(s->children[0]->bs);
+    result =3D bdrv_getlength(s->children[0].child->bs);
     if (result < 0) {
         return result;
     }
     for (i =3D 1; i < s->num_children; i++) {
-        int64_t value =3D bdrv_getlength(s->children[i]->bs);
+        int64_t value =3D bdrv_getlength(s->children[i].child->bs);
         if (value < 0) {
             return value;
         }
@@ -774,10 +779,10 @@ static coroutine_fn int quorum_co_flush(BlockDriver=
State *bs)
     error_votes.compare =3D quorum_64bits_compare;
=20
     for (i =3D 0; i < s->num_children; i++) {
-        result =3D bdrv_co_flush(s->children[i]->bs);
+        result =3D bdrv_co_flush(s->children[i].child->bs);
         if (result) {
             quorum_report_bad(QUORUM_OP_TYPE_FLUSH, 0, 0,
-                              s->children[i]->bs->node_name, result);
+                              s->children[i].child->bs->node_name, resul=
t);
             result_value.l =3D result;
             quorum_count_vote(&error_votes, &result_value, i);
         } else {
@@ -803,7 +808,7 @@ static bool quorum_recurse_is_first_non_filter(BlockD=
riverState *bs,
     int i;
=20
     for (i =3D 0; i < s->num_children; i++) {
-        bool perm =3D bdrv_recurse_is_first_non_filter(s->children[i]->b=
s,
+        bool perm =3D bdrv_recurse_is_first_non_filter(s->children[i].ch=
ild->bs,
                                                      candidate);
         if (perm) {
             return true;
@@ -932,7 +937,7 @@ static int quorum_open(BlockDriverState *bs, QDict *o=
ptions, int flags,
     }
=20
     /* allocate the children array */
-    s->children =3D g_new0(BdrvChild *, s->num_children);
+    s->children =3D g_new0(QuorumChild, s->num_children);
     opened =3D g_new0(bool, s->num_children);
=20
     for (i =3D 0; i < s->num_children; i++) {
@@ -940,8 +945,9 @@ static int quorum_open(BlockDriverState *bs, QDict *o=
ptions, int flags,
         ret =3D snprintf(indexstr, 32, "children.%d", i);
         assert(ret < 32);
=20
-        s->children[i] =3D bdrv_open_child(NULL, options, indexstr, bs,
-                                         &child_format, false, &local_er=
r);
+        s->children[i].child =3D bdrv_open_child(NULL, options, indexstr=
, bs,
+                                               &child_format, false,
+                                               &local_err);
         if (local_err) {
             ret =3D -EINVAL;
             goto close_exit;
@@ -962,7 +968,7 @@ close_exit:
         if (!opened[i]) {
             continue;
         }
-        bdrv_unref_child(bs, s->children[i]);
+        bdrv_unref_child(bs, s->children[i].child);
     }
     g_free(s->children);
     g_free(opened);
@@ -979,7 +985,7 @@ static void quorum_close(BlockDriverState *bs)
     int i;
=20
     for (i =3D 0; i < s->num_children; i++) {
-        bdrv_unref_child(bs, s->children[i]);
+        bdrv_unref_child(bs, s->children[i].child);
     }
=20
     g_free(s->children);
@@ -1022,8 +1028,10 @@ static void quorum_add_child(BlockDriverState *bs,=
 BlockDriverState *child_bs,
         s->next_child_index--;
         goto out;
     }
-    s->children =3D g_renew(BdrvChild *, s->children, s->num_children + =
1);
-    s->children[s->num_children++] =3D child;
+    s->children =3D g_renew(QuorumChild, s->children, s->num_children + =
1);
+    s->children[s->num_children++] =3D (QuorumChild){
+        .child =3D child,
+    };
=20
 out:
     bdrv_drained_end(bs);
@@ -1036,7 +1044,7 @@ static void quorum_del_child(BlockDriverState *bs, =
BdrvChild *child,
     int i;
=20
     for (i =3D 0; i < s->num_children; i++) {
-        if (s->children[i] =3D=3D child) {
+        if (s->children[i].child =3D=3D child) {
             break;
         }
     }
@@ -1059,7 +1067,7 @@ static void quorum_del_child(BlockDriverState *bs, =
BdrvChild *child,
     /* We can safely remove this child now */
     memmove(&s->children[i], &s->children[i + 1],
             (s->num_children - i - 1) * sizeof(BdrvChild *));
-    s->children =3D g_renew(BdrvChild *, s->children, --s->num_children)=
;
+    s->children =3D g_renew(QuorumChild, s->children, --s->num_children)=
;
     bdrv_unref_child(bs, child);
=20
     bdrv_drained_end(bs);
@@ -1100,7 +1108,7 @@ static void quorum_gather_child_options(BlockDriver=
State *bs, QDict *target,
=20
     for (i =3D 0; i < s->num_children; i++) {
         qlist_append(children_list,
-                     qobject_ref(s->children[i]->bs->full_open_options))=
;
+                     qobject_ref(s->children[i].child->bs->full_open_opt=
ions));
     }
 }
=20
--=20
2.21.0


