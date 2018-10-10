Received: from eggs.gnu.org ([2001:4830:134:3::10]:59828)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1gA50n-0005Qc-HN
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 23:18:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1gA50i-0005kq-TD
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 23:18:13 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50232)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alex.williamson@redhat.com>)
	id 1gA50i-0005jv-Ky
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 23:18:08 -0400
Date: Tue, 9 Oct 2018 21:18:02 -0600
From: Alex Williamson <alex.williamson@redhat.com>
Message-ID: <20181009211802.531df951@t450s.home>
In-Reply-To: <9BD73EA91F8E404F851CF3F519B14AA80180A6E0@DGGEMI521-MBX.china.huawei.com>
References: <9BD73EA91F8E404F851CF3F519B14AA80180A4A5@DGGEMI521-MBX.china.huawei.com>
	<20181009090801.6f53286d@w520.home>
	<9BD73EA91F8E404F851CF3F519B14AA80180A6E0@DGGEMI521-MBX.china.huawei.com>
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

On Wed, 10 Oct 2018 01:47:10 +0000
"Wuzongyong (Euler Dept)" <cordius.wu@huawei.com> wrote:
> 
> You're right. The initial states are not identical.
> I found the function vfio_pci_pre_reset in qemu.
>     /*
>      * Stop any ongoing DMA by disconecting I/O, MMIO, and bus master.
>      * Also put INTx Disable in known state.
>      */
>     cmd = vfio_pci_read_config(pdev, PCI_COMMAND, 2);
>     cmd &= ~(PCI_COMMAND_IO | PCI_COMMAND_MEMORY | PCI_COMMAND_MASTER |
>              PCI_COMMAND_INTX_DISABLE);
>     vfio_pci_write_config(pdev, PCI_COMMAND, cmd, 2);
> 
> So the behaviors between the two reset are inconsistent.
> 
> Then I wonder whether the operation is necessary here?
> Could I enable the Memory bit in the Command register in vfio_pci_post_reset,
> because I want to write regions of PCI devices after reset.

One reset is done by the kernel to try to put the device into a known
clean state before allowing the user access to it, the other is done by
QEMU as part of the initial machine reset.  I suppose we could special
case the initial machine reset, but it seems perhaps risky and
unnecessary.

QEMU is the driver here, it can certainly enable MMIO on the device and
there are some examples in the QEMU code where MMIO is enabled to
interact with the device, see vfio_radeon_reset() for example.  The
device driver in the guest or the VM firmware should be the one to
enable the device for VM usage though, QEMU should provide the device
to the VM in a power-on default state, or as close as we can reasonably
get to that.  Thanks,

Alex
