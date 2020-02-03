Return-Path: <SRS0=cs6B=3X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02C1AC3524D
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 09:46:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C083520661
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 09:46:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KIibm1nc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C083520661
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37042 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iyYJc-0003TP-3p
	for qemu-devel@archiver.kernel.org; Mon, 03 Feb 2020 04:46:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57805)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <imammedo@redhat.com>) id 1iyYIv-00034d-7W
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 04:46:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1iyYIt-0004Fv-CB
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 04:46:05 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:47641
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1iyYIs-0004Dy-FP
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 04:46:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580723161;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TKmqaFYIuWWmv0xYrToaB1/TueV6ngGBR2fgAOgxInU=;
 b=KIibm1ncfqVbnly6NgxJTIv8DQSaBl8utmunXeo/slpHBSjM6BwhUbbfLaUZ4zd6BJ/2wI
 61aHLxuuuN/idiK1F+6fxJ92xfCmipwgq7ki/lUXElE3MlGtHvnLmnwAuh7J55kWZRo/xl
 z+NNOHkUeiq2l1EuvFCVetq563F0AP8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-397-g8IGiacTMKezLzZrQLYgmA-1; Mon, 03 Feb 2020 04:45:59 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EC23C800D50;
 Mon,  3 Feb 2020 09:45:58 +0000 (UTC)
Received: from localhost (unknown [10.43.2.114])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C774E5D9CA;
 Mon,  3 Feb 2020 09:45:55 +0000 (UTC)
Date: Mon, 3 Feb 2020 10:45:53 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v4 43/80] x86/pc: use memdev for RAM
Message-ID: <20200203104553.76e76364@redhat.com>
In-Reply-To: <20200203040441-mutt-send-email-mst@kernel.org>
References: <1580483390-131164-1-git-send-email-imammedo@redhat.com>
 <1580483390-131164-44-git-send-email-imammedo@redhat.com>
 <20200203040441-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: g8IGiacTMKezLzZrQLYgmA-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: pbonzini@redhat.com, rth@twiddle.net, qemu-devel@nongnu.org,
 ehabkost@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 3 Feb 2020 04:07:12 -0500
"Michael S. Tsirkin" <mst@redhat.com> wrote:

> On Fri, Jan 31, 2020 at 04:09:13PM +0100, Igor Mammedov wrote:
> > memory_region_allocate_system_memory() API is going away, so
> > replace it with memdev allocated MemoryRegion. The later is
> > initialized by generic code, so board only needs to opt in
> > to memdev scheme by providing
> >   MachineClass::default_ram_id
> > and using MachineState::ram instead of manually initializing
> > RAM memory region.
> > 
> > Signed-off-by: Igor Mammedov <imammedo@redhat.com>  
> 
> 
> Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
> 
thanks!

> But see by other comment - I think a bool flag to opt in,
> that can then be dropped for non-versioned boards would be nicer.
> 
> E.g. use_memdev_for_ram.

It could be done on top as cleanup patch, similar to dropped:
"[PATCH v2 76/86] post conversion default_ram_id cleanup"
but it needs some more thought on what direction we would like
to go wrt these boards and boards with fixed RAM size.

Goal of this series is replacing memory_region_allocate_system_memory()
with hostmem based allocation.
Whether non-versioned boards used the former for a good reason or
it was used  just as copied as template is a topic for another series.

Personally, for boards with fixed RAM size I'd just make usage
of "-m" error out saying that size is fixed and can't be set by user.
(that should clean up quite a bit of code).
And on top of that convert them to plain memory_region_init_ram() as
they do not really need flexibility hostmem provides. So that pattern
would be copied to new embed boards and -m optin used only in cases
where board really needs it.

> > ---
> > CC: mst@redhat.com
> > CC: pbonzini@redhat.com
> > CC: rth@twiddle.net
> > CC: ehabkost@redhat.com
> > ---
> >  hw/i386/pc.c | 19 +++++++++----------
> >  1 file changed, 9 insertions(+), 10 deletions(-)
> > 
> > diff --git a/hw/i386/pc.c b/hw/i386/pc.c
> > index 2ddce42..6ab4acb 100644
> > --- a/hw/i386/pc.c
> > +++ b/hw/i386/pc.c
> > @@ -937,7 +937,7 @@ void pc_memory_init(PCMachineState *pcms,
> >                      MemoryRegion **ram_memory)
> >  {
> >      int linux_boot, i;
> > -    MemoryRegion *ram, *option_rom_mr;
> > +    MemoryRegion *option_rom_mr;
> >      MemoryRegion *ram_below_4g, *ram_above_4g;
> >      FWCfgState *fw_cfg;
> >      MachineState *machine = MACHINE(pcms);
> > @@ -950,22 +950,20 @@ void pc_memory_init(PCMachineState *pcms,
> >  
> >      linux_boot = (machine->kernel_filename != NULL);
> >  
> > -    /* Allocate RAM.  We allocate it as a single memory region and use
> > -     * aliases to address portions of it, mostly for backwards compatibility
> > -     * with older qemus that used qemu_ram_alloc().
> > +    /*
> > +     * Split single memory region and use aliases to address portions of it,
> > +     * done for backwards compatibility with older qemus.
> >       */
> > -    ram = g_malloc(sizeof(*ram));
> > -    memory_region_allocate_system_memory(ram, NULL, "pc.ram",
> > -                                         machine->ram_size);
> > -    *ram_memory = ram;
> > +    *ram_memory = machine->ram;
> >      ram_below_4g = g_malloc(sizeof(*ram_below_4g));
> > -    memory_region_init_alias(ram_below_4g, NULL, "ram-below-4g", ram,
> > +    memory_region_init_alias(ram_below_4g, NULL, "ram-below-4g", machine->ram,
> >                               0, x86ms->below_4g_mem_size);
> >      memory_region_add_subregion(system_memory, 0, ram_below_4g);
> >      e820_add_entry(0, x86ms->below_4g_mem_size, E820_RAM);
> >      if (x86ms->above_4g_mem_size > 0) {
> >          ram_above_4g = g_malloc(sizeof(*ram_above_4g));
> > -        memory_region_init_alias(ram_above_4g, NULL, "ram-above-4g", ram,
> > +        memory_region_init_alias(ram_above_4g, NULL, "ram-above-4g",
> > +                                 machine->ram,
> >                                   x86ms->below_4g_mem_size,
> >                                   x86ms->above_4g_mem_size);
> >          memory_region_add_subregion(system_memory, 0x100000000ULL,
> > @@ -1952,6 +1950,7 @@ static void pc_machine_class_init(ObjectClass *oc, void *data)
> >      mc->default_cpu_type = TARGET_DEFAULT_CPU_TYPE;
> >      mc->nvdimm_supported = true;
> >      mc->numa_mem_supported = true;
> > +    mc->default_ram_id = "pc.ram";
> >  
> >      object_class_property_add(oc, PC_MACHINE_DEVMEM_REGION_SIZE, "int",
> >          pc_machine_get_device_memory_region_size, NULL,
> > -- 
> > 2.7.4
> > 
> >   
> 
> 


