Return-Path: <SRS0=ES4k=XM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E4BBC49ED7
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2019 02:40:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2AFDC20678
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2019 02:40:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2AFDC20678
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41448 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iA3Ph-0006Ux-8g
	for qemu-devel@archiver.kernel.org; Mon, 16 Sep 2019 22:40:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43124)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1iA3Oy-00060y-7P
 for qemu-devel@nongnu.org; Mon, 16 Sep 2019 22:39:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1iA3Ow-0006Rh-LJ
 for qemu-devel@nongnu.org; Mon, 16 Sep 2019 22:39:36 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51588)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>)
 id 1iA3Or-0006PK-Q1; Mon, 16 Sep 2019 22:39:30 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 6203210CC1E4;
 Tue, 17 Sep 2019 02:39:28 +0000 (UTC)
Received: from blue.redhat.com (ovpn-116-234.phx2.redhat.com [10.3.116.234])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 820985D6A9;
 Tue, 17 Sep 2019 02:39:25 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Date: Mon, 16 Sep 2019 21:39:17 -0500
Message-Id: <20190917023917.32226-1-eblake@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.65]); Tue, 17 Sep 2019 02:39:28 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH] nbd: Grab aio context lock in more places
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
Cc: kwolf@redhat.com, "open list:Network Block Dev..." <qemu-block@nongnu.org>,
 slp@redhat.com, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

When iothreads are in use, the failure to grab the aio context results
in an assertion failure when trying to unlock things during blk_unref,
when trying to unlock a mutex that was not locked.  In short, all
calls to nbd_export_put need to done while within the correct aio
context.  But since nbd_export_put can recursively reach itself via
nbd_export_close, and recursively grabbing the context would deadlock,
we can't do the context grab directly in those functions, but must do
so in their callers.

Hoist the use of the correct aio_context from nbd_export_new() to its
caller qmp_nbd_server_add().  Then tweak qmp_nbd_server_remove(),
nbd_eject_notifier(), and nbd_esport_close_all() to grab the right
context, so that all callers during qemu now own the context before
nbd_export_put() can call blk_unref().

Remaining uses in qemu-nbd don't matter (since that use case does not
support iothreads).

Suggested-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Eric Blake <eblake@redhat.com>
---

With this in place, my emailed formula [1] for causing an iothread
assertion failure no longer hits, and all the -nbd and -qcow2 iotests
still pass.  I would still like to update iotests to cover things (I
could not quickly figure out how to make iotest 222 use iothreads -
either we modify that one or add a new one), but wanted to get review
started on this first.

[1] https://lists.gnu.org/archive/html/qemu-devel/2019-09/msg03383.html

 include/block/nbd.h |  1 +
 blockdev-nbd.c      | 14 ++++++++++++--
 nbd/server.c        | 23 +++++++++++++++++++----
 3 files changed, 32 insertions(+), 6 deletions(-)

diff --git a/include/block/nbd.h b/include/block/nbd.h
index 21550747cf35..316fd705a9e4 100644
--- a/include/block/nbd.h
+++ b/include/block/nbd.h
@@ -340,6 +340,7 @@ void nbd_export_put(NBDExport *exp);

 BlockBackend *nbd_export_get_blockdev(NBDExport *exp);

+AioContext *nbd_export_aio_context(NBDExport *exp);
 NBDExport *nbd_export_find(const char *name);
 void nbd_export_close_all(void);

diff --git a/blockdev-nbd.c b/blockdev-nbd.c
index 213f226ac1c4..6a8b206e1d74 100644
--- a/blockdev-nbd.c
+++ b/blockdev-nbd.c
@@ -151,6 +151,7 @@ void qmp_nbd_server_add(const char *device, bool has_=
name, const char *name,
     BlockBackend *on_eject_blk;
     NBDExport *exp;
     int64_t len;
+    AioContext *aio_context;

     if (!nbd_server) {
         error_setg(errp, "NBD server not running");
@@ -173,11 +174,13 @@ void qmp_nbd_server_add(const char *device, bool ha=
s_name, const char *name,
         return;
     }

+    aio_context =3D bdrv_get_aio_context(bs);
+    aio_context_acquire(aio_context);
     len =3D bdrv_getlength(bs);
     if (len < 0) {
         error_setg_errno(errp, -len,
                          "Failed to determine the NBD export's length");
-        return;
+        goto out;
     }

     if (!has_writable) {
@@ -190,13 +193,16 @@ void qmp_nbd_server_add(const char *device, bool ha=
s_name, const char *name,
     exp =3D nbd_export_new(bs, 0, len, name, NULL, bitmap, !writable, !w=
ritable,
                          NULL, false, on_eject_blk, errp);
     if (!exp) {
-        return;
+        goto out;
     }

     /* The list of named exports has a strong reference to this export n=
ow and
      * our only way of accessing it is through nbd_export_find(), so we =
can drop
      * the strong reference that is @exp. */
     nbd_export_put(exp);
+
+ out:
+    aio_context_release(aio_context);
 }

 void qmp_nbd_server_remove(const char *name,
@@ -204,6 +210,7 @@ void qmp_nbd_server_remove(const char *name,
                            Error **errp)
 {
     NBDExport *exp;
+    AioContext *aio_context;

     if (!nbd_server) {
         error_setg(errp, "NBD server not running");
@@ -220,7 +227,10 @@ void qmp_nbd_server_remove(const char *name,
         mode =3D NBD_SERVER_REMOVE_MODE_SAFE;
     }

+    aio_context =3D nbd_export_aio_context(exp);
+    aio_context_acquire(aio_context);
     nbd_export_remove(exp, mode, errp);
+    aio_context_release(aio_context);
 }

 void qmp_nbd_server_stop(Error **errp)
diff --git a/nbd/server.c b/nbd/server.c
index 378784c1e54a..3003381c86b4 100644
--- a/nbd/server.c
+++ b/nbd/server.c
@@ -1458,7 +1458,12 @@ static void blk_aio_detach(void *opaque)
 static void nbd_eject_notifier(Notifier *n, void *data)
 {
     NBDExport *exp =3D container_of(n, NBDExport, eject_notifier);
+    AioContext *aio_context;
+
+    aio_context =3D exp->ctx;
+    aio_context_acquire(aio_context);
     nbd_export_close(exp);
+    aio_context_release(aio_context);
 }

 NBDExport *nbd_export_new(BlockDriverState *bs, uint64_t dev_offset,
@@ -1477,12 +1482,11 @@ NBDExport *nbd_export_new(BlockDriverState *bs, u=
int64_t dev_offset,
      * NBD exports are used for non-shared storage migration.  Make sure
      * that BDRV_O_INACTIVE is cleared and the image is ready for write
      * access since the export could be available before migration hando=
ver.
+     * ctx was acquired in the caller.
      */
     assert(name);
     ctx =3D bdrv_get_aio_context(bs);
-    aio_context_acquire(ctx);
     bdrv_invalidate_cache(bs, NULL);
-    aio_context_release(ctx);

     /* Don't allow resize while the NBD server is running, otherwise we =
don't
      * care what happens with the node. */
@@ -1490,7 +1494,7 @@ NBDExport *nbd_export_new(BlockDriverState *bs, uin=
t64_t dev_offset,
     if (!readonly) {
         perm |=3D BLK_PERM_WRITE;
     }
-    blk =3D blk_new(bdrv_get_aio_context(bs), perm,
+    blk =3D blk_new(ctx, perm,
                   BLK_PERM_CONSISTENT_READ | BLK_PERM_WRITE_UNCHANGED |
                   BLK_PERM_WRITE | BLK_PERM_GRAPH_MOD);
     ret =3D blk_insert_bs(blk, bs, errp);
@@ -1557,7 +1561,7 @@ NBDExport *nbd_export_new(BlockDriverState *bs, uin=
t64_t dev_offset,
     }

     exp->close =3D close;
-    exp->ctx =3D blk_get_aio_context(blk);
+    exp->ctx =3D ctx;
     blk_add_aio_context_notifier(blk, blk_aio_attached, blk_aio_detach, =
exp);

     if (on_eject_blk) {
@@ -1590,11 +1594,18 @@ NBDExport *nbd_export_find(const char *name)
     return NULL;
 }

+AioContext *
+nbd_export_aio_context(NBDExport *exp)
+{
+    return exp->ctx;
+}
+
 void nbd_export_close(NBDExport *exp)
 {
     NBDClient *client, *next;

     nbd_export_get(exp);
+
     /*
      * TODO: Should we expand QMP NbdServerRemoveNode enum to allow a
      * close mode that stops advertising the export to new clients but
@@ -1684,9 +1695,13 @@ BlockBackend *nbd_export_get_blockdev(NBDExport *e=
xp)
 void nbd_export_close_all(void)
 {
     NBDExport *exp, *next;
+    AioContext *aio_context;

     QTAILQ_FOREACH_SAFE(exp, &exports, next, next) {
+        aio_context =3D exp->ctx;
+        aio_context_acquire(aio_context);
         nbd_export_close(exp);
+        aio_context_release(aio_context);
     }
 }

--=20
2.21.0


