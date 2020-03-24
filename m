Return-Path: <SRS0=M7c2=5J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLACK,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32ABAC43331
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2020 14:30:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0390620714
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2020 14:30:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0390620714
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49754 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jGkZX-0004DA-4W
	for qemu-devel@archiver.kernel.org; Tue, 24 Mar 2020 10:30:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58103)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groug@kaod.org>) id 1jGkYd-0003YM-9K
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 10:29:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groug@kaod.org>) id 1jGkYc-0000Ix-0U
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 10:29:31 -0400
Received: from 5.mo69.mail-out.ovh.net ([46.105.43.105]:42648)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <groug@kaod.org>) id 1jGkYb-00009o-RY
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 10:29:29 -0400
Received: from player728.ha.ovh.net (unknown [10.110.171.136])
 by mo69.mail-out.ovh.net (Postfix) with ESMTP id CEE3987343
 for <qemu-devel@nongnu.org>; Tue, 24 Mar 2020 15:29:20 +0100 (CET)
Received: from kaod.org (lns-bzn-46-82-253-208-248.adsl.proxad.net
 [82.253.208.248]) (Authenticated sender: groug@kaod.org)
 by player728.ha.ovh.net (Postfix) with ESMTPSA id 8936E10A7CB5A;
 Tue, 24 Mar 2020 14:29:15 +0000 (UTC)
Date: Tue, 24 Mar 2020 15:29:13 +0100
From: Greg Kurz <groug@kaod.org>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Subject: Re: [PATCH qemu] vfio/spapr: Fix page size calculation
Message-ID: <20200324152913.39c52cb2@bahia.lan>
In-Reply-To: <20200324063912.25063-1-aik@ozlabs.ru>
References: <20200324063912.25063-1-aik@ozlabs.ru>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Ovh-Tracer-Id: 1819454253479074293
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedugedrudehuddgfeegucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepfffhvffukfgjfhfogggtgfesthejredtredtvdenucfhrhhomhepifhrvghgucfmuhhriicuoehgrhhouhhgsehkrghougdrohhrgheqnecukfhppedtrddtrddtrddtpdekvddrvdehfedrvddtkedrvdegkeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehplhgrhigvrhejvdekrdhhrgdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomhepghhrohhugheskhgrohgurdhorhhgpdhrtghpthhtohepqhgvmhhuqdguvghvvghlsehnohhnghhnuhdrohhrgh
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 46.105.43.105
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
 qemu-devel@nongnu.org, David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 24 Mar 2020 17:39:12 +1100
Alexey Kardashevskiy <aik@ozlabs.ru> wrote:

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

Reviewed-by: Greg Kurz <groug@kaod.org>

>  hw/vfio/spapr.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/hw/vfio/spapr.c b/hw/vfio/spapr.c
> index 33692fc86fd6..2900bd19417a 100644
> --- a/hw/vfio/spapr.c
> +++ b/hw/vfio/spapr.c
> @@ -147,7 +147,7 @@ int vfio_spapr_create_window(VFIOContainer *container,
>  {
>      int ret = 0;
>      IOMMUMemoryRegion *iommu_mr = IOMMU_MEMORY_REGION(section->mr);
> -    uint64_t pagesize = memory_region_iommu_get_min_page_size(iommu_mr);
> +    uint64_t pagesize = memory_region_iommu_get_min_page_size(iommu_mr), pgmask;
>      unsigned entries, bits_total, bits_per_level, max_levels;
>      struct vfio_iommu_spapr_tce_create create = { .argsz = sizeof(create) };
>      long rampagesize = qemu_minrampagesize();
> @@ -159,8 +159,8 @@ int vfio_spapr_create_window(VFIOContainer *container,
>      if (pagesize > rampagesize) {
>          pagesize = rampagesize;
>      }
> -    pagesize = 1ULL << (63 - clz64(container->pgsizes &
> -                                   (pagesize | (pagesize - 1))));
> +    pgmask = container->pgsizes & (pagesize | (pagesize - 1));
> +    pagesize = pgmask ? (1ULL << (63 - clz64(pgmask))) : 0;
>      if (!pagesize) {
>          error_report("Host doesn't support page size 0x%"PRIx64
>                       ", the supported mask is 0x%lx",


