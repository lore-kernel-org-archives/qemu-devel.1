Return-Path: <SRS0=URa6=5T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3494C43331
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Apr 2020 08:56:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BE55D2080C
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Apr 2020 08:56:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="arL3nEZP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE55D2080C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52332 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jKI7Q-0004MG-Sq
	for qemu-devel@archiver.kernel.org; Fri, 03 Apr 2020 04:56:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49453)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1jKI6n-0003r7-CY
 for qemu-devel@nongnu.org; Fri, 03 Apr 2020 04:55:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1jKI6l-00030k-PJ
 for qemu-devel@nongnu.org; Fri, 03 Apr 2020 04:55:25 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:37726
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1jKI6l-0002yy-JW
 for qemu-devel@nongnu.org; Fri, 03 Apr 2020 04:55:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585904122;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=63KjWeKu8PUziGEX16GOJafoZTEdcP3NgQK1g1+W9yA=;
 b=arL3nEZPNp6NESgrweWgzU6JkRAptMXJq7sNp21g6rLyQx+R6gRabsKicNuNlkBjX3Nfsu
 +uFptvzFPuNwcazrCqWA/rn6w9sIi+hWpHOZojq3L9yv/y2YItyhNNasnIGzGg/04zqRx4
 aWHFJ7rQHl9fkSQjaKU4BJAURtLLBRo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-268-_goqlZ2gPGeYAzek2pf0mA-1; Fri, 03 Apr 2020 04:55:17 -0400
X-MC-Unique: _goqlZ2gPGeYAzek2pf0mA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5F7D3800D5C;
 Fri,  3 Apr 2020 08:55:16 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-113-97.ams2.redhat.com
 [10.36.113.97])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 1BB3E1001B28;
 Fri,  3 Apr 2020 08:55:14 +0000 (UTC)
Subject: Re: [PATCH for-5.0] vpc: Don't round up already aligned BAT sizes
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
References: <20200402093603.2369-1-kwolf@redhat.com>
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
Message-ID: <e379efcd-58ef-c9bb-0ae8-b3435f30d141@redhat.com>
Date: Fri, 3 Apr 2020 10:55:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200402093603.2369-1-kwolf@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="1QvN4a0sx2FETdurXxVPqoIWrCWOdvp6A"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--1QvN4a0sx2FETdurXxVPqoIWrCWOdvp6A
Content-Type: multipart/mixed; boundary="PAoAeta6gDfQrRTVjig8IBscUQOmKebwc"

--PAoAeta6gDfQrRTVjig8IBscUQOmKebwc
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 02.04.20 11:36, Kevin Wolf wrote:
> As reported on Launchpad, Azure apparently doesn't accept images for
> upload that are not both aligned to 1 MB blocks and have a BAT size that
> matches the image size exactly.
>=20
> As far as I can tell, there is no real reason why we create a BAT that
> is one entry longer than necessary for aligned image sizes, so change
> that.
>=20
> (Even though the condition is only mentioned as "should" in the spec and
> previous products accepted larger BATs - but we'll try to maintain
> compatibility with as many of Microsoft's ever-changing interpretations
> of the VHD spec as possible.)

So as far as I can tell we still don=E2=80=99t ensure that the image is ali=
gned
to 1 MB blocks?

Well, as long as it=E2=80=99s at least possible for the user to create vali=
d
images, that=E2=80=99s better.

> Fixes: https://bugs.launchpad.net/bugs/1870098
> Reported-by: Tobias Witek
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  block/vpc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/block/vpc.c b/block/vpc.c
> index 6df75e22dc..d8141b52da 100644
> --- a/block/vpc.c
> +++ b/block/vpc.c
> @@ -835,7 +835,7 @@ static int create_dynamic_disk(BlockBackend *blk, uin=
t8_t *buf,
> =20
>      /* Write the footer (twice: at the beginning and at the end) */
>      block_size =3D 0x200000;
> -    num_bat_entries =3D (total_sectors + block_size / 512) / (block_size=
 / 512);
> +    num_bat_entries =3D DIV_ROUND_UP(total_sectors, block_size / 512);

And the old code just looks like a wrong DIV_ROUND_UP() attempt.  So:

Reviewed-by: Max Reitz <mreitz@redhat.com>

> =20
>      ret =3D blk_pwrite(blk, offset, buf, HEADER_SIZE, 0);
>      if (ret < 0) {
>=20



--PAoAeta6gDfQrRTVjig8IBscUQOmKebwc--

--1QvN4a0sx2FETdurXxVPqoIWrCWOdvp6A
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl6G+fEACgkQ9AfbAGHV
z0DsJggAkZ9egJ/Wh75omp6zxZn2i5caL89w8UjVOeTu+k5DqpvuGpJUOb9fB7qm
IyKAjR1EcoykNGndP8tdMtkxAzdDVBdBccxyTgcyR+H7V77AYlMOAS1Z3ML9XMQR
WnmUhCl4QJ3qSZubAftmvtjsDGcxUMBH00rqgJMs8bK4uL6L8mcH6dH2obiMF0m4
WTk/dvdFAnu4ytENDKBRoCrsI4ziBlVe5OjCsiBh+3aPY0/hjwFe/pyD2Wz63DKy
/u9nCurAKz1xFWDW3quLi0ZJ9LnfTXBEDZcSds3tQTgSbopLtIruXRWv0SeJlFZP
W3XU8n7AVg/u3328Yp1VrQzpsJbLVQ==
=ZvQS
-----END PGP SIGNATURE-----

--1QvN4a0sx2FETdurXxVPqoIWrCWOdvp6A--


