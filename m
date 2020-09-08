Return-Path: <SRS0=2IDT=CR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AED4C43461
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2020 14:20:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D88D8206A5
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2020 14:20:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TGs0+cCx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D88D8206A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60810 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFeUK-0004Ue-RV
	for qemu-devel@archiver.kernel.org; Tue, 08 Sep 2020 10:20:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35410)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kFeTl-0003ud-SZ
 for qemu-devel@nongnu.org; Tue, 08 Sep 2020 10:20:13 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:26582
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kFeTj-0005hF-Az
 for qemu-devel@nongnu.org; Tue, 08 Sep 2020 10:20:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599574810;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=AepqlJzty59lExFXqKs5CMiEOvgUHXLXBI3RP7CaMcQ=;
 b=TGs0+cCxJQPZEtrwUKLDYR7En5VFQ8yOz2svcv59I2y542vE7vpvjuXKjzi6LAlHRC1aXl
 M0Q+igyhmlSn3bSRQKcusfiexZygyA3nRmUyXWSzRUD3WJE69gnF3gx6AfCDWXOGNAZXJR
 xZ0tIQc2YL4H16SDW8k1TyXywAmeEr8=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-370-K0_Dt8GJNu6evMpbLS_qrg-1; Tue, 08 Sep 2020 10:20:02 -0400
X-MC-Unique: K0_Dt8GJNu6evMpbLS_qrg-1
Received: by mail-wm1-f69.google.com with SMTP id d5so3538972wmb.2
 for <qemu-devel@nongnu.org>; Tue, 08 Sep 2020 07:20:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=AepqlJzty59lExFXqKs5CMiEOvgUHXLXBI3RP7CaMcQ=;
 b=pdycrLxjCk7kVbIlyKdcyBkdfZh7Zj9o3upfJLl/7uCCneswj+pnM7uBGcfS5hzKXs
 rsQuPNEmCkRHb2NYSPZGVpuNAeorV2YozvI3Fts352yZUff/G+p7kCMyQFa3oWr3q6EG
 s1XichfgXgLhzVa510h4y8Rw/5IOJsBd2HzJT97nv6tCi22FdK217js04RHmIyxq6ckV
 gYxr32MI37n1IdJQaYy5K8L9LWRBEh98hfecvSKrHVGHhB5x29DajOZ5N29+2p09+hua
 ZRHaWZ85lg+qgSQykXsmRI0sHbKEX8lwxvJ+wFTePoTZkQgsFrKVnmNVc+10Uore8++L
 +8QQ==
X-Gm-Message-State: AOAM530i4s8rU7meKjZeeRhMCsyWvSa2oh0iATziFx5nM78V+Hg2b91s
 3m/BcS+m+zH7A7mewH+7+IvCYTxZN2Dl0eMwVyOKND7zGI+3EdC8Nl9+Iinn8kMNU5FBBjC06+7
 I2fvp13Kp9lsqUto=
X-Received: by 2002:adf:a18c:: with SMTP id u12mr28134294wru.90.1599574799224; 
 Tue, 08 Sep 2020 07:19:59 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzKkj0s3yGyFI/7nhvQbFj3a1dUtwUEaaWQYXURyDsXn+xMJEAewexjQQTtCs78qW9vjPzkxQ==
X-Received: by 2002:adf:a18c:: with SMTP id u12mr28134270wru.90.1599574799008; 
 Tue, 08 Sep 2020 07:19:59 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-218-236.inter.net.il. [80.230.218.236])
 by smtp.gmail.com with ESMTPSA id
 i6sm38373917wra.1.2020.09.08.07.19.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Sep 2020 07:19:57 -0700 (PDT)
Date: Tue, 8 Sep 2020 10:19:54 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: andrew@daynix.com
Subject: Re: [PATCH 2/2] hw/virtio-pci Added AER capability.
Message-ID: <20200908101813-mutt-send-email-mst@kernel.org>
References: <20200813071931.19846-1-andrew@daynix.com>
 <20200813071931.19846-2-andrew@daynix.com>
MIME-Version: 1.0
In-Reply-To: <20200813071931.19846-2-andrew@daynix.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.120; envelope-from=mst@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/08 02:10:53
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Aug 13, 2020 at 10:19:31AM +0300, andrew@daynix.com wrote:
> From: Andrew <andrew@daynix.com>
> 
> Buglink: https://bugzilla.redhat.com/show_bug.cgi?id=1857668
> Added AER capability for virtio-pci devices.
> Also added property for devices, by default AER is enabled.
> 
> Signed-off-by: Andrew Melnychenko <andrew@daynix.com>

Well AER is pci express only. I suspect you need to limit
this to express, fail on pci.




> ---
>  hw/virtio/virtio-pci.c | 16 ++++++++++++++++
>  hw/virtio/virtio-pci.h |  4 ++++
>  2 files changed, 20 insertions(+)
> 
> diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
> index 8e02709605..646dfb8a0d 100644
> --- a/hw/virtio/virtio-pci.c
> +++ b/hw/virtio/virtio-pci.c
> @@ -1806,6 +1806,12 @@ static void virtio_pci_realize(PCIDevice *pci_dev, Error **errp)
>           */
>          pci_set_word(pci_dev->config + pos + PCI_PM_PMC, 0x3);
>  
> +        if (proxy->flags & VIRTIO_PCI_FLAG_AER) {
> +            pcie_aer_init(pci_dev, PCI_ERR_VER, last_pcie_cap_offset,
> +                          PCI_ERR_SIZEOF, NULL);
> +            last_pcie_cap_offset += PCI_ERR_SIZEOF;
> +        }
> +
>          if (proxy->flags & VIRTIO_PCI_FLAG_INIT_DEVERR) {
>              /* Init error enabling flags */
>              pcie_cap_deverr_init(pci_dev);
> @@ -1847,7 +1853,15 @@ static void virtio_pci_realize(PCIDevice *pci_dev, Error **errp)
>  
>  static void virtio_pci_exit(PCIDevice *pci_dev)
>  {
> +    VirtIOPCIProxy *proxy = VIRTIO_PCI(pci_dev);
> +    bool pcie_port = pci_bus_is_express(pci_get_bus(pci_dev)) &&
> +                     !pci_bus_is_root(pci_get_bus(pci_dev));
> +
>      msix_uninit_exclusive_bar(pci_dev);
> +    if (proxy->flags & VIRTIO_PCI_FLAG_AER && pcie_port &&
> +        pci_is_express(pci_dev)) {
> +        pcie_aer_exit(pci_dev);
> +    }
>  }
>  
>  static void virtio_pci_reset(DeviceState *qdev)
> @@ -1900,6 +1914,8 @@ static Property virtio_pci_properties[] = {
>                      VIRTIO_PCI_FLAG_INIT_PM_BIT, true),
>      DEFINE_PROP_BIT("x-pcie-flr-init", VirtIOPCIProxy, flags,
>                      VIRTIO_PCI_FLAG_INIT_FLR_BIT, true),
> +    DEFINE_PROP_BIT("aer", VirtIOPCIProxy, flags,
> +                    VIRTIO_PCI_FLAG_AER_BIT, true),
>      DEFINE_PROP_END_OF_LIST(),
>  };
>

This will break cross version migration. Please disable this for
old machine types.

I am also unsure why it's on by default generally.
It is optional in express spec.


  
> diff --git a/hw/virtio/virtio-pci.h b/hw/virtio/virtio-pci.h
> index e2eaaa9182..4b2491ff15 100644
> --- a/hw/virtio/virtio-pci.h
> +++ b/hw/virtio/virtio-pci.h
> @@ -45,6 +45,7 @@ enum {
>      VIRTIO_PCI_FLAG_INIT_LNKCTL_BIT,
>      VIRTIO_PCI_FLAG_INIT_PM_BIT,
>      VIRTIO_PCI_FLAG_INIT_FLR_BIT,
> +    VIRTIO_PCI_FLAG_AER_BIT,
>  };
>  
>  /* Need to activate work-arounds for buggy guests at vmstate load. */
> @@ -84,6 +85,9 @@ enum {
>  /* Init Function Level Reset capability */
>  #define VIRTIO_PCI_FLAG_INIT_FLR (1 << VIRTIO_PCI_FLAG_INIT_FLR_BIT)
>  
> +/* Advanced Error Reporting capability */
> +#define VIRTIO_PCI_FLAG_AER (1 << VIRTIO_PCI_FLAG_AER_BIT)
> +
>  typedef struct {
>      MSIMessage msg;
>      int virq;
> -- 
> 2.27.0


