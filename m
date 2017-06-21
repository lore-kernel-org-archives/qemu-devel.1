Received: from eggs.gnu.org ([2001:4830:134:3::10]:45876)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dNU0h-00081R-Rd
	for qemu-devel@nongnu.org; Tue, 20 Jun 2017 21:00:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dNU0e-0004xv-Oh
	for qemu-devel@nongnu.org; Tue, 20 Jun 2017 21:00:43 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56451)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1dNU0e-0004xk-Bo
	for qemu-devel@nongnu.org; Tue, 20 Jun 2017 21:00:40 -0400
References: <ccd731e5-f128-0493-d12f-72193a39d0f9@ilande.co.uk>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <384e0431-5c29-dee4-a99c-19c350ebba57@redhat.com>
Date: Wed, 21 Jun 2017 03:00:31 +0200
MIME-Version: 1.0
In-Reply-To: <ccd731e5-f128-0493-d12f-72193a39d0f9@ilande.co.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] pci_nic_init_nofail() only works on root PCI buses?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel <qemu-devel@nongnu.org>
Cc: David Gibson <david@gibson.dropbear.id.au>, "Michael S. Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>

On 11.06.2017 17:08, Mark Cave-Ayland wrote:
> Hi all,
> 
> Playing around with trying to set up PCI bridges for sun4u, I noticed
> that I get an assert with the following diff which simply moves the
> default NIC behind a PCI bridge rather than being directly on the root
> PCI bus:
> 
> diff --git a/hw/sparc64/sun4u.c b/hw/sparc64/sun4u.c
> index 69f565d..0b17f2e 100644
> --- a/hw/sparc64/sun4u.c
> +++ b/hw/sparc64/sun4u.c
> @@ -465,7 +465,7 @@ static void sun4uv_init(MemoryRegion *address_space_mem,
>      parallel_hds_isa_init(isa_bus, MAX_PARALLEL_PORTS);
> 
>      for(i = 0; i < nb_nics; i++)
> -        pci_nic_init_nofail(&nd_table[i], pci_bus, "ne2k_pci", NULL);
> +        pci_nic_init_nofail(&nd_table[i], pci_bus3, "ne2k_pci", NULL);
> 
>      ide_drive_get(hd, ARRAY_SIZE(hd));
> 
> 
> $ ./qemu-system-sparc64 -nographic
> qemu-system-sparc64: hw/pci/pci.c:682: pci_get_bus_devfn: Assertion
> `!root->parent_dev' failed.
> Aborted
> 
> Is there any particular reason why the assert() is set to fail if the
> NIC isn't being instantiated on the root PCI bus?

Sounds strange indeed. At least the patch description of the commit that
introduce the assert() says that using anything else seems to be an error:

http://git.qemu.org/?p=qemu.git;a=commitdiff;h=85c6e4fabb4c26e5cd8a0

Not sure whether that's still true nowadays, since that commit is
already 4 years old...

 Thomas
