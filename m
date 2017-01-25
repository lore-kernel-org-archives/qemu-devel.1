Received: from eggs.gnu.org ([2001:4830:134:3::10]:46376)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcel@redhat.com>) id 1cWTH2-0007EF-Ca
	for qemu-devel@nongnu.org; Wed, 25 Jan 2017 14:30:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcel@redhat.com>) id 1cWTGy-0007bu-C3
	for qemu-devel@nongnu.org; Wed, 25 Jan 2017 14:30:28 -0500
Received: from mx1.redhat.com ([209.132.183.28]:60878)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcel@redhat.com>) id 1cWTGy-0007bl-3w
	for qemu-devel@nongnu.org; Wed, 25 Jan 2017 14:30:24 -0500
Received: from int-mx09.intmail.prod.int.phx2.redhat.com
	(int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id F0EA5C04BD24
	for <qemu-devel@nongnu.org>; Wed, 25 Jan 2017 19:30:23 +0000 (UTC)
References: <1485371038-737-1-git-send-email-marcel@redhat.com>
	<20170125211506-mutt-send-email-mst@kernel.org>
From: Marcel Apfelbaum <marcel@redhat.com>
Message-ID: <a9c24d1e-a957-13ac-115f-435aa73d060d@redhat.com>
Date: Wed, 25 Jan 2017 21:30:17 +0200
MIME-Version: 1.0
In-Reply-To: <20170125211506-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH V4 0/3] hw/pcie: Introduce Generic PCI
 Express Root Port
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, abologna@redhat.com

On 01/25/2017 09:15 PM, Michael S. Tsirkin wrote:
> On Wed, Jan 25, 2017 at 09:03:55PM +0200, Marcel Apfelbaum wrote:
>> v3 -> v4:
>>   - Rebased on master.
>
>
> No need for this. Pls check that my pci branch is ok.
>

I see hw/pci-bridge/gen_pcie_root_port.c still uses the macro VMSTATE_PCI=
E_DEVICE
removed by the commit 20daa90 (PCI/migration merge vmstate_pci_device and=
 vmstate_pcie_device),
so it can't work.

I couldn't check the issue because the pci tree compilation fails on:

     qemu/hw/display/qxl.c: In function =91qxl_rom_size=92:
     qemu/hw/display/qxl.c:313:20: error: bit-field =91<anonymous>=92 wid=
th not an integer constant
          QEMU_BUILD_BUG_ON(required_rom_size > rom_size);
                         ^
     qemu/rules.mak:64: recipe for target 'hw/display/qxl.o' failed

Thanks,
Marcel

>
>> v2 -> v3:
>>  - Keep only the root port base class code in pcie_root_port.c (Michae=
l)
>>  - Use msix for the generic root port implementation (Michael and Gerd=
)
>>    - The task required some refactoring like having some common
>>      init/uninit interrupts functions to be implemented by both
>>      generic and Intel Root Ports.
>>
>> v1 -> v2:
>>  - Rebased on master.
>>
>> The Generic Root Port behaves the same as the
>> Intel's IOH device with id 3420, without having
>> Intel specific attributes.
>>
>> The device has two purposes:
>>  (1) Can be used on both X86 and ARM machines.
>>  (2) It will allow us to tweak the behaviour
>>     (e.g add vendor-specific PCI capabilities)
>>      - something that obviously cannot be done
>>        on a known device.
>>
>> Patch 1/3: Introduce a base class for Root Ports - most of the code
>>            is migrated from IOH3420 implementation.
>> Patch 2/3: Derives the IOH3420 from the new base class
>> Patch 3/3: Introduces the generic Root Port.
>>
>> Tested with Linux and Windows guests only on x86 hosts.
>>
>> Marcel Apfelbaum (3):
>>   hw/pcie: Introduce a base class for PCI Express Root Ports
>>   hw/ioh3420: derive from PCI Express Root Port base class
>>   hw/pcie: Introduce Generic PCI Express Root Port
>>
>>  default-configs/arm-softmmu.mak    |   1 +
>>  default-configs/i386-softmmu.mak   |   1 +
>>  default-configs/x86_64-softmmu.mak |   1 +
>>  hw/pci-bridge/Makefile.objs        |   1 +
>>  hw/pci-bridge/gen_pcie_root_port.c |  88 +++++++++++++++++++
>>  hw/pci-bridge/ioh3420.c            | 121 ++++----------------------
>>  hw/pci-bridge/pcie_root_port.c     | 171 ++++++++++++++++++++++++++++=
+++++++++
>>  include/hw/pci/pci.h               |   1 +
>>  include/hw/pci/pcie_port.h         |  19 +++++
>>  9 files changed, 298 insertions(+), 106 deletions(-)
>>  create mode 100644 hw/pci-bridge/gen_pcie_root_port.c
>>  create mode 100644 hw/pci-bridge/pcie_root_port.c
>>
>> --
>> 2.5.5
