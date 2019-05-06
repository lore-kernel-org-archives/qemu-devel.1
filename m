Return-Path: <SRS0=msIk=TG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1421C04AAD
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2019 19:53:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 86250206BF
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2019 19:53:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 86250206BF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:33245 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hNjff-0000FE-Ln
	for qemu-devel@archiver.kernel.org; Mon, 06 May 2019 15:53:07 -0400
Received: from eggs.gnu.org ([209.51.188.92]:43793)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1hNjbH-0004ju-CU
	for qemu-devel@nongnu.org; Mon, 06 May 2019 15:48:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1hNjbF-0002Bx-7z
	for qemu-devel@nongnu.org; Mon, 06 May 2019 15:48:35 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43134)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mreitz@redhat.com>)
	id 1hNjbA-00029w-M7; Mon, 06 May 2019 15:48:28 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 0DA9288305;
	Mon,  6 May 2019 19:48:28 +0000 (UTC)
Received: from localhost (ovpn-204-185.brq.redhat.com [10.40.204.185])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 551BC5DC1A;
	Mon,  6 May 2019 19:48:25 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Date: Mon,  6 May 2019 21:47:52 +0200
Message-Id: <20190506194753.12464-7-mreitz@redhat.com>
In-Reply-To: <20190506194753.12464-1-mreitz@redhat.com>
References: <20190506194753.12464-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.28]);
	Mon, 06 May 2019 19:48:28 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH 6/7] block: Add *loosen_restrictions to
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
change purely loosens restrictions or not.  These functions are:
- bdrv_check_perm()
- bdrv_check_update_perm()
- bdrv_child_check_perm()

Callers can use this result to decide whether a failure is fatal or not
(see the next patch).

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 block.c | 81 +++++++++++++++++++++++++++++++++++++++++++++------------
 1 file changed, 65 insertions(+), 16 deletions(-)

diff --git a/block.c b/block.c
index 21e4514426..105866d15a 100644
--- a/block.c
+++ b/block.c
@@ -1686,9 +1686,12 @@ static int bdrv_fill_options(QDict **options, cons=
t char *filename,
=20
 static int bdrv_child_check_perm(BdrvChild *c, BlockReopenQueue *q,
                                  uint64_t perm, uint64_t shared,
-                                 GSList *ignore_children, Error **errp);
+                                 GSList *ignore_children,
+                                 bool *loosen_restrictions, Error **errp=
);
 static void bdrv_child_abort_perm_update(BdrvChild *c);
 static void bdrv_child_set_perm(BdrvChild *c, uint64_t perm, uint64_t sh=
ared);
+static void bdrv_get_cumulative_perm(BlockDriverState *bs, uint64_t *per=
m,
+                                     uint64_t *shared_perm);
=20
 typedef struct BlockReopenQueueEntry {
      bool prepared;
@@ -1759,18 +1762,37 @@ static void bdrv_child_perm(BlockDriverState *bs,=
 BlockDriverState *child_bs,
  * permissions of all its parents. This involves checking whether all ne=
cessary
  * permission changes to child nodes can be performed.
  *
+ * Will set *loosen_restrictions to true if and only if no new permissio=
ns have
+ * to be taken and no existing shared permissions are to be unshared.  I=
n this
+ * case, errors are not fatal, as long as the caller accepts that the
+ * restrictions remain tighter than they need to be.  The caller still h=
as to
+ * abort the transaction.
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
+                           bool *loosen_restrictions, Error **errp)
 {
     BlockDriver *drv =3D bs->drv;
     BdrvChild *c;
     int ret;
=20
+    if (loosen_restrictions) {
+        uint64_t current_perms, current_shared;
+        uint64_t added_perms, removed_shared_perms;
+
+        bdrv_get_cumulative_perm(bs, &current_perms, &current_shared);
+
+        added_perms =3D cumulative_perms & ~current_perms;
+        removed_shared_perms =3D current_shared & ~cumulative_shared_per=
ms;
+
+        *loosen_restrictions =3D !added_perms && !removed_shared_perms;
+    }
+
     /* Write permissions never work with read-only images */
     if ((cumulative_perms & (BLK_PERM_WRITE | BLK_PERM_WRITE_UNCHANGED))=
 &&
         !bdrv_is_writable_after_reopen(bs, q))
@@ -1798,11 +1820,16 @@ static int bdrv_check_perm(BlockDriverState *bs, =
BlockReopenQueue *q,
     /* Check all children */
     QLIST_FOREACH(c, &bs->children, next) {
         uint64_t cur_perm, cur_shared;
+        bool child_loosen_restr;
+
         bdrv_child_perm(bs, c->bs, c, c->role, q,
                         cumulative_perms, cumulative_shared_perms,
                         &cur_perm, &cur_shared);
         ret =3D bdrv_child_check_perm(c, q, cur_perm, cur_shared,
-                                    ignore_children, errp);
+                                    ignore_children, &child_loosen_restr=
, errp);
+        if (loosen_restrictions) {
+            *loosen_restrictions &=3D child_loosen_restr;
+        }
         if (ret < 0) {
             return ret;
         }
@@ -1926,12 +1953,20 @@ char *bdrv_perm_names(uint64_t perm)
  * set, the BdrvChild objects in this list are ignored in the calculatio=
ns;
  * this allows checking permission updates for an existing reference.
  *
+ * Will set *loosen_restrictions to true if and only if no new permissio=
ns have
+ * to be taken and no existing shared permissions are to be unshared.  I=
n this
+ * case, errors are not fatal, as long as the caller accepts that the
+ * restrictions remain tighter than they need to be.  The caller still h=
as to
+ * abort the transaction.
+ *
  * Needs to be followed by a call to either bdrv_set_perm() or
  * bdrv_abort_perm_update(). */
 static int bdrv_check_update_perm(BlockDriverState *bs, BlockReopenQueue=
 *q,
                                   uint64_t new_used_perm,
                                   uint64_t new_shared_perm,
-                                  GSList *ignore_children, Error **errp)
+                                  GSList *ignore_children,
+                                  bool *loosen_restrictions,
+                                  Error **errp)
 {
     BdrvChild *c;
     uint64_t cumulative_perms =3D new_used_perm;
@@ -1948,6 +1983,11 @@ static int bdrv_check_update_perm(BlockDriverState=
 *bs, BlockReopenQueue *q,
         if ((new_used_perm & c->shared_perm) !=3D new_used_perm) {
             char *user =3D bdrv_child_user_desc(c);
             char *perm_names =3D bdrv_perm_names(new_used_perm & ~c->sha=
red_perm);
+
+            if (loosen_restrictions) {
+                *loosen_restrictions =3D false;
+            }
+
             error_setg(errp, "Conflicts with use by %s as '%s', which do=
es not "
                              "allow '%s' on %s",
                        user, c->name, perm_names, bdrv_get_node_name(c->=
bs));
@@ -1959,6 +1999,11 @@ static int bdrv_check_update_perm(BlockDriverState=
 *bs, BlockReopenQueue *q,
         if ((c->perm & new_shared_perm) !=3D c->perm) {
             char *user =3D bdrv_child_user_desc(c);
             char *perm_names =3D bdrv_perm_names(c->perm & ~new_shared_p=
erm);
+
+            if (loosen_restrictions) {
+                *loosen_restrictions =3D false;
+            }
+
             error_setg(errp, "Conflicts with use by %s as '%s', which us=
es "
                              "'%s' on %s",
                        user, c->name, perm_names, bdrv_get_node_name(c->=
bs));
@@ -1972,19 +2017,21 @@ static int bdrv_check_update_perm(BlockDriverStat=
e *bs, BlockReopenQueue *q,
     }
=20
     return bdrv_check_perm(bs, q, cumulative_perms, cumulative_shared_pe=
rms,
-                           ignore_children, errp);
+                           ignore_children, loosen_restrictions, errp);
 }
=20
 /* Needs to be followed by a call to either bdrv_child_set_perm() or
  * bdrv_child_abort_perm_update(). */
 static int bdrv_child_check_perm(BdrvChild *c, BlockReopenQueue *q,
                                  uint64_t perm, uint64_t shared,
-                                 GSList *ignore_children, Error **errp)
+                                 GSList *ignore_children,
+                                 bool *loosen_restrictions, Error **errp=
)
 {
     int ret;
=20
     ignore_children =3D g_slist_prepend(g_slist_copy(ignore_children), c=
);
-    ret =3D bdrv_check_update_perm(c->bs, q, perm, shared, ignore_childr=
en, errp);
+    ret =3D bdrv_check_update_perm(c->bs, q, perm, shared, ignore_childr=
en,
+                                 loosen_restrictions, errp);
     g_slist_free(ignore_children);
=20
     if (ret < 0) {
@@ -2037,7 +2084,7 @@ int bdrv_child_try_set_perm(BdrvChild *c, uint64_t =
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
@@ -2223,7 +2270,8 @@ static void bdrv_replace_child(BdrvChild *child, Bl=
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
@@ -2237,7 +2285,8 @@ BdrvChild *bdrv_root_attach_child(BlockDriverState =
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
@@ -3292,7 +3341,7 @@ int bdrv_reopen_multiple(BlockReopenQueue *bs_queue=
, Error **errp)
     QSIMPLEQ_FOREACH(bs_entry, bs_queue, entry) {
         BDRVReopenState *state =3D &bs_entry->state;
         ret =3D bdrv_check_perm(state->bs, bs_queue, state->perm,
-                              state->shared_perm, NULL, errp);
+                              state->shared_perm, NULL, NULL, errp);
         if (ret < 0) {
             goto cleanup_perm;
         }
@@ -3304,7 +3353,7 @@ int bdrv_reopen_multiple(BlockReopenQueue *bs_queue=
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
@@ -4031,7 +4080,7 @@ void bdrv_replace_node(BlockDriverState *from, Bloc=
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
@@ -4378,7 +4427,7 @@ int bdrv_drop_intermediate(BlockDriverState *top, B=
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
@@ -5153,7 +5202,7 @@ static void coroutine_fn bdrv_co_invalidate_cache(B=
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
@@ -5303,7 +5352,7 @@ static int bdrv_inactivate_recurse(BlockDriverState=
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


