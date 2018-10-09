Received: from eggs.gnu.org ([2001:4830:134:3::10]:33867)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1g9tcL-0005JC-2E
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 11:08:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1g9tcG-0004Ez-IA
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 11:08:12 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38742)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alex.williamson@redhat.com>)
	id 1g9tcG-0004DZ-0l
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 11:08:08 -0400
Date: Tue, 9 Oct 2018 09:08:01 -0600
From: Alex Williamson <alex.williamson@redhat.com>
Message-ID: <20181009090801.6f53286d@w520.home>
In-Reply-To: <9BD73EA91F8E404F851CF3F519B14AA80180A4A5@DGGEMI521-MBX.china.huawei.com>
References: <9BD73EA91F8E404F851CF3F519B14AA80180A4A5@DGGEMI521-MBX.china.huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] The results of lspci are inconsistent between vfio
 reset pci devices and reset devices by sysfs interafce
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Wuzongyong (Euler Dept)" <cordius.wu@huawei.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "libvir-list@redhat.com" <libvir-list@redhat.com>, "Chenhaiwu (Euler)" <chenhaiwu1@huawei.com>, "Wanzongshun (Vincent)" <wanzongshun@huawei.com>

On Tue, 9 Oct 2018 12:11:29 +0000
"Wuzongyong (Euler Dept)" <cordius.wu@huawei.com> wrote:

> Hi,
> 
> I start a virtual machine with commandline:
>     /usr/libexec/qemu-kvm --enable-kvm -smp 8 -m 8192 -device vfio-pci,host=0000:81:00.0
> 
> Then I pause the qemu process before executing the main_loop function by gdb.
> At this moment, lspci shows the regions are disabled like below:
>     81:00.0 3D controller: NVIDIA Corporation GP100GL [Tesla P100 PCIe 16GB] (rev a1)
>         Subsystem: NVIDIA Corporation Device 118f
>         Physical Slot: 0-6
>         Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
>         Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
>         Interrupt: pin A routed to IRQ 35
>         NUMA node: 1
>         Region 0: Memory at c8000000 (32-bit, non-prefetchable) [disabled] [size=16M]
>         Region 1: Memory at 27800000000 (64-bit, prefetchable) [disabled] [size=16G]
>         Region 3: Memory at 27c00000000 (64-bit, prefetchable) [disabled] [size=32M]
> 
> But after the command:
> echo 1 > /sys/bus/pci/devices/0000:81:00.0/reset
> lspci shows the regions are *not* disabled:
>     81:00.0 3D controller: NVIDIA Corporation GP100GL [Tesla P100 PCIe 16GB] (rev a1)
>         Subsystem: Huawei Technologies Co., Ltd. Device 2061
>         Physical Slot: 0-6
>         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr+ Stepping- SERR+ FastB2B- DisINTx-
>         Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
>         Latency: 0, Cache Line Size: 32 bytes
>         Interrupt: pin A routed to IRQ 7
>         NUMA node: 1
>         Region 0: Memory at c8000000 (32-bit, non-prefetchable) [size=16M]
>         Region 1: Memory at 27800000000 (64-bit, prefetchable) [size=16G]
>         Region 3: Memory at 27c00000000 (64-bit, prefetchable) [size=32M]
> 
> AFAIK, qemu performs vfio_pci_reset like the below callstack:
>     Qemu:
>         vfio_pci_reset
>             ioctl(vdev->vbasedev.fd, VFIO_DEVICE_RESET)
> Kernel:
>     vfio_pci_ioctl
>         pci_try_reset_function
>             __pci_reset_function_locked
>                     pci_parent_bus_reset
>                         pci_reset_bridge_secondary_bus
> 
> and write 1 to the reset interface of sysfs go through the path:
> Kernel:
>     reset_store
>         pci_reset_function
>             __pci_reset_function_locked
>                     pci_parent_bus_reset
>                         pci_reset_bridge_secondary_bus
> 
> So seem that these two methods are same actually, I am confused why the results are inconsistent.

Maybe there's a misunderstanding here, the kernel PCI reset functions
save and restore config space around the reset.  The intention of the
reset is to re-init the internal state of the device while preserving
(via save+restore) the config space.  The BARs being disabled is simply
a matter of the Memory bit in the Command register being unset (note
Mem-).  Whether this is indicative of some issue depends on whether the
state before reset matches the state after reset, not that the states
after two different paths of triggering a reset are identical.

vfio-pci will hand off the device to the user (QEMU) disabled, so the
states in the first example make sense to me.  In the second case, it's
not clear what the starting state is for the device.  Was this reset
performed from the starting point of the first case or is the device in
some arbitrary, unknown state prior to reset?  Thanks,

Alex
