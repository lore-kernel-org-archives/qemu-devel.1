Return-Path: <SRS0=nSo8=TI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13E2AC04A6B
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2019 18:32:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CE07321726
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2019 18:32:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE07321726
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:41528 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hORN7-0002Gv-2K
	for qemu-devel@archiver.kernel.org; Wed, 08 May 2019 14:32:53 -0400
Received: from eggs.gnu.org ([209.51.188.92]:51389)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1hORH3-0004wN-3s
	for qemu-devel@nongnu.org; Wed, 08 May 2019 14:26:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1hORH1-0003af-9Q
	for qemu-devel@nongnu.org; Wed, 08 May 2019 14:26:37 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52890)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mreitz@redhat.com>)
	id 1hORGu-0003Eu-L1; Wed, 08 May 2019 14:26:29 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id EDF482D808;
	Wed,  8 May 2019 18:26:14 +0000 (UTC)
Received: from localhost (ovpn-204-94.brq.redhat.com [10.40.204.94])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 53A2B60C82;
	Wed,  8 May 2019 18:26:14 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Date: Wed,  8 May 2019 20:25:45 +0200
Message-Id: <20190508182546.2239-7-mreitz@redhat.com>
In-Reply-To: <20190508182546.2239-1-mreitz@redhat.com>
References: <20190508182546.2239-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.30]);
	Wed, 08 May 2019 18:26:15 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v2 6/7] block: Add *tighten_restrictions to
 *check*_perm()
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
Cc: Kevin Wolf <kwolf@redhat.com>, John Snow <jsnow@redhat.com>,
	qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This patch makes three functions report whether the necessary permission
change tightens restrictions or not.  These functions are:
- bdrv_check_perm()
- bdrv_check_update_perm()
- bdrv_child_check_perm()

Callers can use this result to decide whether a failure is fatal or not
(see the next patch).

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 block.c | 89 ++++++++++++++++++++++++++++++++++++++++++++++-----------
 1 file changed, 72 insertions(+), 17 deletions(-)

diff --git a/block.c b/block.c
index da7da8cc6c..8f517be5b4 100644
--- a/block.c
+++ b/block.c
@@ -1686,9 +1686,12 @@ static int bdrv_fill_options(QDict **options, cons=
t char *filename,
=20
 static int bdrv_child_check_perm(BdrvChild *c, BlockReopenQueue *q,
                                  uint64_t perm, uint64_t shared,
-                                 GSList *ignore_children, Error **errp);
+                                 GSList *ignore_children,
+                                 bool *tighten_restrictions, Error **err=
p);
 static void bdrv_child_abort_perm_update(BdrvChild *c);
 static void bdrv_child_set_perm(BdrvChild *c, uint64_t perm, uint64_t sh=
ared);
+static void bdrv_get_cumulative_perm(BlockDriverState *bs, uint64_t *per=
m,
+                                     uint64_t *shared_perm);
=20
 typedef struct BlockReopenQueueEntry {
      bool prepared;
@@ -1759,18 +1762,43 @@ static void bdrv_child_perm(BlockDriverState *bs,=
 BlockDriverState *child_bs,
  * permissions of all its parents. This involves checking whether all ne=
cessary
  * permission changes to child nodes can be performed.
  *
+ * Will set *tighten_restrictions to true if and only if new permissions=
 have to
+ * be taken or currently shared permissions are to be unshared.  Otherwi=
se,
+ * errors are not fatal as long as the caller accepts that the restricti=
ons
+ * remain tighter than they need to be.  The caller still has to abort t=
he
+ * transaction.
+ * @tighten_restrictions cannot be used together with @q: When reopening=
, we may
+ * encounter fatal errors even though no restrictions are to be tightene=
d.  For
+ * example, changing a node from RW to RO will fail if the WRITE permiss=
ion is
+ * to be kept.
+ *
  * A call to this function must always be followed by a call to bdrv_set=
_perm()
  * or bdrv_abort_perm_update().
  */
 static int bdrv_check_perm(BlockDriverState *bs, BlockReopenQueue *q,
                            uint64_t cumulative_perms,
                            uint64_t cumulative_shared_perms,
-                           GSList *ignore_children, Error **errp)
+                           GSList *ignore_children,
+                           bool *tighten_restrictions, Error **errp)
 {
     BlockDriver *drv =3D bs->drv;
     BdrvChild *c;
     int ret;
=20
+    assert(!q || !tighten_restrictions);
+
+    if (tighten_restrictions) {
+        uint64_t current_perms, current_shared;
+        uint64_t added_perms, removed_shared_perms;
+
+        bdrv_get_cumulative_perm(bs, &current_perms, &current_shared);
+
+        added_perms =3D cumulative_perms & ~current_perms;
+        removed_shared_perms =3D current_shared & ~cumulative_shared_per=
ms;
+
+        *tighten_restrictions =3D added_perms || removed_shared_perms;
+    }
+
     /* Write permissions never work with read-only images */
     if ((cumulative_perms & (BLK_PERM_WRITE | BLK_PERM_WRITE_UNCHANGED))=
 &&
         !bdrv_is_writable_after_reopen(bs, q))
@@ -1798,11 +1826,18 @@ static int bdrv_check_perm(BlockDriverState *bs, =
BlockReopenQueue *q,
     /* Check all children */
     QLIST_FOREACH(c, &bs->children, next) {
         uint64_t cur_perm, cur_shared;
+        bool child_tighten_restr;
+
         bdrv_child_perm(bs, c->bs, c, c->role, q,
                         cumulative_perms, cumulative_shared_perms,
                         &cur_perm, &cur_shared);
-        ret =3D bdrv_child_check_perm(c, q, cur_perm, cur_shared,
-                                    ignore_children, errp);
+        ret =3D bdrv_child_check_perm(c, q, cur_perm, cur_shared, ignore=
_children,
+                                    tighten_restrictions ? &child_tighte=
n_restr
+                                                         : NULL,
+                                    errp);
+        if (tighten_restrictions) {
+            *tighten_restrictions |=3D child_tighten_restr;
+        }
         if (ret < 0) {
             return ret;
         }
@@ -1926,17 +1961,23 @@ char *bdrv_perm_names(uint64_t perm)
  * set, the BdrvChild objects in this list are ignored in the calculatio=
ns;
  * this allows checking permission updates for an existing reference.
  *
+ * See bdrv_check_perm() for the semantics of @tighten_restrictions.
+ *
  * Needs to be followed by a call to either bdrv_set_perm() or
  * bdrv_abort_perm_update(). */
 static int bdrv_check_update_perm(BlockDriverState *bs, BlockReopenQueue=
 *q,
                                   uint64_t new_used_perm,
                                   uint64_t new_shared_perm,
-                                  GSList *ignore_children, Error **errp)
+                                  GSList *ignore_children,
+                                  bool *tighten_restrictions,
+                                  Error **errp)
 {
     BdrvChild *c;
     uint64_t cumulative_perms =3D new_used_perm;
     uint64_t cumulative_shared_perms =3D new_shared_perm;
=20
+    assert(!q || !tighten_restrictions);
+
     /* There is no reason why anyone couldn't tolerate write_unchanged *=
/
     assert(new_shared_perm & BLK_PERM_WRITE_UNCHANGED);
=20
@@ -1948,6 +1989,11 @@ static int bdrv_check_update_perm(BlockDriverState=
 *bs, BlockReopenQueue *q,
         if ((new_used_perm & c->shared_perm) !=3D new_used_perm) {
             char *user =3D bdrv_child_user_desc(c);
             char *perm_names =3D bdrv_perm_names(new_used_perm & ~c->sha=
red_perm);
+
+            if (tighten_restrictions) {
+                *tighten_restrictions =3D true;
+            }
+
             error_setg(errp, "Conflicts with use by %s as '%s', which do=
es not "
                              "allow '%s' on %s",
                        user, c->name, perm_names, bdrv_get_node_name(c->=
bs));
@@ -1959,6 +2005,11 @@ static int bdrv_check_update_perm(BlockDriverState=
 *bs, BlockReopenQueue *q,
         if ((c->perm & new_shared_perm) !=3D c->perm) {
             char *user =3D bdrv_child_user_desc(c);
             char *perm_names =3D bdrv_perm_names(c->perm & ~new_shared_p=
erm);
+
+            if (tighten_restrictions) {
+                *tighten_restrictions =3D true;
+            }
+
             error_setg(errp, "Conflicts with use by %s as '%s', which us=
es "
                              "'%s' on %s",
                        user, c->name, perm_names, bdrv_get_node_name(c->=
bs));
@@ -1972,19 +2023,21 @@ static int bdrv_check_update_perm(BlockDriverStat=
e *bs, BlockReopenQueue *q,
     }
=20
     return bdrv_check_perm(bs, q, cumulative_perms, cumulative_shared_pe=
rms,
-                           ignore_children, errp);
+                           ignore_children, tighten_restrictions, errp);
 }
=20
 /* Needs to be followed by a call to either bdrv_child_set_perm() or
  * bdrv_child_abort_perm_update(). */
 static int bdrv_child_check_perm(BdrvChild *c, BlockReopenQueue *q,
                                  uint64_t perm, uint64_t shared,
-                                 GSList *ignore_children, Error **errp)
+                                 GSList *ignore_children,
+                                 bool *tighten_restrictions, Error **err=
p)
 {
     int ret;
=20
     ignore_children =3D g_slist_prepend(g_slist_copy(ignore_children), c=
);
-    ret =3D bdrv_check_update_perm(c->bs, q, perm, shared, ignore_childr=
en, errp);
+    ret =3D bdrv_check_update_perm(c->bs, q, perm, shared, ignore_childr=
en,
+                                 tighten_restrictions, errp);
     g_slist_free(ignore_children);
=20
     if (ret < 0) {
@@ -2037,7 +2090,7 @@ int bdrv_child_try_set_perm(BdrvChild *c, uint64_t =
perm, uint64_t shared,
 {
     int ret;
=20
-    ret =3D bdrv_child_check_perm(c, NULL, perm, shared, NULL, errp);
+    ret =3D bdrv_child_check_perm(c, NULL, perm, shared, NULL, NULL, err=
p);
     if (ret < 0) {
         bdrv_child_abort_perm_update(c);
         return ret;
@@ -2223,7 +2276,8 @@ static void bdrv_replace_child(BdrvChild *child, Bl=
ockDriverState *new_bs)
          * because we're just taking a parent away, so we're loosening
          * restrictions. */
         bdrv_get_cumulative_perm(old_bs, &perm, &shared_perm);
-        bdrv_check_perm(old_bs, NULL, perm, shared_perm, NULL, &error_ab=
ort);
+        bdrv_check_perm(old_bs, NULL, perm, shared_perm, NULL,
+                        NULL, &error_abort);
         bdrv_set_perm(old_bs, perm, shared_perm);
     }
 }
@@ -2237,7 +2291,8 @@ BdrvChild *bdrv_root_attach_child(BlockDriverState =
*child_bs,
     BdrvChild *child;
     int ret;
=20
-    ret =3D bdrv_check_update_perm(child_bs, NULL, perm, shared_perm, NU=
LL, errp);
+    ret =3D bdrv_check_update_perm(child_bs, NULL, perm, shared_perm, NU=
LL, NULL,
+                                 errp);
     if (ret < 0) {
         bdrv_abort_perm_update(child_bs);
         return NULL;
@@ -3292,7 +3347,7 @@ int bdrv_reopen_multiple(BlockReopenQueue *bs_queue=
, Error **errp)
     QSIMPLEQ_FOREACH(bs_entry, bs_queue, entry) {
         BDRVReopenState *state =3D &bs_entry->state;
         ret =3D bdrv_check_perm(state->bs, bs_queue, state->perm,
-                              state->shared_perm, NULL, errp);
+                              state->shared_perm, NULL, NULL, errp);
         if (ret < 0) {
             goto cleanup_perm;
         }
@@ -3304,7 +3359,7 @@ int bdrv_reopen_multiple(BlockReopenQueue *bs_queue=
, Error **errp)
                             state->perm, state->shared_perm,
                             &nperm, &nshared);
             ret =3D bdrv_check_update_perm(state->new_backing_bs, NULL,
-                                         nperm, nshared, NULL, errp);
+                                         nperm, nshared, NULL, NULL, err=
p);
             if (ret < 0) {
                 goto cleanup_perm;
             }
@@ -4031,7 +4086,7 @@ void bdrv_replace_node(BlockDriverState *from, Bloc=
kDriverState *to,
=20
     /* Check whether the required permissions can be granted on @to, ign=
oring
      * all BdrvChild in @list so that they can't block themselves. */
-    ret =3D bdrv_check_update_perm(to, NULL, perm, shared, list, errp);
+    ret =3D bdrv_check_update_perm(to, NULL, perm, shared, list, NULL, e=
rrp);
     if (ret < 0) {
         bdrv_abort_perm_update(to);
         goto out;
@@ -4378,7 +4433,7 @@ int bdrv_drop_intermediate(BlockDriverState *top, B=
lockDriverState *base,
         /* Check whether we are allowed to switch c from top to base */
         GSList *ignore_children =3D g_slist_prepend(NULL, c);
         ret =3D bdrv_check_update_perm(base, NULL, c->perm, c->shared_pe=
rm,
-                                     ignore_children, &local_err);
+                                     ignore_children, NULL, &local_err);
         g_slist_free(ignore_children);
         if (ret < 0) {
             error_report_err(local_err);
@@ -5153,7 +5208,7 @@ static void coroutine_fn bdrv_co_invalidate_cache(B=
lockDriverState *bs,
      */
     bs->open_flags &=3D ~BDRV_O_INACTIVE;
     bdrv_get_cumulative_perm(bs, &perm, &shared_perm);
-    ret =3D bdrv_check_perm(bs, NULL, perm, shared_perm, NULL, &local_er=
r);
+    ret =3D bdrv_check_perm(bs, NULL, perm, shared_perm, NULL, NULL, &lo=
cal_err);
     if (ret < 0) {
         bs->open_flags |=3D BDRV_O_INACTIVE;
         error_propagate(errp, local_err);
@@ -5303,7 +5358,7 @@ static int bdrv_inactivate_recurse(BlockDriverState=
 *bs)
=20
     /* Update permissions, they may differ for inactive nodes */
     bdrv_get_cumulative_perm(bs, &perm, &shared_perm);
-    bdrv_check_perm(bs, NULL, perm, shared_perm, NULL, &error_abort);
+    bdrv_check_perm(bs, NULL, perm, shared_perm, NULL, NULL, &error_abor=
t);
     bdrv_set_perm(bs, perm, shared_perm);
=20
=20
--=20
2.20.1


