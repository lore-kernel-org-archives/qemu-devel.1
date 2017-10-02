Received: from eggs.gnu.org ([2001:4830:134:3::10]:36064)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1dz8aP-0000c8-Gl
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 17:49:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1dz8aL-0002YS-Ki
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 17:49:13 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37466)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1dz8aL-0002X2-F0
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 17:49:09 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 02C2B81E00
	for <qemu-devel@nongnu.org>; Mon,  2 Oct 2017 21:49:07 +0000 (UTC)
References: <20171002103135.33440-1-marcel@redhat.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <07f7595e-f721-96d9-0d4c-4e2024b09e32@redhat.com>
Date: Mon, 2 Oct 2017 23:49:01 +0200
MIME-Version: 1.0
In-Reply-To: <20171002103135.33440-1-marcel@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] hw/gen_pcie_root_port: properly set
List-Unsubscribe: <https://lists.gnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=unsubscribe>
List-Archive: <http://lists.gnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@gnu.org>
List-Help: <mailto:qemu-devel-request@gnu.org?subject=help>
List-Subscribe: <https://lists.gnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=subscribe>
To: Marcel Apfelbaum <marcel@redhat.com>, qemu-devel@nongnu.org
Cc: mst@redhat.com
List-ID: <qemu-devel.nongnu.org>

On 10/02/17 12:31, Marcel Apfelbaum wrote:
> IO_LIMIT and IO_BASE registers should not be writable if
> gen_pcie_root_port's io-reserve property is set to 0.
> The COMMAND register should have the IO flag read only.
> 
> 
> Signed-off-by: Marcel Apfelbaum <marcel@redhat.com>
> ---
>  hw/pci-bridge/gen_pcie_root_port.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/hw/pci-bridge/gen_pcie_root_port.c b/hw/pci-bridge/gen_pcie_root_port.c
> index ed03ffc764..ad4e6aa7ff 100644
> --- a/hw/pci-bridge/gen_pcie_root_port.c
> +++ b/hw/pci-bridge/gen_pcie_root_port.c
> @@ -85,6 +85,13 @@ static void gen_rp_realize(DeviceState *dev, Error **errp)
>          rpc->parent_class.exit(d);
>          return;
>      }
> +
> +    if (!grp->io_reserve) {
> +        pci_word_test_and_clear_mask(d->wmask + PCI_COMMAND,
> +                                     PCI_COMMAND_IO);
> +        d->wmask[PCI_IO_BASE] = 0;
> +        d->wmask[PCI_IO_LIMIT] = 0;
> +    }
>  }
>  
>  static const VMStateDescription vmstate_rp_dev = {
> 

The patch looks good to me (which doesn't mean much, honestly :) ), but
I think the subject line is truncated. You left off what exactly should
be set properly. (IO base, IO limit, and command registers, presumably.)

Thanks!
Laszlo
