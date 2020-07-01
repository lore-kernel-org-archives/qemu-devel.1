Return-Path: <SRS0=qPFU=AM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D21FFC433DF
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2020 12:19:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9EF9F20760
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2020 12:19:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="K6y7RDSN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9EF9F20760
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46360 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqbi8-0001SB-Uo
	for qemu-devel@archiver.kernel.org; Wed, 01 Jul 2020 08:19:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33118)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jqbhV-0000wK-Ro
 for qemu-devel@nongnu.org; Wed, 01 Jul 2020 08:18:53 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:34081
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jqbhU-0006mS-9p
 for qemu-devel@nongnu.org; Wed, 01 Jul 2020 08:18:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593605931;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ot8hJvCBs4XWvu8ck7o5DULM70/1ucJ1bc/r+61/3wA=;
 b=K6y7RDSN7Y853rv2r5pT0oVj+uhQnBPKsXBhQH6v6jnVERGkgMqQfAzL5t+rOS9Fz0jl6J
 CTrUXAwHXKDjLOOTFSer++KXnUGPzDoyDjYhUXFE0ClqAWRZwkH2me3bT/r2F9fYXwV1Ma
 nR7EhnYY7sEYNDrtkY/RJWxe+v6Wo/E=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-124-BJJJcnSiOJKlmovL-yxhng-1; Wed, 01 Jul 2020 08:18:48 -0400
X-MC-Unique: BJJJcnSiOJKlmovL-yxhng-1
Received: by mail-wr1-f71.google.com with SMTP id c6so1172593wru.7
 for <qemu-devel@nongnu.org>; Wed, 01 Jul 2020 05:18:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=KJ3FZnF1a+diUKq4h7d0EBrneFllvQ91isDeMSD+yJM=;
 b=lW8x0yPHHQ3oC/Rq2UOvzZp0XHePTDI2oXx2btQOt7ikIzXLP+tMOcYh962v2Aai+Q
 1z8QUhTvX+5sGiFo/KKo4l5MQVYN9yE62wVj8Q9ov2v9g1RarsWeHVZvFBpyC/hxGcxV
 PWZLQ67dzDO1EPUxWuyqdJ6rzhGulLXMRWxBUEeAoGoacwtmvTtLSGhVcrP05xa3f7HA
 fUln1cKTRhKfsXvPavRp64aTsniRd7T/WbCgQ17dgl9txrayITvDEjI0Hb9VvtYh65ve
 8Rk2k/gga/BbFRWWHVNuBMHDbYeyir34Biehvbc3mZaUk6+wIHd57khBdwwGc0YdsQL/
 hnqA==
X-Gm-Message-State: AOAM532kT0RqIX5d/xoIiC2Z7J771XlnfEVHX3ebt+tDiZo7kCiiXmfR
 U2Y081TfyZNjAS1CTZNzw1Y20TpLDruWFiCSRICCJ5rb56kLiCPQ+LnN3qnfPEZ7sHa3yJuKkYN
 G8IEA2qr/jC5AA4k=
X-Received: by 2002:a1c:f314:: with SMTP id q20mr26485204wmq.18.1593605926967; 
 Wed, 01 Jul 2020 05:18:46 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxOuDfNmD/YeLMm0ZwBtwjdBeZEKppMst3K4dKKHwbE1lYUNo2O3l5/xs/LUOGsb8a419fubQ==
X-Received: by 2002:a1c:f314:: with SMTP id q20mr26485196wmq.18.1593605926792; 
 Wed, 01 Jul 2020 05:18:46 -0700 (PDT)
Received: from redhat.com (bzq-79-182-31-92.red.bezeqint.net. [79.182.31.92])
 by smtp.gmail.com with ESMTPSA id
 b10sm6586346wmj.30.2020.07.01.05.18.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Jul 2020 05:18:46 -0700 (PDT)
Date: Wed, 1 Jul 2020 08:18:43 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Klaus Jensen <its@irrelevant.dk>
Subject: Re: [PATCH 1/2] pci: pass along the return value of dma_memory_rw
Message-ID: <20200701081830-mutt-send-email-mst@kernel.org>
References: <20200629202053.1223342-1-its@irrelevant.dk>
 <20200629202053.1223342-2-its@irrelevant.dk>
MIME-Version: 1.0
In-Reply-To: <20200629202053.1223342-2-its@irrelevant.dk>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.61; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/01 01:05:53
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 Klaus Jensen <k.jensen@samsung.com>, qemu-devel@nongnu.org,
 Max Reitz <mreitz@redhat.com>, Keith Busch <kbusch@kernel.org>,
 Maxim Levitsky <mlevitsk@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Jun 29, 2020 at 10:20:52PM +0200, Klaus Jensen wrote:
> From: Klaus Jensen <k.jensen@samsung.com>
> 
> Some devices might want to know the return value of dma_memory_rw, so
> pass it along instead of ignoring it.
> 
> There are no existing users of the return value, so this patch should be
> safe.
> 
> Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
> Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
> Acked-by: Keith Busch <kbusch@kernel.org>

Feel free to merge with patch 2/2.

> ---
>  include/hw/pci/pci.h | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/include/hw/pci/pci.h b/include/hw/pci/pci.h
> index a4e9c3341615..2347dc36bfb5 100644
> --- a/include/hw/pci/pci.h
> +++ b/include/hw/pci/pci.h
> @@ -786,8 +786,7 @@ static inline AddressSpace *pci_get_address_space(PCIDevice *dev)
>  static inline int pci_dma_rw(PCIDevice *dev, dma_addr_t addr,
>                               void *buf, dma_addr_t len, DMADirection dir)
>  {
> -    dma_memory_rw(pci_get_address_space(dev), addr, buf, len, dir);
> -    return 0;
> +    return dma_memory_rw(pci_get_address_space(dev), addr, buf, len, dir);
>  }
>  
>  static inline int pci_dma_read(PCIDevice *dev, dma_addr_t addr,
> -- 
> 2.27.0


