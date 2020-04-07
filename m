Return-Path: <SRS0=U3m5=5X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F722C2BB1D
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Apr 2020 10:05:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 53DFB20771
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Apr 2020 10:05:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GjaRq7kE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 53DFB20771
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44412 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jLl7G-0007z6-Ht
	for qemu-devel@archiver.kernel.org; Tue, 07 Apr 2020 06:05:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39719)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1jLl5t-0006lK-Gw
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 06:04:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1jLl5r-0006rX-A4
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 06:04:32 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:39703
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1jLl5r-0006pk-4M
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 06:04:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1586253869;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=9jR2JvXNCKYIiMyqnMXRmojizuVOCspRY6x0P5x1kPY=;
 b=GjaRq7kE31GXeGGTMuo5e4+f2PgGy64ExMTuQ+DGk1Q/lD9jH68KIHNfWGHVxoKKiOwxpj
 q+OgM3EwO81ZhMM2FCAHmqCvz7xOJWALXgG5ppUWDBlTmGl54NEj9Sx9hHxMcnSt0nTJNy
 aQqGiIqlUOnwBkEExOsYuQkrxJdjHwc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-255-7Op43mIPPYew7D4NDKubtg-1; Tue, 07 Apr 2020 06:04:26 -0400
X-MC-Unique: 7Op43mIPPYew7D4NDKubtg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A0E73107ACC9;
 Tue,  7 Apr 2020 10:04:25 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-114-84.ams2.redhat.com
 [10.36.114.84])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 14F4F5E000;
 Tue,  7 Apr 2020 10:04:19 +0000 (UTC)
Subject: Re: [PATCH for-5.0 v2 2/3] block: Increase BB.in_flight for coroutine
 interfaces
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
References: <20200406171403.6761-1-kwolf@redhat.com>
 <20200406171403.6761-3-kwolf@redhat.com>
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
Message-ID: <5c5ee71e-f2d7-201d-73d1-2ee9a68b042a@redhat.com>
Date: Tue, 7 Apr 2020 12:04:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200406171403.6761-3-kwolf@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="z2DbYfHiarufDTS7JlYrNFJknEBZ5F25g"
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
Cc: vsementsov@virtuozzo.com, s.reiter@proxmox.com, qemu-devel@nongnu.org,
 t.lamprecht@proxmox.com, stefanha@redhat.com, dietmar@proxmox.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--z2DbYfHiarufDTS7JlYrNFJknEBZ5F25g
Content-Type: multipart/mixed; boundary="sZ4UUrRMWDPNdjvD8dihVciL438DENSYu"

--sZ4UUrRMWDPNdjvD8dihVciL438DENSYu
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 06.04.20 19:14, Kevin Wolf wrote:
> External callers of blk_co_*() don't currently increase the
> BlockBackend.in_flight counter, but calls from blk_aio_*() do, so there
> is an inconsistency whether the counter has been increased or not.
>=20
> This patch moves the actual operations to static functions that can
> later know they will always be called with in_flight increased exactly
> once, even for external callers using the blk_co_*() coroutine
> interfaces.
>=20
> If the public blk_co_*() interface is unused, remove it.
>=20
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  include/sysemu/block-backend.h |  1 -
>  block/block-backend.c          | 94 +++++++++++++++++++++++++++-------
>  2 files changed, 76 insertions(+), 19 deletions(-)

Reviewed-by: Max Reitz <mreitz@redhat.com>


--sZ4UUrRMWDPNdjvD8dihVciL438DENSYu--

--z2DbYfHiarufDTS7JlYrNFJknEBZ5F25g
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl6MUCIACgkQ9AfbAGHV
z0AWBQgAs1DmSFpq2vk9Oi7MtS2Is/mGBiMEL7yt304+LzM4jHUZtU2KyzJwsrJG
ZqYM5qNjfzmU5WYjDmXC4xzTtkNSPSOQTJjJPxPL6MjBCy25k4y4/LmgxGLC8FDe
5TOvNbKwPBQSUw6xVlGCE99NM+6ee/WXV7k2Pd+OYc9ZWGP4KRJGmZ8F3TERlcba
oKZJHTMjSYMECmJcbgknB1ftTIKVP4kjMvR/O9etWTjpXX6vpGyqOj0fMg30AkgC
8pnrFYJ66o0eMz6PXyOO8f6wxFqZAmCN1BJmlBwDrPcKTwe9v4v9vpsxI+eb4OsC
3NQ/Sc8k8Xd1XCZwLHV9sbXhbhL3Fg==
=XDrS
-----END PGP SIGNATURE-----

--z2DbYfHiarufDTS7JlYrNFJknEBZ5F25g--


