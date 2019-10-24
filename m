Return-Path: <SRS0=Jnn8=YR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 077B8CA9EAF
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 13:53:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C3FF021655
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 13:53:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ir+H9j7q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C3FF021655
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43228 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNdYT-0007gy-DZ
	for qemu-devel@archiver.kernel.org; Thu, 24 Oct 2019 09:53:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59988)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iNdTR-0003cA-FF
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 09:48:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iNdTO-0008AU-MO
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 09:48:20 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:54891
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1iNdTO-00088v-4F
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 09:48:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1571924894;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=Hk6Wg6UfVi/TnRspPYhEUtS2XkIIu/9oHcDDY5nokkc=;
 b=ir+H9j7qmR0xtOQBkyA9MuJ0PPDAKpAtHK3GWkIproP8zmDKcmhP2KhGjeKC8ShGHp41L+
 rbPQjcmqFtuJ3KXC3o0zJU9+nP5SgF2+D2YNO1I6be/fJtXxhhRXCEUNKtPVwMirUANiOi
 jdH5P0Vd0QgEn2Tn6btYVrKreiyRn2U=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-339-AR61IUxpOwWtCj_Bg92cPQ-1; Thu, 24 Oct 2019 09:48:11 -0400
X-MC-Unique: AR61IUxpOwWtCj_Bg92cPQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BDB3480183D;
 Thu, 24 Oct 2019 13:48:09 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-117-205.ams2.redhat.com
 [10.36.117.205])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 6BA725D9D5;
 Thu, 24 Oct 2019 13:48:07 +0000 (UTC)
Subject: Re: [PATCH v5 1/4] block: support compressed write at generic layer
To: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>
References: <1571603828-185910-1-git-send-email-andrey.shinkevich@virtuozzo.com>
 <1571603828-185910-2-git-send-email-andrey.shinkevich@virtuozzo.com>
 <408ef2ab-1f6c-2c9f-ad50-92269c20fb27@redhat.com>
 <eece4ca2-7c40-cae6-b15f-beed73830fd8@virtuozzo.com>
 <cc3f87c2-3ad5-da4e-4750-27a48bce1ee6@virtuozzo.com>
 <787da788-9aca-2110-a092-b63ef498a9fa@redhat.com>
 <ae5bc00f-e65e-8c33-2620-a9147e48ea78@virtuozzo.com>
 <1088f0ff-d882-083f-705c-95c08bdc486f@redhat.com>
 <cb6db9c4-0dbc-9d9a-4ec5-b436c48178a8@virtuozzo.com>
 <4fd89d2a-94aa-6f2d-ed7d-7633356e5163@redhat.com>
 <539e7d9e-0cb7-fdb7-f376-1648361ec2f3@virtuozzo.com>
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
Message-ID: <8828d08f-79aa-f3a6-4387-f1423a8b7d70@redhat.com>
Date: Thu, 24 Oct 2019 15:48:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <539e7d9e-0cb7-fdb7-f376-1648361ec2f3@virtuozzo.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="lcqM5PwKqt9YICTYHMH9M2gB4ervX1ZWN"
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
Cc: "kwolf@redhat.com" <kwolf@redhat.com>, "fam@euphon.net" <fam@euphon.net>,
 Denis Lunev <den@virtuozzo.com>, "armbru@redhat.com" <armbru@redhat.com>,
 "stefanha@redhat.com" <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--lcqM5PwKqt9YICTYHMH9M2gB4ervX1ZWN
Content-Type: multipart/mixed; boundary="vrEpoaTwFtTuRqpN20PsA5Nmdh3qs7idV"

--vrEpoaTwFtTuRqpN20PsA5Nmdh3qs7idV
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 24.10.19 14:56, Andrey Shinkevich wrote:
>=20
>=20
> On 24/10/2019 12:34, Max Reitz wrote:
>> On 22.10.19 15:53, Andrey Shinkevich wrote:
>>
>> [...]
>>
>>> If the support of COW for compressed writes is found feasible, will it
>>> make a sense to implement? Then this series will follow.
>>
>> Hm, what exactly do you mean by support of COW for compressed writes?
>>
>=20
> I spoke in terms of the commit message with the following ID:
>=20
> b0b6862e5e1a1394e0ab3d5da94ba8b0da8664e2
>=20
> "qcow2: Fail write_compressed when overwriting data"
>=20
> "...qcow2_write_compressed() doesn't perform COW as it would have to do..=
."
>=20
> So, I suggest that we implement writing compressed data to the allocated=
=20
> clusters rather than qcow2_alloc_compressed_cluster_offset() returns the=
=20
> error. Particularly, when it comes to NBD server connection failure for=
=20
> writhing a compressed cluster, it may not be rewritten after the=20
> connection is restored.
> Are there any issues with that implementation idea?

Well, the COW in that commit is meant differently, because it refers to
the COW that=E2=80=99s required when writing to a cluster shared by an inte=
rnal
snapshot.

OTOH, you could say that all compressed writes to a cluster that is
already allocated would need to do COW because we=E2=80=99d always have to =
fully
rewrite that cluster in an RMW cycle.

I don=E2=80=99t see how letting qcow2_alloc_compressed_cluster_offset() use=
 the
existing cluster would solve the problem, though.  You=E2=80=99d generally =
need
to allocate a new cluster; or attempt to reuse the existing space in a
compressed cluster.

Max


--vrEpoaTwFtTuRqpN20PsA5Nmdh3qs7idV--

--lcqM5PwKqt9YICTYHMH9M2gB4ervX1ZWN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl2xq5UACgkQ9AfbAGHV
z0A01Qf8Dsa7NS79rKBSw3aha7lWCmbG9T7HHaDqMfrhv6S8Nuru1yGR2ySgIyIo
X4i67ZqRl3/CRrwZmnqKFQ1IZ3czJNneqPlRq7rzxfcaS+umPbu9L4iHbwEzlFT5
bZfztHeI9d4OOD9LocXl4itY2N9LtcxVkMsEGOsV+cFns56eH0TBW3OLc6ozd2fd
euwQS6EBuoxlg9HvBu3cs3vAlNNdauSdIysayxIOT0Yt24Wfha+vSJ/+j8l5N57z
0GM4JvIs0SQYa2f8hRpRk23TYy7CSzbLwJoQQKjdbotXMuuOqzGzNlSqiOkUS4Vl
YLgO7UwGHKlF4Kze+itL9yzEuZqLww==
=fu5f
-----END PGP SIGNATURE-----

--lcqM5PwKqt9YICTYHMH9M2gB4ervX1ZWN--


