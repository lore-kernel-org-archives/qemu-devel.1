Return-Path: <SRS0=KlJF=Y4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF9F4CA9ECF
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2019 08:31:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A9A2E21744
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2019 08:31:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="b1/Lh+HS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9A2E21744
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58458 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iRXmF-000870-Pp
	for qemu-devel@archiver.kernel.org; Mon, 04 Nov 2019 03:31:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58906)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iRXkT-0007FB-Qo
 for qemu-devel@nongnu.org; Mon, 04 Nov 2019 03:30:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iRXkR-0008A9-Ct
 for qemu-devel@nongnu.org; Mon, 04 Nov 2019 03:30:04 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:22286
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1iRXkQ-00087Y-LI
 for qemu-devel@nongnu.org; Mon, 04 Nov 2019 03:30:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1572856199;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=HArU7KEVxNwaOO6Xz7fkDkuljjFU1dAZC3rnjmnGzGY=;
 b=b1/Lh+HS++zE0afMw61sG6VJ3t9Hm3TKoVSILKbNLW56kQbY6kzGaf+NZZ5GtKtESLjzQB
 4C3sKC6qOrgsD+++kMVHN0i/O92+RJkiVP495dKIv3MLRr8VKN2OMkd1ddte4Ud89eAjlO
 rlfV6HztJ5Vl2EWzxe17Tin+kY9sDX8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-120-lXHu-cfOO6GDcU3K9sUuZA-1; Mon, 04 Nov 2019 03:29:55 -0500
X-MC-Unique: lXHu-cfOO6GDcU3K9sUuZA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A2214180496F;
 Mon,  4 Nov 2019 08:29:54 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-117-85.ams2.redhat.com
 [10.36.117.85])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 8A00D60C05;
 Mon,  4 Nov 2019 08:29:49 +0000 (UTC)
Subject: Re: [PATCH for-4.2 v2 0/3] qcow2: Fix data corruption on XFS
To: qemu-devel@nongnu.org
References: <157262333774.11413.7122618621068123723@37313f22b938>
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
Message-ID: <ff486ced-96f8-4bff-1452-42585bcfe502@redhat.com>
Date: Mon, 4 Nov 2019 09:29:47 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <157262333774.11413.7122618621068123723@37313f22b938>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="aDWzPDzCKuGIhuGmAp9zLdbqetjV9oarV"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: kwolf@redhat.com, anton.nefedov@virtuozzo.com, qemu-block@nongnu.org,
 qemu-stable@nongnu.org, vsementsov@virtuozzo.com, stefanha@redhat.com,
 den@openvz.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--aDWzPDzCKuGIhuGmAp9zLdbqetjV9oarV
Content-Type: multipart/mixed; boundary="KGm8Q4sVCXPG6zrsFo6w6xcrukgVWxOsw"

--KGm8Q4sVCXPG6zrsFo6w6xcrukgVWxOsw
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 01.11.19 16:48, no-reply@patchew.org wrote:
> Patchew URL: https://patchew.org/QEMU/20191101152510.11719-1-mreitz@redha=
t.com/
>=20
>=20
>=20
> Hi,
>=20
> This series failed the docker-quick@centos7 build test. Please find the t=
esting commands and
> their output below. If you have Docker installed, you can probably reprod=
uce it
> locally.
>=20
> =3D=3D=3D TEST SCRIPT BEGIN =3D=3D=3D
> #!/bin/bash
> make docker-image-centos7 V=3D1 NETWORK=3D1
> time make docker-test-quick@centos7 SHOW_ENV=3D1 J=3D14 NETWORK=3D1
> =3D=3D=3D TEST SCRIPT END =3D=3D=3D
>=20
>   TEST    check-qtest-x86_64: tests/ahci-test
>   TEST    check-unit: tests/test-aio-multithread
> test-aio-multithread: /tmp/qemu-test/src/util/async.c:283: aio_ctx_finali=
ze: Assertion `!qemu_lockcnt_count(&ctx->list_lock)' failed.
> ERROR - too few tests run (expected 6, got 2)
> make: *** [check-unit] Error 1
> make: *** Waiting for unfinished jobs....

This doesn=E2=80=99t seem related to this series and I can=E2=80=99t reprod=
uce it
locally, so I=E2=80=99ll just ignore it.

Max


--KGm8Q4sVCXPG6zrsFo6w6xcrukgVWxOsw--

--aDWzPDzCKuGIhuGmAp9zLdbqetjV9oarV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl2/4XsACgkQ9AfbAGHV
z0BcqwgAuKI/0aH9ilsMb2wudU7GwVXq5KvxkUwS9zFq5KIrP0XrYRnYJEl+gPp0
J44tO10xsXZW4MGPNe32gv7Z8rBPX7mrtlO1uR2UXIv9ZVAmkcuCTPWxDxdWrzbV
+YtZ34Bude8/36anvIFnwTbShn7c97QaFQZZv/V46koOVmLqkz4bBNLF1uC16CNU
eyU6W20vWevUXwLJVrjMZ6N4JvB2NK5A8irzop6L1Loyy/Nytlu1ZeG19LwRP8yU
xVoNvWvxwE0PAA6WMzTE4dngH00WHpkWC+tsZEeTkCuoa1M18wqJvrt9WuzaZwOI
P1YtIYgR1XPVv1XN3cAlH+atgmLpPg==
=E+mD
-----END PGP SIGNATURE-----

--aDWzPDzCKuGIhuGmAp9zLdbqetjV9oarV--


