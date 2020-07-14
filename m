Return-Path: <SRS0=DUFB=AZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1DE0C433E5
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2020 09:08:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6659C2076D
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2020 09:08:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HuuGf5hX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6659C2076D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60234 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jvGv6-0005ok-Lk
	for qemu-devel@archiver.kernel.org; Tue, 14 Jul 2020 05:08:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44614)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jvGuZ-0005Pz-NJ
 for qemu-devel@nongnu.org; Tue, 14 Jul 2020 05:07:39 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:50981
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jvGuY-0006Hr-1R
 for qemu-devel@nongnu.org; Tue, 14 Jul 2020 05:07:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594717657;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OMZnJ/T18yLqtrICA4x8z58IdyGwmA6jKPb6UgRue9Q=;
 b=HuuGf5hXW6qMR5heojXrDh1Q+RzIPEWWVaZBSyDCEi+N1BVGcrvSub0cskSKQU2W4IXtqQ
 WjzojXDdJDUT0NZtEMO4ymlvctvdni/6DiWZPPRhyVmLBlTTXmzzEDfRS/IYHGvHzXlsvj
 mjHtc7ZobCP0pSzv3QNzhb6JckhLQf0=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-276-ZET9qqR8OTqjJCCBL3JMZw-1; Tue, 14 Jul 2020 05:07:32 -0400
X-MC-Unique: ZET9qqR8OTqjJCCBL3JMZw-1
Received: by mail-wr1-f70.google.com with SMTP id e11so20866938wrs.2
 for <qemu-devel@nongnu.org>; Tue, 14 Jul 2020 02:07:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=e9UlVTOE00kYLA1iRp4LSZEgso6GSwT0n8Uc1DZmpwk=;
 b=oNQHSOeLEbZD7qIicjqPTcDymlaPLMG185/FTVTpwl4xojU/AWbaMuUdKrekOP5e9y
 q1/6Q9YxQLkLOAvoQ23E0QOitnmVWJtH/URXYgKgkmsRoxUFxmYZfMqhAAIyWWgBE985
 FZ9S4rWxfD4Exww1FhZyV+vc2K0QtLCF2oGVFJRZCD+8Jh5Jv2gPneiPd9s7ckINiDLg
 6FMZ+U3JvykS85aHzGaMFP/l2/yEw6TkrMUbiq3z2y2C9NkUc63BL8Wx7F9SASdY0OsO
 4DMhV5RnEJXhOnm2viyKcpnugZw1e1+K/3IZI1WrfHd45xs+vPrwRRtoOa5/Ay5ByYSW
 Dyfg==
X-Gm-Message-State: AOAM530Nwiz7RyRiJ8USgrQ6iQCrLfcxvArPs4qz8MXK7b+BKi9/h0OH
 RF4i6kpNV2HE+skNPWPZUmAt8fEiZwmPtCul2+CMBplb+JiWu+z5YkScwbVPN4SYHFfydMoOMQR
 NqmKS7KZ+PBdwA30=
X-Received: by 2002:a5d:44d1:: with SMTP id z17mr3918793wrr.259.1594717651272; 
 Tue, 14 Jul 2020 02:07:31 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJydPyonVomeIWJRz8XiNovUcbOIqVwa2ArAQOBz6m2EIV9ucULb7CM9zl0fPoghTfAqMMiuag==
X-Received: by 2002:a5d:44d1:: with SMTP id z17mr3918764wrr.259.1594717651062; 
 Tue, 14 Jul 2020 02:07:31 -0700 (PDT)
Received: from redhat.com (bzq-79-180-10-140.red.bezeqint.net. [79.180.10.140])
 by smtp.gmail.com with ESMTPSA id y77sm3773348wmd.36.2020.07.14.02.07.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Jul 2020 02:07:30 -0700 (PDT)
Date: Tue, 14 Jul 2020 05:07:26 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Subject: Re: [PATCH v2 09/11] hw/virtio/pci: include vdev name in registered
 PCI sections
Message-ID: <20200714050630-mutt-send-email-mst@kernel.org>
References: <20200713200415.26214-1-alex.bennee@linaro.org>
 <20200713200415.26214-10-alex.bennee@linaro.org>
MIME-Version: 1.0
In-Reply-To: <20200713200415.26214-10-alex.bennee@linaro.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.120; envelope-from=mst@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/14 01:42:04
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
Cc: fam@euphon.net, berrange@redhat.com, robert.foley@linaro.org,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>,
 richard.henderson@linaro.org, qemu-devel@nongnu.org, robhenry@microsoft.com,
 f4bug@amsat.org, aaron@os.amperecomputing.com, cota@braap.org,
 kuhn.chenqun@huawei.com, peter.puhov@linaro.org, aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Jul 13, 2020 at 09:04:13PM +0100, Alex Bennée wrote:
> When viewing/debugging memory regions it is sometimes hard to figure
> out which PCI device something belongs to. Make the names unique by
> including the vdev name in the name string.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> Reviewed-by: Michael S. Tsirkin <mst@redhat.com>

I wonder here: why don't we see the owner name when debugging? Maybe that's a better
way to address that.

> ---
> v2
>   - swap ()'s for an extra -
> ---
>  hw/virtio/virtio-pci.c | 22 ++++++++++++++--------
>  1 file changed, 14 insertions(+), 8 deletions(-)
> 
> diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
> index 8554cf2a03..215e680c71 100644
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


