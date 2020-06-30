Return-Path: <SRS0=gXk/=AL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBD59C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 10:39:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 80F6720780
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 10:39:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IMWn2MYZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 80F6720780
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34844 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqDfv-0001N6-QN
	for qemu-devel@archiver.kernel.org; Tue, 30 Jun 2020 06:39:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40226)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1jqDej-0007hd-1n
 for qemu-devel@nongnu.org; Tue, 30 Jun 2020 06:38:25 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:25073
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1jqDeh-0002Kx-6k
 for qemu-devel@nongnu.org; Tue, 30 Jun 2020 06:38:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593513502;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=AxBNVHf+qMW+Z96D9qo3n5fIB1s62lk8rutAufpLazw=;
 b=IMWn2MYZrAp2xefwOk5UlVGGgORNVqZOBBf1isCoVI+76YOm/NpHGlpn5yxdW3EyHBrQBn
 J/l6Bk4CEz+dUc8PEzxAJhCr1e19nsWnDcFOmcBlGv6TL1jw+zxdMWfuvYGNl50xRfh4vy
 xYIkXGSqN/Ck/JvCtpHEI96+rz+Ol/c=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-271-_amUexhVPcKALh5X0m8gLw-1; Tue, 30 Jun 2020 06:38:20 -0400
X-MC-Unique: _amUexhVPcKALh5X0m8gLw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B46F0107ACF3;
 Tue, 30 Jun 2020 10:38:18 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-113-102.ams2.redhat.com
 [10.36.113.102])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 2A1115BAEC;
 Tue, 30 Jun 2020 10:38:16 +0000 (UTC)
Subject: Re: [PATCH v9 05/34] qcow2: Process QCOW2_CLUSTER_ZERO_ALLOC clusters
 in handle_copied()
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
References: <cover.1593342067.git.berto@igalia.com>
 <4b6d5c3a4359b3e5274df5ac22262b2b4198fb99.1593342067.git.berto@igalia.com>
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
Message-ID: <4cfbcb03-abc6-951b-24d3-6e544904da52@redhat.com>
Date: Tue, 30 Jun 2020 12:38:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <4b6d5c3a4359b3e5274df5ac22262b2b4198fb99.1593342067.git.berto@igalia.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mreitz@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="eiezvypKLK94LXCTInjSUQChOFipBSYY9"
Received-SPF: pass client-ip=207.211.31.81; envelope-from=mreitz@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/30 02:00:02
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: Kevin Wolf <kwolf@redhat.com>, Derek Su <dereksu@qnap.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--eiezvypKLK94LXCTInjSUQChOFipBSYY9
Content-Type: multipart/mixed; boundary="BmkDFurPlZbi3OV9IzHDweQtGNnzu6WVN"

--BmkDFurPlZbi3OV9IzHDweQtGNnzu6WVN
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 28.06.20 13:02, Alberto Garcia wrote:
> When writing to a qcow2 file there are two functions that take a
> virtual offset and return a host offset, possibly allocating new
> clusters if necessary:
>=20
>    - handle_copied() looks for normal data clusters that are already
>      allocated and have a reference count of 1. In those clusters we
>      can simply write the data and there is no need to perform any
>      copy-on-write.
>=20
>    - handle_alloc() looks for clusters that do need copy-on-write,
>      either because they haven't been allocated yet, because their
>      reference count is !=3D 1 or because they are ZERO_ALLOC clusters.
>=20
> The ZERO_ALLOC case is a bit special because those are clusters that
> are already allocated and they could perfectly be dealt with in
> handle_copied() (as long as copy-on-write is performed when required).
>=20
> In fact, there is extra code specifically for them in handle_alloc()
> that tries to reuse the existing allocation if possible and frees them
> otherwise.
>=20
> This patch changes the handling of ZERO_ALLOC clusters so the
> semantics of these two functions are now like this:
>=20
>    - handle_copied() looks for clusters that are already allocated and
>      which we can overwrite (NORMAL and ZERO_ALLOC clusters with a
>      reference count of 1).
>=20
>    - handle_alloc() looks for clusters for which we need a new
>      allocation (all other cases).
>=20
> One important difference after this change is that clusters found
> in handle_copied() may now require copy-on-write, but this will be
> necessary anyway once we add support for subclusters.
>=20
> Signed-off-by: Alberto Garcia <berto@igalia.com>
> Reviewed-by: Eric Blake <eblake@redhat.com>
> ---
>  block/qcow2-cluster.c | 256 +++++++++++++++++++++++-------------------
>  1 file changed, 141 insertions(+), 115 deletions(-)

Reviewed-by: Max Reitz <mreitz@redhat.com>


--BmkDFurPlZbi3OV9IzHDweQtGNnzu6WVN--

--eiezvypKLK94LXCTInjSUQChOFipBSYY9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl77FhcACgkQ9AfbAGHV
z0DMpgf9FNyYmrnC97jdCVt4cy97cY+MvLDw3g6BMI14PTaequ0/8R6h3QYE+h86
iP8HlumAL6qBuPzDWJgSQaUuledqQjm0NpJU6ibNJZi0NquX0RqWNyudbIqdxE+G
U9cQdqPcc5goS+wRH4f6EWFPKnCiZSQwHK+Sfg7m8Xist7whJeqoKD3XdYwvH6QH
GMdaMJHk/MTAYMIob0oj7qPv9tso2eCuW96GMZ4ZZf7tLUILnns0SM5UMq7VP09S
DWtJJzSH2yrU82LyUTmThs9609FnBIR3rD28dV0ulQp4obeBLvM0EylhHNDxqzml
wdz2Lk9ibzp8RllPJQezuE/GKbz0PA==
=d+A3
-----END PGP SIGNATURE-----

--eiezvypKLK94LXCTInjSUQChOFipBSYY9--


