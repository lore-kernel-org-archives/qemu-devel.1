Return-Path: <SRS0=6DzB=ZD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA205C43331
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Nov 2019 16:21:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 73FBC21783
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Nov 2019 16:21:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hQCdsjFh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 73FBC21783
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54818 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iUCRg-00051J-Vl
	for qemu-devel@archiver.kernel.org; Mon, 11 Nov 2019 11:21:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39261)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iUC9t-0008TS-U9
 for qemu-devel@nongnu.org; Mon, 11 Nov 2019 11:03:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iUC9o-0002ym-Gq
 for qemu-devel@nongnu.org; Mon, 11 Nov 2019 11:03:17 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:27474
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1iUC9o-0002yS-Cw
 for qemu-devel@nongnu.org; Mon, 11 Nov 2019 11:03:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573488191;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RdKb/hYNSlDaukRFq6ANuOdiA03sLkb2ULTE0afREU8=;
 b=hQCdsjFhfrEiDK5qGoPQPTcHv5zVgxrnGT9KdqYMrxFxbXCxVLpKnTruP9ZaQKwG8IVJO9
 xSAfYNk2UcKEMY4wzrALY0K6j2QFDLazqJHMQP0bAN23lcwm8WvpA3zlIR4TUn9Uv9eRl/
 +H6ELPNgzeK8o+p1xx+hdB0IOBoX+KM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-34-_UQop2qqOQ-EKVZmjdrKvQ-1; Mon, 11 Nov 2019 11:03:07 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2B0E0800C72;
 Mon, 11 Nov 2019 16:03:06 +0000 (UTC)
Received: from localhost (ovpn-117-116.ams2.redhat.com [10.36.117.116])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 7214F600CC;
 Mon, 11 Nov 2019 16:03:05 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH for-5.0 v2 15/23] mirror: Prevent loops
Date: Mon, 11 Nov 2019 17:02:08 +0100
Message-Id: <20191111160216.197086-16-mreitz@redhat.com>
In-Reply-To: <20191111160216.197086-1-mreitz@redhat.com>
References: <20191111160216.197086-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: _UQop2qqOQ-EKVZmjdrKvQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.61
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
 Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org,
 Max Reitz <mreitz@redhat.com>
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

bdrv_replace_node() will not create those loops, but by doing so, it
ignores the user-requested configuration, which is not ideally either.
(In the first example above, the target's child will remain what it was,
which may still be reasonable.  But in the second example, the target
will just not become a child of the source, which is precisely what was
requested with @replaces.)

So prevent such configurations, both before the job, and before it
actually completes.

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 block.c                   | 30 ++++++++++++++++++++++++
 block/mirror.c            | 19 +++++++++++++++-
 blockdev.c                | 48 ++++++++++++++++++++++++++++++++++++++-
 include/block/block_int.h |  3 +++
 4 files changed, 98 insertions(+), 2 deletions(-)

diff --git a/block.c b/block.c
index 0159f8e510..e3922a0474 100644
--- a/block.c
+++ b/block.c
@@ -6259,6 +6259,36 @@ out:
     return to_replace_bs;
 }
=20
+/*
+ * Return true iff @child is a (recursive) child of @parent, with at
+ * least @min_level edges between them.
+ *
+ * (If @min_level =3D=3D 0, return true if @child =3D=3D @parent.  For
+ * @min_level =3D=3D 1, @child needs to be at least a real child; for
+ * @min_level =3D=3D 2, it needs to be at least a grand-child; and so on.)
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
index 68a4404666..b258c7e98b 100644
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
+             * drive-mirror sync=3Dnone mode=3Dabsolute-paths: target_bs's
+             * backing file will be the source node, which is also
+             * to_replace (by default).
+             * bdrv_replace_node() handles this case by not letting
+             * target_bs->backing point to itself, but to the source
+             * still.
+             */
+            if (!bdrv_is_child_of(to_replace, target_bs, 2)) {
+                bdrv_replace_node(to_replace, target_bs, &local_err);
+            } else {
+                error_setg(&local_err, "Can no longer replace '%s' by '%s'=
, "
+                           "because the former is now a child of the latte=
r, "
+                           "and doing so would thus create a loop",
+                           to_replace->node_name, target_bs->node_name);
+            }
         } else {
             error_setg(&local_err, "Can no longer replace '%s' by '%s', "
                        "because it can no longer be guaranteed that doing =
so "
diff --git a/blockdev.c b/blockdev.c
index 9dc2238bf3..d29f147f72 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -3824,7 +3824,7 @@ static void blockdev_mirror_common(const char *job_id=
, BlockDriverState *bs,
     }
=20
     if (has_replaces) {
-        BlockDriverState *to_replace_bs;
+        BlockDriverState *to_replace_bs, *target_backing_bs;
         AioContext *replace_aio_context;
         int64_t bs_size, replace_size;
=20
@@ -3839,6 +3839,52 @@ static void blockdev_mirror_common(const char *job_i=
d, BlockDriverState *bs,
             return;
         }
=20
+        if (bdrv_is_child_of(to_replace_bs, target, 1)) {
+            error_setg(errp, "Replacing %s by %s would result in a loop, "
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
+            error_setg(errp, "Replacing '%s' by '%s' with this sync mode w=
ould "
+                       "result in a loop, because the former would be a ch=
ild "
+                       "of the latter's backing file ('%s') after the mirr=
or "
+                       "job", to_replace_bs->node_name, target->node_name,
+                       target_backing_bs->node_name);
+            return;
+        }
+
         replace_aio_context =3D bdrv_get_aio_context(to_replace_bs);
         aio_context_acquire(replace_aio_context);
         replace_size =3D bdrv_getlength(to_replace_bs);
diff --git a/include/block/block_int.h b/include/block/block_int.h
index 589a797fab..7064a1a4fa 100644
--- a/include/block/block_int.h
+++ b/include/block/block_int.h
@@ -1266,6 +1266,9 @@ void bdrv_format_default_perms(BlockDriverState *bs, =
BdrvChild *c,
 bool bdrv_recurse_can_replace(BlockDriverState *bs,
                               BlockDriverState *to_replace);
=20
+bool bdrv_is_child_of(BlockDriverState *child, BlockDriverState *parent,
+                      int min_level);
+
 /*
  * Default implementation for drivers to pass bdrv_co_block_status() to
  * their file.
--=20
2.23.0


