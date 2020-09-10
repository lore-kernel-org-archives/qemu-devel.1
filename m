Return-Path: <SRS0=7f1Q=CT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85FD0C433E2
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 15:46:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EA9E12087C
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 15:46:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Sz7QaRm5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA9E12087C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47858 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kGOmO-0000Yg-S7
	for qemu-devel@archiver.kernel.org; Thu, 10 Sep 2020 11:46:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45830)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1kGOlD-0007vS-Rg
 for qemu-devel@nongnu.org; Thu, 10 Sep 2020 11:45:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:52074)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1kGOlC-0002mB-4d
 for qemu-devel@nongnu.org; Thu, 10 Sep 2020 11:45:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599752716;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=FU8kNfbiHhZqDHscFptLY7BzZVluEEh+JNkERSsvjoo=;
 b=Sz7QaRm5ZBFOokWqaB5XKCBKhoOZX0/zKIuEbmxbnoPMUkJemizWdotZ4GLFZCyRSmvMXi
 01BuNc/Pm3zUyZ8iCzDRZ3qHo3CXF7wb2x2cu61vRHGGfevhRsRPkqw/bELwJ2olvuxNgU
 2LTdDUptNVl8FY4+5VmS5Cgi0u0ribQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-290-duJY6d3lOnqsZl5moXtkYQ-1; Thu, 10 Sep 2020 11:45:12 -0400
X-MC-Unique: duJY6d3lOnqsZl5moXtkYQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0F91210BBEF6;
 Thu, 10 Sep 2020 15:45:12 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-112-197.ams2.redhat.com
 [10.36.112.197])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 309E719C4F;
 Thu, 10 Sep 2020 15:45:08 +0000 (UTC)
Subject: Re: [PATCH 28/29] iotests: Factor out qemu_tool_pipe_and_status()
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
References: <20200907182011.521007-1-kwolf@redhat.com>
 <20200907182011.521007-29-kwolf@redhat.com>
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
Message-ID: <923d2f06-36dc-9c97-af4c-e624f8bcb8ea@redhat.com>
Date: Thu, 10 Sep 2020 17:45:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200907182011.521007-29-kwolf@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mreitz@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="PaNVFNhECbAAiMruWoE9Prqwj2bPSkPFO"
Received-SPF: pass client-ip=63.128.21.124; envelope-from=mreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/10 09:16:38
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -56
X-Spam_score: -5.7
X-Spam_bar: -----
X-Spam_report: (-5.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-3.576, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--PaNVFNhECbAAiMruWoE9Prqwj2bPSkPFO
Content-Type: multipart/mixed; boundary="rwKpWj2vDN5Z9dfPo8YPYIZZkrz6LhcKP"

--rwKpWj2vDN5Z9dfPo8YPYIZZkrz6LhcKP
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 07.09.20 20:20, Kevin Wolf wrote:
> We have three almost identical functions that call an external process
> and return its output and return code. Refactor them into small wrappers
> around a common function.
>=20
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  tests/qemu-iotests/iotests.py | 50 +++++++++++++++++------------------
>  1 file changed, 24 insertions(+), 26 deletions(-)
>=20
> diff --git a/tests/qemu-iotests/iotests.py b/tests/qemu-iotests/iotests.p=
y
> index 64ccaf9061..6fed77487e 100644
> --- a/tests/qemu-iotests/iotests.py
> +++ b/tests/qemu-iotests/iotests.py
> @@ -90,21 +90,30 @@ luks_default_secret_object =3D 'secret,id=3Dkeysec0,d=
ata=3D' + \
>  luks_default_key_secret_opt =3D 'key-secret=3Dkeysec0'
> =20
> =20
> -def qemu_img_pipe_and_status(*args: str) -> Tuple[str, int]:
> +def qemu_tool_pipe_and_status(tool: str, *args: str,

If this is just an internal function not to be used outside of
iotests.py, I wonder if =E2=80=9Cargs: Sequence[str]=E2=80=9D wouldn=E2=80=
=99t be cleaner.

(Just because I feel like the *args notation is useful to provide a
nicer-looking external interface, but is somehow unclean, so I
personally avoid it unless it actually does make things look nicer.
Just a very personal feeling, though, of course.)

> +                              connect_stderr: bool =3D True) -> Tuple[st=
r, int]:
>      """
> -    Run qemu-img and return both its output and its exit code
> +    Run a tool and return both its output and its exit code
>      """
> -    subp =3D subprocess.Popen(qemu_img_args + list(args),
> +    stderr =3D subprocess.STDOUT if connect_stderr else None

I really despise this notation.  It=E2=80=99s like ternary operators in C
weren=E2=80=99t bad enough.

(Again with the personal feelings.  Sorry.)

Reviewed-by: Max Reitz <mreitz@redhat.com>


--rwKpWj2vDN5Z9dfPo8YPYIZZkrz6LhcKP--

--PaNVFNhECbAAiMruWoE9Prqwj2bPSkPFO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl9aSgIACgkQ9AfbAGHV
z0DD4QgAgRH9lpqde3NLhb6gw6t2v4jzZ28GCcKEPrX8Vv+hUBg9yxoGwfxAnlSP
xKyj68bo7upyVHDjbMR1vphr67q7koHFqxshJnr9NTmYVNG3BuEGDvCusodFyJlj
ASdFVeLFTTJdgUKHtWLcjPB0TtXVjydpjP1NIrtslEYVWqE6hgEL+8GbKzgvuuOD
E0Xf9XfTJbCM9l4cWiwp0vo8KnaUk/hnevO8cyHTh3GSQhoGPtvdXDODoQHBp7oJ
oI9RrqEVffGojSPGTeo2W3UaSqFo5qKEwt1Fr4pKYTP3Q6sbJKlNM2aqcATo+y8q
cRhecH+NB3NaOLzjJxrc4Xy8iuCwTA==
=wOhQ
-----END PGP SIGNATURE-----

--PaNVFNhECbAAiMruWoE9Prqwj2bPSkPFO--


