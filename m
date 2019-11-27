Return-Path: <SRS0=bFmd=ZT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C1E1C43215
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Nov 2019 13:44:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4B9982073F
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Nov 2019 13:44:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HXLuCaTZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B9982073F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38508 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iZxcZ-00062W-1r
	for qemu-devel@archiver.kernel.org; Wed, 27 Nov 2019 08:44:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34125)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iZxCH-0004Uk-Fj
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 08:17:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iZxCG-00077s-1I
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 08:17:33 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:20664
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1iZxCF-00077d-UV
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 08:17:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574860651;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OLLQ1KTpyta8JCEYezhvRaLy+WXczLRCcZ8EtngMXB0=;
 b=HXLuCaTZbfv3FanzifFzsv9sUYbto/PBgRyou+pzdwJAgtVVajk44nW5ZZU5ua/aiirC80
 kyDqVBuVE2BlLP9n6MdHjNam936jid1fUpHWcIjNYyXUzZuzmD63skztyfFoODX7iO8zRC
 tkw9PD2axTuK/Rj0q3OpxEHsqlrDFNo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-133-y5e_GVI5Pnaa5uQKP_xYfg-1; Wed, 27 Nov 2019 08:17:28 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3A06B800598;
 Wed, 27 Nov 2019 13:17:27 +0000 (UTC)
Received: from localhost (ovpn-205-186.brq.redhat.com [10.40.205.186])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C2EB560BEC;
 Wed, 27 Nov 2019 13:17:26 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH for-5.0 25/31] tests: Use child_of_bds instead of child_file
Date: Wed, 27 Nov 2019 14:16:18 +0100
Message-Id: <20191127131624.1062403-26-mreitz@redhat.com>
In-Reply-To: <20191127131624.1062403-1-mreitz@redhat.com>
References: <20191127131624.1062403-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: y5e_GVI5Pnaa5uQKP_xYfg-1
X-Mimecast-Spam-Score: 0
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 tests/test-bdrv-drain.c     | 29 +++++++++++++++++------------
 tests/test-bdrv-graph-mod.c |  6 ++++--
 2 files changed, 21 insertions(+), 14 deletions(-)

diff --git a/tests/test-bdrv-drain.c b/tests/test-bdrv-drain.c
index 15393a0140..91567ca97d 100644
--- a/tests/test-bdrv-drain.c
+++ b/tests/test-bdrv-drain.c
@@ -97,7 +97,7 @@ static void bdrv_test_child_perm(BlockDriverState *bs, Bd=
rvChild *c,
      * detach_by_driver_cb_parent as one of them.
      */
     if (child_class !=3D &child_file && child_class !=3D &child_of_bds) {
-        child_class =3D &child_file;
+        child_class =3D &child_of_bds;
     }
=20
     bdrv_format_default_perms(bs, c, child_class, role, reopen_queue,
@@ -1203,7 +1203,8 @@ static void do_test_delete_by_drain(bool detach_inste=
ad_of_delete,
=20
     null_bs =3D bdrv_open("null-co://", NULL, NULL, BDRV_O_RDWR | BDRV_O_P=
ROTOCOL,
                         &error_abort);
-    bdrv_attach_child(bs, null_bs, "null-child", &child_file, 0, &error_ab=
ort);
+    bdrv_attach_child(bs, null_bs, "null-child", &child_of_bds,
+                      BDRV_CHILD_DATA, &error_abort);
=20
     /* This child will be the one to pass to requests through to, and
      * it will stall until a drain occurs */
@@ -1211,14 +1212,17 @@ static void do_test_delete_by_drain(bool detach_ins=
tead_of_delete,
                                     &error_abort);
     child_bs->total_sectors =3D 65536 >> BDRV_SECTOR_BITS;
     /* Takes our reference to child_bs */
-    tts->wait_child =3D bdrv_attach_child(bs, child_bs, "wait-child", &chi=
ld_file,
-                                        0, &error_abort);
+    tts->wait_child =3D bdrv_attach_child(bs, child_bs, "wait-child",
+                                        &child_of_bds,
+                                        BDRV_CHILD_DATA | BDRV_CHILD_PRIMA=
RY,
+                                        &error_abort);
=20
     /* This child is just there to be deleted
      * (for detach_instead_of_delete =3D=3D true) */
     null_bs =3D bdrv_open("null-co://", NULL, NULL, BDRV_O_RDWR | BDRV_O_P=
ROTOCOL,
                         &error_abort);
-    bdrv_attach_child(bs, null_bs, "null-child", &child_file, 0, &error_ab=
ort);
+    bdrv_attach_child(bs, null_bs, "null-child", &child_of_bds, BDRV_CHILD=
_DATA,
+                      &error_abort);
=20
     blk =3D blk_new(qemu_get_aio_context(), BLK_PERM_ALL, BLK_PERM_ALL);
     blk_insert_bs(blk, bs, &error_abort);
@@ -1315,7 +1319,8 @@ static void detach_indirect_bh(void *opaque)
=20
     bdrv_ref(data->c);
     data->child_c =3D bdrv_attach_child(data->parent_b, data->c, "PB-C",
-                                      &child_file, 0, &error_abort);
+                                      &child_of_bds, BDRV_CHILD_DATA,
+                                      &error_abort);
 }
=20
 static void detach_by_parent_aio_cb(void *opaque, int ret)
@@ -1332,7 +1337,7 @@ static void detach_by_driver_cb_drained_begin(BdrvChi=
ld *child)
 {
     aio_bh_schedule_oneshot(qemu_get_current_aio_context(),
                             detach_indirect_bh, &detach_by_parent_data);
-    child_file.drained_begin(child);
+    child_of_bds.drained_begin(child);
 }
=20
 static BdrvChildClass detach_by_driver_cb_class;
@@ -1367,7 +1372,7 @@ static void test_detach_indirect(bool by_parent_cb)
     QEMUIOVector qiov =3D QEMU_IOVEC_INIT_BUF(qiov, NULL, 0);
=20
     if (!by_parent_cb) {
-        detach_by_driver_cb_class =3D child_file;
+        detach_by_driver_cb_class =3D child_of_bds;
         detach_by_driver_cb_class.drained_begin =3D
             detach_by_driver_cb_drained_begin;
     }
@@ -1397,15 +1402,15 @@ static void test_detach_indirect(bool by_parent_cb)
     /* Set child relationships */
     bdrv_ref(b);
     bdrv_ref(a);
-    child_b =3D bdrv_attach_child(parent_b, b, "PB-B", &child_file, 0,
-                                &error_abort);
+    child_b =3D bdrv_attach_child(parent_b, b, "PB-B", &child_of_bds,
+                                BDRV_CHILD_DATA, &error_abort);
     child_a =3D bdrv_attach_child(parent_b, a, "PB-A", &child_of_bds,
                                 BDRV_CHILD_COW, &error_abort);
=20
     bdrv_ref(a);
     bdrv_attach_child(parent_a, a, "PA-A",
-                      by_parent_cb ? &child_file : &detach_by_driver_cb_cl=
ass,
-                      0, &error_abort);
+                      by_parent_cb ? &child_of_bds : &detach_by_driver_cb_=
class,
+                      BDRV_CHILD_DATA, &error_abort);
=20
     g_assert_cmpint(parent_a->refcnt, =3D=3D, 1);
     g_assert_cmpint(parent_b->refcnt, =3D=3D, 1);
diff --git a/tests/test-bdrv-graph-mod.c b/tests/test-bdrv-graph-mod.c
index 3707e2533c..6ae91ff171 100644
--- a/tests/test-bdrv-graph-mod.c
+++ b/tests/test-bdrv-graph-mod.c
@@ -112,7 +112,8 @@ static void test_update_perm_tree(void)
=20
     blk_insert_bs(root, bs, &error_abort);
=20
-    bdrv_attach_child(filter, bs, "child", &child_file, 0, &error_abort);
+    bdrv_attach_child(filter, bs, "child", &child_of_bds,
+                      BDRV_CHILD_FILTERED | BDRV_CHILD_PRIMARY, &error_abo=
rt);
=20
     bdrv_append(filter, bs, &local_err);
=20
@@ -178,7 +179,8 @@ static void test_should_update_child(void)
     bdrv_set_backing_hd(target, bs, &error_abort);
=20
     g_assert(target->backing->bs =3D=3D bs);
-    bdrv_attach_child(filter, target, "target", &child_file, 0, &error_abo=
rt);
+    bdrv_attach_child(filter, target, "target", &child_of_bds,
+                      BDRV_CHILD_DATA, &error_abort);
     bdrv_append(filter, bs, &error_abort);
     g_assert(target->backing->bs =3D=3D bs);
=20
--=20
2.23.0


