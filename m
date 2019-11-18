Return-Path: <SRS0=QE2o=ZK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5998C432C0
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Nov 2019 18:04:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7A564218AF
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Nov 2019 18:04:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EqJyX9/J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A564218AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37912 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iWlO0-0007j3-Hz
	for qemu-devel@archiver.kernel.org; Mon, 18 Nov 2019 13:04:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34873)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iWlN0-00075M-2J
 for qemu-devel@nongnu.org; Mon, 18 Nov 2019 13:03:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iWlMz-0000b8-5l
 for qemu-devel@nongnu.org; Mon, 18 Nov 2019 13:03:25 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:57112
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1iWlMz-0000at-0M
 for qemu-devel@nongnu.org; Mon, 18 Nov 2019 13:03:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574100204;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=EFPg57HUAZ0bVfsJRpyN26UY78Y1GFrhaaGmWIIjjsI=;
 b=EqJyX9/Ju1ERP4/3qMtPfXSVNcwvJDW6YTCR1N3K+4pV7BpSBZdNaYXSm0nV5c3ID19D00
 Wp+TNSv91ic0SJdNh2r+WUBW8tHKSEmTrHmNAmyIBLueyxi5v5HGLKi9PAgA6MhGkRIGSI
 mLuzKgzoDSyNmQin1Pfbaj2oBUCFs3M=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-335-LMa_0SWRMJaY8JDbJEnWYw-1; Mon, 18 Nov 2019 13:03:22 -0500
X-MC-Unique: LMa_0SWRMJaY8JDbJEnWYw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D7BE9801E5A;
 Mon, 18 Nov 2019 18:03:21 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-117-88.ams2.redhat.com
 [10.36.117.88])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id DFDA04B6;
 Mon, 18 Nov 2019 18:03:20 +0000 (UTC)
Subject: Re: [PATCH 2/2] iotests: Test multiple blockdev-snapshot calls
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
References: <20191108085312.27049-1-kwolf@redhat.com>
 <20191108085312.27049-3-kwolf@redhat.com>
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
Message-ID: <91867797-dfac-2193-9730-70fc701270df@redhat.com>
Date: Mon, 18 Nov 2019 19:03:18 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191108085312.27049-3-kwolf@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="kaVb80zkpmoHyur7UJJyxN7f9LshqO4W1"
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
Cc: pkrempa@redhat.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--kaVb80zkpmoHyur7UJJyxN7f9LshqO4W1
Content-Type: multipart/mixed; boundary="0HmdEFzAzZRtjlI8amGQ00GVxmxIz2h6i"

--0HmdEFzAzZRtjlI8amGQ00GVxmxIz2h6i
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 08.11.19 09:53, Kevin Wolf wrote:
> Test that doing a second blockdev-snapshot doesn't make the first
> overlay's backing file go away.
>=20
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  tests/qemu-iotests/273     |  76 +++++++++
>  tests/qemu-iotests/273.out | 337 +++++++++++++++++++++++++++++++++++++
>  tests/qemu-iotests/group   |   1 +
>  3 files changed, 414 insertions(+)
>  create mode 100755 tests/qemu-iotests/273
>  create mode 100644 tests/qemu-iotests/273.out

[...]

> +                "format-specific": {
> +                    "type": "IMGFMT",
> +                    "data": {
> +                        "compat": "1.1",
> +                        "lazy-refcounts": false,
> +                        "refcount-bits": 16,
> +                        "corrupt": false
> +                    }

I get a mismatch here with -o compat=3D0.10 or -o refcount_bits=3D1.

Max


--0HmdEFzAzZRtjlI8amGQ00GVxmxIz2h6i--

--kaVb80zkpmoHyur7UJJyxN7f9LshqO4W1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl3S3OcACgkQ9AfbAGHV
z0C0PggAk5FgL41maDjZ4/C/gR78jxILVb7lVOVTlwcwngwQU/WINvdRkuz7nNZG
3pN39kjIOqyumToapI2vUpJsTO7XWZS3T3yT3AH1KXWXFTyMsPp6X97HIsXL0j6f
dSMJXQAYMQB2H6UrQ4+G4NboY1HHJYqSotHMk5oBtq/i/gzqIGBXnCS9Dnl+rHpB
QM/hGhMjo0LXs/9JoSZaKM9FB6K9BIEvt4SgwEpAup0QUY251DwhhwdaBAKlBsco
wtK81syH70awjSjL1WZdkKM6beUcpKTVX05mYIJ/h6mrRUdUltg1O4zRLZREV15M
Caf+bWuNZ1XIxNrEhxG+tnp4eZrlyQ==
=Sbax
-----END PGP SIGNATURE-----

--kaVb80zkpmoHyur7UJJyxN7f9LshqO4W1--


