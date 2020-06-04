Return-Path: <SRS0=1Qun=7R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F28B9C433E0
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2020 11:36:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B78A9206C3
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2020 11:36:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BgLk1tHD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B78A9206C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34186 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jgoAq-0006uU-1R
	for qemu-devel@archiver.kernel.org; Thu, 04 Jun 2020 07:36:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43742)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jgoA4-0006Q7-AQ
 for qemu-devel@nongnu.org; Thu, 04 Jun 2020 07:35:52 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:21400
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jgoA3-0003BO-9K
 for qemu-devel@nongnu.org; Thu, 04 Jun 2020 07:35:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591270549;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5V0MJpayVz7nFshwMDXO+/fwvP6IDCKKSqlXC5O3+/s=;
 b=BgLk1tHDfP9v3XdAAAoNgiM3o2/rmb24+LpxsjEwvE8sH+UZh7LFH0g3jlor9LjFL5M3De
 XCQyZ3ntyUf1dYRLEZok8CQ07ojaZtIEGxn0r/6B5ka3H0N6kOuOyaYDuUrx4g6aZQ87Qg
 EnhhlQUCIGHJzmf9LlW+yjuYBhzlsmw=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-330-YdHff6xMMoyWjcJyrVeoPg-1; Thu, 04 Jun 2020 07:35:45 -0400
X-MC-Unique: YdHff6xMMoyWjcJyrVeoPg-1
Received: by mail-wr1-f70.google.com with SMTP id w16so2307740wru.18
 for <qemu-devel@nongnu.org>; Thu, 04 Jun 2020 04:35:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=gHY6TqO7QhSV2HYkz6VbuWTeVKfnIK1JQB0sbICEoHw=;
 b=escTuxMCdzyqlF0Nyb7nJiZvx8TOPlMyAkexZMvfWwYMGGEXckZjidDJ8sDgbAbgkf
 9who8kpRbdZ5yo1mrJO35nTzmQYvVewVTLZ1Yjf0pNxY64SNH4TjtehAYgf/zt7yW52c
 fYvYL0rnkQ7PJGWwCEp+T/xq04N7bu2uDCPhPvbpgRqMvkojCyRUECdqPgcJvv21m+hy
 CVe/TWgbD50pTrFF2a6rE996J2eGr95rfPx/HC4gZAuS9gOkCnC0Sbg26TM+y+8eue1x
 OFMmlJHhqCq2n+y3IUav+eCT7R6zhckI9nzNY/pu7UkRtuuGFCuUFwp362p4qLHs4hBd
 zKfQ==
X-Gm-Message-State: AOAM5333YM18t9PVnHgT3/lnjqeRo8+JGshOO04XsDi//2sA2SPcPc6r
 hbuYL3m2f/J43Sm7YARtq5ap28gflB9txDp+H/RM0CadOebz30VUW0UngZgjDTJKCzUIHcUtQzq
 UWzGyNajadK7ieYQ=
X-Received: by 2002:a5d:6444:: with SMTP id d4mr4155231wrw.239.1591270544060; 
 Thu, 04 Jun 2020 04:35:44 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxH2n8NZTeOlZb9EsLKerxOePVnFMw+j2IvFmh5DXCaY/rDRneS9xkRXjshwXDdeeY6blov7Q==
X-Received: by 2002:a5d:6444:: with SMTP id d4mr4155205wrw.239.1591270543854; 
 Thu, 04 Jun 2020 04:35:43 -0700 (PDT)
Received: from redhat.com ([2a00:a040:185:f65:9a3b:8fff:fed3:ad8d])
 by smtp.gmail.com with ESMTPSA id n19sm6736677wmi.33.2020.06.04.04.35.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Jun 2020 04:35:43 -0700 (PDT)
Date: Thu, 4 Jun 2020 07:35:40 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Subject: Re: [PATCH v1 6/9] hw/virtio/pci: include vdev name in registered
 PCI sections
Message-ID: <20200604073423-mutt-send-email-mst@kernel.org>
References: <20200602154624.4460-1-alex.bennee@linaro.org>
 <20200602154624.4460-7-alex.bennee@linaro.org>
MIME-Version: 1.0
In-Reply-To: <20200602154624.4460-7-alex.bennee@linaro.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.61; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/04 01:08:38
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: robert.foley@linaro.org, qemu-devel@nongnu.org, robhenry@microsoft.com,
 aaron@os.amperecomputing.com, cota@braap.org, peter.puhov@linaro.org,
 kuhn.chenqun@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Jun 02, 2020 at 04:46:21PM +0100, Alex Bennée wrote:
> When viewing/debugging memory regions it is sometimes hard to figure
> out which PCI device something belongs to. Make the names unique by
> including the vdev name in the name string.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

Reviewed-by: Michael S. Tsirkin <mst@redhat.com>

Feel free to merge with the rest of it.

> ---
>  hw/virtio/virtio-pci.c | 21 +++++++++++++--------
>  1 file changed, 13 insertions(+), 8 deletions(-)
> 
> diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
> index d028c17c240..9ee4ab26cfe 100644
> --- a/hw/virtio/virtio-pci.c
> +++ b/hw/virtio/virtio-pci.c
> @@ -1390,7 +1390,7 @@ static void virtio_pci_device_write(void *opaque, hwaddr addr,
>      }
>  }
>  
> -static void virtio_pci_modern_regions_init(VirtIOPCIProxy *proxy)
> +static void virtio_pci_modern_regions_init(VirtIOPCIProxy *proxy, const char *vdev_name)
>  {
>      static const MemoryRegionOps common_ops = {
>          .read = virtio_pci_common_read,
> @@ -1437,36 +1437,41 @@ static void virtio_pci_modern_regions_init(VirtIOPCIProxy *proxy)
>          },
>          .endianness = DEVICE_LITTLE_ENDIAN,
>      };
> +    g_autoptr(GString) name = g_string_new(NULL);
>  
> -
> +    g_string_printf(name, "virtio-pci-common(%s)", vdev_name);
>      memory_region_init_io(&proxy->common.mr, OBJECT(proxy),
>                            &common_ops,
>                            proxy,
> -                          "virtio-pci-common",
> +                          name->str,
>                            proxy->common.size);
>  
> +    g_string_printf(name, "virtio-pci-isr(%s)", vdev_name);
>      memory_region_init_io(&proxy->isr.mr, OBJECT(proxy),
>                            &isr_ops,
>                            proxy,
> -                          "virtio-pci-isr",
> +                          name->str,
>                            proxy->isr.size);
>  
> +    g_string_printf(name, "virtio-pci-device(%s)", vdev_name);
>      memory_region_init_io(&proxy->device.mr, OBJECT(proxy),
>                            &device_ops,
>                            virtio_bus_get_device(&proxy->bus),
> -                          "virtio-pci-device",
> +                          name->str,
>                            proxy->device.size);
>  
> +    g_string_printf(name, "virtio-pci-notify(%s)", vdev_name);
>      memory_region_init_io(&proxy->notify.mr, OBJECT(proxy),
>                            &notify_ops,
>                            virtio_bus_get_device(&proxy->bus),
> -                          "virtio-pci-notify",
> +                          name->str,
>                            proxy->notify.size);
>  
> +    g_string_printf(name, "virtio-pci-notify-pio(%s)", vdev_name);
>      memory_region_init_io(&proxy->notify_pio.mr, OBJECT(proxy),
>                            &notify_pio_ops,
>                            virtio_bus_get_device(&proxy->bus),
> -                          "virtio-pci-notify-pio",
> +                          name->str,
>                            proxy->notify_pio.size);
>  }
>  
> @@ -1607,7 +1612,7 @@ static void virtio_pci_device_plugged(DeviceState *d, Error **errp)
>  
>          struct virtio_pci_cfg_cap *cfg_mask;
>  
> -        virtio_pci_modern_regions_init(proxy);
> +        virtio_pci_modern_regions_init(proxy, vdev->name);
>  
>          virtio_pci_modern_mem_region_map(proxy, &proxy->common, &cap);
>          virtio_pci_modern_mem_region_map(proxy, &proxy->isr, &cap);
> -- 
> 2.20.1
> 
> 


