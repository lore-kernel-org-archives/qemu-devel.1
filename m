Return-Path: <SRS0=XqMt=3J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F18B4C2D0DB
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2020 14:52:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BC2CF22464
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2020 14:52:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZfmKW2oc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC2CF22464
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38070 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1itYPw-0005Vm-NV
	for qemu-devel@archiver.kernel.org; Mon, 20 Jan 2020 09:52:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44274)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1itYNl-0002v0-VY
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 09:50:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1itYNi-0006Qj-1K
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 09:50:25 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:55405
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1itYNh-0006QZ-Sp
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 09:50:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579531821;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=FZ7TV0D6zXTNctNV2j/Z+rIMykqAfjKdiLIANwSTTbQ=;
 b=ZfmKW2ocJiBdI4zCg/JAnEZMFNHo2oEylivayqZ5KwO7Jo9KWMg0T/+NvjgunrmPKuvGRQ
 tDqleXhlrj/7GULeOZLGrIuRBVaydZzkKBWMP8JbMgBDNJ1rjgrvxvMcGbWDOoF7IDF7DJ
 BDDdiLXrAskqo/chbkhcutH4xJTjPqA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-151-IU9J8a32NMK84hMADWCKpg-1; Mon, 20 Jan 2020 09:50:19 -0500
X-MC-Unique: IU9J8a32NMK84hMADWCKpg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0FFF7190B2A3;
 Mon, 20 Jan 2020 14:50:18 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-117-225.ams2.redhat.com
 [10.36.117.225])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 0D8DF19C70;
 Mon, 20 Jan 2020 14:50:13 +0000 (UTC)
Subject: Re: [PATCH v4 5/6] iotests: Skip Python-based tests if QEMU does not
 support virtio-blk
To: Thomas Huth <thuth@redhat.com>, qemu-block@nongnu.org,
 Kevin Wolf <kwolf@redhat.com>
References: <20191202101039.8981-1-thuth@redhat.com>
 <20191202101039.8981-6-thuth@redhat.com>
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
Message-ID: <a51a4748-fa43-d2b2-ffa2-05769e8f32f3@redhat.com>
Date: Mon, 20 Jan 2020 15:50:11 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <20191202101039.8981-6-thuth@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="L8CJ4Do4K5q6w0AsTtwzklu8wVxqHqNug"
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
Cc: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--L8CJ4Do4K5q6w0AsTtwzklu8wVxqHqNug
Content-Type: multipart/mixed; boundary="boXHdJXwVtdIlZr5t7A5xBMGHT4saPLHv"

--boXHdJXwVtdIlZr5t7A5xBMGHT4saPLHv
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 02.12.19 11:10, Thomas Huth wrote:
> We are going to enable some of the python-based tests in the "auto" group=
,
> and these tests require virtio-blk to work properly. Running iotests
> without virtio-blk likely does not make too much sense anyway, so instead
> of adding a check for the availability of virtio-blk to each and every
> test (which does not sound very appealing), let's rather add a check for
> this a central spot in the "check" script instead (so that it is still
> possible to run "make check" for qemu-system-tricore for example).
>=20
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  tests/qemu-iotests/check | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
>=20
> diff --git a/tests/qemu-iotests/check b/tests/qemu-iotests/check
> index 90970b0549..bce3035d5a 100755
> --- a/tests/qemu-iotests/check
> +++ b/tests/qemu-iotests/check
> @@ -642,7 +642,11 @@ fi
>  python_usable=3Dfalse
>  if $PYTHON -c 'import sys; sys.exit(0 if sys.version_info >=3D (3,6) els=
e 1)'
>  then
> -    python_usable=3Dtrue
> +    # Our python framework also requires virtio-blk
> +    if "$QEMU_PROG" -M none -device help | grep -q virtio-blk >/dev/null=
 2>&1
> +    then
> +        python_usable=3Dtrue
> +    fi
>  fi
> =20
>  default_machine=3D$($QEMU_PROG -machine help | sed -n '/(default)/ s/ .*=
//p')
> @@ -830,7 +834,7 @@ do
>                  run_command=3D"$PYTHON $seq"
>              else
>                  run_command=3D"false"
> -                echo "Unsupported Python version" > $seq.notrun
> +                echo "Unsupported Python version or missing virtio-blk" =
> $seq.notrun

A $python_unusable_because might be helpful (set in to-be-added else
branches for the ifs that set python_usable to true), but either way:

Reviewed-by: Max Reitz <mreitz@redhat.com>

>              fi
>          else
>              run_command=3D"./$seq"
>=20



--boXHdJXwVtdIlZr5t7A5xBMGHT4saPLHv--

--L8CJ4Do4K5q6w0AsTtwzklu8wVxqHqNug
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl4lviMACgkQ9AfbAGHV
z0AEmwf/Q+Fhq7HcaDXgu++Joa2NcKEmg4SUL7c3u4bGxZgBLICXLC2yBUaAoflI
3XjIMmOK+TfiWOBzn+rqpPF64xLgYv8+v5Ug91hNza8Rih1n5KsO5VlkIxSaKiVy
u/V2dTBM3PX1/ray2VenY1pQqPlmiGlWQLK+YzyLo7cLaHBQPugtP2bd/XOlIi/m
+NppPpJvJRNm+NzLlDuBHYOdrnDEPfNmMjMS/9MjZ/rTTfmm6cvo6PWWgFQ6D5Gb
7TyXvl1zyDtLho5XdKMyxeD8VYHmGAXCLAEaO6KOg0JVOsE0LCl9uPppfsc3my0y
SMOjXn85WwSXkaBVFkG86hiSzloijA==
=0T0v
-----END PGP SIGNATURE-----

--L8CJ4Do4K5q6w0AsTtwzklu8wVxqHqNug--


