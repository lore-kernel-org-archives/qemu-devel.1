Received: from eggs.gnu.org ([2001:4830:134:3::10]:49043)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1e9agq-0005fa-Ul
	for qemu-devel@nongnu.org; Tue, 31 Oct 2017 13:51:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1e9agn-00043w-SN
	for qemu-devel@nongnu.org; Tue, 31 Oct 2017 13:51:05 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35056)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1e9agn-00043K-Jy
	for qemu-devel@nongnu.org; Tue, 31 Oct 2017 13:51:01 -0400
Date: Tue, 31 Oct 2017 17:50:49 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20171031175048.GI4526@work-vm>
References: <20171031155435.4618-1-michael.nawrocki@gtri.gatech.edu>
	<20171031155435.4618-3-michael.nawrocki@gtri.gatech.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171031155435.4618-3-michael.nawrocki@gtri.gatech.edu>
Subject: Re: [Qemu-devel] [PATCH 2/2] Add i82559a eepro100 interface
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mike Nawrocki <michael.nawrocki@gtri.gatech.edu>
Cc: qemu-devel@nongnu.org, marcel@redhat.com, jasowang@redhat.com, mst@redhat.com

* Mike Nawrocki (michael.nawrocki@gtri.gatech.edu) wrote:
> Signed-off-by: Mike Nawrocki <michael.nawrocki@gtri.gatech.edu>
> ---
>  hw/net/eepro100.c    | 2 +-
>  hw/pci/pci.c         | 2 ++
>  include/hw/pci/pci.h | 1 +
>  qemu-options.hx      | 2 +-
>  4 files changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/net/eepro100.c b/hw/net/eepro100.c
> index 91dd058010..2c7c5cdeb9 100644
> --- a/hw/net/eepro100.c
> +++ b/hw/net/eepro100.c
> @@ -1973,7 +1973,7 @@ static E100PCIDeviceInfo e100_devices[] = {
>          .name = "i82559a",
>          .desc = "Intel i82559A Ethernet",
>          .device = i82559A,
> -        .device_id = PCI_DEVICE_ID_INTEL_82557,
> +        .device_id = PCI_DEVICE_ID_INTEL_82559,

Doesn't that break migration/compatibility - if one side suddenly
sees a different device_id ?

Dave

>          .revision = 0x06,
>          .stats_size = 80,
>          .has_extended_tcb_support = true,
> diff --git a/hw/pci/pci.c b/hw/pci/pci.c
> index 5ed3c8dca4..1126ad1eb3 100644
> --- a/hw/pci/pci.c
> +++ b/hw/pci/pci.c
> @@ -1826,6 +1826,7 @@ static const char * const pci_nic_models[] = {
>      "ne2k_pci",
>      "i82551",
>      "i82557b",
> +    "i82559a",
>      "i82559er",
>      "rtl8139",
>      "e1000",
> @@ -1839,6 +1840,7 @@ static const char * const pci_nic_names[] = {
>      "ne2k_pci",
>      "i82551",
>      "i82557b",
> +    "i82559a",
>      "i82559er",
>      "rtl8139",
>      "e1000",
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
> 
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
