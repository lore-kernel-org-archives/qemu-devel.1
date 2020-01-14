Return-Path: <SRS0=7MIY=3D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B361C33CB1
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2020 13:49:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 67A0A2187F
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2020 13:49:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Osh2GtEJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 67A0A2187F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40116 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1irMZ2-0000Sg-Di
	for qemu-devel@archiver.kernel.org; Tue, 14 Jan 2020 08:49:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50596)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1irMY6-0007wn-JZ
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 08:48:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1irMY5-0006bI-Le
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 08:48:02 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:59053
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1irMY5-0006bE-I9
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 08:48:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579009681;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=b2pC5EA9d8iJZMZB0JM9XMz66IsYxUBdGNfkhqeF1JA=;
 b=Osh2GtEJAsuX7kZxSWV9ZJyKA3ACyXkEhP8H+5sBd3h6Z4gTGmQ2Umtse+wzduENov9+Zc
 lkaHRClNS4jfZ8pBDe7zG0vjgRHQZB6LinaoDHsqqbXYL9JeQngEpxVsLkU2itTdiIxP+e
 tEF5lF6FThAG++PmK1Rhdin6UFb02Rk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-338-wSWxu34LOWmXZqoDWRf9qw-1; Tue, 14 Jan 2020 08:47:58 -0500
X-MC-Unique: wSWxu34LOWmXZqoDWRf9qw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0963618543A0;
 Tue, 14 Jan 2020 13:47:57 +0000 (UTC)
Received: from dresden.str.redhat.com (unknown [10.36.118.23])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 6263D60BF1;
 Tue, 14 Jan 2020 13:47:55 +0000 (UTC)
Subject: Re: [PATCH v2 1/4] qcow2: Require that the virtual size is a multiple
 of the sector size
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
References: <cover.1578596897.git.berto@igalia.com>
 <6a1cfcbb533b487bac96e1d2282ebf210954d27a.1578596897.git.berto@igalia.com>
 <bd6ca991-c2f7-0e27-5bee-07a7c53f8a8e@redhat.com>
 <w51v9peb2dz.fsf@maestria.local.igalia.com>
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
Message-ID: <9f7ab60c-c9d4-527b-55dd-40f487a36895@redhat.com>
Date: Tue, 14 Jan 2020 14:47:53 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <w51v9peb2dz.fsf@maestria.local.igalia.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="6kxAxSK8TyfKf9J2uIwsvox8nAoszvzDM"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.120
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
Cc: Kevin Wolf <kwolf@redhat.com>, Nir Soffer <nsoffer@redhat.com>,
 qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--6kxAxSK8TyfKf9J2uIwsvox8nAoszvzDM
Content-Type: multipart/mixed; boundary="2GnU9p1JsLgbeRLKf1g6Ds5ELNEMlPKIs"

--2GnU9p1JsLgbeRLKf1g6Ds5ELNEMlPKIs
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 14.01.20 14:20, Alberto Garcia wrote:
> On Tue 14 Jan 2020 02:01:03 PM CET, Max Reitz wrote:
>>> However when an image is opened the virtual size is rounded down,
>>> which means that trying to access the last few advertised bytes will
>>> result in an error. As seen above QEMU cannot create such images and
>>> there's no good use case that would require us to try to handle them
>>> so let's just treat them as unsupported.
>>
>> But isn=E2=80=99t that just a bug in qemu?
>=20
> Yes, but does it make sense to try to support images with unaligned
> sizes if no one is going to create them ever and QEMU cannot even
> generate them?

If nobody uses such images ever, isn=E2=80=99t the current code fine as-is?

Max


--2GnU9p1JsLgbeRLKf1g6Ds5ELNEMlPKIs--

--6kxAxSK8TyfKf9J2uIwsvox8nAoszvzDM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl4dxokACgkQ9AfbAGHV
z0Cn+wgAgGwEevZwgex7paMPQbOMyGfFoLZmA8v6v6o3Gc4fr5SADJLMi0O5jwxA
4dEEAsIR7ljnO+m3ckUufVLJKkqOwSOedM11HKdTANQ2K0Met+5YZGPe39NqEsID
+OwA/tWR1kv+4vHZAqItfhunQUhyy4eVMlpP9ymr0fND4R7mvQ/LC5UAlM1jvjIq
FywEfeKIAPWrqYsZAQVKR0maJTSRbYTMBMKcujX4w0K+Q2d+uexlMqEMegsv5Hhf
4PIxZtuOboQWsu6J6bUKPN+2JWpLqB/yaNZE5V++tseW5triimt6m4jhZz4jipQ8
A6pthd7lppMHCodFFAy1lnt1D4/GEA==
=kUA3
-----END PGP SIGNATURE-----

--6kxAxSK8TyfKf9J2uIwsvox8nAoszvzDM--


