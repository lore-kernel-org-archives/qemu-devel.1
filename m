Return-Path: <SRS0=QE2o=ZK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBC9DC432C0
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Nov 2019 18:46:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9C011222F0
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Nov 2019 18:46:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OCUp9FXg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C011222F0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38174 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iWm2K-0008A1-H7
	for qemu-devel@archiver.kernel.org; Mon, 18 Nov 2019 13:46:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40501)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iWm1B-0007VU-G8
 for qemu-devel@nongnu.org; Mon, 18 Nov 2019 13:44:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iWm1A-0001h0-6L
 for qemu-devel@nongnu.org; Mon, 18 Nov 2019 13:44:57 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:59771
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1iWm1A-0001gn-1w
 for qemu-devel@nongnu.org; Mon, 18 Nov 2019 13:44:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574102695;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=XuUA3hmPcpEQqTEymi3RXdR2kAyMX3wKHt8JnItHM8E=;
 b=OCUp9FXgFiVCPyGepZMC26MBrg2FAamL12yxoMjxYe2C80nRzK+81yDZ4nxjFTsNJgAMsk
 3e2SeWdzM0PfdWevr1Jq/lqQ6SBERc6aAv/cz32YHS8LF5uQT7a0hQSjrLremXQ4c5DLrf
 LNTqqq48oviLDNu84yQTFSprXEZ+30s=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-335-73O5x9H3P6Ooo8kL0bWqsA-1; Mon, 18 Nov 2019 13:44:52 -0500
X-MC-Unique: 73O5x9H3P6Ooo8kL0bWqsA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6B2A3477;
 Mon, 18 Nov 2019 18:44:51 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-117-88.ams2.redhat.com
 [10.36.117.88])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E4E5719C4F;
 Mon, 18 Nov 2019 18:44:49 +0000 (UTC)
Subject: Re: [PATCH v3 2/4] iotests: Switch nbd tests to use Unix rather than
 TCP
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
References: <20191114213415.23499-1-eblake@redhat.com>
 <20191114213415.23499-3-eblake@redhat.com>
 <db43e495-8a10-62af-624a-c09b42488232@redhat.com>
 <b5a6953b-48b7-19a0-a1ba-c266cc81ef02@redhat.com>
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
Message-ID: <673b245a-8eeb-5945-2c60-c1a3757f6fed@redhat.com>
Date: Mon, 18 Nov 2019 19:44:47 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <b5a6953b-48b7-19a0-a1ba-c266cc81ef02@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="ebnb7TtRjH0813dcwdAsCrOIWe45SdfHn"
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 "open list:Block layer core" <qemu-block@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--ebnb7TtRjH0813dcwdAsCrOIWe45SdfHn
Content-Type: multipart/mixed; boundary="TEx9aU1g5iTUh497jVDT2gpu6qCxEs96T"

--TEx9aU1g5iTUh497jVDT2gpu6qCxEs96T
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 18.11.19 18:42, Eric Blake wrote:
> On 11/18/19 11:29 AM, Max Reitz wrote:
>> On 14.11.19 22:34, Eric Blake wrote:
>>> Up to now, all it took to cause a lot of iotest failures was to have a
>>> background process such as 'nbdkit -p 10810 null' running, because we
>>> hard-coded the TCP port.=C2=A0 Switching to a Unix socket eliminates th=
is
>>> contention.=C2=A0 We still have TCP coverage in test 233, and that test=
 is
>>> more careful to not pick a hard-coded port.
>>
>> For me, all it took was to run qcow2 and nbd tests in parallel (some
>> qcow2 tests create nbd servers, too), so this is great.
>>
>>> Signed-off-by: Eric Blake <eblake@redhat.com>
>>> ---
>>> =C2=A0 tests/qemu-iotests/common.filter | 6 ++++--
>>> =C2=A0 tests/qemu-iotests/common.rc=C2=A0=C2=A0=C2=A0=C2=A0 | 8 ++++---=
-
>>> =C2=A0 2 files changed, 8 insertions(+), 6 deletions(-)
>>>
>>> diff --git a/tests/qemu-iotests/common.filter
>>> b/tests/qemu-iotests/common.filter
>>> index f870e00e4421..5367deea398e 100644
>>> --- a/tests/qemu-iotests/common.filter
>>> +++ b/tests/qemu-iotests/common.filter
>>> @@ -127,7 +127,8 @@ _filter_img_create()
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -e "s#$TEST_DIR#=
TEST_DIR#g" \
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -e "s#$SOCK_DIR#=
SOCK_DIR#g" \
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -e "s#$IMGFMT#IM=
GFMT#g" \
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -e 's#nbd:127.0.0.1:10810#T=
EST_DIR/t.IMGFMT#g' \
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -e 's#nbd:127.0.0.1:[0-9]\\=
+#TEST_DIR/t.IMGFMT#g' \
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -e 's#nbd+unix:///\??socket=
=3DSOCK_DIR/nbd#TEST_DIR/t.IMGFMT#g' \
>>
>> Why the second question mark?=C2=A0 I thought the ? after the /// was
>> mandatory.
>=20
> Some of our code outputs:
>=20
> nbd+unix://?socket=3D...
>=20
> when there is no export name, while other outputs:
>=20
> nbd+unix:///?socket=3D...
>=20
> When there IS an export name, it outputs
>=20
> nbd+unix:///name?socket=3D...
>=20
> So the regex is matching 2 or 3 / (using \? to make the third optional),
> then a mandatory ?.

Ah, I mixed up the escaping, as I often do when dealing with regexes.

>>> +++ b/tests/qemu-iotests/common.rc
>>> @@ -217,7 +217,7 @@ if [ "$IMGOPTSSYNTAX" =3D "true" ]; then
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 TEST_IMG=3D"$DRI=
VER,file.filename=3D$TEST_DIR/t.$IMGFMT"
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 elif [ "$IMGPROTO" =3D "nbd" ]; then
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 TEST_IMG_FILE=3D=
$TEST_DIR/t.$IMGFMT
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
>>> TEST_IMG=3D"$DRIVER,file.driver=3Dnbd,file.host=3D127.0.0.1,file.port=
=3D10810"
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
>>> TEST_IMG=3D"$DRIVER,file.driver=3Dnbd,file.type=3Dunix,file.path=3D$SOC=
KDIR/$IMGFMT"
>>>
>>
>> Maybe nbd.$IMGFMT?
>=20
> At first glance, it seems reasonable.=C2=A0 But reading further,
>=20
>>
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 elif [ "$IMGPROTO" =3D "ssh" ]; then
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 TEST_IMG_FILE=3D=
$TEST_DIR/t.$IMGFMT
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
>>> TEST_IMG=3D"$DRIVER,file.driver=3Dssh,file.host=3D127.0.0.1,file.path=
=3D$TEST_IMG_FILE"
>>>
>>> @@ -233,7 +233,7 @@ else
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 TEST_IMG=3D$TEST=
_DIR/t.$IMGFMT
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 elif [ "$IMGPROTO" =3D "nbd" ]; then
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 TEST_IMG_FILE=3D=
$TEST_DIR/t.$IMGFMT
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 TEST_IMG=3D"nbd:127.0.0.1:1=
0810"
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 TEST_IMG=3D"nbd+unix:///?so=
cket=3D$SOCK_DIR/nbd"
>>
>> Shouldn=E2=80=99t this be $IMGFMT, too (instead of nbd)?=C2=A0 (Or maybe=
 nbd.$IMGFMT)
>=20
> Now I'm starting to wonder.=C2=A0 With NBD and non-raw, there are two pla=
ces
> to do the image format:
>=20
> qcow2 file -> qemu-nbd -f qcow2 -> raw bytes over NBD -> qemu client -f
> raw -> guest=C2=A0 (our typical usage)
>=20
> qcow2 file -> qemu-nbd -f raw -> qcow2 bytes over NBD -> qemu client -f
> qcow2 -> guest=C2=A0 (limited use, since NBD does not [yet] have resize s=
upport]
>=20
> so naming the socket $SOCK_DIR/nbd.qcow2 when the socket carries raw
> data (our typical use) seems awkward.=C2=A0 But then again, running './ch=
eck
> -qcow2 -nbd' shows that we seldom test qcow2 format over nbd protocol
> (precisely because nbd does not yet have resize).

Yes, the socket would carry qcow2 data.  Which doesn=E2=80=99t work (and I =
don=E2=80=99t
see a reason why we=E2=80=99d want it), but, well.

> If anything, I'm inclined to use $SOCK_DIR/nbd.raw to indicate that the
> NBD client sees raw format, regardless of the format in use by the
> server, to leave the door open for $SOCK_DIR/nbd.qcow2 when we finally
> are happy to test qcow2 format over NBD.

Sure, works for me.

> Or stick to just $SOCK_DIR/nbd hard-coded everywhere, and quit trying to
> use $IMGFMT in the socket name, to make all the usage consistent.

Works for me, too.

Max


--TEx9aU1g5iTUh497jVDT2gpu6qCxEs96T--

--ebnb7TtRjH0813dcwdAsCrOIWe45SdfHn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl3S5p8ACgkQ9AfbAGHV
z0ANwwf9EjLZcZnB0VBewG+Vz3f4aXrAI0wzchbcAZeXzGxclPYrI+iZ4EpLMH5M
84jGfZkX4aymub9i8HTlPu3GiKB5d9n0x9ClNc4TrPltvHt2mRIDv+Bl9P1t6X1v
whxWhB4fJFGgMjpkpvv29v3tuM/lKj5d8WCmD0Mn/Q18u+/17uDZs1E0a1AkAedO
3FIlRi/g5fGH1xHS2qAcS8taisToYnGq/c8Nb1ByT8XLmBRz7LhUSDZgE0nI6C25
R4BvUWufpsnxna9uU37qjpHIN206XRGjBwVXsQc/nrmrbko96KWJw89tJk4cM6cP
l4NkZKb7Q/8WawU57vz8j/3tMl1Cyg==
=9T9L
-----END PGP SIGNATURE-----

--ebnb7TtRjH0813dcwdAsCrOIWe45SdfHn--


