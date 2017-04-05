Received: from eggs.gnu.org ([2001:4830:134:3::10]:36496)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1cvt2d-0000k8-MD
	for qemu-devel@nongnu.org; Wed, 05 Apr 2017 18:04:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1cvt2a-0003D3-Im
	for qemu-devel@nongnu.org; Wed, 05 Apr 2017 18:04:39 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38322)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1cvt2a-0003Cm-Cp
	for qemu-devel@nongnu.org; Wed, 05 Apr 2017 18:04:36 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 665508046D
	for <qemu-devel@nongnu.org>; Wed,  5 Apr 2017 22:04:35 +0000 (UTC)
Date: Thu, 6 Apr 2017 01:04:32 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20170406010411-mutt-send-email-mst@kernel.org>
References: <20170405194741.18956-1-eblake@redhat.com>
	<20170405194741.18956-3-eblake@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170405194741.18956-3-eblake@redhat.com>
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
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, armbru@redhat.com, Marcel Apfelbaum <marcel@redhat.com>

On Wed, Apr 05, 2017 at 02:47:30PM -0500, Eric Blake wrote:
> No one outside of pcie_aer.h was using error injection; mark them
> static for internal use.
> 
> Signed-off-by: Eric Blake <eblake@redhat.com>


Reviewed-by: Michael S. Tsirkin <mst@redhat.com>

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
> -- 
> 2.9.3
