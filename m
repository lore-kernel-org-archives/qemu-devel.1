Received: from eggs.gnu.org ([2001:4830:134:3::10]:59255)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcel.apfelbaum@gmail.com>) id 1fvlg7-0007yF-GK
	for qemu-devel@nongnu.org; Fri, 31 Aug 2018 11:49:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcel.apfelbaum@gmail.com>) id 1fvlg4-0005eI-6W
	for qemu-devel@nongnu.org; Fri, 31 Aug 2018 11:49:43 -0400
Received: from mail-wm0-x243.google.com ([2a00:1450:400c:c09::243]:52722)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcel.apfelbaum@gmail.com>)
	id 1fvlg3-0005dt-Vq
	for qemu-devel@nongnu.org; Fri, 31 Aug 2018 11:49:40 -0400
Received: by mail-wm0-x243.google.com with SMTP id y139-v6so5654664wmc.2
	for <qemu-devel@nongnu.org>; Fri, 31 Aug 2018 08:49:38 -0700 (PDT)
References: <20180830105757.10577-1-berrange@redhat.com>
From: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Message-ID: <b9d9e4dd-059c-33c8-cdfc-5c20c2ebab53@gmail.com>
Date: Fri, 31 Aug 2018 18:49:34 +0300
MIME-Version: 1.0
In-Reply-To: <20180830105757.10577-1-berrange@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH] i386: clarify that the Q35 machine type
 implements a P35 chipset
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "=?UTF-8?Q?Daniel_P._Berrang=c3=a9?=" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: Cole Robinson <crobinso@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Laine Stump <laine@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>



On 08/30/2018 01:57 PM, Daniel P. Berrangé wrote:
> The 'q35' machine type implements an Intel Series 3 chipset,
> of which there are several variants:
>
>    https://www.intel.com/Assets/PDF/datasheet/316966.pdf
>
> The key difference between the 82P35 MCH ('p35', PCI device ID 0x29c0)
> and 82Q35 GMCH ('q35', PCI device ID 0x29b0) variants is that the latter
> has an integrated graphics adapter. QEMU does not implement integrated
> graphics, so uses the PCI ID for the 82P35 chipset, despite calling the
> machine type 'q35'. Thus we rename the PCI device ID constant to reflect
> reality, to avoid confusing future developers. The new name more closely
> matches what pci.ids reports it to be:
>
> $ grep  P35 /usr/share/hwdata/pci.ids  | grep 29
> 	29c0  82G33/G31/P35/P31 Express DRAM Controller
> 	29c1  82G33/G31/P35/P31 Express PCI Express Root Port
> 	29c4  82G33/G31/P35/P31 Express MEI Controller
> 	29c5  82G33/G31/P35/P31 Express MEI Controller
> 	29c6  82G33/G31/P35/P31 Express PT IDER Controller
> 	29c7  82G33/G31/P35/P31 Express Serial KT Controller
>
> $ grep  Q35 /usr/share/hwdata/pci.ids  | grep 29
> 	29b0  82Q35 Express DRAM Controller
> 	29b1  82Q35 Express PCI Express Root Port
> 	29b2  82Q35 Express Integrated Graphics Controller
> 	29b3  82Q35 Express Integrated Graphics Controller
> 	29b4  82Q35 Express MEI Controller
> 	29b5  82Q35 Express MEI Controller
> 	29b6  82Q35 Express PT IDER Controller
> 	29b7  82Q35 Express Serial KT Controller
>
> Arguably the QEMU machine type should be named 'p35'. At this point in
> time, however, it is not worth the churn for management applications &
> documentation to worry about renaming it.
>
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>   hw/pci-host/q35.c        | 10 +++++++++-
>   include/hw/pci/pci_ids.h |  2 +-
>   2 files changed, 10 insertions(+), 2 deletions(-)
>
> diff --git a/hw/pci-host/q35.c b/hw/pci-host/q35.c
> index 02f9576588..0a056d6aea 100644
> --- a/hw/pci-host/q35.c
> +++ b/hw/pci-host/q35.c
> @@ -618,7 +618,15 @@ static void mch_class_init(ObjectClass *klass, void *data)
>       dc->desc = "Host bridge";
>       dc->vmsd = &vmstate_mch;
>       k->vendor_id = PCI_VENDOR_ID_INTEL;
> -    k->device_id = PCI_DEVICE_ID_INTEL_Q35_MCH;
> +    /*
> +     * The 'q35' machine type implements an Intel Series 3 chipset,
> +     * of which there are several variants. The key difference between
> +     * the 82P35 MCH ('p35') and 82Q35 GMCH ('q35') variants is that
> +     * the latter has an integrated graphics adapter. QEMU does not
> +     * implement integrated graphics, so uses the PCI ID for the 82P35
> +     * chipset.
> +     */
> +    k->device_id = PCI_DEVICE_ID_INTEL_P35_MCH;
>       k->revision = MCH_HOST_BRIDGE_REVISION_DEFAULT;
>       k->class_id = PCI_CLASS_BRIDGE_HOST;
>       /*
> diff --git a/include/hw/pci/pci_ids.h b/include/hw/pci/pci_ids.h
> index 63acc722a9..eeb33018ad 100644
> --- a/include/hw/pci/pci_ids.h
> +++ b/include/hw/pci/pci_ids.h
> @@ -255,7 +255,7 @@
>   #define PCI_DEVICE_ID_INTEL_82801I_EHCI2 0x293c
>   #define PCI_DEVICE_ID_INTEL_82599_SFP_VF 0x10ed
>   
> -#define PCI_DEVICE_ID_INTEL_Q35_MCH      0x29c0
> +#define PCI_DEVICE_ID_INTEL_P35_MCH      0x29c0
>   
>   #define PCI_VENDOR_ID_XEN                0x5853
>   #define PCI_DEVICE_ID_XEN_PLATFORM       0x0001


Reviewed-by: Marcel Apfelbaum<marcel.apfelbaum@gmail.com>


Thanks,
Marcel
