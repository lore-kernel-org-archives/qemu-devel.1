Return-Path: <SRS0=WkHy=5I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FA05C4332B
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2020 14:12:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E698620714
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2020 14:12:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="feq4DhnM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E698620714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34348 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jGNoy-0002mW-29
	for qemu-devel@archiver.kernel.org; Mon, 23 Mar 2020 10:12:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37628)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1jGNoN-0002Jf-Hc
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 10:12:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1jGNoM-0004Yn-FY
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 10:12:15 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:51192)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1jGNoM-0004Y6-Bv
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 10:12:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584972733;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=bAd6n+BhkPJ679K74G3GoWkpGejCtlQchhtOsoCXE60=;
 b=feq4DhnMId/iVhNg9muaCcwFpThedowKAWIv6H1DCiTw0Up94req7at9Q6BMvufdrmbJfC
 l0vnBwhc32mnndoat6xfudBXRgFL3rwTEmHOeu9LlmPPuAye2ey1p56hYqq1uyb7kl8vyI
 hCwutKYBmA4e9/JlPGiivAy6rX5qc2c=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-406-ErXrBDJiPKOcADTBl2GGpw-1; Mon, 23 Mar 2020 10:12:01 -0400
X-MC-Unique: ErXrBDJiPKOcADTBl2GGpw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 080BD800D54;
 Mon, 23 Mar 2020 14:12:00 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-114-242.ams2.redhat.com
 [10.36.114.242])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 9629710002A7;
 Mon, 23 Mar 2020 14:11:58 +0000 (UTC)
Subject: Re: [PATCH 0/2] zero pointer after bdrv_unref_child
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org
References: <20200316060631.30052-1-vsementsov@virtuozzo.com>
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
Message-ID: <acdd5ae5-e384-e896-adf6-7ed0621c6a30@redhat.com>
Date: Mon, 23 Mar 2020 15:11:56 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200316060631.30052-1-vsementsov@virtuozzo.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="v7oVOJ5zz0VCAqRYPB3dZXX5tAi8iPSOP"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 63.128.21.74
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
Cc: kwolf@redhat.com, den@openvz.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--v7oVOJ5zz0VCAqRYPB3dZXX5tAi8iPSOP
Content-Type: multipart/mixed; boundary="3LGuz0bAnEVzbQJ4I9oXd304RYmIzSrNA"

--3LGuz0bAnEVzbQJ4I9oXd304RYmIzSrNA
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 16.03.20 07:06, Vladimir Sementsov-Ogievskiy wrote:
> Hi all!
>=20
> I faced use-after-free of bs->backing pointer after bdrv_unref_child in
> bdrv_set_backing_hd.
>=20
> Fix it, and do similar thing for s->data_file in qcow2.c.
>=20
> I'm not sure that this is the full fix. Is it safe to keep bs->backing
> during bdrv_unref_child itself? Is it safe to keep bs->backing during
> all-child-unref loop in bdrv_close?
>=20
>=20
> Vladimir Sementsov-Ogievskiy (2):
>   block: bdrv_set_backing_bs: fix use-after-free
>   block/qcow2: zero data_file child after free

Thanks, applied to my block branch:

https://git.xanclic.moe/XanClic/qemu/commits/branch/block

Max


--3LGuz0bAnEVzbQJ4I9oXd304RYmIzSrNA--

--v7oVOJ5zz0VCAqRYPB3dZXX5tAi8iPSOP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl54w6wACgkQ9AfbAGHV
z0BZKwf+NH153r7tZScCe/W4AtPEX7f0t9AbTQeDqK8kQsLKYGCfm8yP8X4YddlR
jqc0lW+qCLSrhDLnwXX5n6gxptcCO2U7jQ2h2bRK45OpKMT2EBq3LfgzBpy31eUZ
KVF6JWjp8KwpA7tGmGEtD4TXL5BMeCHPPBD3FslYbhxy5lrLwBr6FuYg9ly2p1zs
FyYniaKd3/8jsaVOq5E1d1KJ+oxj5MtQOsF5dFo1Rdz/6cQU+XMa1vQpHw/FaVQ5
HVUMg0m6OJR6rmyiOxiRsMpr/q7tA/To6DQULPnnEAFAVqZeLZSVHdK90w5AqKJt
RFubPqlY2vsRDq3hO8+GCnNMFS8BLA==
=2A2t
-----END PGP SIGNATURE-----

--v7oVOJ5zz0VCAqRYPB3dZXX5tAi8iPSOP--


