Return-Path: <SRS0=Qmby=6N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACCD8C83003
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 09:01:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7755C2076B
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 09:01:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="V16Hzk26"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7755C2076B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33924 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jTibB-0000vG-ID
	for qemu-devel@archiver.kernel.org; Wed, 29 Apr 2020 05:01:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57824)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1jTiVd-0000tg-TU
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 04:56:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1jTiVQ-0001HI-6U
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 04:56:01 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:48612
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1jTiVP-0001H2-PD
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 04:55:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588150547;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=Uj/rgRNO9dpB7ymJEWiMZUfVPx9dsu6tLLMeORo8ATU=;
 b=V16Hzk266na9UJrJV/2p0FZtwdmfSif9sx5na++uNg2Cm2vFDZUlxcllztwPlWSDPiYWAh
 t2pc0N2bW0vYOpcxjSRN8mVbfTe4fPBKADHl3J52z8tuJFKF5tHADwDmM555P6Cn3M8CpC
 G7vzbS+eDLDnYYADhhWPonbXTEt7pHA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-237-TUgFN5XMPDq8jEWX9Oh0vA-1; Wed, 29 Apr 2020 04:55:40 -0400
X-MC-Unique: TUgFN5XMPDq8jEWX9Oh0vA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 941D71859072;
 Wed, 29 Apr 2020 08:55:39 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-113-19.ams2.redhat.com
 [10.36.113.19])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 8C4AC60A9E;
 Wed, 29 Apr 2020 08:55:35 +0000 (UTC)
Subject: Re: [PATCH v4 0/3] qcow2: Allow resize of images with internal
 snapshots
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
References: <20200428192648.749066-1-eblake@redhat.com>
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
Message-ID: <308da480-e5ec-c9c0-9147-6bd6f761f2b2@redhat.com>
Date: Wed, 29 Apr 2020 10:55:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200428192648.749066-1-eblake@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="ldg3cb8gTzSM4XWNN1a4T69HPcHqeIylk"
Received-SPF: pass client-ip=207.211.31.81; envelope-from=mreitz@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/29 01:28:11
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
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
Cc: kwolf@redhat.com, qemu-block@nongnu.org, stefanha@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--ldg3cb8gTzSM4XWNN1a4T69HPcHqeIylk
Content-Type: multipart/mixed; boundary="meDZAa5OLLlEWHRD9sdYj2PUNXfAcCaM8"

--meDZAa5OLLlEWHRD9sdYj2PUNXfAcCaM8
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 28.04.20 21:26, Eric Blake wrote:
> Re-posting this to make Max' life easier when rebasing on top of Kevin's =
work.
>=20
> Based-on: <20200424125448.63318-1-kwolf@redhat.com>
> [PATCH v7 00/10] block: Fix resize (extending) of short overlays
>=20
> In v4:
> - patch 1: fold in Max's touchups to my v3
> - patch 1: resolve merge conflict on top of Kevin's block-next branch (tr=
uncate signature change)
> - patch 2: resolve semantic conflict (truncate signature change)
>=20
> 001/3:[0004] [FC] 'block: Add blk_new_with_bs() helper'
> 002/3:[0002] [FC] 'qcow2: Allow resize of images with internal snapshots'
> 003/3:[----] [--] 'qcow2: Tweak comment about bitmaps vs. resize'

Thanks, I=E2=80=99ve updated my branch:

https://git.xanclic.moe/XanClic/qemu/commits/branch/block-next

(A commit with two Message-Id tags is interesting :))

Max


--meDZAa5OLLlEWHRD9sdYj2PUNXfAcCaM8--

--ldg3cb8gTzSM4XWNN1a4T69HPcHqeIylk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl6pQQYACgkQ9AfbAGHV
z0DiZAf+LgV7f7L4bFiK/bMQ2Y9q1/owS9y7zptJeuKuXnh61D04he09GvbKQ6xX
xmKCrRlaM8xHqPOhtJMbvfd847ObHJsFGzJ+ZDmiB/WNRAw5Q1vFvsd/lAU0dkdH
qCz2rtPn4dVSCQnEE9cTdoGmahaJvlZ4JAO7cZ4CNUxRuN2AX0uyGri1v84r2Q6/
Fgq4AlpNDQqTw3BUDmMdNYNB6jO5lMAOYDdMNSLrPCykUsXDHvyU6L5BXd2eJ/Bt
I258OIs/PK9a/3HVF59VzKwNX1C9lbGTD5i0BdRNq73B6N+OMaIwNY5TOdGRqesy
6ewtW0oD+IkIT6dJeOJicz2GW44FhA==
=ThlT
-----END PGP SIGNATURE-----

--ldg3cb8gTzSM4XWNN1a4T69HPcHqeIylk--


