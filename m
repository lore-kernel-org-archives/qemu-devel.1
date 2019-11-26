Return-Path: <SRS0=u80H=ZS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35E99C432C0
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Nov 2019 10:39:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0268620748
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Nov 2019 10:39:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fcF4STFK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0268620748
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52508 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iZYFG-0000GQ-MK
	for qemu-devel@archiver.kernel.org; Tue, 26 Nov 2019 05:38:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59802)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iZY8X-00019y-UH
 for qemu-devel@nongnu.org; Tue, 26 Nov 2019 05:32:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iZY8W-00062M-Eo
 for qemu-devel@nongnu.org; Tue, 26 Nov 2019 05:32:01 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:44198
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1iZY8W-00061x-9r
 for qemu-devel@nongnu.org; Tue, 26 Nov 2019 05:32:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574764319;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=4Tv68wMNZkdHzYr4BALoPRADeU6Klt3QWg7QPQj7Ebw=;
 b=fcF4STFKUh6t1zP3Nk+Mc0hkSX78Nt8azjeFQIBR+giQ7tY6f9SSsBaK4I3HCgu8x7wf1b
 2zPv0y7Y0+K4uVxwrHL8ITWZXuS1Vmz8IGb+/4F4EvJyFhrv8hUMTLvrIe2vJcZ04RZe6v
 skTN7ri2niX7Ln7G44/JQ1XKtNUAt6U=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-288-N-7_9dC3N3a1eCYIPq5tlw-1; Tue, 26 Nov 2019 05:31:56 -0500
X-MC-Unique: N-7_9dC3N3a1eCYIPq5tlw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 56AED18557EA;
 Tue, 26 Nov 2019 10:31:55 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-204-240.brq.redhat.com
 [10.40.204.240])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id BFE0A600C6;
 Tue, 26 Nov 2019 10:31:53 +0000 (UTC)
Subject: Re: [PATCH for-4.2 0/2] Fix bitmap migration
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org
References: <20191125125229.13531-1-vsementsov@virtuozzo.com>
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
Message-ID: <3f25f814-24be-cc3d-770a-8ad9d3be5993@redhat.com>
Date: Tue, 26 Nov 2019 11:31:52 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191125125229.13531-1-vsementsov@virtuozzo.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="WmyL9Rw1NAvt2RKaIkXQnHIeWd988y4Ue"
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
Cc: kwolf@redhat.com, jsnow@redhat.com, qemu-devel@nongnu.org,
 qemu-stable@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--WmyL9Rw1NAvt2RKaIkXQnHIeWd988y4Ue
Content-Type: multipart/mixed; boundary="HsnE1kDWNdmVjTcjzjhlvvxUlVwmXZzNQ"

--HsnE1kDWNdmVjTcjzjhlvvxUlVwmXZzNQ
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 25.11.19 13:52, Vladimir Sementsov-Ogievskiy wrote:
> Hi all!
>=20
> We've faced a bug in rhev-2.12.0-33.el7-based Qemu.
> In upstream, bug introduced in 4.0 by 74da6b943565c45
> "block/dirty-bitmaps: implement inconsistent bit" commit.
> At this commit we started to load inconsistent bitmap instead of
> silently ignoring them, and it now I see that it breaks migration.
>=20
> The fix is very simple, so I think it's OK for 4.2.. Still, it's not a
> degradation, so we may postpone it to 5.0.
>=20
> Vladimir Sementsov-Ogievskiy (2):
>   block/qcow2-bitmap: fix bitmap migration
>   iotests: add new test cases to bitmap migration
>=20
>  block/qcow2-bitmap.c       | 21 ++++++++++++++++++++-
>  tests/qemu-iotests/169     | 22 +++++++++++++++-------
>  tests/qemu-iotests/169.out |  4 ++--
>  3 files changed, 37 insertions(+), 10 deletions(-)

Thanks, applied to my block branch:

https://git.xanclic.moe/XanClic/qemu/commits/branch/block

Max


--HsnE1kDWNdmVjTcjzjhlvvxUlVwmXZzNQ--

--WmyL9Rw1NAvt2RKaIkXQnHIeWd988y4Ue
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl3c/xgACgkQ9AfbAGHV
z0DifQf9FNpOlItmDiEkkDhpLXLXd/24tehJa63xCpQBAg0F6xvOjTp+LBCN27D/
8xkmDpmZouPgfDS4me5DhYopVQY5jumYZ0dv/WuZzm35+GHSgw2+VuzLm07k0CX0
XJzzMIs56V4/XFduN+59g05YUl4uB1sHLz8PzO78T4xB2vZVYkAoCbMCfyJIvQ22
767sWBhq+5vSmYHkV8bkw4DXBcNkxQ9rtJsz7nlk1HqgVr42Cj4eBb2grTMklnuC
5Wald6ytlio9hh1NOjH+pafsA89oAzFBI3va6S+Rd8MV5YhUmh+rGLAcY9M9dn+G
NXPI19XRC/TNMtCsU0/AZHMirfsCxw==
=UQ9e
-----END PGP SIGNATURE-----

--WmyL9Rw1NAvt2RKaIkXQnHIeWd988y4Ue--


