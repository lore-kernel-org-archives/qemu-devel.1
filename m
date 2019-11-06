Return-Path: <SRS0=EylP=Y6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2A2CC5DF62
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2019 11:50:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 926CD2173E
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2019 11:50:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VzhQlPLp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 926CD2173E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56590 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iSJp6-0006AJ-5v
	for qemu-devel@archiver.kernel.org; Wed, 06 Nov 2019 06:50:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39393)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iSJdE-00017x-Ts
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 06:37:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iSJdD-0001jb-Ks
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 06:37:48 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:49578
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1iSJdD-0001iQ-En
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 06:37:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573040266;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=0YRD5odyFHW/1AFgcGYcoJz5vnwVdolMeUZvDDwByr4=;
 b=VzhQlPLpbYZug2FokdRDw7huNzmK/UB/ATwa1ci22ZKhqZ+cM14t+0vS0qOBXne6YIVoAT
 FkDe6sbTxvToni00zKjiAgFK7QyX1CuspkU9u6/1SJDGykVUAVUx2Ze4YWTrxCqs7Upanb
 9bV0viOkmIpQyVwrvU1P8669UBsNcyM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-130-IVMRGOWdPJirFGEfU2DjrQ-1; Wed, 06 Nov 2019 06:37:42 -0500
X-MC-Unique: IVMRGOWdPJirFGEfU2DjrQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BA57B477;
 Wed,  6 Nov 2019 11:37:40 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-117-212.ams2.redhat.com
 [10.36.117.212])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A8E0560BF4;
 Wed,  6 Nov 2019 11:37:38 +0000 (UTC)
Subject: Re: backup_calculate_cluster_size does not consider source
From: Max Reitz <mreitz@redhat.com>
To: Dietmar Maurer <dietmar@proxmox.com>,
 Wolfgang Bumiller <w.bumiller@proxmox.com>
References: <1767781109.66.1572948164492@webmail.proxmox.com>
 <20191106083222.GA189998@stefanha-x1.localdomain>
 <ac30110f-6abe-a144-2aa5-b1cc140d7e8c@redhat.com>
 <20191106103450.cafwk7m5xd5eulxo@olga.proxmox.com>
 <37f72cb7-7085-3c40-7728-e41d59137b3b@redhat.com>
 <1868807950.27.1573039080274@webmail.proxmox.com>
 <eb3a232d-6567-1816-b7fc-121770aa42b4@redhat.com>
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
Message-ID: <6684852e-da7d-13b2-f226-1c0074e4ab3b@redhat.com>
Date: Wed, 6 Nov 2019 12:37:36 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <eb3a232d-6567-1816-b7fc-121770aa42b4@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="kYUh49cFw1nkL8MkyaWjtX82FJBlEDIpz"
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
Cc: Kevin Wolf <kwolf@redhat.com>, Stefan Hajnoczi <stefanha@gmail.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--kYUh49cFw1nkL8MkyaWjtX82FJBlEDIpz
Content-Type: multipart/mixed; boundary="PUYwGzJeDi0xP2akkEGbdkE1m4fcipuxd"

--PUYwGzJeDi0xP2akkEGbdkE1m4fcipuxd
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 06.11.19 12:22, Max Reitz wrote:
> On 06.11.19 12:18, Dietmar Maurer wrote:
>>> And if it issues a smaller request, there is no way for a guest device
>>> to tell it =E2=80=9COK, here=E2=80=99s your data, but note we have a wh=
ole 4 MB chunk
>>> around it, maybe you=E2=80=99d like to take that as well...?=E2=80=9D
>>>
>>> I understand wanting to increase the backup buffer size, but I don=E2=
=80=99t
>>> quite understand why we=E2=80=99d want it to increase to the source clu=
ster size
>>> when the guest also has no idea what the source cluster size is.
>>
>> Because it is more efficent.
>=20
> For rbd.

Let me elaborate: Yes, a cluster size generally means that it is most
=E2=80=9Cefficient=E2=80=9D to access the storage at that size.  But there=
=E2=80=99s a tradeoff.
 At some point, reading the data takes sufficiently long that reading a
bit of metadata doesn=E2=80=99t matter anymore (usually, that is).

There is a bit of a problem with making the backup copy size rather
large, and that is the fact that backup=E2=80=99s copy-before-write causes =
guest
writes to stall.  So if the guest just writes a bit of data, a 4 MB
buffer size may mean that in the background it will have to wait for 4
MB of data to be copied.[1]

Hm.  OTOH, we have the same problem already with the target=E2=80=99s clust=
er
size, which can of course be 4 MB as well.  But I can imagine it to
actually be important for the target, because otherwise there might be
read-modify-write cycles.

But for the source, I still don=E2=80=99t quite understand why rbd has such=
 a
problem with small read requests.  I don=E2=80=99t doubt that it has (as yo=
u
explained), but again, how is it then even possible to use rbd as the
backend for a guest that has no idea of this requirement?  Does Linux
really prefill the page cache with 4 MB of data for each read?

Max


[1] I suppose what we could do is decouple the copy buffer size from the
bitmap granularity, but that would be more work than just a MAX() in
backup_calculate_cluster_size().


--PUYwGzJeDi0xP2akkEGbdkE1m4fcipuxd--

--kYUh49cFw1nkL8MkyaWjtX82FJBlEDIpz
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl3CsIEACgkQ9AfbAGHV
z0AoSwf/d/Txdbo0pTIpvBTLg9otgjvgtyCSO5GviXlMGd6FjESajxRHeJXxD2aL
r9lBHV7r/fv8CBp2RTUKcbRQYHMlVW6g6clg/QIwEB8KrZdwk0piw7ZP8gQsIonP
UVdjjEL2YDe342NOGa9iZpRcMJDDdNgioPeGMp61IdodaOLCDozcOgHvAXRxiYYe
bh0/y2Z1Q7pXdGK5PZPrQ9NO/ub4alLwuNAx09r+VQjzQ13Pls/z+x+SZJayBLym
oND0yl5roH+TcFTQonFqIfsz/JTfVHBB+veg2O8kthYeZXGej8AgR4+t2ELmTUCi
E4t6Zw6vWcrw9zu3AhB8btJFbBwUJw==
=jFgU
-----END PGP SIGNATURE-----

--kYUh49cFw1nkL8MkyaWjtX82FJBlEDIpz--


