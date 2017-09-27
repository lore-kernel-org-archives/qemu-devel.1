Received: from eggs.gnu.org ([2001:4830:134:3::10]:53857)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dxFNg-0002Z4-Lp
	for qemu-devel@nongnu.org; Wed, 27 Sep 2017 12:40:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dxFNa-00036b-Ey
	for qemu-devel@nongnu.org; Wed, 27 Sep 2017 12:40:16 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34163)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1dxFNa-00035u-9P
	for qemu-devel@nongnu.org; Wed, 27 Sep 2017 12:40:10 -0400
References: <1506295318-10479-1-git-send-email-zuban32s@gmail.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <c3dd9584-a89e-50b4-4381-ce735376d299@redhat.com>
Date: Wed, 27 Sep 2017 18:40:02 +0200
MIME-Version: 1.0
In-Reply-To: <1506295318-10479-1-git-send-email-zuban32s@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2] hw/pci-bridge/pcie_pci_bridge: properly
 handle MSI unavailability case
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aleksandr Bezzubikov <zuban32s@gmail.com>, qemu-devel@nongnu.org
Cc: marcel@redhat.com, ehabkost@redhat.com, mst@redhat.com

On 25.09.2017 01:21, Aleksandr Bezzubikov wrote:
> QEMU with the pcie-pci-bridge device crashes if the guest board doesn't support MSI,
> e.g. 'qemu-system-ppc64 -M prep -device pcie-pci-bridge'.
> This is caused by wrong pcie-pci-bridge instantiation error handling. This patch fixes this issue
> by falling back to legacy INTx if MSI is not available.
> Also set the bridge's 'msi' property default value to 'auto' in order to trigger errors 
> only when user explicitly set msi=on.
> 
> v2:
> rewrite the commit message
> 
> Reported-by: Eduardo Habkost <ehabkost@redhat.com>
> Signed-off-by: Aleksandr Bezzubikov <zuban32s@gmail.com>
> Reviewed-by: Marcel Apfelbaum <marcel@redhat.com>
> ---
>  hw/pci-bridge/pcie_pci_bridge.c | 24 ++++++++++++++++++------
>  1 file changed, 18 insertions(+), 6 deletions(-)

This also fixes the issue that I've seen with qemu-system-mips64el today:

$ mips64el-softmmu/qemu-system-mips64el -M malta -nographic -S -device
pcie-pci-bridge -bios pc-bios/bios.bin
qemu-system-mips64el: memory.c:1699: memory_region_finalize:
 Assertion `!mr->container' failed.
Aborted (core dumped)

So feel free to add:

Tested-by: Thomas Huth <thuth@redhat.com>
