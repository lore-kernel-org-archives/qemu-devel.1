Return-Path: <SRS0=XqMt=3J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98A6DC2D0DB
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2020 11:08:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 639872073D
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2020 11:08:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZdP1UZ7N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 639872073D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34288 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1itUvS-0000PR-2E
	for qemu-devel@archiver.kernel.org; Mon, 20 Jan 2020 06:08:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39063)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1itUVi-0006eJ-VY
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 05:42:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1itUVf-0005yK-Cg
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 05:42:22 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:24736
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1itUVf-0005yE-9W
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 05:42:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579516938;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BLMdlgiEznEFCFhjl4MRTG3GCx9wPbAEUkGCEjpgEQ4=;
 b=ZdP1UZ7Now9u+N4IcLYpj+abTumh1dKMvjRXzV5E8y7ml5WhLrcQQk7aez17BE0AzPE3SB
 FjPp+OXp1oY0v+HEDp8PgjeMqOrtuTlcohEBUzruUb5onpVtXqJm8zWsrZ0WkFZGYldcCJ
 KQSCgejxIrVqXU3zNDIpqAC8gHw4PKs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-243-QL7ZaKBJMkuGj8tcXVcnmg-1; Mon, 20 Jan 2020 05:42:13 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AC81018A6EC2;
 Mon, 20 Jan 2020 10:42:12 +0000 (UTC)
Received: from linux.fritz.box (ovpn-116-194.ams2.redhat.com [10.36.116.194])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 871545C21A;
 Mon, 20 Jan 2020 10:42:11 +0000 (UTC)
Date: Mon, 20 Jan 2020 11:42:10 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: Eiichi Tsukata <devel@etsukata.com>
Subject: Re: [PATCH] block/backup: fix memory leak in bdrv_backup_top_append()
Message-ID: <20200120104210.GC4970@linux.fritz.box>
References: <20191223090632.30653-1-devel@etsukata.com>
 <221aa3d1-9e64-7fc4-e04b-dc6366978c18@virtuozzo.com>
 <9a335600-d9cc-bbed-7b2f-9d9d0174c7e7@etsukata.com>
MIME-Version: 1.0
In-Reply-To: <9a335600-d9cc-bbed-7b2f-9d9d0174c7e7@etsukata.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: QL7ZaKBJMkuGj8tcXVcnmg-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
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
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>,
 "mreitz@redhat.com" <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 23.12.2019 um 14:40 hat Eiichi Tsukata geschrieben:
>=20
>=20
> On 2019/12/23 21:40, Vladimir Sementsov-Ogievskiy wrote:
> > 23.12.2019 12:06, Eiichi Tsukata wrote:
> >> bdrv_open_driver() allocates bs->opaque according to drv->instance_siz=
e.
> >> There is no need to allocate it and overwrite opaque in
> >> bdrv_backup_top_append().
> >>
> >> Reproducer:
> >>
> >>    $ QTEST_QEMU_BINARY=3D./x86_64-softmmu/qemu-system-x86_64 valgrind =
-q --leak-check=3Dfull tests/test-replication -p /replication/secondary/sta=
rt
> >>    =3D=3D29792=3D=3D 24 bytes in 1 blocks are definitely lost in loss =
record 52 of 226
> >>    =3D=3D29792=3D=3D    at 0x483AB1A: calloc (vg_replace_malloc.c:762)
> >>    =3D=3D29792=3D=3D    by 0x4B07CE0: g_malloc0 (in /usr/lib64/libglib=
-2.0.so.0.6000.7)
> >>    =3D=3D29792=3D=3D    by 0x12BAB9: bdrv_open_driver (block.c:1289)
> >>    =3D=3D29792=3D=3D    by 0x12BEA9: bdrv_new_open_driver (block.c:135=
9)
> >>    =3D=3D29792=3D=3D    by 0x1D15CB: bdrv_backup_top_append (backup-to=
p.c:190)
> >>    =3D=3D29792=3D=3D    by 0x1CC11A: backup_job_create (backup.c:439)
> >>    =3D=3D29792=3D=3D    by 0x1CD542: replication_start (replication.c:=
544)
> >>    =3D=3D29792=3D=3D    by 0x1401B9: replication_start_all (replicatio=
n.c:52)
> >>    =3D=3D29792=3D=3D    by 0x128B50: test_secondary_start (test-replic=
ation.c:427)
> >>    ...
> >>
> >> Fixes: 7df7868b9640 ("block: introduce backup-top filter driver")
> >> Signed-off-by: Eiichi Tsukata <devel@etsukata.com>
> >> ---
> >>   block/backup-top.c | 2 +-
> >>   1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/block/backup-top.c b/block/backup-top.c
> >> index 7cdb1f8eba..617217374d 100644
> >> --- a/block/backup-top.c
> >> +++ b/block/backup-top.c
> >> @@ -196,7 +196,7 @@ BlockDriverState *bdrv_backup_top_append(BlockDriv=
erState *source,
> >>       }
> >>  =20
> >>       top->total_sectors =3D source->total_sectors;
> >> -    top->opaque =3D state =3D g_new0(BDRVBackupTopState, 1);
> >> +    state =3D top->opaque;
> >>  =20
> >>       bdrv_ref(target);
> >>       state->target =3D bdrv_attach_child(top, target, "target", &chil=
d_file, errp);
> >>
> >=20
> > Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> >=20
> > Hmm, it was not my idea, I just copied it from mirror.. And there shoul=
d be the same leak. and
> > may be in other places:
> >=20
> > # git grep 'opaque =3D.*g_new'
> > block/backup-top.c:    top->opaque =3D state =3D g_new0(BDRVBackupTopSt=
ate, 1);

Fixed by this patch.

> > block/file-posix.c:    state->opaque =3D g_new0(BDRVRawReopenState, 1);
> > block/gluster.c:    state->opaque =3D g_new0(BDRVGlusterReopenState, 1)=
;
> > block/raw-format.c:    reopen_state->opaque =3D g_new0(BDRVRawState, 1)=
;
> > block/sheepdog.c:    re_s =3D state->opaque =3D g_new0(BDRVSheepdogReop=
enState, 1);

Doing this for reopen state is fine.

> > block/iscsi.c:    bs->opaque =3D g_new0(struct IscsiLun, 1);

This one looks kind of questionable. It basically builds its
BlockDriveState manually without using any of the block layer open
functions.

> > block/mirror.c:    bs_opaque =3D g_new0(MirrorBDSOpaque, 1);

Harmless as Eiichi explained below, but not nice either.

> Thanks for reviewing.
> As you say, block/mirror.c has similar code. But it does not cause the le=
ak.
> The difference is bdrv_mirror_top BlockDriver does not have .instance_siz=
e
> whereas bdrv_backup_top_filter BlockDriver has .instance_size =3D sizeof(=
BDRVBackupTopState).
> So when bdrv_open_driver() is called from mirror.c, g_malloc0(0) is
> called allocating nothing.

I think it should still be changed just because it would make the code
cleaner. It's always better to use common infrastructure than
reimplementing it locally.

Kevin


