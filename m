Received: from eggs.gnu.org ([209.51.188.92]:56932)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gwLBq-00045w-Km
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 01:17:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gwLBp-0006yn-Tn
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 01:17:06 -0500
References: <1550591757-6192-1-git-send-email-thuth@redhat.com>
	<482a82e6-ce89-bb04-7a0f-a674397827a8@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <be997f90-8afd-5e57-a84d-2872a4c77c60@redhat.com>
Date: Wed, 20 Feb 2019 07:16:57 +0100
MIME-Version: 1.0
In-Reply-To: <482a82e6-ce89-bb04-7a0f-a674397827a8@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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
To: Paolo Bonzini <pbonzini@redhat.com>, John Snow <jsnow@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, qemu-trivial@nongnu.org, yang.zhong@intel.com

On 19/02/2019 19.18, Paolo Bonzini wrote:
> On 19/02/19 16:55, Thomas Huth wrote:
>> With the upcoming Kconfig-like build system, it will be easy to
>> build also version of QEMU that only contain a single machine. Some
>> of these machines (like the ARM cubieboard) use CONFIG_AHCI for an
>> AHCI sysbus device, but do not use CONFIG_PCI since they do not feature
>> a PCI bus. In this case linking fails:
>>
>> ../hw/ide/ich.o: In function `pci_ich9_ahci_realize':
>> hw/ide/ich.c:124: undefined reference to `pci_allocate_irq'
>> hw/ide/ich.c:126: undefined reference to `pci_register_bar'
>> hw/ide/ich.c:128: undefined reference to `pci_register_bar'
>> hw/ide/ich.c:131: undefined reference to `pci_add_capability'
>> hw/ide/ich.c:147: undefined reference to `msi_init'
>> ../hw/ide/ich.o: In function `pci_ich9_uninit':
>> hw/ide/ich.c:158: undefined reference to `msi_uninit'
>> ../hw/ide/ich.o:(.data.rel+0x50): undefined reference to `vmstate_pci_device'
>>
>> Thus we must only compile ich.c if CONFIG_PCI is also set.
>>
>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>> ---
>>  hw/ide/Makefile.objs | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/hw/ide/Makefile.objs b/hw/ide/Makefile.objs
>> index a142add..dfe53af 100644
>> --- a/hw/ide/Makefile.objs
>> +++ b/hw/ide/Makefile.objs
>> @@ -9,6 +9,6 @@ common-obj-$(CONFIG_IDE_MMIO) += mmio.o
>>  common-obj-$(CONFIG_IDE_VIA) += via.o
>>  common-obj-$(CONFIG_MICRODRIVE) += microdrive.o
>>  common-obj-$(CONFIG_AHCI) += ahci.o
>> -common-obj-$(CONFIG_AHCI) += ich.o
>> +common-obj-$(call land,$(CONFIG_AHCI),$(CONFIG_PCI)) += ich.o
>>  common-obj-$(CONFIG_ALLWINNER_A10) += ahci-allwinner.o
>>  common-obj-$(CONFIG_IDE_SII3112) += sii3112.o
> 
> What about defining CONFIG_AHCI_ICH instead?  It can wait until after
> Kconfig is merged.

Yeah, that's the ultimate solution once we've got Kconfig merged. I
thought this might be a nice intermediate step, but if we want to avoid
code churn, this can indeed wait.

By the way, what's the current status of the Kconfig series? Will there
be another respin soon? ... the next softfreeze is not that far away ...

 Thomas
