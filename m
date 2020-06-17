Return-Path: <SRS0=bzpH=76=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68081C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 06:43:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 32793208C3
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 06:43:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="it/M4ShR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 32793208C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36534 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlRn9-0004KP-H4
	for qemu-devel@archiver.kernel.org; Wed, 17 Jun 2020 02:43:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59946)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1jlRmG-0003oW-Ct
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 02:42:28 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:29949
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1jlRmE-00044U-AX
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 02:42:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592376145;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=S3X+VlYAAM+5Yg3n0pYe9ZP/3ak366v0s41FwlaOAf8=;
 b=it/M4ShRiq8nzB17Tn5A0PFXn7PLaBP6DyrrJUZPrE2YZ5L+y1ieszuofh2+sidG1fJ1Ip
 DtxS99nJli/QVbIfNfDKOXzjsOVbPX7RqgXgjOeHeoa50uYFYkJcje3619VAu/AflA8DRO
 PsH8CmRwc/61qbJ4AR/dJkBbgDicSmk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-442-bZzdGjAeOOuzyQSS2JHhZA-1; Wed, 17 Jun 2020 02:42:21 -0400
X-MC-Unique: bZzdGjAeOOuzyQSS2JHhZA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A773C81EE28;
 Wed, 17 Jun 2020 06:42:20 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-113-111.ams2.redhat.com
 [10.36.113.111])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 8DD1B7CACC;
 Wed, 17 Jun 2020 06:42:19 +0000 (UTC)
Subject: Re: iotest 041 is failing with -qed
To: Thomas Huth <thuth@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>
References: <900ebe8c-ac9e-a355-b068-41735863dce4@redhat.com>
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
Message-ID: <8f918615-1666-dd8e-1815-98ab224ec610@redhat.com>
Date: Wed, 17 Jun 2020 08:42:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <900ebe8c-ac9e-a355-b068-41735863dce4@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="xMmYBAidFX9LJqr6nuEac9qMw8C6dJSqr"
Received-SPF: pass client-ip=205.139.110.61; envelope-from=mreitz@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/17 02:02:46
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Kevin Wolf <kwolf@redhat.com>, Qemu-block <qemu-block@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--xMmYBAidFX9LJqr6nuEac9qMw8C6dJSqr
Content-Type: multipart/mixed; boundary="iDHgkn3qRQxvW7q1YVx2wXveI5R85NbWK"

--iDHgkn3qRQxvW7q1YVx2wXveI5R85NbWK
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 17.06.20 08:18, Thomas Huth wrote:
>=20
>  Hi!
>=20
> I just noticed that iotest 041 is failing with -qed:
>=20
> $ ./check -qed 041
> QEMU          --
> "tests/qemu-iotests/../../x86_64-softmmu/qemu-system-x86_64" -nodefaults
> -display none -accel qtest
> QEMU_IMG      -- "tests/qemu-iotests/../../qemu-img"
> QEMU_IO       -- "tests/qemu-iotests/../../qemu-io"  --cache writeback
> --aio threads -f qed
> QEMU_NBD      -- "tests/qemu-iotests/../../qemu-nbd"
> IMGFMT        -- qed
> IMGPROTO      -- file
> PLATFORM      -- Linux/x86_64 thuth 4.18.0-80.11.2.el8_0.x86_64
> TEST_DIR      -- tests/qemu-iotests/scratch
> SOCK_DIR      -- /tmp/tmp.Fgwzwl4EoG
> SOCKET_SCM_HELPER -- tests/qemu-iotests/socket_scm_helper
>=20
> 041      fail       [08:12:36] [08:13:09]      (last: 31s)   output
> mismatch (see 041.out.bad)
> --- tests/qemu-iotests/041.out=092020-06-15 14:11:05.389400610 +0200
> +++ tests/qemu-iotests/041.out.bad=092020-06-17 08:13:09.205195987 +0200
> @@ -1,5 +1,33 @@
> -........................................................................=
................................
> +........................................F............F..................=
................................
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +FAIL: test_small_target (__main__.TestSingleBlockdev)
> +----------------------------------------------------------------------
> +Traceback (most recent call last):
> +  File "041", line 281, in test_small_target
> +    self.do_test_target_size(self.image_len // 2)
> +  File "041", line 270, in do_test_target_size
> +    self.assert_qmp(result, 'return', {})
> +  File "tests/qemu-iotests/iotests.py", line 848, in assert_qmp
> +    result =3D self.dictpath(d, path)
> +  File "tests/qemu-iotests/iotests.py", line 822, in dictpath
> +    self.fail(f'failed path traversal for "{path}" in "{d}"')
> +AssertionError: failed path traversal for "return" in "{'error':
> {'class': 'GenericError', 'desc': 'Shrinking images is currently not
> supported'}}"
> +
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +FAIL: test_small_target (__main__.TestSingleBlockdevUnalignedLength)
> +----------------------------------------------------------------------
> +Traceback (most recent call last):
> +  File "041", line 281, in test_small_target
> +    self.do_test_target_size(self.image_len // 2)
> +  File "041", line 270, in do_test_target_size
> +    self.assert_qmp(result, 'return', {})
> +  File "tests/qemu-iotests/iotests.py", line 848, in assert_qmp
> +    result =3D self.dictpath(d, path)
> +  File "tests/qemu-iotests/iotests.py", line 822, in dictpath
> +    self.fail(f'failed path traversal for "{path}" in "{d}"')
> +AssertionError: failed path traversal for "return" in "{'error':
> {'class': 'GenericError', 'desc': 'Shrinking images is currently not
> supported'}}"
> +
>  ----------------------------------------------------------------------
>  Ran 104 tests
>=20
> -OK
> +FAILED (failures=3D2)
> Failures: 041
> Failed 1 of 1 iotests
>=20
> Is it a known problem already?

Well, FWIW, I knew of it, but didn=E2=80=99t get around to doing anything a=
bout
it yet.

Thanks for reporting it anyway, now I have better justification to do
something about it. :)  (And of course in case I would have missed it.)

Max


--iDHgkn3qRQxvW7q1YVx2wXveI5R85NbWK--

--xMmYBAidFX9LJqr6nuEac9qMw8C6dJSqr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl7pu0kACgkQ9AfbAGHV
z0CClggAm3GDB0DcGK0tE3UD6o7d/1zr8uyNV3N0NfMafGijPACEEdE2hjYf4oYo
YZd9Ql57UtFj89zv+D0vJ1mZNSgeUxpk6PlCyU4QaeEF6HFvU9HAUEjK7xdmsPmO
0EF95kv1Xw2PvcNgOXckP9sz/bPyyDzK8QlUPtMc3L2w0x0XdZdnf893RtUi73hQ
zRKAC540R3Tl2xFrXW99H4HpscoFL6J0BBxsQa68msxmc600BNY+XVJTEMTvMgJd
dJcxstvnRBx8JAZeiCDiCCRHF9ocKAuXm6y7KB+e6gGg+q2CFAZuRioxY47ZXn18
leNMh7awNirhhdsYl0NH92gCOWvk3g==
=kP9J
-----END PGP SIGNATURE-----

--xMmYBAidFX9LJqr6nuEac9qMw8C6dJSqr--


