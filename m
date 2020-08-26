Return-Path: <SRS0=H0ck=CE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19C88C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2020 15:51:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C38182078D
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2020 15:51:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ed1PTkNm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C38182078D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51170 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAxht-0006i7-2Z
	for qemu-devel@archiver.kernel.org; Wed, 26 Aug 2020 11:51:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40758)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1kAxgu-0005og-4k
 for qemu-devel@nongnu.org; Wed, 26 Aug 2020 11:50:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:27081)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1kAxgo-0001BA-DC
 for qemu-devel@nongnu.org; Wed, 26 Aug 2020 11:50:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598457015;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=x1g0Fo+q2+qxb9tVugJhPh6JiZquv/69NfiCPRwMqjM=;
 b=Ed1PTkNmZQKblWH5JW9b9rW8nXy/s3eCFq8uDawedWWTLDKCvYtx38ZDXDaCkVJDGvKSmG
 na3sVbJA2RF1L4lfPKJ8zK8QM2hDm6dGZ5MabBMCU1np+U2r1j7PyJKqGJEPyFY3c0EytZ
 QH+JtxikF36/5nn+Lnv9qzHqu9oNAi4=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-228-Gc3FwmylOR2PbPU3E7nuVw-1; Wed, 26 Aug 2020 11:50:12 -0400
X-MC-Unique: Gc3FwmylOR2PbPU3E7nuVw-1
Received: by mail-qt1-f197.google.com with SMTP id w15so2043977qtv.11
 for <qemu-devel@nongnu.org>; Wed, 26 Aug 2020 08:50:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=x1g0Fo+q2+qxb9tVugJhPh6JiZquv/69NfiCPRwMqjM=;
 b=mfJv9pz9W3pLxaeYnT/uLn+K5rh2pft2izdgS4AivyZ5fSbSC8yXPI1saq/7t6QdwY
 nfLwuV3E7kYhz8wrNd0YPZf/8aMldI9VtTFI3zuGPTjyE5P2qRtG/piCb/pO38+fQolo
 6tg2GouoRitw3XQmmLIjnmJxYl7svsWaGPTsdrUiBMQuxYyh7mVwCvzQbLEA6XMCvkQU
 NKKUzmoukW90j8PnOovPlfsJUlReJNbvk6how/iuOazBrXpwYoxoKbuWo/uuTgXf7EkU
 BrGteOUsoZ+sMOVouu6nIoS/oUFViv+1gnqS7nuJtjj7DtSyoIylQucxQxDRVddQEym7
 EeQw==
X-Gm-Message-State: AOAM531iCBnTNNDfW1OLyYQSVvJXrbDEBeuZZJq+rCikaLUdC266vdPR
 KDuYgmj4n6LxbQkWZYkXTUkOGihkKaIboGoGHgEAHgplpVZRK+J/7bBf+cJpsAlDVmukrehX1Vz
 3cofyG6crCP9o+DM=
X-Received: by 2002:a05:6214:1910:: with SMTP id
 er16mr14302353qvb.228.1598457012447; 
 Wed, 26 Aug 2020 08:50:12 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy8wdf4dwgNRGDahlwE+BSaQqLyhBApWXSXw6PYEMIr3lsgPXQYRdxuCR3mESij1qLStrMsVA==
X-Received: by 2002:a05:6214:1910:: with SMTP id
 er16mr14302330qvb.228.1598457012234; 
 Wed, 26 Aug 2020 08:50:12 -0700 (PDT)
Received: from xz-x1 (bras-vprn-toroon474qw-lp130-11-70-53-122-15.dsl.bell.ca.
 [70.53.122.15])
 by smtp.gmail.com with ESMTPSA id j4sm1925068qkd.129.2020.08.26.08.50.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Aug 2020 08:50:11 -0700 (PDT)
Date: Wed, 26 Aug 2020 11:50:10 -0400
From: Peter Xu <peterx@redhat.com>
To: Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>
Subject: Re: [RFC v6 03/13] hw/alpha/typhoon: Mark all IOMMUTLBEntry as
 IOMMU_IOTLB_NONE type
Message-ID: <20200826155010.GF8235@xz-x1>
References: <20200625191651.5817-1-eperezma@redhat.com>
 <20200826143651.7915-1-eperezma@redhat.com>
 <20200826143651.7915-4-eperezma@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200826143651.7915-4-eperezma@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=peterx@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=63.128.21.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/26 06:53:10
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.959,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Yan Zhao <yan.y.zhao@intel.com>, Eduardo Habkost <ehabkost@redhat.com>,
 Juan Quintela <quintela@redhat.com>, Jason Wang <jasowang@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org,
 Eric Auger <eric.auger@redhat.com>, qemu-arm@nongnu.org,
 =?utf-8?B?SGVydsOp?= Poussineau <hpoussin@reactos.org>,
 Avi Kivity <avi@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Aug 26, 2020 at 04:36:41PM +0200, Eugenio Pérez wrote:
> Signed-off-by: Eugenio Pérez <eperezma@redhat.com>
> ---
>  hw/alpha/typhoon.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/hw/alpha/typhoon.c b/hw/alpha/typhoon.c
> index 29d44dfb06..b1e6c4e929 100644
> --- a/hw/alpha/typhoon.c
> +++ b/hw/alpha/typhoon.c
> @@ -615,6 +615,7 @@ static bool make_iommu_tlbe(hwaddr taddr, hwaddr mask, IOMMUTLBEntry *ret)
>          .translated_addr = taddr,
>          .addr_mask = mask,
>          .perm = IOMMU_RW,
> +        .type = IOMMU_IOTLB_NONE,

IMHO we don't need to touch all the IOMMUTLBEntry users, but only the callers
of memory_region_notify_iommu*().  We should also comment at the type field
that it's meaningless except when used for IOMMU notifications, because these
are really two different things: IOMMUTLBEntry was originally a translated
entry out of IOMMU hardware, so in those case it does not need a "type" field.

To make it clearer (depending on your preference...), we can introduce
IOMMUTLBEvent to be:

  struct IOMMUTLBEvent {
    IOMMUTLBEntry entry;
    IOMMUTLBType type;
  };

Then it'll be clear on which is which.  Though you'll need to touch more things
(all the callers and all the registerered notifiers).

Thanks,

-- 
Peter Xu


