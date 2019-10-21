Return-Path: <SRS0=8ZcK=YO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B987ECA9EAF
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2019 16:25:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 815FD2084B
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2019 16:25:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cnP4bRZi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 815FD2084B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44976 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iMaUj-0002tQ-An
	for qemu-devel@archiver.kernel.org; Mon, 21 Oct 2019 12:25:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36950)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iMaTa-0001Yx-ER
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 12:24:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iMaTY-0000PR-E5
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 12:24:09 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:33397
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1iMaTY-0000PJ-99
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 12:24:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1571675047;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=M4ZktrOt37nID6Oq3gM8my+fwanJhwSG0QT7o5hj7Ls=;
 b=cnP4bRZi/+HWJDeTRl3mHw8kzjLQXA+hExhIozuGE+wD7DQudSz1uW54JWr13VBTcJDElg
 N3hf9uOhCTTywpaMEDYWCXc0yxZcDgSqTfimrWggE3zDUyVDoLAq9hHxVEvNg0D749fXl1
 fiNWCSadWFhtu3nnluKzTpVwDqhMK1M=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-180-gbq6a-oJOXu2dhdSOlRDWw-1; Mon, 21 Oct 2019 12:24:05 -0400
X-MC-Unique: gbq6a-oJOXu2dhdSOlRDWw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DA41E80183E;
 Mon, 21 Oct 2019 16:24:03 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-117-17.ams2.redhat.com
 [10.36.117.17])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 5B2F15D721;
 Mon, 21 Oct 2019 16:24:02 +0000 (UTC)
Subject: Re: Problems with c8bb23cbdbe3 on ppc64le
From: Max Reitz <mreitz@redhat.com>
To: Qemu-block <qemu-block@nongnu.org>
References: <2e7d321c-89f4-f3fd-8331-6bc276880de2@redhat.com>
 <120ab7dc-17dd-2796-95a3-8492ca40339e@redhat.com>
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
Message-ID: <2bf96cbd-0836-bd48-a2fc-84f5a630939d@redhat.com>
Date: Mon, 21 Oct 2019 18:24:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <120ab7dc-17dd-2796-95a3-8492ca40339e@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="iqYe2AT1f67IxPBytnhspwzdNajxZKYk9"
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
Cc: Alberto Garcia <berto@igalia.com>,
 Anton Nefedov <anton.nefedov@virtuozzo.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--iqYe2AT1f67IxPBytnhspwzdNajxZKYk9
Content-Type: multipart/mixed; boundary="MgQSVaDjDyl36tyE6thr5oPkaSTw6lsSu"

--MgQSVaDjDyl36tyE6thr5oPkaSTw6lsSu
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 21.10.19 15:33, Max Reitz wrote:
> On 10.10.19 17:17, Max Reitz wrote:
>> Hi everyone,
>>
>> (CCs just based on tags in the commit in question)
>>
>> I have two bug reports which claim problems of qcow2 on XFS on ppc64le
>> machines since qemu 4.1.0.  One of those is about bad performance
>> (sorry, is isn=E2=80=99t public :-/), the other about data corruption
>> (https://bugzilla.redhat.com/show_bug.cgi?id=3D1751934).
>>
>> It looks like in both cases reverting c8bb23cbdbe3 solves the problem
>> (which optimized COW of unallocated areas).
>>
>> I think I=E2=80=99ve looked at every angle but can=E2=80=98t find what c=
ould be wrong
>> with it.  Do any of you have any idea? :-/
>=20
> I now have a reproducer with CentOS, so it=E2=80=99s actually useful outs=
ide of
> Red Hat:

I=E2=80=99ve run this test with various configurations, and the installatio=
n
does not fail on tmpfs, ext4, btrfs; or without cache.direct=3Don,aio=3Dnat=
ive.

(So the installation only fails on xfs and aio=3Dnative.  I=E2=80=99ve trie=
d both
virtio-scsi and virtio-blk, but it fails with both.  I did test a
loop-mounted xfs volume, and the installation fails there, too,
regardless of whether the raw xfs image is placed on ext4 or tmpfs.[1])

Unfortunately I still don=E2=80=99t have a more concise reproducer that wou=
ld
clearly show that this is a kernel bug.  So for the time being I still
don=E2=80=99t know what causes it.

Max


--MgQSVaDjDyl36tyE6thr5oPkaSTw6lsSu--

--iqYe2AT1f67IxPBytnhspwzdNajxZKYk9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl2t26AACgkQ9AfbAGHV
z0BWHAgAncLySNYTvnCFT/VK2KORu9SsJ0zmS6gfbLnpDDXK4BoMyCISbo/Awc+8
uJHXMcC3GCLfdyHiio2dkaYeMG4InZ0VgJ9nYNL2XelNgZd4dOvO3mhcCcYzmHUG
EAza9TwESv4W7NK83tqJ5iRWxPF8BQDl/DgdGDZwhgv6qrIalhq8iycSaQyQ1+Uj
cKfFgF8/niRVzWAFujFKgAiXzzSlTXUn3BD90q2oi9bbOUmmX+SfNGNw6Pj+05rS
FRoNweUPd7iM694WHshGkd1h92cGL6fhccMMtHA4kGwMg8H1FH3D7OfwJfLDzpJz
zZEEXiZo/hvFvdBEzovAyW8hMKR7ww==
=cG+b
-----END PGP SIGNATURE-----

--iqYe2AT1f67IxPBytnhspwzdNajxZKYk9--


