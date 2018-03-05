Received: from eggs.gnu.org ([2001:4830:134:3::10]:51435)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1esgu5-0001OT-8P
	for qemu-devel@nongnu.org; Sun, 04 Mar 2018 22:35:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1esgu3-0004BF-Bw
	for qemu-devel@nongnu.org; Sun, 04 Mar 2018 22:35:09 -0500
Received: from ozlabs.org ([2401:3900:2:1::2]:52565)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgibson@ozlabs.org>) id 1esgu2-0004AW-Lq
	for qemu-devel@nongnu.org; Sun, 04 Mar 2018 22:35:07 -0500
Date: Mon, 5 Mar 2018 14:25:09 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180305032509.GH2650@umbus.fritz.box>
References: <1519900322-30263-1-git-send-email-yi.l.liu@linux.intel.com>
	<1519900322-30263-4-git-send-email-yi.l.liu@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="qVHblb/y9DPlgkHs"
Content-Disposition: inline
In-Reply-To: <1519900322-30263-4-git-send-email-yi.l.liu@linux.intel.com>
Subject: Re: [Qemu-devel] [PATCH v3 03/12] hw/core: introduce
 IOMMUSVAContext for virt-SVA
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Liu, Yi L" <yi.l.liu@linux.intel.com>
Cc: qemu-devel@nongnu.org, mst@redhat.com, pbonzini@redhat.com, alex.williamson@redhat.com, eric.auger.pro@gmail.com


--qVHblb/y9DPlgkHs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 01, 2018 at 06:31:53PM +0800, Liu, Yi L wrote:
> From: Peter Xu <peterx@redhat.com>
>=20
> This patch adds IOMMUSVAContext as an abstract for virt-SVA in
> Qemu.
>=20
> IOMMUSVAContext is per-PASID(Process Address Space Identity).
> A PASID Tagged AddressSpace should have an IOMMUSVAContext
> created for it. virt-SVA emulation for emulated SVA capable
> devices would use IOMMUSVAContext. And for assigned devices,
> Qemu also needs to propagate guest tlb flush to host through
> the sva_notifer based on IOMMUSVAContext.
>=20
> This patch proposes to include a sva_notifier list and
> an IOMMUSVAContextOps in IOMMUSVAContext.
>=20
> * The sva_notifier list would include tlb invalidate nofitifer
>   to propagate guest's iotlb flush to host.
> * The first callback in IOMMUSVAContextOps would be an address
>   translation callback. For the SVA aware DMAs issued by emulated
>   SVA capable devices, it requires Qemu to emulate data read/write
>   to guest process address space. Qemu needs to do address translation
>   with guest process page table. So the IOMMUSVAContextOps.translate()
>   callback would be helpful for emulating SVA capable devices.
>=20
> Note: to fulfill the IOMMUSVAContext based address translation
> framework, may duplicate quite a few existing MemoryRegion based
> translation code in Qemu. As this patchset is mainly to support
> assigned SVA capable devices. So this patchset hasn't done the
> duplication. In future, if any requirement for emulating SVA
> capable device, it would require a separate patchset to fulfill
> the translation framework.
>=20
> Signed-off-by: Peter Xu <peterx@redhat.com>
> Signed-off-by: Liu, Yi L <yi.l.liu@linux.intel.com>
> ---
>  hw/core/Makefile.objs   |   1 +
>  hw/core/pasid.c         |  64 ++++++++++++++++++++++++++++
>  include/hw/core/pasid.h | 110 ++++++++++++++++++++++++++++++++++++++++++=
++++++
>  3 files changed, 175 insertions(+)
>  create mode 100644 hw/core/pasid.c
>  create mode 100644 include/hw/core/pasid.h

[snip]
> +
> +#ifndef HW_PCI_PASID_H
> +#define HW_PCI_PASID_H
> +
> +#include "qemu/queue.h"
> +#ifndef CONFIG_USER_ONLY
> +#include "exec/hwaddr.h"
> +#endif
> +
> +typedef struct IOMMUSVAContext IOMMUSVAContext;
> +
> +enum IOMMUSVAEvent {
> +    IOMMU_SVA_EVENT_TLB_INV,
> +};
> +typedef enum IOMMUSVAEvent IOMMUSVAEvent;
> +
> +struct IOMMUSVAEventData {
> +    IOMMUSVAEvent event;
> +    uint64_t length;
> +    void *data;
> +};
> +typedef struct IOMMUSVAEventData IOMMUSVAEventData;
> +
> +typedef struct IOMMUSVANotifier IOMMUSVANotifier;
> +
> +typedef void (*IOMMUSVANotifyFn)(IOMMUSVANotifier *notifier,
> +                                 IOMMUSVAEventData *event_data);
> +
> +typedef struct IOMMUSVATLBEntry IOMMUSVATLBEntry;
> +
> +/* See address_space_translate: bit 0 is read, bit 1 is write.  */
> +typedef enum {
> +    IOMMU_SVA_NONE =3D 0,
> +    IOMMU_SVA_RO   =3D 1,
> +    IOMMU_SVA_WO   =3D 2,
> +    IOMMU_SVA_RW   =3D 3,
> +} IOMMUSVAAccessFlags;
> +
> +#define IOMMU_SVA_ACCESS_FLAG(r, w) (((r) ? IOMMU_SVA_RO : 0) | \
> +                                     ((w) ? IOMMU_SVA_WO : 0))
> +
> +struct IOMMUSVATLBEntry {
> +    AddressSpace    *target_as;
> +    hwaddr           va;
> +    hwaddr           translated_addr;
> +    hwaddr           addr_mask;  /* 0xfff =3D 4k translation */
> +    IOMMUSVAAccessFlags perm;
> +};
> +
> +typedef struct IOMMUSVAContextOps IOMMUSVAContextOps;
> +struct IOMMUSVAContextOps {
> +    /* Return a TLB entry that contains a given address. */
> +    IOMMUSVATLBEntry (*translate)(IOMMUSVAContext *sva_ctx,
> +                                  hwaddr addr, bool is_write);
> +};

A lot of the above seems to just duplicate stuff from IOMMU MRs and
it's not clear why we need both.

> +struct IOMMUSVANotifier {
> +    IOMMUSVANotifyFn sva_notify;
> +    /*
> +     * What events we are listening to. Let's allow multiple event
> +     * registrations from beginning.
> +     */
> +    IOMMUSVAEvent event;
> +    QLIST_ENTRY(IOMMUSVANotifier) node;
> +};
> +
> +/*
> + * This stands for an IOMMU unit. Any translation device should have
> + * this struct inside its own structure to make sure it can leverage
> + * common IOMMU functionalities.
> + */
> +struct IOMMUSVAContext {
> +    uint32_t pasid;
> +    QLIST_HEAD(, IOMMUSVANotifier) sva_notifiers;
> +    const IOMMUSVAContextOps *sva_ctx_ops;
> +};

I think the problem is here.  The SVAContext represents a *single*
PASID, and once you have a single PASID the resulting object *is*
functionally equivalent to an AddressSpace (though effectively
required to have nothing but a single IOMMUMR within it).

It also seems to me unlikely that different PASIDs for the same device
/ IOMMU domain will have truly different sva_ctx_ops.

It really seems to me the object you actually want is a level up from
that, representing the whole cluster of address spaces indexed by
PASID.  They would have the same operations for all PASIDs in the
cluster, but those would take the pasid number.

> +
> +void iommu_sva_notifier_register(IOMMUSVAContext *sva_ctx,
> +                                 IOMMUSVANotifier *n,
> +                                 IOMMUSVANotifyFn fn,
> +                                 IOMMUSVAEvent event);
> +void iommu_sva_notifier_unregister(IOMMUSVAContext *sva_ctx,
> +                                   IOMMUSVANotifier *notifier);
> +void iommu_sva_notify(IOMMUSVAContext *sva_ctx,
> +                      IOMMUSVAEventData *event_data);
> +
> +void iommu_sva_ctx_init(IOMMUSVAContext *sva_ctx);
> +
> +#endif

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--qVHblb/y9DPlgkHs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlqcuJMACgkQbDjKyiDZ
s5L02w//a7uKod93oU/YmZ040KxwV89G3jcFNVD9oWdJtZIAQinpKCj83ByI1xOb
6OY7HFKu/KXScOwlnLePYC3QTNjesGZ9fgQiDE3ugHY5MabReR5m981TQFk4OuZZ
4b1SbxSKjOECW49byDryTULm0o+fjAlCk40GVL9yqmB6lyUnAFQcxlZFI7qNKuVu
3czSjVHJ70xebQQFYju9egYrjrZxSd2MaFboROBKZhhrzQR8v4aJd8MjSyH05Ymq
RNie+gJMoBBiAPBvAa2WvlrcM0zoRQHE9M3dauGvTjIdArtb3vDk++LiwTMA9UQD
Zh1WXs0Mz050bs+JxDW5s4/Knxa1KFg/izcmAxwLXPSIEx0MGvMFX0kOOohfyMZb
KgqLCYuvpvJQPQtVwTkCPUVf42icYGNhkmyqNL6or4dbRm9rhrfo2eyH0rRXbTdB
P/gGYVZadnP/R8n0dGym5BpLhGdQuWw+vP6/Tmox3LLSQ84fWID7t7tBIaRtbphd
3Oe3agiJd7jO3SgcJgF3/Z1kx8vFJ4XN3RN3CuIzkRcjBjFMVZVja0YWN+wsmi/n
XHJc8z+WnjXBs6MUjLgTIU4HTfZF0xm9lOhg4bnAsS0a344XLJx1UBu6vG3Dta1C
1N1LAG3L35Yi1C6HSxobrTotvBojG4ts7BRqKc14bO4HJ7EW2N4=
=If1U
-----END PGP SIGNATURE-----

--qVHblb/y9DPlgkHs--
