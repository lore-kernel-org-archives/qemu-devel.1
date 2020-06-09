Return-Path: <SRS0=hUBF=7W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91B9AC433DF
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 15:48:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5BE39206A4
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 15:48:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZnLBCjyh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5BE39206A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60388 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jigUQ-0000jq-I6
	for qemu-devel@archiver.kernel.org; Tue, 09 Jun 2020 11:48:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39390)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jigTS-0000CK-C5
 for qemu-devel@nongnu.org; Tue, 09 Jun 2020 11:47:38 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:42388
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jigTR-0000R7-C2
 for qemu-devel@nongnu.org; Tue, 09 Jun 2020 11:47:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591717656;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/JGW0NnaRfuky2tYatN5aUpny9qByLWJZcC4YZ5tvvs=;
 b=ZnLBCjyhTQL0vMMbwwzWAmrAkqfcmQ7mm2FypdNb871efB8z6SdXjUXrjzTOAtbTwlv6eh
 hVEVpUPOwpFkqVOHyfFvwcOTMndrrLVXPT07xpmMphv8OKxISxPBDT9ZUHIlrhcNRH/EKc
 HrdSqkoGeWuXUBkptIFDNWH7v4Gtz6s=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-388-BlNMACBmM5qGva3XkWsFRw-1; Tue, 09 Jun 2020 11:47:34 -0400
X-MC-Unique: BlNMACBmM5qGva3XkWsFRw-1
Received: by mail-wr1-f71.google.com with SMTP id l18so8832633wrm.0
 for <qemu-devel@nongnu.org>; Tue, 09 Jun 2020 08:47:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=/JGW0NnaRfuky2tYatN5aUpny9qByLWJZcC4YZ5tvvs=;
 b=AqObFoRWAZwvSep69XCB8jHdmSQ8IOtGAeYamckucnv0RHg+pQziOwFn8FrKN+pyDS
 i+eS8So9JTpxvmS/lFwENOk6TIJk/n9gSuFEjgMRD16AQwYCXOWicCcSBFtG3xQ8qKxg
 JFoWRj4SPjtlYThTJ4mTugrX+wX2YZBhynioNE0SqIWtC2yE3hfci4IIuR00Ve1eD95q
 2tviOZGO/zDmGErKXMGHxWS3vLzCVxxWgUjCVg+a2vbnbP1zIW/O5NtapkiaiYCvnRIH
 EMOFNiMQVjAuf26z6VLndii4KlW+tc+ymei6zRmC4ngLJ5h2yb6bbMf9fXRws0aQLX3Q
 F6Pg==
X-Gm-Message-State: AOAM532niKdE3bCHED7yF5kVL6zUmpev3RPCanjQdMpUQngD1r0jxx6V
 nWfLMmnKfGg5AXBiyvY6RuMAKM7kxy1ZfWa66ERNAaS/NcBV3dBVGioTOnQHaAr5fvgP7VF+7Eq
 B44jpgxdpcbCzlCE=
X-Received: by 2002:adf:c44e:: with SMTP id a14mr4856562wrg.50.1591717653726; 
 Tue, 09 Jun 2020 08:47:33 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzFQUX9XqJPS+DbyhdpVXvZUPyIWslvX+NTavL4qTYzDxneXAJM6Oix0gNvqbD585/AXWch8A==
X-Received: by 2002:adf:c44e:: with SMTP id a14mr4856544wrg.50.1591717653507; 
 Tue, 09 Jun 2020 08:47:33 -0700 (PDT)
Received: from redhat.com (bzq-79-181-55-232.red.bezeqint.net. [79.181.55.232])
 by smtp.gmail.com with ESMTPSA id k14sm3783365wrq.97.2020.06.09.08.47.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Jun 2020 08:47:33 -0700 (PDT)
Date: Tue, 9 Jun 2020 11:47:30 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH v1] pc: Support coldplugging of virtio-pmem-pci devices
 on all buses
Message-ID: <20200609114608-mutt-send-email-mst@kernel.org>
References: <20200525084511.51379-1-david@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200525084511.51379-1-david@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.61; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/09 02:41:53
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: Pankaj Gupta <pankaj.gupta.linux@gmail.com>,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org,
 Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Vivek Goyal <vgoyal@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, May 25, 2020 at 10:45:11AM +0200, David Hildenbrand wrote:
> E.g., with "pc-q35-4.2", trying to coldplug a virtio-pmem-pci devices
> results in
>     "virtio-pmem-pci not supported on this bus"
> 
> Reasons is, that the bus does not support hotplug and, therefore, does
> not have a hotplug handler. Let's allow coldplugging virtio-pmem devices
> on such buses. The hotplug order is only relevant for virtio-pmem-pci
> when the guest is already alive and the device is visible before
> memory_device_plug() wired up the memory device bits.
> 
> Hotplug attempts will still fail with:
>     "Error: Bus 'pcie.0' does not support hotplugging"
> 
> Hotunplug attempts will still fail with:
>     "Error: Bus 'pcie.0' does not support hotplugging"
> 
> Reported-by: Vivek Goyal <vgoyal@redhat.com>
> Cc: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
> Cc: Igor Mammedov <imammedo@redhat.com>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Richard Henderson <rth@twiddle.net>
> Cc: Eduardo Habkost <ehabkost@redhat.com>
> Cc: "Michael S. Tsirkin" <mst@redhat.com>
> Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>

I assume you are still debugging Vivek's issues, right?
Let me know when you feel it's time to merge this ...

> ---
>  hw/i386/pc.c | 18 ++++++++++--------
>  1 file changed, 10 insertions(+), 8 deletions(-)
> 
> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
> index 2128f3d6fe..c740495eb6 100644
> --- a/hw/i386/pc.c
> +++ b/hw/i386/pc.c
> @@ -1663,13 +1663,13 @@ static void pc_virtio_pmem_pci_pre_plug(HotplugHandler *hotplug_dev,
>      HotplugHandler *hotplug_dev2 = qdev_get_bus_hotplug_handler(dev);
>      Error *local_err = NULL;
>  
> -    if (!hotplug_dev2) {
> +    if (!hotplug_dev2 && dev->hotplugged) {
>          /*
>           * Without a bus hotplug handler, we cannot control the plug/unplug
> -         * order. This should never be the case on x86, however better add
> -         * a safety net.
> +         * order. We should never reach this point when hotplugging on x86,
> +         * however, better add a safety net.
>           */
> -        error_setg(errp, "virtio-pmem-pci not supported on this bus.");
> +        error_setg(errp, "virtio-pmem-pci hotplug not supported on this bus.");
>          return;
>      }
>      /*
> @@ -1678,7 +1678,7 @@ static void pc_virtio_pmem_pci_pre_plug(HotplugHandler *hotplug_dev,
>       */
>      memory_device_pre_plug(MEMORY_DEVICE(dev), MACHINE(hotplug_dev), NULL,
>                             &local_err);
> -    if (!local_err) {
> +    if (!local_err && hotplug_dev2) {
>          hotplug_handler_pre_plug(hotplug_dev2, dev, &local_err);
>      }
>      error_propagate(errp, local_err);
> @@ -1696,9 +1696,11 @@ static void pc_virtio_pmem_pci_plug(HotplugHandler *hotplug_dev,
>       * device bits.
>       */
>      memory_device_plug(MEMORY_DEVICE(dev), MACHINE(hotplug_dev));
> -    hotplug_handler_plug(hotplug_dev2, dev, &local_err);
> -    if (local_err) {
> -        memory_device_unplug(MEMORY_DEVICE(dev), MACHINE(hotplug_dev));
> +    if (hotplug_dev2) {
> +        hotplug_handler_plug(hotplug_dev2, dev, &local_err);
> +        if (local_err) {
> +            memory_device_unplug(MEMORY_DEVICE(dev), MACHINE(hotplug_dev));
> +        }
>      }
>      error_propagate(errp, local_err);
>  }
> -- 
> 2.25.4


