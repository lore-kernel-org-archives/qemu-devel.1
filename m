Return-Path: <SRS0=buBk=6M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5221C83000
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2020 15:07:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A034C205C9
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2020 15:07:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TI7jD3lW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A034C205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34366 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jTRpH-0008J2-PS
	for qemu-devel@archiver.kernel.org; Tue, 28 Apr 2020 11:07:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49536)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1jTRmY-0005lS-Oh
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 11:06:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1jTRlX-0007nm-Eh
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 11:04:22 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:59935
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jTRlV-0007nJ-B2
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 11:03:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588086196;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yAqwhX3+AnzKdJLw0RQWKD4jv3O+DvVGr5w9/stfNX8=;
 b=TI7jD3lWUqrein5g+3+XesII8+D5QkTeaRFsGuyEqhCO9jlJnCDWqbVYmbvWcboBJvFZ6i
 k2sYCqq59LfBiJvSFBcZmy88xzEHi3BChfrEA2dZrmyeoQA2woSf7u0azvJ+nsvnGZNspp
 6Tzj6am3yXfyKuRfaFinxRp4b8GDpDo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-353-uLiyU3s6NQSkdpqxWbYXGg-1; Tue, 28 Apr 2020 11:03:14 -0400
X-MC-Unique: uLiyU3s6NQSkdpqxWbYXGg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9F338800685;
 Tue, 28 Apr 2020 15:03:13 +0000 (UTC)
Received: from linux.fritz.box (ovpn-114-37.ams2.redhat.com [10.36.114.37])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C6175600D2;
 Tue, 28 Apr 2020 15:03:12 +0000 (UTC)
Date: Tue, 28 Apr 2020 17:03:11 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Max Reitz <mreitz@redhat.com>
Subject: Re: [PATCH 4/4] block: Use blk_make_empty() after commits
Message-ID: <20200428150311.GK5789@linux.fritz.box>
References: <20200428132629.796753-1-mreitz@redhat.com>
 <20200428132629.796753-5-mreitz@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200428132629.796753-5-mreitz@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.81; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/28 04:11:46
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
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 28.04.2020 um 15:26 hat Max Reitz geschrieben:
> bdrv_commit() already has a BlockBackend pointing to the BDS that we
> want to empty, it just has the wrong permissions.
>=20
> qemu-img commit has no BlockBackend pointing to the old backing file
> yet, but introducing one is simple.
>=20
> After this commit, bdrv_make_empty() is the only remaining caller of
> BlockDriver.bdrv_make_empty().
>=20
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
>  block/commit.c |  8 +++++++-
>  qemu-img.c     | 19 ++++++++++++++-----
>  2 files changed, 21 insertions(+), 6 deletions(-)
>=20
> diff --git a/block/commit.c b/block/commit.c
> index 8e672799af..24720ba67d 100644
> --- a/block/commit.c
> +++ b/block/commit.c
> @@ -493,10 +493,16 @@ int bdrv_commit(BlockDriverState *bs)
>      }
> =20
>      if (drv->bdrv_make_empty) {
> -        ret =3D drv->bdrv_make_empty(bs);
> +        ret =3D blk_set_perm(src, BLK_PERM_WRITE, BLK_PERM_ALL, NULL);

This is very likely to fail because the common case is that the source
node is attached to a guest device that doesn't share writes.
(qemu-iotests 131 and 274 catch this.)

So I think after my theoretical comment in patch 1, this is the
practical reason why we need WRITE_UNCHANGED rather than WRITE.

Also, why don't you take this permission from the start so that we would
error out right away rather than failing after waiting for the all the
data to be copied?

>          if (ret < 0) {
>              goto ro_cleanup;
>          }
> +
> +        ret =3D blk_make_empty(src, NULL);
> +        if (ret < 0) {
> +            goto ro_cleanup;
> +        }
> +
>          blk_flush(src);
>      }
> =20
> diff --git a/qemu-img.c b/qemu-img.c
> index 821cbf610e..a5e8659867 100644
> --- a/qemu-img.c
> +++ b/qemu-img.c
> @@ -1065,11 +1065,20 @@ static int img_commit(int argc, char **argv)
>          goto unref_backing;
>      }
> =20
> -    if (!drop && bs->drv->bdrv_make_empty) {
> -        ret =3D bs->drv->bdrv_make_empty(bs);
> -        if (ret) {
> -            error_setg_errno(&local_err, -ret, "Could not empty %s",
> -                             filename);
> +    if (!drop) {
> +        BlockBackend *old_backing_blk;
> +
> +        old_backing_blk =3D blk_new_with_bs(bs, BLK_PERM_WRITE, BLK_PERM=
_ALL,
> +                                          &local_err);

Oh, you actually depend on another series that you didn't mention in
the cover letter.

> +        if (!old_backing_blk) {
> +            goto unref_backing;
> +        }
> +        ret =3D blk_make_empty(old_backing_blk, &local_err);
> +        blk_unref(old_backing_blk);
> +        if (ret =3D=3D -ENOTSUP) {
> +            error_free(local_err);
> +            local_err =3D NULL;
> +        } else if (ret < 0) {
>              goto unref_backing;
>          }
>      }

Kevin


