Return-Path: <SRS0=Szrt=YV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C718ECA9EA0
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Oct 2019 08:57:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9036720B7C
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Oct 2019 08:57:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DZz0vCFL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9036720B7C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51960 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iP0qO-0001eg-Qu
	for qemu-devel@archiver.kernel.org; Mon, 28 Oct 2019 04:57:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55200)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iP0pQ-0008Qa-KN
 for qemu-devel@nongnu.org; Mon, 28 Oct 2019 04:56:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iP0pN-0004C5-PM
 for qemu-devel@nongnu.org; Mon, 28 Oct 2019 04:56:43 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:31067
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1iP0pN-0004BX-I0
 for qemu-devel@nongnu.org; Mon, 28 Oct 2019 04:56:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1572253000;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=k8YJnNIYXIQ5uLsk+faddod4S0AtcB12murXPk41gYU=;
 b=DZz0vCFLsoSxuWQm3OV3lbm1XmKZW8YQpMLtVeqzkIEZEL8KtcBuTTRY6fJYkit9HbjOsm
 CIaqw3CVQ/tmanGRuSZVS2CTT1nmsEGiMAXuX0Zc3Fl9S1sj4LliWNUg09Ss5wmR3Mg0X3
 m1nDC6yGd/b1y3E8wwBGiY5gFQlu09A=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-36--d0OOc7HMsKpEE4cBc2_sg-1; Mon, 28 Oct 2019 04:56:36 -0400
X-MC-Unique: -d0OOc7HMsKpEE4cBc2_sg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7F7ED1005509;
 Mon, 28 Oct 2019 08:56:35 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-117-83.ams2.redhat.com
 [10.36.117.83])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 62F835C219;
 Mon, 28 Oct 2019 08:56:30 +0000 (UTC)
Subject: Re: [RFC 0/3] block/file-posix: Work around XFS bug
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 Nir Soffer <nsoffer@redhat.com>
References: <20191025095849.25283-1-mreitz@redhat.com>
 <CAMRbyyuMyyMp0HT2Kmdwj4svKLAmk4_Lryagx8XowRJ1T3xjcg@mail.gmail.com>
 <314c504d-5560-3770-766f-ab7bfa9a37d0@virtuozzo.com>
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
Message-ID: <6a1b71a1-a5e4-35fc-19a0-08e4fd16a44a@redhat.com>
Date: Mon, 28 Oct 2019 09:56:28 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <314c504d-5560-3770-766f-ab7bfa9a37d0@virtuozzo.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="0rx2CnoEk9AwdCS3wJ2eztTAdYm7nN0Ir"
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
 Alberto Garcia <berto@igalia.com>, qemu-block <qemu-block@nongnu.org>,
 QEMU Developers <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--0rx2CnoEk9AwdCS3wJ2eztTAdYm7nN0Ir
Content-Type: multipart/mixed; boundary="WTvnBjlhfDF75UTVOWLHgx6Gwmn5pWlmA"

--WTvnBjlhfDF75UTVOWLHgx6Gwmn5pWlmA
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 26.10.19 19:52, Vladimir Sementsov-Ogievskiy wrote:
> 26.10.2019 20:37, Nir Soffer wrote:
>> On Fri, Oct 25, 2019 at 1:11 PM Max Reitz <mreitz@redhat.com> wrote:
>>>
>>> Hi,
>>>
>>> It seems to me that there is a bug in Linux=E2=80=99s XFS kernel driver=
, as
>>> I=E2=80=99ve explained here:
>>>
>>> https://lists.nongnu.org/archive/html/qemu-block/2019-10/msg01429.html
>>>
>>> In combination with our commit c8bb23cbdbe32f, this may lead to guest
>>> data corruption when using qcow2 images on XFS with aio=3Dnative.
>>>
>>> We can=E2=80=99t wait until the XFS kernel driver is fixed, we should w=
ork
>>> around the problem ourselves.
>>>
>>> This is an RFC for two reasons:
>>> (1) I don=E2=80=99t know whether this is the right way to address the i=
ssue,
>>> (2) Ideally, we should detect whether the XFS kernel driver is fixed an=
d
>>>      if so stop applying the workaround.
>>>      I don=E2=80=99t know how we would go about this, so this series do=
esn=E2=80=99t do
>>>      it.  (Hence it=E2=80=99s an RFC.)
>>> (3) Perhaps it=E2=80=99s a bit of a layering violation to let the file-=
posix
>>>      driver access and modify a BdrvTrackedRequest object.
>>>
>>> As for how we can address the issue, I see three ways:
>>> (1) The one presented in this series: On XFS with aio=3Dnative, we exte=
nd
>>>      tracked requests for post-EOF fallocate() calls (i.e., write-zero
>>>      operations) to reach until infinity (INT64_MAX in practice), mark
>>>      them serializing and wait for other conflicting requests.
>>>
>>>      Advantages:
>>>      + Limits the impact to very specific cases
>>>        (And that means it wouldn=E2=80=99t hurt too much to keep this w=
orkaround
>>>        even when the XFS driver has been fixed)
>>>      + Works around the bug where it happens, namely in file-posix
>>>
>>>      Disadvantages:
>>>      - A bit complex
>>>      - A bit of a layering violation (should file-posix have access to
>>>        tracked requests?)
>>>
>>> (2) Always skip qcow2=E2=80=99s handle_alloc_space() on XFS.  The XFS b=
ug only
>>>      becomes visible due to that function: I don=E2=80=99t think qcow2 =
writes
>>>      zeroes in any other I/O path, and raw images are fixed in size so
>>>      post-EOF writes won=E2=80=99t happen.
>>>
>>>      Advantages:
>>>      + Maybe simpler, depending on how difficult it is to handle the
>>>        layering violation
>>>      + Also fixes the performance problem of handle_alloc_space() being
>>>        slow on ppc64+XFS.
>>>
>>>      Disadvantages:
>>>      - Huge layering violation because qcow2 would need to know whether
>>>        the image is stored on XFS or not.
>>>      - We=E2=80=99d definitely want to skip this workaround when the XF=
S driver
>>>        has been fixed, so we need some method to find out whether it ha=
s
>>>
>>> (3) Drop handle_alloc_space(), i.e. revert c8bb23cbdbe32f.
>>>      To my knowledge I=E2=80=99m the only one who has provided any benc=
hmarks for
>>>      this commit, and even then I was a bit skeptical because it perfor=
ms
>>>      well in some cases and bad in others.  I concluded that it=E2=80=
=99s
>>>      probably worth it because the =E2=80=9Csome cases=E2=80=9D are mor=
e likely to occur.
>>>
>>>      Now we have this problem of corruption here (granted due to a bug =
in
>>>      the XFS driver), and another report of massively degraded
>>>      performance on ppc64
>>>      (https://bugzilla.redhat.com/show_bug.cgi?id=3D1745823 =E2=80=93 s=
orry, a
>>>      private BZ; I hate that :-/  The report is about 40 % worse
>>>      performance for an in-guest fio write benchmark.)
>>>
>>>      So I have to ask the question about what the justification for
>>>      keeping c8bb23cbdbe32f is.  How much does performance increase wit=
h
>>>      it actually?  (On non-(ppc64+XFS) machines, obviously)
>>>
>>>      Advantages:
>>>      + Trivial
>>>      + No layering violations
>>>      + We wouldn=E2=80=99t need to keep track of whether the kernel bug=
 has been
>>>        fixed or not
>>>      + Fixes the ppc64+XFS performance problem
>>>
>>>      Disadvantages:
>>>      - Reverts cluster allocation performance to pre-c8bb23cbdbe32f
>>>        levels, whatever that means
>>
>> Correctness is more important than performance, so this is my
>> preference as a user.
>>
>=20
> Hmm, still, incorrect is XFS, not Qemu. This bug may be triggered by anot=
her
> software, or may be another scenario in Qemu (not sure).

I don=E2=80=99t see any other image format (but qcow2, raw, and filters)
creating zero-writes apart from the parallels format which does so
before writes can happen to that area.  So with parallels, it=E2=80=99s
impossible to get a data write behind an ongoing zero-write.

Raw and filters do not initiate zero-writes on their own.  So there must
be something else that requests them.  Block jobs and guests are limited
to generally fixed-size disks, so I don=E2=80=99t see a way to generate
zero-writes beyond the EOF there.

Which leaves us with qcow2.  To my knowledge the only place where qcow2
generates zero-writes in an I/O path (so they can occur concurrently to
data writes) is in handle_alloc_space().  Therefore, dropping it should
remove the only place where the XFS bug can be triggered.


That the bug is in XFS and not in qemu is a good argument from a moral
standpoint, but it isn=E2=80=99t very pragmatic or reasonable from a techni=
cal
standpoint.  There is no fix for XFS yet, so right now the situation is
that there is a bug that causes guest data loss, that qemu can prevent
it, and that there is no other workaround or fix.

So we must work around it.

Of course, that doesn=E2=80=99t mean that we have to do everything in our p=
ower
to implement a work around no matter the cost.  We do indeed have to
balance between how far we=E2=80=99re willing to go to fix it and how much =
we
impact non-XFS workloads.


Honestly, I caught myself saying =E2=80=9CWell, that=E2=80=99s too bad for =
XFS over
gluster if XFS is broken=E2=80=9D.  But that just isn=E2=80=99t a reasonabl=
e thing to say.

I suppose what we could do is drop the is_xfs check in patch 3.  The
only outcome is that you can no longer do concurrent data writes past
zero-writes past the EOF.  And as I=E2=80=99ve claimed above, this only aff=
ects
handle_alloc_space() from qcow2.  Would it be so bad if we simply did
that on every filesystem?

Max


--WTvnBjlhfDF75UTVOWLHgx6Gwmn5pWlmA--

--0rx2CnoEk9AwdCS3wJ2eztTAdYm7nN0Ir
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl22rTwACgkQ9AfbAGHV
z0CL5wf/TG6i8o2D+trXqZtPF0eRXblTJ7yBNBL7hIORNbLLnpCgylbw5RIUhaHx
1fzu03OcHtn905CzCo8jjUtfNMcYzmTge0FJ7CmYQdWiSJRqQ2oTUmznlkTfar2i
AtEqeJvQ44rjR+8WC6KRlyqoP1g1PgggbUkTrSWQWFs/wcoLOZ8SMSKr7LMzbyof
ap3ykt/PAkEu3UW5qscmFxDfaffBCXOokWi2CCj6rB8QG4r0brC4Pef7sk11UDWX
BrC/ZUAv31a5C3KOtHYZkvQBCVZA0ALOPnBG1757IyiObLnniePrR51HjBS3sK7F
htzPt9h/iBXE46pBWTQHrNvzXqTzxg==
=QcV2
-----END PGP SIGNATURE-----

--0rx2CnoEk9AwdCS3wJ2eztTAdYm7nN0Ir--


