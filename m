Return-Path: <SRS0=bySr=YS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAA98CA9EA0
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 12:52:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 82A5C21929
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 12:52:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="h3XLN8UB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 82A5C21929
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59534 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNz4i-0004LV-CC
	for qemu-devel@archiver.kernel.org; Fri, 25 Oct 2019 08:52:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55530)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iNz3W-0002EZ-Hd
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 08:51:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iNz3U-0002EG-Ad
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 08:51:01 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:37061
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1iNz3T-0002Do-W0
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 08:51:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1572007858;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=bm6tmMR8XBWWJlP2/fa9LeW1Pl+v+vxF6+XPg1KZqWQ=;
 b=h3XLN8UBHOUXrJMLrKO2S/loLoaai/RMKPN86GEcG96MB80A75p8N0o9q7RWs4nGVcyZ0S
 bUy++4cI/zsmwUtS0XZ2NMIpT+L5b8mtWuajnkw/GPW4jJJ/A6tRNTLVGzYSkvI4MaFpqU
 HzuWJy2tlO4UV1EAFBYqbxpLnneijGM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-28-O_Wxxrl2P2yJeRcjN-CsbA-1; Fri, 25 Oct 2019 08:50:55 -0400
X-MC-Unique: O_Wxxrl2P2yJeRcjN-CsbA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3EC7E476;
 Fri, 25 Oct 2019 12:50:54 +0000 (UTC)
Received: from dresden.str.redhat.com (unknown [10.36.118.67])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 58CD8589B;
 Fri, 25 Oct 2019 12:50:50 +0000 (UTC)
Subject: Re: [PATCH v2 1/2] qcow2-bitmaps: fix qcow2_can_store_new_dirty_bitmap
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org
References: <20191014115126.15360-1-vsementsov@virtuozzo.com>
 <20191014115126.15360-2-vsementsov@virtuozzo.com>
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
Message-ID: <e54561aa-d653-5df4-0379-083ddc7b9657@redhat.com>
Date: Fri, 25 Oct 2019 14:50:48 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191014115126.15360-2-vsementsov@virtuozzo.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="CoG89eNUYRmfE2KsXi8fybDSwgLi5MSdK"
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
Cc: kwolf@redhat.com, jsnow@redhat.com, qemu-devel@nongnu.org, den@openvz.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--CoG89eNUYRmfE2KsXi8fybDSwgLi5MSdK
Content-Type: multipart/mixed; boundary="htILAPxVSrb2SGmjvf0UWIXFDQ9wELBL2"

--htILAPxVSrb2SGmjvf0UWIXFDQ9wELBL2
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 14.10.19 13:51, Vladimir Sementsov-Ogievskiy wrote:
> qcow2_can_store_new_dirty_bitmap works wrong, as it considers only
> bitmaps already stored in the qcow2 image and ignores persistent
> BdrvDirtyBitmap objects.
>=20
> So, let's instead count persistent BdrvDirtyBitmaps. We load all qcow2
> bitmaps on open, so there should not be any bitmap in the image for
> which we don't have BdrvDirtyBitmaps version. If it is - it's a kind of
> corruption, and no reason to check for corruptions here (open() and
> close() are better places for it).
>=20
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>  block/qcow2-bitmap.c | 41 ++++++++++++++++++-----------------------
>  1 file changed, 18 insertions(+), 23 deletions(-)

Am I right in interpreting qcow2_load_dirty_bitmaps() in such a way that
every persistent dirty bitmap will cause a runtime dirty bitmap to be
created?

If so:

Reviewed-by: Max Reitz <mreitz@redhat.com>


--htILAPxVSrb2SGmjvf0UWIXFDQ9wELBL2--

--CoG89eNUYRmfE2KsXi8fybDSwgLi5MSdK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl2y76gACgkQ9AfbAGHV
z0BzbAf/aRgO6K8ava9nYMzeNvv9qpFb7Hy2xMHpGyrEHfEPSg5YdRqOElxd5YcJ
yOJnAH6lpNwSpG8S3YTD8TyIIiHNJAcUwcj/pCutE0dZfA8PHXPkhRZjjPYJImKl
4cTSDNL3pyeCD0tTA0CYA1WHZQgWB4GXFld+za8Co1hNM3CPSUoP7VQuuf56IJ1o
/1l5V5u+uiFex2zSj9lIS+/kg2TW0pc4+2EEN3g3ZmWFtQoG/M0E2G+E9JwLLDsB
GogQzTTCeP0lGWx1W9CG+CXcmxii8K8EcNJMKX57j3DT/9Qcilf9B3eLuYi/fWCe
NFSIAz1YquAqkeOw42IS6KYKevoaQA==
=2RH6
-----END PGP SIGNATURE-----

--CoG89eNUYRmfE2KsXi8fybDSwgLi5MSdK--


