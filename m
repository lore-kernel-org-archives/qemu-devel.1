Received: from eggs.gnu.org ([2001:4830:134:3::10]:34103)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1eHoDI-0005cO-3X
	for qemu-devel@nongnu.org; Thu, 23 Nov 2017 04:54:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1eHoDE-0001aY-4V
	for qemu-devel@nongnu.org; Thu, 23 Nov 2017 04:54:32 -0500
References: <1511388334-16347-1-git-send-email-pmorel@linux.vnet.ibm.com>
	<1511388334-16347-8-git-send-email-pmorel@linux.vnet.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <deec080f-b03c-85ae-72dd-5704d557cc02@redhat.com>
Date: Thu, 23 Nov 2017 10:54:22 +0100
MIME-Version: 1.0
In-Reply-To: <1511388334-16347-8-git-send-email-pmorel@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 7/7] s390x/pci: search for subregion
 inside the BARs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pierre Morel <pmorel@linux.vnet.ibm.com>, qemu-devel@nongnu.org
Cc: borntraeger@de.ibm.com, pasic@linux.vnet.ibm.com, cohuck@redhat.com, zyimin@linux.vnet.ibm.com, agraf@suse.de, Qemu-s390x list <qemu-s390x@nongnu.org>

On 22.11.2017 23:05, Pierre Morel wrote:
> When dispatching memory access to PCI BAR region, we must
> look for possible subregions, used by the PCI device to map
> different memory areas inside the same PCI BAR.
>=20
> Since the data offset we received is calculated starting at the
> region start address we need to adjust the offset for the subregion.
>=20
> The data offset inside the subregion is calculated by substracting
> the subregion's starting address from the data offset in the region.
>=20
> The access to the MSIX region is now handled in a generic way,
> we do not need the specific trap_msix() function anymore.
>=20
> Signed-off-by: Pierre Morel <pmorel@linux.vnet.ibm.com>
> Reviewed-by: Yi Min Zhao <zyimin@linux.vnet.ibm.com>
> ---
>  hw/s390x/s390-pci-inst.c | 44 +++++++++++++++++++++++++---------------=
----
>  1 file changed, 25 insertions(+), 19 deletions(-)
>=20
> diff --git a/hw/s390x/s390-pci-inst.c b/hw/s390x/s390-pci-inst.c
> index 8d35f8f..fae3ef7 100644
> --- a/hw/s390x/s390-pci-inst.c
> +++ b/hw/s390x/s390-pci-inst.c
> @@ -345,12 +345,31 @@ static int zpci_endian_swap(uint64_t *ptr, uint8_=
t len)
>      return 0;
>  }
> =20
> +static MemoryRegion *s390_get_subregion(MemoryRegion *mr, uint64_t off=
set,
> +                                        uint8_t len)
> +{
> +    MemoryRegion *other;

Just my personal taste, but I'd rather call it "submr" or something simil=
ar.

> +    uint64_t subregion_size;
> +
> +    QTAILQ_FOREACH(other, &mr->subregions, subregions_link) {
> +        subregion_size =3D int128_get64(other->size);
> +        if ((offset >=3D other->addr) &&
> +            (offset + len) <=3D (other->addr + subregion_size)) {

(Too much parentheses for my taste ;-))

> +            mr =3D other;
> +            break;
> +        }
> +    }
> +    return mr;
> +}
> +
>  static MemTxResult zpci_read_bar(S390PCIBusDevice *pbdev, uint8_t pcia=
s,
>                                   uint64_t offset, uint64_t *data, uint=
8_t len)
>  {
>      MemoryRegion *mr;
> =20
>      mr =3D pbdev->pdev->io_regions[pcias].memory;
> +    mr =3D s390_get_subregion(mr, offset, len);
> +    offset -=3D mr->addr;

I'm not that familiar with the MemoryRegion nesting ... So may I ask: Is
that "offset -=3D mr->addr" also right if mr does *not* point to a
sub-region, but to the main memory region? (I.e. is mr->addr =3D=3D 0 in
that case?)

>      return memory_region_dispatch_read(mr, offset, data, len,
>                                         MEMTXATTRS_UNSPECIFIED);
>  }
> @@ -442,30 +461,14 @@ int pcilg_service_call(S390CPU *cpu, uint8_t r1, =
uint8_t r2)
>      return 0;
>  }
> =20
> -static int trap_msix(S390PCIBusDevice *pbdev, uint64_t offset, uint8_t=
 pcias)
> -{
> -    if (pbdev->msix.available && pbdev->msix.table_bar =3D=3D pcias &&
> -        offset >=3D pbdev->msix.table_offset &&
> -        offset < (pbdev->msix.table_offset +
> -                  pbdev->msix.entries * PCI_MSIX_ENTRY_SIZE)) {
> -        return 1;
> -    } else {
> -        return 0;
> -    }
> -}
> -
>  static MemTxResult zpci_write_bar(S390PCIBusDevice *pbdev, uint8_t pci=
as,
>                                    uint64_t offset, uint64_t data, uint=
8_t len)
>  {
>      MemoryRegion *mr;
> =20
> -    if (trap_msix(pbdev, offset, pcias)) {
> -        offset =3D offset - pbdev->msix.table_offset;
> -        mr =3D &pbdev->pdev->msix_table_mmio;
> -    } else {
> -        mr =3D pbdev->pdev->io_regions[pcias].memory;
> -    }
> -
> +    mr =3D pbdev->pdev->io_regions[pcias].memory;
> +    mr =3D s390_get_subregion(mr, offset, len);
> +    offset -=3D mr->addr;
>      return memory_region_dispatch_write(mr, offset, data, len,
>                                          MEMTXATTRS_UNSPECIFIED);
>  }
> @@ -726,6 +729,9 @@ int pcistb_service_call(S390CPU *cpu, uint8_t r1, u=
int8_t r3, uint64_t gaddr,
>      }
> =20
>      mr =3D pbdev->pdev->io_regions[pcias].memory;

Since this above line is done right before all calls to
s390_get_subregion(), you could maybe move it into that function, too.
(and rather call the function sth. like pci_mem_get_subregion() instead?)

> +    mr =3D s390_get_subregion(mr, offset, len);
> +    offset -=3D mr->addr;
> +
>      if (!memory_region_access_valid(mr, offset, len, true)) {
>          program_interrupt(env, PGM_OPERAND, 6);
>          return 0;
>=20

 Thomas
