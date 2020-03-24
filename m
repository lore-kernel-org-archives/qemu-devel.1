Return-Path: <SRS0=M7c2=5J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLACK,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1B54C41621
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2020 13:28:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9053A20870
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2020 13:28:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EVXhHXsM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9053A20870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48686 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jGjbY-0000vu-Lm
	for qemu-devel@archiver.kernel.org; Tue, 24 Mar 2020 09:28:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49350)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jGjap-0000KB-33
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 09:27:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jGjan-0004PC-C6
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 09:27:42 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:59852)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jGjan-0004Ok-94
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 09:27:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585056460;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qQM1qktLiJWqpFLGAZZl1dYjShi0yrqWlHrQmoCG0+E=;
 b=EVXhHXsMsMr50nnzQVjwOxMryLvCptDUGAv2smy5h2Y83lViG8N3VuzqjBtDwZEGIJpZO6
 G0wdldUHqa86k+Rp870+/3nX20KxnyJXTAQESBBxgvs93yH2ZJjY0o2NWyl6oc0bEEiWf0
 1qKAk/93zFwvJr96CK/+sy0ezlYBYKE=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-232-CHx2QAEzOb2I76JYOvCYvg-1; Tue, 24 Mar 2020 09:27:39 -0400
X-MC-Unique: CHx2QAEzOb2I76JYOvCYvg-1
Received: by mail-ed1-f72.google.com with SMTP id m24so14803456edq.8
 for <qemu-devel@nongnu.org>; Tue, 24 Mar 2020 06:27:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=qQM1qktLiJWqpFLGAZZl1dYjShi0yrqWlHrQmoCG0+E=;
 b=UFhwnpdRVnhSjnNprIfcyzMcB0CUIZa4/0o7Kz93aRhqKOx8KlLXbqmtzOQPO3X5v5
 g/YwO/hfzmBdrnrEYY/NWOGWBaBORN3DvImY3lDHqotebnK7ZQ5tnycCoNDe1+k90coR
 EGvCfANleLKHI/1BYXDCd8gX+ttSiUeSoWvW+O6O1L5XZFLHrNGIWgdTbyJBwXjVf6qM
 vSkUWSCuGoPpzTE/qSYKXzMMaRnsuj69mlLXJM9fc59ETzhk2Np/aGclUQriD7PC4+/L
 N66ArXJ5B+6QmH5Iov10OO9D0jblp1hQrrVLFKaR2Oq0mu4oULp59OOrHBtQBpTiTD5x
 ALTQ==
X-Gm-Message-State: ANhLgQ2NkdbSPgqMG2kSV4S8IBOBFSORyWUyjhlWBiaBSrr28rmwRdEp
 Fh6P9jNYNVvXxXJjuAtIeWJvZo/8/atasHXZVWNs/DHKu4YJud36X+D3gC6M9VU9Eb7E0OqiEHr
 POa/efBri+97ySZ4=
X-Received: by 2002:a17:906:7083:: with SMTP id
 b3mr24711626ejk.238.1585056457733; 
 Tue, 24 Mar 2020 06:27:37 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vvoCCOn0942HB7cO3eKw/stwMffoZuIXf8wIk9yxXdpyfLFBco6RhJwC9EMucZtUP6iJ2cgRw==
X-Received: by 2002:a17:906:7083:: with SMTP id
 b3mr24711603ejk.238.1585056457476; 
 Tue, 24 Mar 2020 06:27:37 -0700 (PDT)
Received: from [192.168.1.35] (37.red-83-52-54.dynamicip.rima-tde.net.
 [83.52.54.37])
 by smtp.gmail.com with ESMTPSA id t19sm1096289ejc.55.2020.03.24.06.27.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 24 Mar 2020 06:27:36 -0700 (PDT)
Subject: Re: [PATCH qemu] vfio/spapr: Fix page size calculation
To: Alexey Kardashevskiy <aik@ozlabs.ru>, qemu-devel@nongnu.org
References: <20200324063912.25063-1-aik@ozlabs.ru>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <87ddd733-8498-57a5-2fe2-8f1a3e60e0c9@redhat.com>
Date: Tue, 24 Mar 2020 14:27:35 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200324063912.25063-1-aik@ozlabs.ru>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 63.128.21.74
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
Cc: Alex Williamson <alex.williamson@redhat.com>, qemu-ppc@nongnu.org,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 3/24/20 7:39 AM, Alexey Kardashevskiy wrote:
> Coverity detected an issue (CID 1421903) with potential call of clz64(0)
> which returns 64 which make it do "<<" with a negative number.
> 
> This checks the mask and avoids undefined behaviour.
> 
> In practice pgsizes and memory_region_iommu_get_min_page_size() always
> have some common page sizes and even if they did not, the resulting page
> size would be 0x8000.0000.0000.0000 (gcc 9.2) and
> ioctl(VFIO_IOMMU_SPAPR_TCE_CREATE) would fail anyway.
> 
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> ---
>   hw/vfio/spapr.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/hw/vfio/spapr.c b/hw/vfio/spapr.c
> index 33692fc86fd6..2900bd19417a 100644
> --- a/hw/vfio/spapr.c
> +++ b/hw/vfio/spapr.c
> @@ -147,7 +147,7 @@ int vfio_spapr_create_window(VFIOContainer *container,
>   {
>       int ret = 0;
>       IOMMUMemoryRegion *iommu_mr = IOMMU_MEMORY_REGION(section->mr);
> -    uint64_t pagesize = memory_region_iommu_get_min_page_size(iommu_mr);
> +    uint64_t pagesize = memory_region_iommu_get_min_page_size(iommu_mr), pgmask;
>       unsigned entries, bits_total, bits_per_level, max_levels;
>       struct vfio_iommu_spapr_tce_create create = { .argsz = sizeof(create) };
>       long rampagesize = qemu_minrampagesize();
> @@ -159,8 +159,8 @@ int vfio_spapr_create_window(VFIOContainer *container,
>       if (pagesize > rampagesize) {
>           pagesize = rampagesize;
>       }
> -    pagesize = 1ULL << (63 - clz64(container->pgsizes &
> -                                   (pagesize | (pagesize - 1))));
> +    pgmask = container->pgsizes & (pagesize | (pagesize - 1));

Is that ROUND_UP(container->pgsizes, pagesize)?

> +    pagesize = pgmask ? (1ULL << (63 - clz64(pgmask))) : 0;
>       if (!pagesize) {
>           error_report("Host doesn't support page size 0x%"PRIx64
>                        ", the supported mask is 0x%lx",
> 


