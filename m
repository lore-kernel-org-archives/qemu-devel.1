Received: from eggs.gnu.org ([2001:4830:134:3::10]:52694)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1d2jjC-0002CD-9R
	for qemu-devel@nongnu.org; Mon, 24 Apr 2017 15:32:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1d2jj8-0001eN-BG
	for qemu-devel@nongnu.org; Mon, 24 Apr 2017 15:32:54 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44242)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1d2jj8-0001de-5P
	for qemu-devel@nongnu.org; Mon, 24 Apr 2017 15:32:50 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id EDD328553E
	for <qemu-devel@nongnu.org>; Mon, 24 Apr 2017 19:32:48 +0000 (UTC)
Date: Mon, 24 Apr 2017 21:32:33 +0200
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20170424213233.2d19bdab@Igors-MacBook-Pro.local>
In-Reply-To: <20170424191317.GA3482@thinpad.lan.raisama.net>
References: <20170424185817.41002-1-imammedo@redhat.com>
	<20170424191317.GA3482@thinpad.lan.raisama.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] pc/fwcfg: unbreak migration from qemu-2.5
 and qemu-2.6 during firmware boot
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, mst@redhat.com, dgilbert@redhat.com, lersek@redhat.com

On Mon, 24 Apr 2017 16:13:17 -0300
Eduardo Habkost <ehabkost@redhat.com> wrote:

> On Mon, Apr 24, 2017 at 08:58:17PM +0200, Igor Mammedov wrote:
> [...]
> > diff --git a/hw/i386/pc.c b/hw/i386/pc.c
> > index f3b372a18f..3f2d96da64 100644
> > --- a/hw/i386/pc.c
> > +++ b/hw/i386/pc.c
> > @@ -1047,7 +1047,7 @@ static void load_linux(PCMachineState *pcms,
> >      fw_cfg_add_i32(fw_cfg, FW_CFG_SETUP_SIZE, setup_size);
> >      fw_cfg_add_bytes(fw_cfg, FW_CFG_SETUP_DATA, setup, setup_size);
> >  
> > -    if (fw_cfg_dma_enabled(fw_cfg)) {
> > +    if (!pcmc->linuxboot_dma_disabled && fw_cfg_dma_enabled(fw_cfg)) {
> 
> Why not name the flag just "linuxboot_dma", set it to true by
> default at pc_machine_class_init(), and avoid the double
> negative?
to avoid setting it to true somewhere else, so less thing could go wrong
but is you prefer *_enable variant I can switch to it.

> 
> [...]
> > diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
> > index f278b3ae89..ff6f13b61b 100644
> > --- a/include/hw/i386/pc.h
> > +++ b/include/hw/i386/pc.h
> > @@ -151,6 +151,8 @@ struct PCMachineClass {
> >      bool save_tsc_khz;
> >      /* generate legacy CPU hotplug AML */
> >      bool legacy_cpu_hotplug;
> > +
> 
> A one-line description of the consequences of setting/clearing
> the flag would be nice.
will fix in v2

> 
> > +    bool linuxboot_dma_disabled;
> >  };
> >  
> >  #define TYPE_PC_MACHINE "generic-pc-machine"
> > @@ -432,10 +434,6 @@ bool e820_get_entry(int, uint32_t, uint64_t *, uint64_t *);
> >  #define PC_COMPAT_2_6 \
> >      HW_COMPAT_2_6 \
> >      {\
> > -        .driver   = "fw_cfg_io",\
> > -        .property = "dma_enabled",\
> > -        .value    = "off",\
> > -    },{\
> >          .driver   = TYPE_X86_CPU,\
> >          .property = "cpuid-0xb",\
> >          .value    = "off",\
> > -- 
> > 2.11.0 (Apple Git-81)
> > 
> 
