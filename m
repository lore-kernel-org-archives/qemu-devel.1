Return-Path: <SRS0=URa6=5T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91D4BC43331
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Apr 2020 12:44:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 58A4220659
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Apr 2020 12:44:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cZXAaeHu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 58A4220659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54844 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jKLgp-0007QB-Gk
	for qemu-devel@archiver.kernel.org; Fri, 03 Apr 2020 08:44:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54796)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1jKLee-0005Jt-I7
 for qemu-devel@nongnu.org; Fri, 03 Apr 2020 08:42:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1jKLec-0005w4-J4
 for qemu-devel@nongnu.org; Fri, 03 Apr 2020 08:42:36 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:26135
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1jKLec-0005va-Ed
 for qemu-devel@nongnu.org; Fri, 03 Apr 2020 08:42:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585917754;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=oKYImRbzPwtf1YsDs/j9HzELgt6ZLV727Qu2d0hHjI4=;
 b=cZXAaeHuWW7bkTxYzdx0P+DeIWZHswFvQ1hOROza2OYMXm++ftsOfWv4eKfSwdHxv7EGok
 Yf7WzGTDUMgzdGHPCPSv4yuuOAwuVmiFUm1ilnKeGXFvvQpxnUCRb81hY1ggTCVjoGyfkH
 +iXO4wHQOfHb2P3J94HIW5PAWH/Lot4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-394-dlDz4pBRPN2kkK_Pr4mWkA-1; Fri, 03 Apr 2020 08:42:31 -0400
X-MC-Unique: dlDz4pBRPN2kkK_Pr4mWkA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9295C104FC01;
 Fri,  3 Apr 2020 12:42:30 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-113-97.ams2.redhat.com
 [10.36.113.97])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E7EE66E717;
 Fri,  3 Apr 2020 12:42:24 +0000 (UTC)
Subject: Re: [PATCH for-5.0 2/2] block: Fix blk->in_flight during
 blk_wait_while_drained()
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
References: <20200403104415.20963-1-kwolf@redhat.com>
 <20200403104415.20963-3-kwolf@redhat.com>
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
Message-ID: <30e7194e-afbc-2822-f086-9891539c0e3a@redhat.com>
Date: Fri, 3 Apr 2020 14:42:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200403104415.20963-3-kwolf@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="ZO9oN9Y1RJLZjrwDguHriF17ObaPNgI0D"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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
--ZO9oN9Y1RJLZjrwDguHriF17ObaPNgI0D
Content-Type: multipart/mixed; boundary="KepTs70hKfFRU6E1CFmXMsLEvMUAmDOxh"

--KepTs70hKfFRU6E1CFmXMsLEvMUAmDOxh
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 03.04.20 12:44, Kevin Wolf wrote:
> Calling blk_wait_while_drained() while blk->in_flight is increased for
> the current request is wrong because it will cause the drain operation
> to deadlock.
>=20
> Many callers of blk_wait_while_drained() have already increased
> blk->in_flight when called in a blk_aio_*() path, but can also be called
> in synchonous code paths where blk->in_flight isn't increased. This
> means that these calls of blk_wait_while_drained() are wrong at least in
> some cases.
>=20
> In order to fix this, increase blk->in_flight even for synchronous
> operations and temporarily decrease the counter again in
> blk_wait_while_drained().
>=20
> Fixes: cf3129323f900ef5ddbccbe86e4fa801e88c566e
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  block/block-backend.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)

blk_co_pdiscard() and blk_co_flush() are called from outside of
block-backend.c (namely from mirror.c and nbd/server.c).  Is that OK?

Max


--KepTs70hKfFRU6E1CFmXMsLEvMUAmDOxh--

--ZO9oN9Y1RJLZjrwDguHriF17ObaPNgI0D
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl6HLykACgkQ9AfbAGHV
z0CLGggAlm3BVMslHN3gBTGcmlw2849DlEcyyVNELH5otZSOXHA75es0jYtfA8ZH
NT6JBaxWy7inXkDqqT50Zvh3bOZmHt7yAvJ5ls5gqvmfgdrfk10usUdcdFoPeKCK
Qx5CwXPO0l6PS627TwfgSGvlObmMiucb/34j/ErROSmQQr77TrShwDhXPdLR5exC
uzOuyVYJq0uIGY1YxqCjbOMGL5GbAMMfvMvsgG2D6FWSdqPafmSYItngR2u4w6Hn
w/L/TyO7P3wyA09romLibWAO/UW61aFq2VBo+ZtSqN02o/lDnT7zdNrHBzl2thsu
r6L3bwb5PAXPFWacYcnsyd7QygbPyQ==
=7BK3
-----END PGP SIGNATURE-----

--ZO9oN9Y1RJLZjrwDguHriF17ObaPNgI0D--


