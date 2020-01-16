Return-Path: <SRS0=QWrs=3F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 180C3C33CB3
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2020 12:14:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DC680207FF
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2020 12:14:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="N2V/5YfA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC680207FF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40696 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1is42H-0000ZX-0C
	for qemu-devel@archiver.kernel.org; Thu, 16 Jan 2020 07:14:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60409)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <imammedo@redhat.com>) id 1is41P-0008T2-Dy
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 07:13:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1is41K-0000Tz-HL
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 07:13:09 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:36101
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1is41K-0000T9-6g
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 07:13:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579176785;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=t3kJyEPXbe5wyT0VZuUDU/OasljjfMt6+3fFU2Sj7q4=;
 b=N2V/5YfAgSExB9vho/104jpkIdYVsKWJG2WzDSjgx4+GCIvHbint9PjgeL9GoucMhQWzDS
 wV/Ez8W15KvAkq2EQQWi0t5rSvUgFxaolMqkSsS0L6vdZbF+q2fqhsqaz8mht3xdrZ+t6c
 FF87BuWT9yG+91CKGB0o679ZtXU+1yE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-146-dGECNY1mMautz0f8NMWaJQ-1; Thu, 16 Jan 2020 07:13:01 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 04136801E7B;
 Thu, 16 Jan 2020 12:13:00 +0000 (UTC)
Received: from localhost (unknown [10.43.2.114])
 by smtp.corp.redhat.com (Postfix) with ESMTP id DF43E60C63;
 Thu, 16 Jan 2020 12:12:58 +0000 (UTC)
Date: Thu, 16 Jan 2020 13:12:57 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [PATCH v2 71/86] ppc:virtex_ml507: use memdev for RAM
Message-ID: <20200116131257.50b274ee@redhat.com>
In-Reply-To: <20200116043157.GN54439@umbus>
References: <1579100861-73692-1-git-send-email-imammedo@redhat.com>
 <1579100861-73692-72-git-send-email-imammedo@redhat.com>
 <20200116043157.GN54439@umbus>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: dGECNY1mMautz0f8NMWaJQ-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.120
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
Cc: edgar.iglesias@gmail.com, qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 16 Jan 2020 14:31:57 +1000
David Gibson <david@gibson.dropbear.id.au> wrote:

> On Wed, Jan 15, 2020 at 04:07:26PM +0100, Igor Mammedov wrote:
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
> Acked-by: David Gibson <david@gibson.dropbear.id.au>
> 
> Since this is (AFAICT) independent of the main purpose of your series,
> I've also applied it to my ppc-for-5.0 tree.  If we get a conflict
> because of that it should be easy to resolve.

this patch depends on 1-5/86 as prerequsites,
so pls drop it from your queue.

What could be merged independently is patches with following
phrases in title:
 "drop RAM size fixup"
 "add RAM size checks"
that should help by reducing size of this series a bit.


> > ---
> > CC: david@gibson.dropbear.id.au
> > CC: qemu-ppc@nongnu.org
> > CC: edgar.iglesias@gmail.com
> > ---
> >  hw/ppc/virtex_ml507.c | 12 +++++-------
> >  1 file changed, 5 insertions(+), 7 deletions(-)
> > 
> > diff --git a/hw/ppc/virtex_ml507.c b/hw/ppc/virtex_ml507.c
> > index 651d8db..b74a269 100644
> > --- a/hw/ppc/virtex_ml507.c
> > +++ b/hw/ppc/virtex_ml507.c
> > @@ -193,7 +193,6 @@ static int xilinx_load_device_tree(hwaddr addr,
> >  
> >  static void virtex_init(MachineState *machine)
> >  {
> > -    ram_addr_t ram_size = machine->ram_size;
> >      const char *kernel_filename = machine->kernel_filename;
> >      const char *kernel_cmdline = machine->kernel_cmdline;
> >      hwaddr initrd_base = 0;
> > @@ -204,7 +203,6 @@ static void virtex_init(MachineState *machine)
> >      CPUPPCState *env;
> >      hwaddr ram_base = 0;
> >      DriveInfo *dinfo;
> > -    MemoryRegion *phys_ram = g_new(MemoryRegion, 1);
> >      qemu_irq irq[32], *cpu_irq;
> >      int kernel_size;
> >      int i;
> > @@ -221,8 +219,7 @@ static void virtex_init(MachineState *machine)
> >  
> >      qemu_register_reset(main_cpu_reset, cpu);
> >  
> > -    memory_region_allocate_system_memory(phys_ram, NULL, "ram", ram_size);
> > -    memory_region_add_subregion(address_space_mem, ram_base, phys_ram);
> > +    memory_region_add_subregion(address_space_mem, ram_base, machine->ram);
> >  
> >      dinfo = drive_get(IF_PFLASH, 0, 0);
> >      pflash_cfi01_register(PFLASH_BASEADDR, "virtex.flash", FLASH_SIZE,
> > @@ -265,7 +262,7 @@ static void virtex_init(MachineState *machine)
> >              /* If we failed loading ELF's try a raw image.  */
> >              kernel_size = load_image_targphys(kernel_filename,
> >                                                boot_offset,
> > -                                              ram_size);
> > +                                              machine->ram_size);
> >              boot_info.bootstrap_pc = boot_offset;
> >              high = boot_info.bootstrap_pc + kernel_size + 8192;
> >          }
> > @@ -276,7 +273,7 @@ static void virtex_init(MachineState *machine)
> >          if (machine->initrd_filename) {
> >              initrd_base = high = ROUND_UP(high, 4);
> >              initrd_size = load_image_targphys(machine->initrd_filename,
> > -                                              high, ram_size - high);
> > +                                              high, machine->ram_size - high);
> >  
> >              if (initrd_size < 0) {
> >                  error_report("couldn't load ram disk '%s'",
> > @@ -290,7 +287,7 @@ static void virtex_init(MachineState *machine)
> >          boot_info.fdt = high + (8192 * 2);
> >          boot_info.fdt &= ~8191;
> >  
> > -        xilinx_load_device_tree(boot_info.fdt, ram_size,
> > +        xilinx_load_device_tree(boot_info.fdt, machine->ram_size,
> >                                  initrd_base, initrd_size,
> >                                  kernel_cmdline);
> >      }
> > @@ -302,6 +299,7 @@ static void virtex_machine_init(MachineClass *mc)
> >      mc->desc = "Xilinx Virtex ML507 reference design";
> >      mc->init = virtex_init;
> >      mc->default_cpu_type = POWERPC_CPU_TYPE_NAME("440-xilinx");
> > +    mc->default_ram_id = "ram";
> >  }
> >  
> >  DEFINE_MACHINE("virtex-ml507", virtex_machine_init)  
> 


