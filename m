Return-Path: <SRS0=6r5r=AY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E3D4C433E1
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 10:12:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 690E82077D
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 10:12:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Du9ZqMnL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 690E82077D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36482 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1juvRN-0008Lc-Nl
	for qemu-devel@archiver.kernel.org; Mon, 13 Jul 2020 06:12:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45882)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1juvQS-0007jE-S9
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 06:11:08 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:43181
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1juvQQ-0005Dp-J1
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 06:11:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594635065;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=S16CeIgE/CU42HK+5nwFpE66319Bwf8tmkqoIt1OjTg=;
 b=Du9ZqMnLZ51hwshoWox2YU0trEwsaR2vojN4hrF75QgZQLIzj8ZzSs5oaUKkP1g2uCUlUk
 ROoX4L0WWc4wOqYJAGQDm4u70AR1RHKR+LSf338Tr3F8PJpNqErAwjI/oSG2yYJ1J413Vv
 /ciglbjJNECs/svvjiQHbGpCerSkGUI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-110-FMNYEkHFOxiVvwwAAVi9SQ-1; Mon, 13 Jul 2020 06:11:01 -0400
X-MC-Unique: FMNYEkHFOxiVvwwAAVi9SQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 74E1E800685;
 Mon, 13 Jul 2020 10:11:00 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-113-8.ams2.redhat.com
 [10.36.113.8])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 47C421001281;
 Mon, 13 Jul 2020 10:10:59 +0000 (UTC)
Subject: Re: [PATCH] block: Raise an error when backing file parameter is an
 empty string
To: Connor Kuehl <ckuehl@redhat.com>, kwolf@redhat.com
References: <20200617182725.951119-1-ckuehl@redhat.com>
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
Message-ID: <32e25922-c3da-c3a6-c853-c729a3a85853@redhat.com>
Date: Mon, 13 Jul 2020 12:10:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200617182725.951119-1-ckuehl@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mreitz@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="xQuMvF8HZMvt1mvvDOW3DZGo5uiHDwAqO"
Received-SPF: pass client-ip=205.139.110.61; envelope-from=mreitz@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/13 01:36:29
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--xQuMvF8HZMvt1mvvDOW3DZGo5uiHDwAqO
Content-Type: multipart/mixed; boundary="6pUGHUTAabwjd6zODCk5nROiza3jjJa7M"

--6pUGHUTAabwjd6zODCk5nROiza3jjJa7M
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 17.06.20 20:27,

Sorry :/

Connor Kuehl wrote:
> Providing an empty string for the backing file parameter like so:
>=20
> =09qemu-img create -f qcow2 -b '' /tmp/foo
>=20
> allows the flow of control to reach and subsequently fail an assert
> statement because passing an empty string to
>=20
> =09bdrv_get_full_backing_filename_from_filename()
>=20
> simply results in NULL being returned without an error being raised.
>=20
> To fix this, let's check for an empty string when getting the value from
> the opts list.
>=20
> Reported-by: Attila Fazekas <afazekas@redhat.com>
> Fixes: https://bugzilla.redhat.com/1809553
> Signed-off-by: Connor Kuehl <ckuehl@redhat.com>
> ---
>  block.c                    |  4 ++++
>  tests/qemu-iotests/298     | 47 ++++++++++++++++++++++++++++++++++++++
>  tests/qemu-iotests/298.out |  5 ++++
>  tests/qemu-iotests/group   |  1 +
>  4 files changed, 57 insertions(+)
>  create mode 100755 tests/qemu-iotests/298
>  create mode 100644 tests/qemu-iotests/298.out
>=20
> diff --git a/block.c b/block.c
> index 6dbcb7e083..b335d6bcb2 100644
> --- a/block.c
> +++ b/block.c
> @@ -6116,6 +6116,10 @@ void bdrv_img_create(const char *filename, const c=
har *fmt,
>                               "same filename as the backing file");
>              goto out;
>          }
> +        if (backing_file[0] =3D=3D '\0') {
> +            error_setg(errp, "Expected backing file name, got empty stri=
ng");
> +            goto out;
> +        }

Looks good.

>      }
> =20
>      backing_fmt =3D qemu_opt_get(opts, BLOCK_OPT_BACKING_FMT);
> diff --git a/tests/qemu-iotests/298 b/tests/qemu-iotests/298
> new file mode 100755
> index 0000000000..1e30caebec
> --- /dev/null
> +++ b/tests/qemu-iotests/298
> @@ -0,0 +1,47 @@
> +#!/usr/bin/env python3
> +#
> +# Copyright (C) 2020 Red Hat, Inc.
> +#
> +# This program is free software; you can redistribute it and/or modify
> +# it under the terms of the GNU General Public License as published by
> +# the Free Software Foundation; either version 2 of the License, or
> +# (at your option) any later version.
> +#
> +# This program is distributed in the hope that it will be useful,
> +# but WITHOUT ANY WARRANTY; without even the implied warranty of
> +# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> +# GNU General Public License for more details.
> +#
> +# You should have received a copy of the GNU General Public License
> +# along with this program.  If not, see <http://www.gnu.org/licenses/>.
> +
> +
> +
> +# Regression test for avoiding an assertion when the 'backing file'
> +# parameter (-b) is set to an empty string for qemu-img create
> +#
> +#   qemu-img create -f qcow2 -b '' /tmp/foo
> +#
> +# This ensures the invalid parameter is handled with a user-
> +# friendly message instead of a failed assertion.
> +
> +import iotests
> +
> +class TestEmptyBackingFilename(iotests.QMPTestCase):
> +
> +
> +    def test_empty_backing_file_name(self):
> +        actual =3D iotests.qemu_img_pipe(

(pylint complains about the indentation that follows, it says it=E2=80=99d
prefer four spaces less.  Make of that want you wish, AFAIA there=E2=80=99s=
 no
requirement to get a clean pylint pass for iotests yet. O:))

> +                'create',
> +                '-f', 'qcow2',

This should be iotests.imgfmt, not specifically qcow2.

> +                '-b', '',
> +                '/tmp/foo'

I=E2=80=99m not sure I like using /tmp/foo very much, for two reasons: Firs=
t,
this expects that the backing filename will be checked before something
really happens with the image filename; for example on Windows, /tmp/foo
is just not a valid filename, so we might end up getting an error
because of that.  Or, for me, I like saving mails in a directory called
/tmp/foo, so maybe at some point I get an error because /tmp/foo already
exists as a directory.

Second, if we ever do run into a regression or some configuration where
this test unexpectedly manages to create the image, it would overwrite
/tmp/foo.  Which maybe isn=E2=80=99t good, because maybe it=E2=80=99s a fil=
e the user
wants to keep around.

The fix is simple, just use some file under iotests.test_dir.  I think
the easiest way right now is something like:

with iotests.FilePath('test.img') as img_path:
    actual =3D iotests.qemu_img_pipe('create', ..., img_path, '1M')
    expected =3D f'qemu-img: {img_path}: Expected...'
    self.assertEqual(...)

(On that note, I=E2=80=99d give a size to qemu-img, so that the invocation =
is
correct apart from the missing backing file name.)

> +        )
> +        expected =3D 'qemu-img: /tmp/foo: Expected backing file name,' \
> +                   ' got empty string'
> +
> +        self.assertEqual(actual.strip(), expected.strip())
> +
> +
> +if __name__ =3D=3D '__main__':
> +    iotests.main(supported_fmts=3D['raw', 'qcow2'])

raw isn=E2=80=99t supported, this test only works for formats that support
backing files.  (Which also means it should work for qed and qcow, I
imagine...?)

Max


--6pUGHUTAabwjd6zODCk5nROiza3jjJa7M--

--xQuMvF8HZMvt1mvvDOW3DZGo5uiHDwAqO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl8MMzEACgkQ9AfbAGHV
z0AvvQf+Mc2vXpS1XfcFwYyR0nu7I8tetQ5LEddGSVnSk9YXe4LEXgl2Iz0irMgl
WypA3+AAFqiv6vW36bOYiCx819d9fH3OA8DGLcVFgSA/tz4H9AxBGq0i8/bxQzDh
6kA5rAry5w5ls7+EhE5+0jnbkQp+nD1XJftRVXas1cVLilWZv6IjvxEoNoidpKp0
8OV5f8KEV1R7VHWG5bZ5d0Rqv7BbxPh5FlOfMWzYEwaep+1A+FmZRAdGTSGMOyBK
o+VPE7bITiLTi8qZO5iIq1jrXXtV2bOAaQf6ylgq+XGlf9dzsc36d4FHED9QjTL1
IISvHKcF4VIEx+1T7EW/snkR/wIuzA==
=kX0R
-----END PGP SIGNATURE-----

--xQuMvF8HZMvt1mvvDOW3DZGo5uiHDwAqO--


