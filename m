Return-Path: <SRS0=Q6KP=2B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E6D1C43603
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2019 07:10:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5B4D020836
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2019 07:10:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZCQvR+0i"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B4D020836
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39406 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iew8Q-0000ht-GP
	for qemu-devel@archiver.kernel.org; Wed, 11 Dec 2019 02:10:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57485)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iew7k-0000Eg-FI
 for qemu-devel@nongnu.org; Wed, 11 Dec 2019 02:09:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iew7h-0000G5-Fv
 for qemu-devel@nongnu.org; Wed, 11 Dec 2019 02:09:26 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:35683)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1iew7h-0000DH-8S
 for qemu-devel@nongnu.org; Wed, 11 Dec 2019 02:09:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576048164;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=/eFChM1uzr6GTD4nc0lLA3g3f5mNeVkqshrWOPNNsvA=;
 b=ZCQvR+0iOsfx4GMwQeUR3NVFFzrwgTo03M7h1Igub5MvnaS1rl0V62u2rc+s3UsG103pGK
 45NZVR8IwopheJGf815v7r9SbjEQhlaJLHsyVdPK8nPdh8vW8FGYM2EiqQEXqLz4VnrpFl
 ZlfcjkvKshAMYN3wAeG7kvcs1gUz0hA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-9-mFuj1QC0Nji4bueo512GSg-1; Wed, 11 Dec 2019 02:09:18 -0500
X-MC-Unique: mFuj1QC0Nji4bueo512GSg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1EFF58024D6;
 Wed, 11 Dec 2019 07:09:17 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-116-167.ams2.redhat.com
 [10.36.116.167])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 752E5707A4;
 Wed, 11 Dec 2019 07:09:12 +0000 (UTC)
Subject: Re: [PATCH for-4.2? v3 0/8] block: Fix resize (extending) of short
 overlays
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
References: <20191122160511.8377-1-kwolf@redhat.com>
 <20191210174644.GC7103@linux.fritz.box>
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
Message-ID: <019ced4d-04ea-6a3d-ec6b-bb0d5fdd37d6@redhat.com>
Date: Wed, 11 Dec 2019 08:09:10 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191210174644.GC7103@linux.fritz.box>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="VmFhrwo0xpjamylzFpVAwtZXnyCD2ehd0"
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
Cc: vsementsov@virtuozzo.com, qemu-devel@nongnu.org, stefanha@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--VmFhrwo0xpjamylzFpVAwtZXnyCD2ehd0
Content-Type: multipart/mixed; boundary="J00KcfWdHo8pqd6HeO9BHiGk8q04a5lZZ"

--J00KcfWdHo8pqd6HeO9BHiGk8q04a5lZZ
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 10.12.19 18:46, Kevin Wolf wrote:
> Am 22.11.2019 um 17:05 hat Kevin Wolf geschrieben:
>> See patch 4 for the description of the bug fixed.
>=20
> I'm applying patches 3 and 5-7 to the block branch because they make
> sense on their own.
>=20
> The real fix will need another approach because the error handling is
> broken in this one: If zeroing out fails (either because of NO_FALLBACK
> or because of some other I/O error), bdrv_co_truncate() will return
> failure, but the image size has already been increased, with potentially
> incorrect data in the new area.
>=20
> To fix this, we need to make sure that zeros will be read before we
> commit the new image size to the image file (e.g. qcow2 header) and to
> bs->total_sectors. In other words, it must become the responsibility of
> the block driver.
>=20
> To this effect, I'm planning to introduce a PREALLOC_MODE_ZERO_INIT flag
> that can be or'ed to the preallocation mode. This will fail by default
> because it looks like just another unimplemented preallocation mode to
> block drivers. It will be requested explicitly by commit jobs and
> automatically added by bdrv_co_truncate() if the backing file would
> become visible (like in this series, but now for all preallocation
> modes). I'm planning to implement it for qcow2 and file-posix for now,
> which should cover most interesting cases.
>=20
> Does this make sense to you?

Sounds good to me.

Max


--J00KcfWdHo8pqd6HeO9BHiGk8q04a5lZZ--

--VmFhrwo0xpjamylzFpVAwtZXnyCD2ehd0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl3wlhYACgkQ9AfbAGHV
z0CMsAgAmMlPkphGl3gyJC6zda7Og6l2UtNrhhFJj/bQ5k2+Ez7Ysobdf1R6zmC+
VH4TUdrD+8aeXxI6M+MKbr1Z7oZbvuLvsh9yek2i7Eu90v1ftrcuJzkrmNjhgW0q
hERpc1nZOYtB1FlNkMDpw15RGKsXY8iW6AmeiFnEzqRITZc2UYFVe+UOadYlif4c
cjSqEWYJAiuutBAp3zDwGiKhtMDTjnU7RK4jSnVolM6rNPEfAw2v+f8keIgOwWAA
o8HAgn4FBgScmjQlJExwSKCDF9MlAU0ui6XHg8P4fBdxGMPBu14j1bTKaqEtHp3f
CSBsDmxnU8K8yC7vCe1RA0xDcDPdQQ==
=Lpop
-----END PGP SIGNATURE-----

--VmFhrwo0xpjamylzFpVAwtZXnyCD2ehd0--


