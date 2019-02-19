Received: from eggs.gnu.org ([209.51.188.92]:52420)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gwA4k-0001LV-UN
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 13:25:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gwA4j-0001cg-Vn
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 13:25:02 -0500
References: <1550592459-7286-1-git-send-email-thuth@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <a7eb2932-c72d-f9cf-c3c4-010f967ca743@redhat.com>
Date: Tue, 19 Feb 2019 19:24:40 +0100
MIME-Version: 1.0
In-Reply-To: <1550592459-7286-1-git-send-email-thuth@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] hw/pci/pci-stub: Add msi_enabled() and
 msi_notify() to the pci stubs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-trivial@nongnu.org, yang.zhong@intel.com

On 19/02/19 17:07, Thomas Huth wrote:
> Some machines have an AHCI adapter, but no PCI. To be able to
> compile hw/ide/ahci.c without CONFIG_PCI, we still need the two
> functions msi_enabled() and msi_notify() for linking.
> This is required for the upcoming Kconfig-like build system, if
> a user wants to compile a QEMU binary with just one machine that
> has AHCI, but no PCI, like the ARM "cubieboard" for example.
>=20
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  hw/pci/pci-stub.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>=20
> diff --git a/hw/pci/pci-stub.c b/hw/pci/pci-stub.c
> index b941a0e..c04a5df 100644
> --- a/hw/pci/pci-stub.c
> +++ b/hw/pci/pci-stub.c
> @@ -53,3 +53,14 @@ uint16_t pci_requester_id(PCIDevice *dev)
>      g_assert(false);
>      return 0;
>  }
> +
> +/* Required by ahci.c */
> +bool msi_enabled(const PCIDevice *dev)
> +{
> +    return false;
> +}
> +
> +void msi_notify(PCIDevice *dev, unsigned int vector)
> +{
> +    g_assert_not_reached();
> +}
>=20

Makes sense, but it is also abstraction time. :)  What if instead there
was a function

void msi_allocate_irqs(PCIDevice *pdev, int num, bool fallback_to_intx);

and then ich.c did

    irqs =3D msi_allocate_irqs(pdev, 1, true);
    s->irq =3D irqs[0];
    g_free(irqs);

?  "if msi_enabled raise MSI else raise INTX" is really a common idiom.

Thanks,

Paolo
