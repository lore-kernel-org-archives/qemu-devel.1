Return-Path: <SRS0=V8KP=YZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6F86CA9ECF
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Nov 2019 15:08:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A443621734
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Nov 2019 15:08:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="N+XzYkT7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A443621734
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40060 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iQYXH-00033f-Qv
	for qemu-devel@archiver.kernel.org; Fri, 01 Nov 2019 11:08:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46359)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iQYVh-0001s5-7r
 for qemu-devel@nongnu.org; Fri, 01 Nov 2019 11:06:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iQYVb-0002bk-9T
 for qemu-devel@nongnu.org; Fri, 01 Nov 2019 11:06:40 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:58571
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1iQYVb-0002NJ-5k
 for qemu-devel@nongnu.org; Fri, 01 Nov 2019 11:06:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1572620795;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=bfHvVtjPCvsjd2B5ccO+hzxk5EETcYHnl1n61gfT/oY=;
 b=N+XzYkT7uL/ImF4wqH1Job+VA/co9B7rv5gqIYy387d/MC1EnKa7V7BkBnJkErd3EG+bKf
 ETsH0dlzmYEo7vYYDghoNw0cTYmd9OJEWGRcv+1Q0XDHOGLqmuQTIDdqodvHk2EgSUxwUw
 Vx0tsTdgpsZwYvnNjVhBZ3M0sHPXij0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-91-y85TJo3aNr2AbUQJ2G7gzA-1; Fri, 01 Nov 2019 11:06:31 -0400
X-MC-Unique: y85TJo3aNr2AbUQJ2G7gzA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CB6E22EE3;
 Fri,  1 Nov 2019 15:06:30 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-117-28.ams2.redhat.com
 [10.36.117.28])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 4ACC05DA7C;
 Fri,  1 Nov 2019 15:06:24 +0000 (UTC)
Subject: Re: [PATCH for-4.2 0/4] qcow2: Fix data corruption on XFS
From: Max Reitz <mreitz@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>
References: <20191101100019.9512-1-mreitz@redhat.com>
 <fbf32283-2ec5-28ae-f4c9-5bd7d4af7b3f@redhat.com>
 <783a805a-3a3a-e8c5-41ac-f6476378975e@virtuozzo.com>
 <908ffc42-8328-969d-641b-4596ec0b6b45@redhat.com>
 <fb5ae941-622f-c82d-9eb8-be3fe66e3fb6@virtuozzo.com>
 <909d8474-0e8f-b9b9-5647-b604f956900a@redhat.com>
 <c252753e-c67a-be46-1136-d0d7d9e642e7@redhat.com>
 <4188555d-23e3-ef2d-133c-5826cf878d37@redhat.com>
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
Message-ID: <544d3cad-213b-752f-0831-075fd41a281d@redhat.com>
Date: Fri, 1 Nov 2019 16:06:23 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <4188555d-23e3-ef2d-133c-5826cf878d37@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="YwEPc06ETMaecfD0RQschjcEXF21l3F2C"
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
--YwEPc06ETMaecfD0RQschjcEXF21l3F2C
Content-Type: multipart/mixed; boundary="wrvsQ98r9siZcm2wMAbpRAjjrF2IrRefP"

--wrvsQ98r9siZcm2wMAbpRAjjrF2IrRefP
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 01.11.19 14:30, Max Reitz wrote:

[...]

> So unless there are realistic guest benchmarks for ext4 that say we
> should keep the patch, I=E2=80=99m going to queue the revert for now (=E2=
=80=9Cnow=E2=80=9D =3D
> 4.1.1 and 4.2.0).

I found one case where the performance is significantly improved by
c8bb23cbdbe: In the cases so far I had XFS in the guest, now I used
ext4, and with aio=3Dnative (on the ext4 host with 2 MB clusters), the
performance goes from 63.9 - 65.0 MB/s to 75.7 - 76.4 MB/s (so +18%).

The difference is smaller for 64 kB clusters, but still there at +13%.
That=E2=80=99s probably the more important fact, because these are the defa=
ult
settings, and this is probably about what would happen with 2 MB
clusters + subclusters.

(Patch 4 in this series doesn=E2=80=99t decrease the performance.)

This is a tough decision for me because from some people tell me =E2=80=9CL=
et=E2=80=99s
just revert it, there are problems with it and we don=E2=80=99t quite know =
what
good it does in practice=E2=80=9D, and others say =E2=80=9CWe have (not rea=
lly
practical) benchmarks that show it does something good for our specific
case=E2=80=9D.  And all that while those two groups never seem to talk to e=
ach
other directly.

So I suppose I=E2=80=99m going to have to make a decision.  I now know a ca=
se
where c8bb23cbdbe is actually beneficial.  I myself have never seen
c8bb23cbdbe decrease performance, but I know Laurent has seen a drastic
performance degradation, and he=E2=80=99s used it to bisect the XFS problem=
 to
that commit, so it=E2=80=99s really real.  But I haven=E2=80=99t seen it, a=
nd as far as
I know it really only happens on ppc64.


In light of this, I would prefer to revert c8bb23cbdbe for 4.1.1, and
keep it for 4.2.0.  But I don=E2=80=99t know whether we can do that, all I =
know
is that I=E2=80=99m not going to find out in time for 4.1.1.

If we keep c8bb23cbdbe in any way, we need patches 2 through 4, that
much is clear.

I believe we can think about the performance problem after 4.2.0.  I
would love to benchmark c8bb23cbdbe on a fixed kernel, but there just
isn=E2=80=99t time for that anymore.


I=E2=80=99m not a fan of keeping c8bb23cbdbe behind a configure switch.  If=
 it=E2=80=99s
beneficial, it should be there for everyone.


OK.  Some may see this as a wrong decision, but someone needs to make
one now, so here goes: ext4 is the default Linux FS for most
distributions.  As far as I can tell from my own benchmarks, c8bb23cbdbe
brings a significant performance improvement for qcow2 images with the
default configuration on this default filesystem with aio=3Dnative and
doesn=E2=80=99t change much in any other case.

What happens on ppc64 is a problem, but that=E2=80=99s a RHEL problem becau=
se
it=E2=80=99s specific to XFS (and also ppc64).  It also won=E2=80=99t be a =
regression on
4.2 compared to 4.1.

Dave=E2=80=99s argument was good that fallocate() and AIO cannot mix (at le=
ast
on XFS), but I couldn=E2=80=99t see any impact of that in my benchmarks (ma=
ybe
my benchmarks were just wrong).


So I think for upstream it=E2=80=99ll be best if I send a v2 which doesn=E2=
=80=99t touch
handle_alloc_space(), and instead just consists of patches 2 through 4.
 (And CC it all to stable.)

I think we still need to keep track of the XFS/ppc64 issue and do more
benchmarks especially with the fixed XFS driver.


tl;dr:
The main arguments for reverting c8bb23cbdbe were (AFAIU):
- a general uneasy feeling about it
- theoretical arguments that it must be bad on XFS
- actual problems on ppc64/XFS
- =E2=80=9Cwhat good does it do in practice?=E2=80=9D
- that subclusters would make it obsolete anyway

What I could see is:
- no impact on XFS in practice
- significant practical benefit on ext4
- subclusters probably wouldn=E2=80=99t make it obsolete, because I can sti=
ll
see a +13% improvement for 64 kB clusters (2 MB clusters + subclusters
gives you 64 kB subclusters)

In addition, it needs to be considered that ext4 is the default FS for
most Linux distributions.

As such, I personally am not convinced of reverting this patch.  Let=E2=80=
=99s
keep it, have patches 2 through 4 for 4.1.1 and 4.2.0, and think about
what to do for ppc64/XFS later.

Max


--wrvsQ98r9siZcm2wMAbpRAjjrF2IrRefP--

--YwEPc06ETMaecfD0RQschjcEXF21l3F2C
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl28Se8ACgkQ9AfbAGHV
z0DJqAf8D4Pxx0AZxh+gH9aQU3KH/Du15Xdt6CB5e45eitLxfo7Vw73FMqzFy0p0
E1U764t2giiGklkyIIk5fneWZTCBxs9Lpnwj+HrdmZzOHfpOcFoGQN6PEVkdsl2v
n85NtFoQV3gqEUowvkRN+dugEWT8uxj3LEXgmsrG00kw4W39NVT2fGmx5wvNsrUD
U+0VZUg/kxBixpv2nW38RM7L5RkUmvSAdcyP9QwqyNHjOc8rn69AZdVKRPCRIqLr
PT92EPHubutXFPg5q4HX3JAbHm5qk/qespqpkTkvYj6rOaRBmSH6DJKrpSLHci6y
149aDLxm4hg1e+4HTwdU6/kFCorLsg==
=Z15E
-----END PGP SIGNATURE-----

--YwEPc06ETMaecfD0RQschjcEXF21l3F2C--


