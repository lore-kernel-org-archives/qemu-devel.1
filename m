Return-Path: <SRS0=HiY9=4H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE056C34047
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2020 10:39:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B85F42465D
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2020 10:39:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iatfp7bj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B85F42465D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48768 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j4Ml8-00060t-Td
	for qemu-devel@archiver.kernel.org; Wed, 19 Feb 2020 05:39:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58078)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1j4MkX-0005XU-Gv
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 05:38:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1j4MkW-0006Zv-Ah
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 05:38:37 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:41847
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1j4MkW-0006ZM-5n
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 05:38:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582108715;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=77uf+v9Ntwbve021oAsAF70lkDXQGqU8s0ekDkFWCwM=;
 b=iatfp7bjikXLV4TGQplOL8lJMr24iedwwErVpcG5A2GBb4Jos0oDgTvk+EPudRM0RyVr1n
 HQJ5kxWFW/WFPOQcgYmGkSVHSbY0aD3aspDinz2lR12bRNeTqJ1tKngcmSiINu5XQM+UkI
 apoCKFDolJUyHFUzbBLE6LzGRd6RKkg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-341-qXDfG88YNIKoE-H32_Qorw-1; Wed, 19 Feb 2020 05:38:19 -0500
X-MC-Unique: qXDfG88YNIKoE-H32_Qorw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B138313E2;
 Wed, 19 Feb 2020 10:38:18 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-116-152.ams2.redhat.com
 [10.36.116.152])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 99B698AC47;
 Wed, 19 Feb 2020 10:38:17 +0000 (UTC)
Subject: Re: [PATCH v2 0/5] block: Generic file creation fallback
To: qemu-block@nongnu.org
References: <20200122164532.178040-1-mreitz@redhat.com>
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
Message-ID: <07edfa0c-25af-e519-eb41-5bcda107438e@redhat.com>
Date: Wed, 19 Feb 2020 11:38:16 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200122164532.178040-1-mreitz@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="ouVugZfzLtXmBhcv2twnuLnbQ5JajRAuY"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org,
 Maxim Levitsky <mlevitsk@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--ouVugZfzLtXmBhcv2twnuLnbQ5JajRAuY
Content-Type: multipart/mixed; boundary="WTxQrvPQpK8XDQf4rpKAY1K5z7LGBLuhZ"

--WTxQrvPQpK8XDQf4rpKAY1K5z7LGBLuhZ
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 22.01.20 17:45, Max Reitz wrote:
> Hi,
>=20
> As version 1, this series adds a fallback path for creating files (on
> the protocol layer) if the protocol driver does not support file
> creation, but the file already exists.
>=20
>=20
> Branch: https://github.com/XanClic/qemu.git skip-proto-create-v2
> Branch: https://git.xanclic.moe/XanClic/qemu.git skip-proto-create-v2
>=20
>=20
> v2:
> - Drop blk_truncate_for_formatting(): It doesn=E2=80=99t make sense to in=
troduce
>   this function any more after 26536c7fc25917d1bd13781f81fe3ab039643bff
>   (=E2=80=9Cblock: Do not truncate file node when formatting=E2=80=9D), b=
ecause we=E2=80=99d
>   only use it in bdrv_create_file_fallback().
>   Thus, it makes more sense to create special helper functions
>   specifically for bdrv_create_file_fallback().
>=20
> - Thus, dropped patches 2 and 3.
>=20
> - And changed patch 4 to include those helper functions.
>=20
> - Rebased, which was a bit of a pain.

Thanks for the reviews, added a note to the new test why the second case
is expected to fail (as requested by Maxim), and applied the series to
my block branch:

https://git.xanclic.moe/XanClic/qemu/commits/branch/block

Max


--WTxQrvPQpK8XDQf4rpKAY1K5z7LGBLuhZ--

--ouVugZfzLtXmBhcv2twnuLnbQ5JajRAuY
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl5NEBgACgkQ9AfbAGHV
z0ByGgf/cJU5inhIKmgJvIMjY6nxDDbaY8oP+8zAL3JzOd8dk9VVHfyTtHIuewz0
9x3j9pPf08Wro0BAq16tc0gK8IQJ/2PsgQzYvABonorbFJIiRB4E70c3PjHPJ7RZ
Xfv5MhPyRfRdFt4iqphawyEarxRCXR0KhV4WAB4YKqOnQ9OCVptpw5eqFKaf2GSM
p/10nDNnnuzCSh9xus2b4EFB9/1zeRUcGC2DmJdoUbO6iyBXhuveBGjwycl6bhh7
2gck+XdkNHz2dvtSxO3PWUhvpP+QEFTYEw+eAh1pLislGW/zheJ3QM6K1FEKy7cS
x+24d1o9+ZfxN7hRAK+jlxhYddpnsg==
=zaLp
-----END PGP SIGNATURE-----

--ouVugZfzLtXmBhcv2twnuLnbQ5JajRAuY--


