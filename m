Return-Path: <SRS0=buBk=6M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CE97C83000
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2020 14:24:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D6D90206D7
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2020 14:24:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UdamLnl0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D6D90206D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60562 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jTR9q-0006gD-W9
	for qemu-devel@archiver.kernel.org; Tue, 28 Apr 2020 10:24:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43836)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1jTR8U-0005AU-B3
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 10:23:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1jTR6l-0003Lz-P9
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 10:22:57 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:53070
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jTR6l-0003Ky-9U
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 10:21:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588083669;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vXsfaqbKzbmyGzjd0hH35dirKJa0G/EnTg+YaT6oY1c=;
 b=UdamLnl0VaepkE+EO9cSt9Vv8LkgS0txUTFf9eNDIUTDwta+QOWBgxbUffQZuoUU3d/M4I
 PCRHSoiRbtz9EaXuGk3c+iRKYzJSaXKr29wpBgcG0k5RbEhpEUesBXf5zYz8MQKWpuM17g
 gr4oSHwx92kbA8ekMVtNzySP3P+HZJs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-170-M7iZ_cMeOA-yEmvPODHu3A-1; Tue, 28 Apr 2020 10:21:07 -0400
X-MC-Unique: M7iZ_cMeOA-yEmvPODHu3A-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5D69C462;
 Tue, 28 Apr 2020 14:21:06 +0000 (UTC)
Received: from linux.fritz.box (ovpn-114-37.ams2.redhat.com [10.36.114.37])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 703B2272A7;
 Tue, 28 Apr 2020 14:21:05 +0000 (UTC)
Date: Tue, 28 Apr 2020 16:21:04 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Max Reitz <mreitz@redhat.com>
Subject: Re: [PATCH 1/4] block: Add bdrv_make_empty()
Message-ID: <20200428142104.GI5789@linux.fritz.box>
References: <20200428132629.796753-1-mreitz@redhat.com>
 <20200428132629.796753-2-mreitz@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200428132629.796753-2-mreitz@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.120; envelope-from=kwolf@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/28 02:16:38
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
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
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 28.04.2020 um 15:26 hat Max Reitz geschrieben:
> Right now, all users of bdrv_make_empty() call the BlockDriver method
> directly.  That is not only bad style, it is also wrong, unless the
> caller has a BdrvChild with a WRITE permission.
>=20
> Introduce bdrv_make_empty() that verifies that it does.
>=20
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
>  include/block/block.h |  1 +
>  block.c               | 23 +++++++++++++++++++++++
>  2 files changed, 24 insertions(+)
>=20
> diff --git a/include/block/block.h b/include/block/block.h
> index b05995fe9c..d947fb4080 100644
> --- a/include/block/block.h
> +++ b/include/block/block.h
> @@ -351,6 +351,7 @@ BlockMeasureInfo *bdrv_measure(BlockDriver *drv, Qemu=
Opts *opts,
>  void bdrv_get_geometry(BlockDriverState *bs, uint64_t *nb_sectors_ptr);
>  void bdrv_refresh_limits(BlockDriverState *bs, Error **errp);
>  int bdrv_commit(BlockDriverState *bs);
> +int bdrv_make_empty(BdrvChild *c, Error **errp);
>  int bdrv_change_backing_file(BlockDriverState *bs,
>      const char *backing_file, const char *backing_fmt);
>  void bdrv_register(BlockDriver *bdrv);
> diff --git a/block.c b/block.c
> index 2e3905c99e..b0d5b98617 100644
> --- a/block.c
> +++ b/block.c
> @@ -6791,3 +6791,26 @@ void bdrv_del_child(BlockDriverState *parent_bs, B=
drvChild *child, Error **errp)
> =20
>      parent_bs->drv->bdrv_del_child(parent_bs, child, errp);
>  }
> +
> +int bdrv_make_empty(BdrvChild *c, Error **errp)
> +{
> +    BlockDriver *drv =3D c->bs->drv;
> +    int ret;
> +
> +    assert(c->perm & BLK_PERM_WRITE);

If I understand correctly, bdrv_make_empty() is called to drop an
overlay whose content is identical to what it would read from its
backing file (in particular after a commit operation). This means that
the caller promises that the visible content doesn't change.

So should we check BLK_PERM_WRITE_UNCHANGED instead?

Kevin


