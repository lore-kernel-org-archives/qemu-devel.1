Return-Path: <SRS0=UKTp=CS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 331FCC433E2
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 08:39:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BCAB0215A4
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 08:39:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=euphon.net header.i=fam@euphon.net header.b="M2Ucm8Xi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BCAB0215A4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=euphon.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41494 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFve1-0002Fe-Qe
	for qemu-devel@archiver.kernel.org; Wed, 09 Sep 2020 04:39:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40886)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fam@euphon.net>)
 id 1kFvcx-0000v3-1D; Wed, 09 Sep 2020 04:38:51 -0400
Received: from sender2-op-o12.zoho.com.cn ([163.53.93.243]:17639)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fam@euphon.net>)
 id 1kFvcs-0006zo-9w; Wed, 09 Sep 2020 04:38:50 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1599640702; cv=none; d=zoho.com.cn; s=zohoarc; 
 b=E+/lTKReqydzSUpPehSDgHWj/V/qrfs8w79G5SUYOVKBCAeaLuvyVhbN01cqQBCcQMeZJ85pIPL0MRBzeaGy/fbtTAYPyjUWXOut9lg1sI6TU8GXcsxiqX6SV7FAMi87qvMdtOK4XRwUBbCZukrLQae+n2oYpRu1W74MW6RjSkU=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com.cn;
 s=zohoarc; t=1599640702;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To;
 bh=A+s6JKOwBlT3nIqqBlTNnSv8zmpSGkgPgR0d2cB6f7Y=; 
 b=V3ga9GPs4f3ctmG/l3Z1RN4FDoP1ms6StFpmDD6fm3cTiik8trAB0boDF1g5d6fQ1P9TLtkqZUnYYXbjfRunu/n0+EtLWK4AvDYDNTf/Bl8DAh8y4UKXTsPzlpFClh+gAaAcBFEtD+bNf4FdITY5nlSqVf++DWNaViJ5yrnue7k=
ARC-Authentication-Results: i=1; mx.zoho.com.cn;
 dkim=pass  header.i=euphon.net;
 spf=pass  smtp.mailfrom=fam@euphon.net;
 dmarc=pass header.from=<fam@euphon.net> header.from=<fam@euphon.net>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1599640702; 
 s=zoho; d=euphon.net; i=fam@euphon.net;
 h=Date:From:To:Cc:Message-ID:Subject:References:MIME-Version:Content-Type:Content-Transfer-Encoding:In-Reply-To;
 bh=A+s6JKOwBlT3nIqqBlTNnSv8zmpSGkgPgR0d2cB6f7Y=;
 b=M2Ucm8XiBE4QxHGoaUY5fVumTOxid/PRlxIgVnLGkVJgNoUaKvvEY3GJn05mcie7
 RqKGB3pqwYWw8xgBudZZ9cMDGAjv3AxZZb0BOtMqS450Qhdzbg1DaYP31raFk4BbzwL
 4iWIdg+nVNPO16pINvVqlHk5Mg/pdtCMj7FjjnVA=
Received: from localhost (ec2-52-56-101-76.eu-west-2.compute.amazonaws.com
 [52.56.101.76]) by mx.zoho.com.cn
 with SMTPS id 1599640700750107.10460783921292;
 Wed, 9 Sep 2020 16:38:20 +0800 (CST)
Date: Wed, 9 Sep 2020 08:38:15 +0000
From: Fam Zheng <fam@euphon.net>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Message-ID: <20200909083815.wp2f3kmc2xxgjukm@dev>
Subject: Re: [RFC PATCH v5 2/4] util/vfio-helpers: Report error when IOMMU
 page size is not supported
References: <20200908180342.280749-1-philmd@redhat.com>
 <20200908180342.280749-3-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20200908180342.280749-3-philmd@redhat.com>
X-ZohoCNMailClient: External
Received-SPF: pass client-ip=163.53.93.243; envelope-from=fam@euphon.net;
 helo=sender2-op-o12.zoho.com.cn
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/09 04:38:34
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org,
 Max Reitz <mreitz@redhat.com>, Alex Williamson <alex.williamson@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2020-09-08 20:03, Philippe Mathieu-Daud=E9 wrote:
> This driver uses the host page size to align its memory regions,
> but this size is not always compatible with the IOMMU. Add a
> check if the size matches, and bails out with listing the sizes
> the IOMMU supports.
>=20
> Example on Aarch64:
>=20
>  $ qemu-system-aarch64 -M virt -drive if=3Dnone,id=3Dnvme0,file=3Dnvme://=
0006:90:00.0/1,format=3Draw
>  qemu-system-aarch64: -drive if=3Dnone,id=3Dnvme0,file=3Dnvme://0006:90:0=
0.0/1,format=3Draw: Unsupported IOMMU page size: 4 KiB
>  Available page size:
>   64 KiB
>   512 MiB
>=20
> Suggested-by: Alex Williamson <alex.williamson@redhat.com>
> Signed-off-by: Philippe Mathieu-Daud=E9 <philmd@redhat.com>
> ---
>  util/vfio-helpers.c | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
>=20
> diff --git a/util/vfio-helpers.c b/util/vfio-helpers.c
> index 55b4107ce69..6d9ec7d365c 100644
> --- a/util/vfio-helpers.c
> +++ b/util/vfio-helpers.c
> @@ -11,6 +11,7 @@
>   */
> =20
>  #include "qemu/osdep.h"
> +#include "qemu/cutils.h"
>  #include <sys/ioctl.h>
>  #include <linux/vfio.h>
>  #include "qapi/error.h"
> @@ -316,6 +317,25 @@ static int qemu_vfio_init_pci(QEMUVFIOState *s, cons=
t char *device,
>          ret =3D -errno;
>          goto fail;
>      }
> +    if (!(iommu_info.flags & VFIO_IOMMU_INFO_PGSIZES)) {
> +        error_setg(errp, "Failed to get IOMMU page size info");
> +        ret =3D -errno;

We don't have errno here, do we?

> +        goto fail;
> +    }
> +    if (!extract64(iommu_info.iova_pgsizes,
> +                   ctz64(qemu_real_host_page_size), 1)) {
> +        g_autofree char *host_page_size =3D size_to_str(qemu_real_host_p=
age_size);
> +        error_setg(errp, "Unsupported IOMMU page size: %s", host_page_si=
ze);
> +        error_append_hint(errp, "Available page size:\n");
> +        for (int i =3D 0; i < 64; i++) {
> +            if (extract64(iommu_info.iova_pgsizes, i, 1)) {
> +                g_autofree char *iova_pgsizes =3D size_to_str(1UL << i);
> +                error_append_hint(errp, " %s\n", iova_pgsizes);

Interesting... Since it's printing page size which is fairly low level,
why not just plain (hex) numbers?

Fam

> +            }
> +        }
> +        ret =3D -EINVAL;
> +        goto fail;
> +    }
> =20
>      s->device =3D ioctl(s->group, VFIO_GROUP_GET_DEVICE_FD, device);
> =20
> --=20
> 2.26.2
>=20
>=20


