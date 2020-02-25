Return-Path: <SRS0=OzdF=4N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1264BC35E01
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 17:44:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D4C8C2082F
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 17:44:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="I4/UwIsN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D4C8C2082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33024 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6eGN-0002Uf-0V
	for qemu-devel@archiver.kernel.org; Tue, 25 Feb 2020 12:44:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41928)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1j6eFQ-0001qJ-Kj
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 12:43:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1j6eFP-0007p0-G1
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 12:43:56 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:60829
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1j6eFO-0007mQ-8y
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 12:43:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582652633;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=Gd/xI8JgucqpJBV8ygCv+8M1Rjwau3tTd2+xzioA9y8=;
 b=I4/UwIsN3n4z3iptmT1V8fAx7lLRl/MujVJQEuVZ4LrQS13mLsQm8B5IaP6R2E2rH73o2E
 sB/x0IZzF6oA84BuCvQb5rEKXbCuEVzrtzwNBfP6inDY6egdijT+Wda1zWx1uaO5MrskjQ
 G7NGtjjaDu8sLTGyIIpcfGpu74bqke0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-440-kbqdAqn8MV669ITJeTlqkA-1; Tue, 25 Feb 2020 12:43:49 -0500
X-MC-Unique: kbqdAqn8MV669ITJeTlqkA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 745D68017DF;
 Tue, 25 Feb 2020 17:43:48 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-117-215.ams2.redhat.com
 [10.36.117.215])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 0AE4227181;
 Tue, 25 Feb 2020 17:43:46 +0000 (UTC)
Subject: Re: [PATCH] iotests: Fix nonportable use of od --endian
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
References: <20200219144103.2919292-1-eblake@redhat.com>
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
Message-ID: <4a50da40-5a01-e597-b136-1be62994b2a2@redhat.com>
Date: Tue, 25 Feb 2020 18:43:45 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200219144103.2919292-1-eblake@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="NKUr5LFGQbGwODBlqq3Cm5DfAUcOVcPlB"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: qemu-trivial@nongnu.org, andrey.shinkevich@virtuozzo.com,
 Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--NKUr5LFGQbGwODBlqq3Cm5DfAUcOVcPlB
Content-Type: multipart/mixed; boundary="4GDF1HxE34OHdehYJWokpWYbNbIqrFumC"

--4GDF1HxE34OHdehYJWokpWYbNbIqrFumC
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 19.02.20 15:41, Eric Blake wrote:
> Tests 261 and 272 fail on RHEL 7 with coreutils 8.22, since od
> --endian was not added until coreutils 8.23.  Fix this by manually
> constructing the final value one byte at a time.
>=20
> Fixes: fc8ba423
> Reported-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
> Signed-off-by: Eric Blake <eblake@redhat.com>
> ---
>  tests/qemu-iotests/common.rc | 22 +++++++++++++++++-----
>  1 file changed, 17 insertions(+), 5 deletions(-)
>=20
> diff --git a/tests/qemu-iotests/common.rc b/tests/qemu-iotests/common.rc
> index 8a6366c09daf..b77ef3d22cd1 100644
> --- a/tests/qemu-iotests/common.rc
> +++ b/tests/qemu-iotests/common.rc
> @@ -56,6 +56,12 @@ poke_file()

I don=E2=80=99t know how you did it, but something in your workflow broke t=
his
patch.  This should be -56,18 +56,30.

(Note that git accepts this patch without error, but it drops everything
after the first part.  I noticed because your squash-in failed to apply.
 I suppose I might have noticed later when reviewing, because only
peek_file_le() was touched, but who knows.)

>  # peek_file_le 'test.img' 512 2 =3D> 65534
>  peek_file_le()
>  {
> -    # Wrap in echo $() to strip spaces
> -    echo $(od -j"$2" -N"$3" --endian=3Dlittle -An -vtu"$3" "$1")
> +    local val=3D0 shift=3D0 i
> +
> +    # coreutils' od --endian is not portable, so manually assemble bytes=
.
> +    for i in $(od -j"$2" -N"$3" -An -v -tu1 "$1"); do

=E2=80=9Ci=E2=80=9D is a weird name for something that isn=E2=80=99t an ind=
ex.

> +        val=3D$(( val | (i << shift) ))
> +        shift=3D$((shift + 8))
> +    done
> +    echo $val
>  }
>=20

Regarding the broken patch format again: There are no spaces here...

>  # peek_file_be 'test.img' 512 2 =3D> 65279
>  peek_file_be()
>  {
> -    # Wrap in echo $() to strip spaces
> -    echo $(od -j"$2" -N"$3" --endian=3Dbig -An -vtu"$3" "$1")
> +    local val=3D0 i
> +
> +    # coreutils' od --endian is not portable, so manually assemble bytes=
.
> +    for i in $(od -j"$2" -N"$3" -An -v -tu1 "$1"); do
> +        val=3D$(( (val << 8) | i ))
> +    done
> +    echo $val
>  }
>=20

...and here like there normally would be.

With the patch format fixed, and your proposed to-be-squashed patch
squashed in, there isn=E2=80=99t anything wrong, so:

Reviewed-by: Max Reitz <mreitz@redhat.com>

But if I=E2=80=99m already about to squash something in, would you allow me=
 to
rename all instances of =E2=80=9Ci=E2=80=9D to e.g. =E2=80=9Cbyte=E2=80=9D?

Max

> -# peek_file_raw 'test.img' 512 2 =3D> '\xff\xfe'
> +# peek_file_raw 'test.img' 512 2 =3D> '\xff\xfe'. Do not use if the raw =
data
> +# is likely to contain \0 or trailing \n.
>  peek_file_raw()
>  {
>      dd if=3D"$1" bs=3D1 skip=3D"$2" count=3D"$3" status=3Dnone
>=20



--4GDF1HxE34OHdehYJWokpWYbNbIqrFumC--

--NKUr5LFGQbGwODBlqq3Cm5DfAUcOVcPlB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl5VXNEACgkQ9AfbAGHV
z0D93Af7BzoMeAZD8ZM2Hfc9bp/ObX/Ih94v8qF4e5phd8eMZ4m/zUWjAI1tZ4zx
+V2LH3RTMOmxzfiIzMaLCphO2x8rXp4eGNGj0JBp3jPCVYwMnPSXCr0qejfHShAz
LhkiR+QgpzzK4EXE3JdJJSNH3EgIO6yNKH9Z6wMwJ1g9ui5xHcn3VMHobZsomz1d
GWnY2wOjneMy7wj+svD6/2B6sGwzb/1PZssPJ+jB1aQQJQ41BuXfYDQOXdHv/4pc
VZsV5sIg0d6PwbD7ZFx32SlHnNthZuEKEktEOKIfvE92+q7ZGcEeDRhTvPBoiIq/
pUcavXhDsHs9PvH8O/taz4ohc3bITw==
=8PDB
-----END PGP SIGNATURE-----

--NKUr5LFGQbGwODBlqq3Cm5DfAUcOVcPlB--


