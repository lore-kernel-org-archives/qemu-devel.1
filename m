Return-Path: <SRS0=d4IR=4I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C57F9C11D05
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2020 15:40:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 921CB2071E
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2020 15:40:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FOSigPzq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 921CB2071E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44462 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j4nw7-0003lk-J1
	for qemu-devel@archiver.kernel.org; Thu, 20 Feb 2020 10:40:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50299)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1j4nvM-0002qw-L3
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 10:39:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1j4nvL-00012G-JX
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 10:39:36 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:20801
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1j4nvL-000125-FT
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 10:39:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582213174;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=73nZ6iAuI4yn+H+oeSOZr1P3hIaTUj0fA50vi2lg4GE=;
 b=FOSigPzqu1JQs7+gTYjvwtjrd/syvgvUs3yNbewKDgn6aQLFnUT319eVAr3+G71Nogxu+H
 U+2FzFT4Ie8DYRPmlA3sTRE+tdArCGk7dPJnVa06nInRxoMeAbGSdIjLQaaRet7/wSbQAJ
 BGsijuLWA/ZVFqniLNf8d3JA3kg8skc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-248-h-UJgK_DNfi2O4Og5QcY9Q-1; Thu, 20 Feb 2020 10:39:30 -0500
X-MC-Unique: h-UJgK_DNfi2O4Og5QcY9Q-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0B64F1005510;
 Thu, 20 Feb 2020 15:39:29 +0000 (UTC)
Received: from dresden.str.redhat.com (unknown [10.36.118.38])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 3C06A60C63;
 Thu, 20 Feb 2020 15:39:21 +0000 (UTC)
Subject: Re: [RFC PATCH v3 04/27] qcow2: Add get_l2_entry() and set_l2_entry()
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
References: <cover.1577014346.git.berto@igalia.com>
 <a1be1f4311da643b439cb5e1924b0ddfb052f338.1577014346.git.berto@igalia.com>
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
Message-ID: <43263b9c-d6f6-1d4a-963c-ef86fc5b8929@redhat.com>
Date: Thu, 20 Feb 2020 16:39:07 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <a1be1f4311da643b439cb5e1924b0ddfb052f338.1577014346.git.berto@igalia.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="Ba3fTxBE1QMEyfWVTfviiMQb6ZXSRIuVq"
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
Cc: Kevin Wolf <kwolf@redhat.com>, Anton Nefedov <anton.nefedov@virtuozzo.com>,
 qemu-block@nongnu.org, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "Denis V . Lunev" <den@openvz.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Ba3fTxBE1QMEyfWVTfviiMQb6ZXSRIuVq
Content-Type: multipart/mixed; boundary="nQXlt8BeVKsdrpe4IXMe9UMTiRcl0vQiz"

--nQXlt8BeVKsdrpe4IXMe9UMTiRcl0vQiz
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 22.12.19 12:36, Alberto Garcia wrote:
> The size of an L2 entry is 64 bits, but if we want to have subclusters
> we need extended L2 entries. This means that we have to access L2
> tables and slices differently depending on whether an image has
> extended L2 entries or not.
>=20
> This patch replaces all l2_slice[] accesses with calls to
> get_l2_entry() and set_l2_entry().
>=20
> Signed-off-by: Alberto Garcia <berto@igalia.com>
> ---
>  block/qcow2-cluster.c  | 65 ++++++++++++++++++++++--------------------
>  block/qcow2-refcount.c | 17 +++++------
>  block/qcow2.h          | 12 ++++++++
>  3 files changed, 55 insertions(+), 39 deletions(-)

Reviewed-by: Max Reitz <mreitz@redhat.com>


--nQXlt8BeVKsdrpe4IXMe9UMTiRcl0vQiz--

--Ba3fTxBE1QMEyfWVTfviiMQb6ZXSRIuVq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl5OqBsACgkQ9AfbAGHV
z0CtUwf+J7Im+5+sPMdjmda44OvKYHvIuJt7Buv1MqtKyfMth3lbTgrxaQKleSOu
ioL5ml4lx7BdNINLGrLg7FhrIoH7EJd0IPdcLSYI2ORnTP8700OiWZZKbJF2a18X
jORyPUwS01oReOZeCIwDw8R+MW94gMSf7AMENBezZKNwprmG3mbnRBBrrJdrk0dR
OF2ujYCVXSk3U1NRU1PnBJYARqTfAfKKlX1dY9/9/RqBLZcuHi092ljcKOGGDk4j
Laug9GnP/JktAnd1Fsqzi3/9djldu0naFTzDSK/LtqhsT6PddTscGtS0v42hrEbn
HouCGI+eb8sA/Mrc107kqyZX1dsqlQ==
=etvX
-----END PGP SIGNATURE-----

--Ba3fTxBE1QMEyfWVTfviiMQb6ZXSRIuVq--


