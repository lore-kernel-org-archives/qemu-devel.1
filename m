Return-Path: <SRS0=mHy3=VQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2952C76195
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jul 2019 13:44:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 99B862173B
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jul 2019 13:44:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 99B862173B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45606 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hoTBk-0005dM-Ff
	for qemu-devel@archiver.kernel.org; Fri, 19 Jul 2019 09:44:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40274)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <kwolf@redhat.com>) id 1hoTB5-0003Bg-JP
 for qemu-devel@nongnu.org; Fri, 19 Jul 2019 09:44:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1hoTB4-0003TY-4S
 for qemu-devel@nongnu.org; Fri, 19 Jul 2019 09:44:03 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39418)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>)
 id 1hoTB1-0003Qx-0M; Fri, 19 Jul 2019 09:43:59 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 4E6EB30C34CF;
 Fri, 19 Jul 2019 13:43:58 +0000 (UTC)
Received: from dhcp-200-226.str.redhat.com (dhcp-200-226.str.redhat.com
 [10.33.200.226])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 66448608A4;
 Fri, 19 Jul 2019 13:43:57 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Date: Fri, 19 Jul 2019 15:43:34 +0200
Message-Id: <20190719134345.23526-3-kwolf@redhat.com>
In-Reply-To: <20190719134345.23526-1-kwolf@redhat.com>
References: <20190719134345.23526-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.40]); Fri, 19 Jul 2019 13:43:58 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 02/13] block: Introduce
 BdrvChild.parent_quiesce_counter
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
Cc: kwolf@redhat.com, peter.maydell@linaro.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Max Reitz <mreitz@redhat.com>

Commit 5cb2737e925042e6c7cd3fb0b01313950b03cddf laid out why
bdrv_do_drained_end() must decrement the quiesce_counter after
bdrv_drain_invoke().  It did not give a very good reason why it has to
happen after bdrv_parent_drained_end(), instead only claiming symmetry
to bdrv_do_drained_begin().

It turns out that delaying it for so long is wrong.

Situation: We have an active commit job (i.e. a mirror job) from top to
base for the following graph:

                  filter
                    |
                  [file]
                    |
                    v
top --[backing]--> base

Now the VM is closed, which results in the job being cancelled and a
bdrv_drain_all() happening pretty much simultaneously.

Beginning the drain means the job is paused once whenever one of its
nodes is quiesced.  This is reversed when the drain ends.

With how the code currently is, after base's drain ends (which means
that it will have unpaused the job once), its quiesce_counter remains at
1 while it goes to undrain its parents (bdrv_parent_drained_end()).  For
some reason or another, undraining filter causes the job to be kicked
and enter mirror_exit_common(), where it proceeds to invoke
block_job_remove_all_bdrv().

Now base will be detached from the job.  Because its quiesce_counter is
still 1, it will unpause the job once more.  So in total, undraining
base will unpause the job twice.  Eventually, this will lead to the
job's pause_count going negative -- well, it would, were there not an
assertion against this, which crashes qemu.

The general problem is that if in bdrv_parent_drained_end() we undrain
parent A, and then undrain parent B, which then leads to A detaching the
child, bdrv_replace_child_noperm() will undrain A as if we had not done
so yet; that is, one time too many.

It follows that we cannot decrement the quiesce_counter after invoking
bdrv_parent_drained_end().

Unfortunately, decrementing it before bdrv_parent_drained_end() would be
wrong, too.  Imagine the above situation in reverse: Undraining A leads
to B detaching the child.  If we had already decremented the
quiesce_counter by that point, bdrv_replace_child_noperm() would undrain
B one time too little; because it expects bdrv_parent_drained_end() to
issue this undrain.  But bdrv_parent_drained_end() won't do that,
because B is no longer a parent.

Therefore, we have to do something else.  This patch opts for
introducing a second quiesce_counter that counts how many times a
child's parent has been quiesced (though c->role->drained_*).  With
that, bdrv_replace_child_noperm() just has to undrain the parent exactly
that many times when removing a child, and it will always be right.

Signed-off-by: Max Reitz <mreitz@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 include/block/block.h     |  7 +++++++
 include/block/block_int.h |  9 +++++++++
 block.c                   | 15 +++++----------
 block/io.c                | 14 +++++++++++---
 4 files changed, 32 insertions(+), 13 deletions(-)

diff --git a/include/block/block.h b/include/block/block.h
index 734c9d2f76..bff3317696 100644
--- a/include/block/block.h
+++ b/include/block/block.h
@@ -617,6 +617,13 @@ void bdrv_parent_drained_begin(BlockDriverState *bs,=
 BdrvChild *ignore,
  */
 void bdrv_parent_drained_begin_single(BdrvChild *c, bool poll);
=20
+/**
+ * bdrv_parent_drained_end_single:
+ *
+ * End a quiesced section for the parent of @c.
+ */
+void bdrv_parent_drained_end_single(BdrvChild *c);
+
 /**
  * bdrv_parent_drained_end:
  *
diff --git a/include/block/block_int.h b/include/block/block_int.h
index 50902531b7..f5b044fcdb 100644
--- a/include/block/block_int.h
+++ b/include/block/block_int.h
@@ -729,6 +729,15 @@ struct BdrvChild {
      */
     bool frozen;
=20
+    /*
+     * How many times the parent of this child has been drained
+     * (through role->drained_*).
+     * Usually, this is equal to bs->quiesce_counter (potentially
+     * reduced by bdrv_drain_all_count).  It may differ while the
+     * child is entering or leaving a drained section.
+     */
+    int parent_quiesce_counter;
+
     QLIST_ENTRY(BdrvChild) next;
     QLIST_ENTRY(BdrvChild) next_parent;
 };
diff --git a/block.c b/block.c
index 29e931e217..8440712ca0 100644
--- a/block.c
+++ b/block.c
@@ -2251,24 +2251,19 @@ static void bdrv_replace_child_noperm(BdrvChild *=
child,
         if (child->role->detach) {
             child->role->detach(child);
         }
-        if (old_bs->quiesce_counter && child->role->drained_end) {
-            int num =3D old_bs->quiesce_counter;
-            if (child->role->parent_is_bds) {
-                num -=3D bdrv_drain_all_count;
-            }
-            assert(num >=3D 0);
-            for (i =3D 0; i < num; i++) {
-                child->role->drained_end(child);
-            }
+        while (child->parent_quiesce_counter) {
+            bdrv_parent_drained_end_single(child);
         }
         QLIST_REMOVE(child, next_parent);
+    } else {
+        assert(child->parent_quiesce_counter =3D=3D 0);
     }
=20
     child->bs =3D new_bs;
=20
     if (new_bs) {
         QLIST_INSERT_HEAD(&new_bs->parents, child, next_parent);
-        if (new_bs->quiesce_counter && child->role->drained_begin) {
+        if (new_bs->quiesce_counter) {
             int num =3D new_bs->quiesce_counter;
             if (child->role->parent_is_bds) {
                 num -=3D bdrv_drain_all_count;
diff --git a/block/io.c b/block/io.c
index 24a18759fd..1e618f9a37 100644
--- a/block/io.c
+++ b/block/io.c
@@ -55,6 +55,15 @@ void bdrv_parent_drained_begin(BlockDriverState *bs, B=
drvChild *ignore,
     }
 }
=20
+void bdrv_parent_drained_end_single(BdrvChild *c)
+{
+    assert(c->parent_quiesce_counter > 0);
+    c->parent_quiesce_counter--;
+    if (c->role->drained_end) {
+        c->role->drained_end(c);
+    }
+}
+
 void bdrv_parent_drained_end(BlockDriverState *bs, BdrvChild *ignore,
                              bool ignore_bds_parents)
 {
@@ -64,9 +73,7 @@ void bdrv_parent_drained_end(BlockDriverState *bs, Bdrv=
Child *ignore,
         if (c =3D=3D ignore || (ignore_bds_parents && c->role->parent_is=
_bds)) {
             continue;
         }
-        if (c->role->drained_end) {
-            c->role->drained_end(c);
-        }
+        bdrv_parent_drained_end_single(c);
     }
 }
=20
@@ -96,6 +103,7 @@ static bool bdrv_parent_drained_poll(BlockDriverState =
*bs, BdrvChild *ignore,
=20
 void bdrv_parent_drained_begin_single(BdrvChild *c, bool poll)
 {
+    c->parent_quiesce_counter++;
     if (c->role->drained_begin) {
         c->role->drained_begin(c);
     }
--=20
2.20.1


