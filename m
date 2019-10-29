Return-Path: <SRS0=qR42=YW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FA34CA9EAE
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Oct 2019 12:25:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 931AB21479
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Oct 2019 12:25:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Onst8pCO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 931AB21479
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56288 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iPQYs-0003jt-56
	for qemu-devel@archiver.kernel.org; Tue, 29 Oct 2019 08:25:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45927)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iPQXd-0002OB-I8
 for qemu-devel@nongnu.org; Tue, 29 Oct 2019 08:24:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iPQXb-0001AL-NK
 for qemu-devel@nongnu.org; Tue, 29 Oct 2019 08:24:05 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:26017
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1iPQXb-0001A1-Hu
 for qemu-devel@nongnu.org; Tue, 29 Oct 2019 08:24:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1572351843;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=/qhwA66/QiPsYu8qwZXGPYb5ICZV1DRwMXGuipp7f9U=;
 b=Onst8pCOCYCEq9C0DAxZjdAjVAOG5MavpUddN9wivf1FIfZ22zn4ZvLENinp3tikt/D5z4
 T5Y4oIbbbkQP5BNLyhUUmRA+x9RZEFueOXyeEgk396B49qiK84n9mubFC+3vgyM1iNWKA/
 uiF03pu9FoAjjjDrXnK+Q+IMRojUjDo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-309-_em0CsBXNjyo2BwyU8CpjA-1; Tue, 29 Oct 2019 08:23:56 -0400
X-MC-Unique: _em0CsBXNjyo2BwyU8CpjA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7B2321005500;
 Tue, 29 Oct 2019 12:23:55 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-116-124.ams2.redhat.com
 [10.36.116.124])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 6D7A61001B11;
 Tue, 29 Oct 2019 12:23:51 +0000 (UTC)
Subject: Re: [RFC 0/3] block/file-posix: Work around XFS bug
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 Kevin Wolf <kwolf@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>
References: <20191025095849.25283-1-mreitz@redhat.com>
 <20191027123555.GN4472@stefanha-x1.localdomain>
 <20191028110408.GB3579@localhost.localdomain>
 <44565375-b051-e782-4988-c3e0b1745e37@virtuozzo.com>
 <9780d020-e573-866f-dce4-d99d73f1f5e8@redhat.com>
 <98a5da91-d018-13e1-cf5c-168d7348117b@virtuozzo.com>
 <b93e2b5c-b245-e8eb-bd9e-cbde46290544@redhat.com>
 <319e9b81-407b-62d0-2f79-d12e0b24e457@virtuozzo.com>
 <73064426-f84e-15ec-eaf3-fc02a6b64351@redhat.com>
 <4c3f9460-04e3-c6d4-8d98-dcb95b023b6b@virtuozzo.com>
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
Message-ID: <9dd0be12-2460-2d9a-4c13-7c1f5110b5c1@redhat.com>
Date: Tue, 29 Oct 2019 13:23:49 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <4c3f9460-04e3-c6d4-8d98-dcb95b023b6b@virtuozzo.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="2CVvJfP6Pu5XQhdTdsIpOGAV9w3aftXxu"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: Anton Nefedov <anton.nefedov@virtuozzo.com>,
 Alberto Garcia <berto@igalia.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--2CVvJfP6Pu5XQhdTdsIpOGAV9w3aftXxu
Content-Type: multipart/mixed; boundary="KKeqGNIpW8b5pe5pKwbzMByYfgjbrW2yJ"

--KKeqGNIpW8b5pe5pKwbzMByYfgjbrW2yJ
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 29.10.19 13:19, Vladimir Sementsov-Ogievskiy wrote:
> 29.10.2019 15:11, Max Reitz wrote:
>> On 29.10.19 13:05, Vladimir Sementsov-Ogievskiy wrote:
>>> 29.10.2019 14:55, Max Reitz wrote:
>>>> On 29.10.19 12:48, Vladimir Sementsov-Ogievskiy wrote:
>>>>> 29.10.2019 11:50, Max Reitz wrote:
>>>>>> On 28.10.19 12:25, Vladimir Sementsov-Ogievskiy wrote:
>>>>>>> 28.10.2019 14:04, Kevin Wolf wrote:
>>>>>>>> Am 27.10.2019 um 13:35 hat Stefan Hajnoczi geschrieben:
>>>>>>>>> On Fri, Oct 25, 2019 at 11:58:46AM +0200, Max Reitz wrote:
>>>>>>
>>>>>> [...]
>>>>>>
>>>>>>>>>> (3) Drop handle_alloc_space(), i.e. revert c8bb23cbdbe32f.
>>>>>>>>>>         To my knowledge I=E2=80=99m the only one who has provide=
d any benchmarks for
>>>>>>>>>>         this commit, and even then I was a bit skeptical because=
 it performs
>>>>>>>>>>         well in some cases and bad in others.  I concluded that =
it=E2=80=99s
>>>>>>>>>>         probably worth it because the =E2=80=9Csome cases=E2=80=
=9D are more likely to occur.
>>>>>>>>>>
>>>>>>>>>>         Now we have this problem of corruption here (granted due=
 to a bug in
>>>>>>>>>>         the XFS driver), and another report of massively degrade=
d
>>>>>>>>>>         performance on ppc64
>>>>>>>>>>         (https://bugzilla.redhat.com/show_bug.cgi?id=3D1745823 =
=E2=80=93 sorry, a
>>>>>>>>>>         private BZ; I hate that :-/  The report is about 40 % wo=
rse
>>>>>>>>>>         performance for an in-guest fio write benchmark.)
>>>>>>>>>>
>>>>>>>>>>         So I have to ask the question about what the justificati=
on for
>>>>>>>>>>         keeping c8bb23cbdbe32f is.  How much does performance in=
crease with
>>>>>>>>>>         it actually?  (On non-(ppc64+XFS) machines, obviously)
>>>>>>>>>>
>>>>>>>>>>         Advantages:
>>>>>>>>>>         + Trivial
>>>>>>>>>>         + No layering violations
>>>>>>>>>>         + We wouldn=E2=80=99t need to keep track of whether the =
kernel bug has been
>>>>>>>>>>           fixed or not
>>>>>>>>>>         + Fixes the ppc64+XFS performance problem
>>>>>>>>>>
>>>>>>>>>>         Disadvantages:
>>>>>>>>>>         - Reverts cluster allocation performance to pre-c8bb23cb=
dbe32f
>>>>>>>>>>           levels, whatever that means
>>>>>>>>>
>>>>>>>>> My favorite because it is clean and simple, but Vladimir has a va=
lid
>>>>>>>>> use-case for requiring this performance optimization so reverting=
 isn't
>>>>>>>>> an option.
>>>>>>>>
>>>>>>>> Vladimir also said that qcow2 subclusters would probably also solv=
e his
>>>>>>>> problem, so maybe reverting and applying the subcluster patches in=
stead
>>>>>>>> is a possible solution, too?
>>>>>>>
>>>>>>> I'm not sure about ssd case, it may need write-zero optimization an=
yway.
>>>>>>
>>>>>> What exactly do you need?  Do you actually need to write zeroes (e.g=
.
>>>>>> because you=E2=80=99re storing images on block devices) or would it =
be
>>>>>> sufficient to just drop the COW areas when bdrv_has_zero_init() and
>>>>>> bdrv_has_zero_init_truncate() are true?
>>>>>
>>>>> Hmm, what do you mean? We need to zero COW areas. So, original way is=
 to
>>>>> write real zeroes, optimized way is fallocate.. What do you mean by d=
rop?
>>>>> Mark sublusters as zeroes by metadata?
>>>>
>>>> Why do you need to zero COW areas?  For normal files, any data will re=
ad
>>>> as zero if you didn=E2=80=99t write anything there.
>>>
>>> Hmm, but when allocating new cluster in qcow2, it's not guaranteed to b=
e zero,
>>> as it may be reused previously allocated cluster..
>>
>> Hm, right.  We could special-case something for beyond the EOF, but I
>> don=E2=80=99t know whether that really makes it better.
>>
>> OTOH, maybe allocations at the EOF are the real bottleneck.  Reusing
>> existing clusters should be rare enough that maybe the existing code
>> which explicitly writes zeroes is sufficient.
>=20
> But, as I understand pre-EOF fallocates are safe in xfs? So, we may just =
drop calling
> fallocate past-EOF (it's zero anyway) and do fallocate pre-EOF (it's safe=
) ?

But probably slow still.  And there=E2=80=99s the question of how much
complexity we want to heap onto this.

Max


--KKeqGNIpW8b5pe5pKwbzMByYfgjbrW2yJ--

--2CVvJfP6Pu5XQhdTdsIpOGAV9w3aftXxu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl24L1UACgkQ9AfbAGHV
z0Bx0wf7BLwYX/2mjocttITUZsb9rXiamIy6PKz8nZ7rmFAAUbs0hbYULMhicw9h
vDbMeoUSh7faOJ2z9gcJbCOERDx1Y+Zc8bqi63T3d8IaqpPzMmkkjNBjrDw6dNgS
6eSUnritCc5414GcNZ5f+vp8/9SyrOLSafje1BpEbRwEddnfWJlcA1t0oUbYfin3
YlpHXSoArxM5ScyxODwL/+3J41VPhR7bgE9AQpvZYN6boeJFR9XOjgbCofl8jzDp
MTTJEsnugBMJwaSlV8fb8YvaNGJEvKTLg6QGsCM+iGIOyt9nPxUSS4x5aL36Ify8
+JmtoEx44K8kDLfhKWvpYh4DIEFVQQ==
=gUWt
-----END PGP SIGNATURE-----

--2CVvJfP6Pu5XQhdTdsIpOGAV9w3aftXxu--


