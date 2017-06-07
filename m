Received: from eggs.gnu.org ([2001:4830:134:3::10]:39975)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dIYBK-00056o-BD
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 06:27:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dIYBG-0006PC-5Y
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 06:27:18 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34036)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1dIYBF-0006P3-Vt
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 06:27:14 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 0E86683F46
	for <qemu-devel@nongnu.org>; Wed,  7 Jun 2017 10:27:13 +0000 (UTC)
Date: Wed, 7 Jun 2017 11:27:06 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170607102705.GA2384@work-vm>
References: <20170607102413.60774-1-marcel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170607102413.60774-1-marcel@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] hw/pcie: fix the generic pcie root port to
 support migration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Marcel Apfelbaum <marcel@redhat.com>
Cc: qemu-devel@nongnu.org, mst@redhat.com

* Marcel Apfelbaum (marcel@redhat.com) wrote:
> Add msix state to pcie-root-ports's vmstate
> in order to support migration.
> 
> Signed-off-by: Marcel Apfelbaum <marcel@redhat.com>
> ---
>  hw/pci-bridge/gen_pcie_root_port.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/hw/pci-bridge/gen_pcie_root_port.c b/hw/pci-bridge/gen_pcie_root_port.c
> index 8ebffa8..d24aa8a 100644
> --- a/hw/pci-bridge/gen_pcie_root_port.c
> +++ b/hw/pci-bridge/gen_pcie_root_port.c
> @@ -54,6 +54,7 @@ static const VMStateDescription vmstate_rp_dev = {
>          VMSTATE_PCI_DEVICE(parent_obj.parent_obj.parent_obj, PCIESlot),
>          VMSTATE_STRUCT(parent_obj.parent_obj.parent_obj.exp.aer_log,
>                         PCIESlot, 0, vmstate_pcie_aer_log, PCIEAERLog),
> +        VMSTATE_MSIX(parent_obj.parent_obj, PCIEPort),

That will cause a failure of migration from/to 2.9.
Doesn't that need to be tied to the machine-type in a subsection?

Dave

>          VMSTATE_END_OF_LIST()
>      }
>  };
> -- 
> 2.9.4
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
