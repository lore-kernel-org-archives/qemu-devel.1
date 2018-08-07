Received: from eggs.gnu.org ([2001:4830:134:3::10]:38301)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1fn0xn-0000aK-L3
	for qemu-devel@nongnu.org; Tue, 07 Aug 2018 08:19:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1fn0xl-0002sa-Ku
	for qemu-devel@nongnu.org; Tue, 07 Aug 2018 08:19:47 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:38550 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1fn0xl-0002sI-Dp
	for qemu-devel@nongnu.org; Tue, 07 Aug 2018 08:19:45 -0400
References: <1533625449-14989-1-git-send-email-jing2.liu@linux.intel.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <893d9264-7908-4e2c-ae1d-7e46eed6e6a0@redhat.com>
Date: Tue, 7 Aug 2018 14:19:41 +0200
MIME-Version: 1.0
In-Reply-To: <1533625449-14989-1-git-send-email-jing2.liu@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] hw/pci: add pci capability to pci-pci
 bridge
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jing Liu <jing2.liu@linux.intel.com>, qemu-devel@nongnu.org
Cc: anthony.xu@intel.com, mst@redhat.com, marcel.apfelbaum@gmail.com, pbonzini@redhat.com

On 08/07/18 09:04, Jing Liu wrote:
> Add hint to firmware (e.g. SeaBIOS) to reserve addtional
> IO/MEM/PREF spaces for legacy pci-pci bridge, to enable
> some pci devices hotplugging whose IO/MEM/PREF spaces
> requests are larger than the ones in pci-pci bridge set
> by firmware.
> 
> Signed-off-by: Jing Liu <jing2.liu@linux.intel.com>
> ---
>  hw/pci-bridge/pci_bridge_dev.c | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
> 
> diff --git a/hw/pci-bridge/pci_bridge_dev.c b/hw/pci-bridge/pci_bridge_dev.c
> index b2d861d..8e9afbd 100644
> --- a/hw/pci-bridge/pci_bridge_dev.c
> +++ b/hw/pci-bridge/pci_bridge_dev.c
> @@ -46,6 +46,12 @@ struct PCIBridgeDev {
>      uint32_t flags;
>  
>      OnOffAuto msi;
> +
> +    /* additional resources to reserve on firmware init */
> +    uint64_t io_reserve;
> +    uint64_t mem_reserve;
> +    uint64_t pref32_reserve;
> +    uint64_t pref64_reserve;
>  };
>  typedef struct PCIBridgeDev PCIBridgeDev;

(1) Please evaluate the following idea:

- Factor the "bus_reserve", "io_reserve", "mem_reserve",
"pref32_reserve" and "pref64_reserve" fiels of the "GenPCIERootPort"
structure out to another structure.

- I think this new structure type should be defined in
"include/hw/pci/pci_bridge.h", just before the declaration of the
pci_bridge_qemu_reserve_cap_init() function.

- Note that the PCIBridgeQemuCap structure should *not* be modified
(i.e. it should not be rebased to the new sub-structure) -- the fields
are not identical!

- The GenPCIERootPort structure should embed this new sub-structure; the
field name could be "res_reserve".

- The parameter list of pci_bridge_qemu_reserve_cap_init() should be
updated to take a pointer to a constant sub-structure.

- gen_rp_realize() can simply pass &grp->res_reserve.

- gen_rp_props should be updated accordingly. The property names should
stay the same, but they should reference fields of the "res_reserve" field.

(2) Then, in a separate patch, you can add another "res_reserve" field
to "PCIBridgeDev". (As a consequence, "bus_reserve" will also be added,
which I think is the right thing to do.)

(3) There is a class that is derived from TYPE_PCI_BRIDGE_DEV:
TYPE_PCI_BRIDGE_SEAT_DEV. Is it correct to add the new properties /
fields to the latter as well?

>  
> @@ -95,6 +101,13 @@ static void pci_bridge_dev_realize(PCIDevice *dev, Error **errp)
>          error_free(local_err);
>      }
>  
> +    err = pci_bridge_qemu_reserve_cap_init(dev, 0, 0,
> +          bridge_dev->io_reserve, bridge_dev->mem_reserve,
> +          bridge_dev->pref32_reserve, bridge_dev->pref64_reserve, errp);
> +    if (err) {
> +        goto cap_error;
> +    }
> +
>      if (shpc_present(dev)) {
>          /* TODO: spec recommends using 64 bit prefetcheable BAR.
>           * Check whether that works well. */
> @@ -103,6 +116,8 @@ static void pci_bridge_dev_realize(PCIDevice *dev, Error **errp)
>      }
>      return;
>  
> +cap_error:
> +    msi_uninit(dev);

(4) This error handler doesn't look entirely correct; we can reach it
without having initialized MSI. (MSI setup is conditional; and even if
we attempt it, it is permitted to fail with "msi=auto".) Therefore,
msi_uninit() should be wrapped into "if (msi_present())", same as you
see in pci_bridge_dev_exitfn().

>  msi_error:
>      slotid_cap_cleanup(dev);
>  slotid_error:
> @@ -162,6 +177,11 @@ static Property pci_bridge_dev_properties[] = {
>                              ON_OFF_AUTO_AUTO),
>      DEFINE_PROP_BIT(PCI_BRIDGE_DEV_PROP_SHPC, PCIBridgeDev, flags,
>                      PCI_BRIDGE_DEV_F_SHPC_REQ, true),
> +    DEFINE_PROP_SIZE("io-reserve", PCIBridgeDev, io_reserve, -1),
> +    DEFINE_PROP_SIZE("mem-reserve", PCIBridgeDev, mem_reserve, -1),
> +    DEFINE_PROP_SIZE("pref32-reserve", PCIBridgeDev, pref32_reserve, -1),
> +    DEFINE_PROP_SIZE("pref64-reserve", PCIBridgeDev, pref64_reserve, -1),
> +
>      DEFINE_PROP_END_OF_LIST(),
>  };
>  
> 

(5) Similarly to (2), this property list should cover "bus-reserve" too.
If we are exposing the same capability in PCI config space, then I think
we should let the user control all fields of it as well.

(6) Please clarify the capability ID in the subject line of the patch.
For example:

  hw/pci: support resource reservation capability on "pci-bridge"

Thanks
Laszlo
