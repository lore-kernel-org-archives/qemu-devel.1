Received: from eggs.gnu.org ([2001:4830:134:3::10]:54242)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eCnrI-0008KD-D7
	for qemu-devel@nongnu.org; Thu, 09 Nov 2017 09:31:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eCnrC-00068c-IL
	for qemu-devel@nongnu.org; Thu, 09 Nov 2017 09:31:08 -0500
Received: from mail-qk0-x241.google.com ([2607:f8b0:400d:c09::241]:43510)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eCnrC-00068V-Cr
	for qemu-devel@nongnu.org; Thu, 09 Nov 2017 09:31:02 -0500
Received: by mail-qk0-x241.google.com with SMTP id 78so7895679qkz.0
	for <qemu-devel@nongnu.org>; Thu, 09 Nov 2017 06:31:02 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <151023266893.360.2441014157612423993@bafd83ae6430>
	<775f71a5-4975-da5f-1e42-c4dfe8f589ef@redhat.com>
	<d7a34a10-ae75-2d75-95b8-581b814b3e22@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <707e2aa1-5e01-ec98-33f0-0a014bcd0623@amsat.org>
Date: Thu, 9 Nov 2017 11:29:54 -0300
MIME-Version: 1.0
In-Reply-To: <d7a34a10-ae75-2d75-95b8-581b814b3e22@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH V4] hw/pcie-pci-bridge: restrict to X86 and
 ARM
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Marcel Apfelbaum <marcel@redhat.com>, Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: cohuck@redhat.com, famz@redhat.com, zuban32s@gmail.com, mst@redhat.com

Hi Marcel,

On 11/09/2017 11:10 AM, Marcel Apfelbaum wrote:
> On 09/11/2017 16:03, Thomas Huth wrote:
>> On 09.11.2017 14:04, no-reply@patchew.org wrote:
>>> Hi,
>>>
>>> This series failed automatic build test. Please find the testing
>>> commands and
>>> their output below. If you have docker installed, you can probably
>>> reproduce it
>>> locally.
>> [...]
>>>    CC      aarch64-softmmu/hw/scsi/virtio-scsi.o
>>>    CC      aarch64-softmmu/hw/scsi/virtio-scsi-dataplane.o
>>> make[1]: *** No rule to make target
>>> `../hw/pci-bridge/pcie_pci_bridge.o', needed by
>>> `qemu-system-x86_64'.  Stop.
>>> make[1]: *** Waiting for unfinished jobs....
>>>    CC      aarch64-softmmu/hw/scsi/vhost-scsi-common.o
>>>    CC      aarch64-softmmu/hw/scsi/vhost-scsi.o
>>>    CC      aarch64-softmmu/hw/scsi/vhost-user-scsi.o
>>>    CC      aarch64-softmmu/hw/sd/omap_mmc.o
>>>    CC      aarch64-softmmu/hw/sd/pxa2xx_mmci.o
>>>    CC      aarch64-softmmu/hw/sd/bcm2835_sdhost.o
>>> make: *** [subdir-x86_64-softmmu] Error 2
>>> make: *** Waiting for unfinished jobs....
>>>    CC      aarch64-softmmu/hw/ssi/omap_spi.o
>>>    CC      aarch64-softmmu/hw/ssi/imx_spi.o
>>>    CC      aarch64-softmmu/hw/timer/exynos4210_mct.o
>>>    CC      aarch64-softmmu/hw/timer/exynos4210_pwm.o
>> [...]
>>>    CC      aarch64-softmmu/hw/timer/exynos4210_rtc.o
>>>    CC      aarch64-softmmu/target/arm/translate-a64.o
>>> make[1]: *** No rule to make target
>>> `../hw/pci-bridge/pcie_pci_bridge.o', needed by
>>> `qemu-system-aarch64'.  Stop.
>>> make[1]: *** Waiting for unfinished
>>> jobs..../tmp/qemu-test/src/target/arm/translate-a64.c: In function
>>> 'handle_shri_with_rndacc':
>>
>> Hmm, looks like this was not working as expected?
>>
> 
> In my workstation works just fine (clean and compiled all archs),
> I sent a mail to Fam.

Applying your patch on v2.11.0-rc0 I also get this:

make[1]: *** No rule to make target
'../hw/pci-bridge/pcie_pci_bridge.o', needed by 'qemu-system-aarch64'.
Stop.
Makefile:383: recipe for target 'subdir-aarch64-softmmu' failed
make: *** [subdir-aarch64-softmmu] Error 2

$ fgrep CONFIG_PCIE config-all-devices.mak
CONFIG_PCIE_PCI_BRIDGE:=$(findstring
y,$(CONFIG_PCIE_PCI_BRIDGE)$(CONFIG_PCIE_PORT))
CONFIG_PCIE_PORT:=$(findstring y,$(CONFIG_PCIE_PORT)y)

$ make subdir-aarch64-softmmu --debug=v 2>/dev/null | fgrep -i
pcie_pci_bridge
Reading makefile '../hw/pci-bridge/pcie_pci_bridge.d' (search path)
(don't care) (no ~ expansion)...
    Considering target file '../hw/pci-bridge/pcie_pci_bridge.o'.
     File '../hw/pci-bridge/pcie_pci_bridge.o' does not exist.
     Finished prerequisites of target file
'../hw/pci-bridge/pcie_pci_bridge.o'.
    Must remake target '../hw/pci-bridge/pcie_pci_bridge.o'.
