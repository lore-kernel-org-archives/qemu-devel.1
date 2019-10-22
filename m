Return-Path: <SRS0=tSBD=YP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AE3CCA9EA0
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2019 09:55:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 94CAE20B7C
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2019 09:55:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BdTGoMkV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 94CAE20B7C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52536 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iMqsV-0005Ec-3I
	for qemu-devel@archiver.kernel.org; Tue, 22 Oct 2019 05:54:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59152)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iMqrV-0004AE-1Q
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 05:53:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iMqrT-0005NZ-Dr
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 05:53:56 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:54645
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1iMqrT-0005MI-8e
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 05:53:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1571738034;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=w//qG2ZlTGl/kypQJf3Q0et/7RidPbAHWUr//ALF6Lk=;
 b=BdTGoMkVo9AvLH3mwt69VVe7VVwaTR485cP6J5WWywSELY1cf8cpORKtIJJUq/ehPQAH4+
 xTDnZ1O+UNRw/zRHxtL5VoEVOIvfDuImv5AORBROMl/w18HLhPWSRr270yvH6hyuVW/Os+
 FelS+O/aZl9BUcV2X96VaqI1wD63y74=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-336-ns5Wsl9TMmapFixGr1bcxQ-1; Tue, 22 Oct 2019 05:53:52 -0400
X-MC-Unique: ns5Wsl9TMmapFixGr1bcxQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EC04A107AD31;
 Tue, 22 Oct 2019 09:53:50 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-117-215.ams2.redhat.com
 [10.36.117.215])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 5204A5DC1E;
 Tue, 22 Oct 2019 09:53:47 +0000 (UTC)
Subject: Re: [PATCH v2 3/6] block/block-copy: refactor copying
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org
References: <20191016170905.8325-1-vsementsov@virtuozzo.com>
 <20191016170905.8325-4-vsementsov@virtuozzo.com>
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
Message-ID: <94b3c958-62b8-474e-5835-7bb77c3c5b84@redhat.com>
Date: Tue, 22 Oct 2019 11:53:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191016170905.8325-4-vsementsov@virtuozzo.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="rEISc58D2jX5RKZ50CKkNfEWFvPtdlmxM"
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
Cc: kwolf@redhat.com, den@openvz.org, jsnow@redhat.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--rEISc58D2jX5RKZ50CKkNfEWFvPtdlmxM
Content-Type: multipart/mixed; boundary="ukYmiqdUhJHahSn0Qo2xMlvInRFcG39wI"

--ukYmiqdUhJHahSn0Qo2xMlvInRFcG39wI
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 16.10.19 19:09, Vladimir Sementsov-Ogievskiy wrote:
> Merge copying code into one function block_copy_do_copy, which only
> calls bdrv_ io functions and don't do any synchronization (like dirty
> bitmap set/reset).
>=20
> Refactor block_copy() function so that it takes full decision about
> size of chunk to be copied and does all the synchronization (checking
> intersecting requests, set/reset dirty bitmaps).
>=20
> It will help:
>  - introduce parallel processing of block_copy iterations: we need to
>    calculate chunk size, start async chunk copying and go to the next
>    iteration
>  - simplify synchronization improvement (like memory limiting in
>    further commit and reducing critical section (now we lock the whole
>    requested range, when actually we need to lock only dirty region
>    which we handle at the moment))
>=20
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>  block/block-copy.c | 118 ++++++++++++++++++++-------------------------
>  block/trace-events |   6 +--
>  2 files changed, 54 insertions(+), 70 deletions(-)

Reviewed-by: Max Reitz <mreitz@redhat.com>


--ukYmiqdUhJHahSn0Qo2xMlvInRFcG39wI--

--rEISc58D2jX5RKZ50CKkNfEWFvPtdlmxM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl2u0akACgkQ9AfbAGHV
z0CFzwf/ZBHj3WM14qtsBITb2Y3jGSckS9qrlC5W/bDFw+LIJqovg2mC73PGakc7
kNow9s31aNOrCYYA6oefjivVIyB54+NNr3JX7Nf6q/lWUbI66/pg2oLm47II3edW
bSWraGcx1E7RhVPlv499A1pSoS96CSjw2Nu/lPGfVRAcU0Hhq+d8oPOj7rPmCXrb
iqaTlfgt8Tnc5QR5AtO7l2eDeVKmgFGEoJuuTDNaO5/Nzf1r7DRgztfcM/BpATTx
kJGs17GOO0jBubdLOU3Cj1QbhIVAbMjiUxlXlmOqZuxtz69oAuu8NoQSCZ8hB0Wr
o/75dzAxeDY09PYZxhratuqyVw0Thg==
=FCCE
-----END PGP SIGNATURE-----

--rEISc58D2jX5RKZ50CKkNfEWFvPtdlmxM--


