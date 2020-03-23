Return-Path: <SRS0=WkHy=5I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0599AC4332B
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2020 13:36:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C46FC20735
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2020 13:35:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RLkVhl/q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C46FC20735
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33956 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jGNFG-0003SM-V7
	for qemu-devel@archiver.kernel.org; Mon, 23 Mar 2020 09:35:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60104)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1jGNDE-0000K3-HQ
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 09:33:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1jGNDB-0004wK-VX
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 09:33:51 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:22286)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1jGNDA-0004vW-1J
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 09:33:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584970426;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=KV5sDWjEBqaZiIvMoaAVIDhz898up8t7py+Rw6BijCs=;
 b=RLkVhl/qh3QjU2OdKgC/Z/4tmwOTW3dsjYVIMBh9O8Ju9zahXRMfT3dF3KF11yh223BsfI
 Nsi2Sra1t0MLQ1NvfzglVAJj1TkVGom/jcq0UmPfoFSn5M83TeyoaWOhaypx/fghSclO2o
 sUAuP979ZGq6gqRm4cW/GkMVSnaKFEs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-383-satjfPK9PPe0tu7XPVCYPw-1; Mon, 23 Mar 2020 09:33:40 -0400
X-MC-Unique: satjfPK9PPe0tu7XPVCYPw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C80D0477;
 Mon, 23 Mar 2020 13:33:38 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-114-242.ams2.redhat.com
 [10.36.114.242])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id DFAE25C1C7;
 Mon, 23 Mar 2020 13:33:36 +0000 (UTC)
Subject: Re: [PATCH] block: Avoid memleak on qcow2 image info failure
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
References: <20200320183620.1112123-1-eblake@redhat.com>
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
Message-ID: <c827e930-fa72-2bad-9261-8e7ceb809edb@redhat.com>
Date: Mon, 23 Mar 2020 14:33:34 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200320183620.1112123-1-eblake@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="8JgvpteqpcTPLf37UtCtm4KquaUfHDBLX"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 216.205.24.74
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
Cc: Kevin Wolf <kwolf@redhat.com>, peter.maydell@linaro.org,
 "open list:qcow2" <qemu-block@nongnu.org>, andrey.shinkevich@virtuozzo.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--8JgvpteqpcTPLf37UtCtm4KquaUfHDBLX
Content-Type: multipart/mixed; boundary="RXJS9tA9h937ZG6ydt1y41KfRTZFXLK1U"

--RXJS9tA9h937ZG6ydt1y41KfRTZFXLK1U
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 20.03.20 19:36, Eric Blake wrote:
> If we fail to get bitmap info, we must not leak the encryption info.
>=20
> Fixes: b8968c875f403
> Fixes: Coverity CID 1421894
> Signed-off-by: Eric Blake <eblake@redhat.com>
> ---
>  block/qcow2.c | 1 +
>  1 file changed, 1 insertion(+)

Thanks, applied to my block branch:

https://git.xanclic.moe/XanClic/qemu/commits/branch/block

Max


--RXJS9tA9h937ZG6ydt1y41KfRTZFXLK1U--

--8JgvpteqpcTPLf37UtCtm4KquaUfHDBLX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl54uq4ACgkQ9AfbAGHV
z0AC2wgAn4ABPGJY36y3gSh/jVrSXjGKqA5G0J/hY23gUH073x7EaMK2rzXCK5CC
T5xtLPJedVgEz5LDJGlkTEn4GbhNJBxMEz1hjf2eWqVM15cMO38Gg0IDcsJ+OOrd
qo3Khd54w5wiYxqVm58vtVS8UxWJghqlzDa/fuYNI/Y62zHSMMa5bjPTe8OTqI/d
Mn4HyVVL4kT9EW/+zXcKRnKq9Xxr0fpT67RQ0JuUPGvvwmpxb6XPM7kquG5NY0cR
2t5A5VB8Xhomof48RoOxUrdnYPXAriWRUwt+VGB78vg0E+PXtqIiM6X7F81lV1Kg
loIeZoMXp29OoKdweKloiw7skffAHQ==
=sOik
-----END PGP SIGNATURE-----

--8JgvpteqpcTPLf37UtCtm4KquaUfHDBLX--


