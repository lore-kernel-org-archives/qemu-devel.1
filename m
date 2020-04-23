Return-Path: <SRS0=5yua=6H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8062C54FCB
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2020 18:07:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9A27D20736
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2020 18:07:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aKIS7c0x"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A27D20736
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35456 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jRgGS-0007iV-D1
	for qemu-devel@archiver.kernel.org; Thu, 23 Apr 2020 14:07:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55966)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1jRgEa-0006NG-4x
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 14:06:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1jRgEU-0003fV-Rf
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 14:05:59 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:20299
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1jRgEU-0003NQ-Al
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 14:05:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1587665148;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=Q4R0XBImRqM9dElitjPjjcjBOM8voCLP7yWWpVOZl7A=;
 b=aKIS7c0xo+PvVFxwABzbqxQoyEbNsOAxfHhcZFrAzO2zL4DYQEtgO5fNSOeEH525Ol7KKM
 BQFhnME4DMKP3U0HpRW1DfenocwVIi+1Ox5UuPzmqKxtLJmz9qfLvRS9TSr/FBg+CBJLiK
 yJs5DQmxVybT2N5SCNNY63+7aXV38Xo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-199-xLChhKY4Pv6ySdVeQwewCg-1; Thu, 23 Apr 2020 14:05:46 -0400
X-MC-Unique: xLChhKY4Pv6ySdVeQwewCg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 03E90835B42;
 Thu, 23 Apr 2020 18:05:45 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-113-212.ams2.redhat.com
 [10.36.113.212])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id BE4A15D9CC;
 Thu, 23 Apr 2020 18:05:40 +0000 (UTC)
Subject: Re: [PATCH v6 10/10] qcow2: Forward ZERO_WRITE flag for full
 preallocation
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
References: <20200423150127.142609-1-kwolf@redhat.com>
 <20200423150127.142609-11-kwolf@redhat.com>
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
Message-ID: <af243df4-06ad-196c-b426-00fca75aabf2@redhat.com>
Date: Thu, 23 Apr 2020 20:05:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200423150127.142609-11-kwolf@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="aP6YmBds9is5xHVj8iaTIqVYfzIJ5pvEC"
Received-SPF: pass client-ip=207.211.31.81; envelope-from=mreitz@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/23 02:14:02
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
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
Cc: berto@igalia.com, vsementsov@virtuozzo.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--aP6YmBds9is5xHVj8iaTIqVYfzIJ5pvEC
Content-Type: multipart/mixed; boundary="dFJcVgFUHNvoPAVPGE7WZ29lequt9LwT8"

--dFJcVgFUHNvoPAVPGE7WZ29lequt9LwT8
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 23.04.20 17:01, Kevin Wolf wrote:
> The BDRV_REQ_ZERO_WRITE is currently implemented in a way that first the
> image is possibly preallocated and then the zero flag is added to all
> clusters. This means that a copy-on-write operation may be needed when
> writing to these clusters, despite having used preallocation, negating
> one of the major benefits of preallocation.
>=20
> Instead, try to forward the BDRV_REQ_ZERO_WRITE to the protocol driver,
> and if the protocol driver can ensure that the new area reads as zeros,
> we can skip setting the zero flag in the qcow2 layer.
>=20
> Unfortunately, the same approach doesn't work for metadata
> preallocation, so we'll still set the zero flag there.
>=20
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  block/qcow2.c              | 22 +++++++++++++++++++---
>  tests/qemu-iotests/274.out |  4 ++--
>  2 files changed, 21 insertions(+), 5 deletions(-)

Oh, nice.  I didn=E2=80=99t think you (or anyone else for that matter) woul=
d
actually do this. :)

With the errp thing fixed:

Reviewed-by: Max Reitz <mreitz@redhat.com>


--dFJcVgFUHNvoPAVPGE7WZ29lequt9LwT8--

--aP6YmBds9is5xHVj8iaTIqVYfzIJ5pvEC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl6h2PIACgkQ9AfbAGHV
z0CByAgAimMQMm5rSkaHprIQxHCexmF3aWtmBXwjUEbG+ZJM0e0a4913WF8K5+Dh
CC7T2k4XKFFA+KWIXOMA8IiaMLrwOo6QkePHoZdwXqebP/rqjlnE6sZytojLrsW5
ZI3gpjeUxA0l0C5T6LYLCkmNsa9PjNDPqUQcUBOWX06DfBIg+0Opw502H9M2XeOK
9yrQx0M4m1DhJFdc7qrNJSaep/vzux597Jl9RguyQPShmeROaTQU5k58PHQjNFF0
DMSi3rM1fNQgXNwpi2742N9Z6cezoAFxWmOovGavic/pnmnW2IBanXJxuVkbsw4f
NSFqLzv3KW5USW7FiGhIEbJnW90+mA==
=ARZl
-----END PGP SIGNATURE-----

--aP6YmBds9is5xHVj8iaTIqVYfzIJ5pvEC--


