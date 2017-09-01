Received: from eggs.gnu.org ([2001:4830:134:3::10]:33596)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1dngWF-0005BH-Aw
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 03:37:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1dngWA-00046e-L7
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 03:37:35 -0400
References: <1499634139-20399-1-git-send-email-eric.auger@redhat.com>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <ef76ffc0-0303-9227-7b05-0325e443819f@redhat.com>
Date: Fri, 1 Sep 2017 09:37:09 +0200
MIME-Version: 1.0
In-Reply-To: <1499634139-20399-1-git-send-email-eric.auger@redhat.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH RESEND v3 0/3] Generic PCIe host bridge
 INTx determination for INTx routing
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: eric.auger.pro@gmail.com, peter.maydell@linaro.org, alex.williamson@redhat.com, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: christoffer.dall@linaro.org, agraf@suse.de, pranavkumar@linaro.org, drjones@redhat.com, wei@redhat.com, Feng Kan <fkan@apm.com>

Hi,

On 09/07/2017 23:02, Eric Auger wrote:
> This series implements INTx to gsi routing for ARM VIRT/Gpex. This is
> a respin of [1] which was lost in limbo.
> 
> ARM virt uses GPEX PCIe bridge. This latter does not implement INTx
> to GSI routing. PCIe/INTx assignment works but the consequence is
> irqfd is not used along with INTx interrupts and VFIO INTx handlers
> are executed on userspace leading to an important performance degradation.
> 
> This issue is witnessed by the following messages;
> 
> qemu-system-aarch64: -device vfio-pci,host=0006:90:00.0: PCI: Bug -
> unimplemented PCI INTx routing (gpex-pcihost)
> qemu-system-aarch64: PCI: Bug - unimplemented PCI INTx routing (gpex-pcihost)
> qemu-system-aarch64: PCI: Bug - unimplemented PCI INTx routing (gpex-pcihost)
> 
> So with this series, irqfd is set up for PCIe/INTx passthrough and we get
> the optimal performance. Also we get rid of the above messages.

If I haven't missed anything, I have not received any comment on this
series despite ping and resend since mid June. Now most of the 2.10 rush
is behind, please can anyone have a look?

The BUG message hits when your assign a PF and performance is largely
decreased whenever INTx are used during passthrough.

Thanks

Eric
> 
> This series can be found at:
> https://github.com/eauger/qemu/tree/v2.9-gpex-intx-v3
> 
> References:
> [1] Generic PCIe host bridge INTx determination for INTx routing
>    https://lists.gnu.org/archive/html/qemu-devel/2015-09/msg04975.html
> 
> 
> Pranavkumar Sawargaonkar (3):
>   hw/pci-host/gpex: Set INTx index/gsi mapping
>   hw/arm/virt: Set INTx/gsi mapping
>   hw/pci-host/gpex: Implement PCI INTx routing
> 
>  hw/arm/virt.c              |  4 ++++
>  hw/pci-host/gpex.c         | 22 ++++++++++++++++++++++
>  include/hw/pci-host/gpex.h |  3 +++
>  3 files changed, 29 insertions(+)
> 
