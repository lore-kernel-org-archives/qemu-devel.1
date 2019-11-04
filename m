Return-Path: <SRS0=KlJF=Y4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26F38CA9EB5
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2019 14:26:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E41B721655
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2019 14:26:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XffIjR+u"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E41B721655
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33934 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iRdJ5-0002Mf-Vz
	for qemu-devel@archiver.kernel.org; Mon, 04 Nov 2019 09:26:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34023)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iRdIM-0001o0-Vb
 for qemu-devel@nongnu.org; Mon, 04 Nov 2019 09:25:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iRdIL-0007hX-Ta
 for qemu-devel@nongnu.org; Mon, 04 Nov 2019 09:25:26 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:43258
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1iRdIL-0007hH-QA
 for qemu-devel@nongnu.org; Mon, 04 Nov 2019 09:25:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1572877525;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=bYT6qNkwoPgsAgQMzR82q4QACe8jwocOUIR62APUmTM=;
 b=XffIjR+uu3RNO80+ydlYAQHlyrT5O1VlmlCTAGoIKK/8NDR0eKlGKMAby0JiX468OLxsjS
 yyZFSFSz93sOzSK0cJJmOcAU7COpynV9z8G1J4D7Pg21o4p4E9ddRjTiqXI782iDcvKJoL
 N9EMGo9+Lyuy4dkJxNip69P7JK5n7l4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-249-PGQZoerxPFiCzaghiSN3zQ-1; Mon, 04 Nov 2019 09:25:21 -0500
X-MC-Unique: PGQZoerxPFiCzaghiSN3zQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C4B43477;
 Mon,  4 Nov 2019 14:25:20 +0000 (UTC)
Received: from dresden.str.redhat.com (unknown [10.36.118.44])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 905BC5C28C;
 Mon,  4 Nov 2019 14:25:13 +0000 (UTC)
Subject: Re: [RFC 0/3] block/file-posix: Work around XFS bug
To: Alberto Garcia <berto@igalia.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>
References: <20191025095849.25283-1-mreitz@redhat.com>
 <02291bca-67d2-ed30-ac34-17641afbe397@virtuozzo.com>
 <d1b43c24-a443-dd19-6814-11eec43e943a@virtuozzo.com>
 <0f75cbcf-e6c7-c74c-972b-22e7760a8b5c@redhat.com>
 <w51r22nspqp.fsf@maestria.local.igalia.com>
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
Message-ID: <7ed9b8f0-2d8c-7bac-185e-9a1dd68fcce8@redhat.com>
Date: Mon, 4 Nov 2019 15:25:12 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <w51r22nspqp.fsf@maestria.local.igalia.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="HOgw5gOv6Ix7vsD8Q4aQlDnZLUxcyBffm"
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
Cc: Kevin Wolf <kwolf@redhat.com>, Anton Nefedov <anton.nefedov@virtuozzo.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--HOgw5gOv6Ix7vsD8Q4aQlDnZLUxcyBffm
Content-Type: multipart/mixed; boundary="goq2BfNGDZfCkuICjyY5FMAC5ENRli7AS"

--goq2BfNGDZfCkuICjyY5FMAC5ENRli7AS
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 04.11.19 15:03, Alberto Garcia wrote:
> On Fri 25 Oct 2019 04:19:30 PM CEST, Max Reitz wrote:
>>>> So, it's obvious that c8bb23cbdbe32f5c326 is significant for 1M
>>>> cluster-size, even on rotational disk, which means that previous
>>>> assumption about calling handle_alloc_space() only for ssd is wrong,
>>>> we need smarter heuristics..
>>>>
>>>> So, I'd prefer (1) or (2).
>>
>> OK.  I wonder whether that problem would go away with Berto=E2=80=99s su=
bcluster
>> series, though.
>=20
> Catching up with this now. I was told about this last week at the KVM
> Forum, but if the problems comes with the use of fallocate() and XFS,
> the I don't think subclusters will solve it.
>=20
> handle_alloc_space() is used to fill a cluster with zeroes when there's
> COW, and that happens the same with subclusters, just at the subcluster
> level instead of course.
>=20
> What can happen, if the subcluster size matches the filesystem block
> size, is that there's no need for any COW and therefore the bug is never
> triggered. But that's not quite the same as a fix :-)

No, what I meant was that the original problem that led to c8bb23cbdbe
would go away.

c8bb23cbdbe was added because small writes to new clusters are slow when
the clusters are large (because you need to do a 2 MB write on the host
for a 4 kB write from the guest).  So handle_alloc_space() was added to
alleviate the problem with a zero-write instead of actually writing zeroes.

The question is whether there is no need for handle_alloc_space() with
subclusters because a normal write with explicit zeroes being written in
the COW areas would be sufficiently quick.  (Because the subclusters for
2 MB clusters are just 64 kB in size.)

If that were so (right now it doesn=E2=80=99t look like it), we could rever=
t
c8bb23cbdbe and wouldn=E2=80=99t see the bug anymore.

Max

>> Maybe make a decision based both on the ratio of data size to COW area
>> length (only invoke handle_alloc_space() under a certain threshold),
>> and the absolute COW area length (always invoke it above a certain
>> threshold, unless the ratio doesn=E2=80=99t allow it)?
>=20
> Maybe combining that with the smaller clusters/subclusters can work
> around the problem. The maximum subcluster size is 64KB (for a 2MB
> cluster).
>=20
> Berto
>=20



--goq2BfNGDZfCkuICjyY5FMAC5ENRli7AS--

--HOgw5gOv6Ix7vsD8Q4aQlDnZLUxcyBffm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl3ANMgACgkQ9AfbAGHV
z0Csugf/aga9mCP61cERJ12b6eD7alUe2kpRy80fGPxTIMTPsbZQYgIa6z49sFQA
7yVBHSdz9PXkE89ITFnzgsHc1sywLZhoFVVSRYDj8vrUch8jCV/Tk95obYw2/EMM
qBjUKZC045VaxV5cAEi2FXhPr+Ef5tIvCjZG59OkhAAEKIhSZ37tEcP/gHIhfrn2
0GQIbEO9zJmX4CsZ5RIudqRxG02H6o2jodapVTjgWF1L0v3bxFURP1FPQZQKFHdV
zpSxbZ6t73s0aeCV+25thS7u1j1NHAsLXDaoyvhT7ecQKu2sXJXQhBbgWGVx3EFR
74/S0qRJXlVHFnAQphky/Q61A3RFEg==
=t2uW
-----END PGP SIGNATURE-----

--HOgw5gOv6Ix7vsD8Q4aQlDnZLUxcyBffm--


