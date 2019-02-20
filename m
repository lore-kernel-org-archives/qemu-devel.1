Received: from eggs.gnu.org ([209.51.188.92]:60030)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richardw.yang@linux.intel.com>) id 1gwLW3-0000IP-6H
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 01:38:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richardw.yang@linux.intel.com>) id 1gwLW2-000472-Eq
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 01:37:59 -0500
Date: Wed, 20 Feb 2019 14:37:23 +0800
From: Wei Yang <richardw.yang@linux.intel.com>
Message-ID: <20190220063723.GA28876@richard>
Reply-To: Wei Yang <richardw.yang@linux.intel.com>
References: <1550591757-6192-1-git-send-email-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1550591757-6192-1-git-send-email-thuth@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] hw/ide/ich: Compile ich.c only if
 CONFIG_PCI is also set
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: John Snow <jsnow@redhat.com>, qemu-block@nongnu.org, qemu-trivial@nongnu.org, yang.zhong@intel.com, qemu-devel@nongnu.org, pbonzini@redhat.com

On Tue, Feb 19, 2019 at 04:55:57PM +0100, Thomas Huth wrote:
>With the upcoming Kconfig-like build system, it will be easy to
>build also version of QEMU that only contain a single machine. Some

Sorry for my poor English.

What is also version?

>of these machines (like the ARM cubieboard) use CONFIG_AHCI for an
>AHCI sysbus device, but do not use CONFIG_PCI since they do not feature
>a PCI bus. In this case linking fails:
>
>../hw/ide/ich.o: In function `pci_ich9_ahci_realize':
>hw/ide/ich.c:124: undefined reference to `pci_allocate_irq'
>hw/ide/ich.c:126: undefined reference to `pci_register_bar'
>hw/ide/ich.c:128: undefined reference to `pci_register_bar'
>hw/ide/ich.c:131: undefined reference to `pci_add_capability'
>hw/ide/ich.c:147: undefined reference to `msi_init'
>../hw/ide/ich.o: In function `pci_ich9_uninit':
>hw/ide/ich.c:158: undefined reference to `msi_uninit'
>../hw/ide/ich.o:(.data.rel+0x50): undefined reference to `vmstate_pci_device'
>
>Thus we must only compile ich.c if CONFIG_PCI is also set.
>
>Signed-off-by: Thomas Huth <thuth@redhat.com>
>---
> hw/ide/Makefile.objs | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
>diff --git a/hw/ide/Makefile.objs b/hw/ide/Makefile.objs
>index a142add..dfe53af 100644
>--- a/hw/ide/Makefile.objs
>+++ b/hw/ide/Makefile.objs
>@@ -9,6 +9,6 @@ common-obj-$(CONFIG_IDE_MMIO) += mmio.o
> common-obj-$(CONFIG_IDE_VIA) += via.o
> common-obj-$(CONFIG_MICRODRIVE) += microdrive.o
> common-obj-$(CONFIG_AHCI) += ahci.o
>-common-obj-$(CONFIG_AHCI) += ich.o
>+common-obj-$(call land,$(CONFIG_AHCI),$(CONFIG_PCI)) += ich.o
> common-obj-$(CONFIG_ALLWINNER_A10) += ahci-allwinner.o
> common-obj-$(CONFIG_IDE_SII3112) += sii3112.o
>-- 
>1.8.3.1
>

-- 
Wei Yang
Help you, Help me
