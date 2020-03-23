Return-Path: <SRS0=WkHy=5I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLACK autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF93DC4332E
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2020 10:56:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AD7CD2077D
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2020 10:56:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ec3SX4EL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD7CD2077D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60138 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jGKkx-00012U-S6
	for qemu-devel@archiver.kernel.org; Mon, 23 Mar 2020 06:56:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38033)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jGKk5-0000OT-Ok
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 06:55:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1jGKk4-0000mP-7s
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 06:55:37 -0400
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:38675)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1jGKk3-0000m7-TK
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 06:55:36 -0400
Received: by mail-ot1-x344.google.com with SMTP id t28so12899535ott.5
 for <qemu-devel@nongnu.org>; Mon, 23 Mar 2020 03:55:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=hYwm9HbFatlIEHbhqMpCXWhtf9FYdCd8gdCDpDDhcpc=;
 b=Ec3SX4EL1Wv41mjXCHodPxm+gVjaNvHz/hfXngG4q+7fPrN7Q/8vj6M0cBZ3jiP+TH
 Zpf2uZ1yKi3tFJSGqtLUIH574Y4rb+bqWjNphvWjgMhLxE9/ARMR7tzI105AO5oCs49B
 RyLxeoOkekSyaUgtuhK/ve7WK+lO4QoifqiTNYut0dswmU+6IUPNc7LflihTv1U2eTGl
 arTnC6XAVNA0p4HEn3zrL/QfBSyPHGc+af/OM2HHkvLZ1yVIlFwH8/4cU5SRgxgGx2OE
 XTHBs3z3M+e7v5JUtDB14ZZu2xcvGCRMG8EumGCY8qlluPTpUXE7S3HgyIbz6cvm4Fy3
 h1FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=hYwm9HbFatlIEHbhqMpCXWhtf9FYdCd8gdCDpDDhcpc=;
 b=mMNFOJ2QxKmjut6lQ0IRT9CSqwvQKpU+vAkoKf/e6mJoTsXJCWQIemtSpwgwp5B4Dk
 J7I8WjMW1u4g74e5XSeibidbOwkVeHOXTCwx6UINT2ejM6SQMsEYXD3Doxpwc7PzrgUQ
 V3QyaApzwVdt1mKVPJ6UAOAw+SlCPR3APrDGhdL/UqOVsNvLtigzuVKp9AuNiNBYiqBz
 3OMNvL8WdnT+/UKk6PtoHPaavXVCjYT4H+G5WFa8ZTyoL9s3JB6wiWws4FWSqScDP5wg
 r3Xj7fhGzsM0H2vu4wsX0e0Wcf8LHf8xh7oou9PNZDgkRhVmfBhxCvn3HKaWmNm+Dn5F
 kbCw==
X-Gm-Message-State: ANhLgQ1Qpl8M3P4Nmx7ScUe/v2En+vZRtaIPLEeCk+D3u5q0UnygCKlw
 xrfO/jep/2hYld859SSne2gQk+6w0r1SUCoW3WNpHw==
X-Google-Smtp-Source: ADFU+vt7tJNPwEV5fzgsboMa6PIFW0ncs3vFoJewXRhzOUERwpy7Cx0jmALFBmNF6+NWJsBnwkbaIHwzZy72tbIb1yA=
X-Received: by 2002:a05:6830:1f39:: with SMTP id
 e25mr2441523oth.135.1584960934944; 
 Mon, 23 Mar 2020 03:55:34 -0700 (PDT)
MIME-Version: 1.0
References: <20180821043343.7514-1-david@gibson.dropbear.id.au>
 <20180821043343.7514-12-david@gibson.dropbear.id.au>
In-Reply-To: <20180821043343.7514-12-david@gibson.dropbear.id.au>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 23 Mar 2020 10:55:23 +0000
Message-ID: <CAFEAcA_yCceBjJU+QfcSe+wHkSZp90e3XZ-H_Au2VhfY_Zmuxw@mail.gmail.com>
Subject: Re: [PULL 11/26] vfio/spapr: Allow backing bigger guest IOMMU pages
 with smaller physical pages
To: David Gibson <david@gibson.dropbear.id.au>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::344
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
Cc: Laurent Vivier <lvivier@redhat.com>, Alexey Kardashevskiy <aik@ozlabs.ru>,
 Greg Kurz <groug@kaod.org>, QEMU Developers <qemu-devel@nongnu.org>,
 qemu-ppc <qemu-ppc@nongnu.org>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 21 Aug 2018 at 05:33, David Gibson <david@gibson.dropbear.id.au> wrote:
>
> From: Alexey Kardashevskiy <aik@ozlabs.ru>
>
> At the moment the PPC64/pseries guest only supports 4K/64K/16M IOMMU
> pages and POWER8 CPU supports the exact same set of page size so
> so far things worked fine.
>
> However POWER9 supports different set of sizes - 4K/64K/2M/1G and
> the last two - 2M and 1G - are not even allowed in the paravirt interface
> (RTAS DDW) so we always end up using 64K IOMMU pages, although we could
> back guest's 16MB IOMMU pages with 2MB pages on the host.
>
> This stores the supported host IOMMU page sizes in VFIOContainer and uses
> this later when creating a new DMA window. This uses the system page size
> (64k normally, 2M/16M/1G if hugepages used) as the upper limit of
> the IOMMU pagesize.
>
> This changes the type of @pagesize to uint64_t as this is what
> memory_region_iommu_get_min_page_size() returns and clz64() takes.
>
> There should be no behavioral changes on platforms other than pseries.
> The guest will keep using the IOMMU page size selected by the PHB pagesize
> property as this only changes the underlying hardware TCE table
> granularity.

Hi; Coverity has raised an issue (CID 1421903) on this code and
I'm not sure if it's correct or not.


> @@ -144,9 +145,27 @@ int vfio_spapr_create_window(VFIOContainer *container,
>  {
>      int ret;
>      IOMMUMemoryRegion *iommu_mr = IOMMU_MEMORY_REGION(section->mr);
> -    unsigned pagesize = memory_region_iommu_get_min_page_size(iommu_mr);
> +    uint64_t pagesize = memory_region_iommu_get_min_page_size(iommu_mr);
>      unsigned entries, pages;
>      struct vfio_iommu_spapr_tce_create create = { .argsz = sizeof(create) };
> +    long systempagesize = qemu_getrampagesize();
> +
> +    /*
> +     * The host might not support the guest supported IOMMU page size,
> +     * so we will use smaller physical IOMMU pages to back them.
> +     */
> +    if (pagesize > systempagesize) {
> +        pagesize = systempagesize;
> +    }
> +    pagesize = 1ULL << (63 - clz64(container->pgsizes &
> +                                   (pagesize | (pagesize - 1))));

If the argument to clz64() is zero then it will return 64, and
then we will try to do a shift by -1, which is undefined
behaviour.

Can the expression ever be zero? It's not immediately obvious to me
that it can't be, so my suggestion would be that if it is
impossible then an assert() of that would be helpful, and if it
is possible then the code needs to avoid the illegal shift.

> +    if (!pagesize) {
> +        error_report("Host doesn't support page size 0x%"PRIx64
> +                     ", the supported mask is 0x%lx",
> +                     memory_region_iommu_get_min_page_size(iommu_mr),
> +                     container->pgsizes);
> +        return -EINVAL;
> +    }

thanks
-- PMM

