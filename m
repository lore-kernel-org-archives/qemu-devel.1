Return-Path: <SRS0=8bV5=CN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24C72C43461
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2020 16:17:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C3DDB20795
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2020 16:17:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=anisinha-ca.20150623.gappssmtp.com header.i=@anisinha-ca.20150623.gappssmtp.com header.b="IlrBD5FP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C3DDB20795
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=anisinha.ca
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47034 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kEEOt-0002RG-SC
	for qemu-devel@archiver.kernel.org; Fri, 04 Sep 2020 12:17:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34822)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ani@anisinha.ca>) id 1kEEJ2-0001l4-Lu
 for qemu-devel@nongnu.org; Fri, 04 Sep 2020 12:11:17 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:38951)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ani@anisinha.ca>) id 1kEEJ0-0003ze-SG
 for qemu-devel@nongnu.org; Fri, 04 Sep 2020 12:11:16 -0400
Received: by mail-wr1-x444.google.com with SMTP id a17so7268782wrn.6
 for <qemu-devel@nongnu.org>; Fri, 04 Sep 2020 09:11:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=anisinha-ca.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=qGZd2ln57HZfFyZY5hQBYwXLW+Ac98WgjXsTRI13/zU=;
 b=IlrBD5FPyCdhcGBMFMgH0v3ZJgaf4/bY/Q3jkA4vfPLTI/ReMzNjWQcXsvy8kH4dO8
 LrV8GVDHZGAaSoo9gdzJeaIvtrp5XyDDSMeCP/XU0dpXKZGX74pQif6LDqDy/LIC+ejz
 aymbU9oSrTksKh815tNHSZdzhTaVfGrSHwUNDqYbqSzTcEF6Vesyn15VHF2sX7E9atX0
 iHezcuJ7w1Tx/Oi2MBDmeprJIZS+zowEu/altZ/OgmoszBQCAt9nZlpwzKzUDXm6vrdt
 OKsUaEshcReS+2YHX6VKDqLy3nmFZsBqZU8qVHgEJy2fsmWj2RU3MNonN5DZNwXYrmQx
 TLuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=qGZd2ln57HZfFyZY5hQBYwXLW+Ac98WgjXsTRI13/zU=;
 b=Bz89iYtAtsT2Ty2j7Wn4wwjt4vsUiMZH1Dxhr9fsBL+FhUekItagcgeaNC1nxAiL7m
 dPfLSKuKWLxRxS+TZMgsVjZWMpbHxSPUnQt39WKOTcELhD3NUy/l+GQjck3bXDtjvn1E
 rdyXWWddS16TghgR0l/M8XR0yUHL1uKPs/iWcBZquvi0CvVFdVP5CXa/KbnqRf0IDEoA
 IpqUGlHi6K0t04+Bimc9krK6bdKY6Ka3XJ2qXTmggBy05kECj7aDEyNu4kS/pSJRRTzJ
 O9OgrpW0nSkrAnXatOOe66C1E2neXXbbkJ1f+JZ3xh4erPmhW7z3vm2e2ZUSmFakDdxn
 CaDw==
X-Gm-Message-State: AOAM532h54zKTd7H7YGDREPxMDdS9fspIam9WAo7AjnKvtSj3/xG/ItU
 9qkEYdz3Qx5fp/mt+D7Yjivf8n8suk7AegOzz40T3A==
X-Google-Smtp-Source: ABdhPJzHHc9D4EC/0Htc9iF5elnTWbqVPaC/XbitKNB3WfHyKJJmd1bB6XHpc68CvFWAKSMBmdJhom0AwB2NL2L1ysg=
X-Received: by 2002:adf:e3cf:: with SMTP id k15mr7911105wrm.291.1599235872866; 
 Fri, 04 Sep 2020 09:11:12 -0700 (PDT)
MIME-Version: 1.0
References: <20200904082451.1043-1-ani@anisinha.ca>
 <20200904082451.1043-2-ani@anisinha.ca>
 <CAMDeoFUVoJ9hN7DaMBZ2RyS5jLNJACB-Uq6C6XXih8-9RDCj_g@mail.gmail.com>
 <CAARzgwxpA8rO44SbXiagJy3f1w1FZfwmij5PB7EF6krKieixfg@mail.gmail.com>
In-Reply-To: <CAARzgwxpA8rO44SbXiagJy3f1w1FZfwmij5PB7EF6krKieixfg@mail.gmail.com>
From: Ani Sinha <ani@anisinha.ca>
Date: Fri, 4 Sep 2020 21:41:01 +0530
Message-ID: <CAARzgwwLWCEAG7FUvPj5RgL_-wXgmat8jWLs=HUox9fGZ+1_FQ@mail.gmail.com>
Subject: Re: [PATCH v1] i440fx/acpi: don't hot-unplug cold plugged bridges
 when their hotplug switch is off
To: Julia Suvorova <jusual@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: none client-ip=2a00:1450:4864:20::444;
 envelope-from=ani@anisinha.ca; helo=mail-wr1-x444.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

On Fri, Sep 4, 2020 at 9:23 PM Ani Sinha <ani@anisinha.ca> wrote:
>
> On Fri, Sep 4, 2020 at 9:18 PM Julia Suvorova <jusual@redhat.com> wrote:
> >
> > On Fri, Sep 4, 2020 at 10:25 AM Ani Sinha <ani@anisinha.ca> wrote:
> > >
> > > Cold plugged bridges should not be hot unpluggable, even when their hotplug property
> > > (acpi-pci-hotplug-with-bridge-support) is turned off.
> >
> > Unplugging a cold-plugged bridge is impossible already, see
> > acpi_pcihp_pc_no_hotplug().
>
> Ah cool. So all the more reason we should fix this because guest OSes
> should not think that the device is hot-unpluggable.

I have sent a V3 with info Julia sent and also rewording the commit
log to reflect the
correct information.

>
> >
> > Best regards, Julia Suvorova.
> >
> > > However, with the current
> > > implementaton, windows would try to hot-unplug a pci bridge when it's hotplug switch
> > > is off. This is regardless of whether there are devices attached to the bridge. When
> > > devices are attached to the bridge, the bridge is ultimately not hot-unpluggable. We
> > > have a demo video here: https://youtu.be/pME2sjyQweo
> > >
> > > In this fix, we identify a cold plugged bridge and for cold plugged bridges, we do not
> > > add the appropriate amls and acpi methods that are used by the OS to identify a hot-
> > > unpluggable pci device. After this change, Windows does not show an option to eject the
> > > PCI bridge. A demo video is here:  https://youtu.be/kbgej5B9Hgs
> > >
> > > While at it, I have also updated a stale comment.
> > >
> > > This change is tested with a Windows 2012R2 guest image running on Ubuntu host. This
> > > change is based off of upstream qemu master branch tag v5.1.0.
> > >
> > > Signed-off-by: Ani Sinha <ani@anisinha.ca>
> > > ---
> > >  hw/i386/acpi-build.c | 12 ++++++------
> > >  1 file changed, 6 insertions(+), 6 deletions(-)
> > >
> > > diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
> > > index b7bcbbbb2a..90b863f4ec 100644
> > > --- a/hw/i386/acpi-build.c
> > > +++ b/hw/i386/acpi-build.c
> > > @@ -359,6 +359,7 @@ static void build_append_pci_bus_devices(Aml *parent_scope, PCIBus *bus,
> > >          int slot = PCI_SLOT(i);
> > >          bool hotplug_enabled_dev;
> > >          bool bridge_in_acpi;
> > > +        bool cold_plugged_bridge;
> > >
> > >          if (!pdev) {
> > >              if (bsel) { /* add hotplug slots for non present devices */
> > > @@ -380,15 +381,14 @@ static void build_append_pci_bus_devices(Aml *parent_scope, PCIBus *bus,
> > >          pc = PCI_DEVICE_GET_CLASS(pdev);
> > >          dc = DEVICE_GET_CLASS(pdev);
> > >
> > > -        /* When hotplug for bridges is enabled, bridges are
> > > -         * described in ACPI separately (see build_pci_bus_end).
> > > -         * In this case they aren't themselves hot-pluggable.
> > > +        /*
> > > +         * Cold plugged bridges aren't themselves hot-pluggable.
> > >           * Hotplugged bridges *are* hot-pluggable.
> > >           */
> > > -        bridge_in_acpi = pc->is_bridge && pcihp_bridge_en &&
> > > -            !DEVICE(pdev)->hotplugged;
> > > +        cold_plugged_bridge = pc->is_bridge && !DEVICE(pdev)->hotplugged;
> > > +        bridge_in_acpi =  cold_plugged_bridge && pcihp_bridge_en;
> > >
> > > -        hotplug_enabled_dev = bsel && dc->hotpluggable && !bridge_in_acpi;
> > > +        hotplug_enabled_dev = bsel && dc->hotpluggable && !cold_plugged_bridge;
> > >
> > >          if (pc->class_id == PCI_CLASS_BRIDGE_ISA) {
> > >              continue;
> > > --
> > > 2.17.1
> > >
> >

