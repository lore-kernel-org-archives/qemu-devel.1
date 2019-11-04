Return-Path: <SRS0=KlJF=Y4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01110CA9EB5
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2019 15:11:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C043D204FD
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2019 15:11:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VWkXVd6w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C043D204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34286 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iRe1N-0000rG-Ri
	for qemu-devel@archiver.kernel.org; Mon, 04 Nov 2019 10:11:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40019)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iRe0a-0000I8-7R
 for qemu-devel@nongnu.org; Mon, 04 Nov 2019 10:11:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iRe0Z-0001kt-8S
 for qemu-devel@nongnu.org; Mon, 04 Nov 2019 10:11:08 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:58719
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1iRe0Z-0001kf-4R
 for qemu-devel@nongnu.org; Mon, 04 Nov 2019 10:11:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1572880266;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=q6dUI9ixfa5/SZ2fMjH30EmgAJlj7fHOceHX1fZGQgE=;
 b=VWkXVd6wbcksDv9Z1xkItGULy3qAfc6FOYoNVtlwV5RLKGFwy+KzESZ6rj18Sa2rS1E3J7
 sT498DJnDpeQZ8VvSstWjLb0cQJnhp+/uxy/Hk5a76CNOv2hNt/8PRCzZL+UW/FIRXR1kD
 Cwqvg0FzSoP02ifHrrilFDgqYfdvuJI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-230-4s6g8IcYN62x51Jap2Oj0w-1; Mon, 04 Nov 2019 10:11:03 -0500
X-MC-Unique: 4s6g8IcYN62x51Jap2Oj0w-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AC182800C73;
 Mon,  4 Nov 2019 15:11:01 +0000 (UTC)
Received: from dresden.str.redhat.com (unknown [10.36.118.44])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D9FC65D9CD;
 Mon,  4 Nov 2019 15:10:59 +0000 (UTC)
Subject: Re: [RFC PATCH v2 15/26] qcow2: Add subcluster support to
 zero_in_l2_slice()
From: Max Reitz <mreitz@redhat.com>
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
References: <cover.1572125022.git.berto@igalia.com>
 <8f366482d2b273c26ff67cba1de898289f613fc7.1572125022.git.berto@igalia.com>
 <94b1434e-3e0f-bbce-0ba0-67309565bfec@redhat.com>
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
Message-ID: <3a42a341-367c-82b1-19c1-9ae2a9986de7@redhat.com>
Date: Mon, 4 Nov 2019 16:10:58 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <94b1434e-3e0f-bbce-0ba0-67309565bfec@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="7HVjwNGOvgOxZgJVGefUIXwfuFPJASSf0"
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
Cc: Kevin Wolf <kwolf@redhat.com>, Anton Nefedov <anton.nefedov@virtuozzo.com>,
 qemu-block@nongnu.org, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "Denis V . Lunev" <den@openvz.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--7HVjwNGOvgOxZgJVGefUIXwfuFPJASSf0
Content-Type: multipart/mixed; boundary="6WcQ6ERqlqVymcEUIlTuo9nJEEJJLYG1r"

--6WcQ6ERqlqVymcEUIlTuo9nJEEJJLYG1r
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 04.11.19 16:04, Max Reitz wrote:
> On 26.10.19 23:25, Alberto Garcia wrote:
>> Setting the QCOW_OFLAG_ZERO bit of the L2 entry is forbidden if an
>> image has subclusters. Instead, the individual 'all zeroes' bits must
>> be used.
>>
>> Signed-off-by: Alberto Garcia <berto@igalia.com>
>> ---
>>  block/qcow2-cluster.c | 14 ++++++++++----
>>  1 file changed, 10 insertions(+), 4 deletions(-)
>>
>> diff --git a/block/qcow2-cluster.c b/block/qcow2-cluster.c
>> index e67559152f..3e4ba8d448 100644
>> --- a/block/qcow2-cluster.c
>> +++ b/block/qcow2-cluster.c
>> @@ -1852,7 +1852,7 @@ static int zero_in_l2_slice(BlockDriverState *bs, =
uint64_t offset,
>>      assert(nb_clusters <=3D INT_MAX);
>> =20
>>      for (i =3D 0; i < nb_clusters; i++) {
>> -        uint64_t old_offset;
>> +        uint64_t old_offset, l2_entry =3D 0;
>>          QCow2ClusterType cluster_type;
>> =20
>>          old_offset =3D get_l2_entry(s, l2_slice, l2_index + i);
>> @@ -1869,12 +1869,18 @@ static int zero_in_l2_slice(BlockDriverState *bs=
, uint64_t offset,
>> =20
>>          qcow2_cache_entry_mark_dirty(s->l2_table_cache, l2_slice);
>>          if (cluster_type =3D=3D QCOW2_CLUSTER_COMPRESSED || unmap) {
>> -            set_l2_entry(s, l2_slice, l2_index + i, QCOW_OFLAG_ZERO);
>>              qcow2_free_any_clusters(bs, old_offset, 1, QCOW2_DISCARD_RE=
QUEST);
>=20
> It feels wrong to me to free the cluster before updating the L2 entry.

(Although it=E2=80=99s pre-existing, as set_l2_entry() is just an in-cache
operation anyway :-/)

Max


--6WcQ6ERqlqVymcEUIlTuo9nJEEJJLYG1r--

--7HVjwNGOvgOxZgJVGefUIXwfuFPJASSf0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl3AP4IACgkQ9AfbAGHV
z0CnvggAspZr9plc+5B9899jSAaCJM1S4eulKM/DAg2N6oNqxkZSa7Mg0Qmbpa7Y
U+v2V6aUZX08VBvKjp53MlNJEluCo4fhb8wFyyXKWELzmSYEDX7tIqUH4Qt6R8Lx
5RytTr11E30Iv91zQmVjo7oEYgVPtUptGUqQQKZYcNo/X0JWQ8gFf3ZIaL5/F19d
sBrOb7MCasG2Xt0BlmMW7sJuEKgq4MeRr8sGt0tBYdsHaXYzWxQRhoGLrsrX3Gmf
KcQNQ10a594NH4cXuMgMdSh4Z5Dj/TCcK74TmiHbNxjXYfFYaWcVl1axOgNAN2St
y2Pz9kiWqVDIyOa0epg0R8aADXscvQ==
=Pqxg
-----END PGP SIGNATURE-----

--7HVjwNGOvgOxZgJVGefUIXwfuFPJASSf0--


