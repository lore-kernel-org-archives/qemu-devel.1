Return-Path: <SRS0=UKTp=CS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6374C43461
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 17:51:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 25A6121D46
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 17:51:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bSr9efz5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 25A6121D46
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48880 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kG4FW-0006j1-86
	for qemu-devel@archiver.kernel.org; Wed, 09 Sep 2020 13:51:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41592)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsuvorov@redhat.com>)
 id 1kG4F1-0006IH-Al
 for qemu-devel@nongnu.org; Wed, 09 Sep 2020 13:50:43 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:21273
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jsuvorov@redhat.com>)
 id 1kG4Ey-0008W2-D2
 for qemu-devel@nongnu.org; Wed, 09 Sep 2020 13:50:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599673838;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=by4rVFJrYIJJU5k8VNQMWhlZjV7vStLEjxeDkbZybhk=;
 b=bSr9efz5h0BY4uia1uHaKrR3cyigw/wkRbqTenS3wt1vag7UmYnXTvR61nCb5khUXkTgqB
 jJclAbmV89k2Afqv1kh3wxUkQAqMxpQ9ZjyBtOPmJLkik90i9UMMz88jHEBktSp/PPHW9W
 Mq0imwX/quCYUxCqtK5qglUniSK8ugA=
Received: from mail-yb1-f198.google.com (mail-yb1-f198.google.com
 [209.85.219.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-346-e3xhosfZNe-U8S8UzH1lmQ-1; Wed, 09 Sep 2020 13:50:34 -0400
X-MC-Unique: e3xhosfZNe-U8S8UzH1lmQ-1
Received: by mail-yb1-f198.google.com with SMTP id v77so3055995ybi.2
 for <qemu-devel@nongnu.org>; Wed, 09 Sep 2020 10:50:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=by4rVFJrYIJJU5k8VNQMWhlZjV7vStLEjxeDkbZybhk=;
 b=nUkbdSEV8zBIBogUrEzMQ+DL7Gn930e/bAHcI9FCzjUlzNOu/hp920QPWwO/+MvSEt
 m5XPg2PSJhRGJglUbhQKhcIOC12LJDfahB6F7ugiku1nQwaG+P5iJ9VWTobYy5ZvjrJ4
 nH859eUTELkVZFa56yg6bM5dcyoc9fnXO/HVJtWI09/mN2dF7o0/UAtTA2N6Q2yXMQFK
 SgRCYCvMzKeKExDuCLhCjVA7kMpNMWOjsnxyEQYgsWJOgg14lpr3cMwYkCLaSOYIEYfQ
 2L6OymGWnSD+JY271GA0nQIJ5hFfVSIaxY+qqPhtLoj6OZqHII7COVUQA6Fu9cycJLWB
 hRPQ==
X-Gm-Message-State: AOAM530hk1e6ZlSkpzkISvp0x6HobzbrEh2qmzj9mW8NUeUAzqzthysU
 yu34hE0kxw937LDx8UuVfRb8Qwqf+wPuvbr7qoYSR5+TVkM4ZCAOP9p2eVcUttS+aDN+TpWHnIt
 oRTBLw18sswS5xmLyztnLKb4Y5pDkp3o=
X-Received: by 2002:a25:3f83:: with SMTP id m125mr7359196yba.324.1599673834298; 
 Wed, 09 Sep 2020 10:50:34 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyY5rKlEH4b4FFjhimflwaDkdSXzgjkmbRw0+JonJSyOJyVSXMwFCUpYcPwH5L+Jc7OL45T0tdZv86bYruKjn4=
X-Received: by 2002:a25:3f83:: with SMTP id m125mr7359166yba.324.1599673834017; 
 Wed, 09 Sep 2020 10:50:34 -0700 (PDT)
MIME-Version: 1.0
References: <20200904161000.12115-1-ani@anisinha.ca>
In-Reply-To: <20200904161000.12115-1-ani@anisinha.ca>
From: Julia Suvorova <jusual@redhat.com>
Date: Wed, 9 Sep 2020 19:50:22 +0200
Message-ID: <CAMDeoFVQWeWArPty2z4rNbdmS7O2X66SaONqiKzFqFpaKwuNDg@mail.gmail.com>
Subject: Re: [PATCH v3] i440fx/acpi: do not add hotplug related amls for cold
 plugged bridges
To: Ani Sinha <ani@anisinha.ca>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jsuvorov@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=205.139.110.120; envelope-from=jsuvorov@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/09 03:13:17
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
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
Cc: Eduardo Habkost <ehabkost@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Sep 4, 2020 at 6:10 PM Ani Sinha <ani@anisinha.ca> wrote:
>
> Cold plugged bridges are not hot unpluggable, even when their hotplug
> property (acpi-pci-hotplug-with-bridge-support) is turned off. Please see
> the function acpi_pcihp_pc_no_hotplug() (thanks Julia). However, with
> the current implementaton, windows would try to hot-unplug a pci bridge when
> it's hotplug switch is off. This is regardless of whether there are devices
> attached to the bridge. This is because we add amls like _EJ0 etc for the
> pci slot where the bridge is cold plugged. We have a demo video here:
> https://youtu.be/pME2sjyQweo
>
> In this fix, we identify a cold plugged bridge and for cold plugged bridges,
> we do not add the appropriate amls and acpi methods that are used by the OS
> to identify a hot-pluggable/unpluggable pci device. After this change, Windows
> does not show an option to eject the PCI bridge. A demo video is here:
> https://youtu.be/kbgej5B9Hgs
>
> While at it, I have also updated a stale comment.
>
> This change is tested with a Windows 2012R2 guest image and Windows 2019 server
> guest image running on Ubuntu 18.04 host. This change is based off of upstream
> qemu master branch tag v5.1.0.
>
> Signed-off-by: Ani Sinha <ani@anisinha.ca>

Reviewed-by: Julia Suvorova <jusual@redhat.com>

BTW, aren't all bridges handled in build_append_pci_bus_devices() cold-plugged?

> ---
>  hw/i386/acpi-build.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
>
> changelog:
> v3: commit log updates providing more accurate information as received from Julia.
> v2: cosmetic commit log updates with patch testing information.
> v1: initial patch.
>
>
> diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
> index b7bcbbbb2a..90b863f4ec 100644
> --- a/hw/i386/acpi-build.c
> +++ b/hw/i386/acpi-build.c
> @@ -359,6 +359,7 @@ static void build_append_pci_bus_devices(Aml *parent_scope, PCIBus *bus,
>          int slot = PCI_SLOT(i);
>          bool hotplug_enabled_dev;
>          bool bridge_in_acpi;
> +        bool cold_plugged_bridge;
>
>          if (!pdev) {
>              if (bsel) { /* add hotplug slots for non present devices */
> @@ -380,15 +381,14 @@ static void build_append_pci_bus_devices(Aml *parent_scope, PCIBus *bus,
>          pc = PCI_DEVICE_GET_CLASS(pdev);
>          dc = DEVICE_GET_CLASS(pdev);
>
> -        /* When hotplug for bridges is enabled, bridges are
> -         * described in ACPI separately (see build_pci_bus_end).
> -         * In this case they aren't themselves hot-pluggable.
> +        /*
> +         * Cold plugged bridges aren't themselves hot-pluggable.
>           * Hotplugged bridges *are* hot-pluggable.
>           */
> -        bridge_in_acpi = pc->is_bridge && pcihp_bridge_en &&
> -            !DEVICE(pdev)->hotplugged;
> +        cold_plugged_bridge = pc->is_bridge && !DEVICE(pdev)->hotplugged;
> +        bridge_in_acpi =  cold_plugged_bridge && pcihp_bridge_en;
>
> -        hotplug_enabled_dev = bsel && dc->hotpluggable && !bridge_in_acpi;
> +        hotplug_enabled_dev = bsel && dc->hotpluggable && !cold_plugged_bridge;
>
>          if (pc->class_id == PCI_CLASS_BRIDGE_ISA) {
>              continue;
> --
> 2.17.1
>


