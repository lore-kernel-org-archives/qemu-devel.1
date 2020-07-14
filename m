Return-Path: <SRS0=DUFB=AZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCF8FC433E2
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2020 11:13:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 88DC62084C
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2020 11:13:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RjpKqAIP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 88DC62084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33990 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jvIs4-0004un-Ng
	for qemu-devel@archiver.kernel.org; Tue, 14 Jul 2020 07:13:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49836)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jvIrV-0004VZ-Tm
 for qemu-devel@nongnu.org; Tue, 14 Jul 2020 07:12:37 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:57747
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jvIrU-0006Vk-1s
 for qemu-devel@nongnu.org; Tue, 14 Jul 2020 07:12:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594725155;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bX7JHxFm/38ZQuxn3bHweSgOSEJRRueQJ6aA137wLAc=;
 b=RjpKqAIPjzDSPB/tYqAKpBZ5Xv1zi2OvTYpNTKIh/31mP8MblD70W2dW/hulS0Mg80cxdI
 beSbTSyISqtHJXJbGHJNmZ8bkxozfyOr40YXtsKTqOTpTq5iV8/bBzT18t9Av7mFnvAPUa
 XQKnAIHpDIibAPpjrH0KSPUiUwrlsRk=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-277-rtvmBap0NHm9U_f9TOCVmg-1; Tue, 14 Jul 2020 07:12:33 -0400
X-MC-Unique: rtvmBap0NHm9U_f9TOCVmg-1
Received: by mail-wm1-f72.google.com with SMTP id f68so2286125wmf.1
 for <qemu-devel@nongnu.org>; Tue, 14 Jul 2020 04:12:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=bX7JHxFm/38ZQuxn3bHweSgOSEJRRueQJ6aA137wLAc=;
 b=BUmXK5koeJiZephDjSyy3GHP57GBtLP12xb2Jx5vAaCd2f46n4A/xhfDeTH7GZpB0/
 8HPSWdHP3SnIu/tmlp7wo8UENbpwLUPleunWTdO0lFN6Rs3jsXOZ3VDmTs65A3WHMRat
 gGBo7dPs0Dw9nqqK6MqtTskw2E9WrWz4q7XoDA2w3MfE7XK/U2mz4eXr8g4yC151XS4B
 GSTjTZXTtIEVSn7s1057b0OYA/4owVwpUfbE5MJ79q7Cfczh/nQCcC5j2CKcPqVDcrle
 C+oh4UByV92yZsbelbjVUYyLMYvbTKgwlo7xAq28EfrQe8aD1gOSm7ER3jdOm4SNKpXO
 iS/A==
X-Gm-Message-State: AOAM531eDiFmjDpcesm6jCYJ5q96y9YWdx7mLJq7OQDLoYMlHwTlywKU
 zmBSpvZfyhhh9OxN+ScN4k0JuNWMFdhL5XG4CxkBaKsxToM/PEa794oAMCo9KMzuuDFyekphNHF
 k5mKuZweOC5p+5Ug=
X-Received: by 2002:adf:8444:: with SMTP id 62mr4389441wrf.278.1594725152495; 
 Tue, 14 Jul 2020 04:12:32 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxvgm2y/eENp2joIaEb9fxRA1Zn/dn+rUQr41gPXK9ZPAr4a6oF9pMlW/+LKVfZoNOFz5Yk4g==
X-Received: by 2002:adf:8444:: with SMTP id 62mr4389328wrf.278.1594725151297; 
 Tue, 14 Jul 2020 04:12:31 -0700 (PDT)
Received: from redhat.com (bzq-79-180-10-140.red.bezeqint.net. [79.180.10.140])
 by smtp.gmail.com with ESMTPSA id y16sm29132131wro.71.2020.07.14.04.12.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Jul 2020 04:12:30 -0700 (PDT)
Date: Tue, 14 Jul 2020 07:12:27 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Subject: Re: [PATCH] Allow acpi-tmr size=2
Message-ID: <20200714071055-mutt-send-email-mst@kernel.org>
References: <5f12377f-b640-c4c5-1bcd-858c622c6c31@the-jedi.co.uk>
 <4a5cfe21-d370-8ebf-b905-c37d39b68353@msgid.tls.msk.ru>
 <20200713070946-mutt-send-email-mst@kernel.org>
 <cf26ffdf-3165-8f54-267f-70f150c73c37@redhat.com>
MIME-Version: 1.0
In-Reply-To: <cf26ffdf-3165-8f54-267f-70f150c73c37@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.120; envelope-from=mst@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/13 21:44:01
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Simon John <github@the-jedi.co.uk>, Michael Tokarev <mjt@tls.msk.ru>,
 qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, imammedo@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Jul 14, 2020 at 12:55:44PM +0200, Philippe Mathieu-Daudé wrote:
> +Peter/Paolo
> 
> On 7/13/20 1:14 PM, Michael S. Tsirkin wrote:
> > On Mon, Jul 13, 2020 at 10:20:12AM +0300, Michael Tokarev wrote:
> >> 12.07.2020 15:00, Simon John wrote:
> >>> macos guests no longer boot after commit 5d971f9e672507210e77d020d89e0e89165c8fc9
> >>>
> >>> acpi-tmr needs 2 byte memory accesses, so breaks as that commit only allows 4 bytes.
> >>>
> >>> Fixes: 5d971f9e672507210e7 (memory: Revert "memory: accept mismatching sizes in memory_region_access_valid")
> >>> Buglink: https://bugs.launchpad.net/qemu/+bug/1886318
> >>
> >> Actually this fixes 77d58b1e47c8d1c661f98f12b47ab519d3561488
> >> Author: Gerd Hoffmann <kraxel@redhat.com>
> >> Date:   Thu Nov 22 12:12:30 2012 +0100
> >> Subject: apci: switch timer to memory api
> >> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> >>
> >> because this is the commit which put min_access_size = 4 in there
> >> (5d971f9e672507210e7 is just a messenger, actual error were here
> >> earlier but it went unnoticed).
> >>
> >> While min_access_size=4 was most likely an error, I wonder why
> >> we use 1 now, while the subject says it needs 2? What real min
> >> size is here for ACPI PM timer?
> >>
> >> /mjt
> > 
> > 
> > Well the ACPI spec 1.0b says
> > 
> > 4.7.3.3 Power Management Timer (PM_TMR)
> > 
> > ...
> > 
> > This register is accessed as 32 bits.
> > 
> > and this text is still there in 6.2.
> > 
> > 
> > So it's probably worth it to cite this in the commit log
> > and explain it's a spec violation.
> > I think it's better to be restrictive and only allow the
> > minimal variation from spec - in this case I guess this means 2 byte
> > reads.
> 
> Now reading this thread, I guess understand this register is
> accessed via the I/O address space, where 8/16/32-bit accesses
> are always valid if the CPU supports an I/O bus.

They are valid from bus POV, but not from the device POV.


> We have 3 different devices providing this register:
> - ICH9
> - PIIX4 (abused in PIIX3)
> - VT82C686
> 
> All are PCI devices, exposing this register via an ISA function.
> 
> The ISA MemoryRegion should allow 8/16/32-bit accesses.
> 
> For these devices we use:
> 
> MemoryRegion *pci_address_space_io(PCIDevice *dev)
> {
>     return pci_get_bus(dev)->address_space_io;
> }
> 
> Which comes from:
> 
> static void pci_root_bus_init(PCIBus *bus, DeviceState *parent,
>                               MemoryRegion *address_space_mem,
>                               MemoryRegion *address_space_io,
>                               uint8_t devfn_min)
> {
>     ...
>     bus->address_space_mem = address_space_mem;
>     bus->address_space_io = address_space_io;
>     ...
> 
> 
> In i440fx_init():
> 
>     b = pci_root_bus_new(dev, NULL, pci_address_space,
>                          address_space_io, 0, TYPE_PCI_BUS);
> 
> q35_host_initfn() uses get_system_io() from pc_q35_init().
> 
> If the guest did a 16-bit read, it should work ...:
> 
> uint16_t cpu_inw(uint32_t addr)
> {
>     uint8_t buf[2];
>     uint16_t val;
> 
>     address_space_read(&address_space_io, addr, MEMTXATTRS_UNSPECIFIED,
> buf, 2);
>     val = lduw_p(buf);
>     trace_cpu_in(addr, 'w', val);
>     return val;
> }
> 
> ... but it is indeed prevented by min_access_size=4.
> 
> Maybe we should have the ISA MemoryRegion accepts min_access_size=1
> and adjust the access sizes.

What started all this is that device code isn't really prepared
to handle such accesses.


> > 
> > In any case pls do include an explanation for why you picked
> > one over the other.
> > 
> >>
> >>> Signed-off-by: Simon John <git@the-jedi.co.uk>
> >>> ---
> >>> Ãƒâ€šÃ‚Â hw/acpi/core.c | 2 +-
> >>> Ãƒâ€šÃ‚Â 1 file changed, 1 insertion(+), 1 deletion(-)
> >>>
> >>> diff --git a/hw/acpi/core.c b/hw/acpi/core.c
> >>> index f6d9ec4f13..05ff29b9d7 100644
> >>> --- a/hw/acpi/core.c
> >>> +++ b/hw/acpi/core.c
> >>> @@ -527,7 +527,7 @@ static void acpi_pm_tmr_write(void *opaque, hwaddr addr, uint64_t val,
> >>> Ãƒâ€šÃ‚Â static const MemoryRegionOps acpi_pm_tmr_ops = {
> >>> Ãƒâ€šÃ‚Â Ãƒâ€šÃ‚Â Ãƒâ€šÃ‚Â Ãƒâ€šÃ‚Â  .read = acpi_pm_tmr_read,
> >>> Ãƒâ€šÃ‚Â Ãƒâ€šÃ‚Â Ãƒâ€šÃ‚Â Ãƒâ€šÃ‚Â  .write = acpi_pm_tmr_write,
> >>> -Ãƒâ€šÃ‚Â Ãƒâ€šÃ‚Â Ãƒâ€šÃ‚Â  .valid.min_access_size = 4,
> >>> +Ãƒâ€šÃ‚Â Ãƒâ€šÃ‚Â Ãƒâ€šÃ‚Â  .valid.min_access_size = 1,
> >>> Ãƒâ€šÃ‚Â Ãƒâ€šÃ‚Â Ãƒâ€šÃ‚Â Ãƒâ€šÃ‚Â  .valid.max_access_size = 4,
> >>> Ãƒâ€šÃ‚Â Ãƒâ€šÃ‚Â Ãƒâ€šÃ‚Â Ãƒâ€šÃ‚Â  .endianness = DEVICE_LITTLE_ENDIAN,
> >>> Ãƒâ€šÃ‚Â };
> > 
> > 


