Return-Path: <SRS0=cfdO=BG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24A41C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2020 11:50:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E22E22072E
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2020 11:50:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hN+8DQi9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E22E22072E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45450 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k01dx-0003AS-6a
	for qemu-devel@archiver.kernel.org; Mon, 27 Jul 2020 07:50:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57644)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1k01d8-0002QJ-Sq
 for qemu-devel@nongnu.org; Mon, 27 Jul 2020 07:49:18 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:52924
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1k01d6-0001yu-I0
 for qemu-devel@nongnu.org; Mon, 27 Jul 2020 07:49:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595850555;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=x2cxipETFap080QmjZ+AjQtAaTqxixvBPDxepOeJnRo=;
 b=hN+8DQi9ZNsqtA/levjHuCnd4R3C36pRjPmbRhVAFcOjOuCTHAgFUcXauL2KzcG6RAKjKC
 xXzJfgcuYUndVf5hDY2Rlijb2YAvA50Avd9ZcdfXs5OQPzvSAsVPeOaFVFxnVz98ewWYZf
 aoionzTkV1pi8rT9E7mAbt1d0pQuaEc=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-208-cDVYjuHZMpe7Zq8Y3dd-fA-1; Mon, 27 Jul 2020 07:49:13 -0400
X-MC-Unique: cDVYjuHZMpe7Zq8Y3dd-fA-1
Received: by mail-wr1-f69.google.com with SMTP id m7so3832347wrb.20
 for <qemu-devel@nongnu.org>; Mon, 27 Jul 2020 04:49:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=x2cxipETFap080QmjZ+AjQtAaTqxixvBPDxepOeJnRo=;
 b=t8dZxj2VeAlzYY2si8hcMF/1AxXMRBKT3Jafp3QuJWOQ6QjM50hVcU93EnqMrG9IRk
 JsXeSh0yZjXO6rUf5aTjwquKBi7OxiYWY6KfsOpAVEI+Q7I4/Y+Aj6nrpsLYyIFSvpBs
 f0aa3xlt4KdGBFM6v6FC4SUVbvtODxILPspkQytqzc8ezPfrpEwTHB8929Zw1QJZ+sXY
 HwBm2+3uXWvAlo3Pol1XZjegjiKrY8VZTnQjjsbitnqCUmd7RR0gO+WkRUxANZGNaFJb
 d0/q/WHgpwM5nDlMBOfK4/8oTo7xmzOfLC/3OITg6CaOu1kLaDvUkBBQ4GmI3AENtUYl
 17Hw==
X-Gm-Message-State: AOAM533/zV5vGYpNBZnirCNcTpdMNi5dtYBBv5ynHRn7lsPqXS/sUz1H
 eh57e1Rg7afwuw5WtzaU3/CcT52wHus2Hs2/5fQSPw5MTeTqIr2P/cn8JYo7LUuVibLovH35DnH
 IE4jUTUqx4pX+UA0=
X-Received: by 2002:a7b:c057:: with SMTP id u23mr2273961wmc.167.1595850552246; 
 Mon, 27 Jul 2020 04:49:12 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJziezDWKSlO/VIZLRJI+M+4L/pwMs8It1/FrGzkXAiokb0utBEFmjkO9Bnub3OAC1Xu5ketpA==
X-Received: by 2002:a7b:c057:: with SMTP id u23mr2273942wmc.167.1595850551953; 
 Mon, 27 Jul 2020 04:49:11 -0700 (PDT)
Received: from redhat.com ([192.117.173.58])
 by smtp.gmail.com with ESMTPSA id i14sm14175968wrc.19.2020.07.27.04.49.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Jul 2020 04:49:11 -0700 (PDT)
Date: Mon, 27 Jul 2020 07:49:08 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH v1] virtio-mem-pci: force virtio version 1
Message-ID: <20200727074404-mutt-send-email-mst@kernel.org>
References: <20200708143619.38743-1-david@redhat.com>
 <d9cfad16-5b62-483a-c049-4dbaec51cd3e@redhat.com>
 <2a7d938b-cd30-4598-b151-d16dc0a2f46b@redhat.com>
MIME-Version: 1.0
In-Reply-To: <2a7d938b-cd30-4598-b151-d16dc0a2f46b@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.61; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/27 01:46:13
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
Cc: Cornelia Huck <cohuck@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Jul 27, 2020 at 01:42:56PM +0200, David Hildenbrand wrote:
> On 22.07.20 16:22, David Hildenbrand wrote:
> > On 08.07.20 16:36, David Hildenbrand wrote:
> >> Let's force virtio version 1. While at it, use qdev_realize() to set
> >> the parent bus and realize - like most other virtio-*-pci
> >> implementations.
> >>
> >> Fixes: 0b9a2443a48b ("virtio-pci: Proxy for virtio-mem")
> >> Cc: Cornelia Huck <cohuck@redhat.com>
> >> Cc: "Michael S. Tsirkin" <mst@redhat.com>
> >> Signed-off-by: David Hildenbrand <david@redhat.com>
> >> ---
> >>  hw/virtio/virtio-mem-pci.c | 4 ++--
> >>  1 file changed, 2 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/hw/virtio/virtio-mem-pci.c b/hw/virtio/virtio-mem-pci.c
> >> index 1a8e854123..831022aa86 100644
> >> --- a/hw/virtio/virtio-mem-pci.c
> >> +++ b/hw/virtio/virtio-mem-pci.c
> >> @@ -21,8 +21,8 @@ static void virtio_mem_pci_realize(VirtIOPCIProxy *vpci_dev, Error **errp)
> >>      VirtIOMEMPCI *mem_pci = VIRTIO_MEM_PCI(vpci_dev);
> >>      DeviceState *vdev = DEVICE(&mem_pci->vdev);
> >>  
> >> -    qdev_set_parent_bus(vdev, BUS(&vpci_dev->bus));
> >> -    object_property_set_bool(OBJECT(vdev), true, "realized", errp);
> >> +    virtio_pci_force_virtio_1(vpci_dev);
> >> +    qdev_realize(vdev, BUS(&vpci_dev->bus), errp);
> >>  }
> >>  
> >>  static void virtio_mem_pci_set_addr(MemoryDeviceState *md, uint64_t addr,
> >>
> > 
> > Ping @mst
> > 
> 
> With Conny's patches in, simple virtio-mem examples currently fail with
> 
> qemu-system-x86_64: -device
> virtio-mem-pci,id=vm0,memdev=mem0,node=0,requested-size=300M: device is
> modern-only, use disable-legacy=on
> 
> So we really want this in QEMU 5.1
> 
> -- 
> Thanks,
> 
> David / dhildenb

That's something to note in the commit log btw.


-- 
MST


