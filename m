Return-Path: <SRS0=MTtZ=AN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36FAAC433E0
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2020 13:39:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0021F207CD
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2020 13:39:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Z+yk3IEN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0021F207CD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58696 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqzQq-00051b-6h
	for qemu-devel@archiver.kernel.org; Thu, 02 Jul 2020 09:39:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37358)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1jqzKa-00010u-Jn
 for qemu-devel@nongnu.org; Thu, 02 Jul 2020 09:32:48 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:22738
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1jqzKY-0003N5-NW
 for qemu-devel@nongnu.org; Thu, 02 Jul 2020 09:32:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593696765;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=PLlrjy2VqgTpCA8ZLcrmp6b3o8pA+hR2nklHSBY2ELM=;
 b=Z+yk3IENfxr/denT9RsZd4Mptr1yaIpw4hbXIINxGWv4xDvFUjjQ4nBGfW/hQTFmRBykaV
 IcVH8jDBgueT1zxtw0rkW1lkK2mIPNSSMMmO6gvNIiHtwCsQVboDD7EATKHaQdOXM1CHK0
 YzVaa9x/dEzLWp3KEWKVHm0aWax0F1A=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-242-7769TRJuPrm26LpUhxUZjw-1; Thu, 02 Jul 2020 09:32:43 -0400
X-MC-Unique: 7769TRJuPrm26LpUhxUZjw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 64A631005513;
 Thu,  2 Jul 2020 13:32:42 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-113-196.ams2.redhat.com
 [10.36.113.196])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id EECD473FD3;
 Thu,  2 Jul 2020 13:32:40 +0000 (UTC)
Subject: Re: [PATCH v9 24/34] qcow2: Add subcluster support to
 check_refcounts_l2()
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
References: <cover.1593342067.git.berto@igalia.com>
 <8f424f702967348a6180cf4bc492d7ddede5ae57.1593342067.git.berto@igalia.com>
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
Message-ID: <d6cd3e93-0eb3-df86-c1cd-61ab1d0b1259@redhat.com>
Date: Thu, 2 Jul 2020 15:32:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <8f424f702967348a6180cf4bc492d7ddede5ae57.1593342067.git.berto@igalia.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mreitz@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="eqludxudOYTn668IDsor8LqDGPHaAPF7p"
Received-SPF: pass client-ip=205.139.110.61; envelope-from=mreitz@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/02 03:42:59
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
--eqludxudOYTn668IDsor8LqDGPHaAPF7p
Content-Type: multipart/mixed; boundary="uDnTCDiqiWYjyZiRZYtL4My89slysICxF"

--uDnTCDiqiWYjyZiRZYtL4My89slysICxF
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 28.06.20 13:02, Alberto Garcia wrote:
> The offset field of an uncompressed cluster's L2 entry must be aligned
> to the cluster size, otherwise it is invalid. If the cluster has no
> data then it means that the offset points to a preallocation, so we
> can clear the offset field without affecting the guest-visible data.
> This is what 'qemu-img check' does when run in repair mode.
>=20
> On traditional qcow2 images this can only happen when QCOW_OFLAG_ZERO
> is set, and repairing such entries turns the clusters from ZERO_ALLOC
> into ZERO_PLAIN.
>=20
> Extended L2 entries have no ZERO_ALLOC clusters and no QCOW_OFLAG_ZERO
> but the idea is the same: if none of the subclusters are allocated
> then we can clear the offset field and leave the bitmap untouched.
>=20
> Signed-off-by: Alberto Garcia <berto@igalia.com>
> ---
>  block/qcow2-refcount.c     | 16 +++++++++++-----
>  tests/qemu-iotests/060.out |  2 +-
>  2 files changed, 12 insertions(+), 6 deletions(-)

Reviewed-by: Max Reitz <mreitz@redhat.com>


--uDnTCDiqiWYjyZiRZYtL4My89slysICxF--

--eqludxudOYTn668IDsor8LqDGPHaAPF7p
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl794fYACgkQ9AfbAGHV
z0BOpggAnSVkfWh1pgHMupV6a3+f+UHMg28EDAQCZpZDxbLKP5SkWHB9T9DLekpZ
Uza8vvpv/qAOl/b++tNVHJAmyM8bij7YyDVuY/N8TnZ6CoMULtDxJ9yvNJLX89vt
g/eV1rTLhUx7MxcjYVSKd1CQOGHmkAW/trEm+D3b1OWzZRqeV8e3YBZX/J/m0KlQ
vG+rWkUr3jeC+HAgCaPXX6X09H68gCDfNXoYXpl4X3qrWm3URlFJSqcOg53VPlpz
FzOQb79No6kWtA+2YhmtxyTIcfL44O1Ybbdrqo74mOxsFfx+2WwjV9IF+MFcROQf
wCA3l8h0Lh95FO5kHflG+4KZPoZ3WQ==
=hTvD
-----END PGP SIGNATURE-----

--eqludxudOYTn668IDsor8LqDGPHaAPF7p--


