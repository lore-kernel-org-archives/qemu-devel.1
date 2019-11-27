Return-Path: <SRS0=bFmd=ZT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66290C432C0
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Nov 2019 17:12:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2B363206E0
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Nov 2019 17:12:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HjqWVgTv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B363206E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40840 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ia0rL-0000D7-6O
	for qemu-devel@archiver.kernel.org; Wed, 27 Nov 2019 12:12:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36928)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1ia0ps-0007fU-2X
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 12:10:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1ia0pq-0007Ia-UJ
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 12:10:40 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:51392
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1ia0pq-0007IA-PA
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 12:10:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574874638;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=n869NSx2jHlfXMNJ4D+BjdJXOISy2WyeFv/8PIXFnCg=;
 b=HjqWVgTvcsCMCDF+5aPscmZn1T6mxPWb1pK0DZYLYcHQjxNIQL124JDaaTh4CK2wv5InOj
 F/vLZb2agzMOSREMPG85md9+LjJYDei/RYIWa+843ker77xMK/TBzu4yWskj9G7XJ+kcb6
 lPNgMgl5wFqjCg1PcVYUbc0MUcmRoYE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-390-DA6j-_LHMXyj4gD65z8jFw-1; Wed, 27 Nov 2019 12:10:36 -0500
X-MC-Unique: DA6j-_LHMXyj4gD65z8jFw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9500C107ACE3;
 Wed, 27 Nov 2019 17:10:35 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-205-186.brq.redhat.com
 [10.40.205.186])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 79366600C8;
 Wed, 27 Nov 2019 17:10:31 +0000 (UTC)
Subject: Re: [PATCH v4 4/5] blockdev: honor bdrv_try_set_aio_context() context
 requirements
To: Sergio Lopez <slp@redhat.com>, qemu-devel@nongnu.org
References: <20191121135759.101655-1-slp@redhat.com>
 <20191121135759.101655-5-slp@redhat.com>
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
Message-ID: <7742b8ea-1e9e-7acc-6af2-3155b8d11af2@redhat.com>
Date: Wed, 27 Nov 2019 18:10:29 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191121135759.101655-5-slp@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="ttBGzGNSrH3jpILXKMN9QKGojncXDnATH"
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
Cc: Kevin Wolf <kwolf@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--ttBGzGNSrH3jpILXKMN9QKGojncXDnATH
Content-Type: multipart/mixed; boundary="jLwouv1y0Ky2qeglpWzcksRfjMBffE3q7"

--jLwouv1y0Ky2qeglpWzcksRfjMBffE3q7
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 21.11.19 14:57, Sergio Lopez wrote:
> bdrv_try_set_aio_context() requires that the old context is held, and
> the new context is not held. Fix all the occurrences where it's not
> done this way.
>=20
> Suggested-by: Max Reitz <mreitz@redhat.com>
> Signed-off-by: Sergio Lopez <slp@redhat.com>
> ---
>  blockdev.c | 67 ++++++++++++++++++++++++++++++++++++++++++++++--------
>  1 file changed, 58 insertions(+), 9 deletions(-)

I wonder whether we even need to set the target=E2=80=99s context, because =
I
suppose it should be done automatically when it is attached to the
backup job with bdrv_attach_child() in bdrv_backup_top_append().  *shrug*

> diff --git a/blockdev.c b/blockdev.c
> index 152a0f7454..b0647d8d33 100644
> --- a/blockdev.c
> +++ b/blockdev.c

[...]

> @@ -1868,6 +1880,20 @@ static void drive_backup_prepare(BlkActionState *c=
ommon, Error **errp)
>          goto out;
>      }
> =20
> +    /* Honor bdrv_try_set_aio_context() context acquisition requirements=
. */
> +    old_context =3D bdrv_get_aio_context(target_bs);
> +    aio_context_release(aio_context);
> +    aio_context_acquire(old_context);
> +
> +    ret =3D bdrv_try_set_aio_context(target_bs, aio_context, errp);
> +    if (ret < 0) {
> +        aio_context_release(old_context);
> +        return;
> +     }
> +
> +    aio_context_release(old_context);
> +    aio_context_acquire(aio_context);

Would it work to put the error block after these two calls so it can
just goto out again?  (Which would help if someone were to e.g.
introduce a new resource that is to be freed behind the out label.)

>      if (set_backing_hd) {
>          bdrv_set_backing_hd(target_bs, source, &local_err);
>          if (local_err) {

[...]

> @@ -4001,14 +4046,18 @@ void qmp_blockdev_mirror(bool has_job_id, const c=
har *job_id,
> =20
>      zero_target =3D (sync =3D=3D MIRROR_SYNC_MODE_FULL);
> =20
> +    /* Honor bdrv_try_set_aio_context() context acquisition requirements=
. */
> +    old_context =3D bdrv_get_aio_context(target_bs);
>      aio_context =3D bdrv_get_aio_context(bs);
> -    aio_context_acquire(aio_context);
> +    aio_context_acquire(old_context);
> =20
>      ret =3D bdrv_try_set_aio_context(target_bs, aio_context, errp);
>      if (ret < 0) {
>          goto out;
>      }
> =20
> +    aio_context_acquire(aio_context);
> +

old_context is never released here.

Max

>      blockdev_mirror_common(has_job_id ? job_id : NULL, bs, target_bs,
>                             has_replaces, replaces, sync, backing_mode,
>                             zero_target, has_speed, speed,
>=20



--jLwouv1y0Ky2qeglpWzcksRfjMBffE3q7--

--ttBGzGNSrH3jpILXKMN9QKGojncXDnATH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl3ergUACgkQ9AfbAGHV
z0DcsQf/XxWfCno0ZQsjKKBCbaZAC6Pw4fHLalFxSFdLI9VJ389IPw1u+HyHuNLG
OoeRG680hfGf5QjGPO98IEvMUTx/D/pXGODo/8Zy394elTO+6WI+/m0JS81S3nAc
FQ2PlxnynADRD/BnttaRWfTjZrMXr1CTxE0RsVX4zmyzEFsWqlOU9GTAjcXkTRxy
FxQpWsAdzfiU6b59f8C/bw38HJFa+trEwg6RjJMhMy9nWXf2h98akEBhjv1djXeC
01udGG2zxfwyZE8p9vvnLyEGvTaO14YvZ07ovQ2aDtbjXMSTx3apJq1AW5DSTQ7I
CI0nFAvQtAYU3LNMugk9kOzqmsxbHw==
=LfM7
-----END PGP SIGNATURE-----

--ttBGzGNSrH3jpILXKMN9QKGojncXDnATH--


