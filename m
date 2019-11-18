Return-Path: <SRS0=QE2o=ZK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F740C432C0
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Nov 2019 17:31:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E0D902186D
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Nov 2019 17:31:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JXYi0aD/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E0D902186D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37554 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iWkrd-00085l-3G
	for qemu-devel@archiver.kernel.org; Mon, 18 Nov 2019 12:31:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57615)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iWkqZ-0007UM-GA
 for qemu-devel@nongnu.org; Mon, 18 Nov 2019 12:29:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iWkqY-0006ZB-8g
 for qemu-devel@nongnu.org; Mon, 18 Nov 2019 12:29:55 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:21949
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1iWkqY-0006Z1-4k
 for qemu-devel@nongnu.org; Mon, 18 Nov 2019 12:29:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574098193;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=RLZIsy7DE2zVMgE1OTt2wN61VgV2MhsAhlGchwvQGNg=;
 b=JXYi0aD/BdrWxUL/sq1tNL0DufGbinuyt2KwobuhN2ZX22/C6SZvj4hh9+/jCUjfbn9zoZ
 lxTEgWdj4uGx0xJh6SzxEVpv9rNF3jLvsJHdY48Ka9WUsY/TUXvj5ZuhWpu5E1L/B0wF2r
 tmQbd8FYJ4XqHJ/wXV9+Jd0LsYpunbE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-277-aALbN2AbP-ClKX5WY7DoWQ-1; Mon, 18 Nov 2019 12:29:50 -0500
X-MC-Unique: aALbN2AbP-ClKX5WY7DoWQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0264412CA34;
 Mon, 18 Nov 2019 17:29:49 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-117-88.ams2.redhat.com
 [10.36.117.88])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 73E7D101F6C0;
 Mon, 18 Nov 2019 17:29:47 +0000 (UTC)
Subject: Re: [PATCH v3 2/4] iotests: Switch nbd tests to use Unix rather than
 TCP
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
References: <20191114213415.23499-1-eblake@redhat.com>
 <20191114213415.23499-3-eblake@redhat.com>
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
Message-ID: <db43e495-8a10-62af-624a-c09b42488232@redhat.com>
Date: Mon, 18 Nov 2019 18:29:45 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191114213415.23499-3-eblake@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="npoAenC9GkenINzp0cJ5Pril0LjnCxkq4"
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
--npoAenC9GkenINzp0cJ5Pril0LjnCxkq4
Content-Type: multipart/mixed; boundary="6BBzEoiXh0KGsvPFWRV4e4j0kaVMeTUj5"

--6BBzEoiXh0KGsvPFWRV4e4j0kaVMeTUj5
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 14.11.19 22:34, Eric Blake wrote:
> Up to now, all it took to cause a lot of iotest failures was to have a
> background process such as 'nbdkit -p 10810 null' running, because we
> hard-coded the TCP port.  Switching to a Unix socket eliminates this
> contention.  We still have TCP coverage in test 233, and that test is
> more careful to not pick a hard-coded port.

For me, all it took was to run qcow2 and nbd tests in parallel (some
qcow2 tests create nbd servers, too), so this is great.

> Signed-off-by: Eric Blake <eblake@redhat.com>
> ---
>  tests/qemu-iotests/common.filter | 6 ++++--
>  tests/qemu-iotests/common.rc     | 8 ++++----
>  2 files changed, 8 insertions(+), 6 deletions(-)
>=20
> diff --git a/tests/qemu-iotests/common.filter b/tests/qemu-iotests/common=
.filter
> index f870e00e4421..5367deea398e 100644
> --- a/tests/qemu-iotests/common.filter
> +++ b/tests/qemu-iotests/common.filter
> @@ -127,7 +127,8 @@ _filter_img_create()
>          -e "s#$TEST_DIR#TEST_DIR#g" \
>          -e "s#$SOCK_DIR#SOCK_DIR#g" \
>          -e "s#$IMGFMT#IMGFMT#g" \
> -        -e 's#nbd:127.0.0.1:10810#TEST_DIR/t.IMGFMT#g' \
> +        -e 's#nbd:127.0.0.1:[0-9]\\+#TEST_DIR/t.IMGFMT#g' \
> +        -e 's#nbd+unix:///\??socket=3DSOCK_DIR/nbd#TEST_DIR/t.IMGFMT#g' =
\

Why the second question mark?  I thought the ? after the /// was mandatory.

>          -e "s# encryption=3Doff##g" \
>          -e "s# cluster_size=3D[0-9]\\+##g" \
>          -e "s# table_size=3D[0-9]\\+##g" \
> @@ -164,7 +165,8 @@ _filter_img_info()
>          -e "s#$TEST_DIR#TEST_DIR#g" \
>          -e "s#$SOCK_DIR#SOCK_DIR#g" \
>          -e "s#$IMGFMT#IMGFMT#g" \
> -        -e 's#nbd://127.0.0.1:10810$#TEST_DIR/t.IMGFMT#g' \
> +        -e 's#nbd://127.0.0.1:[0-9]\\+$#TEST_DIR/t.IMGFMT#g' \
> +        -e 's#nbd+unix:///\??socket=3DSOCK_DIR/nbd#TEST_DIR/t.IMGFMT#g' =
\
>          -e 's#json.*vdisk-id.*vxhs"}}#TEST_DIR/t.IMGFMT#' \
>          -e "/encrypted: yes/d" \
>          -e "/cluster_size: [0-9]\\+/d" \
> diff --git a/tests/qemu-iotests/common.rc b/tests/qemu-iotests/common.rc
> index fa7bae24226a..f772dcb67322 100644
> --- a/tests/qemu-iotests/common.rc
> +++ b/tests/qemu-iotests/common.rc
> @@ -217,7 +217,7 @@ if [ "$IMGOPTSSYNTAX" =3D "true" ]; then
>          TEST_IMG=3D"$DRIVER,file.filename=3D$TEST_DIR/t.$IMGFMT"
>      elif [ "$IMGPROTO" =3D "nbd" ]; then
>          TEST_IMG_FILE=3D$TEST_DIR/t.$IMGFMT
> -        TEST_IMG=3D"$DRIVER,file.driver=3Dnbd,file.host=3D127.0.0.1,file=
.port=3D10810"
> +        TEST_IMG=3D"$DRIVER,file.driver=3Dnbd,file.type=3Dunix,file.path=
=3D$SOCKDIR/$IMGFMT"

Maybe nbd.$IMGFMT?

>      elif [ "$IMGPROTO" =3D "ssh" ]; then
>          TEST_IMG_FILE=3D$TEST_DIR/t.$IMGFMT
>          TEST_IMG=3D"$DRIVER,file.driver=3Dssh,file.host=3D127.0.0.1,file=
.path=3D$TEST_IMG_FILE"
> @@ -233,7 +233,7 @@ else
>          TEST_IMG=3D$TEST_DIR/t.$IMGFMT
>      elif [ "$IMGPROTO" =3D "nbd" ]; then
>          TEST_IMG_FILE=3D$TEST_DIR/t.$IMGFMT
> -        TEST_IMG=3D"nbd:127.0.0.1:10810"
> +        TEST_IMG=3D"nbd+unix:///?socket=3D$SOCK_DIR/nbd"

Shouldn=E2=80=99t this be $IMGFMT, too (instead of nbd)?  (Or maybe nbd.$IM=
GFMT)

Max

>      elif [ "$IMGPROTO" =3D "ssh" ]; then
>          TEST_IMG_FILE=3D$TEST_DIR/t.$IMGFMT
>          REMOTE_TEST_DIR=3D"ssh://\\($USER@\\)\\?127.0.0.1\\(:[0-9]\\+\\)=
\\?$TEST_DIR"
> @@ -293,7 +293,7 @@ _stop_nbd_server()
>          local QEMU_NBD_PID
>          read QEMU_NBD_PID < "${QEMU_TEST_DIR}/qemu-nbd.pid"
>          kill ${QEMU_NBD_PID}
> -        rm -f "${QEMU_TEST_DIR}/qemu-nbd.pid"
> +        rm -f "${QEMU_TEST_DIR}/qemu-nbd.pid" "$SOCK_DIR/nbd"
>      fi
>  }
>=20
> @@ -353,7 +353,7 @@ _make_test_img()
>      if [ $IMGPROTO =3D "nbd" ]; then
>          # Pass a sufficiently high number to -e that should be enough fo=
r all
>          # tests
> -        eval "$QEMU_NBD -v -t -b 127.0.0.1 -p 10810 -f $IMGFMT -e 42 -x =
'' $TEST_IMG_FILE >/dev/null &"
> +        eval "$QEMU_NBD -v -t -k '$SOCK_DIR/nbd' -f $IMGFMT -e 42 -x '' =
$TEST_IMG_FILE >/dev/null &"
>          sleep 1 # FIXME: qemu-nbd needs to be listening before we contin=
ue
>      fi
>=20



--6BBzEoiXh0KGsvPFWRV4e4j0kaVMeTUj5--

--npoAenC9GkenINzp0cJ5Pril0LjnCxkq4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl3S1QkACgkQ9AfbAGHV
z0B0BggAnDRQdpk7MKCf3hD23tc3y2dEIqHw1pEj2LKmb+FSVcY9ED9rMmQtjGRS
2k/gs5W8ISHnTws7tQcssXpJfmWhaXGVAn1NOnhat9U53wcuATjyPyU2fyuJOb7o
dn1zips8fS7lX29UFf5JFYBfJbvhnUs3GCjOt+Nnkr/y8HZPevE1JPmBCFkziPEM
xxV+8eFIRdekgUJyE0l7vvj13Fhh8kG2KReeaAkwTf2yQzxm4es/K9MTwIG62gXZ
DHiJ7SK6hJcK8DuSHohgPiFeRl6/R4Q8JmyfV42+d177aip5QoX6ySo7Lblw8FY+
c/X06sAZ7UAV/Lyc5X9scu4wLAtC+Q==
=LqzP
-----END PGP SIGNATURE-----

--npoAenC9GkenINzp0cJ5Pril0LjnCxkq4--


