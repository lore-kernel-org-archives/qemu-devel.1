Return-Path: <SRS0=ZRpO=43=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08B5CC10F27
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 13:47:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C9E2120637
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 13:47:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="g1AJgccq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C9E2120637
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33466 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBfE2-0002Aa-1e
	for qemu-devel@archiver.kernel.org; Tue, 10 Mar 2020 09:47:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42534)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1jBf9U-0002Xb-OI
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 09:42:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1jBf9S-0007rI-1Z
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 09:42:31 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:60874)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1jBf9Q-0007n1-8I
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 09:42:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583847746;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=KxLUBgrxM88Q1Nzsdfcb5tVk/cyez4wfetUgfza8qRs=;
 b=g1AJgccqH3Kxpu8xN/EO/Yjm8zDPcI1kEtXnf3peULZi9r/TEy4HSae4bKfYPNOO/Q6Kng
 gu9rrj6tfmclTOrDzT388fKqtKpFTi1zUI/ZredbiSRtM8w322dLOR/Ajo+DVb/4vgzuXp
 qdGZ0zHbch5oKayFQGMVVN7eMVFJ6tw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-4-yQR6KxZdPByMUEKVJLM8wg-1; Tue, 10 Mar 2020 09:42:24 -0400
X-MC-Unique: yQR6KxZdPByMUEKVJLM8wg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 503008017CC;
 Tue, 10 Mar 2020 13:42:22 +0000 (UTC)
Received: from dresden.str.redhat.com (unknown [10.36.118.149])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 902995D9C5;
 Tue, 10 Mar 2020 13:42:20 +0000 (UTC)
Subject: Re: [PATCH v3 3/9] block/block-copy: specialcase first copy_range
 request
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org
References: <20200306073831.7737-1-vsementsov@virtuozzo.com>
 <20200306073831.7737-4-vsementsov@virtuozzo.com>
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
Message-ID: <db130e8d-80dd-40f5-851c-faebe9baab3e@redhat.com>
Date: Tue, 10 Mar 2020 14:42:18 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200306073831.7737-4-vsementsov@virtuozzo.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="hLZYl1SZvMmVsaCqpn3qXmuiXE1MxOv4J"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: kwolf@redhat.com, andrey.shinkevich@virtuozzo.com, jsnow@redhat.com,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--hLZYl1SZvMmVsaCqpn3qXmuiXE1MxOv4J
Content-Type: multipart/mixed; boundary="AvBcarpGR50kdICRidYOI2pu2CJUJ4paG"

--AvBcarpGR50kdICRidYOI2pu2CJUJ4paG
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 06.03.20 08:38, Vladimir Sementsov-Ogievskiy wrote:
> In block_copy_do_copy we fallback to read+write if copy_range failed.
> In this case copy_size is larger than defined for buffered IO, and
> there is corresponding commit. Still, backup copies data cluster by
> cluster, and most of requests are limited to one cluster anyway, so the
> only source of this one bad-limited request is copy-before-write
> operation.
>=20
> Further patch will move backup to use block_copy directly, than for
> cases where copy_range is not supported, first request will be
> oversized in each backup. It's not good, let's change it now.
>=20
> Fix is simple: just limit first copy_range request like buffer-based
> request. If it succeed, set larger copy_range limit.
>=20
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> Reviewed-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
> ---
>  block/block-copy.c | 41 +++++++++++++++++++++++++++++++----------
>  1 file changed, 31 insertions(+), 10 deletions(-)

Reviewed-by: Max Reitz <mreitz@redhat.com>


--AvBcarpGR50kdICRidYOI2pu2CJUJ4paG--

--hLZYl1SZvMmVsaCqpn3qXmuiXE1MxOv4J
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl5nmToACgkQ9AfbAGHV
z0CN1AgAiQoFHNl3CcUY49lsmx55Zw4MyZxYKJFsr1W4FAfuEotN9A3fOb0hcMIx
mYSfipooXBwKfrKNBON5Y/8TSQO1abKksfiuCNj4GN5FYp3dAF1wdNXq/fhir94F
5lzmkISRlwxU1I3dZNZoe09ifYD2OLd4BQ9fU0hN623KPmefOcZwsjLsE/+5A/rS
IAUI14cQAV7W9WTQet6sAGAT6ip46QS0cnrLKvO8xvm3nGFRSIJZWVJn7H6v3dsS
5SGih7jVZS24YLSdf7YtEldAqYM0YQ3/3gSbCbWfyYB+2KyfF6XlfB52FZ5vyjnh
mAmAXUaV1EhA4AceilhKK0xOO9+8xA==
=bvrg
-----END PGP SIGNATURE-----

--hLZYl1SZvMmVsaCqpn3qXmuiXE1MxOv4J--


