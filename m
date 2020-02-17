Return-Path: <SRS0=CnYV=4F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BB4FC7619D
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 08:17:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3608C20718
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 08:17:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="USs8sBGe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3608C20718
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41810 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j3bb6-0002TV-8Z
	for qemu-devel@archiver.kernel.org; Mon, 17 Feb 2020 03:17:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43056)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <ndevos@redhat.com>) id 1j3baO-0001xG-NF
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 03:17:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ndevos@redhat.com>) id 1j3baM-0004rq-W4
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 03:17:00 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:41278
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ndevos@redhat.com>) id 1j3baM-0004rE-Ra
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 03:16:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581927417;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=s+782s65KIf1poUVjhRTsU6MtZbvvF/wajpYT/D3e2Y=;
 b=USs8sBGe/pmZU/ICt8kSKQHFlh8GrWmDRm/r+wvu1QkWrb+VZNsGnAybaQmTWUzY8HTowB
 +212H6u8G1SKqb229A6Pp1snfATUHfTtgaWHmo5tJdK7d0wuf3o5+uxtcIFPPEALndB1Zi
 NO/tucVdIIZlFIZCQYDq+VAPbu0W+qE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-135-FPsqsc_ZN4Wzvz-AQZVgKw-1; Mon, 17 Feb 2020 03:16:53 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9B82B8017DF;
 Mon, 17 Feb 2020 08:16:52 +0000 (UTC)
Received: from localhost (unknown [10.36.118.9])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 38FAF2CC39;
 Mon, 17 Feb 2020 08:16:52 +0000 (UTC)
Date: Mon, 17 Feb 2020 09:16:50 +0100
From: Niels de Vos <ndevos@redhat.com>
To: Eric Blake <eblake@redhat.com>
Subject: Re: [GEDI] [PATCH 12/17] gluster: Support BDRV_ZERO_OPEN
Message-ID: <20200217081650.GH239686@ndevos-x270.lan.nixpanic.net>
References: <20200131174436.2961874-1-eblake@redhat.com>
 <20200131174436.2961874-13-eblake@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200131174436.2961874-13-eblake@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: FPsqsc_ZN4Wzvz-AQZVgKw-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 "open list:GLUSTER" <integration@gluster.org>, qemu-block@nongnu.org,
 qemu-devel@nongnu.org, mreitz@redhat.com, david.edmondson@oracle.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Jan 31, 2020 at 11:44:31AM -0600, Eric Blake wrote:
> Since gluster already copies file-posix for lseek usage in block
> status, it also makes sense to copy it for learning if the image
> currently reads as all zeroes.
>=20
> Signed-off-by: Eric Blake <eblake@redhat.com>
> ---
>  block/gluster.c | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
>=20
> diff --git a/block/gluster.c b/block/gluster.c
> index 9d952c70981b..0417a86547c8 100644
> --- a/block/gluster.c
> +++ b/block/gluster.c
> @@ -1464,6 +1464,22 @@ exit:
>      return -ENOTSUP;
>  }
>=20
> +static int qemu_gluster_known_zeroes(BlockDriverState *bs)
> +{
> +    /*
> +     * GlusterFS volume could be backed by a block device, with no way

Actually, Gluster dropped support for volumes backed by block devices
(LVM) a few releases back. Nobody could be found that used it, and it
could not be combined with other Gluster features. All contents on a
Gluster volume is now always backed by 'normal' files on a filesystem.

Creation or truncation should behave just as on a file on a local
filesystem. So maybe qemu_gluster_known_zeroes is not needed at all?

Niels


> +     * to query if regions added by creation or truncation will read
> +     * as zeroes.  However, we can use lseek(SEEK_DATA) to check if
> +     * contents currently read as zero.
> +     */
> +    off_t data, hole;
> +
> +    if (find_allocation(bs, 0, &data, &hole) =3D=3D -ENXIO) {
> +        return BDRV_ZERO_OPEN;
> +    }
> +    return 0;
> +}
> +
>  /*
>   * Returns the allocation status of the specified offset.
>   *
> @@ -1561,6 +1577,7 @@ static BlockDriver bdrv_gluster =3D {
>      .bdrv_co_readv                =3D qemu_gluster_co_readv,
>      .bdrv_co_writev               =3D qemu_gluster_co_writev,
>      .bdrv_co_flush_to_disk        =3D qemu_gluster_co_flush_to_disk,
> +    .bdrv_known_zeroes            =3D qemu_gluster_known_zeroes,
>  #ifdef CONFIG_GLUSTERFS_DISCARD
>      .bdrv_co_pdiscard             =3D qemu_gluster_co_pdiscard,
>  #endif
> @@ -1591,6 +1608,7 @@ static BlockDriver bdrv_gluster_tcp =3D {
>      .bdrv_co_readv                =3D qemu_gluster_co_readv,
>      .bdrv_co_writev               =3D qemu_gluster_co_writev,
>      .bdrv_co_flush_to_disk        =3D qemu_gluster_co_flush_to_disk,
> +    .bdrv_known_zeroes            =3D qemu_gluster_known_zeroes,
>  #ifdef CONFIG_GLUSTERFS_DISCARD
>      .bdrv_co_pdiscard             =3D qemu_gluster_co_pdiscard,
>  #endif
> @@ -1621,6 +1639,7 @@ static BlockDriver bdrv_gluster_unix =3D {
>      .bdrv_co_readv                =3D qemu_gluster_co_readv,
>      .bdrv_co_writev               =3D qemu_gluster_co_writev,
>      .bdrv_co_flush_to_disk        =3D qemu_gluster_co_flush_to_disk,
> +    .bdrv_known_zeroes            =3D qemu_gluster_known_zeroes,
>  #ifdef CONFIG_GLUSTERFS_DISCARD
>      .bdrv_co_pdiscard             =3D qemu_gluster_co_pdiscard,
>  #endif
> @@ -1657,6 +1676,7 @@ static BlockDriver bdrv_gluster_rdma =3D {
>      .bdrv_co_readv                =3D qemu_gluster_co_readv,
>      .bdrv_co_writev               =3D qemu_gluster_co_writev,
>      .bdrv_co_flush_to_disk        =3D qemu_gluster_co_flush_to_disk,
> +    .bdrv_known_zeroes            =3D qemu_gluster_known_zeroes,
>  #ifdef CONFIG_GLUSTERFS_DISCARD
>      .bdrv_co_pdiscard             =3D qemu_gluster_co_pdiscard,
>  #endif
> --=20
> 2.24.1
>=20
> _______________________________________________
> integration mailing list
> integration@gluster.org
> https://lists.gluster.org/mailman/listinfo/integration
>=20


