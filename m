Return-Path: <SRS0=Qmby=6N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1061C83003
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 08:07:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8AB0C2083B
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 08:07:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hKR+mo4r"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8AB0C2083B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48530 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jThkc-0003bH-LP
	for qemu-devel@archiver.kernel.org; Wed, 29 Apr 2020 04:07:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50662)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1jThgA-0004eF-DT
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 04:05:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1jThbg-0001Ml-BX
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 04:02:49 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:20839
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1jThbf-0001M6-P6
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 03:58:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588147090;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=x2aTTj0F7hIXvGyY70KkfRFYrPMxUZiJB5XUQF4IaoE=;
 b=hKR+mo4rVlimKeeZUIABvd2H5KOoBurd9msRtie7M7N6FWA6cePNzPJKHq4eiZDX7aEC2x
 Uk0xfpUdfGvScqNUgDyMTJcP+ERGX6Xplc3ykR2EeHTbKAMgaLUh2hConv5vOHIdA5FWBk
 ktUwg1L6vU71Pplr5wDvlBHZAbe8IeM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-406-hVoAmiEUPLa0Z5_pgyVDXQ-1; Wed, 29 Apr 2020 03:58:08 -0400
X-MC-Unique: hVoAmiEUPLa0Z5_pgyVDXQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3AB85835B41;
 Wed, 29 Apr 2020 07:58:07 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-113-19.ams2.redhat.com
 [10.36.113.19])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 0FFBE600DB;
 Wed, 29 Apr 2020 07:58:05 +0000 (UTC)
Subject: Re: [PATCH 4/4] block: Use blk_make_empty() after commits
To: Eric Blake <eblake@redhat.com>, qemu-block@nongnu.org
References: <20200428132629.796753-1-mreitz@redhat.com>
 <20200428132629.796753-5-mreitz@redhat.com>
 <0fb5d21f-4075-8c6a-0105-01fc60acaecf@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Autocrypt: addr=mreitz@redhat.com; prefer-encrypt=mutual; keydata=
 mQENBFXOJlcBCADEyyhOTsoa/2ujoTRAJj4MKA21dkxxELVj3cuILpLTmtachWj7QW+TVG8U
 /PsMCFbpwsQR7oEy8eHHZwuGQsNpEtNC2G/L8Yka0BIBzv7dEgrPzIu+W3anZXQW4702+uES
 U29G8TP/NGfXRRHGlbBIH9KNUnOSUD2vRtpOLXkWsV5CN6vQFYgQfFvmp5ZpPeUe6xNplu8V
 mcTw8OSEDW/ZnxJc8TekCKZSpdzYoxfzjm7xGmZqB18VFwgJZlIibt1HE0EB4w5GsD7x5ekh
 awIe3RwoZgZDLQMdOitJ1tUc8aqaxvgA4tz6J6st8D8pS//m1gAoYJWGwwIVj1DjTYLtABEB
 AAG0HU1heCBSZWl0eiA8bXJlaXR6QHJlZGhhdC5jb20+iQFTBBMBCAA9AhsDBQkSzAMABQsJ
 CAcCBhUICQoLAgQWAgMBAh4BAheABQJVzie5FRhoa3A6Ly9rZXlzLmdudXBnLm5ldAAKCRD0
 B9sAYdXPQDcIB/9uNkbYEex1rHKz3mr12uxYMwLOOFY9fstP5aoVJQ1nWQVB6m2cfKGdcRe1
 2/nFaHSNAzT0NnKz2MjhZVmcrpyd2Gp2QyISCfb1FbT82GMtXFj1wiHmPb3CixYmWGQUUh+I
 AvUqsevLA+WihgBUyaJq/vuDVM1/K9Un+w+Tz5vpeMidlIsTYhcsMhn0L9wlCjoucljvbDy/
 8C9L2DUdgi3XTa0ORKeflUhdL4gucWoAMrKX2nmPjBMKLgU7WLBc8AtV+84b9OWFML6NEyo4
 4cP7cM/07VlJK53pqNg5cHtnWwjHcbpGkQvx6RUx6F1My3y52vM24rNUA3+ligVEgPYBuQEN
 BFXOJlcBCADAmcVUNTWT6yLWQHvxZ0o47KCP8OcLqD+67T0RCe6d0LP8GsWtrJdeDIQk+T+F
 xO7DolQPS6iQ6Ak2/lJaPX8L0BkEAiMuLCKFU6Bn3lFOkrQeKp3u05wCSV1iKnhg0UPji9V2
 W5eNfy8F4ZQHpeGUGy+liGXlxqkeRVhLyevUqfU0WgNqAJpfhHSGpBgihUupmyUg7lfUPeRM
 DzAN1pIqoFuxnN+BRHdAecpsLcbR8sQddXmDg9BpSKozO/JyBmaS1RlquI8HERQoe6EynJhd
 64aICHDfj61rp+/0jTIcevxIIAzW70IadoS/y3DVIkuhncgDBvGbF3aBtjrJVP+5ABEBAAGJ
 ASUEGAEIAA8FAlXOJlcCGwwFCRLMAwAACgkQ9AfbAGHVz0CbFwf9F/PXxQR9i4N0iipISYjU
 sxVdjJOM2TMut+ZZcQ6NSMvhZ0ogQxJ+iEQ5OjnIputKvPVd5U7WRh+4lF1lB/NQGrGZQ1ic
 alkj6ocscQyFwfib+xIe9w8TG1CVGkII7+TbS5pXHRxZH1niaRpoi/hYtgzkuOPp35jJyqT/
 /ELbqQTDAWcqtJhzxKLE/ugcOMK520dJDeb6x2xVES+S5LXby0D4juZlvUj+1fwZu+7Io5+B
 bkhSVPb/QdOVTpnz7zWNyNw+OONo1aBUKkhq2UIByYXgORPFnbfMY7QWHcjpBVw9MgC4tGeF
 R4bv+1nAMMxKmb5VvQCExr0eFhJUAHAhVg==
Message-ID: <5b22a747-c00e-02a2-17fb-652d1eaea453@redhat.com>
Date: Wed, 29 Apr 2020 09:58:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <0fb5d21f-4075-8c6a-0105-01fc60acaecf@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="m9wEpVvEhjEC9nfuOHA6DIecCsv4wjmdg"
Received-SPF: pass client-ip=205.139.110.61; envelope-from=mreitz@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/29 00:53:13
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--m9wEpVvEhjEC9nfuOHA6DIecCsv4wjmdg
Content-Type: multipart/mixed; boundary="gHhCvHdmBrzcHjs1cm9BoxkpDCHrmINOE"

--gHhCvHdmBrzcHjs1cm9BoxkpDCHrmINOE
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 28.04.20 16:07, Eric Blake wrote:
> On 4/28/20 8:26 AM, Max Reitz wrote:
>> bdrv_commit() already has a BlockBackend pointing to the BDS that we
>> want to empty, it just has the wrong permissions.
>>
>> qemu-img commit has no BlockBackend pointing to the old backing file
>> yet, but introducing one is simple.
>>
>> After this commit, bdrv_make_empty() is the only remaining caller of
>> BlockDriver.bdrv_make_empty().
>>
>> Signed-off-by: Max Reitz <mreitz@redhat.com>
>> ---
>> =C2=A0 block/commit.c |=C2=A0 8 +++++++-
>> =C2=A0 qemu-img.c=C2=A0=C2=A0=C2=A0=C2=A0 | 19 ++++++++++++++-----
>> =C2=A0 2 files changed, 21 insertions(+), 6 deletions(-)
>>
>> diff --git a/block/commit.c b/block/commit.c
>> index 8e672799af..24720ba67d 100644
>> --- a/block/commit.c
>> +++ b/block/commit.c
>> @@ -493,10 +493,16 @@ int bdrv_commit(BlockDriverState *bs)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (drv->bdrv_make_empty) {
>=20
> This 'if' is still a bit awkward. Do all filter drivers set this
> function, or will bdrv_make_empty() automatically take care of looking
> through filters?=C2=A0 Should this be a check of a supported_ variable
> instead (similar to how Kevin just added supported_truncate_flags)?
>=20
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D drv->bdrv_make_empty=
(bs);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D blk_set_perm(src, BL=
K_PERM_WRITE, BLK_PERM_ALL, NULL);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (ret < 0) {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 goto ro_cleanup;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> +
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D blk_make_empty(src, =
NULL);
>=20
> So, if the driver lacks the callback, you miss calling blk_make_empty()
> even if it would have done something.

We can=E2=80=99t just call blk_make_empty() and then special case -ENOTSUP =
here,
though, because the BB doesn=E2=80=99t have a WRITE permission beforehand. =
 So
we have to take that permission before we can call blk_make_empty().
But taking the permission can fail, and then we kind of have to report
the -EPERM, even though the BlockDriver may not support emptying anyway.

I suppose if we just have to take the WRITE_UNCHANGED permission,
though, we can assume that that=E2=80=99s basically always allowed, so it
shouldn=E2=80=99t be that much of a problem there.

Max

>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (ret < 0) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto=
 ro_cleanup;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> +
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 blk_flush(src);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> =C2=A0 diff --git a/qemu-img.c b/qemu-img.c
>> index 821cbf610e..a5e8659867 100644
>> --- a/qemu-img.c
>> +++ b/qemu-img.c
>> @@ -1065,11 +1065,20 @@ static int img_commit(int argc, char **argv)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto unref_backin=
g;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> =C2=A0 -=C2=A0=C2=A0=C2=A0 if (!drop && bs->drv->bdrv_make_empty) {
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D bs->drv->bdrv_make_e=
mpty(bs);
>=20
> Old code: if the driver had the callback, use it.
>=20
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (ret) {
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 erro=
r_setg_errno(&local_err, -ret, "Could not empty %s",
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 filename);
>> +=C2=A0=C2=A0=C2=A0 if (!drop) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 BlockBackend *old_backing_bl=
k;
>> +
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 old_backing_blk =3D blk_new_=
with_bs(bs, BLK_PERM_WRITE,
>> BLK_PERM_ALL,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 &local_err);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!old_backing_blk) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto=
 unref_backing;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D blk_make_empty(old_b=
acking_blk, &local_err);
>=20
> New code: Call blk_make_empty() whether or not driver has the callback,
> then deal with the fallout.
>=20
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 blk_unref(old_backing_blk);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (ret =3D=3D -ENOTSUP) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 erro=
r_free(local_err);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 loca=
l_err =3D NULL;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 } else if (ret < 0) {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 goto unref_backing;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>=20
> But this actually looks smarter than the commit case.
>=20



--gHhCvHdmBrzcHjs1cm9BoxkpDCHrmINOE--

--m9wEpVvEhjEC9nfuOHA6DIecCsv4wjmdg
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl6pM4wACgkQ9AfbAGHV
z0DQAAf/V2Wqlar1KUiDrPKrhCio3YNBB/nrDnHMxN4whnAqmUhRN8bnDpJ02xg/
2lUOxCLiwI0+ELM1Hnve19dqt6/ac8smR/PBCvyh9XhuIcZZUyp1Qye1bCtuCuGP
VlnO8OLrAVA5QE7qAXeqywFuGS2+pvdF7Cd7sIR2u0ifqt3SsX5Rmy1v/BuhyECW
sopaxLybQZgKTG8Jl2RPAuxx9OlHZgqfUuaVVPxvGf49kcD6sIqDsJba/OWY5fc8
nRw4xzogpNtg9KhIDvBPg/aSx9h53hUYBi+CTqMEf1gSmrl2goTcgYpQan90dWCr
6zj19BUsW1+Gta5vB5da3qSAG2+aSQ==
=+Je3
-----END PGP SIGNATURE-----

--m9wEpVvEhjEC9nfuOHA6DIecCsv4wjmdg--


