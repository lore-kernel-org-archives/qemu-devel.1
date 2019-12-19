Return-Path: <SRS0=p/0J=2J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2463AC43603
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 12:59:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E205C20716
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 12:59:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Z8KddTQL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E205C20716
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40534 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihvOU-0004Ri-Vh
	for qemu-devel@archiver.kernel.org; Thu, 19 Dec 2019 07:59:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42162)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1ihvC8-0003Jj-5s
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 07:46:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1ihvC7-0002Rk-1z
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 07:46:20 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:60081
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1ihvC6-0002Nh-Q7
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 07:46:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576759578;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=wpnSwqfE+MFm+F3USobYDW29p2xwzCUzBxHIxoeRsR4=;
 b=Z8KddTQL/AAneVfKwne3HS5S/i8MEKkn+DzFFTyGjpSxNrVvzXHIT3egn5+fqQBAK8ZN8t
 JOgEDKRnYckiyA+4mBqZhiHBxeoqxfnPofc+zmPH72CEhI9x43k/IQzpZZqCid/MYdHox2
 22lnNhxv9xIj95udGfYwIvvf3kjwbk0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-320-AEtA76dJPEWf4Epjdfywpw-1; Thu, 19 Dec 2019 07:46:16 -0500
X-MC-Unique: AEtA76dJPEWf4Epjdfywpw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EE4DB8024DA;
 Thu, 19 Dec 2019 12:46:15 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-205-138.brq.redhat.com
 [10.40.205.138])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 27C5A63B94;
 Thu, 19 Dec 2019 12:46:14 +0000 (UTC)
Subject: Re: [PATCH 1/3] block: Activate recursively even for already active
 nodes
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
References: <20191217145939.5537-1-kwolf@redhat.com>
 <20191217145939.5537-2-kwolf@redhat.com>
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
Message-ID: <c1719dd0-0e7f-c606-f69d-3bfdbef3f348@redhat.com>
Date: Thu, 19 Dec 2019 13:46:13 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191217145939.5537-2-kwolf@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="ZRddNMxetXLDbIZPXf1VoQazoGMxB3nD1"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--ZRddNMxetXLDbIZPXf1VoQazoGMxB3nD1
Content-Type: multipart/mixed; boundary="E1OA5HAnYu1gTQxy5DwghMO9fUfEgrMmf"

--E1OA5HAnYu1gTQxy5DwghMO9fUfEgrMmf
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 17.12.19 15:59, Kevin Wolf wrote:
> bdrv_invalidate_cache_all() assumes that all nodes in a given subtree
> are either active or inactive when it starts. Therefore, as soon as it
> arrives at an already active node, it stops.
>=20
> However, this assumption is wrong. For example, it's possible to take a
> snapshot of an inactive node, which results in an active overlay over an
> inactive backing file. The active overlay is probably also the root node
> of an inactive BlockBackend (blk->disable_perm =3D=3D true).
>=20
> In this case, bdrv_invalidate_cache_all() does not need to do anything
> to activate the overlay node, but it still needs to recurse into the
> children and the parents to make sure that after returning success,
> really everything is activated.
>=20
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  block.c | 50 ++++++++++++++++++++++++--------------------------
>  1 file changed, 24 insertions(+), 26 deletions(-)

Basically the only change is to not skip the whole function when the
node is already active but only the part that actually activates the
node.  blk_root_activate() is a no-op for already-active BBs, so this
looks good to me.

Reviewed-by: Max Reitz <mreitz@redhat.com>


--E1OA5HAnYu1gTQxy5DwghMO9fUfEgrMmf--

--ZRddNMxetXLDbIZPXf1VoQazoGMxB3nD1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl37cRUACgkQ9AfbAGHV
z0DcLQgAvJW0tqYwYz22hMT/QG24rlqq6objMA2l3Fkjrcxy3aXmjMR4ovOXP9R1
BoT2qTG/abV5QiFHPhA7vdp01VDf4vtOR7LxzSDDo++OE/NE589XXh/2K7BsF4YD
eA0XORhRdrE7dQaXb2m+e1YTUbgCl9ol921j1xIVMdqbA37Lg5E7u2gUqhgAp0kC
uY2kfH5p+hbOxpwEiF4F9wPkt2aza0wCZDwGZ7gUUY3gZ+VZ3LUl3VpRacqiCozg
1cABAfcaVXhhxwXZjrvvrOFK7g7tUOAGaOBDZbxDeaoyw+LopwhYFRTOl7/jVokn
TWXRsaNwiszbvLyS773QVrLPlWZx2g==
=4x0n
-----END PGP SIGNATURE-----

--ZRddNMxetXLDbIZPXf1VoQazoGMxB3nD1--


