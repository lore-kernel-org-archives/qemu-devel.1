Return-Path: <SRS0=KlJF=Y4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 348A1CA9EA0
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2019 11:22:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ED9FC217F4
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2019 11:22:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CyZErMCf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED9FC217F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59680 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iRaRH-0006tN-44
	for qemu-devel@archiver.kernel.org; Mon, 04 Nov 2019 06:22:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60384)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iRaQS-0006LJ-Cq
 for qemu-devel@nongnu.org; Mon, 04 Nov 2019 06:21:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iRaQQ-00064Y-68
 for qemu-devel@nongnu.org; Mon, 04 Nov 2019 06:21:35 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:48614
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1iRaQQ-000646-1D
 for qemu-devel@nongnu.org; Mon, 04 Nov 2019 06:21:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1572866493;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=M1QMtdv7cTF+gPfUDLky0FK509hNv0WQqa+ZO+tcFXQ=;
 b=CyZErMCf13UfMBkxqyODsuj8W0KG3mwZe0egXggSDTnsYyuGP3NOLNEi/M9uauESy3f1LC
 1T7aMTE+F/Nr8QoKwnZNJ8j0D16kQB5Bg1JFMNVoZbubm5JmwWAFvknzWpD5oVB/BHpM1C
 xX6ogMWqql3dMTerahy60Up9WFem2rk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-162-mvf_xX93N62ZigSKxgEO-A-1; Mon, 04 Nov 2019 06:21:29 -0500
X-MC-Unique: mvf_xX93N62ZigSKxgEO-A-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B6BEA477;
 Mon,  4 Nov 2019 11:21:28 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-117-85.ams2.redhat.com
 [10.36.117.85])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 9442960863;
 Mon,  4 Nov 2019 11:21:24 +0000 (UTC)
Subject: Re: bitmaps -- copying allocation status into dirty bitmaps
To: John Snow <jsnow@redhat.com>, Qemu-block <qemu-block@nongnu.org>
References: <b9b55376-3d6d-5dc2-2db3-bdced9e2d46a@redhat.com>
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
Message-ID: <f9611252-ee6a-c966-e625-1295bc7fe11e@redhat.com>
Date: Mon, 4 Nov 2019 12:21:23 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <b9b55376-3d6d-5dc2-2db3-bdced9e2d46a@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="JiDecQvIuvsyrX3r54DYFeLVj4LTp1TbD"
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
Cc: Kevin Wolf <kwolf@redhat.com>, "Denis V. Lunev" <den@openvz.org>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--JiDecQvIuvsyrX3r54DYFeLVj4LTp1TbD
Content-Type: multipart/mixed; boundary="HAXhhUs2VADnhvrfgcI6W6218e0q6ejHl"

--HAXhhUs2VADnhvrfgcI6W6218e0q6ejHl
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 01.11.19 16:42, John Snow wrote:
> Hi, in one of my infamously unreadable and long status emails, I
> mentioned possibly wanting to copy allocation data into bitmaps as a way
> to enable users to create (external) snapshots from outside of the
> libvirt/qemu context.
>=20
> (That is: to repair checkpoints in libvirt after a user extended the
> backing chain themselves, you want to restore bitmap information for
> that node. Conveniently, this information IS the allocation map, so we
> can do this.)
>=20
> It came up at KVM Forum that we probably do want this, because oVirt
> likes the idea of being able to manipulate these chains from outside of
> libvirt/qemu.
>=20
> Denis suggested that instead of a new command, we can create a special
> name -- maybe "#ALLOCATED" or something similar that can never be
> allocated as a user-defined bitmap name -- as a special source for the
> merge command.
>=20
> You'd issue a merge from "#ALLOCATED" to "myBitmap0" to copy the current
> allocation data into "myBitmap0", for instance.

Sounds fun, but is there actually any use for this if the only purpose
is to work as a source for merge?

I mean, it would be interesting if it worked exactly like a perma-RO
pseudo-bitmap that whenever you try to get data from it performs a
block-status call.  But as you say, that would probably be too slow, and
it would take a lot of code modifications, so I wonder if there is
actually any purpose for this.

> Some thoughts:
>=20
> - The only commands where this pseudo-bitmap makes sense is merge.
> enable/disable/remove/clear/add don't make sense here.
>=20
> - This pseudo bitmap might make sense for backup, but it's not needed;
> you can just merge into an empty/enabled bitmap and then use that.
>=20
> - Creating an allocation bitmap on-the-fly is probably not possible
> directly in the merge command, because the disk status calls might take
> too long...
>=20
> Hm, actually, I'm not sure how to solve that one. Merge would need to
> become a job (or an async QMP command?) or we'd need to keep an
> allocation bitmap object around and in-sync. I don't really want to do
> either, so maybe I'm missing an obvious/better solution.

All of what you wrote in this mail makes me think it would make much
more sense to just add a =E2=80=9Cblock-dirty-bitmap-create-from=E2=80=9D j=
ob with an
enum of targets.  (One of which would be =E2=80=9Callocated-blocks=E2=80=9D=
.)

Max


--HAXhhUs2VADnhvrfgcI6W6218e0q6ejHl--

--JiDecQvIuvsyrX3r54DYFeLVj4LTp1TbD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl3ACbMACgkQ9AfbAGHV
z0AOIggAwftyXdeYT5c7qwjGZrrhvZMhlENkkXxbV791oHFDaWp2kGiGRWWnbjdr
LtTFy4ec70QRIPIvTt5/XsxBhFVJgCAtSxE+HO8ec5IJxB7tdCBf8VeK+Yvbaq17
WfaujlBkDcZ7ep7IxVAMl1V3a+V3actp24OXafT1aWEEweqKk8VGGlfgH8Phj8st
rRXEQabp1cue7BF0iLDCy79TxzctZN6wg7Qjh7ok8m6lVWsbVc619Qjjr5gFE2+p
Nwaf3bEmcLA3vNj4DYkJRKaH1/3Y0TeNkS/KFR2sJ0HFxOga0p+xwbhemVLL7OeY
uwvc8YHkhv0TgnUvx19gLUQUtuA1Rw==
=MKC3
-----END PGP SIGNATURE-----

--JiDecQvIuvsyrX3r54DYFeLVj4LTp1TbD--


