Return-Path: <SRS0=cfdO=BG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73BCDC433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2020 13:33:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3FA4E207FC
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2020 13:33:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FpcgulD8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3FA4E207FC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43012 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k03Fj-00005P-Gl
	for qemu-devel@archiver.kernel.org; Mon, 27 Jul 2020 09:33:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56486)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1k03Ew-00086P-Q7
 for qemu-devel@nongnu.org; Mon, 27 Jul 2020 09:32:26 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:38308
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1k03Eu-0007ia-VJ
 for qemu-devel@nongnu.org; Mon, 27 Jul 2020 09:32:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595856744;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RmXA8qhhnpj18aQGofBntySzakG3RcJAdmZwbk5uTJo=;
 b=FpcgulD8mv3Vq5mLxY9/L3bUpMyKHQrtL/QhMsGSqDikDJyp12GZUl04tfR91JTABZXuNs
 cDZaAq7uENVgRTYGs+bmHcAyD5Bbh22X4ETG8X9Gv3N27ngZTZ+gUNE/sX221Wf5PVUFOr
 ViJjhz4WDEs/5F0dbBNZT1OtbL7fK2o=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-147-H0pAeVg4Pfqqbd5M6CetVg-1; Mon, 27 Jul 2020 09:32:15 -0400
X-MC-Unique: H0pAeVg4Pfqqbd5M6CetVg-1
Received: by mail-wr1-f71.google.com with SMTP id f14so3917275wrm.22
 for <qemu-devel@nongnu.org>; Mon, 27 Jul 2020 06:32:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=JTdauwM5SHnHEcc7VfzWG2Gc3sibHwbFmlKOszL/LVU=;
 b=Tq0n9JrT5YTskBByjMWYvt3vfZ1Qw7Nv9bdJ050xZO+H8MWGCHxUCv0dKi8DH2C0Zj
 BNB2Y88CgD5/9nho/gEbMw43nSHjABREvRs12fiqDwrW6PSzNWlhCCL+xd1QV6GoW60C
 ihytVQmc75ogrk1stZqThCjxaJ43kHQ7ctbdzL4ueVdnPYaSVcgpftZi1a6Tj0YRH89K
 yP9LL0H2RMx2Mqkwhi5TTpLcvifk1AJIWpNlnri9eFvdrHeKo3jP7os9OFIEAbRTjo2W
 QU13kc25VZ0dNNXgnh1vv6AlzRlMn4sp/X3aZwiBMlhoLitDkGMPGsXF2vl+RoCoOYvD
 iDBA==
X-Gm-Message-State: AOAM531K1LfftKaRfTC6HIHpoJJmYKEq3GFiIHX4+FHK3hmhIL6VdF9w
 1LmLn7bLWtETkX5CnHdUE+2gQ/VLEzN1gR+nMVIh9v1bSO6fSfxMAjyivJUgrCrBOBDg6AKDEj/
 yorMuaNbVVvMGfOE=
X-Received: by 2002:adf:82a5:: with SMTP id 34mr20611904wrc.266.1595856734711; 
 Mon, 27 Jul 2020 06:32:14 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxpM8sUlKgEsGb0x8kH4HvzQm1zx8qrACaNGmn3RZusv+azQdB5X/Q8iJCDjh6Wg8yKGHr/zA==
X-Received: by 2002:adf:82a5:: with SMTP id 34mr20611882wrc.266.1595856734510; 
 Mon, 27 Jul 2020 06:32:14 -0700 (PDT)
Received: from redhat.com ([192.117.173.58])
 by smtp.gmail.com with ESMTPSA id p14sm12559547wrg.96.2020.07.27.06.32.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Jul 2020 06:32:13 -0700 (PDT)
Date: Mon, 27 Jul 2020 09:32:09 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Subject: Re: [PATCH v1 05/13] hw/virtio/pci: include vdev name in registered
 PCI sections
Message-ID: <20200727093107-mutt-send-email-mst@kernel.org>
References: <20200709141327.14631-1-alex.bennee@linaro.org>
 <20200709141327.14631-6-alex.bennee@linaro.org>
MIME-Version: 1.0
In-Reply-To: <20200709141327.14631-6-alex.bennee@linaro.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.81; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/27 03:37:14
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: fam@euphon.net, berrange@redhat.com, robert.foley@linaro.org,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>,
 richard.henderson@linaro.org, qemu-devel@nongnu.org, robhenry@microsoft.com,
 f4bug@amsat.org, aaron@os.amperecomputing.com, cota@braap.org,
 kuhn.chenqun@huawei.com, peter.puhov@linaro.org, aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Jul 09, 2020 at 03:13:19PM +0100, Alex Bennée wrote:
> When viewing/debugging memory regions it is sometimes hard to figure
> out which PCI device something belongs to. Make the names unique by
> including the vdev name in the name string.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> Reviewed-by: Michael S. Tsirkin <mst@redhat.com>


So I don't know what's the plan here. I think ideally core would
just do it for us automatically. Why not?
If it can't my ack stands, anyway, pls
merge with rest of the patches if that is deemed appropriate.

> ---
> v2
>   - swap ()'s for an extra -
> ---
>  hw/virtio/virtio-pci.c | 22 ++++++++++++++--------
>  1 file changed, 14 insertions(+), 8 deletions(-)
> 
> diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
> index 8554cf2a038e..215e680c71f4 100644
> --- a/hw/virtio/virtio-pci.c
> +++ b/hw/virtio/virtio-pci.c
> @@ -1406,7 +1406,8 @@ static void virtio_pci_device_write(void *opaque, hwaddr addr,
>      }
>  }
>  
> -static void virtio_pci_modern_regions_init(VirtIOPCIProxy *proxy)
> +static void virtio_pci_modern_regions_init(VirtIOPCIProxy *proxy,
> +                                           const char *vdev_name)
>  {
>      static const MemoryRegionOps common_ops = {
>          .read = virtio_pci_common_read,
> @@ -1453,36 +1454,41 @@ static void virtio_pci_modern_regions_init(VirtIOPCIProxy *proxy)
>          },
>          .endianness = DEVICE_LITTLE_ENDIAN,
>      };
> +    g_autoptr(GString) name = g_string_new(NULL);
>  
> -
> +    g_string_printf(name, "virtio-pci-common-%s", vdev_name);
>      memory_region_init_io(&proxy->common.mr, OBJECT(proxy),
>                            &common_ops,
>                            proxy,
> -                          "virtio-pci-common",
> +                          name->str,
>                            proxy->common.size);
>  
> +    g_string_printf(name, "virtio-pci-isr-%s", vdev_name);
>      memory_region_init_io(&proxy->isr.mr, OBJECT(proxy),
>                            &isr_ops,
>                            proxy,
> -                          "virtio-pci-isr",
> +                          name->str,
>                            proxy->isr.size);
>  
> +    g_string_printf(name, "virtio-pci-device-%s", vdev_name);
>      memory_region_init_io(&proxy->device.mr, OBJECT(proxy),
>                            &device_ops,
>                            virtio_bus_get_device(&proxy->bus),
> -                          "virtio-pci-device",
> +                          name->str,
>                            proxy->device.size);
>  
> +    g_string_printf(name, "virtio-pci-notify-%s", vdev_name);
>      memory_region_init_io(&proxy->notify.mr, OBJECT(proxy),
>                            &notify_ops,
>                            virtio_bus_get_device(&proxy->bus),
> -                          "virtio-pci-notify",
> +                          name->str,
>                            proxy->notify.size);
>  
> +    g_string_printf(name, "virtio-pci-notify-pio-%s", vdev_name);
>      memory_region_init_io(&proxy->notify_pio.mr, OBJECT(proxy),
>                            &notify_pio_ops,
>                            virtio_bus_get_device(&proxy->bus),
> -                          "virtio-pci-notify-pio",
> +                          name->str,
>                            proxy->notify_pio.size);
>  }
>  
> @@ -1623,7 +1629,7 @@ static void virtio_pci_device_plugged(DeviceState *d, Error **errp)
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


