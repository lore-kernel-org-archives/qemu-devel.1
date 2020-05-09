Return-Path: <SRS0=giGJ=6X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30706C28CBC
	for <qemu-devel@archiver.kernel.org>; Sat,  9 May 2020 12:02:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F3A0821473
	for <qemu-devel@archiver.kernel.org>; Sat,  9 May 2020 12:02:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BwbHyEUr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F3A0821473
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60270 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jXOBo-00014w-50
	for qemu-devel@archiver.kernel.org; Sat, 09 May 2020 08:02:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60472)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jXOB4-0000FT-NW
 for qemu-devel@nongnu.org; Sat, 09 May 2020 08:01:58 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:20558
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jXOB3-0007qS-F7
 for qemu-devel@nongnu.org; Sat, 09 May 2020 08:01:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589025716;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VtnfCdZ0mI4N9AycnXHM0PHZARhhX9vC2zBNKcVFHPE=;
 b=BwbHyEUrZL8AbWKMalNDEjspJELyD2TABK2BpDK0S4lNH9CNfooicKpKvzX71eJNkakVNg
 lZZDjg5XN1yESrgfrPnySuXuF76EK8P0Ac8e7r0fmE7F3UjnAgYjQcKjw5Bs6ldHy2KelI
 weGA69Hhs0FQMNOePVVTLwCKltrbJD0=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-472-nAOWqZKbPNqzbNhXLSC3wQ-1; Sat, 09 May 2020 08:01:55 -0400
X-MC-Unique: nAOWqZKbPNqzbNhXLSC3wQ-1
Received: by mail-wr1-f71.google.com with SMTP id u5so452241wrt.22
 for <qemu-devel@nongnu.org>; Sat, 09 May 2020 05:01:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=VtnfCdZ0mI4N9AycnXHM0PHZARhhX9vC2zBNKcVFHPE=;
 b=ngXWbUDd8hVKOg38grQzQBRcLSxdRtidRWr5ycxV6CRWQZwkxn2tyA8GHiqa5PxwdS
 GqJJQ6c8Q/7eOh/jnZZZjOkWjnkEDGh+sZTXnAvHZFPt1Be7iFcB8Lk4dPTxViQAUSOp
 m4oEBgbc8o00EnIEV8JyrsUPO9koA7G+ediZ42Re/tnqX8hasBD/F1yvqJwoUHWY3658
 FPDUppgSSq5iCgLVVuO6+nm4xXi433BqNa/eiiMcP3AQAGbvjdonB/6qdhm/53aCOvAQ
 IWQF52dX5ZclHmKhqWWvChfxPZwQBrQ5kX/8qTD9YEbwCNsEtkxKtOu1ADI3hCgl2Kg8
 vX+Q==
X-Gm-Message-State: AGi0Pua+5ZQ5XPYdWeB2Lk47S9jVBL1rXFNHKiCiH29IXOCj2ocII9Tc
 sk07qAsfrFxARReb5B6+xOuNsyceuT6kVYfpEYp3gaDVOzAMmSif5WpDPrwjhGK9XmG8NsMz7kz
 6ZK/3ijLnCZ84FUs=
X-Received: by 2002:a1c:5541:: with SMTP id j62mr10957848wmb.64.1589025713836; 
 Sat, 09 May 2020 05:01:53 -0700 (PDT)
X-Google-Smtp-Source: APiQypJbvBcWwzPvR9EySuaFPbPk7G2MyF3/+oo+JFOWCXPg5O73nfJLxirL71pGkHFny5ZY8qQ54Q==
X-Received: by 2002:a1c:5541:: with SMTP id j62mr10957822wmb.64.1589025713634; 
 Sat, 09 May 2020 05:01:53 -0700 (PDT)
Received: from [192.168.1.38] (17.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.17])
 by smtp.gmail.com with ESMTPSA id 128sm10370934wme.39.2020.05.09.05.01.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 09 May 2020 05:01:53 -0700 (PDT)
Subject: Re: [RFC v2 7/9] virito-pci: implement queue_enabled method
To: Cindy Lu <lulu@redhat.com>, mst@redhat.com, armbru@redhat.com,
 eblake@redhat.com, cohuck@redhat.com, jasowang@redhat.com
References: <20200508163218.22592-1-lulu@redhat.com>
 <20200508163218.22592-8-lulu@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <11e5604f-1a29-95ad-9d4b-2d75e5a26d9d@redhat.com>
Date: Sat, 9 May 2020 14:01:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200508163218.22592-8-lulu@redhat.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/09 08:01:07
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: mhabets@solarflare.com, qemu-devel@nongnu.org, rob.miller@broadcom.com,
 saugatm@xilinx.com, maxime.coquelin@redhat.com, hch@infradead.org,
 eperezma@redhat.com, jgg@mellanox.com, shahafs@mellanox.com,
 kevin.tian@intel.com, parav@mellanox.com, vmireyno@marvell.com,
 cunming.liang@intel.com, gdawar@xilinx.com, jiri@mellanox.com,
 xiao.w.wang@intel.com, stefanha@redhat.com, zhihong.wang@intel.com,
 aadam@redhat.com, rdunlap@infradead.org, hanand@xilinx.com,
 lingshan.zhu@intel.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Typo "virtio-pci" in patch subject.

On 5/8/20 6:32 PM, Cindy Lu wrote:
> From: Jason Wang <jasowang@redhat.com>
> 
> With version 1, we can detect whether a queue is enabled via
> queue_enabled.
> 
> Signed-off-by: Jason Wang <jasowang@redhat.com>
> ---
>   hw/virtio/virtio-pci.c | 13 +++++++++++++
>   1 file changed, 13 insertions(+)
> 
> diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
> index c6b47a9c73..4aaf5d953e 100644
> --- a/hw/virtio/virtio-pci.c
> +++ b/hw/virtio/virtio-pci.c
> @@ -1103,6 +1103,18 @@ static AddressSpace *virtio_pci_get_dma_as(DeviceState *d)
>       return pci_get_address_space(dev);
>   }
>   
> +static bool virtio_pci_queue_enabled(DeviceState *d, int n)
> +{
> +    VirtIOPCIProxy *proxy = VIRTIO_PCI(d);
> +    VirtIODevice *vdev = virtio_bus_get_device(&proxy->bus);
> +
> +    if (virtio_vdev_has_feature(vdev, VIRTIO_F_VERSION_1)) {
> +        return proxy->vqs[vdev->queue_sel].enabled;
> +    }
> +
> +    return virtio_queue_get_desc_addr(vdev, n) != 0;
> +}
> +
>   static int virtio_pci_add_mem_cap(VirtIOPCIProxy *proxy,
>                                      struct virtio_pci_cap *cap)
>   {
> @@ -2053,6 +2065,7 @@ static void virtio_pci_bus_class_init(ObjectClass *klass, void *data)
>       k->ioeventfd_enabled = virtio_pci_ioeventfd_enabled;
>       k->ioeventfd_assign = virtio_pci_ioeventfd_assign;
>       k->get_dma_as = virtio_pci_get_dma_as;
> +    k->queue_enabled = virtio_pci_queue_enabled;
>   }
>   
>   static const TypeInfo virtio_pci_bus_info = {
> 


