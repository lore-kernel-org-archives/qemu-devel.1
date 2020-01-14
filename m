Return-Path: <SRS0=7MIY=3D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F962C33CB2
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2020 15:44:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DE6F8207FF
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2020 15:44:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RT/MC/sE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE6F8207FF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42424 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1irON6-0006pG-0U
	for qemu-devel@archiver.kernel.org; Tue, 14 Jan 2020 10:44:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44880)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1irOMB-0006H9-Om
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 10:43:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1irOM6-0007m4-Hd
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 10:43:50 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:40396
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1irOM6-0007k3-78
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 10:43:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579016624;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=myewnkP4jTE3bQVosFyrAjQtLId1aHwlHAUHYVei+qU=;
 b=RT/MC/sEjrd9Gnaw1aFBjiZT26KTSgts/+zog2ZLx2Cbk5Mt38W5YBF6jP1PnT+cKwM2K1
 /bHi+SrcZRyoO60hTNEg1u23PCXRbGq5551aKxW+kloFfwTtVgNlypPRTDkDuaf83kH3Y0
 1oxFZ+X8F90+Y3qu26JzfCMpMt0ST6U=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-89-IrnpdN1nMAyNr7xCkHovpg-1; Tue, 14 Jan 2020 10:43:42 -0500
X-MC-Unique: IrnpdN1nMAyNr7xCkHovpg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B41058024CD;
 Tue, 14 Jan 2020 15:43:41 +0000 (UTC)
Received: from dresden.str.redhat.com (unknown [10.36.118.23])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 0997180F5C;
 Tue, 14 Jan 2020 15:43:37 +0000 (UTC)
Subject: Re: [PATCH v2 2/4] luks: implement .bdrv_measure()
To: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
References: <20200109111012.559052-1-stefanha@redhat.com>
 <20200109111012.559052-3-stefanha@redhat.com>
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
Message-ID: <1e812068-4009-9203-c252-5922000dbbb3@redhat.com>
Date: Tue, 14 Jan 2020 16:43:36 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <20200109111012.559052-3-stefanha@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="9ZZlDBtNzEVdvXozHdeUSCP0axkKl6w4q"
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--9ZZlDBtNzEVdvXozHdeUSCP0axkKl6w4q
Content-Type: multipart/mixed; boundary="HZ1NrfZ4i3RRTcjyWN8ZKyhHwBOYkrMGS"

--HZ1NrfZ4i3RRTcjyWN8ZKyhHwBOYkrMGS
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 09.01.20 12:10, Stefan Hajnoczi wrote:
> Add qemu-img measure support in the "luks" block driver.
>=20
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>  block/crypto.c | 82 ++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 82 insertions(+)
>=20
> diff --git a/block/crypto.c b/block/crypto.c
> index ed32202fa2..51f37bb1f6 100644
> --- a/block/crypto.c
> +++ b/block/crypto.c
> @@ -548,6 +548,87 @@ static int64_t block_crypto_getlength(BlockDriverSta=
te *bs)

[...]

> +            if (ret & BDRV_BLOCK_ZERO) {
> +                /* Skip zero regions */
> +            } else if ((ret & (BDRV_BLOCK_DATA | BDRV_BLOCK_ALLOCATED)) =
=3D=3D
> +                       (BDRV_BLOCK_DATA | BDRV_BLOCK_ALLOCATED)) {
> +                /* Count clusters we've seen */
> +                required +=3D pnum;
> +            }

Don=E2=80=99t LUKS-encrypted files allocate effectively everything because =
zero
data has to be encrypted, too?

(=E2=80=9CEffectively=E2=80=9D, because you could zero out regions that are=
 zero when
encrypted, but...)

> +        }
> +    }
> +
> +    /* Take into account preallocation.  Nothing special is needed for
> +     * PREALLOC_MODE_METADATA since metadata is always counted.
> +     */
> +    if (prealloc =3D=3D PREALLOC_MODE_FULL || prealloc =3D=3D PREALLOC_M=
ODE_FALLOC) {
> +        required =3D virtual_size;

Same here.  I think required should always be set to virtual_size.

Max


--HZ1NrfZ4i3RRTcjyWN8ZKyhHwBOYkrMGS--

--9ZZlDBtNzEVdvXozHdeUSCP0axkKl6w4q
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl4d4agACgkQ9AfbAGHV
z0DP9gf+PbreD8Vve+alOXBjc7W5ZIlbbCQWYdwj7dQ+bbr0fQYRXhVN9Jx6nKVs
itJcCopy5tWb9VxvGhFdIhBnU1IfST7cMf4Rg366sZRVemoipPuBBX7DFjeBwDdk
n7qIR5ZaKYHa5MVHAoNNg9mvk19KYnOZYlK+ia7JCBP3FLhItidNZkaJLqsl1zPX
xbZ7T/4muaIbWTBr3Q7Ux7+zbUF5xqqcmzTz4MPG6ie6+kwyKJ3AqO0wulLO9e3B
DCrNH5AcdeZnYTJ8i19l1JcXNUs0TDp2y4Ib12ivHEZmavjud8QtVYO67fSSCu8b
u1xwPeqvUrMRKF59rTyzPllpJbcJ8A==
=+6yD
-----END PGP SIGNATURE-----

--9ZZlDBtNzEVdvXozHdeUSCP0axkKl6w4q--


