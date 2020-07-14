Return-Path: <SRS0=DUFB=AZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E832C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2020 08:58:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CF39520BED
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2020 08:58:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="P81i2xbz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF39520BED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53040 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jvGlo-00027x-5m
	for qemu-devel@archiver.kernel.org; Tue, 14 Jul 2020 04:58:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42386)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jvGlE-0001a6-7H
 for qemu-devel@nongnu.org; Tue, 14 Jul 2020 04:58:00 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:54784
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jvGlC-0004zQ-H8
 for qemu-devel@nongnu.org; Tue, 14 Jul 2020 04:57:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594717077;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=d7qu47wrEa9Rra+uRd9zMX6T/4ahPlP/4qd4nYZVew8=;
 b=P81i2xbz3BrVotNUlcjiS+smS+TyyyxtdMNNsaiUR655Sw+QakK9ioEg6zSeZYTpQ3soGq
 Y5HQyjtiudYmdqQk3B1PVa/ddyTVNyZXx/izCBv24HRzugeJZuqzUx42/tdl1kihhT/keJ
 31QfK3cg2uEVBeQ/YBXS0/wTYLTzgss=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-384-xMXDFjiHP-KWPcL-IAWQAQ-1; Tue, 14 Jul 2020 04:57:55 -0400
X-MC-Unique: xMXDFjiHP-KWPcL-IAWQAQ-1
Received: by mail-wr1-f71.google.com with SMTP id v3so20801041wrq.10
 for <qemu-devel@nongnu.org>; Tue, 14 Jul 2020 01:57:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=d7qu47wrEa9Rra+uRd9zMX6T/4ahPlP/4qd4nYZVew8=;
 b=IqCSxmzkYktrnm8YRX9VsMEwzzA3NmMLAYJsL8p2zqtf/5I170hcayTF/BURReW9hT
 QRy3ZIRSB5on+5EyFjeuyW0GPljuRzFFJnqbcINvPddbjBEqiiib0rETvNQbIzUfan/y
 9Z9640BvO3yojixG+yMmHs6EM7DmXUJ1DrnXxIjbkGlDwVb/LKcvDHGrf+ANBW4UjseE
 bNr0brC4vrm85o0r5dg/J4acw81Q8w63z4urisCddTZSf6SyNsmYSFWhDo+XAwxJwHFQ
 myx5rEL6bejupURpOvT+fgR6SQSlMticyHyflX3qwBB1qnDkGFmZkBksthlia18DrpsG
 7nRw==
X-Gm-Message-State: AOAM530gXDtx+eDhoeOXcpYLpWlv1dDAwhlkSXOvN4QvEjGtODfIq9ZU
 fC2go4jn4u7LoQrIWvo6g0Gkn+Ho5pgm0HswvFfosxHEdQYR+PTFSb5K4MwTHFSMN5eZr59yl4g
 F5U93s4q+JmsEMK0=
X-Received: by 2002:adf:f885:: with SMTP id u5mr3894659wrp.402.1594717074234; 
 Tue, 14 Jul 2020 01:57:54 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzZ0GVRP+PyF08+JHT5iWKfv4h4GYO0IG8jHLS+qDMIEoEWVEGYZEjg05letM82+pgr2pGaDA==
X-Received: by 2002:adf:f885:: with SMTP id u5mr3894637wrp.402.1594717074006; 
 Tue, 14 Jul 2020 01:57:54 -0700 (PDT)
Received: from redhat.com (bzq-79-180-10-140.red.bezeqint.net. [79.180.10.140])
 by smtp.gmail.com with ESMTPSA id v7sm28837090wrp.45.2020.07.14.01.57.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Jul 2020 01:57:53 -0700 (PDT)
Date: Tue, 14 Jul 2020 04:57:50 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Andrew Jones <drjones@redhat.com>
Subject: Re: [PATCH 3/4] hw/arm/virt-acpi-build: Only expose flash on older
 machine types
Message-ID: <20200714045537-mutt-send-email-mst@kernel.org>
References: <20200629140938.17566-1-drjones@redhat.com>
 <20200629140938.17566-4-drjones@redhat.com>
 <20200713104907.335bf762@redhat.com>
 <20200714055109.owrlob6m53notzh3@kamzik.brq.redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200714055109.owrlob6m53notzh3@kamzik.brq.redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.120; envelope-from=mst@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/14 01:42:04
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: peter.maydell@linaro.org, eric.auger@redhat.com, lersek@redhat.com,
 qemu-devel@nongnu.org, shannon.zhaosl@gmail.com, qemu-arm@nongnu.org,
 ard.biesheuvel@arm.com, Igor Mammedov <imammedo@redhat.com>, philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Jul 14, 2020 at 07:51:09AM +0200, Andrew Jones wrote:
> On Mon, Jul 13, 2020 at 10:49:07AM +0200, Igor Mammedov wrote:
> > On Mon, 29 Jun 2020 16:09:37 +0200
> > Andrew Jones <drjones@redhat.com> wrote:
> > 
> > > The flash device is exclusively for the host-controlled firmware, so
> > > we should not expose it to the OS. Exposing it risks the OS messing
> > > with it, which could break firmware runtime services and surprise the
> > > OS when all its changes disappear after reboot.
> > > 
> > > As firmware needs the device and uses DT, we leave the device exposed
> > > there. It's up to firmware to remove the nodes from DT before sending
> > > it on to the OS. However, there's no need to force firmware to remove
> > > tables from ACPI (which it doesn't know how to do anyway), so we
> > > simply don't add the tables in the first place. But, as we've been
> > > adding the tables for quite some time and don't want to change the
> > > default hardware exposed to versioned machines, then we only stop
> > > exposing the flash device tables for 5.1 and later machine types.
> > > 
> > > Suggested-by: Ard Biesheuvel <ard.biesheuvel@arm.com>
> > > Suggested-by: Laszlo Ersek <lersek@redhat.com>
> > > Signed-off-by: Andrew Jones <drjones@redhat.com>
> > > ---
> > >  hw/arm/virt-acpi-build.c | 5 ++++-
> > >  hw/arm/virt.c            | 3 +++
> > >  include/hw/arm/virt.h    | 1 +
> > >  3 files changed, 8 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
> > > index 1384a2cf2ab4..91f0df7b13a3 100644
> > > --- a/hw/arm/virt-acpi-build.c
> > > +++ b/hw/arm/virt-acpi-build.c
> > > @@ -749,6 +749,7 @@ static void build_fadt_rev5(GArray *table_data, BIOSLinker *linker,
> > >  static void
> > >  build_dsdt(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
> > >  {
> > > +    VirtMachineClass *vmc = VIRT_MACHINE_GET_CLASS(vms);
> > >      Aml *scope, *dsdt;
> > >      MachineState *ms = MACHINE(vms);
> > >      const MemMapEntry *memmap = vms->memmap;
> > > @@ -767,7 +768,9 @@ build_dsdt(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
> > >      acpi_dsdt_add_cpus(scope, vms->smp_cpus);
> > >      acpi_dsdt_add_uart(scope, &memmap[VIRT_UART],
> > >                         (irqmap[VIRT_UART] + ARM_SPI_BASE));
> > > -    acpi_dsdt_add_flash(scope, &memmap[VIRT_FLASH]);
> > > +    if (vmc->acpi_expose_flash) {
> > > +        acpi_dsdt_add_flash(scope, &memmap[VIRT_FLASH]);
> > > +    }
> > >      acpi_dsdt_add_fw_cfg(scope, &memmap[VIRT_FW_CFG]);
> > >      acpi_dsdt_add_virtio(scope, &memmap[VIRT_MMIO],
> > >                      (irqmap[VIRT_MMIO] + ARM_SPI_BASE), NUM_VIRTIO_TRANSPORTS);
> > > diff --git a/hw/arm/virt.c b/hw/arm/virt.c
> > > index cd0834ce7faf..5adc9ff799ef 100644
> > > --- a/hw/arm/virt.c
> > > +++ b/hw/arm/virt.c
> > > @@ -2482,9 +2482,12 @@ DEFINE_VIRT_MACHINE_AS_LATEST(5, 1)
> > >  
> > >  static void virt_machine_5_0_options(MachineClass *mc)
> > >  {
> > > +    VirtMachineClass *vmc = VIRT_MACHINE_CLASS(OBJECT_CLASS(mc));
> > > +
> > >      virt_machine_5_1_options(mc);
> > >      compat_props_add(mc->compat_props, hw_compat_5_0, hw_compat_5_0_len);
> > >      mc->numa_mem_supported = true;
> > > +    vmc->acpi_expose_flash = true;
> > 
> > we usually do not version ACPI tables changes
> > (unless we have a good reason to do so)
> 
> Even when the change is to remove the exposure of hardware from the guest?
> Before this change, if a guest looked, it had a flash, after this change,
> if a guest looks, it doesn't.

It's up to the relevant maintainers who know what the semantics are.
FYI ACPI tables only change across a reset though.
So it's a question of whether guests get confused even if this
changes after a reboot.
Versioning is generally safer, but it's a good idea to document
the motivation for it.


> I'd feel much better versioning a change
> like that, than not.
> 
> Thanks,
> drew
> 
> > 
> > >  }
> > >  DEFINE_VIRT_MACHINE(5, 0)
> > >  
> > > diff --git a/include/hw/arm/virt.h b/include/hw/arm/virt.h
> > > index 31878ddc7223..c65be5fe0bb6 100644
> > > --- a/include/hw/arm/virt.h
> > > +++ b/include/hw/arm/virt.h
> > > @@ -119,6 +119,7 @@ typedef struct {
> > >      bool no_highmem_ecam;
> > >      bool no_ged;   /* Machines < 4.2 has no support for ACPI GED device */
> > >      bool kvm_no_adjvtime;
> > > +    bool acpi_expose_flash;
> > >  } VirtMachineClass;
> > >  
> > >  typedef struct {
> > 
> > 


