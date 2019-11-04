Return-Path: <SRS0=KlJF=Y4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BB7FCA9EB5
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2019 13:11:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E292921D7F
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2019 13:11:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Q0Tm3ajm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E292921D7F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60982 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iRc8q-0008QE-Qg
	for qemu-devel@archiver.kernel.org; Mon, 04 Nov 2019 08:11:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48927)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iRc8A-0007jS-K1
 for qemu-devel@nongnu.org; Mon, 04 Nov 2019 08:10:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iRc88-000115-VX
 for qemu-devel@nongnu.org; Mon, 04 Nov 2019 08:10:50 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:51285
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1iRc88-00010o-R2
 for qemu-devel@nongnu.org; Mon, 04 Nov 2019 08:10:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1572873048;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=zW2AmwPBEWpelVJwH+pS5LGu2VoVx5RRprJoNrYTqJM=;
 b=Q0Tm3ajmjYlT+ttHVG/+1AfDxe0IjmuhqkKIotstr9O162hXuEKPfg2oagnIExA58qGbH6
 YaamMLNQvk+L4+a4/4CK/FgRJRkarXwTQWpFQyLyVt+Hg87aI5Gw05qK2vMv1xye7Bu2iU
 ZQtaTEKt4xueBw4559AK7IbII47l4Fk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-270-MMUtVvoMPEq3yqlJZbG8hg-1; Mon, 04 Nov 2019 08:10:44 -0500
X-MC-Unique: MMUtVvoMPEq3yqlJZbG8hg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6D140477;
 Mon,  4 Nov 2019 13:10:43 +0000 (UTC)
Received: from dresden.str.redhat.com (unknown [10.36.118.44])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 7838066845;
 Mon,  4 Nov 2019 13:10:39 +0000 (UTC)
Subject: Re: [RFC PATCH v2 12/26] qcow2: Handle
 QCOW2_CLUSTER_UNALLOCATED_SUBCLUSTER
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
References: <cover.1572125022.git.berto@igalia.com>
 <2a6b34635cac78e76150a72c69669b3d9ec0fb8c.1572125022.git.berto@igalia.com>
 <78cc16f3-f8aa-9dcb-2389-4f6ed86080fd@redhat.com>
 <w51tv7jssjf.fsf@maestria.local.igalia.com>
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
Message-ID: <016246de-df5c-b2a3-2d2d-b99ff7277fc5@redhat.com>
Date: Mon, 4 Nov 2019 14:10:37 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <w51tv7jssjf.fsf@maestria.local.igalia.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="66TAlbECwqCH7Es4WmBW88kmGcFhi7kh3"
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
--66TAlbECwqCH7Es4WmBW88kmGcFhi7kh3
Content-Type: multipart/mixed; boundary="uY1LWWMP3NuCOLjKX4wpgd2gpaezDq2Qr"

--uY1LWWMP3NuCOLjKX4wpgd2gpaezDq2Qr
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 04.11.19 14:03, Alberto Garcia wrote:
> On Mon 04 Nov 2019 01:57:42 PM CET, Max Reitz wrote:
>> On 26.10.19 23:25, Alberto Garcia wrote:
>>> In the previous patch we added a new QCow2ClusterType named
>>> QCOW2_CLUSTER_UNALLOCATED_SUBCLUSTER. There is a couple of places
>>> where this new value needs to be handled, and that is what this patch
>>> does.
>>>
>>> Signed-off-by: Alberto Garcia <berto@igalia.com>
>>> ---
>>>  block/qcow2.c | 13 +++++++++----
>>>  1 file changed, 9 insertions(+), 4 deletions(-)
>> This patch deals with everything in qcow2.c.  There are more places that
>> reference QCOW2_CLUSTER_* constants elsewhere, and I suppose most of
>> them are handled by the following patches.
>>
>> But I wonder what the criterion is on where it needs to be handled and
>> where it=E2=80=99s OK not to.  Right now it looks to me like it=E2=80=99=
s a bit
>> arbitrary maybe?  But I suppose I=E2=80=99ll just have to wait until aft=
er the
>> next patches.
>=20
> This is the part of the series that I'm the least happy about, because
> the existing qcow2_get_cluster_type() can never return this new value, I
> only updated the cases where this can actually happen.
>=20
> I'm still considering a different approach for this.
I still don=E2=80=99t know what you=E2=80=99re doing in the later patches, =
but to me it
looks a bit like you don=E2=80=99t dare breaking up the existing structure =
that
just deals with clusters.

If that is so, I think it will help to make a clear cut between what
concerns subclusters and what concerns clusters at a whole.
QCOW2_CLUSTER_UNALLOCATED_SUBCLUSTER shouldn=E2=80=99t be in QCow2ClusterTy=
pe;
there should be a separate QCow2SubclusterType.

OTOH, that would require more modifications, but (na=C3=AFvely) I believe
that would make for the cleaner interface in the end.

Max


--uY1LWWMP3NuCOLjKX4wpgd2gpaezDq2Qr--

--66TAlbECwqCH7Es4WmBW88kmGcFhi7kh3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl3AI00ACgkQ9AfbAGHV
z0A9cAf+O7jCdCk/6bu5q+Ar5fttESiMmaRJIj7BSL7L3kUQL4V5Yxy79+3iU8OD
KHBKzzi166QLQXseYaDjPYV0RK6L2xa3QlgyNyjucFTvxZ4R5lMtZYSDvhvvwJxz
dNXcGJWziDRc7lJfPJXcKJlk6AlNn/y7nn7gC/cFNaI+t3MvXnYaW3bOpeKVEbOO
+3XGIXjCLhBOjFFSrE2agCZ0FxMymAEqjwyirQPe815nRW3E4S3jqLTQJkEmMW8x
i16kO2BO9wyp06A73GYAw5kGSpsMCod4ffFXXPi1fz13iUwHPw4By1CZna8cSZNd
rzBnsMkyX/j6h39olONDxqLZUktM8g==
=PuK2
-----END PGP SIGNATURE-----

--66TAlbECwqCH7Es4WmBW88kmGcFhi7kh3--


