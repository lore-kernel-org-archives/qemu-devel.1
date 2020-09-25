Return-Path: <SRS0=+pSw=DC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27110C4727E
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 08:55:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9249720878
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 08:55:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AySFao3v"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9249720878
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45060 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLjVr-0003mY-LZ
	for qemu-devel@archiver.kernel.org; Fri, 25 Sep 2020 04:55:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53504)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1kLjV4-0002ys-B8
 for qemu-devel@nongnu.org; Fri, 25 Sep 2020 04:54:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:53233)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1kLjV2-0005fD-9w
 for qemu-devel@nongnu.org; Fri, 25 Sep 2020 04:54:42 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601024079;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=A+7yxh1Tms9k+Ads7rNdnGL9IW9pex+zDrAp6Khupow=;
 b=AySFao3vKbAB5jqCoE0fdBZRTewC1hv1QAqkZSjSOWMSG35LB6XwQK0MKWHhWjTAOn+j68
 52D/PM0+xequacpX4COBYFiNLLM1SYXoK6dpSqYNGUpKiCnGzUuarGIRaWhhkvRuKBX1lk
 TIlwZgTjl3LVxYa5R3gWG1PzKzzRuBM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-584-7yxF6e2aMq2qBYF9gl8JMg-1; Fri, 25 Sep 2020 04:54:37 -0400
X-MC-Unique: 7yxF6e2aMq2qBYF9gl8JMg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 16BBF807352;
 Fri, 25 Sep 2020 08:54:36 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-113-113.ams2.redhat.com
 [10.36.113.113])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id DAC925D9F1;
 Fri, 25 Sep 2020 08:54:30 +0000 (UTC)
Subject: Re: [PATCH v6 12/15] scripts/simplebench: support iops
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org
References: <20200918181951.21752-1-vsementsov@virtuozzo.com>
 <20200918181951.21752-13-vsementsov@virtuozzo.com>
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
Message-ID: <d212544e-696f-527f-bf49-9ad5c6cc0452@redhat.com>
Date: Fri, 25 Sep 2020 10:54:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200918181951.21752-13-vsementsov@virtuozzo.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mreitz@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="JyjLruSQwKwkgKnCpsMvSpLZCet60od6A"
Received-SPF: pass client-ip=63.128.21.124; envelope-from=mreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/25 01:07:33
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.199,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.214, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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
Cc: fam@euphon.net, kwolf@redhat.com, qemu-devel@nongnu.org, armbru@redhat.com,
 stefanha@redhat.com, den@openvz.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--JyjLruSQwKwkgKnCpsMvSpLZCet60od6A
Content-Type: multipart/mixed; boundary="lIMabEBjTZhadcnUP7GT1M2eY9SPDt9lP"

--lIMabEBjTZhadcnUP7GT1M2eY9SPDt9lP
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 18.09.20 20:19, Vladimir Sementsov-Ogievskiy wrote:
> Support benchmarks returning not seconds but iops. We'll use it for
> further new test.
>=20
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>  scripts/simplebench/simplebench.py | 35 +++++++++++++++++++++++-------
>  1 file changed, 27 insertions(+), 8 deletions(-)
>=20
> diff --git a/scripts/simplebench/simplebench.py b/scripts/simplebench/sim=
plebench.py
> index 59e7314ff6..716d7fe9b2 100644
> --- a/scripts/simplebench/simplebench.py
> +++ b/scripts/simplebench/simplebench.py

[...]

> @@ -34,6 +37,7 @@ def bench_one(test_func, test_env, test_case, count=3D5=
, initial_run=3DTrue):
> =20
>      Returns dict with the following fields:
>          'runs':     list of test_func results
> +        'dimension': dimension of results, may be 'seconds' or 'iops'
>          'average':  average seconds per run (exists only if at least one=
 run

s/seconds/value/ (or something like that)

>                      succeeded)
>          'delta':    maximum delta between test_func result and the avera=
ge
> @@ -54,11 +58,20 @@ def bench_one(test_func, test_env, test_case, count=
=3D5, initial_run=3DTrue):
> =20
>      result =3D {'runs': runs}
> =20
> -    successed =3D [r for r in runs if ('seconds' in r)]
> +    successed =3D [r for r in runs if ('seconds' in r or 'iops' in r)]
>      if successed:

((Pre-existing, but I feel the urge to point it that it should be
=E2=80=9Csucceeded=E2=80=9D.  (Or perhaps =E2=80=9Csuccesses=E2=80=9D.)

Sorry, not something that should be fixed here, but I just couldn=E2=80=99t
contain myself.))

> -        avg =3D sum(r['seconds'] for r in successed) / len(successed)
> +        dim =3D 'iops' if ('iops' in successed[0]) else 'seconds'

I think this line should be dropped, because it=E2=80=99s obsoleted by the
if-else that follows.

> +        if 'iops' in successed[0]:
> +            assert all('iops' in r for r in successed)
> +            dim =3D 'iops'
> +        else:
> +            assert all('seconds' in r for r in successed)
> +            assert all('iops' not in r for r in successed)
> +            dim =3D 'seconds'

Max


--lIMabEBjTZhadcnUP7GT1M2eY9SPDt9lP--

--JyjLruSQwKwkgKnCpsMvSpLZCet60od6A
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl9tsEUACgkQ9AfbAGHV
z0A84wgAmolqJYR2jti6hqs7QgiWqb2jGBviFNHKj802iOGAZ0zUIPTrPQZ9oAag
D0aYLdBFhR6E/B0NpQBXiUQizNwxOqib2dinjjUBcJudykT8TAPen6JufBvOWaMi
nX5vLTFUqNj1Ka0pHWTJtbHWKb7dcHg7mfBLNeDjufGvt4GSWrtg+xuGOtqpmWwR
1D3vwfr2UkuSM6Xm4eJ+dn6iVJJZaxMHajbmF3cII+MIqphg/Moxsgl+3eIaVvRO
rFkzEbcvhrWzygnOUoqbHV6U2JTCIq3HQgPldFeQ0WTmE5EIvgNQnkDsKfsOKZuq
ULUx3ABmsVaXdIOHJmH95SLZTNHzQQ==
=PdZH
-----END PGP SIGNATURE-----

--JyjLruSQwKwkgKnCpsMvSpLZCet60od6A--


