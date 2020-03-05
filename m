Return-Path: <SRS0=BVCf=4W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3913AC3F2D1
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2020 12:55:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 031A12072D
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2020 12:55:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="H7IZGvWv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 031A12072D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48530 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j9q1m-0005kW-6x
	for qemu-devel@archiver.kernel.org; Thu, 05 Mar 2020 07:55:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43212)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1j9py5-0008Or-9J
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 07:51:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1j9py4-0006JL-1c
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 07:51:13 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:30464
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1j9py3-0006Ik-Uu
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 07:51:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583412671;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tmfXvHKaAYfmdyuEH+HGHNe3Vb7rTFVd+tbKs+hk7xA=;
 b=H7IZGvWvgsJiYZh+BMGcn2hEHMmDOTzkruafSDMqTQtwU8msA/qXr65IqQ+K/Fx+IeKfXV
 eHoT+adDq+LJh0abivxQ3+GG5KZfopn/n29tUDx/GpkpZMNM5kQSETFsvFi/ByEnmwPat3
 3B8mdMKFf1ZfS3A2fPnYejdYWwRZQ+Q=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-212-PiE5bvpuNYCf75frQKaviw-1; Thu, 05 Mar 2020 07:51:10 -0500
X-MC-Unique: PiE5bvpuNYCf75frQKaviw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 222C01005510;
 Thu,  5 Mar 2020 12:51:09 +0000 (UTC)
Received: from linux.fritz.box.com (ovpn-117-210.ams2.redhat.com
 [10.36.117.210])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 00760272A3;
 Thu,  5 Mar 2020 12:51:07 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH 2/4] block: Relax restrictions for blockdev-snapshot
Date: Thu,  5 Mar 2020 13:50:58 +0100
Message-Id: <20200305125100.386-3-kwolf@redhat.com>
In-Reply-To: <20200305125100.386-1-kwolf@redhat.com>
References: <20200305125100.386-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
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
Cc: kwolf@redhat.com, pkrempa@redhat.com, qemu-devel@nongnu.org,
 mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

blockdev-snapshot returned an error if the overlay was already in use,
which it defined as having any BlockBackend parent. This is in fact both
too strict (some parents can tolerate the change of visible data caused
by attaching a backing file) and too loose (some non-BlockBackend
parents may not be happy with it).

One important use case that is prevented by the too strict check is live
storage migration with blockdev-mirror. Here, the target node is
usually opened without a backing file so that the active layer is
mirrored while its backing chain can be copied in the background.

The backing chain should be attached to the mirror target node when
finalising the job, just before switching the users of the source node
to the new copy (at which point the mirror job still has a reference to
the node). drive-mirror did this automatically, but with blockdev-mirror
this is the job of the QMP client, so it needs a way to do this.

blockdev-snapshot is the obvious way, so this patch makes it work in
this scenario. The new condition is that no parent uses CONSISTENT_READ
permissions. This will ensure that the operation will still be blocked
when the node is attached to the guest device, so blockdev-snapshot
remains safe.

(For the sake of completeness, x-blockdev-reopen can be used to achieve
the same, however it is a big hammer, performs the graph change
completely unchecked and is still experimental. So even with the option
of using x-blockdev-reopen, there are reasons why blockdev-snapshot
should be able to perform this operation.)

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 blockdev.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/blockdev.c b/blockdev.c
index 3e44fa766b..bba0e9775b 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -1501,6 +1501,7 @@ static void external_snapshot_prepare(BlkActionState =
*common,
     TransactionAction *action =3D common->action;
     AioContext *aio_context;
     AioContext *old_context;
+    uint64_t perm, shared;
     int ret;
=20
     /* 'blockdev-snapshot' and 'blockdev-snapshot-sync' have similar
@@ -1616,16 +1617,17 @@ static void external_snapshot_prepare(BlkActionStat=
e *common,
         goto out;
     }
=20
-    if (bdrv_has_blk(state->new_bs)) {
+    /*
+     * Allow attaching a backing file to an overlay that's already in use =
only
+     * if the parents don't assume that they are already seeing a valid im=
age.
+     * (Specifically, allow it as a mirror target, which is write-only acc=
ess.)
+     */
+    bdrv_get_cumulative_perm(state->new_bs, &perm, &shared);
+    if (perm & BLK_PERM_CONSISTENT_READ) {
         error_setg(errp, "The overlay is already in use");
         goto out;
     }
=20
-    if (bdrv_op_is_blocked(state->new_bs, BLOCK_OP_TYPE_EXTERNAL_SNAPSHOT,
-                           errp)) {
-        goto out;
-    }
-
     if (state->new_bs->backing !=3D NULL) {
         error_setg(errp, "The overlay already has a backing image");
         goto out;
--=20
2.20.1


