Return-Path: <SRS0=CRBd=6U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCC57C28CBC
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2020 13:48:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A849D20736
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2020 13:48:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ap+WYMFK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A849D20736
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48740 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jWKPb-0000Md-Qe
	for qemu-devel@archiver.kernel.org; Wed, 06 May 2020 09:48:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49224)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jWKOO-0007o7-Pc
 for qemu-devel@nongnu.org; Wed, 06 May 2020 09:47:21 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:44453
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jWKON-0002aV-2k
 for qemu-devel@nongnu.org; Wed, 06 May 2020 09:47:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588772837;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JZncH62c+miB40yVrqLL8UvcWuBkfa1NF4RkAmeZymE=;
 b=Ap+WYMFKYnUCqr8VEdTD9Zo/Hoq987wLqLImDpAZt/wT0nxx4LiYk4WlR1+g/S3EE+Tli0
 HncY/yK5tfVrQWXTGhoSGduPGnHI2cI2JyLmHLz3lFrZRuSCakZHBf/oUSq57Kpmu220yA
 vdMzey15BB2W57Gvp5ju3f4PYVz7fc8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-410-LN6BCuYdOpS3SKkbX5av4g-1; Wed, 06 May 2020 09:47:15 -0400
X-MC-Unique: LN6BCuYdOpS3SKkbX5av4g-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CFBA8107ACCA;
 Wed,  6 May 2020 13:47:14 +0000 (UTC)
Received: from linux.fritz.box (ovpn-113-140.ams2.redhat.com [10.36.113.140])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A42FC579A5;
 Wed,  6 May 2020 13:47:13 +0000 (UTC)
Date: Wed, 6 May 2020 15:47:12 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Max Reitz <mreitz@redhat.com>
Subject: Re: [PATCH v3 18/33] block: Add bdrv_default_perms()
Message-ID: <20200506134712.GG6333@linux.fritz.box>
References: <20200218124242.584644-1-mreitz@redhat.com>
 <20200218124242.584644-19-mreitz@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200218124242.584644-19-mreitz@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.61; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/06 05:50:09
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 18.02.2020 um 13:42 hat Max Reitz geschrieben:
> This callback can be used by BDSs that use child_of_bds with the
> appropriate BdrvChildRole for their children.
>=20
> Also, make bdrv_format_default_perms() use it for child_of_bds children
> (just a temporary solution until we can drop bdrv_format_default_perms()
> altogether).
>=20
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> Reviewed-by: Eric Blake <eblake@redhat.com>
> ---
>  block.c                   | 46 ++++++++++++++++++++++++++++++++-------
>  include/block/block_int.h | 11 ++++++++++
>  2 files changed, 49 insertions(+), 8 deletions(-)
>=20
> diff --git a/block.c b/block.c
> index c0ba274743..3e5b0bc345 100644
> --- a/block.c
> +++ b/block.c
> @@ -2383,14 +2383,12 @@ static void bdrv_default_perms_for_metadata(Block=
DriverState *bs, BdrvChild *c,
>      *nshared =3D shared;
>  }
> =20
> -/* TODO: Use */
> -static void __attribute__((unused))
> -bdrv_default_perms_for_data(BlockDriverState *bs, BdrvChild *c,
> -                            const BdrvChildClass *child_class,
> -                            BdrvChildRole role,
> -                            BlockReopenQueue *reopen_queue,
> -                            uint64_t perm, uint64_t shared,
> -                            uint64_t *nperm, uint64_t *nshared)
> +static void bdrv_default_perms_for_data(BlockDriverState *bs, BdrvChild =
*c,
> +                                        const BdrvChildClass *child_clas=
s,
> +                                        BdrvChildRole role,
> +                                        BlockReopenQueue *reopen_queue,
> +                                        uint64_t perm, uint64_t shared,
> +                                        uint64_t *nperm, uint64_t *nshar=
ed)
>  {
>      assert(child_class =3D=3D &child_of_bds && (role & BDRV_CHILD_DATA))=
;
> =20
> @@ -2425,6 +2423,13 @@ void bdrv_format_default_perms(BlockDriverState *b=
s, BdrvChild *c,
>                                 uint64_t *nperm, uint64_t *nshared)
>  {
>      bool backing =3D (child_class =3D=3D &child_backing);
> +
> +    if (child_class =3D=3D &child_of_bds) {
> +        bdrv_default_perms(bs, c, child_class, role, reopen_queue,
> +                           perm, shared, nperm, nshared);
> +        return;
> +    }
> +
>      assert(child_class =3D=3D &child_backing || child_class =3D=3D &chil=
d_file);
> =20
>      if (!backing) {
> @@ -2436,6 +2441,31 @@ void bdrv_format_default_perms(BlockDriverState *b=
s, BdrvChild *c,
>      }
>  }
> =20
> +void bdrv_default_perms(BlockDriverState *bs, BdrvChild *c,
> +                        const BdrvChildClass *child_class, BdrvChildRole=
 role,
> +                        BlockReopenQueue *reopen_queue,
> +                        uint64_t perm, uint64_t shared,
> +                        uint64_t *nperm, uint64_t *nshared)
> +{
> +    assert(child_class =3D=3D &child_of_bds);
> +
> +    if (role & BDRV_CHILD_FILTERED) {
> +        bdrv_filter_default_perms(bs, c, child_class, role, reopen_queue=
,
> +                                  perm, shared, nperm, nshared);
> +    } else if (role & BDRV_CHILD_COW) {
> +        bdrv_default_perms_for_backing(bs, c, child_class, role, reopen_=
queue,
> +                                       perm, shared, nperm, nshared);
> +    } else if (role & BDRV_CHILD_METADATA) {
> +        bdrv_default_perms_for_metadata(bs, c, child_class, role, reopen=
_queue,
> +                                        perm, shared, nperm, nshared);
> +    } else if (role & BDRV_CHILD_DATA) {
> +        bdrv_default_perms_for_data(bs, c, child_class, role, reopen_que=
ue,
> +                                    perm, shared, nperm, nshared);
> +    } else {
> +        g_assert_not_reached();
> +    }
> +}

Here the discussion from the start of the series becomes relevant: Which
flags can be combined with which other flags, and if multiple flags are
set, which one takes precedence?

First undocumented requirement: You must set at least one of FILTERED,
COW, METADATA and DATA.

Then, for FILTERED we decided to document that DATA shouldn't be set at
the same time. I guess neither should COW and METADATA. Apart for
documentation, worth an assertion?

COW seems to be exclusive in practice, too. I guess you could construct
a driver that somehow keeps its own (meta)data in its backing file,
maybe in the VM state area. It also sounds like a really bad idea. So
forbid it, document it and assert it, too?

METADATA and DATA can be set at the same time. As your previous patch
shows, the function for DATA is a laxer version of the one for METADATA,
requesting a subset of the METADATA permissions and sharing a superset.
So the order in the code makes sense.

But can we make sure that this condition will be true in the future?
Imagine we find a need for a new permission that is used for data files,
but not for metadata. I think at the very least, this deserves a
comment. But probably it means that both should stay a single function
that can check each flag for the exact permission bits it influences.

Kevin


