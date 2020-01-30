Return-Path: <SRS0=hbhd=3T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A45CDC2D0DB
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2020 21:58:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6CEB520708
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2020 21:58:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PgtH3nBV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6CEB520708
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39924 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ixHpe-0002ce-Lp
	for qemu-devel@archiver.kernel.org; Thu, 30 Jan 2020 16:58:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33325)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1ixHcR-0004oO-Ki
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 16:45:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1ixHcP-0003yG-Tv
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 16:44:59 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:34630
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1ixHcP-0003xy-Q6
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 16:44:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580420697;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gDdCF/ChIzOZEc+2w4m/T5Xyag1Kq9vTzGsn7kFoMuI=;
 b=PgtH3nBVfB0S/nbbq74wmN9VOkQrX90g6Nh2YHL40oNF1D5dSpH9zMwWas86AoaTZMkecf
 EPchB1F09h0QCB0/YA559OMGsy9/MC/b7O9uPa2HBh1uGxh5CvdPAqlYpuk5IlGsB1+83f
 2KQStz4YkiG3tmDJAI2SoUwF3wOdKxE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-407-zr6e0kvOML68aIDgZntdNA-1; Thu, 30 Jan 2020 16:44:53 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 951E1108C254;
 Thu, 30 Jan 2020 21:44:52 +0000 (UTC)
Received: from localhost (ovpn-204-145.brq.redhat.com [10.40.204.145])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 0310B88840;
 Thu, 30 Jan 2020 21:44:51 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH v3 08/21] quorum: Store children in own structure
Date: Thu, 30 Jan 2020 22:44:18 +0100
Message-Id: <20200130214431.333510-9-mreitz@redhat.com>
In-Reply-To: <20200130214431.333510-1-mreitz@redhat.com>
References: <20200130214431.333510-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: zr6e0kvOML68aIDgZntdNA-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This will be useful when we want to store additional attributes for each
child.

Signed-off-by: Max Reitz <mreitz@redhat.com>
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 block/quorum.c | 64 ++++++++++++++++++++++++++++----------------------
 1 file changed, 36 insertions(+), 28 deletions(-)

diff --git a/block/quorum.c b/block/quorum.c
index 17b439056f..59cd524502 100644
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
     unsigned next_child_index;  /* the index of the next child that should
                                  * be added
@@ -264,7 +268,7 @@ static void quorum_report_bad_versions(BDRVQuorumState =
*s,
         }
         QLIST_FOREACH(item, &version->items, next) {
             quorum_report_bad(QUORUM_OP_TYPE_READ, acb->offset, acb->bytes=
,
-                              s->children[item->index]->bs->node_name, 0);
+                              s->children[item->index].child->bs->node_nam=
e, 0);
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
-    sacb->ret =3D bdrv_co_preadv(s->children[i], acb->offset, acb->bytes,
+    sacb->bs =3D s->children[i].child->bs;
+    sacb->ret =3D bdrv_co_preadv(s->children[i].child, acb->offset, acb->b=
ytes,
                                &acb->qcrs[i].qiov, 0);
=20
     if (sacb->ret =3D=3D 0) {
@@ -605,7 +609,8 @@ static int read_quorum_children(QuorumAIOCB *acb)
=20
     acb->children_read =3D s->num_children;
     for (i =3D 0; i < s->num_children; i++) {
-        acb->qcrs[i].buf =3D qemu_blockalign(s->children[i]->bs, acb->qiov=
->size);
+        acb->qcrs[i].buf =3D qemu_blockalign(s->children[i].child->bs,
+                                           acb->qiov->size);
         qemu_iovec_init(&acb->qcrs[i].qiov, acb->qiov->niov);
         qemu_iovec_clone(&acb->qcrs[i].qiov, acb->qiov, acb->qcrs[i].buf);
     }
@@ -647,8 +652,8 @@ static int read_fifo_child(QuorumAIOCB *acb)
     /* We try to read the next child in FIFO order if we failed to read */
     do {
         n =3D acb->children_read++;
-        acb->qcrs[n].bs =3D s->children[n]->bs;
-        ret =3D bdrv_co_preadv(s->children[n], acb->offset, acb->bytes,
+        acb->qcrs[n].bs =3D s->children[n].child->bs;
+        ret =3D bdrv_co_preadv(s->children[n].child, acb->offset, acb->byt=
es,
                              acb->qiov, 0);
         if (ret < 0) {
             quorum_report_bad_acb(&acb->qcrs[n], ret);
@@ -688,8 +693,8 @@ static void write_quorum_entry(void *opaque)
     int i =3D co->idx;
     QuorumChildRequest *sacb =3D &acb->qcrs[i];
=20
-    sacb->bs =3D s->children[i]->bs;
-    sacb->ret =3D bdrv_co_pwritev(s->children[i], acb->offset, acb->bytes,
+    sacb->bs =3D s->children[i].child->bs;
+    sacb->ret =3D bdrv_co_pwritev(s->children[i].child, acb->offset, acb->=
bytes,
                                 acb->qiov, acb->flags);
     if (sacb->ret =3D=3D 0) {
         acb->success_count++;
@@ -743,12 +748,12 @@ static int64_t quorum_getlength(BlockDriverState *bs)
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
@@ -774,10 +779,10 @@ static coroutine_fn int quorum_co_flush(BlockDriverSt=
ate *bs)
     error_votes.compare =3D quorum_64bits_compare;
=20
     for (i =3D 0; i < s->num_children; i++) {
-        result =3D bdrv_co_flush(s->children[i]->bs);
+        result =3D bdrv_co_flush(s->children[i].child->bs);
         if (result) {
             quorum_report_bad(QUORUM_OP_TYPE_FLUSH, 0, 0,
-                              s->children[i]->bs->node_name, result);
+                              s->children[i].child->bs->node_name, result)=
;
             result_value.l =3D result;
             quorum_count_vote(&error_votes, &result_value, i);
         } else {
@@ -803,7 +808,7 @@ static bool quorum_recurse_is_first_non_filter(BlockDri=
verState *bs,
     int i;
=20
     for (i =3D 0; i < s->num_children; i++) {
-        bool perm =3D bdrv_recurse_is_first_non_filter(s->children[i]->bs,
+        bool perm =3D bdrv_recurse_is_first_non_filter(s->children[i].chil=
d->bs,
                                                      candidate);
         if (perm) {
             return true;
@@ -932,7 +937,7 @@ static int quorum_open(BlockDriverState *bs, QDict *opt=
ions, int flags,
     }
=20
     /* allocate the children array */
-    s->children =3D g_new0(BdrvChild *, s->num_children);
+    s->children =3D g_new0(QuorumChild, s->num_children);
     opened =3D g_new0(bool, s->num_children);
=20
     for (i =3D 0; i < s->num_children; i++) {
@@ -940,8 +945,9 @@ static int quorum_open(BlockDriverState *bs, QDict *opt=
ions, int flags,
         ret =3D snprintf(indexstr, 32, "children.%d", i);
         assert(ret < 32);
=20
-        s->children[i] =3D bdrv_open_child(NULL, options, indexstr, bs,
-                                         &child_format, false, &local_err)=
;
+        s->children[i].child =3D bdrv_open_child(NULL, options, indexstr, =
bs,
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
@@ -998,8 +1004,8 @@ static void quorum_add_child(BlockDriverState *bs, Blo=
ckDriverState *child_bs,
         return;
     }
=20
-    assert(s->num_children <=3D INT_MAX / sizeof(BdrvChild *));
-    if (s->num_children =3D=3D INT_MAX / sizeof(BdrvChild *) ||
+    assert(s->num_children <=3D INT_MAX / sizeof(QuorumChild));
+    if (s->num_children =3D=3D INT_MAX / sizeof(QuorumChild) ||
         s->next_child_index =3D=3D UINT_MAX) {
         error_setg(errp, "Too many children");
         return;
@@ -1022,8 +1028,10 @@ static void quorum_add_child(BlockDriverState *bs, B=
lockDriverState *child_bs,
         s->next_child_index--;
         goto out;
     }
-    s->children =3D g_renew(BdrvChild *, s->children, s->num_children + 1)=
;
-    s->children[s->num_children++] =3D child;
+    s->children =3D g_renew(QuorumChild, s->children, s->num_children + 1)=
;
+    s->children[s->num_children++] =3D (QuorumChild){
+        .child =3D child,
+    };
=20
 out:
     bdrv_drained_end(bs);
@@ -1036,7 +1044,7 @@ static void quorum_del_child(BlockDriverState *bs, Bd=
rvChild *child,
     int i;
=20
     for (i =3D 0; i < s->num_children; i++) {
-        if (s->children[i] =3D=3D child) {
+        if (s->children[i].child =3D=3D child) {
             break;
         }
     }
@@ -1058,8 +1066,8 @@ static void quorum_del_child(BlockDriverState *bs, Bd=
rvChild *child,
=20
     /* We can safely remove this child now */
     memmove(&s->children[i], &s->children[i + 1],
-            (s->num_children - i - 1) * sizeof(BdrvChild *));
-    s->children =3D g_renew(BdrvChild *, s->children, --s->num_children);
+            (s->num_children - i - 1) * sizeof(QuorumChild));
+    s->children =3D g_renew(QuorumChild, s->children, --s->num_children);
     bdrv_unref_child(bs, child);
=20
     bdrv_drained_end(bs);
@@ -1100,7 +1108,7 @@ static void quorum_gather_child_options(BlockDriverSt=
ate *bs, QDict *target,
=20
     for (i =3D 0; i < s->num_children; i++) {
         qlist_append(children_list,
-                     qobject_ref(s->children[i]->bs->full_open_options));
+                     qobject_ref(s->children[i].child->bs->full_open_optio=
ns));
     }
 }
=20
--=20
2.24.1


