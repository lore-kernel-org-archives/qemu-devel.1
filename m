Received: from eggs.gnu.org ([2001:4830:134:3::10]:56856)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1d2nfb-0003eN-Vr
	for qemu-devel@nongnu.org; Mon, 24 Apr 2017 19:45:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1d2nfY-00047g-3j
	for qemu-devel@nongnu.org; Mon, 24 Apr 2017 19:45:28 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41832)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1d2nfX-00047D-TX
	for qemu-devel@nongnu.org; Mon, 24 Apr 2017 19:45:24 -0400
Date: Tue, 25 Apr 2017 02:45:20 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20170425024324-mutt-send-email-mst@kernel.org>
References: <58FDF9BD.2030100@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <58FDF9BD.2030100@huawei.com>
Subject: Re: [Qemu-devel] [RFC PATCH] pci: deassert intx when pci device
 unrealize
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Herongguang (Stephen)" <herongguang.he@huawei.com>
Cc: marcel@redhat.com, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "wangxinxin.wang@huawei.com >> wangxin (U)" <wangxinxin.wang@huawei.com>

On Mon, Apr 24, 2017 at 09:12:29PM +0800, Herongguang (Stephen) wrote:
> If a pci device is not reset by VM (by writing into config space)
> and unplugged by VM, after that when VM reboots, qemu may assert:
> pcibus_reset: Assertion `bus->irq_count[i] == 0' failed
> 
> Signed-off-by: herongguang <herongguang.he@huawei.com>

Good grief, I can't believe we have had this bug for so long.
Thanks a lot for finding this.

Pls Cc stable on this patch.

> ---
> 
> Is there need to call pci_do_device_reset()?

I don't think so, why?

> ---
>  hw/pci/pci.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/hw/pci/pci.c b/hw/pci/pci.c
> index 259483b..afe6397 100644
> --- a/hw/pci/pci.c
> +++ b/hw/pci/pci.c
> @@ -1078,6 +1078,7 @@ static void pci_qdev_unrealize(DeviceState *dev, Error **errp)
> 
>      pci_unregister_io_regions(pci_dev);
>      pci_del_option_rom(pci_dev);
> +    pci_device_deassert_intx(pci_dev);

I think the right place to call this is after class exit
when we know no one will try to assert the interrupt.

> 
>      if (pc->exit) {
>          pc->exit(pci_dev);
> --
> 1.7.12.4
