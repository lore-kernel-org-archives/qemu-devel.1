Return-Path: <SRS0=EylP=Y6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08424C5DF62
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2019 13:53:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 798AB214D8
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2019 13:53:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fhvL1GC5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 798AB214D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58986 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iSLkz-0001Ew-2k
	for qemu-devel@archiver.kernel.org; Wed, 06 Nov 2019 08:53:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50461)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iSLjL-0008RY-97
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 08:52:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iSLjJ-0007WX-E5
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 08:52:14 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:33668
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1iSLjJ-0007VX-9z
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 08:52:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573048332;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=j4ecUeMVvSGpqywuUZjbOBenlTrq7xK7Z2eTYItQv1Q=;
 b=fhvL1GC5bZwgwVtCGgvo7O3aF38jCtSYGHbkSxZ9X09VQOulgM4PIOJ5PT2erBWkHHTVsw
 ndVUxoQyNipuKAEdf2p3lK1tYGcAGiojn+7Sg/rRTX/WRGeyYn6u72lw3BSpIB6qYSF7WM
 slqNMgtx5fTQ4wu00V0nTdhLzNrI+s4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-412-NrskjCHGMHmOUDp7N8OjVQ-1; Wed, 06 Nov 2019 08:52:09 -0500
X-MC-Unique: NrskjCHGMHmOUDp7N8OjVQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F41D61800D53;
 Wed,  6 Nov 2019 13:52:07 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-117-212.ams2.redhat.com
 [10.36.117.212])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 60C4D60F8A;
 Wed,  6 Nov 2019 13:52:05 +0000 (UTC)
Subject: Re: backup_calculate_cluster_size does not consider source
To: Dietmar Maurer <dietmar@proxmox.com>,
 Wolfgang Bumiller <w.bumiller@proxmox.com>
References: <1767781109.66.1572948164492@webmail.proxmox.com>
 <20191106083222.GA189998@stefanha-x1.localdomain>
 <ac30110f-6abe-a144-2aa5-b1cc140d7e8c@redhat.com>
 <20191106103450.cafwk7m5xd5eulxo@olga.proxmox.com>
 <37f72cb7-7085-3c40-7728-e41d59137b3b@redhat.com>
 <1868807950.27.1573039080274@webmail.proxmox.com>
 <eb3a232d-6567-1816-b7fc-121770aa42b4@redhat.com>
 <6684852e-da7d-13b2-f226-1c0074e4ab3b@redhat.com>
 <396057714.35.1573045777293@webmail.proxmox.com>
 <2bd155fe-af04-05f2-0bd4-28e844564fc4@redhat.com>
 <1098165569.40.1573047245058@webmail.proxmox.com>
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
Message-ID: <62bb451e-6b8a-d842-e07c-9f78a6971450@redhat.com>
Date: Wed, 6 Nov 2019 14:52:03 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <1098165569.40.1573047245058@webmail.proxmox.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="Lpsgh7rRSgpOeBjYODGB10gn03uyUqGuW"
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
--Lpsgh7rRSgpOeBjYODGB10gn03uyUqGuW
Content-Type: multipart/mixed; boundary="vHu5uIYB1yeVaGFkYDv8m47LIHQwfsTjW"

--vHu5uIYB1yeVaGFkYDv8m47LIHQwfsTjW
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 06.11.19 14:34, Dietmar Maurer wrote:
>=20
>> On 6 November 2019 14:17 Max Reitz <mreitz@redhat.com> wrote:
>>
>> =20
>> On 06.11.19 14:09, Dietmar Maurer wrote:
>>>> Let me elaborate: Yes, a cluster size generally means that it is most
>>>> =E2=80=9Cefficient=E2=80=9D to access the storage at that size.  But t=
here=E2=80=99s a tradeoff.
>>>>  At some point, reading the data takes sufficiently long that reading =
a
>>>> bit of metadata doesn=E2=80=99t matter anymore (usually, that is).
>>>
>>> Any network storage suffers from long network latencies, so it always
>>> matters if you do more IOs than necessary.
>>
>> Yes, exactly, that=E2=80=99s why I=E2=80=99m saying it makes sense to me=
 to increase the
>> buffer size from the measly 64 kB that we currently have.  I just don=E2=
=80=99t
>> see the point of increasing it exactly to the source cluster size.
>>
>>>> There is a bit of a problem with making the backup copy size rather
>>>> large, and that is the fact that backup=E2=80=99s copy-before-write ca=
uses guest
>>>> writes to stall. So if the guest just writes a bit of data, a 4 MB
>>>> buffer size may mean that in the background it will have to wait for 4
>>>> MB of data to be copied.[1]
>>>
>>> We use this for several years now in production, and it is not a proble=
m.
>>> (Ceph storage is mostly on 10G (or faster) network equipment).
>>
>> So you mean for cases where backup already chooses a 4 MB buffer size
>> because the target has that cluster size?
>=20
> To make it clear. Backups from Ceph as source are slow.

Yep, but if the target would be another ceph instance, the backup buffer
size would be chosen to be 4 MB (AFAIU), so I was wondering whether you
are referring to this effect, or to...

> That is why we use a patched qemu version, which uses:
>=20
> cluster_size =3D Max_Block_Size(source, target)

...this.

The main problem with the stall I mentioned is that I think one of the
main use cases of backup is having a fast source and a slow (off-site)
target.  In such cases, I suppose it becomes annoying if some guest
writes (which were fast before the backup started) take a long time
because the backup needs to copy quite a bit of data to off-site storage.

(And blindly taking the source cluster size would mean that such things
could happen if you use local qcow2 files with 2 MB clusters.)


So I=E2=80=99d prefer decoupling the backup buffer size and the bitmap
granularity, and then set the buffer size to maybe the MAX of source and
target cluster sizes.  But I don=E2=80=99t know when I can get around to do=
 that.

And then probably also cap it at 4 MB or 8 MB, because that happens to
be what you need, but I=E2=80=99d prefer for it not to use tons of memory. =
 (The
mirror job uses 1 MB per request, for up to 16 parallel requests; and
the backup copy-before-write implementation currently (on master) copies
1 MB at a time (per concurrent request), and the whole memory usage of
backup is limited at 128 MB.)

(OTOH, the minimum should probably be 1 MB.)

Max


--vHu5uIYB1yeVaGFkYDv8m47LIHQwfsTjW--

--Lpsgh7rRSgpOeBjYODGB10gn03uyUqGuW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl3C0AMACgkQ9AfbAGHV
z0BoCAgAt6CZ96vbsSMNlGzzZiOVbQpnMeGCED91gpsXv2+lDPwe+tMGZOvFT3Se
3Iipp0OpCleDwuyfuOIj/KB0plQUb1oqLt8yOQxdAY13aX0NFZosiB4Mj2mHquyK
i6S2NYZQb0dWVZxGs1AolUY6Hu53QZTP9qAaDXnLsw13yNqbHffC7nFKRB0sIL7C
eBRsL4iL3B2Py25J/jLJvP+rkvi3iBaj7/Fh2BSneJ6cbUrRHSL7tNVZ4AnDNKX7
K59JPLxZvtu3nhGBpjrUVo0MkP0vv9RuAecuAbEM2EVoICO12K9hgdpRv5ujlJLL
dy5Amk8VOkfnsuL6pam4UMK1bgMTWA==
=Xkrc
-----END PGP SIGNATURE-----

--Lpsgh7rRSgpOeBjYODGB10gn03uyUqGuW--


