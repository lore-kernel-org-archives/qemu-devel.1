Return-Path: <SRS0=PWAB=4X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F89CC10DCE
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2020 17:29:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0B4DC2051A
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2020 17:29:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QPdjLq75"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B4DC2051A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40008 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jAGmy-0001VK-5x
	for qemu-devel@archiver.kernel.org; Fri, 06 Mar 2020 12:29:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49037)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1jAGZi-0005K8-Qa
 for qemu-devel@nongnu.org; Fri, 06 Mar 2020 12:15:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1jAGZh-0000CR-CK
 for qemu-devel@nongnu.org; Fri, 06 Mar 2020 12:15:50 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:31459
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1jAGZh-00008g-69
 for qemu-devel@nongnu.org; Fri, 06 Mar 2020 12:15:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583514947;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IPhzgXwYKIPvGU4hituByNTQBmvc9DGERkEjCGZhogo=;
 b=QPdjLq755UG4bIpwJIGY3Rekwo/fIQLOC7IwEZQmMmb4dkwCZzYI1nZcgvP71szulctBKH
 kBjWqoRfx5OAF27I1X/zP/3nOUBHZwDkVl3iswrju/UcmnATXCP402TdrUsme5Gy8pyB7X
 RQJ0LThT2qM/ZweeID3XVnPON5Lqw4E=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-224-DMfpYStoNJepv9sMrIJ72g-1; Fri, 06 Mar 2020 12:15:44 -0500
X-MC-Unique: DMfpYStoNJepv9sMrIJ72g-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 05844100550D;
 Fri,  6 Mar 2020 17:15:43 +0000 (UTC)
Received: from linux.fritz.box.com (unknown [10.36.118.33])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0E99A73873;
 Fri,  6 Mar 2020 17:15:41 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Subject: [PULL 29/29] block: bdrv_reopen() with backing file in different
 AioContext
Date: Fri,  6 Mar 2020 18:14:58 +0100
Message-Id: <20200306171458.1848-30-kwolf@redhat.com>
In-Reply-To: <20200306171458.1848-1-kwolf@redhat.com>
References: <20200306171458.1848-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: kwolf@redhat.com, peter.maydell@linaro.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This patch allows bdrv_reopen() (and therefore the x-blockdev-reopen QMP
command) to attach a node as the new backing file even if the node is in
a different AioContext than the parent if one of both nodes can be moved
to the AioContext of the other node.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Tested-by: Peter Krempa <pkrempa@redhat.com>
Message-Id: <20200306141413.30705-3-kwolf@redhat.com>
Reviewed-by: Alberto Garcia <berto@igalia.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block.c                | 32 ++++++++++++++++++++++++++------
 tests/qemu-iotests/245 |  8 +++-----
 2 files changed, 29 insertions(+), 11 deletions(-)

diff --git a/block.c b/block.c
index aaa387504e..957630b1c5 100644
--- a/block.c
+++ b/block.c
@@ -3787,6 +3787,29 @@ static void bdrv_reopen_perm(BlockReopenQueue *q, Bl=
ockDriverState *bs,
     *shared =3D cumulative_shared_perms;
 }
=20
+static bool bdrv_reopen_can_attach(BlockDriverState *parent,
+                                   BdrvChild *child,
+                                   BlockDriverState *new_child,
+                                   Error **errp)
+{
+    AioContext *parent_ctx =3D bdrv_get_aio_context(parent);
+    AioContext *child_ctx =3D bdrv_get_aio_context(new_child);
+    GSList *ignore;
+    bool ret;
+
+    ignore =3D g_slist_prepend(NULL, child);
+    ret =3D bdrv_can_set_aio_context(new_child, parent_ctx, &ignore, NULL)=
;
+    g_slist_free(ignore);
+    if (ret) {
+        return ret;
+    }
+
+    ignore =3D g_slist_prepend(NULL, child);
+    ret =3D bdrv_can_set_aio_context(parent, child_ctx, &ignore, errp);
+    g_slist_free(ignore);
+    return ret;
+}
+
 /*
  * Take a BDRVReopenState and check if the value of 'backing' in the
  * reopen_state->options QDict is valid or not.
@@ -3838,14 +3861,11 @@ static int bdrv_reopen_parse_backing(BDRVReopenStat=
e *reopen_state,
     }
=20
     /*
-     * TODO: before removing the x- prefix from x-blockdev-reopen we
-     * should move the new backing file into the right AioContext
-     * instead of returning an error.
+     * Check AioContext compatibility so that the bdrv_set_backing_hd() ca=
ll in
+     * bdrv_reopen_commit() won't fail.
      */
     if (new_backing_bs) {
-        if (bdrv_get_aio_context(new_backing_bs) !=3D bdrv_get_aio_context=
(bs)) {
-            error_setg(errp, "Cannot use a new backing file "
-                       "with a different AioContext");
+        if (!bdrv_reopen_can_attach(bs, bs->backing, new_backing_bs, errp)=
) {
             return -EINVAL;
         }
     }
diff --git a/tests/qemu-iotests/245 b/tests/qemu-iotests/245
index 7d9eb6285c..1001275a44 100755
--- a/tests/qemu-iotests/245
+++ b/tests/qemu-iotests/245
@@ -1015,18 +1015,16 @@ class TestBlockdevReopen(iotests.QMPTestCase):
     # neither of them can switch to the other AioContext
     def test_iothreads_error(self):
         self.run_test_iothreads('iothread0', 'iothread1',
-                                "Cannot use a new backing file with a diff=
erent AioContext")
+                                "Cannot change iothread of active block ba=
ckend")
=20
     def test_iothreads_compatible_users(self):
         self.run_test_iothreads('iothread0', 'iothread0')
=20
     def test_iothreads_switch_backing(self):
-        self.run_test_iothreads('iothread0', None,
-                                "Cannot use a new backing file with a diff=
erent AioContext")
+        self.run_test_iothreads('iothread0', None)
=20
     def test_iothreads_switch_overlay(self):
-        self.run_test_iothreads(None, 'iothread0',
-                                "Cannot use a new backing file with a diff=
erent AioContext")
+        self.run_test_iothreads(None, 'iothread0')
=20
 if __name__ =3D=3D '__main__':
     iotests.main(supported_fmts=3D["qcow2"],
--=20
2.20.1


