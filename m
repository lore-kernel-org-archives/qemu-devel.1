Return-Path: <SRS0=/cID=ZR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A76B6C432C0
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Nov 2019 12:02:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7650C2075C
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Nov 2019 12:02:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TGEprCKk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7650C2075C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42686 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iZD47-0000Xf-AU
	for qemu-devel@archiver.kernel.org; Mon, 25 Nov 2019 07:02:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56257)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iZD2t-0008DQ-4v
 for qemu-devel@nongnu.org; Mon, 25 Nov 2019 07:00:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iZD2r-0006a3-LT
 for qemu-devel@nongnu.org; Mon, 25 Nov 2019 07:00:46 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:22033
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1iZD2r-0006Zu-Hp
 for qemu-devel@nongnu.org; Mon, 25 Nov 2019 07:00:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574683245;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=i3bH86M0F4tQW0UlsxlTEfV1rB1JEjM6pZo7Mg8LwZQ=;
 b=TGEprCKkP5VIkkeIdmg9+p/SQb1PBwnbijrMfvOnFDS33OqjRDWqLgKoY49YIXQoLf+qP9
 T7yzwkMKOXpCcH6rX1u1iIj7oFGd/5JLkXadKxf0b+L9W0EduagdaKGQuqvml2J+EPKHaU
 0QmPPOC6uGU4wh+2an4NIgwomI/kRY8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-257-b0a1QUMKNF2IRYgFvCNUzA-1; Mon, 25 Nov 2019 07:00:35 -0500
X-MC-Unique: b0a1QUMKNF2IRYgFvCNUzA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A29FD18557C4;
 Mon, 25 Nov 2019 12:00:34 +0000 (UTC)
Received: from dresden.str.redhat.com (unknown [10.40.205.102])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 46169600C6;
 Mon, 25 Nov 2019 12:00:28 +0000 (UTC)
Subject: Re: [PATCH v3 2/8] block: Add no_fallback parameter to
 bdrv_co_truncate()
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
References: <20191122160511.8377-1-kwolf@redhat.com>
 <20191122160511.8377-3-kwolf@redhat.com>
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
Message-ID: <8e67b160-02db-4b09-4748-405f740bd159@redhat.com>
Date: Mon, 25 Nov 2019 13:00:26 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191122160511.8377-3-kwolf@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="4EHgTfzB8YM64oICHkTGfhq7RGpqSo5L7"
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
--4EHgTfzB8YM64oICHkTGfhq7RGpqSo5L7
Content-Type: multipart/mixed; boundary="SWY9hWP3awADlbI5ySBRG85H43Rs5Cmys"

--SWY9hWP3awADlbI5ySBRG85H43Rs5Cmys
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 22.11.19 17:05, Kevin Wolf wrote:
> This adds a no_fallback parameter to bdrv_co_truncate(), bdrv_truncate()
> and blk_truncate() in preparation for a fix that potentially needs to
> zero-write the new area. no_fallback will use BDRV_REQ_NO_FALLBACK for
> this operation and lets the truncate fail if an efficient zero write
> isn't possible.
>=20
> Only qmp_block_resize() passes true for this parameter because it is a
> blocking monitor command, so we don't want to add more potentially slow
> I/O operations to it than we already have.
>=20
> All other users will accept even a slow fallback to avoid failure.
>=20
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  include/block/block.h          |  5 +++--
>  include/sysemu/block-backend.h |  2 +-
>  block/block-backend.c          |  4 ++--
>  block/commit.c                 |  4 ++--
>  block/crypto.c                 |  4 ++--
>  block/io.c                     | 16 ++++++++++++----
>  block/mirror.c                 |  2 +-
>  block/parallels.c              |  6 +++---
>  block/qcow.c                   |  4 ++--
>  block/qcow2-refcount.c         |  2 +-
>  block/qcow2.c                  | 19 +++++++++++--------
>  block/qed.c                    |  2 +-
>  block/raw-format.c             |  2 +-
>  block/vdi.c                    |  2 +-
>  block/vhdx-log.c               |  2 +-
>  block/vhdx.c                   |  6 +++---
>  block/vmdk.c                   | 10 ++++++----
>  block/vpc.c                    |  2 +-
>  blockdev.c                     |  2 +-
>  qemu-img.c                     |  2 +-
>  qemu-io-cmds.c                 |  2 +-
>  tests/test-block-iothread.c    |  6 +++---
>  22 files changed, 60 insertions(+), 46 deletions(-)

With the typo pointed out by Eric fixed:

Reviewed-by: Max Reitz <mreitz@redhat.com>


--SWY9hWP3awADlbI5ySBRG85H43Rs5Cmys--

--4EHgTfzB8YM64oICHkTGfhq7RGpqSo5L7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl3bwloACgkQ9AfbAGHV
z0BWQggAic7tERxJ8MnT7pkutgx9GlLVudAPczERyJCuZN+7Z4vGhJeo641/d3OD
b3F2232G1yrV41BwIai8XamwZUz1xuSkfY3XszOgETt4Aw3vAmaeAjlzqrM+cZnR
SMacE4plEVE69UG5yLa87BCWqLVJyhp8IMQ/IPESJBGJR4TI5cmAUhY9dV8nRmOh
+xN00+b5bczcyCVmg6tS3/jJBQ07EHjtxLaYRVLxAF3kH3V8RIOAeg/70ptCOu24
/oJQXwRutm/l06vIu5ID57AUPjR0ZcRyOZiYIrSQk1VGQa2i29RGPhWIDuC+GmIq
+q9AG+WQJxifP2Qyc/CiP9fV/cyXsA==
=4md2
-----END PGP SIGNATURE-----

--4EHgTfzB8YM64oICHkTGfhq7RGpqSo5L7--


