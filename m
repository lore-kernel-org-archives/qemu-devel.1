Received: from eggs.gnu.org ([209.51.188.92]:44235)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yang.zhong@intel.com>) id 1ggnRC-0008Qr-MR
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 04:12:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yang.zhong@intel.com>) id 1ggnR9-000436-Ib
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 04:12:41 -0500
Received: from mga06.intel.com ([134.134.136.31]:6529)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yang.zhong@intel.com>)
	id 1ggnR6-0003e4-MW
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 04:12:37 -0500
Date: Tue, 8 Jan 2019 17:08:53 +0800
From: Yang Zhong <yang.zhong@intel.com>
Message-ID: <20190108090853.GC27840@yangzhon-Virtual>
References: <20181227063419.12981-1-yang.zhong@intel.com>
	<20181227063419.12981-16-yang.zhong@intel.com>
	<af2cbeac-607c-194a-e546-6a7995be3f52@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <af2cbeac-607c-194a-e546-6a7995be3f52@redhat.com>
Subject: Re: [Qemu-devel] [RFC PATCH 15/25] isa: express dependencies with
 kconfig
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org, sameo@linux.intel.com, pbonzini@redhat.com, ehabkost@redhat.com, yang.zhong@intel.com

On Fri, Jan 04, 2019 at 02:55:20PM +0100, Thomas Huth wrote:
> On 2018-12-27 07:34, Yang Zhong wrote:
> > From: Paolo Bonzini <pbonzini@redhat.com>
> > 
> > Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> > Signed-off-by: Yang Zhong <yang.zhong@intel.com>
> > ---
> [...]
> > diff --git a/hw/display/Kconfig b/hw/display/Kconfig
> > index 5e73277cc2..e0d7919a06 100644
> > --- a/hw/display/Kconfig
> > +++ b/hw/display/Kconfig
> > @@ -9,6 +9,9 @@ config ADS7846
> >  
> >  config VGA_CIRRUS
> >      bool
> > +    default y
> > +    depends on ISA_BUS && PCI
> > +    select VGA
> 
> Please note that the cirrus-isa device has recently been split into a
> separate file, see commit:
> 
>   ce3cf70edaaf1b8f9a566b36011350c642287879
>   Move "isa-cirrus-vga" device into a separate file
> 
> I guess we need a dedicated VGA_CIRRUS_ISA switch for that file now?
> 
  Thanks for Thomas's reminder, you are right.

  The cirrus_vga_isa.c depend on "config VGA_CIRRUS" and "config VGA_ISA"
  common-obj-$(call land,$(CONFIG_VGA_CIRRUS),$(CONFIG_VGA_ISA))+=cirrus_vga_isa.o

  Those have been defined in this hw/display/Kconfig:

  config VGA_CIRRUS
    bool
    default y
    depends on ISA_BUS && PCI
    select VGA

  config VGA_ISA
    bool
    depends on ISA_BUS
    select VGA

  Since isa has been splited out from cirrus_vga.c file 
  common-obj-$(CONFIG_VGA_CIRRUS) += cirrus_vga.o

  The new "config VGA_CIRRUS" will remove ISA_BUS, like below:
   config VGA_CIRRUS
    bool
    default y
    depends on PCI
    select VGA

   Regards,

   Yang

> > diff --git a/hw/i386/Kconfig b/hw/i386/Kconfig
> > index 427bda3717..68a9064558 100644
> > --- a/hw/i386/Kconfig
> > +++ b/hw/i386/Kconfig
> > @@ -9,6 +9,7 @@ config I440FX
> >  
> >  config ISAPC
> >      bool
> > +    select ISA_BUS
> >  
> >  config Q35
> >      bool
> 
> Can Q35 and I440FX work completely without ISA_BUS already, or should
> they also select ISA_BUS here?
>
>  Thomas

  Thanks for comments, and "select ISA_BUS" for i440fx and Q35 are defined
  in hw/isa/Kconfig file of this patch.

   config PIIX4
     bool
+    select ISA_BUS

   config LPC_ICH9
     bool
+    select ISA_BUS
+    select ACPI_X86_ICH

    Regards,

    Yang
