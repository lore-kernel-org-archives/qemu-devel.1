Return-Path: <SRS0=+YCa=CZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA1D6C43461
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2020 10:57:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 528192076D
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2020 10:57:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QCAlvrqP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 528192076D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45964 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIV87-0001ph-63
	for qemu-devel@archiver.kernel.org; Wed, 16 Sep 2020 06:57:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40756)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1kIV7P-0001K1-T5
 for qemu-devel@nongnu.org; Wed, 16 Sep 2020 06:56:55 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:29470
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1kIV7O-0000qU-2k
 for qemu-devel@nongnu.org; Wed, 16 Sep 2020 06:56:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600253813;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=//vU0GMLMnDkdo4A0AsHAA0udhh2mP0N7ISO8uvwUr8=;
 b=QCAlvrqPPfU0JwJIM1Wek1NW76GlW/Yk/TtBCUz69kfZCijv58ZeFc4kCtIRsaoW3NDAGs
 pKm9Y/f22dFjU+etLSYCuFrngF1H4hC2fxpstqu7XcAG4dKfTFpr/yiMEBeejA8/G5idlE
 09kZV97+IjlEJq37rF5OedIq3LKJVzc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-299-wTrlA8K5MaGxJjjl_ImvtQ-1; Wed, 16 Sep 2020 06:56:49 -0400
X-MC-Unique: wTrlA8K5MaGxJjjl_ImvtQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3C2C780EFBE;
 Wed, 16 Sep 2020 10:56:48 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-112-111.ams2.redhat.com
 [10.36.112.111])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 1236E67CF8;
 Wed, 16 Sep 2020 10:56:46 +0000 (UTC)
Subject: Re: [PATCH 16/29] block/export: Allocate BlockExport in blk_exp_add()
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
References: <20200907182011.521007-1-kwolf@redhat.com>
 <20200907182011.521007-17-kwolf@redhat.com>
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
Message-ID: <c42fccd0-13ab-ac8d-e81c-8f8aec3bf8b0@redhat.com>
Date: Wed, 16 Sep 2020 12:56:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200907182011.521007-17-kwolf@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mreitz@redhat.com
X-Mimecast-Spam-Score: 0.0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="fDkmm27Zy7JHGO4RGzKydlJeikidR9qNj"
Received-SPF: pass client-ip=207.211.31.120; envelope-from=mreitz@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/16 06:27:39
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.999,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--fDkmm27Zy7JHGO4RGzKydlJeikidR9qNj
Content-Type: multipart/mixed; boundary="bRtDpy56QuN4K7dzAmcs6e8bW42EyhIi2"

--bRtDpy56QuN4K7dzAmcs6e8bW42EyhIi2
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 07.09.20 20:19, Kevin Wolf wrote:
> Instead of letting the driver allocate and return the BlockExport
> object, allocate it already in blk_exp_add() and pass it. This allows us
> to initialise the generic part before calling into the driver so that
> the driver can just use these values instead of having to parse the
> options a second time.
>=20
> For symmetry, move freeing the BlockExport to blk_exp_unref().
>=20
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> Reviewed-by: Max Reitz <mreitz@redhat.com>
> ---
>  include/block/export.h |  8 +++++++-
>  include/block/nbd.h    | 11 ++++++-----
>  block/export/export.c  | 18 +++++++++++++++++-
>  blockdev-nbd.c         | 26 ++++++++++++++------------
>  nbd/server.c           | 30 +++++++++++++-----------------
>  5 files changed, 57 insertions(+), 36 deletions(-)

[...]

> diff --git a/block/export/export.c b/block/export/export.c
> index 8635318ef1..03ff155f97 100644
> --- a/block/export/export.c
> +++ b/block/export/export.c
> @@ -39,6 +39,8 @@ static const BlockExportDriver *blk_exp_find_driver(Blo=
ckExportType type)
>  BlockExport *blk_exp_add(BlockExportOptions *export, Error **errp)
>  {
>      const BlockExportDriver *drv;
> +    BlockExport *exp;
> +    int ret;
> =20
>      drv =3D blk_exp_find_driver(export->type);
>      if (!drv) {
> @@ -46,7 +48,20 @@ BlockExport *blk_exp_add(BlockExportOptions *export, E=
rror **errp)
>          return NULL;
>      }
> =20
> -    return drv->create(export, errp);
> +    assert(drv->instance_size >=3D sizeof(BlockExport));
> +    exp =3D g_malloc0(drv->instance_size);
> +    *exp =3D (BlockExport) {
> +        .drv        =3D &blk_exp_nbd,

Only noticed now when trying to base my FUSE stuff on this series:
s/blk_exp_nbd/drv/.

(I=E2=80=99d like to say =E2=80=9Cobviously=E2=80=9D, but, well.  Evidently=
 not obvious enough
for me.)

Max


--bRtDpy56QuN4K7dzAmcs6e8bW42EyhIi2--

--fDkmm27Zy7JHGO4RGzKydlJeikidR9qNj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl9h720ACgkQ9AfbAGHV
z0ABLAf/cfpDZHHTV5OwBeDWvVDkgNgkq7VZZSwiOTxDclyI78ZdHXE5FYJD840j
aAl3Du+Uj5rC3mDErpvzEtxY9HcqvL5AVbALJ9qvz+xb2Zhk7Oul6vryO560hCbW
7kCTNVm12CGii281m1tVgm6K9SgxFTmkF6KUkGBVr/2wena4qVfbLQ5RHnN8QXUW
1jK6oAK8urBalC+V0BTrX72Ke8evbWW7cUWWbbgdYyGeU9N4qtuAwwFzZdNiDxWG
QBfXYFRgTdQ+PxIdhDOKvoWP7Jo0BwgMxbT3KrbXqTWwlgWdyus6DNYT/VQRJF9g
yh17BtUEF4QDccsIjjfRkNvCCDGhqA==
=/KZ4
-----END PGP SIGNATURE-----

--fDkmm27Zy7JHGO4RGzKydlJeikidR9qNj--


