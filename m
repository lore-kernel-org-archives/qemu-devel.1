Return-Path: <SRS0=NHD5=ZG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55F39C432C3
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2019 17:22:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 190CB206CC
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2019 17:22:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gWcfizSa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 190CB206CC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60214 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iVIpN-0005ao-Au
	for qemu-devel@archiver.kernel.org; Thu, 14 Nov 2019 12:22:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55831)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iVIjY-000189-GE
 for qemu-devel@nongnu.org; Thu, 14 Nov 2019 12:16:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iVIjX-0001T7-CQ
 for qemu-devel@nongnu.org; Thu, 14 Nov 2019 12:16:40 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:50811
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1iVIjX-0001Rl-83
 for qemu-devel@nongnu.org; Thu, 14 Nov 2019 12:16:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573751798;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=WtHuauGgalHX/tLruBd3DQ+I7aAKgFnx23xEMpphl2I=;
 b=gWcfizSa7FK2HSGTfa3yQldJ/VcvYG2XIxFiOQbc5+j/A5ckbjHbUb1eFtalFwNikzK4UA
 lFN5v8TWGnqFDonNYrSgFhNy6I2CwwDAMSMfQSZg0CpfiN++yczJ+rpMpwQbjB1tuoet//
 D04QsH7ilEtU6AC1+2cijBtw9K7rrTs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-55-yYpulzwvPTuKRWCRNouAzw-1; Thu, 14 Nov 2019 12:16:35 -0500
X-MC-Unique: yYpulzwvPTuKRWCRNouAzw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F1FC2107ACC7;
 Thu, 14 Nov 2019 17:16:33 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-117-160.ams2.redhat.com
 [10.36.117.160])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A7081608B3;
 Thu, 14 Nov 2019 17:16:26 +0000 (UTC)
Subject: Re: [PATCH for-4.2 v2 3/3] block/file-posix: Let post-EOF fallocate
 serialize
From: Max Reitz <mreitz@redhat.com>
To: Christoph Hellwig <hch@infradead.org>
References: <20191101152510.11719-1-mreitz@redhat.com>
 <20191101152510.11719-4-mreitz@redhat.com>
 <20191114162751.GA29976@infradead.org>
 <e5e9e5d8-caf9-1077-1441-c11ae3d23696@redhat.com>
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
Message-ID: <94c4557a-ad98-ae2d-b7aa-b3c85f288a50@redhat.com>
Date: Thu, 14 Nov 2019 18:16:22 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <e5e9e5d8-caf9-1077-1441-c11ae3d23696@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="oCiZwDmrs3hxDjdUGXNPBKKJ2xCx8DqVS"
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
 qemu-block@nongnu.org, qemu-stable@nongnu.org, qemu-devel@nongnu.org,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, "Denis V . Lunev" <den@openvz.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--oCiZwDmrs3hxDjdUGXNPBKKJ2xCx8DqVS
Content-Type: multipart/mixed; boundary="j23zGuX2BvQ0N1WWbce5nw3zh7QjCdWj1"

--j23zGuX2BvQ0N1WWbce5nw3zh7QjCdWj1
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 14.11.19 18:15, Max Reitz wrote:
> On 14.11.19 17:27, Christoph Hellwig wrote:
>> On Fri, Nov 01, 2019 at 04:25:10PM +0100, Max Reitz wrote:
>>> The XFS kernel driver has a bug that may cause data corruption for qcow=
2
>>> images as of qemu commit c8bb23cbdbe32f.  We can work around it by
>>> treating post-EOF fallocates as serializing up until infinity (INT64_MA=
X
>>> in practice).
>>
>> This has been fixed in the kernel a while ago.  I don't think it makes
>> sense to work around it in qemu.
>=20
> Has it?  It was my understanding that this is fixed by
> https://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git/commit/?h=3Dfor-next&=
id=3D249bd9087a5264d2b8a974081870e2e27671b4dcwhich

Sorry, broke the link.  Let me try again:

https://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git/commit/?h=3Dfor-next&id=
=3D249bd9087a5264d2b8a974081870e2e27671b4dc

Max

> has been merged only very recently and is on track to be part of Linux
> 5.5, as far as I understand.
>=20
> Max
>=20



--j23zGuX2BvQ0N1WWbce5nw3zh7QjCdWj1--

--oCiZwDmrs3hxDjdUGXNPBKKJ2xCx8DqVS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl3Ni+YACgkQ9AfbAGHV
z0DQ0wf9HiYtrQ/5ViQ/cGFo8iESRg72n07lmJBOADQIy55p/K7HSu2TghCWgOkv
mLz6TSIuE79KcrM9lkJkp/JSlBlr7AJagQaIpdashEXJ9dsUyg8X1Gtd3czn0GuN
JlTTX94/DLNB5HFW1lJ7iOw1NRcaCJybORGzaM2y50+WPIJU0sttxo/BdPl1xLUD
r2fvMm9Cc/D5DKHzez3MnbSFFZR92OtcsVC0S90LVm9rd/ZXHLgXR5c4SqL1s5SP
bDln/yJl0Ge7fHiQDxH58GwX5FCjUVIgUn5wP6rzCsVySYJxk7VUVlPfSwHUs4ZL
FHzkDlGNFwp37ppl6/+B0GBvfMBMYQ==
=8qCE
-----END PGP SIGNATURE-----

--oCiZwDmrs3hxDjdUGXNPBKKJ2xCx8DqVS--


