Return-Path: <SRS0=ZRpO=43=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF231C10F27
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 11:39:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A1D5B24655
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 11:39:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GASlawyW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A1D5B24655
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58446 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBdEg-0004m2-Ov
	for qemu-devel@archiver.kernel.org; Tue, 10 Mar 2020 07:39:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56106)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1jBdDl-0003Er-AW
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 07:38:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1jBdDj-0008N2-6b
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 07:38:49 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:45701
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1jBdDh-0008JD-Dv
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 07:38:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583840324;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wr1m7nY8KZW+Pv1GXYAt2uYKV/3H/96a7czWg0SsEP8=;
 b=GASlawyWGY1SSu+l5p0exZf9+0xc7PR+AIa4IRZwMx1rR4GuCyeseCP4X+RWG1XXJN0SV9
 4fGA/hXSoCKWE6beEvi+s0iRhGkKuRNyqIvLKTBvPmob/LFUtb+JnCSiG/IX88MFZYtPSU
 s2bTt5RDOOV8HOIERdhAK+IPqb1l7xk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-159-yxzxi2s4M06gBR69TT6Pvg-1; Tue, 10 Mar 2020 07:38:42 -0400
X-MC-Unique: yxzxi2s4M06gBR69TT6Pvg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B65C3DBA5;
 Tue, 10 Mar 2020 11:38:41 +0000 (UTC)
Received: from linux.fritz.box.com (unknown [10.36.118.104])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 92F2F87B2F;
 Tue, 10 Mar 2020 11:38:40 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH v2 2/7] block: Relax restrictions for blockdev-snapshot
Date: Tue, 10 Mar 2020 12:38:26 +0100
Message-Id: <20200310113831.27293-3-kwolf@redhat.com>
In-Reply-To: <20200310113831.27293-1-kwolf@redhat.com>
References: <20200310113831.27293-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
 blockdev.c                 | 14 ++++++++------
 tests/qemu-iotests/085.out |  4 ++--
 2 files changed, 10 insertions(+), 8 deletions(-)

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
diff --git a/tests/qemu-iotests/085.out b/tests/qemu-iotests/085.out
index d94ad22f70..fd11aae678 100644
--- a/tests/qemu-iotests/085.out
+++ b/tests/qemu-iotests/085.out
@@ -82,7 +82,7 @@ Formatting 'TEST_DIR/12-snapshot-v0.IMGFMT', fmt=3DIMGFMT=
 size=3D134217728 backing_f
 =3D=3D=3D Invalid command - cannot create a snapshot using a file BDS =3D=
=3D=3D
=20
 { 'execute': 'blockdev-snapshot', 'arguments': { 'node':'virtio0', 'overla=
y':'file_12' } }
-{"error": {"class": "GenericError", "desc": "The overlay does not support =
backing images"}}
+{"error": {"class": "GenericError", "desc": "The overlay is already in use=
"}}
=20
 =3D=3D=3D Invalid command - snapshot node used as active layer =3D=3D=3D
=20
@@ -96,7 +96,7 @@ Formatting 'TEST_DIR/12-snapshot-v0.IMGFMT', fmt=3DIMGFMT=
 size=3D134217728 backing_f
 =3D=3D=3D Invalid command - snapshot node used as backing hd =3D=3D=3D
=20
 { 'execute': 'blockdev-snapshot', 'arguments': { 'node': 'virtio0', 'overl=
ay':'snap_11' } }
-{"error": {"class": "GenericError", "desc": "Node 'snap_11' is busy: node =
is used as backing hd of 'snap_12'"}}
+{"error": {"class": "GenericError", "desc": "The overlay is already in use=
"}}
=20
 =3D=3D=3D Invalid command - snapshot node has a backing image =3D=3D=3D
=20
--=20
2.20.1


