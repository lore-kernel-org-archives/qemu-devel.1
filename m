Return-Path: <SRS0=37Ja=DO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1B34C4363C
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2020 07:40:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F335E20870
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2020 07:40:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hsjspfYf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F335E20870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55372 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQ43M-0008Uv-4o
	for qemu-devel@archiver.kernel.org; Wed, 07 Oct 2020 03:40:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35826)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1kQ42j-00084B-QK
 for qemu-devel@nongnu.org; Wed, 07 Oct 2020 03:39:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:28284)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1kQ42i-0003Ef-71
 for qemu-devel@nongnu.org; Wed, 07 Oct 2020 03:39:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602056358;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Us9cl1zroBYxXJg6hqH8ppsdryN8aCJltU8ZJbMk9tY=;
 b=hsjspfYf2EV3fJbelmBUICq/Y/HaPxe4OaBZpvvWvt1pcqh2GOrM2gGhVH1ypdE2etLXbM
 31ZmUQhJ5SZrmziYcbzXGgNz461NEEgyJg/33UHVBsUmSCskdYd5slh3b2fAVhz3DGKYZW
 FZxVw5hv5s9t4QhqNZIF4Lq35E96RpE=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-557-CrYLzGMIN7Cz-LNeyIq16g-1; Wed, 07 Oct 2020 03:39:16 -0400
X-MC-Unique: CrYLzGMIN7Cz-LNeyIq16g-1
Received: by mail-wm1-f70.google.com with SMTP id p17so218511wmi.7
 for <qemu-devel@nongnu.org>; Wed, 07 Oct 2020 00:39:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=Us9cl1zroBYxXJg6hqH8ppsdryN8aCJltU8ZJbMk9tY=;
 b=UM1iNA/V2D/0sGh7oSI773B33mvxkJGf+p5Ufvh30l3HnNlr6lWsHzjTyVs5zhnZn+
 LFfT6Deo56/GBqpBljqPDkn1BjkwIy1kkqiiBXhHmqZ8bplTln2haGQNWDd+ck7DN5XK
 OSiXAJwrnAiHI4Qy3TTsNnBTqIU/ORghdnLSZsP9fyfndMVPgiE8phTUI6uejWdt6yh4
 8vMLXGNwLFaPtd2MELKN3fwjD4B1mlEpO504/OS4dOfe1dh6LK7X+iPtJuBagbQxU7Gw
 RQEhh1E+UZ/7yEsJiDu4Ki0280YuqGGxbGHfKvKXX5IZrYsGPJgOXpXvi6eU+TJx8Nul
 RiIg==
X-Gm-Message-State: AOAM532FbTOjyl4jnPUpYJB4osQy6bvya+dZsHAR95xIhLwkYtY24Tkx
 gCAwrQiAClKxfmLCz6IBaV75KF+rX2XIWsXYZWgEEF2zKg2PNjukB9rN8//KwA92yYE6T/w6SwF
 da0B5peImfnYASII=
X-Received: by 2002:a05:600c:22cf:: with SMTP id
 15mr1798937wmg.146.1602056355705; 
 Wed, 07 Oct 2020 00:39:15 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJznz6iYelWaBSU1LxKH1F5VZhAktFFgHj8wj0FBUh6881+wyoh/kOzwoUi4SOHrtepPcPkvMw==
X-Received: by 2002:a05:600c:22cf:: with SMTP id
 15mr1798927wmg.146.1602056355497; 
 Wed, 07 Oct 2020 00:39:15 -0700 (PDT)
Received: from steredhat (host-79-27-201-176.retail.telecomitalia.it.
 [79.27.201.176])
 by smtp.gmail.com with ESMTPSA id z11sm1593470wrh.70.2020.10.07.00.39.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Oct 2020 00:39:14 -0700 (PDT)
Date: Wed, 7 Oct 2020 09:39:12 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Julia Suvorova <jusual@redhat.com>
Subject: Re: [PATCH v2] hw/pci/pci: Fix slot check for plugged devices
Message-ID: <20201007073912.nyki6x7hy6qh6gtb@steredhat>
References: <20201006125908.598388-1-jusual@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20201006125908.598388-1-jusual@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=sgarzare@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=216.205.24.124; envelope-from=sgarzare@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/07 00:54:30
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.733,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org,
 "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Oct 06, 2020 at 02:59:08PM +0200, Julia Suvorova wrote:
> If devfn is assigned automatically, 'else' clauses will never be
> executed. And if it does not matter for the reserved and available
> devfn, because we have already checked it, the check for function0
> needs to be done again.
> 
> Steps to reproduce:
> 1. Run QEMU with:
>         -M q35 \
>         -device pcie-root-port,id=rp,.. \
>         -device pci-device,bus=rp
> 2. Add a new device to the same port:
>         device_add pci-device,bus=rp
> 
> The last command will add the device to slot 1 instead of
> failing with "PCI: slot 0 function 0 already occupied..."
> 
> Signed-off-by: Julia Suvorova <jusual@redhat.com>
> ---
> v2:
>     * add example to the commit message [Michael]
> 
>  hw/pci/pci.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/pci/pci.c b/hw/pci/pci.c
> index de0fae10ab..ae132b0b52 100644
> --- a/hw/pci/pci.c
> +++ b/hw/pci/pci.c
> @@ -1034,8 +1034,9 @@ static PCIDevice *do_pci_register_device(PCIDevice *pci_dev,
>                     PCI_SLOT(devfn), PCI_FUNC(devfn), name,
>                     bus->devices[devfn]->name);
>          return NULL;
> -    } else if (dev->hotplugged &&
> -               pci_get_function_0(pci_dev)) {
> +    };
        ^
This semicolon seems unnecessary, can we take it out?

Thanks,
Stefano

> +
> +    if (dev->hotplugged && pci_get_function_0(pci_dev)) {
>          error_setg(errp, "PCI: slot %d function 0 already ocuppied by %s,"
>                     " new func %s cannot be exposed to guest.",
>                     PCI_SLOT(pci_get_function_0(pci_dev)->devfn),
> -- 
> 2.25.4
> 
> 


