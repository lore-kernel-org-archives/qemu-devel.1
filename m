Return-Path: <SRS0=cIHa=5F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D10AC4332D
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2020 10:43:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 60EAA2076C
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2020 10:43:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UgREWU9C"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 60EAA2076C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50726 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jFF7F-0005Jp-IQ
	for qemu-devel@archiver.kernel.org; Fri, 20 Mar 2020 06:43:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39451)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1jFF6M-0004U1-W8
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 06:42:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1jFF6M-0005tJ-16
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 06:42:06 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:32888)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1jFF6L-0005rj-TN
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 06:42:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584700925;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aKz9u7AXYPnIpgJfXbA5iM2ySWxulqd6M5ixJ0a9q5c=;
 b=UgREWU9CstgcnOlNiGJiCDvpoKQBH35LFNn7GQAnhvKluUcxDG4KkMj6Ha5ti0hg9sytVW
 lS+bvQzxC+TwpJR/4lOYuw1wNyZGxbUyv+KzozWnkl2C2Ch327tUGcFiE/NpxJ3IpcPFJi
 40dGFrFxqdiI6EMQ4KqdwRMR5ZGOols=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-72-WOUMkXWiMHWS6TQ_OmLosA-1; Fri, 20 Mar 2020 06:42:01 -0400
X-MC-Unique: WOUMkXWiMHWS6TQ_OmLosA-1
Received: by mail-wm1-f71.google.com with SMTP id n188so1651384wmf.0
 for <qemu-devel@nongnu.org>; Fri, 20 Mar 2020 03:42:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=aKz9u7AXYPnIpgJfXbA5iM2ySWxulqd6M5ixJ0a9q5c=;
 b=kSwhR0TYWmHJ41eeInYhAvMVWPYGNCwoYdyDV+1fGoVia5SjkJW/2CI8BJnUROeB1N
 qyjEVEEzLc/0RHZSktDaavM28i6xhQsteyOOCIPgvzbkNHxbOtNLjZZ8V9SpD/1/B3ya
 f3Ukm7FjTY3NrUTn6+Z3XIYLQB5V6H8CsZ10Q5yyy2jhXEHwK82lHpW6oWlYu2V/pDSc
 nIvmeh0REX2uny8f1oAAA3dq1nf1HgJ/Fzkn1br0qg6W0fzBdcPIDcP6DF/ZiBUYiThr
 MUyTRmvF0OoeqkQsXpAeViqjsWIDSzh/LXR3f/JDPAj0JQa3te/IGzLB/aLi3jAsGn4+
 ytZQ==
X-Gm-Message-State: ANhLgQ3Yq1eGQDhFZ5+R2XtDiF2nqJ1htQhhkpwwtTa4RDLsD3mtRxU+
 V3+UFkw+cLPiXWtodoIvy95A3cOxb0UpwmMMYIgWATITJ2BgPkG1Hqx9dC92NiAF2hH6zfOVi5x
 j2L/YloVC9unr0OY=
X-Received: by 2002:a5d:464e:: with SMTP id j14mr10172874wrs.339.1584700920582; 
 Fri, 20 Mar 2020 03:42:00 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vtYUt7qI1jGlYws7ADWEOisXONqHjJxSdS6e3LgLqBlC70AaROz6klxewlqsL19rTCG4XUU1Q==
X-Received: by 2002:a5d:464e:: with SMTP id j14mr10172860wrs.339.1584700920407; 
 Fri, 20 Mar 2020 03:42:00 -0700 (PDT)
Received: from [192.168.178.58] ([151.21.15.43])
 by smtp.gmail.com with ESMTPSA id v15sm2111864wrs.85.2020.03.20.03.41.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 20 Mar 2020 03:41:59 -0700 (PDT)
Subject: Re: [PATCH 00/13] microvm: add acpi support
To: Gerd Hoffmann <kraxel@redhat.com>
References: <20200319080117.7725-1-kraxel@redhat.com>
 <2ed586e7-d7a1-77b2-ecc6-01b6fb38d72e@redhat.com>
 <20200319134046.uh2qvyshwtj6ubox@sirius.home.kraxel.org>
 <259fbf57-6d1f-e3cd-d455-d2e6bc4e8b38@redhat.com>
 <20200320083227.6fnqrchjoii6hhli@sirius.home.kraxel.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <1351f912-d79a-656d-3f8d-76607365aa24@redhat.com>
Date: Fri, 20 Mar 2020 11:41:58 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200320083227.6fnqrchjoii6hhli@sirius.home.kraxel.org>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 63.128.21.74
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, Sergio Lopez <slp@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org,
 eric.auger@redhat.com, Igor Mammedov <imammedo@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 20/03/20 09:32, Gerd Hoffmann wrote:
> Hmm, seems we should have that for better regression testing.
> master branch doesn't build with pc+q35+isapc turned off:
> 
>   LINK    x86_64-softmmu/qemu-system-x86_64
> hw/virtio/virtio-iommu.o: In function `virtio_iommu_get_bdf':
> /home/kraxel/projects/qemu/hw/virtio/virtio-iommu.c:66: undefined reference to `pci_bus_num'
> hw/virtio/virtio-iommu.o: In function `iommu_find_iommu_pcibus':
> /home/kraxel/projects/qemu/hw/virtio/virtio-iommu.c:84: undefined reference to `pci_bus_num'
> hw/virtio/virtio-iommu.o: In function `virtio_iommu_device_realize':
> /home/kraxel/projects/qemu/hw/virtio/virtio-iommu.c:685: undefined reference to `pci_setup_iommu'
> collect2: error: ld returned 1 exit status

You need to disable virtio-iommu for now, or apply the patch I've just
sent and CC you on.

Paolo


