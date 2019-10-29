Return-Path: <SRS0=qR42=YW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03C9DCA9EAE
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Oct 2019 12:12:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B021420578
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Oct 2019 12:12:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="P88kfFcR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B021420578
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56158 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iPQMK-00044X-TN
	for qemu-devel@archiver.kernel.org; Tue, 29 Oct 2019 08:12:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44521)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iPQLd-0003To-OQ
 for qemu-devel@nongnu.org; Tue, 29 Oct 2019 08:11:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iPQLc-0004DQ-2p
 for qemu-devel@nongnu.org; Tue, 29 Oct 2019 08:11:41 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:52482
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1iPQLb-0004DC-VC
 for qemu-devel@nongnu.org; Tue, 29 Oct 2019 08:11:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1572351099;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=2IK/pjLR5mYerAeyrI5IFWgZuSfbsUdaAcesxaGUWYk=;
 b=P88kfFcRtc+5oSIvel6qfZiUE4tziGaZ0jJGMMNNc4b52wtsfZ2XcODRf9zP1htSEAgYXU
 d+9ZL1VPyOFB+FXEDaVHLzXGjgt0puj9V9btg6CbeFQK0CSE/Y2ftpWWhcd0INRnXzmiQJ
 5uhsDGNx2cJvzsJ7PLAZ2m3kw0zPmYM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-93-Ec8dGbykPnSL8OUgCWDyXg-1; Tue, 29 Oct 2019 08:11:34 -0400
X-MC-Unique: Ec8dGbykPnSL8OUgCWDyXg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 539571800D55;
 Tue, 29 Oct 2019 12:11:33 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-116-124.ams2.redhat.com
 [10.36.116.124])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C1B6219C4F;
 Tue, 29 Oct 2019 12:11:31 +0000 (UTC)
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
Message-ID: <73064426-f84e-15ec-eaf3-fc02a6b64351@redhat.com>
Date: Tue, 29 Oct 2019 13:11:30 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <319e9b81-407b-62d0-2f79-d12e0b24e457@virtuozzo.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="4g893D0NIRCU9n2JYGkzKYek3ds0vBrNv"
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
Cc: Anton Nefedov <anton.nefedov@virtuozzo.com>,
 Alberto Garcia <berto@igalia.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--4g893D0NIRCU9n2JYGkzKYek3ds0vBrNv
Content-Type: multipart/mixed; boundary="xkjsTaOhjfl28I6L3bHrJlaLExaKqA2IV"

--xkjsTaOhjfl28I6L3bHrJlaLExaKqA2IV
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 29.10.19 13:05, Vladimir Sementsov-Ogievskiy wrote:
> 29.10.2019 14:55, Max Reitz wrote:
>> On 29.10.19 12:48, Vladimir Sementsov-Ogievskiy wrote:
>>> 29.10.2019 11:50, Max Reitz wrote:
>>>> On 28.10.19 12:25, Vladimir Sementsov-Ogievskiy wrote:
>>>>> 28.10.2019 14:04, Kevin Wolf wrote:
>>>>>> Am 27.10.2019 um 13:35 hat Stefan Hajnoczi geschrieben:
>>>>>>> On Fri, Oct 25, 2019 at 11:58:46AM +0200, Max Reitz wrote:
>>>>
>>>> [...]
>>>>
>>>>>>>> (3) Drop handle_alloc_space(), i.e. revert c8bb23cbdbe32f.
>>>>>>>>        To my knowledge I=E2=80=99m the only one who has provided a=
ny benchmarks for
>>>>>>>>        this commit, and even then I was a bit skeptical because it=
 performs
>>>>>>>>        well in some cases and bad in others.  I concluded that it=
=E2=80=99s
>>>>>>>>        probably worth it because the =E2=80=9Csome cases=E2=80=9D =
are more likely to occur.
>>>>>>>>
>>>>>>>>        Now we have this problem of corruption here (granted due to=
 a bug in
>>>>>>>>        the XFS driver), and another report of massively degraded
>>>>>>>>        performance on ppc64
>>>>>>>>        (https://bugzilla.redhat.com/show_bug.cgi?id=3D1745823 =E2=
=80=93 sorry, a
>>>>>>>>        private BZ; I hate that :-/  The report is about 40 % worse
>>>>>>>>        performance for an in-guest fio write benchmark.)
>>>>>>>>
>>>>>>>>        So I have to ask the question about what the justification =
for
>>>>>>>>        keeping c8bb23cbdbe32f is.  How much does performance incre=
ase with
>>>>>>>>        it actually?  (On non-(ppc64+XFS) machines, obviously)
>>>>>>>>
>>>>>>>>        Advantages:
>>>>>>>>        + Trivial
>>>>>>>>        + No layering violations
>>>>>>>>        + We wouldn=E2=80=99t need to keep track of whether the ker=
nel bug has been
>>>>>>>>          fixed or not
>>>>>>>>        + Fixes the ppc64+XFS performance problem
>>>>>>>>
>>>>>>>>        Disadvantages:
>>>>>>>>        - Reverts cluster allocation performance to pre-c8bb23cbdbe=
32f
>>>>>>>>          levels, whatever that means
>>>>>>>
>>>>>>> My favorite because it is clean and simple, but Vladimir has a vali=
d
>>>>>>> use-case for requiring this performance optimization so reverting i=
sn't
>>>>>>> an option.
>>>>>>
>>>>>> Vladimir also said that qcow2 subclusters would probably also solve =
his
>>>>>> problem, so maybe reverting and applying the subcluster patches inst=
ead
>>>>>> is a possible solution, too?
>>>>>
>>>>> I'm not sure about ssd case, it may need write-zero optimization anyw=
ay.
>>>>
>>>> What exactly do you need?  Do you actually need to write zeroes (e.g.
>>>> because you=E2=80=99re storing images on block devices) or would it be
>>>> sufficient to just drop the COW areas when bdrv_has_zero_init() and
>>>> bdrv_has_zero_init_truncate() are true?
>>>
>>> Hmm, what do you mean? We need to zero COW areas. So, original way is t=
o
>>> write real zeroes, optimized way is fallocate.. What do you mean by dro=
p?
>>> Mark sublusters as zeroes by metadata?
>>
>> Why do you need to zero COW areas?  For normal files, any data will read
>> as zero if you didn=E2=80=99t write anything there.
>=20
> Hmm, but when allocating new cluster in qcow2, it's not guaranteed to be =
zero,
> as it may be reused previously allocated cluster..

Hm, right.  We could special-case something for beyond the EOF, but I
don=E2=80=99t know whether that really makes it better.

OTOH, maybe allocations at the EOF are the real bottleneck.  Reusing
existing clusters should be rare enough that maybe the existing code
which explicitly writes zeroes is sufficient.

>>
>>> But still we'll have COW areas in subcluster, and we'll need to directl=
y zero
>>> them.. And fallocate will most probably be faster on ssd ext4 case..
>>>
>>>>
>>>> I=E2=80=99m asking because Dave Chinner said
>>>> (https://bugzilla.redhat.com/show_bug.cgi?id=3D1765547#c7) that
>>>> fallocate() is always slow at least with aio=3Dnative because it needs=
 to
>>>> wait for all concurrent AIO writes to finish, and so it causes the AIO
>>>> pipeline to stall.
>>>>
>>>> (He suggested using XFS extent size hints to get the same effect as
>>>> write-zeroes for free, basically, but I don=E2=80=99t know whether tha=
t=E2=80=99s really
>>>> useful to us; as unallocated areas on XFS read back as zero anyway.)
>>>>
>>>>>> We already have some cases where the existing handle_alloc_space()
>>>>>> causes performance to actually become worse, and serialising request=
s as
>>>>>> a workaround isn't going to make performance any better. So even on
>>>>>> these grounds, keeping commit c8bb23cbdbe32f is questionable.
>>>>>>
>>>>>
>>>>> Can keeping handle_alloc_space under some config option be an option?
>>>>
>>>> Hm.  A config option is weird if you=E2=80=99re the only one who=E2=80=
=99s going to
>>>> enable it.  But other than that I don=E2=80=99t have anything against =
it.
>>>>
>>>
>>> It's just a bit easier for us to maintain config option, than out-of-tr=
ee patch.
>>> On the other hand, it's not a real problem to maintain this one patch i=
n separate.
>>> It may return again to the tree, when XFS bug fixed.
>>
>> We=E2=80=99ll still have the problem that fallocate() must stall aio=3Dn=
ative
>> requests.
>>
>=20
> Does it mean that fallocate is bad in general? Practice shows the opposit=
e..
> At least I have my examples with qemu-img bench. Can that thing be shown =
with
> qemu-img bench or something?

I haven=E2=80=99t done benchmarks yet, but I don=E2=80=99t think Laurent wi=
ll mind if I
paste his fio benchmark results from the unfortunately private BZ here:

         QCOW2 ON |          EXT4         |          XFS          |
                  |                       |                       |
(rw, bs, iodepth) |   2.12.0  |   4.1.0   |   2.12.0  |   4.1.0   |
------------------+-----------+-----------+-----------+-----------+
(write, 16k, 1)   | 1868KiB/s | 1865KiB/s | 18.6MiB/s | 13.7MiB/s |
------------------+-----------+-----------+-----------+-----------+
(write, 64k, 1)   | 7036KiB/s | 7413KiB/s | 27.0MiB/s | 7465KiB/s |
------------------+-----------+-----------+-----------+-----------+
(write,  4k, 8)   |  535KiB/s |  524KiB/s | 13.9MiB/s | 1662KiB/s |
------------------+-----------+-----------+-----------+-----------+

And that just looks like ext4 performs worse with aio=3Dnative in general.
 But I=E2=80=99ll have to do my own benchmarks first.

Max


--xkjsTaOhjfl28I6L3bHrJlaLExaKqA2IV--

--4g893D0NIRCU9n2JYGkzKYek3ds0vBrNv
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl24LHIACgkQ9AfbAGHV
z0B8ggf/YxXBBadOypKF/tdKq0gPSKYK3QarXRDK5QKaMWS8y7uomMqzCT8WCR6f
oHCSaRcCG7a7zS6H9VtehMFnsm2aiUjeUs+73KKpATpBpZipI7UzTuPeJAckjZUw
3qt8XZ5RvQ8eyD8e3jnAQyGtMwV8LDSSxewA1/W0J3UF3WpaHnMn8xpwJS2lWhQ5
iLk5tDmgNbQUd/nOZPf3jdbKhqY0k1FcXnoX3aw6F84/anw0XG34+vqz7umjc3+k
CMhlMl3xoMVbURT4eids/o4P8dQNZOFLU5weeLmYP0+e3LxtcVIW8VfbCzFvklqr
ucUYaEdPA2tJIvcMpwRTq00G4wGtUw==
=Hodi
-----END PGP SIGNATURE-----

--4g893D0NIRCU9n2JYGkzKYek3ds0vBrNv--


