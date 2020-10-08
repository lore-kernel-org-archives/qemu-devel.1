Return-Path: <SRS0=Ajie=DP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 844D4C433DF
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2020 21:24:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B35E32223F
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2020 21:24:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WejKmPPY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B35E32223F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54796 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQdPD-00051J-Ou
	for qemu-devel@archiver.kernel.org; Thu, 08 Oct 2020 17:24:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53830)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1kQdNY-00048L-Tj
 for qemu-devel@nongnu.org; Thu, 08 Oct 2020 17:23:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:20558)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1kQdNW-0004qE-Ia
 for qemu-devel@nongnu.org; Thu, 08 Oct 2020 17:23:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602192188;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oIPTEDnCBcVZTli0zGnrMmuHVYBhmtZMMlsMh75eDwM=;
 b=WejKmPPY5dP1VbrLllXLpdHj2rBNRIFtD4rBfee+uzxtHvKaAONRXwLOVFEru+5fQLiNrZ
 tvsj8jHnQEsawdxJ+RuA5fEXAilcQuPRGEbgWK85NCS4V+XYjErahz9O5MeTYNF1rV6u8m
 scN3K7i9VMLoQEE0RQGXBJuXvRrbUkg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-343-PQaX2PBXNRyAJ2uHWFeAWA-1; Thu, 08 Oct 2020 17:23:05 -0400
X-MC-Unique: PQaX2PBXNRyAJ2uHWFeAWA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B0DFC803F4D;
 Thu,  8 Oct 2020 21:23:03 +0000 (UTC)
Received: from w520.home (ovpn-113-244.phx2.redhat.com [10.3.113.244])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2B1285C1D0;
 Thu,  8 Oct 2020 21:22:55 +0000 (UTC)
Date: Thu, 8 Oct 2020 15:22:54 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: Re: [PATCH v10 08/10] vfio: Set IOMMU page size as per host
 supported page size
Message-ID: <20201008152254.7bf6d8a7@w520.home>
In-Reply-To: <20201008171558.410886-9-jean-philippe@linaro.org>
References: <20201008171558.410886-1-jean-philippe@linaro.org>
 <20201008171558.410886-9-jean-philippe@linaro.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=alex.williamson@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=216.205.24.124;
 envelope-from=alex.williamson@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/08 02:56:27
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: mst@redhat.com, qemu-devel@nongnu.org, peterx@redhat.com,
 eric.auger@redhat.com, pbonzini@redhat.com, bbhushan2@marvell.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu,  8 Oct 2020 19:15:56 +0200
Jean-Philippe Brucker <jean-philippe@linaro.org> wrote:

> From: Bharat Bhushan <bbhushan2@marvell.com>
> 
> Set IOMMU supported page size mask same as host Linux supported page
> size mask.
> 
> Signed-off-by: Bharat Bhushan <bbhushan2@marvell.com>
> Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> ---
>  hw/vfio/common.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/hw/vfio/common.c b/hw/vfio/common.c
> index 13471ae2943..e66054b02a7 100644
> --- a/hw/vfio/common.c
> +++ b/hw/vfio/common.c
> @@ -636,6 +636,14 @@ static void vfio_listener_region_add(MemoryListener *listener,
>                              int128_get64(llend),
>                              iommu_idx);
>  
> +        ret = memory_region_iommu_set_page_size_mask(giommu->iommu,
> +                                                     container->pgsizes,
> +                                                     &err);
> +        if (ret) {
> +            g_free(giommu);
> +            goto fail;
> +        }
> +
>          ret = memory_region_register_iommu_notifier(section->mr, &giommu->n,
>                                                      &err);
>          if (ret) {

Acked-by: Alex Williamson <alex.williamson@redhat.com>


