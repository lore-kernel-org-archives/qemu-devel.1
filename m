Return-Path: <SRS0=CnYV=4F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82470C34021
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 14:42:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 51B9120718
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 14:42:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Hh1BQyyl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 51B9120718
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46442 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j3hbF-0005t5-HE
	for qemu-devel@archiver.kernel.org; Mon, 17 Feb 2020 09:42:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36688)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1j3ha9-0004mM-3d
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 09:41:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1j3ha7-0004qt-3R
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 09:41:09 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:24442
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1j3ha6-0004qg-Vu
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 09:41:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581950466;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=ihNlt3W+yGft9+jKbkJoFbSjNEmCLhCnKpKoD8/UVtw=;
 b=Hh1BQyylRhJTD8xe6LjN+z2nBENUPM8bdTOGw8+Fy9BPZgwmc8a6lCSTXGpXwJbIfniPGL
 Z45ndEUaSp3GD/hnw+mqzY8aHZCYrWdTxEvCXx/EcFeXW0ZO1mIidYPbmpCvsUNbOane/0
 8DmJ3iknOmdOBeMaUOHEzYo721x5CT8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-63-_dA2GcmBOQSfefVxGGZpnQ-1; Mon, 17 Feb 2020 09:41:00 -0500
X-MC-Unique: _dA2GcmBOQSfefVxGGZpnQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0A93610CE784;
 Mon, 17 Feb 2020 14:40:59 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-117-191.ams2.redhat.com
 [10.36.117.191])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id EDB3A10001AE;
 Mon, 17 Feb 2020 14:40:56 +0000 (UTC)
Subject: Re: [PATCH v2 03/33] block: Add BdrvChildRole
To: Alberto Garcia <berto@igalia.com>, qemu-block@nongnu.org
References: <20200204170848.614480-1-mreitz@redhat.com>
 <20200204170848.614480-4-mreitz@redhat.com>
 <w51lfp9b07c.fsf@maestria.local.igalia.com>
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
Message-ID: <f574988c-e610-ba48-3256-f230e7a5a7e2@redhat.com>
Date: Mon, 17 Feb 2020 15:40:55 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <w51lfp9b07c.fsf@maestria.local.igalia.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="bAxUUpmp4cC8XZV8zYGBKfwMlj5FOezJH"
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--bAxUUpmp4cC8XZV8zYGBKfwMlj5FOezJH
Content-Type: multipart/mixed; boundary="3D4XAEo0K6xVyBDNujvb5OMbgg0vDFXk8"

--3D4XAEo0K6xVyBDNujvb5OMbgg0vDFXk8
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 11.02.20 16:41, Alberto Garcia wrote:
> On Tue 04 Feb 2020 06:08:18 PM CET, Max Reitz wrote:
>> +    /* Child to COW from (backing child) */
>> +    BDRV_CHILD_COW          =3D (1 << 3),
>=20
> Without the comment in brackets I'm not sure that I would have
> understood that this is meant for backing files.

I put it in brackets because bs->backing isn=92t always such a child (for
filters it isn=92t).  That=92s also the reason why I prefer to stress the
COW aspect.

> This is the "child that contains the data that is not allocated in the
> parent", or something like that, right?

Hm, so I suppose the problem is that I didn=92t describe in which event
the COW is to occur.  (I didn=92t because we only have one kind of COW in
the block layer, namely for backing chains.)

So maybe =93Child from which to read all data that isn=92t allocated in the
parent (backing child); such data may be copied to the parent by means
of COW or COR=94?

(The problem I see with this description is that it is kind of a
tautology, because =93allocation=94 is in turn defined by differentiating
between layers of a backing chain, i.e. this layer and that backing/COW
child we=92re talking about here.)

Max


--3D4XAEo0K6xVyBDNujvb5OMbgg0vDFXk8--

--bAxUUpmp4cC8XZV8zYGBKfwMlj5FOezJH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl5KpfcACgkQ9AfbAGHV
z0DEtggAsFlQMtEU09v7rRJlyADjKbUxeUaQ/bVP4mjx2LQ8nxhBhGexDre4F6vQ
hJ5KRoUrR3FTFGx9kFgXblEoiFuEK2AUlHhxHJkaGdpX/JFJS8jG+5Olp6MKkBpp
svCpcKJl3M8SktwkcTVSUOvLDAyjIIVsQzdHUh+4IaXTW4PEemnPJdTL9Nj9Yv8B
t9HK7oetvJuG0x/NWZr6HCQkSb1fevQ9kk9WOBPJh03IqAEzVlJfr6wLlwCKxvQ9
kzPrvuKjaAJs2YwtG3HQED0oKvrdrYs8Me9Nk2yhLSNpvUAJ24iPGQHv6kas3FNT
3vxAptuwZLD564+4CtwtpdFyDX78ZQ==
=WE9A
-----END PGP SIGNATURE-----

--bAxUUpmp4cC8XZV8zYGBKfwMlj5FOezJH--


