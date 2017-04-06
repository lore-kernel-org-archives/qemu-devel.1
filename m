Received: from eggs.gnu.org ([2001:4830:134:3::10]:49280)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcel@redhat.com>) id 1cw0BM-0000lg-MG
	for qemu-devel@nongnu.org; Thu, 06 Apr 2017 01:42:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcel@redhat.com>) id 1cw0BL-0007G5-28
	for qemu-devel@nongnu.org; Thu, 06 Apr 2017 01:42:08 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38136)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcel@redhat.com>) id 1cw0BK-0007Fk-Sq
	for qemu-devel@nongnu.org; Thu, 06 Apr 2017 01:42:06 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id E0F7A7EBB8
	for <qemu-devel@nongnu.org>; Thu,  6 Apr 2017 05:42:05 +0000 (UTC)
References: <20170405194741.18956-1-eblake@redhat.com>
	<20170405194741.18956-3-eblake@redhat.com>
From: Marcel Apfelbaum <marcel@redhat.com>
Message-ID: <572daf5e-bac0-4e30-9225-72a1a16f48eb@redhat.com>
Date: Thu, 6 Apr 2017 08:42:01 +0300
MIME-Version: 1.0
In-Reply-To: <20170405194741.18956-3-eblake@redhat.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 02/13] pci: Reduce scope of error
 injection
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: armbru@redhat.com, "Michael S. Tsirkin" <mst@redhat.com>

On 04/05/2017 10:47 PM, Eric Blake wrote:
> No one outside of pcie_aer.h was using error injection; mark them
> static for internal use.
>
> Signed-off-by: Eric Blake <eblake@redhat.com>
>
> ---
> v3: new patch, suggested by Markus
> ---
>  include/hw/pci/pcie_aer.h | 4 ----
>  hw/pci/pcie_aer.c         | 4 ++--
>  2 files changed, 2 insertions(+), 6 deletions(-)
>
> diff --git a/include/hw/pci/pcie_aer.h b/include/hw/pci/pcie_aer.h
> index 526802b..729a943 100644
> --- a/include/hw/pci/pcie_aer.h
> +++ b/include/hw/pci/pcie_aer.h
> @@ -100,8 +100,4 @@ void pcie_aer_root_write_config(PCIDevice *dev,
>                                  uint32_t addr, uint32_t val, int len,
>                                  uint32_t root_cmd_prev);
>
> -/* error injection */
> -int pcie_aer_inject_error(PCIDevice *dev, const PCIEAERErr *err);
> -void pcie_aer_msg(PCIDevice *dev, const PCIEAERMsg *msg);
> -
>  #endif /* QEMU_PCIE_AER_H */
> diff --git a/hw/pci/pcie_aer.c b/hw/pci/pcie_aer.c
> index 653af86..828052b 100644
> --- a/hw/pci/pcie_aer.c
> +++ b/hw/pci/pcie_aer.c
> @@ -376,7 +376,7 @@ static void pcie_aer_msg_root_port(PCIDevice *dev, const PCIEAERMsg *msg)
>   *
>   * Walk up the bus tree from the device, propagate the error message.
>   */
> -void pcie_aer_msg(PCIDevice *dev, const PCIEAERMsg *msg)
> +static void pcie_aer_msg(PCIDevice *dev, const PCIEAERMsg *msg)
>  {
>      uint8_t type;
>
> @@ -631,7 +631,7 @@ static bool pcie_aer_inject_uncor_error(PCIEAERInject *inj, bool is_fatal)
>   * Figure 6-2: Flowchart Showing Sequence of Device Error Signaling and Logging
>   *             Operations
>   */
> -int pcie_aer_inject_error(PCIDevice *dev, const PCIEAERErr *err)
> +static int pcie_aer_inject_error(PCIDevice *dev, const PCIEAERErr *err)
>  {
>      uint8_t *aer_cap = NULL;
>      uint16_t devctl = 0;
>


Reviewed-by: Marcel Apfelbaum <marcel@redhat.com>

Thanks,
Marcel
