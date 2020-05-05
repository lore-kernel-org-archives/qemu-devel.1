Return-Path: <SRS0=1jZz=6T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3971C47254
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2020 10:04:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 987B8206B9
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2020 10:04:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aE57AK0u"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 987B8206B9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35532 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVuRK-0001aQ-O8
	for qemu-devel@archiver.kernel.org; Tue, 05 May 2020 06:04:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55804)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jVuQZ-0000cc-5T
 for qemu-devel@nongnu.org; Tue, 05 May 2020 06:03:51 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:20798
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jVuQX-00008N-6M
 for qemu-devel@nongnu.org; Tue, 05 May 2020 06:03:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588673027;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/FZ/eOCfchc6eLOGDCpUI3FFyRBDCbTDo16wzifFN0Y=;
 b=aE57AK0ufZczvJga/xj1E3XYEMMv4nXEWGRDVuEXS2V3o7cOPjdSKXHo3cS9OlzoAPkvt2
 RELMSd32neHC6UI8oZb89ml2pIfp/psNvnVDS6uPuGEzRHpJJokIQvm4G6rF/q+TP/BEYb
 rwypXjweTDehr2MPjgtbGRLivNel6Qo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-164-QVFJ4h6dPtKLqBjzuWyjcQ-1; Tue, 05 May 2020 06:03:45 -0400
X-MC-Unique: QVFJ4h6dPtKLqBjzuWyjcQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EDFAB835B8B;
 Tue,  5 May 2020 10:03:44 +0000 (UTC)
Received: from linux.fritz.box (ovpn-112-11.ams2.redhat.com [10.36.112.11])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 9FD645C1B2;
 Tue,  5 May 2020 10:03:43 +0000 (UTC)
Date: Tue, 5 May 2020 12:03:42 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Subject: Re: [PATCH v2 3/4] backup: Make sure that source and target size match
Message-ID: <20200505100334.GH5759@linux.fritz.box>
References: <20200430142755.315494-1-kwolf@redhat.com>
 <20200430142755.315494-4-kwolf@redhat.com>
 <d5de1915-523b-fbdb-2ebe-8c31cf0e0cdf@virtuozzo.com>
MIME-Version: 1.0
In-Reply-To: <d5de1915-523b-fbdb-2ebe-8c31cf0e0cdf@virtuozzo.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.120; envelope-from=kwolf@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/05 03:48:16
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: jsnow@redhat.com, qemu-devel@nongnu.org, qemu-block@nongnu.org,
 mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 30.04.2020 um 20:21 hat Vladimir Sementsov-Ogievskiy geschrieben:
> 30.04.2020 17:27, Kevin Wolf wrote:
> > Since the introduction of a backup filter node in commit 00e30f05d, the
> > backup block job crashes when the target image is smaller than the
> > source image because it will try to write after the end of the target
> > node without having BLK_PERM_RESIZE. (Previously, the BlockBackend laye=
r
> > would have caught this and errored out gracefully.)
> >=20
> > We can fix this and even do better than the old behaviour: Check that
> > source and target have the same image size at the start of the block jo=
b
> > and unshare BLK_PERM_RESIZE. (This permission was already unshared
> > before the same commit 00e30f05d, but the BlockBackend that was used to
> > make the restriction was removed without a replacement.) This will
> > immediately error out when starting the job instead of only when writin=
g
> > to a block that doesn't exist in the target.
> >=20
> > Longer target than source would technically work because we would never
> > write to blocks that don't exist, but semantically these are invalid,
> > too, because a backup is supposed to create a copy, not just an image
> > that starts with a copy.
> >=20
> > Fixes: 00e30f05de1d19586345ec373970ef4c192c6270
> > Fixes: https://bugzilla.redhat.com/show_bug.cgi?id=3D1778593
> > Cc: qemu-stable@nongnu.org
> > Signed-off-by: Kevin Wolf <kwolf@redhat.com>
>=20
> I'm OK with it as is, as it fixes bug:
>=20
> Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>=20
> still, some notes below
>=20
>=20
> > ---
> >   block/backup-top.c | 14 +++++++++-----
> >   block/backup.c     | 14 +++++++++++++-
> >   2 files changed, 22 insertions(+), 6 deletions(-)
> >=20
> > diff --git a/block/backup-top.c b/block/backup-top.c
> > index 3b50c06e2c..79b268e6dc 100644
> > --- a/block/backup-top.c
> > +++ b/block/backup-top.c
> > @@ -148,8 +148,10 @@ static void backup_top_child_perm(BlockDriverState=
 *bs, BdrvChild *c,
> >            *
> >            * Share write to target (child_file), to not interfere
> >            * with guest writes to its disk which may be in target backi=
ng chain.
> > +         * Can't resize during a backup block job because we check the=
 size
> > +         * only upfront.
> >            */
> > -        *nshared =3D BLK_PERM_ALL;
> > +        *nshared =3D BLK_PERM_ALL & ~BLK_PERM_RESIZE;
> >           *nperm =3D BLK_PERM_WRITE;
> >       } else {
> >           /* Source child */
> > @@ -159,7 +161,7 @@ static void backup_top_child_perm(BlockDriverState =
*bs, BdrvChild *c,
> >           if (perm & BLK_PERM_WRITE) {
> >               *nperm =3D *nperm | BLK_PERM_CONSISTENT_READ;
> >           }
> > -        *nshared &=3D ~BLK_PERM_WRITE;
> > +        *nshared &=3D ~(BLK_PERM_WRITE | BLK_PERM_RESIZE);
> >       }
> >   }
> > @@ -192,11 +194,13 @@ BlockDriverState *bdrv_backup_top_append(BlockDri=
verState *source,
> >   {
> >       Error *local_err =3D NULL;
> >       BDRVBackupTopState *state;
> > -    BlockDriverState *top =3D bdrv_new_open_driver(&bdrv_backup_top_fi=
lter,
> > -                                                 filter_node_name,
> > -                                                 BDRV_O_RDWR, errp);
> > +    BlockDriverState *top;
> >       bool appended =3D false;
> > +    assert(source->total_sectors =3D=3D target->total_sectors);
>=20
> May be better to error-out, just to keep backup-top independent. Still, n=
ow it's not
> really needed, as we have only one caller. And this function have to be r=
efactored
> anyway, when publishing this filter (open() and close() should appear, so=
 this code
> will be rewritten anyway.)

Yes, the whole function only works because it's used in this restricted
context today. For example, we only know that total_sectors is up to
date because the caller has called bdrv_getlength() just a moment ago.

I think fixing this would be beyond the scope of this patch, but
certainly a good idea anyway.

> And the other thought: the permissions we declared above, will be activat=
ed only after
> successful bdrv_child_refresh_perms(). I think some kind of race is possi=
ble, so that
> size is changed actual permission activation. So, may be good to double c=
heck sizes after
> bdrv_child_refresh_perms().. But it's a kind of paranoia.

We're not in coroutine context, so we can't yield. I don't see who could
change the size in parallel (apart from an external process, but an
external process can mess up anything).

When we make backup-top an independent driver, instead of double
checking (what would you do on error?), maybe we could move the size
initialisation (then with bdrv_getlength()) to after
bdrv_child_refresh_perms().

> Also, third thought: the restricted permissions doesn't save us from resi=
zing
> of the source through exactly this node, does it? Hmm, but your test work=
s somehow. But
> (I assume) it worked in a previous patch version without unsharing on sou=
rce..
>=20
> Ha, but bdrv_co_truncate just can't work on backup-top, because it doesn'=
t have file child.
> But, if we fix bdrv_co_truncate to skip filters, we'll need to define .bd=
rv_co_truncate in
> backup_top, which will return something like -EBUSY.. Or just -ENOTSUP, d=
oesn't matter.

Maybe this is a sign that bdrv_co_truncate shouldn't automatically skip
filters because filters might depend on a fixed size?

Or we could make the automatic skipping depend on having BLK_PERM_RESIZE
for the child. If the filter doesn't have the permission, we must not
call truncate for its child (it would crash). Then backup-top and
similar filters must just be careful not to take RESIZE permissions.

Kevin


