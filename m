Return-Path: <SRS0=/cID=ZR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2D92C432C0
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Nov 2019 13:51:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A36CE20740
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Nov 2019 13:51:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Zi6snizK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A36CE20740
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44240 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iZEmL-00041c-Pg
	for qemu-devel@archiver.kernel.org; Mon, 25 Nov 2019 08:51:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45862)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iZElN-00032i-2N
 for qemu-devel@nongnu.org; Mon, 25 Nov 2019 08:50:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iZElK-0008AV-Ng
 for qemu-devel@nongnu.org; Mon, 25 Nov 2019 08:50:47 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:52580
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1iZElK-00089k-4q
 for qemu-devel@nongnu.org; Mon, 25 Nov 2019 08:50:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574689845;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=z0ydHOdDILu9SPCRUsSTmVDSrbjn1adh/9Sv6XFHiwk=;
 b=Zi6snizKMI7yH/CfjAyeYiG0I9zfPBwy7UgLAuq2lbiBnWGfqum1O5RM5ZKMbxCT2QNoT/
 wYYNuwq/pQH4/HV9gzttkiG4OcblyEKCMU5DiALI3d5QIosjvrNbTeqBgIeerPl0+bi8nx
 UsTRKvgbIZYdEAGctw1U63zeJIAdO9o=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-38-XMlJ_diYNNOKXC_UKYqmnw-1; Mon, 25 Nov 2019 08:50:42 -0500
X-MC-Unique: XMlJ_diYNNOKXC_UKYqmnw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2FAFBA27F1;
 Mon, 25 Nov 2019 13:50:41 +0000 (UTC)
Received: from dresden.str.redhat.com (unknown [10.40.205.102])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 09F8C5D9CA;
 Mon, 25 Nov 2019 13:50:36 +0000 (UTC)
Subject: Re: [PATCH for-4.2 0/2] Fix bitmap migration
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org
References: <20191125125229.13531-1-vsementsov@virtuozzo.com>
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
Message-ID: <ceefa583-5fd0-4278-d7d0-bb07be6accb4@redhat.com>
Date: Mon, 25 Nov 2019 14:50:35 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191125125229.13531-1-vsementsov@virtuozzo.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="hTlsfihynbr58D4hKfpdiKClGGGaxXwYC"
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
Cc: kwolf@redhat.com, jsnow@redhat.com, qemu-devel@nongnu.org,
 qemu-stable@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--hTlsfihynbr58D4hKfpdiKClGGGaxXwYC
Content-Type: multipart/mixed; boundary="3fVHsdLHIZBXTpKg754NpYjqMinhMBLS7"

--3fVHsdLHIZBXTpKg754NpYjqMinhMBLS7
Content-Type: text/plain; charset=WINDOWS-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 25.11.19 13:52, Vladimir Sementsov-Ogievskiy wrote:
> Hi all!
>=20
> We've faced a bug in rhev-2.12.0-33.el7-based Qemu.
> In upstream, bug introduced in 4.0 by 74da6b943565c45
> "block/dirty-bitmaps: implement inconsistent bit" commit.
> At this commit we started to load inconsistent bitmap instead of
> silently ignoring them, and it now I see that it breaks migration.
>=20
> The fix is very simple, so I think it's OK for 4.2.. Still, it's not a
> degradation, so we may postpone it to 5.0.
>=20
> Vladimir Sementsov-Ogievskiy (2):
>   block/qcow2-bitmap: fix bitmap migration
>   iotests: add new test cases to bitmap migration
>=20
>  block/qcow2-bitmap.c       | 21 ++++++++++++++++++++-
>  tests/qemu-iotests/169     | 22 +++++++++++++++-------
>  tests/qemu-iotests/169.out |  4 ++--
>  3 files changed, 37 insertions(+), 10 deletions(-)

Reviewed-by: Max Reitz <mreitz@redhat.com>

Makes sense to me to put this into 4.2, but I don=92t think it would
survive Peter=92s check list. :?

(https://lists.nongnu.org/archive/html/qemu-block/2019-11/msg00807.html)

Max


--3fVHsdLHIZBXTpKg754NpYjqMinhMBLS7--

--hTlsfihynbr58D4hKfpdiKClGGGaxXwYC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl3b3CsACgkQ9AfbAGHV
z0DyDQgAnV++S44Zf52McIcd8xpwWzig5AY3YNLo6TeRg19F7Wx2YodsozLQm926
StCXOWPjsifT2GA8xndOI3crSYf0fUCqYjPfrY6FzdQw5XA9sruX/QbBhXkjlsXW
gJlzGEXaykCGo1Gx/a7FZJJKcuJqEx0bPFGs34I8W9WKH0BQ+aLmijNI5LjSknYc
0iEvbmN8Zlx74RN4FEYwCudcYmPqqD2dPTTUXlSDAnVuIJNzFudpdoYR1xJqBoBo
Edb8grh/z7cQx92ieX9f0TsvD5BhhJgSpVzNtDc/PrupVTuLkBhQg3q9xjDHq+zU
QERcldxE1he895ZHFWSBNM0B9yy2dA==
=3xDt
-----END PGP SIGNATURE-----

--hTlsfihynbr58D4hKfpdiKClGGGaxXwYC--


