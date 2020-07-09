Return-Path: <SRS0=Qbil=AU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85F5AC433E2
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2020 13:51:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5FD642074B
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2020 13:51:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5FD642074B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42450 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtWxU-0005wQ-NF
	for qemu-devel@archiver.kernel.org; Thu, 09 Jul 2020 09:51:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43094)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1jtWww-0005SW-2S
 for qemu-devel@nongnu.org; Thu, 09 Jul 2020 09:50:54 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:25135
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1jtWwu-0005w1-92
 for qemu-devel@nongnu.org; Thu, 09 Jul 2020 09:50:53 -0400
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-424-dnqXqXiNN4-hcsZT5mNiJg-1; Thu, 09 Jul 2020 09:50:48 -0400
X-MC-Unique: dnqXqXiNN4-hcsZT5mNiJg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1695AE919;
 Thu,  9 Jul 2020 13:50:47 +0000 (UTC)
Received: from bahia.lan (ovpn-112-37.ams2.redhat.com [10.36.112.37])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2BFF31001901;
 Thu,  9 Jul 2020 13:50:46 +0000 (UTC)
Subject: [PATCH] block: Avoid stale pointer dereference in
 blk_get_aio_context()
From: Greg Kurz <groug@kaod.org>
To: Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>
Date: Thu, 09 Jul 2020 15:50:45 +0200
Message-ID: <159430264541.389456.11925072456012783045.stgit@bahia.lan>
User-Agent: StGit/0.21
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: kaod.org
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: softfail client-ip=205.139.110.61; envelope-from=groug@kaod.org;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/09 04:20:09
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_SOFTFAIL=0.665 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

It is possible for blk_remove_bs() to race with blk_drain_all(), causing
the latter to dereference a stale blk->root pointer:


  blk_remove_bs(blk)
   bdrv_root_unref_child(blk->root)
    child_bs =3D blk->root->bs
    bdrv_detach_child(blk->root)
     ...
     g_free(blk->root) <=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D blk->roo=
t becomes stale
    bdrv_unref(child_bs) <=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D yield at som=
e point

A blk_drain_all() can be triggered by some guest action in the
meantime, eg. on POWER, SLOF might disable bus mastering on
a virtio-scsi-pci device:

  virtio_write_config()
   virtio_pci_stop_ioeventfd()
    virtio_bus_stop_ioeventfd()
     virtio_scsi_dataplane_stop()
      blk_drain_all()
       blk_get_aio_context()
       bs =3D blk->root ? blk->root->bs : NULL
            ^^^^^^^^^
              stale

Then, depending on one's luck, QEMU either crashes with SEGV or
hits the assertion in blk_get_aio_context().

blk->root is set by blk_insert_bs() which calls bdrv_root_attach_child()
first. The blk_remove_bs() function should rollback the changes made
by blk_insert_bs() in the opposite order (or it should be documented
somewhere why this isn't the case). Clear blk->root before calling
bdrv_root_unref_child() in blk_remove_bs().

Signed-off-by: Greg Kurz <groug@kaod.org>
---
 block/block-backend.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/block/block-backend.c b/block/block-backend.c
index 6936b25c836c..0bf0188133e3 100644
--- a/block/block-backend.c
+++ b/block/block-backend.c
@@ -808,6 +808,7 @@ void blk_remove_bs(BlockBackend *blk)
 {
     ThrottleGroupMember *tgm =3D &blk->public.throttle_group_member;
     BlockDriverState *bs;
+    BdrvChild *root;
=20
     notifier_list_notify(&blk->remove_bs_notifiers, blk);
     if (tgm->throttle_state) {
@@ -825,8 +826,9 @@ void blk_remove_bs(BlockBackend *blk)
      * to avoid that and a potential QEMU crash.
      */
     blk_drain(blk);
-    bdrv_root_unref_child(blk->root);
+    root =3D blk->root;
     blk->root =3D NULL;
+    bdrv_root_unref_child(root);
 }
=20
 /*



