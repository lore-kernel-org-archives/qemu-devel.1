Return-Path: <SRS0=aFsj=XS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2853EC04EBF
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Sep 2019 12:00:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F1941205F4
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Sep 2019 11:59:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F1941205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55218 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iCN0X-0004v4-TM
	for qemu-devel@archiver.kernel.org; Mon, 23 Sep 2019 07:59:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45259)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iCMyR-0003P9-Q6
 for qemu-devel@nongnu.org; Mon, 23 Sep 2019 07:57:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iCMyQ-0006w1-8A
 for qemu-devel@nongnu.org; Mon, 23 Sep 2019 07:57:47 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40800)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1iCMyN-0006t0-1S; Mon, 23 Sep 2019 07:57:43 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 5BFA310C0937;
 Mon, 23 Sep 2019 11:57:42 +0000 (UTC)
Received: from localhost (unknown [10.40.205.78])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 7D40C5D717;
 Mon, 23 Sep 2019 11:57:39 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH v2 2/4] blkdebug: Allow taking/unsharing permissions
Date: Mon, 23 Sep 2019 13:57:26 +0200
Message-Id: <20190923115728.28250-3-mreitz@redhat.com>
In-Reply-To: <20190923115728.28250-1-mreitz@redhat.com>
References: <20190923115728.28250-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.66]); Mon, 23 Sep 2019 11:57:42 +0000 (UTC)
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Sometimes it is useful to be able to add a node to the block graph that
takes or unshare a certain set of permissions for debugging purposes.
This patch adds this capability to blkdebug.

(Note that you cannot make blkdebug release or share permissions that it
needs to take or cannot share, because this might result in assertion
failures in the block layer.  But if the blkdebug node has no parents,
it will not take any permissions and share everything by default, so you
can then freely choose what permissions to take and share.)

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 qapi/block-core.json |  14 +++++-
 block/blkdebug.c     | 106 ++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 118 insertions(+), 2 deletions(-)

diff --git a/qapi/block-core.json b/qapi/block-core.json
index b5cd00c361..572c5756f1 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -3394,6 +3394,16 @@
 #
 # @set-state:       array of state-change descriptions
 #
+# @take-child-perms: Permissions to take on @image in addition to what
+#                    is necessary anyway (which depends on how the
+#                    blkdebug node is used).  Defaults to none.
+#                    (since 4.2)
+#
+# @unshare-child-perms: Permissions not to share on @image in addition
+#                       to what cannot be shared anyway (which depends
+#                       on how the blkdebug node is used).  Defaults
+#                       to none.  (since 4.2)
+#
 # Since: 2.9
 ##
 { 'struct': 'BlockdevOptionsBlkdebug',
@@ -3403,7 +3413,9 @@
             '*opt-write-zero': 'int32', '*max-write-zero': 'int32',
             '*opt-discard': 'int32', '*max-discard': 'int32',
             '*inject-error': ['BlkdebugInjectErrorOptions'],
-            '*set-state': ['BlkdebugSetStateOptions'] } }
+            '*set-state': ['BlkdebugSetStateOptions'],
+            '*take-child-perms': ['BlockPermission'],
+            '*unshare-child-perms': ['BlockPermission'] } }
=20
 ##
 # @BlockdevOptionsBlklogwrites:
diff --git a/block/blkdebug.c b/block/blkdebug.c
index 5ae96c52b0..f3c1e4ad7b 100644
--- a/block/blkdebug.c
+++ b/block/blkdebug.c
@@ -28,9 +28,11 @@
 #include "qemu/cutils.h"
 #include "qemu/config-file.h"
 #include "block/block_int.h"
+#include "block/qdict.h"
 #include "qemu/module.h"
 #include "qemu/option.h"
 #include "qapi/qmp/qdict.h"
+#include "qapi/qmp/qlist.h"
 #include "qapi/qmp/qstring.h"
 #include "sysemu/qtest.h"
=20
@@ -44,6 +46,9 @@ typedef struct BDRVBlkdebugState {
     uint64_t opt_discard;
     uint64_t max_discard;
=20
+    uint64_t take_child_perms;
+    uint64_t unshare_child_perms;
+
     /* For blkdebug_refresh_filename() */
     char *config_file;
=20
@@ -344,6 +349,84 @@ static void blkdebug_parse_filename(const char *file=
name, QDict *options,
     qdict_put_str(options, "x-image", filename);
 }
=20
+static int blkdebug_parse_perm_list(uint64_t *dest, QDict *options,
+                                    const char *prefix, Error **errp)
+{
+    int ret =3D 0;
+    QDict *subqdict =3D NULL;
+    QObject *crumpled_subqdict =3D NULL;
+    QList *perm_list;
+    const QListEntry *perm;
+
+    qdict_extract_subqdict(options, &subqdict, prefix);
+    if (!qdict_size(subqdict)) {
+        goto out;
+    }
+
+    crumpled_subqdict =3D qdict_crumple(subqdict, errp);
+    if (!crumpled_subqdict) {
+        ret =3D -EINVAL;
+        goto out;
+    }
+
+    perm_list =3D qobject_to(QList, crumpled_subqdict);
+    if (!perm_list) {
+        /* Omit the trailing . from the prefix */
+        error_setg(errp, "%.*s expects a list",
+                   (int)(strlen(prefix) - 1), prefix);
+        ret =3D -EINVAL;
+        goto out;
+    }
+
+    for (perm =3D qlist_first(perm_list); perm; perm =3D qlist_next(perm=
)) {
+        const char *perm_name;
+        BlockPermission perm_bit;
+
+        perm_name =3D qstring_get_try_str(qobject_to(QString, perm->valu=
e));
+        if (!perm_name) {
+            /* Omit the trailing . from the prefix */
+            error_setg(errp, "%.*s expects a list of enum strings",
+                       (int)(strlen(prefix) - 1), prefix);
+            ret =3D -EINVAL;
+            goto out;
+        }
+
+        perm_bit =3D qapi_enum_parse(&BlockPermission_lookup, perm_name,
+                                   BLOCK_PERMISSION__MAX, errp);
+        if (perm_bit =3D=3D BLOCK_PERMISSION__MAX) {
+            ret =3D -EINVAL;
+            goto out;
+        }
+
+        *dest |=3D UINT64_C(1) << perm_bit;
+    }
+
+out:
+    qobject_unref(subqdict);
+    qobject_unref(crumpled_subqdict);
+    return ret;
+}
+
+static int blkdebug_parse_perms(BDRVBlkdebugState *s, QDict *options,
+                                Error **errp)
+{
+    int ret;
+
+    ret =3D blkdebug_parse_perm_list(&s->take_child_perms, options,
+                                   "take-child-perms.", errp);
+    if (ret < 0) {
+        return ret;
+    }
+
+    ret =3D blkdebug_parse_perm_list(&s->unshare_child_perms, options,
+                                   "unshare-child-perms.", errp);
+    if (ret < 0) {
+        return ret;
+    }
+
+    return 0;
+}
+
 static QemuOptsList runtime_opts =3D {
     .name =3D "blkdebug",
     .head =3D QTAILQ_HEAD_INITIALIZER(runtime_opts.head),
@@ -419,6 +502,12 @@ static int blkdebug_open(BlockDriverState *bs, QDict=
 *options, int flags,
     /* Set initial state */
     s->state =3D 1;
=20
+    /* Parse permissions modifiers before opening the image file */
+    ret =3D blkdebug_parse_perms(s, options, errp);
+    if (ret < 0) {
+        goto out;
+    }
+
     /* Open the image file */
     bs->file =3D bdrv_open_child(qemu_opt_get(opts, "x-image"), options,=
 "image",
                                bs, &child_file, false, &local_err);
@@ -916,6 +1005,21 @@ static int blkdebug_reopen_prepare(BDRVReopenState =
*reopen_state,
     return 0;
 }
=20
+static void blkdebug_child_perm(BlockDriverState *bs, BdrvChild *c,
+                                const BdrvChildRole *role,
+                                BlockReopenQueue *reopen_queue,
+                                uint64_t perm, uint64_t shared,
+                                uint64_t *nperm, uint64_t *nshared)
+{
+    BDRVBlkdebugState *s =3D bs->opaque;
+
+    bdrv_filter_default_perms(bs, c, role, reopen_queue, perm, shared,
+                              nperm, nshared);
+
+    *nperm |=3D s->take_child_perms;
+    *nshared &=3D ~s->unshare_child_perms;
+}
+
 static const char *const blkdebug_strong_runtime_opts[] =3D {
     "config",
     "inject-error.",
@@ -940,7 +1044,7 @@ static BlockDriver bdrv_blkdebug =3D {
     .bdrv_file_open         =3D blkdebug_open,
     .bdrv_close             =3D blkdebug_close,
     .bdrv_reopen_prepare    =3D blkdebug_reopen_prepare,
-    .bdrv_child_perm        =3D bdrv_filter_default_perms,
+    .bdrv_child_perm        =3D blkdebug_child_perm,
=20
     .bdrv_getlength         =3D blkdebug_getlength,
     .bdrv_refresh_filename  =3D blkdebug_refresh_filename,
--=20
2.21.0


