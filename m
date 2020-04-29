Return-Path: <SRS0=Qmby=6N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD4B2C83009
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 14:18:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A65FA206D9
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 14:18:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="M2grZucA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A65FA206D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38300 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jTnY1-0007OG-OY
	for qemu-devel@archiver.kernel.org; Wed, 29 Apr 2020 10:18:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46098)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1jTnWu-0006L0-D6
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 10:17:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1jTnWZ-0000b8-EZ
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 10:17:40 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:55881
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1jTnWY-0000ag-To
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 10:17:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588169838;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=ilXUloMoH9SBaVQqa0Mja6DNW6CXsswAoCbCSJyULyE=;
 b=M2grZucArYHd6np541Hch8arY+/4wqusSG46DiZjj3EShQL4KyqSEkVgtUEtDzV0kPBYAT
 9YKZOzzCwpMqeEuyh1vzqeYCjLHCtkqfDAspCXKTimQF49tOiOfMeAqjcRhgWooW7PF9+/
 RcGV3H2yhdmwMUXCw+jmMrlkTeZGYOI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-412-gMkwMZDdPMupOjBKZ9jQbg-1; Wed, 29 Apr 2020 10:17:13 -0400
X-MC-Unique: gMkwMZDdPMupOjBKZ9jQbg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 967751009629;
 Wed, 29 Apr 2020 14:17:03 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-113-19.ams2.redhat.com
 [10.36.113.19])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 74AE05C324;
 Wed, 29 Apr 2020 14:17:02 +0000 (UTC)
Subject: Re: [PATCH v2 4/4] block: Use blk_make_empty() after commits
To: qemu-block@nongnu.org
References: <20200429141126.85159-1-mreitz@redhat.com>
 <20200429141126.85159-5-mreitz@redhat.com>
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
Message-ID: <47a06f2d-4ebb-f50f-a168-acc56e7b279c@redhat.com>
Date: Wed, 29 Apr 2020 16:17:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200429141126.85159-5-mreitz@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="JEQ9BurEIFnPWad3RvBlSrXL80pXkARJm"
Received-SPF: pass client-ip=205.139.110.120; envelope-from=mreitz@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/29 01:42:37
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--JEQ9BurEIFnPWad3RvBlSrXL80pXkARJm
Content-Type: multipart/mixed; boundary="MxAVVfPfzldwjiC013Mu6rzZU9UvvdKKw"

--MxAVVfPfzldwjiC013Mu6rzZU9UvvdKKw
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 29.04.20 16:11, Max Reitz wrote:
> bdrv_commit() already has a BlockBackend pointing to the BDS that we
> want to empty, it just has the wrong permissions.
>=20
> qemu-img commit has no BlockBackend pointing to the old backing file
> yet, but introducing one is simple.
>=20
> After this commit, bdrv_make_empty() is the only remaining caller of
> BlockDriver.bdrv_make_empty().
>=20
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
>  block/commit.c | 16 +++++++++-------
>  qemu-img.c     | 19 ++++++++++++++-----
>  2 files changed, 23 insertions(+), 12 deletions(-)

[...]

> diff --git a/qemu-img.c b/qemu-img.c
> index 7f52742ef2..77f3575538 100644
> --- a/qemu-img.c
> +++ b/qemu-img.c
> @@ -1065,11 +1065,20 @@ static int img_commit(int argc, char **argv)
>          goto unref_backing;
>      }
> =20
> -    if (!drop && bs->drv->bdrv_make_empty) {
> -        ret =3D bs->drv->bdrv_make_empty(bs);
> -        if (ret) {
> -            error_setg_errno(&local_err, -ret, "Could not empty %s",
> -                             filename);
> +    if (!drop) {
> +        BlockBackend *old_backing_blk;
> +
> +        old_backing_blk =3D blk_new_with_bs(bs, BLK_PERM_WRITE, BLK_PERM=
_ALL,
> +                                          &local_err);
> +        if (!old_backing_blk) {
> +            goto unref_backing;
> +        }
> +        ret =3D blk_make_empty(old_backing_blk, &local_err);
> +        blk_unref(old_backing_blk);
> +        if (ret =3D=3D -ENOTSUP) {
> +            error_free(local_err);
> +            local_err =3D NULL;
> +        } else if (ret < 0) {
>              goto unref_backing;
>          }
>      }

This patch should also include a %s/Could not empty/Failed to empty/ on
tests/qemu-iotests/098.out...

Max


--MxAVVfPfzldwjiC013Mu6rzZU9UvvdKKw--

--JEQ9BurEIFnPWad3RvBlSrXL80pXkARJm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl6pjF0ACgkQ9AfbAGHV
z0Dsqgf/dUMNL4SV/IV0CadDjGB+EaMpy6ZgJnK1G7OGjXGOBOhgf4bcGYchIsbf
ZyBVrFrYv9yRI0PkZm0J1MxtyDsmEMRGEDhkMhj/iebBUaZujLDbeYm47+A+0sQO
Cp+2IBE+X1Ki+oLhfiNB0eTon5c4z9Hrp6CpDnC+CpTlTfvqLNdbXEkuSgZWTesJ
nUIeVc/+JucPsM7BLl+QLY/prk5dU3GgR0kA8UDPjjoizAc6sVskCtY4N7BSxeIW
eVw5MZseKHKtNHOeMx7mpp87iNJj2ElhKxNFTwMog2rrcBr0ZdbiNBGNlcsc+0E0
eqqPBsrIWqFsceSU5KW1Q16gKWSDrw==
=QZ9l
-----END PGP SIGNATURE-----

--JEQ9BurEIFnPWad3RvBlSrXL80pXkARJm--


