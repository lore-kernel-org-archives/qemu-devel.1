Received: from eggs.gnu.org ([2001:4830:134:3::10]:50351)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=33755ff8a=anthony.perard@citrix.com>)
	id 1dNKTQ-0005vH-OT
	for qemu-devel@nongnu.org; Tue, 20 Jun 2017 10:49:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=33755ff8a=anthony.perard@citrix.com>)
	id 1dNKTM-0003qI-2l
	for qemu-devel@nongnu.org; Tue, 20 Jun 2017 10:49:44 -0400
Received: from smtp02.citrix.com ([66.165.176.63]:36248)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <prvs=33755ff8a=anthony.perard@citrix.com>)
	id 1dNKTL-0003pz-TJ
	for qemu-devel@nongnu.org; Tue, 20 Jun 2017 10:49:40 -0400
Date: Tue, 20 Jun 2017 15:49:33 +0100
From: Anthony PERARD <anthony.perard@citrix.com>
Message-ID: <20170620144933.GB1702@perard.uk.xensource.com>
References: <20170619081945.30001-1-ross.lagerwall@citrix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20170619081945.30001-1-ross.lagerwall@citrix.com>
Subject: Re: [Qemu-devel] [PATCH] xen-platform: Cleanup network
 infrastructure when emulated NICs are unplugged
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Ross Lagerwall <ross.lagerwall@citrix.com>
Cc: qemu-devel@nongnu.org, Stefano Stabellini <sstabellini@kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>

On Mon, Jun 19, 2017 at 09:19:45AM +0100, Ross Lagerwall wrote:
> When the guest unplugs the emulated NICs, call net_cleanup() to cleanup
> the network infrastructure in QEMU as it is not needed anymore. Most
> importantly, this allows the tap interfaces which QEMU holds open to be
> closed and removed.
> 
> Signed-off-by: Ross Lagerwall <ross.lagerwall@citrix.com>
> ---
>  hw/i386/xen/xen_platform.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/hw/i386/xen/xen_platform.c b/hw/i386/xen/xen_platform.c
> index 1419fc9..180abc7 100644
> --- a/hw/i386/xen/xen_platform.c
> +++ b/hw/i386/xen/xen_platform.c
> @@ -105,6 +105,7 @@ static void unplug_nic(PCIBus *b, PCIDevice *d, void *o)
>  static void pci_unplug_nics(PCIBus *bus)
>  {
>      pci_for_each_device(bus, 0, unplug_nic, NULL);
> +    net_cleanup();

This makes QEMU segv when QEMU is shutting down. When net_cleanup() is
called a second time, qemu crash. That probably not a good sign, even if
the guest continue to live after a reboot or a migration.

-- 
Anthony PERARD
