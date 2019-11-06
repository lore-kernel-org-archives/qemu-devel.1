Return-Path: <SRS0=EylP=Y6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C070C5DF62
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2019 13:21:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3E4AC2084C
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2019 13:21:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="E7CiShad"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E4AC2084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58044 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iSLFr-00081v-Fk
	for qemu-devel@archiver.kernel.org; Wed, 06 Nov 2019 08:21:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39592)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iSLBi-0003aG-21
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 08:17:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iSLBf-0004CJ-VM
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 08:17:29 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:33250
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1iSLBf-0004Bv-PE
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 08:17:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573046247;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=8RcVF9GT/HQz7TxttFm6r3q1yurOdVMmBkH3g0JczOM=;
 b=E7CiShad6QVKQCvq/COrMLB9UR5Ga2B/rUfW4uDyuVxTUvu/fZL6jsWuGP97yTbBXYCVr8
 gwoY7tHEJ40uqIuGZYdrUeL7Sqcd/Ry0yIhqq6fHfjQNfviTPxd/D9yVbSeDpqHhsZZS3Z
 fNxy7fvGgmND0bVEYG7JmxjAclV0SsQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-171-oVqFT5gdM5S28C2ETyAvpA-1; Wed, 06 Nov 2019 08:17:25 -0500
X-MC-Unique: oVqFT5gdM5S28C2ETyAvpA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9BCF9477;
 Wed,  6 Nov 2019 13:17:24 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-117-212.ams2.redhat.com
 [10.36.117.212])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 86D8E5C240;
 Wed,  6 Nov 2019 13:17:22 +0000 (UTC)
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
Message-ID: <2bd155fe-af04-05f2-0bd4-28e844564fc4@redhat.com>
Date: Wed, 6 Nov 2019 14:17:20 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <396057714.35.1573045777293@webmail.proxmox.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="xBS0geUUVH9C7WUKt373MpYX0Z2qVPdMV"
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
Cc: Kevin Wolf <kwolf@redhat.com>, Stefan Hajnoczi <stefanha@gmail.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--xBS0geUUVH9C7WUKt373MpYX0Z2qVPdMV
Content-Type: multipart/mixed; boundary="3cDU4mMoT5fZ7s8WAlkF9QAhwxjY6qxfx"

--3cDU4mMoT5fZ7s8WAlkF9QAhwxjY6qxfx
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 06.11.19 14:09, Dietmar Maurer wrote:
>> Let me elaborate: Yes, a cluster size generally means that it is most
>> =E2=80=9Cefficient=E2=80=9D to access the storage at that size.  But the=
re=E2=80=99s a tradeoff.
>>  At some point, reading the data takes sufficiently long that reading a
>> bit of metadata doesn=E2=80=99t matter anymore (usually, that is).
>=20
> Any network storage suffers from long network latencies, so it always
> matters if you do more IOs than necessary.

Yes, exactly, that=E2=80=99s why I=E2=80=99m saying it makes sense to me to=
 increase the
buffer size from the measly 64 kB that we currently have.  I just don=E2=80=
=99t
see the point of increasing it exactly to the source cluster size.

>> There is a bit of a problem with making the backup copy size rather
>> large, and that is the fact that backup=E2=80=99s copy-before-write caus=
es guest
>> writes to stall. So if the guest just writes a bit of data, a 4 MB
>> buffer size may mean that in the background it will have to wait for 4
>> MB of data to be copied.[1]
>=20
> We use this for several years now in production, and it is not a problem.
> (Ceph storage is mostly on 10G (or faster) network equipment).

So you mean for cases where backup already chooses a 4 MB buffer size
because the target has that cluster size?

>> Hm.  OTOH, we have the same problem already with the target=E2=80=99s cl=
uster
>> size, which can of course be 4 MB as well.  But I can imagine it to
>> actually be important for the target, because otherwise there might be
>> read-modify-write cycles.
>>
>> But for the source, I still don=E2=80=99t quite understand why rbd has s=
uch a
>> problem with small read requests.  I don=E2=80=99t doubt that it has (as=
 you
>> explained), but again, how is it then even possible to use rbd as the
>> backend for a guest that has no idea of this requirement?  Does Linux
>> really prefill the page cache with 4 MB of data for each read?
>=20
> No idea. I just observed that upstream qemu backups with ceph are=20
> quite unusable this way.

Hm, OK.

Max


--3cDU4mMoT5fZ7s8WAlkF9QAhwxjY6qxfx--

--xBS0geUUVH9C7WUKt373MpYX0Z2qVPdMV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl3Cx+AACgkQ9AfbAGHV
z0AGAgf/f8kqrfinNvyCcJmGQBfyKVEDet1zy/5cyqVb8ysgw/CFMiEMdJuzXU+c
Q/Sg78wtEpzu1DkEVIVyc0gb6LGxdGpnwahj9DwgSWWsv7VrP98312i8i234LwoS
z5t2S8D6OgEFxygSOSevs13ZYhq7vEeLqcmtz2TWQXm8Zyh7wbYT6RyjmVbzijmd
LrsYcVn7aAJWAfkw64rjc/OiSI5Do8TqicjHGFuqmgBNHP1q5qc8spKkVtSVfVuv
ITZPh4VApkgXuJfL5+dcZlcLzZcRhK2t25wxJBogIa67N154yxGCldPfWzNjpe8u
U3FT0w1kjCyytEtOmMI4z8rUnHl9Ng==
=et8x
-----END PGP SIGNATURE-----

--xBS0geUUVH9C7WUKt373MpYX0Z2qVPdMV--


