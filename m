Return-Path: <SRS0=xKpV=2I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F552C43603
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 15:39:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 69514206CB
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 15:39:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OyeHnmX/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 69514206CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55804 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihbQI-0006GF-EQ
	for qemu-devel@archiver.kernel.org; Wed, 18 Dec 2019 10:39:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34958)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <slp@redhat.com>) id 1ihbPY-0005k7-8N
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 10:38:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <slp@redhat.com>) id 1ihbPU-0004tl-Vv
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 10:38:50 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:23603
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <slp@redhat.com>) id 1ihbPU-0004lu-Jy
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 10:38:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576683527;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=wodZNnBCqJ3/iAsJjnCHUhKIH0OJBPPpdjTlgvikLHs=;
 b=OyeHnmX/ny2Opwt0vmlSv2iPNEe7PsPJvvdAUpUz0sEGR2+MQmN7Z1AqVebglfu6Y7i8A2
 6/Pf0oUXr/rjHfnMJItuTKkLz9mwkFcR3pfpLDJ0AQ2iKazvHh93ceeomH7VeYQlC1AQzJ
 kC6uRv3AN/uPCBoSF2L50bwbhRbGP4E=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-408-ooQie95uOIGVMbqOfXVMkg-1; Wed, 18 Dec 2019 10:38:43 -0500
X-MC-Unique: ooQie95uOIGVMbqOfXVMkg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0A0D2192D2B7;
 Wed, 18 Dec 2019 15:38:42 +0000 (UTC)
Received: from dritchie.redhat.com (unknown [10.33.36.17])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 4CA008E61A;
 Wed, 18 Dec 2019 15:38:40 +0000 (UTC)
References: <20191128104129.250206-1-slp@redhat.com>
 <20191128104129.250206-5-slp@redhat.com>
 <20191209160601.GB6715@linux.fritz.box>
User-agent: mu4e 1.2.0; emacs 26.2
From: Sergio Lopez <slp@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Subject: Re: [PATCH v5 4/4] blockdev: honor bdrv_try_set_aio_context() context
 requirements
Message-ID: <87a77pzls5.fsf@redhat.com>
In-reply-to: <20191209160601.GB6715@linux.fritz.box>
Date: Wed, 18 Dec 2019 16:38:37 +0100
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
Content-Type: multipart/signed; boundary="=-=-=";
 micalg=pgp-sha256; protocol="application/pgp-signature"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.120
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
Cc: Max Reitz <mreitz@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org,
 Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


Kevin Wolf <kwolf@redhat.com> writes:

> Am 28.11.2019 um 11:41 hat Sergio Lopez geschrieben:
>> bdrv_try_set_aio_context() requires that the old context is held, and
>> the new context is not held. Fix all the occurrences where it's not
>> done this way.
>>=20
>> Suggested-by: Max Reitz <mreitz@redhat.com>
>> Signed-off-by: Sergio Lopez <slp@redhat.com>
>> ---
>>  blockdev.c | 72 ++++++++++++++++++++++++++++++++++++++++++++++--------
>>  1 file changed, 62 insertions(+), 10 deletions(-)
>>=20
>> diff --git a/blockdev.c b/blockdev.c
>> index 152a0f7454..e33abd7fd2 100644
>> --- a/blockdev.c
>> +++ b/blockdev.c
>> @@ -1535,6 +1535,7 @@ static void external_snapshot_prepare(BlkActionSta=
te *common,
>>                               DO_UPCAST(ExternalSnapshotState, common, c=
ommon);
>>      TransactionAction *action =3D common->action;
>>      AioContext *aio_context;
>> +    AioContext *old_context;
>>      int ret;
>> =20
>>      /* 'blockdev-snapshot' and 'blockdev-snapshot-sync' have similar
>> @@ -1675,7 +1676,16 @@ static void external_snapshot_prepare(BlkActionSt=
ate *common,
>>          goto out;
>>      }
>> =20
>> +    /* Honor bdrv_try_set_aio_context() context acquisition requirement=
s. */
>> +    old_context =3D bdrv_get_aio_context(state->new_bs);
>> +    aio_context_release(aio_context);
>> +    aio_context_acquire(old_context);
>> +
>>      ret =3D bdrv_try_set_aio_context(state->new_bs, aio_context, errp);
>> +
>> +    aio_context_release(old_context);
>> +    aio_context_acquire(aio_context);
>> +
>>      if (ret < 0) {
>>          goto out;
>>      }
>> @@ -1775,11 +1785,13 @@ static void drive_backup_prepare(BlkActionState =
*common, Error **errp)
>>      BlockDriverState *target_bs;
>>      BlockDriverState *source =3D NULL;
>>      AioContext *aio_context;
>> +    AioContext *old_context;
>>      QDict *options;
>>      Error *local_err =3D NULL;
>>      int flags;
>>      int64_t size;
>>      bool set_backing_hd =3D false;
>> +    int ret;
>> =20
>>      assert(common->action->type =3D=3D TRANSACTION_ACTION_KIND_DRIVE_BA=
CKUP);
>>      backup =3D common->action->u.drive_backup.data;
>> @@ -1868,6 +1880,20 @@ static void drive_backup_prepare(BlkActionState *=
common, Error **errp)
>>          goto out;
>>      }
>> =20
>> +    /* Honor bdrv_try_set_aio_context() context acquisition requirement=
s. */
>> +    old_context =3D bdrv_get_aio_context(target_bs);
>> +    aio_context_release(aio_context);
>> +    aio_context_acquire(old_context);
>> +
>> +    ret =3D bdrv_try_set_aio_context(target_bs, aio_context, errp);
>> +    aio_context_release(old_context);
>> +    aio_context_acquire(aio_context);
>> +
>> +    if (ret < 0) {
>> +        goto out;
>
> I think this needs to be 'goto unref'.
>
> Or in fact, I think you need to hold the AioContext of a bs to
> bdrv_unref() it, so maybe 'goto out' is right, but you need to unref
> target_bs while you still hold old_context.

Thanks for catching this one. To avoid making the error bailout path
even more complicated, in v6 I'll be moving the check just after
bdrv_try_set_aio_context(), doing the unref, the release of old_context,
and a direct return.

>> +    }
>> +
>>      if (set_backing_hd) {
>>          bdrv_set_backing_hd(target_bs, source, &local_err);
>>          if (local_err) {
>> @@ -1947,6 +1973,8 @@ static void blockdev_backup_prepare(BlkActionState=
 *common, Error **errp)
>>      BlockDriverState *bs;
>>      BlockDriverState *target_bs;
>>      AioContext *aio_context;
>> +    AioContext *old_context;
>> +    int ret;
>> =20
>>      assert(common->action->type =3D=3D TRANSACTION_ACTION_KIND_BLOCKDEV=
_BACKUP);
>>      backup =3D common->action->u.blockdev_backup.data;
>> @@ -1961,7 +1989,18 @@ static void blockdev_backup_prepare(BlkActionStat=
e *common, Error **errp)
>>          return;
>>      }
>> =20
>> +    /* Honor bdrv_try_set_aio_context() context acquisition requirement=
s. */
>>      aio_context =3D bdrv_get_aio_context(bs);
>> +    old_context =3D bdrv_get_aio_context(target_bs);
>> +    aio_context_acquire(old_context);
>> +
>> +    ret =3D bdrv_try_set_aio_context(target_bs, aio_context, errp);
>> +    if (ret < 0) {
>> +        aio_context_release(old_context);
>> +        return;
>> +    }
>> +
>> +    aio_context_release(old_context);
>>      aio_context_acquire(aio_context);
>>      state->bs =3D bs;
>> =20
>> @@ -3562,7 +3601,6 @@ static BlockJob *do_backup_common(BackupCommon *ba=
ckup,
>>      BlockJob *job =3D NULL;
>>      BdrvDirtyBitmap *bmap =3D NULL;
>>      int job_flags =3D JOB_DEFAULT;
>> -    int ret;
>> =20
>>      if (!backup->has_speed) {
>>          backup->speed =3D 0;
>> @@ -3586,11 +3624,6 @@ static BlockJob *do_backup_common(BackupCommon *b=
ackup,
>>          backup->compress =3D false;
>>      }
>> =20
>> -    ret =3D bdrv_try_set_aio_context(target_bs, aio_context, errp);
>> -    if (ret < 0) {
>> -        return NULL;
>> -    }
>> -
>>      if ((backup->sync =3D=3D MIRROR_SYNC_MODE_BITMAP) ||
>>          (backup->sync =3D=3D MIRROR_SYNC_MODE_INCREMENTAL)) {
>>          /* done before desugaring 'incremental' to print the right mess=
age */
>> @@ -3825,6 +3858,7 @@ void qmp_drive_mirror(DriveMirror *arg, Error **er=
rp)
>>      BlockDriverState *bs;
>>      BlockDriverState *source, *target_bs;
>>      AioContext *aio_context;
>> +    AioContext *old_context;
>>      BlockMirrorBackingMode backing_mode;
>>      Error *local_err =3D NULL;
>>      QDict *options =3D NULL;
>> @@ -3937,10 +3971,19 @@ void qmp_drive_mirror(DriveMirror *arg, Error **=
errp)
>>                     (arg->mode =3D=3D NEW_IMAGE_MODE_EXISTING ||
>>                      !bdrv_has_zero_init(target_bs)));
>> =20
>> +
>> +    /* Honor bdrv_try_set_aio_context() context acquisition requirement=
s. */
>> +    old_context =3D bdrv_get_aio_context(target_bs);
>> +    aio_context_release(aio_context);
>> +    aio_context_acquire(old_context);
>> +
>>      ret =3D bdrv_try_set_aio_context(target_bs, aio_context, errp);
>> +
>> +    aio_context_release(old_context);
>> +    aio_context_acquire(aio_context);
>> +
>>      if (ret < 0) {
>> -        bdrv_unref(target_bs);
>> -        goto out;
>> +        goto unref;
>>      }
>
> Here you don't forget to unref target_bs, but it has still the same
> problem as above that you need to hold old_context during bdrv_unref().
>
> Kevin


--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEvtX891EthoCRQuii9GknjS8MAjUFAl36R/0ACgkQ9GknjS8M
AjUWeA/9EAyg5qqoGzUoZfRina6fEwXv8vK/WsPJQ8h4hfqNE16W4Hi4JglIswA3
ufzmiLriunW8iWWDtcpAnsIBW4sufj9QGmJCZefJdRUxpvSkLHsZ0reNL960eRDz
lK3bwto/1YHfuNASNFW1j0Tguv1WaYNc4TSrKEoH51xMIMTVmlu9m4RNUXu5dqnu
hN/2lweNuQaeV48DVdTPN7/NpIyMiDvbUIZSDoj0hyXF9CXEywnsCm6M476ZCr05
346j5Iljm+PV1f5t8DydEocj3bGtQtpFar0ALl/PD4oysJUNdPqa74X5jZ18zoeQ
9hcsiR1GJ1ib/doISXGM+xpyscY19gpuuknD+3cCWxHn7v+B9ZfBN4FqXP4gUcHf
qocdsr+JCRqWSZWyQWklKVOPO3sHV41E3MKYNSUbY+OCrVbF4m5K/w8geWdlTdi7
FV5H+PExKUlWuckaiK3EV6jUmTGff27R9jpKju0SR9kjLklnN52noiPUfpyND5Z6
BGkF77+h0Flr2p+y3MHS8JmwMRCYe34nUrbEGP+1swH6k0uBRBrirtcUavtS9SxQ
c2wEJf8j0u1kCiyPAI+gZyi0Tuw///tZtqhh1x75hdojRTYs92QB2mHvtnAYg/6X
Jd7JHYJuGxck5M+5uY+3tI1CZYstD5KTaNDSo+CycwbrahHpOeY=
=QbLF
-----END PGP SIGNATURE-----
--=-=-=--


