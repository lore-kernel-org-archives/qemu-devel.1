Return-Path: <SRS0=/zFi=CU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1ADBC43461
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2020 15:55:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4F8C9207EA
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2020 15:55:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Cq+3xCQU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F8C9207EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36938 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kGlP1-0006Js-9T
	for qemu-devel@archiver.kernel.org; Fri, 11 Sep 2020 11:55:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51108)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kGlLa-0002WV-Rj
 for qemu-devel@nongnu.org; Fri, 11 Sep 2020 11:52:22 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:32715
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kGlLU-0002lx-V9
 for qemu-devel@nongnu.org; Fri, 11 Sep 2020 11:52:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599839536;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SZfnl6fTExTLLdBb1cpE9w+5WZJLbz27tc9EcBTUnWA=;
 b=Cq+3xCQUBl/lfYfGk91AnoHjSQdwX6kYlZCJ2HtVEC49LHWmEyCb6bC7Mi+iF5kt6ZxF5i
 3CpLbxdCVE4DlkQKkpT49iy6zjv+qOplBcvamqDil3P9tX4MGyk8P0fMrByt5pRCEDHLiW
 eMZ5D7j37cC8jYVmesnT3a9Gpbs11Iw=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-340-By5IO1abPquLISxeaPRzxQ-1; Fri, 11 Sep 2020 11:52:12 -0400
X-MC-Unique: By5IO1abPquLISxeaPRzxQ-1
Received: by mail-wm1-f70.google.com with SMTP id w3so1095307wmg.4
 for <qemu-devel@nongnu.org>; Fri, 11 Sep 2020 08:52:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=SZfnl6fTExTLLdBb1cpE9w+5WZJLbz27tc9EcBTUnWA=;
 b=OPTpj7xoRl5Dp/5AtEWCHv4DkaMU30blYCi4wYOhfyV8vfVoAv0J0ZL44Qgfni+3mB
 23qpzG+maRymCXZwppHBGdrM+MO9p7Ouyqv5g9ri+c5bo3pccFyXNWn6T648b2DqM+MJ
 8DVJpaNOw8/T+xALWY4xiVWqFKSBe5SBYtX61inolncIDc2qPuTXup4CxHKi5n/zuLxR
 VOnI7uaRFCw/jBAJCJnF9GKVB0lG+EbOjmVweTzPoS3QQTZrp/WDxEvJ4BAa4ZbdLiZ+
 2w8fTiDe4HHej/UiQfgU5Mbcqd67cZ/KUBv69w5AykhrrfUehLkZsAKqhmXyIB7XxBP4
 2fJA==
X-Gm-Message-State: AOAM531+3dtqTpMnsi6HErYPAKO/3f561GZ/y/fErVUTIkOd/+dLjgg4
 CGSl0wPvcqIa2zmryMwRoWmcdZBdkFtZwznNAC/eFVEPzMqKiausI74Zv+kZ7+v0+Ndk1bcBl4F
 DPkeGGZLu2VnUlOU=
X-Received: by 2002:a5d:6caf:: with SMTP id a15mr2735112wra.344.1599839530076; 
 Fri, 11 Sep 2020 08:52:10 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxEyrXkgbb9Da8JPTedx51jqkhD8JJ43eEjq5bX69vafLRLwkb24n426w4Bp2LKuaYqU37VrA==
X-Received: by 2002:a5d:6caf:: with SMTP id a15mr2735092wra.344.1599839529724; 
 Fri, 11 Sep 2020 08:52:09 -0700 (PDT)
Received: from redhat.com ([176.230.64.162])
 by smtp.gmail.com with ESMTPSA id f1sm5286955wrx.75.2020.09.11.08.52.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Sep 2020 08:52:08 -0700 (PDT)
Date: Fri, 11 Sep 2020 11:52:05 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Ani Sinha <ani@anisinha.ca>
Subject: Re: [PATCH v3] i440fx/acpi: do not add hotplug related amls for cold
 plugged bridges
Message-ID: <20200911115138-mutt-send-email-mst@kernel.org>
References: <20200904161000.12115-1-ani@anisinha.ca>
 <CAMDeoFVQWeWArPty2z4rNbdmS7O2X66SaONqiKzFqFpaKwuNDg@mail.gmail.com>
 <98b26cfa-3ff7-4302-9fc2-0e6672cfbd08@Spark>
 <a6c38469-356d-4629-be12-92129e1b1b96@Spark>
MIME-Version: 1.0
In-Reply-To: <a6c38469-356d-4629-be12-92129e1b1b96@Spark>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.120; envelope-from=mst@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/11 03:28:41
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, Julia Suvorova <jusual@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Sep 10, 2020 at 12:19:19AM +0530, Ani Sinha wrote:
> On Sep 10, 2020, 00:00 +0530, Ani Sinha <ani@anisinha.ca>, wrote:
> 
>     On Sep 9, 2020, 23:20 +0530, Julia Suvorova <jusual@redhat.com>, wrote:
> 
>         On Fri, Sep 4, 2020 at 6:10 PM Ani Sinha <ani@anisinha.ca> wrote:
> 
> 
> 
>             Cold plugged bridges are not hot unpluggable, even when their
>             hotplug
> 
>             property (acpi-pci-hotplug-with-bridge-support) is turned off.
>             Please see
> 
>             the function acpi_pcihp_pc_no_hotplug() (thanks Julia). However,
>             with
> 
>             the current implementaton, windows would try to hot-unplug a pci
>             bridge when
> 
>             it's hotplug switch is off. This is regardless of whether there are
>             devices
> 
>             attached to the bridge. This is because we add amls like _EJ0 etc
>             for the
> 
>             pci slot where the bridge is cold plugged. We have a demo video
>             here:
> 
>             https://youtu.be/pME2sjyQweo
> 
> 
> 
>             In this fix, we identify a cold plugged bridge and for cold plugged
>             bridges,
> 
>             we do not add the appropriate amls and acpi methods that are used
>             by the OS
> 
>             to identify a hot-pluggable/unpluggable pci device. After this
>             change, Windows
> 
>             does not show an option to eject the PCI bridge. A demo video is
>             here:
> 
>             https://youtu.be/kbgej5B9Hgs
> 
> 
> 
>             While at it, I have also updated a stale comment.
> 
> 
> 
>             This change is tested with a Windows 2012R2 guest image and Windows
>             2019 server
> 
>             guest image running on Ubuntu 18.04 host. This change is based off
>             of upstream
> 
>             qemu master branch tag v5.1.0.
> 
> 
> 
>             Signed-off-by: Ani Sinha <ani@anisinha.ca>
> 
> 
> 
>         Reviewed-by: Julia Suvorova <jusual@redhat.com>
> 
> 
> 
>         BTW, aren't all bridges handled in build_append_pci_bus_devices()
>         cold-plugged?
> 
> 
> 
>     Yes they are.
> 
> 
> Maybe as an improvement we can simply identify a bridge instead of a cold
> plugged bridge. However let’s have that improvement as a separate patch on top
> of this. Also let’s see what Igor thinks.

Well this changes acpi tables so I don't see how this will pass
the unit tests. Did you test this change?


> 
> 
> 
>             ---
> 
>             hw/i386/acpi-build.c | 12 ++++++------
> 
>             1 file changed, 6 insertions(+), 6 deletions(-)
> 
> 
> 
>             changelog:
> 
>             v3: commit log updates providing more accurate information as
>             received from Julia.
> 
>             v2: cosmetic commit log updates with patch testing information.
> 
>             v1: initial patch.
> 
> 
> 
> 
> 
>             diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
> 
>             index b7bcbbbb2a..90b863f4ec 100644
> 
>             --- a/hw/i386/acpi-build.c
> 
>             +++ b/hw/i386/acpi-build.c
> 
>             @@ -359,6 +359,7 @@ static void build_append_pci_bus_devices(Aml
>             *parent_scope, PCIBus *bus,
> 
>             int slot = PCI_SLOT(i);
> 
>             bool hotplug_enabled_dev;
> 
>             bool bridge_in_acpi;
> 
>             + bool cold_plugged_bridge;
> 
> 
> 
>             if (!pdev) {
> 
>             if (bsel) { /* add hotplug slots for non present devices */
> 
>             @@ -380,15 +381,14 @@ static void build_append_pci_bus_devices(Aml
>             *parent_scope, PCIBus *bus,
> 
>             pc = PCI_DEVICE_GET_CLASS(pdev);
> 
>             dc = DEVICE_GET_CLASS(pdev);
> 
> 
> 
>             - /* When hotplug for bridges is enabled, bridges are
> 
>             - * described in ACPI separately (see build_pci_bus_end).
> 
>             - * In this case they aren't themselves hot-pluggable.
> 
>             + /*
> 
>             + * Cold plugged bridges aren't themselves hot-pluggable.
> 
>             * Hotplugged bridges *are* hot-pluggable.
> 
>             */
> 
>             - bridge_in_acpi = pc->is_bridge && pcihp_bridge_en &&
> 
>             - !DEVICE(pdev)->hotplugged;
> 
>             + cold_plugged_bridge = pc->is_bridge && !DEVICE(pdev)->hotplugged;
> 
>             + bridge_in_acpi = cold_plugged_bridge && pcihp_bridge_en;
> 
> 
> 
>             - hotplug_enabled_dev = bsel && dc->hotpluggable && !
>             bridge_in_acpi;
> 
>             + hotplug_enabled_dev = bsel && dc->hotpluggable && !
>             cold_plugged_bridge;
> 
> 
> 
>             if (pc->class_id == PCI_CLASS_BRIDGE_ISA) {
> 
>             continue;
> 
>             --
> 
>             2.17.1
> 
> 
> 
> 
> 


