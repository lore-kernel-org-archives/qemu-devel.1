Return-Path: <SRS0=xYMn=7P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2DD7C433DF
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2020 16:02:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B30EF2067B
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2020 16:02:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="M0T1zS7M"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B30EF2067B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42110 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jg9Md-0006Z3-QI
	for qemu-devel@archiver.kernel.org; Tue, 02 Jun 2020 12:02:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58078)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jg9KR-0004nr-9v
 for qemu-devel@nongnu.org; Tue, 02 Jun 2020 11:59:51 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:46603
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jg9KQ-0001mN-2R
 for qemu-devel@nongnu.org; Tue, 02 Jun 2020 11:59:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591113588;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=61tLEqlYRAJNR1MRE40Mb4wlLy3jD3424aMpEo36Dew=;
 b=M0T1zS7M1DV4ltXc5rFhief72/OaaiiEnI715dZ8wy3+otBvZLXEY33fbuE5nKtpI85pmu
 4pwHHsMbMD+37rfOd5egdEAGTqndTAZfi80HyVmWFhijGFp/sjXKb+nN3UnUr0SBefIeem
 Bxkpj50xCK9DimCz/vAmkLPQyL3/f/A=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-405-y6W7rkw1Mz-wHdGCRb66nw-1; Tue, 02 Jun 2020 11:59:45 -0400
X-MC-Unique: y6W7rkw1Mz-wHdGCRb66nw-1
Received: by mail-wm1-f69.google.com with SMTP id b65so1114063wmb.5
 for <qemu-devel@nongnu.org>; Tue, 02 Jun 2020 08:59:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=61tLEqlYRAJNR1MRE40Mb4wlLy3jD3424aMpEo36Dew=;
 b=XQLdkmN1jbJcvrcbVyz1AWCP5iqpTwbpo0j9VdO5bIJzf7NS1VsiHXE+Uh7uxKOyf9
 fLnySHaJOkTwAHXy+CNjzlmpPSVyAjtqtFkYKupel0IelXme7sIz7PFW/2n/eluZOyTS
 uflbg0kVn1DlIFwEorYoO40GfbjOey45QACKgaY0GyRWkcTIW7PU47Jj/3tE6DIYj795
 QUNG+sZrIM+cpNY9jXOb228ZKky6wAVeRvhFFQ6beqvGN9iLHWodGMfcWc4wZLK1hep5
 HalUix5iAGtx1W46HohkDba9Y0Q2BgQzSM9BhC1vlaJa5vBwejXEBkCqF+frKvS1TUCW
 yOAQ==
X-Gm-Message-State: AOAM5324wiiko8oHMG0uANYBhP0XlZGPVwUnpofgZLGN3UWXVJVMUIfG
 5rrJ+/nsKkzr4gwDlI0tnqDcDqhdhCa0WeF6jhr4sC+dc54UO6wKHO95C/1oudr5hzk0Y50Xm8h
 +JpbdTFL0boPUBdE=
X-Received: by 2002:a1c:7305:: with SMTP id d5mr4931934wmb.85.1591113584445;
 Tue, 02 Jun 2020 08:59:44 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw8Eg9+hUgKOQowhh2W/jGTrSSrRQ2V+DQ9IH9763LmC9hd4SugJiYO9sqz32uzqE5BjgGDtQ==
X-Received: by 2002:a1c:7305:: with SMTP id d5mr4931914wmb.85.1591113584205;
 Tue, 02 Jun 2020 08:59:44 -0700 (PDT)
Received: from [192.168.1.43] (181.red-88-10-103.dynamicip.rima-tde.net.
 [88.10.103.181])
 by smtp.gmail.com with ESMTPSA id a126sm202865wme.28.2020.06.02.08.59.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 02 Jun 2020 08:59:43 -0700 (PDT)
Subject: Re: [PATCH v1 6/9] hw/virtio/pci: include vdev name in registered PCI
 sections
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20200602154624.4460-1-alex.bennee@linaro.org>
 <20200602154624.4460-7-alex.bennee@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Autocrypt: addr=philmd@redhat.com; keydata=
 mQINBDXML8YBEADXCtUkDBKQvNsQA7sDpw6YLE/1tKHwm24A1au9Hfy/OFmkpzo+MD+dYc+7
 bvnqWAeGweq2SDq8zbzFZ1gJBd6+e5v1a/UrTxvwBk51yEkadrpRbi+r2bDpTJwXc/uEtYAB
 GvsTZMtiQVA4kRID1KCdgLa3zztPLCj5H1VZhqZsiGvXa/nMIlhvacRXdbgllPPJ72cLUkXf
 z1Zu4AkEKpccZaJspmLWGSzGu6UTZ7UfVeR2Hcc2KI9oZB1qthmZ1+PZyGZ/Dy+z+zklC0xl
 XIpQPmnfy9+/1hj1LzJ+pe3HzEodtlVA+rdttSvA6nmHKIt8Ul6b/h1DFTmUT1lN1WbAGxmg
 CH1O26cz5nTrzdjoqC/b8PpZiT0kO5MKKgiu5S4PRIxW2+RA4H9nq7nztNZ1Y39bDpzwE5Sp
 bDHzd5owmLxMLZAINtCtQuRbSOcMjZlg4zohA9TQP9krGIk+qTR+H4CV22sWldSkVtsoTaA2
 qNeSJhfHQY0TyQvFbqRsSNIe2gTDzzEQ8itsmdHHE/yzhcCVvlUzXhAT6pIN0OT+cdsTTfif
 MIcDboys92auTuJ7U+4jWF1+WUaJ8gDL69ThAsu7mGDBbm80P3vvUZ4fQM14NkxOnuGRrJxO
 qjWNJ2ZUxgyHAh5TCxMLKWZoL5hpnvx3dF3Ti9HW2dsUUWICSQARAQABtDJQaGlsaXBwZSBN
 YXRoaWV1LURhdWTDqSAoUGhpbCkgPHBoaWxtZEByZWRoYXQuY29tPokCVQQTAQgAPwIbDwYL
 CQgHAwIGFQgCCQoLBBYCAwECHgECF4AWIQSJweePYB7obIZ0lcuio/1u3q3A3gUCXsfWwAUJ
 KtymWgAKCRCio/1u3q3A3ircD/9Vjh3aFNJ3uF3hddeoFg1H038wZr/xi8/rX27M1Vj2j9VH
 0B8Olp4KUQw/hyO6kUxqkoojmzRpmzvlpZ0cUiZJo2bQIWnvScyHxFCv33kHe+YEIqoJlaQc
 JfKYlbCoubz+02E2A6bFD9+BvCY0LBbEj5POwyKGiDMjHKCGuzSuDRbCn0Mz4kCa7nFMF5Jv
 piC+JemRdiBd6102ThqgIsyGEBXuf1sy0QIVyXgaqr9O2b/0VoXpQId7yY7OJuYYxs7kQoXI
 6WzSMpmuXGkmfxOgbc/L6YbzB0JOriX0iRClxu4dEUg8Bs2pNnr6huY2Ft+qb41RzCJvvMyu
 gS32LfN0bTZ6Qm2A8ayMtUQgnwZDSO23OKgQWZVglGliY3ezHZ6lVwC24Vjkmq/2yBSLakZE
 6DZUjZzCW1nvtRK05ebyK6tofRsx8xB8pL/kcBb9nCuh70aLR+5cmE41X4O+MVJbwfP5s/RW
 9BFSL3qgXuXso/3XuWTQjJJGgKhB6xXjMmb1J4q/h5IuVV4juv1Fem9sfmyrh+Wi5V1IzKI7
 RPJ3KVb937eBgSENk53P0gUorwzUcO+ASEo3Z1cBKkJSPigDbeEjVfXQMzNt0oDRzpQqH2vp
 apo2jHnidWt8BsckuWZpxcZ9+/9obQ55DyVQHGiTN39hkETy3Emdnz1JVHTU0Q==
Message-ID: <78830c87-6644-db69-fd0e-ab529553684b@redhat.com>
Date: Tue, 2 Jun 2020 17:59:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200602154624.4460-7-alex.bennee@linaro.org>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/01 23:49:17
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: robert.foley@linaro.org, "Michael S. Tsirkin" <mst@redhat.com>,
 robhenry@microsoft.com, aaron@os.amperecomputing.com, cota@braap.org,
 peter.puhov@linaro.org, kuhn.chenqun@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/2/20 5:46 PM, Alex Bennée wrote:
> When viewing/debugging memory regions it is sometimes hard to figure
> out which PCI device something belongs to. Make the names unique by
> including the vdev name in the name string.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
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
> 

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>


