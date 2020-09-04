Return-Path: <SRS0=8bV5=CN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABE70C433E2
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2020 15:59:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6DB4220722
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2020 15:59:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=anisinha-ca.20150623.gappssmtp.com header.i=@anisinha-ca.20150623.gappssmtp.com header.b="qfPKNA48"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6DB4220722
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=anisinha.ca
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43178 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kEE7p-0001Jr-Lq
	for qemu-devel@archiver.kernel.org; Fri, 04 Sep 2020 11:59:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58472)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ani@anisinha.ca>) id 1kEE26-00080r-Kp
 for qemu-devel@nongnu.org; Fri, 04 Sep 2020 11:53:46 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:53732)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ani@anisinha.ca>) id 1kEE24-0000Yv-HO
 for qemu-devel@nongnu.org; Fri, 04 Sep 2020 11:53:46 -0400
Received: by mail-wm1-x344.google.com with SMTP id u18so6503873wmc.3
 for <qemu-devel@nongnu.org>; Fri, 04 Sep 2020 08:53:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=anisinha-ca.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Afwu29ZYyRmTHxYU/ozHLflVOIUX6KaMCX7RuNIc0tY=;
 b=qfPKNA486dHAa5m/ipk0PqiQ6EB+o+ycOeZkBvSs5co58Y0CqjbOrP+oh+jECEPFNl
 nzOyAgYVEadXYyGAva37U1VoWUGA8kwkByf2gWiXAFNvyMOX2M/lbeuJQ7fsXs5V6dFU
 1kSTdsEmW5ezrtCgLZD+R7iwhD0Fz7/mgWRKc+9AGVNBmNnS6MWWhjlftggejgCHej+S
 hGJwBdBSEa4sw6PTj/01OGRJQuiTnaP1Q/o4Z2FUHnuz8FT85GccSgzU4lJVMHwwZ0Hv
 4QgaUJADI8kgAn0JCVifUoYILp+usVr9v/SGxgGHmcnvNQ32WBNb2fneWnUSyeuRTBhZ
 nNNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Afwu29ZYyRmTHxYU/ozHLflVOIUX6KaMCX7RuNIc0tY=;
 b=ewf9pt7A0xGqobhsDZaEF84ZzRLPQ8YbsxU/9SYVFFI5SkD6IChEM6yaDZ6WHY37nN
 K/xUAoLCFNddcigDDLpAiZEuX+QD3kP9pTN5/quw8Vlrc24LoY0L2mqR5i8qMaDG5Rmg
 jcojgmNLJkHoNnriEk1yBQv68yaEPCi486Wbi4odbtblOSOGjLnzKAM72O3FyfbheZ+6
 6fBuGhWg5jy4e7mzgi4LO2B0SW2tLJTlZyGUvK94ypzJqGBUPF7JMiURUk4wpgi60G40
 3n2IZA/RlNODDg9YdSHSqhQT2u8Ewz10t87fMn1l6ISD2VEsXHOSyA9TthpNFoixlIul
 JmrA==
X-Gm-Message-State: AOAM533WIPPsz0aJRRBcJQgIusnB7XVyPxiq7I04jb22ltLO60VXXnTR
 n3ftOvyA8N19c6a3NyOogJjH9p9DBgw/YhPR5M4Q7A==
X-Google-Smtp-Source: ABdhPJyFd089MlGrr5T258U/hy5TlbHtGsAOlmElwe9EPCM+8UqxsGnAthhD5sARgpLmiiipSc75bzWSA0CMslzGAjY=
X-Received: by 2002:a1c:b407:: with SMTP id d7mr8759172wmf.59.1599234822825;
 Fri, 04 Sep 2020 08:53:42 -0700 (PDT)
MIME-Version: 1.0
References: <20200904082451.1043-1-ani@anisinha.ca>
 <20200904082451.1043-2-ani@anisinha.ca>
 <CAMDeoFUVoJ9hN7DaMBZ2RyS5jLNJACB-Uq6C6XXih8-9RDCj_g@mail.gmail.com>
In-Reply-To: <CAMDeoFUVoJ9hN7DaMBZ2RyS5jLNJACB-Uq6C6XXih8-9RDCj_g@mail.gmail.com>
From: Ani Sinha <ani@anisinha.ca>
Date: Fri, 4 Sep 2020 21:23:31 +0530
Message-ID: <CAARzgwxpA8rO44SbXiagJy3f1w1FZfwmij5PB7EF6krKieixfg@mail.gmail.com>
Subject: Re: [PATCH v1] i440fx/acpi: don't hot-unplug cold plugged bridges
 when their hotplug switch is off
To: Julia Suvorova <jusual@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: none client-ip=2a00:1450:4864:20::344;
 envelope-from=ani@anisinha.ca; helo=mail-wm1-x344.google.com
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

On Fri, Sep 4, 2020 at 9:18 PM Julia Suvorova <jusual@redhat.com> wrote:
>
> On Fri, Sep 4, 2020 at 10:25 AM Ani Sinha <ani@anisinha.ca> wrote:
> >
> > Cold plugged bridges should not be hot unpluggable, even when their hotplug property
> > (acpi-pci-hotplug-with-bridge-support) is turned off.
>
> Unplugging a cold-plugged bridge is impossible already, see
> acpi_pcihp_pc_no_hotplug().

Ah cool. So all the more reason we should fix this because guest OSes
should not think that the device is hot-unpluggable.

>
> Best regards, Julia Suvorova.
>
> > However, with the current
> > implementaton, windows would try to hot-unplug a pci bridge when it's hotplug switch
> > is off. This is regardless of whether there are devices attached to the bridge. When
> > devices are attached to the bridge, the bridge is ultimately not hot-unpluggable. We
> > have a demo video here: https://youtu.be/pME2sjyQweo
> >
> > In this fix, we identify a cold plugged bridge and for cold plugged bridges, we do not
> > add the appropriate amls and acpi methods that are used by the OS to identify a hot-
> > unpluggable pci device. After this change, Windows does not show an option to eject the
> > PCI bridge. A demo video is here:  https://youtu.be/kbgej5B9Hgs
> >
> > While at it, I have also updated a stale comment.
> >
> > This change is tested with a Windows 2012R2 guest image running on Ubuntu host. This
> > change is based off of upstream qemu master branch tag v5.1.0.
> >
> > Signed-off-by: Ani Sinha <ani@anisinha.ca>
> > ---
> >  hw/i386/acpi-build.c | 12 ++++++------
> >  1 file changed, 6 insertions(+), 6 deletions(-)
> >
> > diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
> > index b7bcbbbb2a..90b863f4ec 100644
> > --- a/hw/i386/acpi-build.c
> > +++ b/hw/i386/acpi-build.c
> > @@ -359,6 +359,7 @@ static void build_append_pci_bus_devices(Aml *parent_scope, PCIBus *bus,
> >          int slot = PCI_SLOT(i);
> >          bool hotplug_enabled_dev;
> >          bool bridge_in_acpi;
> > +        bool cold_plugged_bridge;
> >
> >          if (!pdev) {
> >              if (bsel) { /* add hotplug slots for non present devices */
> > @@ -380,15 +381,14 @@ static void build_append_pci_bus_devices(Aml *parent_scope, PCIBus *bus,
> >          pc = PCI_DEVICE_GET_CLASS(pdev);
> >          dc = DEVICE_GET_CLASS(pdev);
> >
> > -        /* When hotplug for bridges is enabled, bridges are
> > -         * described in ACPI separately (see build_pci_bus_end).
> > -         * In this case they aren't themselves hot-pluggable.
> > +        /*
> > +         * Cold plugged bridges aren't themselves hot-pluggable.
> >           * Hotplugged bridges *are* hot-pluggable.
> >           */
> > -        bridge_in_acpi = pc->is_bridge && pcihp_bridge_en &&
> > -            !DEVICE(pdev)->hotplugged;
> > +        cold_plugged_bridge = pc->is_bridge && !DEVICE(pdev)->hotplugged;
> > +        bridge_in_acpi =  cold_plugged_bridge && pcihp_bridge_en;
> >
> > -        hotplug_enabled_dev = bsel && dc->hotpluggable && !bridge_in_acpi;
> > +        hotplug_enabled_dev = bsel && dc->hotpluggable && !cold_plugged_bridge;
> >
> >          if (pc->class_id == PCI_CLASS_BRIDGE_ISA) {
> >              continue;
> > --
> > 2.17.1
> >
>

