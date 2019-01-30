Received: from eggs.gnu.org ([209.51.188.92]:49808)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gooel-0001lg-Vg
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 07:07:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gooek-00035r-WC
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 07:07:51 -0500
Received: from mx1.redhat.com ([209.132.183.28]:41468)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1gooei-00031F-Fb
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 07:07:48 -0500
References: <1548410831-19553-1-git-send-email-pbonzini@redhat.com>
	<1548410831-19553-3-git-send-email-pbonzini@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <f4208837-83e7-a090-91d5-fc978490da9c@redhat.com>
Date: Wed, 30 Jan 2019 13:07:35 +0100
MIME-Version: 1.0
In-Reply-To: <1548410831-19553-3-git-send-email-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 02/52] ide: split ioport registration to a
 separate file
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: yang.zhong@intel.com, BALATON Zoltan <balaton@eik.bme.hu>

On 2019-01-25 11:06, Paolo Bonzini wrote:
> This is not needed on ARM, and brings in ISA bus code which is otherwise not
> necessary.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  hw/ide/Makefile.objs |  6 ++---
>  hw/ide/core.c        | 25 --------------------
>  hw/ide/ioport.c      | 67 ++++++++++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 70 insertions(+), 28 deletions(-)
>  create mode 100644 hw/ide/ioport.c
> 
> diff --git a/hw/ide/Makefile.objs b/hw/ide/Makefile.objs
> index fc328ff..3f3edd10 100644
> --- a/hw/ide/Makefile.objs
> +++ b/hw/ide/Makefile.objs
> @@ -1,12 +1,12 @@
>  common-obj-$(CONFIG_IDE_CORE) += core.o atapi.o
>  common-obj-$(CONFIG_IDE_QDEV) += qdev.o
> -common-obj-$(CONFIG_IDE_PCI) += pci.o
> -common-obj-$(CONFIG_IDE_ISA) += isa.o
> +common-obj-$(CONFIG_IDE_PCI) += pci.o ioport.o
> +common-obj-$(CONFIG_IDE_ISA) += isa.o ioport.o
>  common-obj-$(CONFIG_IDE_PIIX) += piix.o
>  common-obj-$(CONFIG_IDE_CMD646) += cmd646.o
>  common-obj-$(CONFIG_IDE_MACIO) += macio.o
>  common-obj-$(CONFIG_IDE_MMIO) += mmio.o
> -common-obj-$(CONFIG_IDE_VIA) += via.o
> +common-obj-$(CONFIG_IDE_VIA) += via.o ioport.o
>  common-obj-$(CONFIG_MICRODRIVE) += microdrive.o
>  common-obj-$(CONFIG_AHCI) += ahci.o
>  common-obj-$(CONFIG_AHCI) += ich.o

This caused some trouble in the "ppc: Express dependencies of the
Sam460EX machines with kconfig" patch - I had to select ISA_BUS there to
avoid linker problems, even though the machine does not use ISA.

I think adding ioport.o to IDE_PCI and IDE_VIA is wrong. The
ide_init_ioport() function is only used by isa.c and piix.c, so it
should only be added for IDE_ISA and IDE_PIIX here.

 Thomas
