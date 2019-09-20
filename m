Return-Path: <SRS0=N0XV=XP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 458F0C4CEC9
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Sep 2019 15:46:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1F3B02086A
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Sep 2019 15:46:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F3B02086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32788 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iBL7L-0007i4-Ji
	for qemu-devel@archiver.kernel.org; Fri, 20 Sep 2019 11:46:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44162)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iBKq7-00016l-W1
 for qemu-devel@nongnu.org; Fri, 20 Sep 2019 11:28:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iBKq5-0004h5-Hg
 for qemu-devel@nongnu.org; Fri, 20 Sep 2019 11:28:55 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40788)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1iBKpy-0004Zt-11; Fri, 20 Sep 2019 11:28:47 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id EFDB2308FC4D;
 Fri, 20 Sep 2019 15:28:41 +0000 (UTC)
Received: from localhost (unknown [10.40.205.102])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 5E3E25D9E5;
 Fri, 20 Sep 2019 15:28:41 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH 15/22] mirror: Prevent loops
Date: Fri, 20 Sep 2019 17:27:57 +0200
Message-Id: <20190920152804.12875-16-mreitz@redhat.com>
In-Reply-To: <20190920152804.12875-1-mreitz@redhat.com>
References: <20190920152804.12875-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.43]); Fri, 20 Sep 2019 15:28:42 +0000 (UTC)
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

While bdrv_replace_node() will not follow through with it, a specific
@replaces asks the mirror job to create a loop.

For example, say both the source and the target share a child where the
source is a filter; by letting @replaces point to the common child, you
ask for a loop.

Or if you use @replaces in drive-mirror with sync=3Dnone and
mode=3Dabsolute-paths, you generally ask for a loop (@replaces must point
to a child of the source, and sync=3Dnone makes the source the backing
file of the target after the job).

bdrv_replace_node() will not create those loops, but it by doing so, it
ignores the user-requested configuration, which is not ideally either.
(In the first example above, the target's child will remain what it was,
which may still be reasonable.  But in the second example, the target
will just not become a child of the source, which is precisely what was
requested with @replaces.)

So prevent such configurations, both before the job, and before it
actually completes.

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 include/block/block_int.h |  3 +++
 block.c                   | 30 ++++++++++++++++++++++++
 block/mirror.c            | 19 +++++++++++++++-
 blockdev.c                | 48 ++++++++++++++++++++++++++++++++++++++-
 4 files changed, 98 insertions(+), 2 deletions(-)

diff --git a/include/block/block_int.h b/include/block/block_int.h
index 70f26530c9..8a26a0d88a 100644
--- a/include/block/block_int.h
+++ b/include/block/block_int.h
@@ -1256,6 +1256,9 @@ void bdrv_format_default_perms(BlockDriverState *bs=
, BdrvChild *c,
 bool bdrv_recurse_can_replace(BlockDriverState *bs,
                               BlockDriverState *to_replace);
=20
+bool bdrv_is_child_of(BlockDriverState *child, BlockDriverState *parent,
+                      int min_level);
+
 /*
  * Default implementation for drivers to pass bdrv_co_block_status() to
  * their file.
diff --git a/block.c b/block.c
index 0d9b3de98f..332191fb47 100644
--- a/block.c
+++ b/block.c
@@ -6260,6 +6260,36 @@ out:
     return to_replace_bs;
 }
=20
+/*
+ * Return true iff @child is a (recursive) child of @parent, with at
+ * least @min_level edges between them.
+ *
+ * (If @min_level =3D=3D 0, return true if @child =3D=3D @parent.  For
+ * @min_level =3D=3D 1, @child needs to be at least a real child; for
+ * @min_level =3D=3D 2, it needs to be at least a grand-child; and so on=
.)
+ */
+bool bdrv_is_child_of(BlockDriverState *child, BlockDriverState *parent,
+                      int min_level)
+{
+    BdrvChild *c;
+
+    if (child =3D=3D parent && min_level <=3D 0) {
+        return true;
+    }
+
+    if (!parent) {
+        return false;
+    }
+
+    QLIST_FOREACH(c, &parent->children, next) {
+        if (bdrv_is_child_of(child, c->bs, min_level - 1)) {
+            return true;
+        }
+    }
+
+    return false;
+}
+
 /**
  * Iterates through the list of runtime option keys that are said to
  * be "strong" for a BDS.  An option is called "strong" if it changes
diff --git a/block/mirror.c b/block/mirror.c
index d877637e1e..f30a6933d8 100644
--- a/block/mirror.c
+++ b/block/mirror.c
@@ -701,7 +701,24 @@ static int mirror_exit_common(Job *job)
          * there.
          */
         if (bdrv_recurse_can_replace(src, to_replace)) {
-            bdrv_replace_node(to_replace, target_bs, &local_err);
+            /*
+             * It is OK for @to_replace to be an immediate child of
+             * @target_bs, because that is what happens with
+             * drive-mirror sync=3Dnone mode=3Dabsolute-paths: target_bs=
's
+             * backing file will be the source node, which is also
+             * to_replace (by default).
+             * bdrv_replace_node() handles this case by not letting
+             * target_bs->backing point to itself, but to the source
+             * still.
+             */
+            if (!bdrv_is_child_of(to_replace, target_bs, 2)) {
+                bdrv_replace_node(to_replace, target_bs, &local_err);
+            } else {
+                error_setg(&local_err, "Can no longer replace '%s' by '%=
s', "
+                           "because the former is now a child of the lat=
ter, "
+                           "and doing so would thus create a loop",
+                           to_replace->node_name, target_bs->node_name);
+            }
         } else {
             error_setg(&local_err, "Can no longer replace '%s' by '%s', =
"
                        "because it can no longer be guaranteed that doin=
g so "
diff --git a/blockdev.c b/blockdev.c
index 0420bc29be..27344247d5 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -3845,7 +3845,7 @@ static void blockdev_mirror_common(const char *job_=
id, BlockDriverState *bs,
     }
=20
     if (has_replaces) {
-        BlockDriverState *to_replace_bs;
+        BlockDriverState *to_replace_bs, *target_backing_bs;
         AioContext *replace_aio_context;
         int64_t bs_size, replace_size;
=20
@@ -3860,6 +3860,52 @@ static void blockdev_mirror_common(const char *job=
_id, BlockDriverState *bs,
             return;
         }
=20
+        if (bdrv_is_child_of(to_replace_bs, target, 1)) {
+            error_setg(errp, "Replacing %s by %s would result in a loop,=
 "
+                       "because the former is a child of the latter",
+                       to_replace_bs->node_name, target->node_name);
+            return;
+        }
+
+        if (backing_mode =3D=3D MIRROR_SOURCE_BACKING_CHAIN ||
+            backing_mode =3D=3D MIRROR_OPEN_BACKING_CHAIN)
+        {
+            /*
+             * While we do not quite know what OPEN_BACKING_CHAIN
+             * (used for mode=3Dexisting) will yield, it is probably
+             * best to restrict it exactly like SOURCE_BACKING_CHAIN,
+             * because that is our best guess.
+             */
+            switch (sync) {
+            case MIRROR_SYNC_MODE_FULL:
+                target_backing_bs =3D NULL;
+                break;
+
+            case MIRROR_SYNC_MODE_TOP:
+                target_backing_bs =3D backing_bs(bs);
+                break;
+
+            case MIRROR_SYNC_MODE_NONE:
+                target_backing_bs =3D bs;
+                break;
+
+            default:
+                abort();
+            }
+        } else {
+            assert(backing_mode =3D=3D MIRROR_LEAVE_BACKING_CHAIN);
+            target_backing_bs =3D backing_bs(target);
+        }
+
+        if (bdrv_is_child_of(to_replace_bs, target_backing_bs, 0)) {
+            error_setg(errp, "Replacing '%s' by '%s' with this sync mode=
 would "
+                       "result in a loop, because the former would be a =
child "
+                       "of the latter's backing file ('%s') after the mi=
rror "
+                       "job", to_replace_bs->node_name, target->node_nam=
e,
+                       target_backing_bs->node_name);
+            return;
+        }
+
         replace_aio_context =3D bdrv_get_aio_context(to_replace_bs);
         aio_context_acquire(replace_aio_context);
         replace_size =3D bdrv_getlength(to_replace_bs);
--=20
2.21.0


