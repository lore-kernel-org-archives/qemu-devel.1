Return-Path: <SRS0=rlpO=32=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BBDDC33CAC
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 17:50:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3D11420659
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 17:50:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JLZsCj0q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D11420659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43790 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izlIV-00051w-AU
	for qemu-devel@archiver.kernel.org; Thu, 06 Feb 2020 12:50:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45270)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1izl5A-0005xY-Pw
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 12:36:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1izl59-00029K-L4
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 12:36:52 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:21453
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1izl59-00025s-Ge
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 12:36:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581010611;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=YLDPp9Yt4RyO3eCBc5XMxuT974oJo9Mil4MTGGoWNeQ=;
 b=JLZsCj0qH6YJ47fBc8nL+cVdl04iSNjC/EL9Sj6wRy7uTK9HvxUQq643139gBH3U9ZZnTr
 xjcluy5UI60rKt4aQy4LXEYOTWIVh6wK3Z94aXPWWWW6O1gssfZkMruAEQrzh2RmdlZVQX
 qAXaq6iyl3VaAKk6L4slgMdgraRLhlM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-350-_6llcb51MU2r-NWcGJAvbQ-1; Thu, 06 Feb 2020 12:36:46 -0500
X-MC-Unique: _6llcb51MU2r-NWcGJAvbQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DAD5D8018C6;
 Thu,  6 Feb 2020 17:36:44 +0000 (UTC)
Received: from dresden.str.redhat.com (unknown [10.36.118.15])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C978460F89;
 Thu,  6 Feb 2020 17:36:37 +0000 (UTC)
Subject: Re: [PATCH] block: fix crash on zero-length unaligned write and read
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org
References: <20200206164245.17781-1-vsementsov@virtuozzo.com>
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
Message-ID: <ac4dc8b4-1057-673b-b7cd-70efbc81daab@redhat.com>
Date: Thu, 6 Feb 2020 18:36:36 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200206164245.17781-1-vsementsov@virtuozzo.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="in9zyM9S9k2s2A5mbfhXP1U6L6kbdJRuE"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: kwolf@redhat.com, fam@euphon.net, qemu-devel@nongnu.org,
 stefanha@redhat.com, qemu-stable@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--in9zyM9S9k2s2A5mbfhXP1U6L6kbdJRuE
Content-Type: multipart/mixed; boundary="rBBcLTF1LKioX95McHy3E6Mgm6X49IAd8"

--rBBcLTF1LKioX95McHy3E6Mgm6X49IAd8
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 06.02.20 17:42, Vladimir Sementsov-Ogievskiy wrote:
> Commit 7a3f542fbd "block/io: refactor padding" occasionally dropped
> aligning for zero-length request: bdrv_init_padding() blindly return
> false if bytes =3D=3D 0, like there is nothing to align.
>=20
> This leads the following command to crash:
>=20
> ./qemu-io --image-opts -c 'write 1 0' \
>   driver=3Dblkdebug,align=3D512,image.driver=3Dnull-co,image.size=3D512
>=20
>>> qemu-io: block/io.c:1955: bdrv_aligned_pwritev: Assertion
>     `(offset & (align - 1)) =3D=3D 0' failed.
>>> Aborted (core dumped)
>=20
> Prior to 7a3f542fbd we does aligning of such zero requests. Instead of
> recovering this behavior let's just do nothing on such requests as it
> is useless.
>=20
> Note that driver may have special meaning of zero-length reqeusts, like
> qcow2_co_pwritev_compressed_part, so we can't skip any zero-length
> operation. But for unaligned ones, we can't pass it to driver anyway.
>=20
> This commit also fixes crash in iotest 80 running with -nocache:
>=20
> ./check -nocache -qcow2 80
>=20
> which crashes on same assertion due to trying to read empty extra data
> in qcow2_do_read_snapshots().
>=20
> Cc: qemu-stable@nongnu.org # v4.2
> Fixes: 7a3f542fbd
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>  block/io.c | 28 +++++++++++++++++++++++++++-
>  1 file changed, 27 insertions(+), 1 deletion(-)

Zero-length reads would still trigger CORs when padded.  But there is no
reason to assume or rely on this, so:

Reviewed-by: Max Reitz <mreitz@redhat.com>

(block/io.c is Stefan=92s department. :-))

Max


--rBBcLTF1LKioX95McHy3E6Mgm6X49IAd8--

--in9zyM9S9k2s2A5mbfhXP1U6L6kbdJRuE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl48TqQACgkQ9AfbAGHV
z0BO2wgAt2th9y1PawpD8fmlq4NlvJcaE2A7SC2X7F7hSLAJPYiXLlsnPym4c/nt
haKEnLCqNXHlNpVhEYbS463L69XoJ1p8NPTuqHvUu9qqkk/i+sTVrwfprWtjMnbC
bMUmCPO/ctb0xVRnWyKjiLAawXtvM67LtWqaCpvwK/CH9Ust9OoyGE1BCs8PHc9l
He2uYuvuKHdUHl5MsqCPnHGeDMxa9uWwMMqBrAncRsc3OsHufz1Kv1NIdzC9zWVy
k28FWAvKvYh+DtwI9eYo5i0aI5ISzX+ATJ8LJEwUBnPgYb92o6VHuIo2T5+OY/9k
Q2eZtVkB4ePCXQf9BvsZKesgrXz+vw==
=FkAa
-----END PGP SIGNATURE-----

--in9zyM9S9k2s2A5mbfhXP1U6L6kbdJRuE--


