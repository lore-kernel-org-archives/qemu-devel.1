Received: from eggs.gnu.org ([2001:4830:134:3::10]:56276)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1eC6Ug-0001Xj-Ov
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 11:12:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1eC6Ud-00059U-JC
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 11:12:54 -0500
Received: from mx1.redhat.com ([209.132.183.28]:60102)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1eC6Ud-00056G-9J
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 11:12:51 -0500
Date: Tue, 7 Nov 2017 18:12:46 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20171107181002-mutt-send-email-mst@kernel.org>
References: <20171106203520.7880-1-michael.nawrocki@gtri.gatech.edu>
	<20171106203520.7880-3-michael.nawrocki@gtri.gatech.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171106203520.7880-3-michael.nawrocki@gtri.gatech.edu>
Subject: Re: [Qemu-devel] [PATCH v2 2/2] Add new PCI ID for i82559a
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mike Nawrocki <michael.nawrocki@gtri.gatech.edu>
Cc: qemu-devel@nongnu.org, jasowang@redhat.com, marcel@redhat.com

On Mon, Nov 06, 2017 at 03:35:20PM -0500, Mike Nawrocki wrote:
> Adds a new PCI ID for the i82559a (0x8086 0x1030) interface. Enables
> this ID with a new property "use-alt-device-id" to preserve
> compatibility.
> 
> Signed-off-by: Mike Nawrocki <michael.nawrocki@gtri.gatech.edu>
> ---
>  hw/net/eepro100.c    | 12 ++++++++++++
>  include/hw/pci/pci.h |  1 +
>  qemu-options.hx      |  2 +-
>  3 files changed, 14 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/net/eepro100.c b/hw/net/eepro100.c
> index 91dd058010..66f2d2b9e7 100644
> --- a/hw/net/eepro100.c
> +++ b/hw/net/eepro100.c
> @@ -132,6 +132,7 @@ typedef struct {
>      const char *name;
>      const char *desc;
>      uint16_t device_id;
> +    uint16_t alt_device_id;
>      uint8_t revision;
>      uint16_t subsystem_vendor_id;
>      uint16_t subsystem_id;
> @@ -276,6 +277,7 @@ typedef struct {
>      /* Quasi static device properties (no need to save them). */
>      uint16_t stats_size;
>      bool has_extended_tcb_support;
> +    bool use_alt_device_id;
>  } EEPRO100State;
>  
>  /* Word indices in EEPROM. */
> @@ -1855,6 +1857,14 @@ static void e100_nic_realize(PCIDevice *pci_dev, Error **errp)
>  
>      TRACE(OTHER, logout("\n"));
>  
> +    /* By default, the i82559a adapter uses the legacy PCI ID (for the
> +     * i82557). This allows the PCI ID to be changed to the alternate
> +     * i82559 ID if needed.
> +     */
> +    if (s->use_alt_device_id) {
> +        pci_config_set_device_id(s->dev.config, info->alt_device_id);
> +    }
> +
>      s->device = info->device;
>  
>      e100_pci_reset(s, &local_err);
> @@ -1974,6 +1984,7 @@ static E100PCIDeviceInfo e100_devices[] = {
>          .desc = "Intel i82559A Ethernet",
>          .device = i82559A,
>          .device_id = PCI_DEVICE_ID_INTEL_82557,
> +        .alt_device_id = PCI_DEVICE_ID_INTEL_82559,
>          .revision = 0x06,
>          .stats_size = 80,
>          .has_extended_tcb_support = true,
> @@ -2067,6 +2078,7 @@ static E100PCIDeviceInfo *eepro100_get_class(EEPRO100State *s)
>  
>  static Property e100_properties[] = {
>      DEFINE_NIC_PROPERTIES(EEPRO100State, conf),
> +    DEFINE_PROP_BOOL("use-alt-device-id", EEPRO100State, use_alt_device_id, 0),

0 -> false

>      DEFINE_PROP_END_OF_LIST(),
>  };
>  

Do I understand it correctly that the only reason we really
want it enabled by default, you only set it to 0 for
compatibility?
If yes there's a way to keep it enabled by default:
- add x- in front of the property, set to true by default,
  then tweak it to false in include/hw/compat.h


> diff --git a/include/hw/pci/pci.h b/include/hw/pci/pci.h
> index 8d02a0a383..f30e2cfb72 100644
> --- a/include/hw/pci/pci.h
> +++ b/include/hw/pci/pci.h
> @@ -70,6 +70,7 @@ extern bool pci_available;
>  /* Intel (0x8086) */
>  #define PCI_DEVICE_ID_INTEL_82551IT      0x1209
>  #define PCI_DEVICE_ID_INTEL_82557        0x1229
> +#define PCI_DEVICE_ID_INTEL_82559        0x1030
>  #define PCI_DEVICE_ID_INTEL_82801IR      0x2922
>  
>  /* Red Hat / Qumranet (for QEMU) -- see pci-ids.txt */
> diff --git a/qemu-options.hx b/qemu-options.hx
> index 3728e9b4dd..a39c7e44b3 100644
> --- a/qemu-options.hx
> +++ b/qemu-options.hx
> @@ -2047,7 +2047,7 @@ that the card should have; this option currently only affects virtio cards; set
>  @var{v} = 0 to disable MSI-X. If no @option{-net} option is specified, a single
>  NIC is created.  QEMU can emulate several different models of network card.
>  Valid values for @var{type} are
> -@code{virtio}, @code{i82551}, @code{i82557b}, @code{i82559er},
> +@code{virtio}, @code{i82551}, @code{i82557b}, @code{i82559a}, @code{i82559er},
>  @code{ne2k_pci}, @code{ne2k_isa}, @code{pcnet}, @code{rtl8139},
>  @code{e1000}, @code{smc91c111}, @code{lance} and @code{mcf_fec}.
>  Not all devices are supported on all targets.  Use @code{-net nic,model=help}
> -- 
> 2.14.2
