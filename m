Received: from eggs.gnu.org ([2001:4830:134:3::10]:37454)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <fkan@apm.com>) id 1dnnC1-0001Ne-Gd
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 10:45:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <fkan@apm.com>) id 1dnnBw-00088M-6M
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 10:45:09 -0400
Received: from mail-wr0-x22d.google.com ([2a00:1450:400c:c0c::22d]:33967)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <fkan@apm.com>) id 1dnnBv-00087E-S0
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 10:45:04 -0400
Received: by mail-wr0-x22d.google.com with SMTP id z91so1189477wrc.1
	for <qemu-devel@nongnu.org>; Fri, 01 Sep 2017 07:45:02 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1499634139-20399-1-git-send-email-eric.auger@redhat.com>
References: <1499634139-20399-1-git-send-email-eric.auger@redhat.com>
From: Feng Kan <fkan@apm.com>
Date: Fri, 1 Sep 2017 07:45:00 -0700
Message-ID: <CAL85gmARf+Mz5-PFHvPXV290umodKD8_6yFABSxc+ghm2iCsGQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
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
To: Auger Eric <eric.auger@redhat.com>
Cc: Alex Williamson <alex.williamson@redhat.com>, qemu-devel@nongnu.org, qemu-arm@nongnu.org, pranavkumar@linaro.org, agraf@suse.de, wei@redhat.com, drjones@redhat.com, peter.maydell@linaro.org, eric.auger.pro@gmail.com, christoffer.dall@linaro.org

On Jul 9, 2017 2:04 PM, "Eric Auger" <eric.auger@redhat.com> wrote:

This series implements INTx to gsi routing for ARM VIRT/Gpex. This is
a respin of [1] which was lost in limbo.

ARM virt uses GPEX PCIe bridge. This latter does not implement INTx
to GSI routing. PCIe/INTx assignment works but the consequence is
irqfd is not used along with INTx interrupts and VFIO INTx handlers
are executed on userspace leading to an important performance degradation.

This issue is witnessed by the following messages;

qemu-system-aarch64: -device vfio-pci,host=0006:90:00.0: PCI: Bug -
unimplemented PCI INTx routing (gpex-pcihost)
qemu-system-aarch64: PCI: Bug - unimplemented PCI INTx routing
(gpex-pcihost)
qemu-system-aarch64: PCI: Bug - unimplemented PCI INTx routing
(gpex-pcihost)

So with this series, irqfd is set up for PCIe/INTx passthrough and we get
the optimal performance. Also we get rid of the above messages.

This series can be found at:
https://github.com/eauger/qemu/tree/v2.9-gpex-intx-v3

References:
[1] Generic PCIe host bridge INTx determination for INTx routing
   https://lists.gnu.org/archive/html/qemu-devel/2015-09/msg04975.html


Pranavkumar Sawargaonkar (3):
  hw/pci-host/gpex: Set INTx index/gsi mapping
  hw/arm/virt: Set INTx/gsi mapping
  hw/pci-host/gpex: Implement PCI INTx routing

 hw/arm/virt.c              |  4 ++++
 hw/pci-host/gpex.c         | 22 ++++++++++++++++++++++
 include/hw/pci-host/gpex.h |  3 +++
 3 files changed, 29 insertions(+)

--
2.5.5

Tested-by: Feng Kan <fkan@apm.com>

Works for APM XGene systems.
Thanks!
