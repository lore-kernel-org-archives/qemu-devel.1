Return-Path: <SRS0=q+n2=EF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 516B5C55179
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 08:59:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A94D220709
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 08:59:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fT6+DgeH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A94D220709
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59760 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kYQFU-0006Di-3B
	for qemu-devel@archiver.kernel.org; Fri, 30 Oct 2020 04:59:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53542)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kYQDb-00048b-UT
 for qemu-devel@nongnu.org; Fri, 30 Oct 2020 04:57:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:47768)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kYQDZ-0001sy-17
 for qemu-devel@nongnu.org; Fri, 30 Oct 2020 04:57:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604048224;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=oF7Q3ywxYByWKjiI+WLvvPiAA5UEwhtM/ZIRRWycrCM=;
 b=fT6+DgeHwtRPrvV+HpS89lAe3CV7CcZ9yJNCy9tMkOiiYATrivf/dY26GsVWFX2PGejL0Y
 UHMKBVoSnHOkLMe1zqt8A1bTCU7UV0CDBL8pnoECI1m87CAD9jfynTYAYpfKw44axa84yg
 txDzanpcUo71P9Qw8eYPsZz94xBCPXU=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-476-0ucRbqnlNl-PHWtECwQNig-1; Fri, 30 Oct 2020 04:57:01 -0400
X-MC-Unique: 0ucRbqnlNl-PHWtECwQNig-1
Received: by mail-wr1-f70.google.com with SMTP id 2so2407553wrd.14
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2020 01:57:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=oF7Q3ywxYByWKjiI+WLvvPiAA5UEwhtM/ZIRRWycrCM=;
 b=ZmymQqm5vnWK9XiHI6SFCRYsVEK7djSsqNhOILe1qkiwpwCSi8gpekMVaXP7uXNID2
 JBangY2QdPP/bZk1+TldwiYkaCrIw2amfYkahCefC69jYC/rSH0vA36rYlr92AlfWtO6
 e6xqiMbMmruYeDll+PotKP/2GUY5uoULUJg6i77eg0ygscQ+OvaMvDz4GdVRtmATPJsS
 uhU952PFW6kYNqT7Igk7WmdGAmn1sYN+qZWW/6Ocg8ckfgX7LmB5RXiuNbppmSiahu4B
 TL+2JSjPnZQ65IpxEoItPFiJcFavaDC6Zt9KcBeGD7VgSM+LwYA4oSxVW5yMUcAzSmhv
 ywDA==
X-Gm-Message-State: AOAM533I+4GU0Z6MaJoKAyCT0hzTILP1GE4C/uCzLAGU3eCxhVFHf/C3
 SLdFK9mHsp9PYdftcENU6cPuMzQzO1zEBt0ve/tKHSmdy3n7WbtwjPiNMyZUJgsx3YSFOD5F7Nw
 I2xmOBGacUkbYiPI=
X-Received: by 2002:adf:f7c3:: with SMTP id a3mr1815778wrq.254.1604048220480; 
 Fri, 30 Oct 2020 01:57:00 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw8eA1MNi7HScBvESBK7w6eHG+R6tAdSyvgPZoREpVKz/gFVUOoGpb6selwu8B/JqK1gcPQoQ==
X-Received: by 2002:adf:f7c3:: with SMTP id a3mr1815768wrq.254.1604048220348; 
 Fri, 30 Oct 2020 01:57:00 -0700 (PDT)
Received: from redhat.com (bzq-79-176-118-93.red.bezeqint.net. [79.176.118.93])
 by smtp.gmail.com with ESMTPSA id f7sm10260412wrx.64.2020.10.30.01.56.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Oct 2020 01:56:59 -0700 (PDT)
Date: Fri, 30 Oct 2020 04:56:57 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Eduardo Habkost <ehabkost@redhat.com>
Subject: Re: [PATCH 22/24] i440fx: Register i440FX-pcihost properties as
 class properties
Message-ID: <20201030045651-mutt-send-email-mst@kernel.org>
References: <20200921221045.699690-1-ehabkost@redhat.com>
 <20200921221045.699690-23-ehabkost@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200921221045.699690-23-ehabkost@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=63.128.21.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/30 01:22:25
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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
Cc: John Snow <jsnow@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Sep 21, 2020 at 06:10:43PM -0400, Eduardo Habkost wrote:
> Class properties make QOM introspection simpler and easier, as
> they don't require an object to be instantiated.
> 
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>

Reviewed-by: Michael S. Tsirkin <mst@redhat.com>


> ---
> Cc: "Michael S. Tsirkin" <mst@redhat.com>
> Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
> Cc: qemu-devel@nongnu.org
> ---
>  hw/pci-host/i440fx.c | 32 ++++++++++++++++----------------
>  1 file changed, 16 insertions(+), 16 deletions(-)
> 
> diff --git a/hw/pci-host/i440fx.c b/hw/pci-host/i440fx.c
> index 93c62235ca7..4454ba06621 100644
> --- a/hw/pci-host/i440fx.c
> +++ b/hw/pci-host/i440fx.c
> @@ -212,22 +212,6 @@ static void i440fx_pcihost_initfn(Object *obj)
>                            "pci-conf-idx", 4);
>      memory_region_init_io(&s->data_mem, obj, &pci_host_data_le_ops, s,
>                            "pci-conf-data", 4);
> -
> -    object_property_add(obj, PCI_HOST_PROP_PCI_HOLE_START, "uint32",
> -                        i440fx_pcihost_get_pci_hole_start,
> -                        NULL, NULL, NULL);
> -
> -    object_property_add(obj, PCI_HOST_PROP_PCI_HOLE_END, "uint32",
> -                        i440fx_pcihost_get_pci_hole_end,
> -                        NULL, NULL, NULL);
> -
> -    object_property_add(obj, PCI_HOST_PROP_PCI_HOLE64_START, "uint64",
> -                        i440fx_pcihost_get_pci_hole64_start,
> -                        NULL, NULL, NULL);
> -
> -    object_property_add(obj, PCI_HOST_PROP_PCI_HOLE64_END, "uint64",
> -                        i440fx_pcihost_get_pci_hole64_end,
> -                        NULL, NULL, NULL);
>  }
>  
>  static void i440fx_pcihost_realize(DeviceState *dev, Error **errp)
> @@ -403,6 +387,22 @@ static void i440fx_pcihost_class_init(ObjectClass *klass, void *data)
>      device_class_set_props(dc, i440fx_props);
>      /* Reason: needs to be wired up by pc_init1 */
>      dc->user_creatable = false;
> +
> +    object_class_property_add(klass, PCI_HOST_PROP_PCI_HOLE_START, "uint32",
> +                              i440fx_pcihost_get_pci_hole_start,
> +                              NULL, NULL, NULL);
> +
> +    object_class_property_add(klass, PCI_HOST_PROP_PCI_HOLE_END, "uint32",
> +                              i440fx_pcihost_get_pci_hole_end,
> +                              NULL, NULL, NULL);
> +
> +    object_class_property_add(klass, PCI_HOST_PROP_PCI_HOLE64_START, "uint64",
> +                              i440fx_pcihost_get_pci_hole64_start,
> +                              NULL, NULL, NULL);
> +
> +    object_class_property_add(klass, PCI_HOST_PROP_PCI_HOLE64_END, "uint64",
> +                              i440fx_pcihost_get_pci_hole64_end,
> +                              NULL, NULL, NULL);
>  }
>  
>  static const TypeInfo i440fx_pcihost_info = {
> -- 
> 2.26.2


