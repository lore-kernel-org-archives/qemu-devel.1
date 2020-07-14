Return-Path: <SRS0=DUFB=AZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12F7BC433E3
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2020 09:32:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D0E37208C3
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2020 09:32:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BGAlmI9R"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D0E37208C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58666 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jvHIw-0001k3-5b
	for qemu-devel@archiver.kernel.org; Tue, 14 Jul 2020 05:32:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52032)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jvHI4-0001BF-5u
 for qemu-devel@nongnu.org; Tue, 14 Jul 2020 05:31:56 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:26057
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jvHI1-00015u-MT
 for qemu-devel@nongnu.org; Tue, 14 Jul 2020 05:31:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594719112;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=z8JvkBd0R8tKW1PwI1aEAkvIaqXUeLX6SqSLALIC3M8=;
 b=BGAlmI9R15e6EQ6d5kwd17qVsH85CQUVb+z75MpCTsKGBVxbK3sf67+xfWnjp6dADt7s3o
 WZkto9nEJa9l73rUqY5fnGwBmcUTR3VDZH6DvZePi4dWkAe0jSBrggKV+TC51DMP0wksDP
 TYFqB8sv+3evKD6LzOz7PKNigtpHM3U=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-432-MpBC-_lDM2GqGq-WUeVylQ-1; Tue, 14 Jul 2020 05:31:48 -0400
X-MC-Unique: MpBC-_lDM2GqGq-WUeVylQ-1
Received: by mail-wr1-f70.google.com with SMTP id v3so20912467wrq.10
 for <qemu-devel@nongnu.org>; Tue, 14 Jul 2020 02:31:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=z8JvkBd0R8tKW1PwI1aEAkvIaqXUeLX6SqSLALIC3M8=;
 b=d9zV+rtU5rMDNmDMmzL9xG5B+Em6rhQEAdsa6W2s1VpMb5xep9Id31R4HSeg5JNpT9
 00jGrXpIA2TfN3KemQ2HU0y8xC1aYa8Vo9Fs4g+Sn1Dq7Sbv2A5g6qE6nHcW/rLsmXYf
 4/ZNSXfbmQgoDPb4N+KkibWV3XgkNm5Wulz77cFsXBHAHOru2j6vFzHicy81+Kq9mIF1
 jLqUQg1XB/MdGXTsFKErG2hoRkZwCjuhCZCqBSZQtBLF1gzhK5OikL0NpPUW57l3op1+
 sVBmHG7LwySPjbecs9GRQzuXBJGg0wmhJA8ZW5EWrx4wdLFWEVyd5Bxxc9GNr988kqvf
 hlmQ==
X-Gm-Message-State: AOAM533fbxQgSQrrvzxkbG6g83zNqsLqVBfsnE23Hjhc/P5bX2gfgbQZ
 0kULJy9+yP1VxVaWmmKwNPt0jvsXXDBQcglKl0C3OmO0lCg7Rb7G6CV9oOu+BELDmb05rIJSkPP
 AkV/kZn7IdKbzJnM=
X-Received: by 2002:a1c:dcd5:: with SMTP id t204mr3265237wmg.17.1594719107461; 
 Tue, 14 Jul 2020 02:31:47 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz9w8Ea0p5Oxvfm1bDyovQ2o+CbszrAVWxUi2q4+D+torUOAleIJNpmRZ/A7AiSjSmrCE8z0A==
X-Received: by 2002:a1c:dcd5:: with SMTP id t204mr3265211wmg.17.1594719107111; 
 Tue, 14 Jul 2020 02:31:47 -0700 (PDT)
Received: from redhat.com (bzq-79-180-10-140.red.bezeqint.net. [79.180.10.140])
 by smtp.gmail.com with ESMTPSA id n16sm3306725wmc.40.2020.07.14.02.31.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Jul 2020 02:31:46 -0700 (PDT)
Date: Tue, 14 Jul 2020 05:31:43 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Andrew Jones <drjones@redhat.com>
Subject: Re: [PATCH 3/4] hw/arm/virt-acpi-build: Only expose flash on older
 machine types
Message-ID: <20200714053023-mutt-send-email-mst@kernel.org>
References: <20200629140938.17566-1-drjones@redhat.com>
 <20200629140938.17566-4-drjones@redhat.com>
 <20200713104907.335bf762@redhat.com>
 <20200714055109.owrlob6m53notzh3@kamzik.brq.redhat.com>
 <20200714045537-mutt-send-email-mst@kernel.org>
 <20200714092325.5klaeqelu46mhg76@kamzik.brq.redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200714092325.5klaeqelu46mhg76@kamzik.brq.redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.61; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/14 03:57:32
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
Cc: peter.maydell@linaro.org, eric.auger@redhat.com, philmd@redhat.com,
 qemu-devel@nongnu.org, shannon.zhaosl@gmail.com, qemu-arm@nongnu.org,
 ard.biesheuvel@arm.com, Igor Mammedov <imammedo@redhat.com>, lersek@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Jul 14, 2020 at 11:23:25AM +0200, Andrew Jones wrote:
> On Tue, Jul 14, 2020 at 04:57:50AM -0400, Michael S. Tsirkin wrote:
> > On Tue, Jul 14, 2020 at 07:51:09AM +0200, Andrew Jones wrote:
> > > On Mon, Jul 13, 2020 at 10:49:07AM +0200, Igor Mammedov wrote:
> > > > On Mon, 29 Jun 2020 16:09:37 +0200
> > > > Andrew Jones <drjones@redhat.com> wrote:
> > > > 
> > > > > The flash device is exclusively for the host-controlled firmware, so
> > > > > we should not expose it to the OS. Exposing it risks the OS messing
> > > > > with it, which could break firmware runtime services and surprise the
> > > > > OS when all its changes disappear after reboot.
> > > > > 
> > > > > As firmware needs the device and uses DT, we leave the device exposed
> > > > > there. It's up to firmware to remove the nodes from DT before sending
> > > > > it on to the OS. However, there's no need to force firmware to remove
> > > > > tables from ACPI (which it doesn't know how to do anyway), so we
> > > > > simply don't add the tables in the first place. But, as we've been
> > > > > adding the tables for quite some time and don't want to change the
> > > > > default hardware exposed to versioned machines, then we only stop
> > > > > exposing the flash device tables for 5.1 and later machine types.
> > > > > 
> > > > > Suggested-by: Ard Biesheuvel <ard.biesheuvel@arm.com>
> > > > > Suggested-by: Laszlo Ersek <lersek@redhat.com>
> > > > > Signed-off-by: Andrew Jones <drjones@redhat.com>
> > > > > ---
> > > > >  hw/arm/virt-acpi-build.c | 5 ++++-
> > > > >  hw/arm/virt.c            | 3 +++
> > > > >  include/hw/arm/virt.h    | 1 +
> > > > >  3 files changed, 8 insertions(+), 1 deletion(-)
> > > > > 
> > > > > diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
> > > > > index 1384a2cf2ab4..91f0df7b13a3 100644
> > > > > --- a/hw/arm/virt-acpi-build.c
> > > > > +++ b/hw/arm/virt-acpi-build.c
> > > > > @@ -749,6 +749,7 @@ static void build_fadt_rev5(GArray *table_data, BIOSLinker *linker,
> > > > >  static void
> > > > >  build_dsdt(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
> > > > >  {
> > > > > +    VirtMachineClass *vmc = VIRT_MACHINE_GET_CLASS(vms);
> > > > >      Aml *scope, *dsdt;
> > > > >      MachineState *ms = MACHINE(vms);
> > > > >      const MemMapEntry *memmap = vms->memmap;
> > > > > @@ -767,7 +768,9 @@ build_dsdt(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
> > > > >      acpi_dsdt_add_cpus(scope, vms->smp_cpus);
> > > > >      acpi_dsdt_add_uart(scope, &memmap[VIRT_UART],
> > > > >                         (irqmap[VIRT_UART] + ARM_SPI_BASE));
> > > > > -    acpi_dsdt_add_flash(scope, &memmap[VIRT_FLASH]);
> > > > > +    if (vmc->acpi_expose_flash) {
> > > > > +        acpi_dsdt_add_flash(scope, &memmap[VIRT_FLASH]);
> > > > > +    }
> > > > >      acpi_dsdt_add_fw_cfg(scope, &memmap[VIRT_FW_CFG]);
> > > > >      acpi_dsdt_add_virtio(scope, &memmap[VIRT_MMIO],
> > > > >                      (irqmap[VIRT_MMIO] + ARM_SPI_BASE), NUM_VIRTIO_TRANSPORTS);
> > > > > diff --git a/hw/arm/virt.c b/hw/arm/virt.c
> > > > > index cd0834ce7faf..5adc9ff799ef 100644
> > > > > --- a/hw/arm/virt.c
> > > > > +++ b/hw/arm/virt.c
> > > > > @@ -2482,9 +2482,12 @@ DEFINE_VIRT_MACHINE_AS_LATEST(5, 1)
> > > > >  
> > > > >  static void virt_machine_5_0_options(MachineClass *mc)
> > > > >  {
> > > > > +    VirtMachineClass *vmc = VIRT_MACHINE_CLASS(OBJECT_CLASS(mc));
> > > > > +
> > > > >      virt_machine_5_1_options(mc);
> > > > >      compat_props_add(mc->compat_props, hw_compat_5_0, hw_compat_5_0_len);
> > > > >      mc->numa_mem_supported = true;
> > > > > +    vmc->acpi_expose_flash = true;
> > > > 
> > > > we usually do not version ACPI tables changes
> > > > (unless we have a good reason to do so)
> > > 
> > > Even when the change is to remove the exposure of hardware from the guest?
> > > Before this change, if a guest looked, it had a flash, after this change,
> > > if a guest looks, it doesn't.
> > 
> > It's up to the relevant maintainers who know what the semantics are.
> > FYI ACPI tables only change across a reset though.
> > So it's a question of whether guests get confused even if this
> > changes after a reboot.
> 
> Yup, but it's still the same "machine", so a user may wonder why it
> changed.
> 
> > Versioning is generally safer, but it's a good idea to document
> > the motivation for it.
> >
> 
> Well, in this case, we could probably push this change to old machine
> types and nobody would notice. If a guest is using ACPI, then it must
> be using firmware, and if they're using firmware, then they can't be
> using the flash. So the user shouldn't care if it's there or not. The
> only justification for the versioning is because "it's safer". If
> people feel strongly about avoiding versioning when it's not obviously
> necessary, then I can respin without it.
> 
> Thanks,
> drew

It's up to maintainers either way, but please do tweak the motivation in the commit log
to include the above.

-- 
MST


