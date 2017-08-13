Received: from eggs.gnu.org ([2001:4830:134:3::10]:36911)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcel@redhat.com>) id 1dgqVu-0003kR-E1
	for qemu-devel@nongnu.org; Sun, 13 Aug 2017 06:53:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcel@redhat.com>) id 1dgqVr-0004f4-AN
	for qemu-devel@nongnu.org; Sun, 13 Aug 2017 06:52:58 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45516)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcel@redhat.com>) id 1dgqVr-0004e7-1N
	for qemu-devel@nongnu.org; Sun, 13 Aug 2017 06:52:55 -0400
References: <1502407863-23182-1-git-send-email-zuban32s@gmail.com>
	<1502407863-23182-5-git-send-email-zuban32s@gmail.com>
From: Marcel Apfelbaum <marcel@redhat.com>
Message-ID: <37061c1b-aef8-000a-08a3-de5b2ef09bb3@redhat.com>
Date: Sun, 13 Aug 2017 13:52:46 +0300
MIME-Version: 1.0
In-Reply-To: <1502407863-23182-5-git-send-email-zuban32s@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v5 4/4] docs: update documentation
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
Cc: mst@redhat.com, seabios@seabios.org

On 11/08/2017 2:31, Aleksandr Bezzubikov wrote:
> Signed-off-by: Aleksandr Bezzubikov <zuban32s@gmail.com>
> ---
>   docs/pcie.txt            |  49 ++++++++++----------
>   docs/pcie_pci_bridge.txt | 115 +++++++++++++++++++++++++++++++++++++++++++++++
>   2 files changed, 141 insertions(+), 23 deletions(-)
>   create mode 100644 docs/pcie_pci_bridge.txt
> 
> diff --git a/docs/pcie.txt b/docs/pcie.txt
> index 5bada24..76b85ec 100644
> --- a/docs/pcie.txt
> +++ b/docs/pcie.txt
> @@ -46,7 +46,7 @@ Place only the following kinds of devices directly on the Root Complex:
>       (2) PCI Express Root Ports (ioh3420), for starting exclusively PCI Express
>           hierarchies.
>   
> -    (3) DMI-PCI Bridges (i82801b11-bridge), for starting legacy PCI
> +    (3) PCI Express to PCI Bridge (pcie-pci-bridge), for starting legacy PCI
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
> +   | PCI Dev |   | PCIe Root Port |   | PCIe-PCI Bridge |   |  pxb-pcie  |
> +   -----------   ------------------   -------------------   --------------
>   
>   2.1.1 To plug a device into pcie.0 as a Root Complex Integrated Endpoint use:
>             -device <dev>[,bus=pcie.0]
>   2.1.2 To expose a new PCI Express Root Bus use:
>             -device pxb-pcie,id=pcie.1,bus_nr=x[,numa_node=y][,addr=z]
> -      Only PCI Express Root Ports and DMI-PCI bridges can be connected
> -      to the pcie.1 bus:
> +      PCI Express Root Ports and PCI Express to PCI bridges can be
> +      connected to the pcie.1 bus:
>             -device ioh3420,id=root_port1[,bus=pcie.1][,chassis=x][,slot=y][,addr=z]                                     \
> -          -device i82801b11-bridge,id=dmi_pci_bridge1,bus=pcie.1
> +          -device pcie-pci-bridge,id=pcie_pci_bridge1,bus=pcie.1
>   
>   
>   2.2 PCI Express only hierarchy
> @@ -130,24 +130,24 @@ Notes:
>   Legacy PCI devices can be plugged into pcie.0 as Integrated Endpoints,
>   but, as mentioned in section 5, doing so means the legacy PCI
>   device in question will be incapable of hot-unplugging.
> -Besides that use DMI-PCI Bridges (i82801b11-bridge) in combination
> -with PCI-PCI Bridges (pci-bridge) to start PCI hierarchies.
> +Besides that use PCI Express to PCI Bridges (pcie-pci-bridge) in
> +combination with PCI-PCI Bridges (pci-bridge) to start PCI hierarchies.
>   
> -Prefer flat hierarchies. For most scenarios a single DMI-PCI Bridge
> +Prefer flat hierarchies. For most scenarios a single PCI Express to PCI Bridge
>   (having 32 slots) and several PCI-PCI Bridges attached to it
>   (each supporting also 32 slots) will support hundreds of legacy devices.
> -The recommendation is to populate one PCI-PCI Bridge under the DMI-PCI Bridge
> -until is full and then plug a new PCI-PCI Bridge...
> +The recommendation is to populate one PCI-PCI Bridge under the
> +PCI Express to PCI Bridge until is full and then plug a new PCI-PCI Bridge...
>   
>      pcie.0 bus
>      ----------------------------------------------
>           |                            |
> -   -----------               ------------------
> -   | PCI Dev |               | DMI-PCI BRIDGE |
> -   ----------                ------------------
> +   -----------               -------------------
> +   | PCI Dev |               | PCIe-PCI Bridge |
> +   -----------               -------------------
>                                  |            |
>                     ------------------    ------------------
> -                  | PCI-PCI Bridge |    | PCI-PCI Bridge |   ...
> +                  | PCI-PCI Bridge |    | PCI-PCI Bridge |
>                     ------------------    ------------------
>                                            |           |
>                                     -----------     -----------
> @@ -157,11 +157,11 @@ until is full and then plug a new PCI-PCI Bridge...
>   2.3.1 To plug a PCI device into pcie.0 as an Integrated Endpoint use:
>         -device <dev>[,bus=pcie.0]
>   2.3.2 Plugging a PCI device into a PCI-PCI Bridge:
> -      -device i82801b11-bridge,id=dmi_pci_bridge1[,bus=pcie.0]                        \
> -      -device pci-bridge,id=pci_bridge1,bus=dmi_pci_bridge1[,chassis_nr=x][,addr=y]   \
> +      -device pcie-pci-bridge,id=pcie_pci_bridge1[,bus=pcie.0] \
> +      -device pci-bridge,id=pci_bridge1,bus=pcie_pci_bridge1[,chassis_nr=x][,addr=y] \
>         -device <dev>,bus=pci_bridge1[,addr=x]
>         Note that 'addr' cannot be 0 unless shpc=off parameter is passed to
> -      the PCI Bridge.
> +      the PCI Bridge/PCI Express to PCI Bridge.
>   
>   3. IO space issues
>   ===================
> @@ -219,14 +219,16 @@ do not support hot-plug, so any devices plugged into Root Complexes
>   cannot be hot-plugged/hot-unplugged:
>       (1) PCI Express Integrated Endpoints
>       (2) PCI Express Root Ports
> -    (3) DMI-PCI Bridges
> +    (3) PCI Express to PCI Bridges
>       (4) pxb-pcie
>   
>   Be aware that PCI Express Downstream Ports can't be hot-plugged into
>   an existing PCI Express Upstream Port.
>   
> -PCI devices can be hot-plugged into PCI-PCI Bridges. The PCI hot-plug is ACPI
> -based and can work side by side with the PCI Express native hot-plug.
> +PCI devices can be hot-plugged into PCI Express to PCI and PCI-PCI Bridges.
> +The PCI hot-plug into PCI-PCI bridge is ACPI based, whereas hot-plug into
> +PCI Express to PCI bridges is SHPC-based. They both can work side by side with
> +the PCI Express native hot-plug.
>   
>   PCI Express devices can be natively hot-plugged/hot-unplugged into/from
>   PCI Express Root Ports (and PCI Express Downstream Ports).
> @@ -234,10 +236,11 @@ PCI Express Root Ports (and PCI Express Downstream Ports).
>   5.1 Planning for hot-plug:
>       (1) PCI hierarchy
>           Leave enough PCI-PCI Bridge slots empty or add one
> -        or more empty PCI-PCI Bridges to the DMI-PCI Bridge.
> +        or more empty PCI-PCI Bridges to the PCI Express to PCI Bridge.
>   
>           For each such PCI-PCI Bridge the Guest Firmware is expected to reserve
>           4K IO space and 2M MMIO range to be used for all devices behind it.
> +        Appropriate PCI capability is designed, see pcie_pci_bridge.txt.
>   
>           Because of the hard IO limit of around 10 PCI Bridges (~ 40K space)
>           per system don't use more than 9 PCI-PCI Bridges, leaving 4K for the
> diff --git a/docs/pcie_pci_bridge.txt b/docs/pcie_pci_bridge.txt
> new file mode 100644
> index 0000000..eabac32
> --- /dev/null
> +++ b/docs/pcie_pci_bridge.txt
> @@ -0,0 +1,115 @@
> +Generic PCI Express to PCI Bridge
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
> +Though it still has some limitations, see below.
> +
> +PCIE-PCI bridge hot-plug
> +=======================
> +Guest OSes require extra efforts to enable PCIE-PCI bridge hot-plug.
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
> +                        RESOURCE_RESERVE = 1
> +
> +
> +    uint32_t bus_res;   Minimum number of buses to reserve
> +
> +    uint64_t io;           IO space to reserve
> +    uint32_t mem           Non-prefetchable memory to reserve
> +
> +    This two fields are mutually exclusive:
> +    uint32_t mem_pref_32;  Prefetchable memory to reserve (32-bit MMIO)
> +    uint64_t mem_pref_64;  Prefetchable memory to reserve (64-bit MMIO)
> +
> +If any reservation field is -1 then this kind of reservation is not
> +needed and must be ignored by firmware.
> +
> +mem_pref_* fields mutual exclusiveness means they cannot be -1 both.
> +
> +At the moment this capability is used only in QEMU generic PCIe root port
> +(-device pcie-root-port). Capability construction function takes all reservation
> +fields values from corresponding device properties. By default all of them are
> +set to -1 to leave root port's default behavior unchanged.
> +
> +Usage
> +=====
> +A detailed command line would be:
> +
> +[qemu-bin + storage options] \
> +-m 2G \
> +-device ioh3420,bus=pcie.0,id=rp1 \
> +-device ioh3420,bus=pcie.0,id=rp2 \

Please don't use ioh3420 in examples, we want to eventually
stop using it. Use pcie-root-port instead.

> +-device pcie-root-port,bus=pcie.0,id=rp3,bus-reserve=1 \
> +-device pcie-pci-bridge,id=br1,bus=rp1 \
> +-device pcie-pci-bridge,id=br2,bus=rp2 \
> +-device e1000,bus=br1,addr=8
> +
> +Then in monitor it's OK to execute next commands:
> +device_add pcie-pci-bridge,id=br3,bus=rp3

Please add '\' at the end of the line

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
> +has proper 'bus-reserve' property value to provide secondary bus for the
> +hot-plugged bridge.
> +
> +Windows 7 and older versions don't support hot-plug devices into the PCIE-PCI bridge.
> +To enable device hot-plug into the bridge on Linux there're 3 ways:
> +1) Build shpchp module with this patch http://www.spinics.net/lists/linux-pci/msg63052.html
> +2) Use kernel 4.14+ where the patch mentioned above is already merged.
> +3) Set 'msi' property to off - this forced the bridge to use legacy INTx,
> +    which allows the bridge to notify the OS about hot-plug event without having
> +    BUSMASTER set.
> +
> +Implementation
> +==============
> +The PCIE-PCI bridge is based on PCI-PCI bridge, but also accumulates PCI Express
> +features as a PCI Express device (is_express=1).
> +
> 

After addressing my and Laszlo's comments:
     Reviewed-by: Marcel Apfelbaum <marcel@redhat.com>

Thanks,
Marcel
