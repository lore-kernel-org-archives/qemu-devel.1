Return-Path: <SRS0=QWrs=3F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EACDC33CB1
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2020 12:16:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 28981207FF
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2020 12:16:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MyaraJY3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 28981207FF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40752 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1is452-0003kR-Ae
	for qemu-devel@archiver.kernel.org; Thu, 16 Jan 2020 07:16:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60654)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <imammedo@redhat.com>) id 1is43d-0002l1-FQ
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 07:15:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1is43Z-0001bc-TW
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 07:15:29 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:40585
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1is43Z-0001bI-PI
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 07:15:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579176925;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sZTfuR5hQ0jgjwm20RiJppftxSC8TRQablyMJCY8mO8=;
 b=MyaraJY3dzCbLRlZpmEMx8ZtO8IX2GvQ/ZIjhzBLyzwwrG0RsfDpSqrGgaGLlhaWCQRNUF
 y1Itnw4No1TPpKiu4EZcRwiuMEjEVb5zaZcz19JBjqJb5Mlpro4lZCcJzBDmA1DbrqU9Kk
 x9zaxRSmB6g0VCri8HPkHDLWldTCDfw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-305-5lNrKOaIPyyY6pHsgNx6fg-1; Thu, 16 Jan 2020 07:15:22 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B4B61192296A;
 Thu, 16 Jan 2020 12:15:20 +0000 (UTC)
Received: from localhost (unknown [10.43.2.114])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8FA3480890;
 Thu, 16 Jan 2020 12:15:19 +0000 (UTC)
Date: Thu, 16 Jan 2020 13:15:17 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [PATCH v2 68/86] ppc:prep: use memdev for RAM
Message-ID: <20200116131517.6133bdd4@redhat.com>
In-Reply-To: <20200116042658.GL54439@umbus>
References: <1579100861-73692-1-git-send-email-imammedo@redhat.com>
 <1579100861-73692-69-git-send-email-imammedo@redhat.com>
 <20200116042658.GL54439@umbus>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: 5lNrKOaIPyyY6pHsgNx6fg-1
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
Cc: hpoussin@reactos.org, qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 16 Jan 2020 14:26:58 +1000
David Gibson <david@gibson.dropbear.id.au> wrote:

> On Wed, Jan 15, 2020 at 04:07:23PM +0100, Igor Mammedov wrote:
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
> Although it's probably fairly pointless, since I'm looking to merge a
> patch removing prep entirely soon.

I know,
if that gets merged first, I'll just drop these on respin

> 
> > ---
> > CC: hpoussin@reactos.org
> > CC: david@gibson.dropbear.id.au
> > CC: qemu-ppc@nongnu.org
> > ---
> >  hw/ppc/prep.c | 15 +++++++--------
> >  1 file changed, 7 insertions(+), 8 deletions(-)
> > 
> > diff --git a/hw/ppc/prep.c b/hw/ppc/prep.c
> > index 862345c..bf75dde 100644
> > --- a/hw/ppc/prep.c
> > +++ b/hw/ppc/prep.c
> > @@ -400,7 +400,6 @@ static int PPC_NVRAM_set_params (Nvram *nvram, uint16_t NVRAM_size,
> >  /* PowerPC PREP hardware initialisation */
> >  static void ppc_prep_init(MachineState *machine)
> >  {
> > -    ram_addr_t ram_size = machine->ram_size;
> >      const char *kernel_filename = machine->kernel_filename;
> >      const char *kernel_cmdline = machine->kernel_cmdline;
> >      const char *initrd_filename = machine->initrd_filename;
> > @@ -413,7 +412,6 @@ static void ppc_prep_init(MachineState *machine)
> >      MemoryRegion *xcsr = g_new(MemoryRegion, 1);
> >  #endif
> >      int linux_boot, i, nb_nics1;
> > -    MemoryRegion *ram = g_new(MemoryRegion, 1);
> >      uint32_t kernel_base, initrd_base;
> >      long kernel_size, initrd_size;
> >      DeviceState *dev;
> > @@ -444,15 +442,14 @@ static void ppc_prep_init(MachineState *machine)
> >          qemu_register_reset(ppc_prep_reset, cpu);
> >      }
> >  
> > -    /* allocate RAM */
> > -    memory_region_allocate_system_memory(ram, NULL, "ppc_prep.ram", ram_size);
> > -    memory_region_add_subregion(sysmem, 0, ram);
> > +    /* map RAM */
> > +    memory_region_add_subregion(sysmem, 0, machine->ram);
> >  
> >      if (linux_boot) {
> >          kernel_base = KERNEL_LOAD_ADDR;
> >          /* now we can load the kernel */
> >          kernel_size = load_image_targphys(kernel_filename, kernel_base,
> > -                                          ram_size - kernel_base);
> > +                                          machine->ram_size - kernel_base);
> >          if (kernel_size < 0) {
> >              error_report("could not load kernel '%s'", kernel_filename);
> >              exit(1);
> > @@ -461,7 +458,7 @@ static void ppc_prep_init(MachineState *machine)
> >          if (initrd_filename) {
> >              initrd_base = INITRD_LOAD_ADDR;
> >              initrd_size = load_image_targphys(initrd_filename, initrd_base,
> > -                                              ram_size - initrd_base);
> > +                                              machine->ram_size - initrd_base);
> >              if (initrd_size < 0) {
> >                  error_report("could not load initial ram disk '%s'",
> >                               initrd_filename);
> > @@ -576,7 +573,7 @@ static void ppc_prep_init(MachineState *machine)
> >      sysctrl->nvram = m48t59;
> >  
> >      /* Initialise NVRAM */
> > -    PPC_NVRAM_set_params(m48t59, NVRAM_SIZE, "PREP", ram_size,
> > +    PPC_NVRAM_set_params(m48t59, NVRAM_SIZE, "PREP", machine->ram_size,
> >                           ppc_boot_device,
> >                           kernel_base, kernel_size,
> >                           kernel_cmdline,
> > @@ -596,6 +593,7 @@ static void prep_machine_init(MachineClass *mc)
> >      mc->default_boot_order = "cad";
> >      mc->default_cpu_type = POWERPC_CPU_TYPE_NAME("602");
> >      mc->default_display = "std";
> > +    mc->default_ram_id = "ppc_prep.ram";
> >  }
> >  
> >  static int prep_set_cmos_checksum(DeviceState *dev, void *opaque)
> > @@ -814,6 +812,7 @@ static void ibm_40p_machine_init(MachineClass *mc)
> >      mc->init = ibm_40p_init;
> >      mc->max_cpus = 1;
> >      mc->default_ram_size = 128 * MiB;
> > +    mc->default_ram_id = "ppc_prep.ram";
> >      mc->block_default_type = IF_SCSI;
> >      mc->default_boot_order = "c";
> >      mc->default_cpu_type = POWERPC_CPU_TYPE_NAME("604");  
> 


