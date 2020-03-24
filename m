Return-Path: <SRS0=M7c2=5J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E2F1C4332B
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2020 12:23:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DD9AB2080C
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2020 12:23:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Vn5Dm3rR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD9AB2080C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47924 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jGib5-0007uo-42
	for qemu-devel@archiver.kernel.org; Tue, 24 Mar 2020 08:23:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41190)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1jGiYH-00048l-HT
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 08:21:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1jGiYG-0007u0-1T
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 08:21:01 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:58551)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1jGiYF-0007tk-TL
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 08:20:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585052459;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yNVzXAqjKE/6iQd4fcPucPVqAA77znoQ7wu4k+4CAmY=;
 b=Vn5Dm3rR0QDctTF3jQhMINN01f16k07Y4MwG6mmhSIhfSc+2DzJJZQaDSXL7OeuxhQ3hdP
 Uw3h6z4IfQ7xoGrCrNm51GOXfHUdTIu1GYDoGUxrqJ1rsL4iZab3jFOKNH3qyAbRKzIREA
 fAlSItdU+IFMy80eg2+OmD6QWYMRX2M=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-438-8zoWZ1YLNnyKMEWsEht85Q-1; Tue, 24 Mar 2020 08:20:57 -0400
X-MC-Unique: 8zoWZ1YLNnyKMEWsEht85Q-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C332F18A8C81;
 Tue, 24 Mar 2020 12:20:56 +0000 (UTC)
Received: from localhost (ovpn-114-213.ams2.redhat.com [10.36.114.213])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 3A7B6399;
 Tue, 24 Mar 2020 12:20:55 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PULL 3/6] block: bdrv_set_backing_bs: fix use-after-free
Date: Tue, 24 Mar 2020 13:20:41 +0100
Message-Id: <20200324122044.1131326-4-mreitz@redhat.com>
In-Reply-To: <20200324122044.1131326-1-mreitz@redhat.com>
References: <20200324122044.1131326-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 63.128.21.74
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

There is a use-after-free possible: bdrv_unref_child() leaves
bs->backing freed but not NULL. bdrv_attach_child may produce nested
polling loop due to drain, than access of freed pointer is possible.

I've produced the following crash on 30 iotest with modified code. It
does not reproduce on master, but still seems possible:

    #0  __strcmp_avx2 () at /lib64/libc.so.6
    #1  bdrv_backing_overridden (bs=3D0x55c9d3cc2060) at block.c:6350
    #2  bdrv_refresh_filename (bs=3D0x55c9d3cc2060) at block.c:6404
    #3  bdrv_backing_attach (c=3D0x55c9d48e5520) at block.c:1063
    #4  bdrv_replace_child_noperm
        (child=3Dchild@entry=3D0x55c9d48e5520,
        new_bs=3Dnew_bs@entry=3D0x55c9d3cc2060) at block.c:2290
    #5  bdrv_replace_child
        (child=3Dchild@entry=3D0x55c9d48e5520,
        new_bs=3Dnew_bs@entry=3D0x55c9d3cc2060) at block.c:2320
    #6  bdrv_root_attach_child
        (child_bs=3Dchild_bs@entry=3D0x55c9d3cc2060,
        child_name=3Dchild_name@entry=3D0x55c9d241d478 "backing",
        child_role=3Dchild_role@entry=3D0x55c9d26ecee0 <child_backing>,
        ctx=3D<optimized out>, perm=3D<optimized out>, shared_perm=3D21,
        opaque=3D0x55c9d3c5a3d0, errp=3D0x7ffd117108e0) at block.c:2424
    #7  bdrv_attach_child
        (parent_bs=3Dparent_bs@entry=3D0x55c9d3c5a3d0,
        child_bs=3Dchild_bs@entry=3D0x55c9d3cc2060,
        child_name=3Dchild_name@entry=3D0x55c9d241d478 "backing",
        child_role=3Dchild_role@entry=3D0x55c9d26ecee0 <child_backing>,
        errp=3Derrp@entry=3D0x7ffd117108e0) at block.c:5876
    #8  in bdrv_set_backing_hd
        (bs=3Dbs@entry=3D0x55c9d3c5a3d0,
        backing_hd=3Dbacking_hd@entry=3D0x55c9d3cc2060,
        errp=3Derrp@entry=3D0x7ffd117108e0)
        at block.c:2576
    #9  stream_prepare (job=3D0x55c9d49d84a0) at block/stream.c:150
    #10 job_prepare (job=3D0x55c9d49d84a0) at job.c:761
    #11 job_txn_apply (txn=3D<optimized out>, fn=3D<optimized out>) at
        job.c:145
    #12 job_do_finalize (job=3D0x55c9d49d84a0) at job.c:778
    #13 job_completed_txn_success (job=3D0x55c9d49d84a0) at job.c:832
    #14 job_completed (job=3D0x55c9d49d84a0) at job.c:845
    #15 job_completed (job=3D0x55c9d49d84a0) at job.c:836
    #16 job_exit (opaque=3D0x55c9d49d84a0) at job.c:864
    #17 aio_bh_call (bh=3D0x55c9d471a160) at util/async.c:117
    #18 aio_bh_poll (ctx=3Dctx@entry=3D0x55c9d3c46720) at util/async.c:117
    #19 aio_poll (ctx=3Dctx@entry=3D0x55c9d3c46720,
        blocking=3Dblocking@entry=3Dtrue)
        at util/aio-posix.c:728
    #20 bdrv_parent_drained_begin_single (poll=3Dtrue, c=3D0x55c9d3d558f0)
        at block/io.c:121
    #21 bdrv_parent_drained_begin_single (c=3Dc@entry=3D0x55c9d3d558f0,
        poll=3Dpoll@entry=3Dtrue)
        at block/io.c:114
    #22 bdrv_replace_child_noperm
        (child=3Dchild@entry=3D0x55c9d3d558f0,
        new_bs=3Dnew_bs@entry=3D0x55c9d3d27300) at block.c:2258
    #23 bdrv_replace_child
        (child=3Dchild@entry=3D0x55c9d3d558f0,
        new_bs=3Dnew_bs@entry=3D0x55c9d3d27300) at block.c:2320
    #24 bdrv_root_attach_child
        (child_bs=3Dchild_bs@entry=3D0x55c9d3d27300,
        child_name=3Dchild_name@entry=3D0x55c9d241d478 "backing",
        child_role=3Dchild_role@entry=3D0x55c9d26ecee0 <child_backing>,
        ctx=3D<optimized out>, perm=3D<optimized out>, shared_perm=3D21,
        opaque=3D0x55c9d3cc2060, errp=3D0x7ffd11710c60) at block.c:2424
    #25 bdrv_attach_child
        (parent_bs=3Dparent_bs@entry=3D0x55c9d3cc2060,
        child_bs=3Dchild_bs@entry=3D0x55c9d3d27300,
        child_name=3Dchild_name@entry=3D0x55c9d241d478 "backing",
        child_role=3Dchild_role@entry=3D0x55c9d26ecee0 <child_backing>,
        errp=3Derrp@entry=3D0x7ffd11710c60) at block.c:5876
    #26 bdrv_set_backing_hd
        (bs=3Dbs@entry=3D0x55c9d3cc2060,
        backing_hd=3Dbacking_hd@entry=3D0x55c9d3d27300,
        errp=3Derrp@entry=3D0x7ffd11710c60)
        at block.c:2576
    #27 stream_prepare (job=3D0x55c9d495ead0) at block/stream.c:150
    ...

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-Id: <20200316060631.30052-2-vsementsov@virtuozzo.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Reviewed-by: John Snow <jsnow@redhat.com>
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 block.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block.c b/block.c
index 6b984dc883..cccae5add9 100644
--- a/block.c
+++ b/block.c
@@ -2760,10 +2760,10 @@ void bdrv_set_backing_hd(BlockDriverState *bs, Bloc=
kDriverState *backing_hd,
=20
     if (bs->backing) {
         bdrv_unref_child(bs, bs->backing);
+        bs->backing =3D NULL;
     }
=20
     if (!backing_hd) {
-        bs->backing =3D NULL;
         goto out;
     }
=20
--=20
2.25.1


