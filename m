Received: from eggs.gnu.org ([2001:4830:134:3::10]:48139)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcel@redhat.com>) id 1dc9Je-0002o2-JX
	for qemu-devel@nongnu.org; Mon, 31 Jul 2017 07:56:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcel@redhat.com>) id 1dc9JX-00028O-Mc
	for qemu-devel@nongnu.org; Mon, 31 Jul 2017 07:56:50 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38100)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcel@redhat.com>) id 1dc9JX-00024r-D7
	for qemu-devel@nongnu.org; Mon, 31 Jul 2017 07:56:47 -0400
References: <1501285073-2215-1-git-send-email-zuban32s@gmail.com>
	<1501285073-2215-6-git-send-email-zuban32s@gmail.com>
From: Marcel Apfelbaum <marcel@redhat.com>
Message-ID: <e9c4df63-7b0b-fad1-21fe-258e3d8ae0e7@redhat.com>
Date: Mon, 31 Jul 2017 14:56:33 +0300
MIME-Version: 1.0
In-Reply-To: <1501285073-2215-6-git-send-email-zuban32s@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 5/5] docs: update documentation
 considering PCIE-PCI bridge
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aleksandr Bezzubikov <zuban32s@gmail.com>, qemu-devel@nongnu.org
Cc: mst@redhat.com, kevin@koconnor.net, lersek@redhat.com, seabios@seabios.org, kraxel@redhat.com, imammedo@redhat.com, pbonzini@redhat.com, rth@twiddle.net, ehabkost@redhat.com

On 29/07/2017 2:37, Aleksandr Bezzubikov wrote:
> Signed-off-by: Aleksandr Bezzubikov <zuban32s@gmail.com>
> ---
>   docs/pcie.txt            |  46 ++++++++++--------
>   docs/pcie_pci_bridge.txt | 121 +++++++++++++++++++++++++++++++++++++++++++++++
>   2 files changed, 147 insertions(+), 20 deletions(-)
>   create mode 100644 docs/pcie_pci_bridge.txt
> 
> diff --git a/docs/pcie.txt b/docs/pcie.txt
> index 5bada24..338b50e 100644
> --- a/docs/pcie.txt
> +++ b/docs/pcie.txt
> @@ -46,7 +46,7 @@ Place only the following kinds of devices directly on the Root Complex:
>       (2) PCI Express Root Ports (ioh3420), for starting exclusively PCI Express
>           hierarchies.
>   
> -    (3) DMI-PCI Bridges (i82801b11-bridge), for starting legacy PCI
> +    (3) PCIE-PCI Bridge (pcie-pci-bridge), for starting legacy PCI
>           hierarchies.
>   
>       (4) Extra Root Complexes (pxb-pcie), if multiple PCI Express Root Buses
> @@ -55,18 +55,18 @@ Place only the following kinds of devices directly on the Root Complex:
>      pcie.0 bus
>      ----------------------------------------------------------------------------
>           |                |                    |                  |
> -   -----------   ------------------   ------------------   --------------
> -   | PCI Dev |   | PCIe Root Port |   | DMI-PCI Bridge |   |  pxb-pcie  |
> -   -----------   ------------------   ------------------   --------------
> +   -----------   ------------------   -------------------   --------------
> +   | PCI Dev |   | PCIe Root Port |   | PCIE-PCI Bridge |   |  pxb-pcie  |
> +   -----------   ------------------   -------------------   --------------
>   
>   2.1.1 To plug a device into pcie.0 as a Root Complex Integrated Endpoint use:
>             -device <dev>[,bus=pcie.0]
>   2.1.2 To expose a new PCI Express Root Bus use:
>             -device pxb-pcie,id=pcie.1,bus_nr=x[,numa_node=y][,addr=z]
> -      Only PCI Express Root Ports and DMI-PCI bridges can be connected
> +      Only PCI Express Root Ports, PCIE-PCI bridges and DMI-PCI bridges can be connected
>         to the pcie.1 bus:
>             -device ioh3420,id=root_port1[,bus=pcie.1][,chassis=x][,slot=y][,addr=z]                                     \
> -          -device i82801b11-bridge,id=dmi_pci_bridge1,bus=pcie.1
> +          -device pcie-pci-bridge,id=pcie_pci_bridge1,bus=pcie.1
>   
>   
>   2.2 PCI Express only hierarchy
> @@ -130,21 +130,25 @@ Notes:
>   Legacy PCI devices can be plugged into pcie.0 as Integrated Endpoints,
>   but, as mentioned in section 5, doing so means the legacy PCI
>   device in question will be incapable of hot-unplugging.
> -Besides that use DMI-PCI Bridges (i82801b11-bridge) in combination
> +Besides that use PCIE-PCI Bridges (pcie-pci-bridge) in combination
>   with PCI-PCI Bridges (pci-bridge) to start PCI hierarchies.
> +Instead of the PCIE-PCI Bridge DMI-PCI one can be used,
> +but it doens't support hot-plug, is not crossplatform and since that
> +is obsolete and deprecated. Use the PCIE-PCI Bridge if you're not
> +absolutely sure you need the DMI-PCI Bridge.
>   
> -Prefer flat hierarchies. For most scenarios a single DMI-PCI Bridge
> +Prefer flat hierarchies. For most scenarios a single PCIE-PCI Bridge
>   (having 32 slots) and several PCI-PCI Bridges attached to it
>   (each supporting also 32 slots) will support hundreds of legacy devices.
> -The recommendation is to populate one PCI-PCI Bridge under the DMI-PCI Bridge
> +The recommendation is to populate one PCI-PCI Bridge under the PCIE-PCI Bridge
>   until is full and then plug a new PCI-PCI Bridge...
>   
>      pcie.0 bus
>      ----------------------------------------------
>           |                            |
> -   -----------               ------------------
> -   | PCI Dev |               | DMI-PCI BRIDGE |
> -   ----------                ------------------
> +   -----------               -------------------
> +   | PCI Dev |               | PCIE-PCI BRIDGE |
> +   ----------                -------------------
>                                  |            |
>                     ------------------    ------------------
>                     | PCI-PCI Bridge |    | PCI-PCI Bridge |   ...
> @@ -157,11 +161,11 @@ until is full and then plug a new PCI-PCI Bridge...
>   2.3.1 To plug a PCI device into pcie.0 as an Integrated Endpoint use:
>         -device <dev>[,bus=pcie.0]
>   2.3.2 Plugging a PCI device into a PCI-PCI Bridge:
> -      -device i82801b11-bridge,id=dmi_pci_bridge1[,bus=pcie.0]                        \
> -      -device pci-bridge,id=pci_bridge1,bus=dmi_pci_bridge1[,chassis_nr=x][,addr=y]   \
> +      -device pcie-pci-bridge,id=pcie_pci_bridge1[,bus=pcie.0]                        \
> +      -device pci-bridge,id=pci_bridge1,bus=pcie_pci_bridge1[,chassis_nr=x][,addr=y]   \
>         -device <dev>,bus=pci_bridge1[,addr=x]
>         Note that 'addr' cannot be 0 unless shpc=off parameter is passed to
> -      the PCI Bridge.
> +      the PCI Bridge, and can never be 0 when plugging into the PCIE-PCI Bridge.
>   

A simpler "to the PCI Bridge/PCIe-PCI bridge" finish is enough.

>   3. IO space issues
>   ===================
> @@ -219,25 +223,27 @@ do not support hot-plug, so any devices plugged into Root Complexes
>   cannot be hot-plugged/hot-unplugged:
>       (1) PCI Express Integrated Endpoints
>       (2) PCI Express Root Ports
> -    (3) DMI-PCI Bridges
> +    (3) PCIE-PCI Bridges
>       (4) pxb-pcie
>   
>   Be aware that PCI Express Downstream Ports can't be hot-plugged into
>   an existing PCI Express Upstream Port.
>   
> -PCI devices can be hot-plugged into PCI-PCI Bridges. The PCI hot-plug is ACPI
> -based and can work side by side with the PCI Express native hot-plug.
> +PCI devices can be hot-plugged into PCIE-PCI and PCI-PCI Bridges.
> +The PCI hot-plug into PCI-PCI bridge is ACPI based, whereas hot-plug into
> +PCIE-PCI bridges is SHPC-base. They both can work side by side with the PCI Express native hot-plug.
>   

SHPC-based.

>   PCI Express devices can be natively hot-plugged/hot-unplugged into/from
> -PCI Express Root Ports (and PCI Express Downstream Ports).
> +PCI Express Root Ports (and PCI Express Downstream Ports) and PCIExpress-to-PCI Bridges.
>   

PCI devices can be hot-plugged into PCIe-PCI bridges not
PCI Express devices.

>   5.1 Planning for hot-plug:
>       (1) PCI hierarchy
>           Leave enough PCI-PCI Bridge slots empty or add one
> -        or more empty PCI-PCI Bridges to the DMI-PCI Bridge.
> +        or more empty PCI-PCI Bridges to the PCIE-PCI Bridge.
>   
>           For each such PCI-PCI Bridge the Guest Firmware is expected to reserve
>           4K IO space and 2M MMIO range to be used for all devices behind it.
> +        Appropriate PCI capability is designed, see pcie_pci_bridge.txt.
>   
>           Because of the hard IO limit of around 10 PCI Bridges (~ 40K space)
>           per system don't use more than 9 PCI-PCI Bridges, leaving 4K for the
> diff --git a/docs/pcie_pci_bridge.txt b/docs/pcie_pci_bridge.txt
> new file mode 100644
> index 0000000..ad392ad
> --- /dev/null
> +++ b/docs/pcie_pci_bridge.txt
> @@ -0,0 +1,121 @@
> +Generic PCIExpress-to-PCI Bridge
> +================================
> +
> +Description
> +===========
> +PCIE-to-PCI bridge is a new method for legacy PCI
> +hierarchies creation on Q35 machines.
> +
> +Previously Intel DMI-to-PCI bridge was used for this purpose.
> +But due to its strict limitations - no support of hot-plug,
> +no cross-platform and cross-architecture support - a new generic
> +PCIE-to-PCI bridge should now be used for any legacy PCI device usage
> +with PCI Express machine.
> +
> +This generic PCIE-PCI bridge is a cross-platform device,
> +can be hot-plugged into appropriate root port (requires additional actions,
> +see 'PCIE-PCI bridge hot-plug' section),
> +and supports devices hot-plug into the bridge itself
> +(with some limitations, see below).
> +
> +Hot-plug of legacy PCI devices into the bridge
> +is provided by bridge's built-in Standard hot-plug Controller.
> +Though it still has some limitations, see 'Limitations' below.

Too much "limitations", once is enough.
And is not a limitation, we simply need to enable the feature.
Instead of "limitation" you can say: the feature needs to be
enabled at command line.

> +
> +PCIE-PCI bridge hot-plug
> +=======================
> +As opposed to Windows, Linux guest requires extra efforts to
> +enable PCIE-PCI bridge hot-plug.

Also Windows guest have problems if you have more than one
pcie-pci bridge. Say "Guest OSes"

> +Motivation - now on init any PCI Express root port which doesn't have
> +any device plugged in, has no free buses reserved to provide any of them
> +to a hot-plugged devices in future.
> +
> +To solve this problem we reserve additional buses on a firmware level.
> +Currently only SeaBIOS is supported.
> +The way of bus number to reserve delivery is special
> +Red Hat vendor-specific PCI capability, added to the root port
> +that is planned to have PCIE-PCI bridge hot-plugged in.
> +
> +Capability layout (defined in include/hw/pci/pci_bridge.h):
> +
> +    uint8_t id;     Standard PCI capability header field
> +    uint8_t next;   Standard PCI capability header field
> +    uint8_t len;    Standard PCI vendor-specific capability header field
> +
> +    uint8_t type;   Red Hat vendor-specific capability type
> +                    List of currently existing types:
> +                        QEMU = 1
> +
> +    uint16_t non_pref_16;	Non-prefetchable memory limit
> +
> +    uint8_t bus_res;    Minimum number of buses to reserve
> +
> +    uint8_t io_8;       IO space limit in case of 8-bit value
> +    uint32_t io_32;     IO space limit in case of 32-bit value
> +                        This two values are mutually exclusive,
> +                        i.e. they can't both be  >0.
> +
> +    uint32_t pref_32;   Prefetchable memory limit in case of 32-bit value
> +    uint64_t pref_64;   Prefetchable memory limit in case of 64-bit value
> +                        This two values are mutually exclusive (just as IO limit),
> +                        i.e. they can't both be  >0.
> +
> +Memory limits are unused now, in future they are planned
> +to be used for providing similar hints to the firmware.
> +
> +At the moment this capability is used only in
> +QEMU generic PCIE root port (-device pcie-root-port).
> +Capability construction function takes bus range value
> +from root ports' common property 'bus_reserve'.
> +By default it is set to 0 to leave root port's default
> +behavior unchanged.
> +
> +Usage
> +=====
> +A detailed command line would be:
> +
> +[qemu-bin + storage options]
> +-m 2G
> +-device ioh3420,bus=pcie.0,id=rp1
> +-device ioh3420,bus=pcie.0,id=rp2
> +-device pcie-root-port,bus=pcie.0,id=rp3,bus-reserve=1
> +-device pcie-pci-bridge,id=br1,bus=rp1
> +-device pcie-pci-bridge,id=br2,bus=rp2
> +-device e1000,bus=br1,addr=8
> +
> +Then in monitor it's OK to do:
> +device_add pcie-pci-bridge,id=br3,bus=rp3
> +device_add e1000,bus=br2,addr=1
> +device_add e1000,bus=br3,addr=1
> +
> +Here you have:
> + (1) Cold-plugged:
> +    - Root ports: 1 QEMU generic root port with the capability mentioned above,
> +                  2 ioh3420 root ports;
> +    - 2 PCIE-PCI bridges plugged into 2 different root ports;
> +    - e1000 plugged into the first bridge.
> + (2) Hot-plugged:
> +    - PCIE-PCI bridge, plugged into QEMU generic root port;
> +    - 2 e1000 cards, one plugged into the cold-plugged PCIE-PCI bridge,
> +                     another plugged into the hot-plugged bridge.
> +
> +Limitations
> +===========
> +The PCIE-PCI bridge can be hot-plugged only into pcie-root-port that
> +has proper 'bus_reserve' property value to provide secondary bus for the hot-plugged bridge.
> +
> +Windows 7 and older versions don't support hot-plug devices into the PCIE-PCI bridge.
> +To enable device hot-plug into the bridge on Linux there're 3 ways:
> +1) Build shpchp module with this patch http://www.spinics.net/lists/linux-pci/msg63052.html
> +2) Wait until the kernel patch mentioned above get merged into upstream -
> +    it's expected to happen in 4.14.

I would not add "wait" :), just notice that you build the shpc
module/use IntX until the kernel bug is merged.

> +3) set 'msi_enable' property to false - this forced the bridge to use legacy INTx,
> +    which allows the bridge to notify the OS about hot-plug event without having
> +    BUSMASTER set.
> +
> +Implementation
> +==============
> +The PCIE-PCI bridge is based on PCI-PCI bridge,
> +but also accumulates PCI Express features
> +as a PCI Express device (is_express=1).
> +
> 

Very good description of the device, thanks!
Marcel
