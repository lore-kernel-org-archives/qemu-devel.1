Return-Path: <SRS0=zezO=BB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E38AC433E2
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2020 11:49:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 57CD8206F5
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2020 11:49:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Q9wXMdDi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 57CD8206F5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55002 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jyDFl-0003V9-Ha
	for qemu-devel@archiver.kernel.org; Wed, 22 Jul 2020 07:49:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39834)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jyDF8-0002zy-9M
 for qemu-devel@nongnu.org; Wed, 22 Jul 2020 07:49:02 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:39667
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jyDF5-0003eI-Km
 for qemu-devel@nongnu.org; Wed, 22 Jul 2020 07:49:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595418538;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RM0b2LftaBME3E5qqYTLfRiBki+QMFObjE1EVv9BAWs=;
 b=Q9wXMdDi0bcNZXdcru2S2X5sA6RVrgx0Csopiyo7JI4E60TVJUE7/hYZ7eH8KC4pNJe7ag
 7yRuf3ZPxn8zhRS9FtmCTOg8EWlqBvW8Fe2xN+KPqNl//lr/trlK8Nc6udZQkG7k/LeX3h
 CBzvWtIfxVHQIvJiTt31Nmw34BdSO/I=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-10-k_Z6PNCNMLqiNPF78Cah9g-1; Wed, 22 Jul 2020 07:48:56 -0400
X-MC-Unique: k_Z6PNCNMLqiNPF78Cah9g-1
Received: by mail-wr1-f69.google.com with SMTP id a18so527168wrm.14
 for <qemu-devel@nongnu.org>; Wed, 22 Jul 2020 04:48:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=Nv3wyJyHDph66QmkZXjT+V6o30mQRLLcWLRYhCjRh9k=;
 b=qm2ZOTVzFsWmywQDUowI8QJGmBj/xLaGpua3RaI5qpBeteFZdslxGEmoC5CrsoU1g2
 SPHSUZHWXKnIatCIiBERkArYHXrok+Mxzk0OxF3lx/UrhcX6MJoV1/ITjJCoUhZkqWIQ
 QWf8OJNo+7KD8y35N6/yonkoG9BSePtSzDpdNs5OCoGCDa05YBG1Q+RDkiHINjaNOPpd
 wqBZAMWkibaGhTMgSEnPDhT2cckLJTsLLbrHZ3F0KP5j9sNp3EX8H3B5kn3el2YqokqA
 Da/KcdTV8eQfOt4PdGUXzMfPvlgZlLGOKJbCVj+O5RSu3qF3dEFh/tHvr3YD4ap4zBwo
 qI5A==
X-Gm-Message-State: AOAM530ucHOKMZX3zU4G45w9eQDXAuGDGwCiDbvL1EUOAM/dtehvZY7i
 NhBE9P2J3c4EAGnBI/YNF0w/lgvhIOm1nUilvKLdP0RTmemSqEQq0e7YAUiVPQzir7zRNvV6OdP
 1gODkvCDRcEeuE3E=
X-Received: by 2002:a1c:68c2:: with SMTP id d185mr6594785wmc.24.1595418535406; 
 Wed, 22 Jul 2020 04:48:55 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxJXEXKtJAvJLmUbhXWeD3PZnStPqWpv27bXeE6ctZhKnEjhhqyLTJlGbnOwedv+P51J7KmKg==
X-Received: by 2002:a1c:68c2:: with SMTP id d185mr6594772wmc.24.1595418535202; 
 Wed, 22 Jul 2020 04:48:55 -0700 (PDT)
Received: from redhat.com (bzq-79-182-82-99.red.bezeqint.net. [79.182.82.99])
 by smtp.gmail.com with ESMTPSA id
 v5sm6717491wmh.12.2020.07.22.04.48.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Jul 2020 04:48:54 -0700 (PDT)
Date: Wed, 22 Jul 2020 07:48:51 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Klaus Jensen <its@irrelevant.dk>
Subject: Re: [PATCH 1/2] pci: pass along the return value of dma_memory_rw
Message-ID: <20200722074834-mutt-send-email-mst@kernel.org>
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
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/21 21:28:05
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
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


Please feel free to merge this with the patch that uses the
return value.

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
> 
> 


