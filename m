Return-Path: <SRS0=p/0J=2J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 583A8C43603
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 10:34:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 240DF21D7D
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 10:34:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LxMxOAyp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 240DF21D7D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38412 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iht8R-0008VR-90
	for qemu-devel@archiver.kernel.org; Thu, 19 Dec 2019 05:34:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54852)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iht7M-0007Ma-Jh
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 05:33:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iht7L-0006EI-By
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 05:33:16 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:40833
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1iht7L-0006Ax-5w
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 05:33:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576751594;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=7dBpi92deU78GDVGs7pnvt2NwA65u9mAj1BisJg+Sgs=;
 b=LxMxOAypzah7XoBHWjhzyjwMmoV1KuMgYlubslrSDkEsLkRKlMuna1s1noYkz7JdbUiCZ8
 1arqvHFyGlTs2tDMRHah3BoFQlgO5/or10Xfef65MSqJGbqp3XCm2xmTI7AunB5L8XEKlE
 000LODm+LhLJOeHBIfgONGIF1nSwswU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-156-wqmzhOaOMHKePHM29X-NIA-1; Thu, 19 Dec 2019 05:33:10 -0500
X-MC-Unique: wqmzhOaOMHKePHM29X-NIA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 828EF107ACCD;
 Thu, 19 Dec 2019 10:33:09 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-205-138.brq.redhat.com
 [10.40.205.138])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id ED367675B8;
 Thu, 19 Dec 2019 10:33:07 +0000 (UTC)
Subject: Re: qcow2 api not secured by mutex lock
To: Kevin Wolf <kwolf@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
References: <1ea7f93d-8f48-d565-70e7-0d66f1b80c1e@virtuozzo.com>
 <20191219100230.GC5230@linux.fritz.box>
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
Message-ID: <7604ffdd-69b5-5968-1736-bb20736be135@redhat.com>
Date: Thu, 19 Dec 2019 11:33:05 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191219100230.GC5230@linux.fritz.box>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="ZKIx9se1B9Qhx5G6UWhcwvi3w52Uxfdx1"
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
Cc: qemu-devel <qemu-devel@nongnu.org>, qemu block <qemu-block@nongnu.org>,
 Denis Lunev <den@virtuozzo.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--ZKIx9se1B9Qhx5G6UWhcwvi3w52Uxfdx1
Content-Type: multipart/mixed; boundary="IPYxxIUw5paJCymqeh0mgomjbw1e6NyEL"

--IPYxxIUw5paJCymqeh0mgomjbw1e6NyEL
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 19.12.19 11:02, Kevin Wolf wrote:
> Am 18.12.2019 um 11:28 hat Vladimir Sementsov-Ogievskiy geschrieben:

[...]

>> qcow2_write_snapshots actually called unlocked from
>> qcow2_check_fix_snapshot_table.. It seems unsafe.
>=20
> This is curious, I'm not sure why you would drop the lock there. Max?

I don=E2=80=99t remember why but it may certainly have to do with the fact =
that
everything that calls qcow2_write_snapshots() (i.e., qcow2_snapshot_*)
does so without having taken the lock.  I suppose I simply assumed this
would have to be how it=E2=80=99s done.

I don=E2=80=99t think it=E2=80=99s a problem right now because you can only=
 check (and
repair) the image from qemu-img (or when it is opened with the dirty
flag set), so there shouldn=E2=80=99t be concurrent I/O.

Anyway.  I tried to remove it and then 261 hangs.  This is because
qcow2_write_snapshots() calls bdrv_flush(bs) twice.  It would have to
drop the lock around those calls at least.  I=E2=80=99m actually not sure
whether this is safe to do (in the sense of whether it=E2=80=99s fundamenta=
lly
safer than just not holding the lock at all and trusting that there are
no concurrent requests).

In any case, it=E2=80=99s also not purely trivial, because if we were to ma=
ke
qcow2_write_snapshots() drop the locks around bdrv_flush(), all of its
callers would in turn need to take the lock around it.  (I=E2=80=99m not sa=
ying
that is difficult, I=E2=80=99m just saying it=E2=80=99s more difficult than=
 dropping
three lines in qcow2_write_snapshots()).

Max


--IPYxxIUw5paJCymqeh0mgomjbw1e6NyEL--

--ZKIx9se1B9Qhx5G6UWhcwvi3w52Uxfdx1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl37UeEACgkQ9AfbAGHV
z0CJKAf/fx+JpfClEzIziMNtbbPiWAOq7Kvtp3krVvIg3QesQdLWSIHf03G61Syd
8Jl1WpQC8lzAxc3WfWBBzAh3STxj0e91n3tUx3gb38HtRpGpR1EIE/QMbdYPRwl9
iNB3l0S4f59MWIVN+fGNH3psY5JdI1/ll+kbLcwW4UzVH891ba4I/UTj2Ls9FkF8
JuvSQKOlOdPkk1CWxeYJ298PaaF0J8axRhfTey8xzN0bO5/1q0AGepr7VagDsv4r
920lA72xPppfpXAdY6nKO4BZqFrI0clc8NE4EZKkUY+vFR5LrjUbZMnFecQFm5Yr
NptRb3/4hvQTI/G7a2HZPQjobiQvGg==
=rLhF
-----END PGP SIGNATURE-----

--ZKIx9se1B9Qhx5G6UWhcwvi3w52Uxfdx1--


