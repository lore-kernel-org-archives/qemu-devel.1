Return-Path: <SRS0=m554=56=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11342C2BA19
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Apr 2020 10:14:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C699920644
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Apr 2020 10:14:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="I/8PXMxJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C699920644
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55348 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jOIa8-0007pz-0c
	for qemu-devel@archiver.kernel.org; Tue, 14 Apr 2020 06:14:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35902)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1jOIZI-0007L1-KO
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 06:13:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1jOIZG-0007sT-De
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 06:13:24 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:24089
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1jOIZG-0007s4-7K
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 06:13:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1586859201;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=Y8GRkFNFkAqN8Im08tlNdelYZf0HImJRdIMRifPfXAs=;
 b=I/8PXMxJYAXYz0rNq+fwOVInIl+CB/Cgzj3AZls5HN3Q/J0rn8njsVSab3qsgMuhZaDbh5
 kE1UhKIPzkGKcrGfp6n69cTDAhRJ5DMuExFxHdc1a4Wk1n8YCrp2O338erl9sEsaHA88Cp
 zrlZPcSn2Cg4MEAcqCtmh5O9t4ClC0s=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-487-qHRMyVgXO8Wf1oUNLH5ozA-1; Tue, 14 Apr 2020 06:13:16 -0400
X-MC-Unique: qHRMyVgXO8Wf1oUNLH5ozA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D7881800D53;
 Tue, 14 Apr 2020 10:13:14 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-114-186.ams2.redhat.com
 [10.36.114.186])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 3DA6010016DA;
 Tue, 14 Apr 2020 10:13:11 +0000 (UTC)
Subject: Re: [PATCH v4 20/30] qcow2: Add subcluster support to
 discard_in_l2_slice()
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
References: <cover.1584468723.git.berto@igalia.com>
 <99b45e3beb4a38b17eb50fcde1e09cdefdb99724.1584468723.git.berto@igalia.com>
 <4b3b1ef4-2f8b-b16f-3c48-2ba6137763e4@redhat.com>
 <w51k12n5wyp.fsf@maestria.local.igalia.com>
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
Message-ID: <58cf9489-057d-429a-8445-cfdffadfa4af@redhat.com>
Date: Tue, 14 Apr 2020 12:13:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <w51k12n5wyp.fsf@maestria.local.igalia.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="PzX1DbnhCrEYQUD0b3DWgzXplC7ZKAP5F"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 207.211.31.120
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
--PzX1DbnhCrEYQUD0b3DWgzXplC7ZKAP5F
Content-Type: multipart/mixed; boundary="OgAnbGdHtoUU1o7iYoXCBEbiMDcSi80Xz"

--OgAnbGdHtoUU1o7iYoXCBEbiMDcSi80Xz
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 10.04.20 14:47, Alberto Garcia wrote:
> On Thu 09 Apr 2020 12:05:12 PM CEST, Max Reitz wrote:
>>>          switch (qcow2_get_cluster_type(bs, old_l2_entry)) {
>>>          case QCOW2_CLUSTER_UNALLOCATED:
>>> -            if (full_discard || !bs->backing) {
>>> +            if (full_discard) {
>>> +                /* If the image has extended L2 entries we can only
>>> +                 * skip this operation if the L2 bitmap is zero. */
>>> +                uint64_t bitmap =3D has_subclusters(s) ?
>>> +                    get_l2_bitmap(s, l2_slice, l2_index + i) : 0;
>>
>> Isn=E2=80=99t this bitmap only valid for standard clusters?  In this cas=
e, the
>> whole cluster is unallocated, so the bitmap shouldn=E2=80=99t be relevan=
t,
>> AFAIU.
>=20
> I'm not sure if I follow you.
>=20
> An unallocated cluster can still have QCOW_OFLAG_SUB_ZERO set in some of
> its subclusters. Those read as zeroes and the rest go to the backing
> file.

Hm, right, this is the only way to have non-preallocated zero clusters
after all.

I suppose I read the spec wrong and assumed somehow that unallocated
clusters don=E2=80=99t use =E2=80=9Cstandard cluster descriptors=E2=80=9D, =
so their bitmap usage
would be undefined.  Don=E2=80=99t know how that happened.

> After a full discard all subclusters should be completely deallocated so
> those bits should be cleared.
>=20
> If the bitmap is already 0 (the whole cluster is already unallocated) or
> if the image does not have extended L2 entries (which also means that
> the whole cluster is already unallocated) then we can skip the discard.

Yep, seems right.

Reviewed-by: Max Reitz <mreitz@redhat.com>


--OgAnbGdHtoUU1o7iYoXCBEbiMDcSi80Xz--

--PzX1DbnhCrEYQUD0b3DWgzXplC7ZKAP5F
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl6VjLUACgkQ9AfbAGHV
z0AmHAf/Qm/cktZ7C4ETFe3osU2oHgTs1oQvfXFxt39VBOdFetsXhSXm1wwOOBUL
BDzxBEtFICOQ+uNSo7+BYv0P+V2lRMVtKouTDvY5+eWwCjxJHxsK9V2R6keMzrZr
FURdr60mXKElOBpMJIldKbHOzc+NmhSaBcfEYGyIeUGpsezsdXAurjAw6sb5dPaP
lKKjriKF7pIdaOMjEcJ44i46vRdS4poK0Gs/Z8H9FVMnSivEdP3e0UWHxw5SzANF
NJ/baEm/aGQbd2YPX8wLOwm9t2fpRPcH2j+5bADdgcNx7o2/mazQAlOXoUCSD0HG
avYPaXlLZVCz0X8lBUDWh2hlwwlNrg==
=y6GW
-----END PGP SIGNATURE-----

--PzX1DbnhCrEYQUD0b3DWgzXplC7ZKAP5F--


