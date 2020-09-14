Return-Path: <SRS0=afRr=CX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E9E3C43461
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 12:43:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 01FBE20771
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 12:43:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jVXWtHPa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 01FBE20771
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42136 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kHnpK-00041h-2m
	for qemu-devel@archiver.kernel.org; Mon, 14 Sep 2020 08:43:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38312)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1kHnjF-0000ko-1h
 for qemu-devel@nongnu.org; Mon, 14 Sep 2020 08:37:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:32520)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1kHnjC-00011p-G9
 for qemu-devel@nongnu.org; Mon, 14 Sep 2020 08:37:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600087021;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Y5jDBewPPsO58wpZAbKGMZImVn3+Ab3hUSrXvmCxUqo=;
 b=jVXWtHPa3S6xVvIJnP7FVob2azbA8eKAgJfJDrs58w7soSaIZrZIXoBQcJLjh+8hVBKWjp
 ZIff2QPPIdzId1gNxNEBg7xWoffV5cFHBIjZNi3sLyC1QEhBlS796qXcIGd/V2rAvKqNqK
 4KadWtFudxwG86bjiiAd0cXP8w3Rr5Q=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-210-kL_Tf-qePGeKiBFD0YXSSQ-1; Mon, 14 Sep 2020 08:36:57 -0400
X-MC-Unique: kL_Tf-qePGeKiBFD0YXSSQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2F9A6EF4E5;
 Mon, 14 Sep 2020 12:36:56 +0000 (UTC)
Received: from localhost (unknown [10.43.2.114])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3C03127BD2;
 Mon, 14 Sep 2020 12:36:48 +0000 (UTC)
Date: Mon, 14 Sep 2020 14:36:46 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Ani Sinha <ani@anisinha.ca>
Subject: Re: [PATCH 5/9] i440fx/acpi: do not add hotplug related amls for
 cold plugged bridges
Message-ID: <20200914143646.073027f1@redhat.com>
In-Reply-To: <20200911180755.28409-5-ani@anisinha.ca>
References: <20200911180755.28409-1-ani@anisinha.ca>
 <20200911180755.28409-5-ani@anisinha.ca>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=imammedo@redhat.com
X-Mimecast-Spam-Score: 0.003
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/14 02:55:39
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -38
X-Spam_score: -3.9
X-Spam_bar: ---
X-Spam_report: (-3.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.792,
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
Cc: Eduardo Habkost <ehabkost@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, jusual@redhat.com,
 qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 11 Sep 2020 23:37:51 +0530
Ani Sinha <ani@anisinha.ca> wrote:

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
> As a result of the patch, the following are the changes to the DSDT ACPI table:
> 
> @@ -858,38 +858,33 @@
>                      Return (Zero)
>                  }
> 
>                  Method (_S2D, 0, NotSerialized)  // _S2D: S2 Device State
>                  {
>                      Return (Zero)
>                  }
> 
>                  Method (_S3D, 0, NotSerialized)  // _S3D: S3 Device State
>                  {
>                      Return (Zero)
>                  }
>              }
> 
>              Device (S18)
>              {
> -                Name (_SUN, 0x03)  // _SUN: Slot User Number
>                  Name (_ADR, 0x00030000)  // _ADR: Address
> -                Method (_EJ0, 1, NotSerialized)  // _EJx: Eject Device
> -                {
> -                    PCEJ (BSEL, _SUN)
> -                }
>              }
> 
>              Device (S20)
>              {
>                  Name (_SUN, 0x04)  // _SUN: Slot User Number
>                  Name (_ADR, 0x00040000)  // _ADR: Address
>                  Method (_EJ0, 1, NotSerialized)  // _EJx: Eject Device
>                  {
>                      PCEJ (BSEL, _SUN)
>                  }
>              }
> 
>              Device (S28)
>              {
>                  Name (_SUN, 0x05)  // _SUN: Slot User Number
>                  Name (_ADR, 0x00050000)  // _ADR: Address
> @@ -1148,37 +1143,32 @@
>                      PCEJ (BSEL, _SUN)
>                  }
>              }
> 
>              Device (SF8)
>              {
>                  Name (_SUN, 0x1F)  // _SUN: Slot User Number
>                  Name (_ADR, 0x001F0000)  // _ADR: Address
>                  Method (_EJ0, 1, NotSerialized)  // _EJx: Eject Device
>                  {
>                      PCEJ (BSEL, _SUN)
>                  }
>              }
> 
>              Method (DVNT, 2, NotSerialized)
>              {
> -                If ((Arg0 & 0x08))
> -                {
> -                    Notify (S18, Arg1)
> -                }
> -
>                  If ((Arg0 & 0x10))
>                  {
>                      Notify (S20, Arg1)
>                  }
> 
>                  If ((Arg0 & 0x20))
>                  {
>                      Notify (S28, Arg1)
>                  }
> 
>                  If ((Arg0 & 0x40))
>                  {
>                      Notify (S30, Arg1)
>                  }
> 
>                  If ((Arg0 & 0x80))
> 
> While at it, I have also updated a stale comment.
> 
> This change is tested with a Windows 2012R2 guest image and Windows 2019 server
> guest image running on Ubuntu 18.04 host. This change is based off of upstream
> qemu master branch tag v5.1.0.
> 
> Signed-off-by: Ani Sinha <ani@anisinha.ca>

Reviewed-by: Igor Mammedov <imammedo@redhat.com>

> ---
>  hw/i386/acpi-build.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
> index 7a5a8b3521..e079b686f5 100644
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


