Received: from eggs.gnu.org ([2001:4830:134:3::10]:38876)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1ce7CF-000102-G6
	for qemu-devel@nongnu.org; Wed, 15 Feb 2017 16:33:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1ce7CC-00004v-Cn
	for qemu-devel@nongnu.org; Wed, 15 Feb 2017 16:33:07 -0500
Received: from mx1.redhat.com ([209.132.183.28]:54536)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alex.williamson@redhat.com>)
	id 1ce7CC-0008WS-70
	for qemu-devel@nongnu.org; Wed, 15 Feb 2017 16:33:04 -0500
Received: from int-mx09.intmail.prod.int.phx2.redhat.com
	(int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 23E588553C
	for <qemu-devel@nongnu.org>; Wed, 15 Feb 2017 21:33:04 +0000 (UTC)
Date: Wed, 15 Feb 2017 14:33:01 -0700
From: Alex Williamson <alex.williamson@redhat.com>
Message-ID: <20170215143301.363029a2@t450s.home>
In-Reply-To: <1487191768-8489-1-git-send-email-mst@redhat.com>
References: <1487191768-8489-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] pci/pcie: don't assume cap id 0 is reserved
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>

On Wed, 15 Feb 2017 22:49:47 +0200
"Michael S. Tsirkin" <mst@redhat.com> wrote:

> VFIO actually wants to create a capability with ID == 0.
> This is done to make guest drivers skip the given capability.
> pcie_add_capability then trips up on this capability
> when looking for end of capability list.
> 
> To support this use-case, it's easy enough to switch to
> e.g. 0xffffffff for these comparisons - we can be sure
> it will never match a 16-bit capability ID.
> 
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---


Reviewed-by: Alex Williamson <alex.williamson@redhat.com>


>  hw/pci/pcie.c | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)
> 
> diff --git a/hw/pci/pcie.c b/hw/pci/pcie.c
> index cbd4bb4..f4dd177 100644
> --- a/hw/pci/pcie.c
> +++ b/hw/pci/pcie.c
> @@ -610,7 +610,8 @@ bool pcie_cap_is_arifwd_enabled(const PCIDevice *dev)
>   * uint16_t ext_cap_size
>   */
>  
> -static uint16_t pcie_find_capability_list(PCIDevice *dev, uint16_t cap_id,
> +/* Passing a cap_id value > 0xffff will return 0 and put end of list in prev */
> +static uint16_t pcie_find_capability_list(PCIDevice *dev, uint32_t cap_id,
>                                            uint16_t *prev_p)
>  {
>      uint16_t prev = 0;
> @@ -679,9 +680,11 @@ void pcie_add_capability(PCIDevice *dev,
>      } else {
>          uint16_t prev;
>  
> -        /* 0 is reserved cap id. use internally to find the last capability
> -           in the linked list */
> -        next = pcie_find_capability_list(dev, 0, &prev);
> +        /*
> +         * 0xffffffff is not a valid cap id (it's a 16 bit field). use
> +         * internally to find the last capability in the linked list.
> +         */
> +        next = pcie_find_capability_list(dev, 0xffffffff, &prev);
>  
>          assert(prev >= PCI_CONFIG_SPACE_SIZE);
>          assert(next == 0);
