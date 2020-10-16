Return-Path: <SRS0=JoQ+=DX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42DE7C433E7
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2020 07:38:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8B962207F7
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2020 07:38:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TxfpqsP3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B962207F7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46472 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kTKJT-0004t8-LG
	for qemu-devel@archiver.kernel.org; Fri, 16 Oct 2020 03:38:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40680)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1kTKI8-0003xu-Au
 for qemu-devel@nongnu.org; Fri, 16 Oct 2020 03:36:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:59552)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1kTKI6-000083-Oe
 for qemu-devel@nongnu.org; Fri, 16 Oct 2020 03:36:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602833801;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JL4uO53rul9TFCH+2U3VHBDNUv+uNdipdwbWXAiSimU=;
 b=TxfpqsP3JewSXhzC2JjdqKcjFYW1Dp0npa+DGasaZl2vW1t+i1n1A4Up/UbUabj5USGNk8
 M+30aGxbUWAUUfkGwgOR75k0nHS1vwPsPpEBi5GPLsDOzlNoD5+MdvIEdkPJyu1c5yBii5
 mmx3yP3DwvwKZTo/HGXoJhjXdzFg8xo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-201-7CGdH6vnMRmsHVTbYgXNXQ-1; Fri, 16 Oct 2020 03:36:38 -0400
X-MC-Unique: 7CGdH6vnMRmsHVTbYgXNXQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E7E6B186841C;
 Fri, 16 Oct 2020 07:36:36 +0000 (UTC)
Received: from [10.36.113.210] (ovpn-113-210.ams2.redhat.com [10.36.113.210])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 82FA35D9CA;
 Fri, 16 Oct 2020 07:36:26 +0000 (UTC)
From: Auger Eric <eric.auger@redhat.com>
Subject: Re: [PATCH v10 01/10] virtio-iommu: Fix virtio_iommu_mr()
To: Jean-Philippe Brucker <jean-philippe@linaro.org>,
 alex.williamson@redhat.com
References: <20201008171558.410886-1-jean-philippe@linaro.org>
 <20201008171558.410886-2-jean-philippe@linaro.org>
Message-ID: <c60b6549-e6ce-79c7-1558-76f6cb882afb@redhat.com>
Date: Fri, 16 Oct 2020 09:36:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20201008171558.410886-2-jean-philippe@linaro.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=eric.auger@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=216.205.24.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/15 20:29:24
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-1.019, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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
Cc: pbonzini@redhat.com, bbhushan2@marvell.com, qemu-devel@nongnu.org,
 peterx@redhat.com, mst@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Jean,

On 10/8/20 7:15 PM, Jean-Philippe Brucker wrote:
> Due to an invalid mask, virtio_iommu_mr() may return the wrong memory
> region. It hasn't been too problematic so far because the function was
> only used to test existence of an endpoint, but that is about to change.
> 
> Fixes: cfb42188b24d ("virtio-iommu: Implement attach/detach command")
> Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
Maybe add
CC: QEMU Stable <qemu-stable@nongnu.org>

Acked-by: Eric Auger <eric.auger@redhat.com>

Thanks

Eric

> ---
>  hw/virtio/virtio-iommu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/virtio/virtio-iommu.c b/hw/virtio/virtio-iommu.c
> index a91fa2f674c..543fbbb24fb 100644
> --- a/hw/virtio/virtio-iommu.c
> +++ b/hw/virtio/virtio-iommu.c
> @@ -101,7 +101,7 @@ static IOMMUMemoryRegion *virtio_iommu_mr(VirtIOIOMMU *s, uint32_t sid)
>      bus_n = PCI_BUS_NUM(sid);
>      iommu_pci_bus = iommu_find_iommu_pcibus(s, bus_n);
>      if (iommu_pci_bus) {
> -        devfn = sid & PCI_DEVFN_MAX;
> +        devfn = sid & (PCI_DEVFN_MAX - 1);
>          dev = iommu_pci_bus->pbdev[devfn];
>          if (dev) {
>              return &dev->iommu_mr;
> 


