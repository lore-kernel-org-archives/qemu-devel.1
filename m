Return-Path: <SRS0=HfOj=DH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A875C4741F
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 16:39:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A8A19207FB
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 16:39:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=euphon.net header.i=fam@euphon.net header.b="dE1QHrsp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A8A19207FB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=euphon.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50874 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNf87-0001cq-G4
	for qemu-devel@archiver.kernel.org; Wed, 30 Sep 2020 12:38:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36384)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fam@euphon.net>)
 id 1kNf6f-0001BX-33; Wed, 30 Sep 2020 12:37:29 -0400
Received: from sender2-op-o12.zoho.com.cn ([163.53.93.243]:17639)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fam@euphon.net>)
 id 1kNf6Y-00063M-JD; Wed, 30 Sep 2020 12:37:28 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1601483800; cv=none; d=zoho.com.cn; s=zohoarc; 
 b=pQdZ9jA2P7iCED0yWsolm+rWYNee5E1bFGW46QdqNMJ7MVskwvLNWgFzK+CBozZw7N4wqv0SlSxqZBm1Vhca9OQEgPsRVWgLLmixNXN2Uv0+lLZ/QLr1kH5k4OzZerP+r76I9WrW4Y86e7LleOMItiZl3Bxv51Qx2YIDNSxhaFY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com.cn;
 s=zohoarc; t=1601483800;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To;
 bh=nDUXJ0aD0OpbgdchhPD1AE3rG4yeFoP17l7N2MrqhVc=; 
 b=j8ShZ4oO2ozRRAMIryhVa2FZbLUlZAvssU7cpqlC3F0qC6dkISivxTLWHmb9PnA5eVcQvfefZv8LzBuVTsHCHSp6baNRT3xTnom2ELcfhChPPz4Dy/bWZVifxZUVgrKKxmAv28afD73WPmr/rEucf08vgywXPtrCBmmcLLSnQ58=
ARC-Authentication-Results: i=1; mx.zoho.com.cn;
 dkim=pass  header.i=euphon.net;
 spf=pass  smtp.mailfrom=fam@euphon.net;
 dmarc=pass header.from=<fam@euphon.net> header.from=<fam@euphon.net>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1601483800; 
 s=zoho; d=euphon.net; i=fam@euphon.net;
 h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:Content-Type:Mime-Version:Content-Transfer-Encoding;
 bh=nDUXJ0aD0OpbgdchhPD1AE3rG4yeFoP17l7N2MrqhVc=;
 b=dE1QHrspMn4nenFt+4z6kld8pUzz7LXzVK9Htfw22q9Mk+z/DFqHDH20mYdXbWM1
 lxcmjz+taqJ+/ZfCLVyqOa1UNZ0vld20MFeexx7LJYd++3SMdF0mWfdTFdwSY63Us+C
 mFwTnj0u2Phq0/wgWmzI5Cv+kOhQMSYM/3PrJk4U=
Received: from u60bdefc337955a.ant.amazon.com (54.239.6.185 [54.239.6.185]) by
 mx.zoho.com.cn with SMTPS id 1601483797963335.588003385917;
 Thu, 1 Oct 2020 00:36:37 +0800 (CST)
Message-ID: <f78c368c7a61c2386deec50cd3386253588e64dc.camel@euphon.net>
Subject: Re: [PATCH 1/4] vmdk: fix maybe uninitialized warnings
From: Fam Zheng <fam@euphon.net>
To: Christian Borntraeger <borntraeger@de.ibm.com>, qemu-devel@nongnu.org
Date: Wed, 30 Sep 2020 17:36:29 +0100
In-Reply-To: <20200930155859.303148-2-borntraeger@de.ibm.com>
References: <20200930155859.303148-1-borntraeger@de.ibm.com>
 <20200930155859.303148-2-borntraeger@de.ibm.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-ZohoCNMailClient: External
Received-SPF: pass client-ip=163.53.93.243; envelope-from=fam@euphon.net;
 helo=sender2-op-o12.zoho.com.cn
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/30 12:37:02
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Kevin Wolf <kwolf@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>, qemu-block@nongnu.org,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 2020-09-30 at 17:58 +0200, Christian Borntraeger wrote:
> Fedora 32 gcc 10 seems to give false positives:
>=20
> Compiling C object libblock.fa.p/block_vmdk.c.o
> ../block/vmdk.c: In function =E2=80=98vmdk_parse_extents=E2=80=99:
> ../block/vmdk.c:587:5: error: =E2=80=98extent=E2=80=99 may be used uninit=
ialized in
> this function [-Werror=3Dmaybe-uninitialized]
>   587 |     g_free(extent->l1_table);
>       |     ^~~~~~~~~~~~~~~~~~~~~~~~
> ../block/vmdk.c:754:17: note: =E2=80=98extent=E2=80=99 was declared here
>   754 |     VmdkExtent *extent;
>       |                 ^~~~~~
> ../block/vmdk.c:620:11: error: =E2=80=98extent=E2=80=99 may be used unini=
tialized in
> this function [-Werror=3Dmaybe-uninitialized]
>   620 |     ret =3D vmdk_init_tables(bs, extent, errp);
>       |           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> ../block/vmdk.c:598:17: note: =E2=80=98extent=E2=80=99 was declared here
>   598 |     VmdkExtent *extent;
>       |                 ^~~~~~
> ../block/vmdk.c:1178:39: error: =E2=80=98extent=E2=80=99 may be used unin=
itialized in
> this function [-Werror=3Dmaybe-uninitialized]
>  1178 |             extent->flat_start_offset =3D flat_offset << 9;
>       |             ~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~
> ../block/vmdk.c: In function =E2=80=98vmdk_open_vmdk4=E2=80=99:
> ../block/vmdk.c:581:22: error: =E2=80=98extent=E2=80=99 may be used unini=
tialized in
> this function [-Werror=3Dmaybe-uninitialized]
>   581 |     extent->l2_cache =3D
>       |     ~~~~~~~~~~~~~~~~~^
>   582 |         g_malloc(extent->entry_size * extent->l2_size *
> L2_CACHE_SIZE);
>       |         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> ~~~~~~~~~
> ../block/vmdk.c:872:17: note: =E2=80=98extent=E2=80=99 was declared here
>   872 |     VmdkExtent *extent;
>       |                 ^~~~~~
> ../block/vmdk.c: In function =E2=80=98vmdk_open=E2=80=99:
> ../block/vmdk.c:620:11: error: =E2=80=98extent=E2=80=99 may be used unini=
tialized in
> this function [-Werror=3Dmaybe-uninitialized]
>   620 |     ret =3D vmdk_init_tables(bs, extent, errp);
>       |           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> ../block/vmdk.c:598:17: note: =E2=80=98extent=E2=80=99 was declared here
>   598 |     VmdkExtent *extent;
>       |                 ^~~~~~
> cc1: all warnings being treated as errors
> make: *** [Makefile.ninja:884: libblock.fa.p/block_vmdk.c.o] Error 1
>=20
> fix them by assigning a default value.
>=20
> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
> ---
>  block/vmdk.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>=20
> diff --git a/block/vmdk.c b/block/vmdk.c
> index 8ec62c7ab798..a00dc00eb47a 100644
> --- a/block/vmdk.c
> +++ b/block/vmdk.c
> @@ -595,7 +595,7 @@ static int vmdk_open_vmfs_sparse(BlockDriverState
> *bs,
>      int ret;
>      uint32_t magic;
>      VMDK3Header header;
> -    VmdkExtent *extent;
> +    VmdkExtent *extent =3D NULL;
> =20
>      ret =3D bdrv_pread(file, sizeof(magic), &header, sizeof(header));
>      if (ret < 0) {
> @@ -751,7 +751,7 @@ static int vmdk_open_se_sparse(BlockDriverState
> *bs,
>      int ret;
>      VMDKSESparseConstHeader const_header;
>      VMDKSESparseVolatileHeader volatile_header;
> -    VmdkExtent *extent;
> +    VmdkExtent *extent =3D NULL;
> =20
>      ret =3D bdrv_apply_auto_read_only(bs,
>              "No write support for seSparse images available", errp);
> @@ -869,7 +869,7 @@ static int vmdk_open_vmdk4(BlockDriverState *bs,
>      uint32_t magic;
>      uint32_t l1_size, l1_entry_sectors;
>      VMDK4Header header;
> -    VmdkExtent *extent;
> +    VmdkExtent *extent =3D NULL;
>      BDRVVmdkState *s =3D bs->opaque;
>      int64_t l1_backup_offset =3D 0;
>      bool compressed;
> @@ -1088,7 +1088,7 @@ static int vmdk_parse_extents(const char *desc,
> BlockDriverState *bs,
>      BdrvChild *extent_file;
>      BdrvChildRole extent_role;
>      BDRVVmdkState *s =3D bs->opaque;
> -    VmdkExtent *extent;
> +    VmdkExtent *extent =3D NULL;
>      char extent_opt_prefix[32];
>      Error *local_err =3D NULL;
> =20

Looks trivial, and correct.

Reviewed-by: Fam Zheng <fam@euphon.net>



