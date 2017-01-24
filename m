Received: from eggs.gnu.org ([2001:4830:134:3::10]:38961)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1cW3iO-00047W-Vx
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 11:13:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1cW3iL-0008Fy-4y
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 11:13:00 -0500
Received: from mx1.redhat.com ([209.132.183.28]:51292)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lvivier@redhat.com>) id 1cW3iK-0008FU-WC
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 11:12:57 -0500
Received: from int-mx10.intmail.prod.int.phx2.redhat.com
	(int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 013CA7FE96
	for <qemu-devel@nongnu.org>; Tue, 24 Jan 2017 16:12:56 +0000 (UTC)
References: <1484859633-24889-1-git-send-email-mst@redhat.com>
From: Laurent Vivier <lvivier@redhat.com>
Message-ID: <f8cdfb09-b074-ad88-afe7-3d76ad3dcd7e@redhat.com>
Date: Tue, 24 Jan 2017 17:12:52 +0100
MIME-Version: 1.0
In-Reply-To: <1484859633-24889-1-git-send-email-mst@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] pci: mark ROMs read-only
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org
Cc: Marcel Apfelbaum <marcel@redhat.com>

On 19/01/2017 22:00, Michael S. Tsirkin wrote:
> Looks like we didn't mark PCI ROMs as RO allowing
> mischief such as guests writing there.
> Further, e.g. vhost gets confused trying to allocate
> enough space to log writes there. Fix it up.
> 
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>  hw/pci/pci.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/pci/pci.c b/hw/pci/pci.c
> index 637d545..eaac185 100644
> --- a/hw/pci/pci.c
> +++ b/hw/pci/pci.c
> @@ -2199,7 +2199,7 @@ static void pci_add_option_rom(PCIDevice *pdev, bool is_default_rom,
>          snprintf(name, sizeof(name), "%s.rom", object_get_typename(OBJECT(pdev)));
>      }
>      pdev->has_rom = true;
> -    memory_region_init_ram(&pdev->rom, OBJECT(pdev), name, size, &error_fatal);
> +    memory_region_init_rom(&pdev->rom, OBJECT(pdev), name, size, &error_fatal);
>      vmstate_register_ram(&pdev->rom, &pdev->qdev);
>      ptr = memory_region_get_ram_ptr(&pdev->rom);
>      load_image(path, ptr);
> 

Tested-by: Laurent Vivier <lvivier@redhat.com>
