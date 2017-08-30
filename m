Received: from eggs.gnu.org ([2001:4830:134:3::10]:54348)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dmzbR-00084R-Gt
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 05:48:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dmzbN-0000xn-Rs
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 05:48:05 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52740)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1dmzbN-0000xU-LU
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 05:48:01 -0400
Date: Wed, 30 Aug 2017 11:47:57 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20170830114757.023e58ae.cohuck@redhat.com>
In-Reply-To: <1503907487-2764-2-git-send-email-zyimin@linux.vnet.ibm.com>
References: <1503907487-2764-1-git-send-email-zyimin@linux.vnet.ibm.com>
	<1503907487-2764-2-git-send-email-zyimin@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 1/4] s390x/pci: fixup trap_msix()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Yi Min Zhao <zyimin@linux.vnet.ibm.com>
Cc: qemu-devel@nongnu.org, borntraeger@de.ibm.com, pasic@linux.vnet.ibm.com, pmorel@linux.vnet.ibm.com, agraf@suse.de, richard.henderson@linaro.org

On Mon, 28 Aug 2017 10:04:44 +0200
Yi Min Zhao <zyimin@linux.vnet.ibm.com> wrote:

> The function trap_msix() is to check if pcistg instruction would access
> msix table entries. The correct boundary condition should be
> [table_offset, table_offset+entries*entry_size). But the current
> condition calculated misses the last entry. So let's fixup it.
> 
> Acked-by: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
> Reviewed-by: Pierre Morel <pmorel@linux.vnet.ibm.com>
> Signed-off-by: Yi Min Zhao <zyimin@linux.vnet.ibm.com>
> ---
>  hw/s390x/s390-pci-inst.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/s390x/s390-pci-inst.c b/hw/s390x/s390-pci-inst.c
> index b7beb8c36a..eba9ffb5f2 100644
> --- a/hw/s390x/s390-pci-inst.c
> +++ b/hw/s390x/s390-pci-inst.c
> @@ -440,8 +440,8 @@ static int trap_msix(S390PCIBusDevice *pbdev, uint64_t offset, uint8_t pcias)
>  {
>      if (pbdev->msix.available && pbdev->msix.table_bar == pcias &&
>          offset >= pbdev->msix.table_offset &&
> -        offset <= pbdev->msix.table_offset +
> -                  (pbdev->msix.entries - 1) * PCI_MSIX_ENTRY_SIZE) {
> +        offset < (pbdev->msix.table_offset +
> +                  pbdev->msix.entries * PCI_MSIX_ENTRY_SIZE)) {
>          return 1;
>      } else {
>          return 0;

Added cc:stable and applied to s390-next.
