Received: from eggs.gnu.org ([209.51.188.92]:46556)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yang.zhong@intel.com>) id 1ggkSf-0006Il-OZ
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 01:02:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yang.zhong@intel.com>) id 1ggkSe-0001w6-Mw
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 01:02:01 -0500
Received: from mga17.intel.com ([192.55.52.151]:11460)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yang.zhong@intel.com>)
	id 1ggkSe-0001nm-DR
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 01:02:00 -0500
Date: Tue, 8 Jan 2019 13:58:18 +0800
From: Yang Zhong <yang.zhong@intel.com>
Message-ID: <20190108055818.GB27412@yangzhon-Virtual>
References: <20181227063419.12981-1-yang.zhong@intel.com>
	<20181227063419.12981-11-yang.zhong@intel.com>
	<00c0eea5-aa0d-118f-3c78-5851fd5eae9d@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <00c0eea5-aa0d-118f-3c78-5851fd5eae9d@redhat.com>
Subject: Re: [Qemu-devel] [RFC PATCH 10/25] build: convert pci.mak to Kconfig
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

On Thu, Jan 03, 2019 at 05:06:32PM +0100, Thomas Huth wrote:
> On 2018-12-27 07:34, Yang Zhong wrote:
> > From: Paolo Bonzini <pbonzini@redhat.com>
> > 
> > Instead of including the same list of devices for each target,
> > set CONFIG_PCI to true, and make the devices default to present
> > whenever PCI is available.
> > 
> > Done mostly with the following script:
> > 
> >   while read i; do
> >      i=${i%=y}; i=${i#CONFIG_}
> >      sed -i -e'/^config '$i'$/!b' -en \
> >             -e'a\' -e'    default y\' -e'    depends on PCI' \
> >           `grep -lw $i hw/*/Kconfig`
> >   done < default-configs/pci.mak
> > 
> > followed by replacing a few "depends on" clauses with "select"
> > whenever the symbol is not really related to PCI.
> > 
> > Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> > Signed-off-by: Yang Zhong <yang.zhong@intel.com>
> > ---
> >  default-configs/i386-softmmu.mak |  2 +-
> >  default-configs/pci.mak          | 47 --------------------------------
> >  hw/audio/Kconfig                 |  6 ++++
> >  hw/block/Kconfig                 |  2 ++
> >  hw/char/Kconfig                  |  2 ++
> >  hw/display/Kconfig               | 12 +++++++-
> >  hw/ide/Kconfig                   |  6 ++++
> >  hw/ipack/Kconfig                 |  2 ++
> >  hw/misc/Kconfig                  |  4 +++
> >  hw/net/Kconfig                   | 19 +++++++++++++
> >  hw/scsi/Kconfig                  | 11 ++++++++
> >  hw/sd/Kconfig                    |  3 ++
> >  hw/usb/Kconfig                   | 10 +++++++
> >  hw/virtio/Kconfig                |  3 ++
> >  hw/watchdog/Kconfig              |  2 ++
> >  15 files changed, 82 insertions(+), 49 deletions(-)
> >  delete mode 100644 default-configs/pci.mak
> > 
> > diff --git a/default-configs/i386-softmmu.mak b/default-configs/i386-softmmu.mak
> > index 560250c998..61f19e5231 100644
> > --- a/default-configs/i386-softmmu.mak
> > +++ b/default-configs/i386-softmmu.mak
> > @@ -1,6 +1,6 @@
> >  # Default configuration for i386-softmmu
> [...]
> > diff --git a/hw/ide/Kconfig b/hw/ide/Kconfig
> > index 091f3a81c9..0f25b27163 100644
> > --- a/hw/ide/Kconfig
> > +++ b/hw/ide/Kconfig
> > @@ -7,6 +7,7 @@ config IDE_QDEV
> >  
> >  config IDE_PCI
> >      bool
> > +    depends on PCI
> >      select IDE_CORE
> >  
> >  config IDE_ISA
> > @@ -15,10 +16,12 @@ config IDE_ISA
> >  
> >  config IDE_PIIX
> >      bool
> > +    depends on PCI
> >      select IDE_QDEV
> >  
> >  config IDE_CMD646
> >      bool
> > +    select IDE_PCI
> >      select IDE_QDEV
> 
> Why "select" here and not "depends on" like in the previous cases?
> 
  Thomas, thanks for reviewing, i will remove "select IDE_PCI" to previous
  patch(ide patch), IDE_PIIX should also "select IDE_PCI" here, thanks!

  Regards,

  Yang
 
> >  config IDE_MACIO
> > @@ -31,6 +34,7 @@ config IDE_MMIO
> >  
> >  config IDE_VIA
> >      bool
> > +    select IDE_PCI
> >      select IDE_QDEV
> 
> dito
> 
  Yes, same as above, thanks for reminder!


> >  config MICRODRIVE
> > @@ -39,6 +43,8 @@ config MICRODRIVE
> >  
> >  config AHCI
> >      bool
> > +    default y
> > +    depends on PCI
> >      select IDE_QDEV
> >  
> >  config IDE_SII3112
> 
> I think the SII3112 needs a "depends on PCI", too?
> 
  Yes, i need add "depends on PCI" here, thanks!

  Regards,

  Yang

> > diff --git a/hw/net/Kconfig b/hw/net/Kconfig
> > index 6b2ec971b5..c87375ee52 100644
> > --- a/hw/net/Kconfig
> > +++ b/hw/net/Kconfig
> > @@ -3,27 +3,42 @@ config DP8393X
> >  
> >  config NE2000_PCI
> >      bool
> > +    default y
> > +    depends on PCI
> >  
> >  config EEPRO100_PCI
> >      bool
> > +    default y
> > +    depends on PCI
> >  
> >  config PCNET_PCI
> >      bool
> > +    default y
> > +    depends on PCI
> > +    select PCNET_COMMON
> >  
> >  config PCNET_COMMON
> >      bool
> >  
> >  config E1000_PCI
> >      bool
> > +    default y
> > +    depends on PCI
> >  
> >  config E1000E_PCI
> >      bool
> > +    default y
> > +    depends on PCI
> >  
> >  config RTL8139_PCI
> >      bool
> > +    default y
> > +    depends on PCI
> >  
> >  config VMXNET3_PCI
> >      bool
> > +    default y
> > +    depends on PCI
> >  
> >  config SMC91C111
> >      bool
> > @@ -81,12 +96,16 @@ config ETSEC
> >  
> >  config ROCKER
> >      bool
> > +    default y
> > +    depends on PCI
> >  
> >  config CAN_BUS
> >      bool
> >  
> >  config CAN_PCI
> >      bool
> > +    default y
> > +    depends on PCI
> 
> Do we need a "select CAN_BUS" here? (Well, maybe that's rather something
> for a later patch instead...)
> 
>  Thomas

  Hello Thomas,

  Yes, right. All those code are based on can bus, which are implemented 
  in net/can. CAN_PCI and CAN_SJA1000 will select CAN_BUS, thanks!

  Regards,

  Yang
