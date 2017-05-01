Received: from eggs.gnu.org ([2001:4830:134:3::10]:40224)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1d53Td-00075a-1Q
	for qemu-devel@nongnu.org; Mon, 01 May 2017 01:02:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1d53TZ-0006qh-Uj
	for qemu-devel@nongnu.org; Mon, 01 May 2017 01:02:25 -0400
Received: from ozlabs.org ([103.22.144.67]:60769)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgibson@ozlabs.org>) id 1d53TZ-0006pv-51
	for qemu-devel@nongnu.org; Mon, 01 May 2017 01:02:21 -0400
Date: Mon, 1 May 2017 14:55:36 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170501045536.GK13773@umbus.fritz.box>
References: <1493285660-4470-1-git-send-email-peterx@redhat.com>
	<1493285660-4470-5-git-send-email-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="VSVNCtZB1QZ8vhj+"
Content-Disposition: inline
In-Reply-To: <1493285660-4470-5-git-send-email-peterx@redhat.com>
Subject: Re: [Qemu-devel] [RFC PATCH 4/8] memory: rename *_notify_iommu*
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, tianyu.lan@intel.com, Paolo Bonzini <pbonzini@redhat.com>, kevin.tian@intel.com, yi.l.liu@intel.com, Jason Wang <jasowang@redhat.com>, Alex Williamson <alex.williamson@redhat.com>


--VSVNCtZB1QZ8vhj+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 27, 2017 at 05:34:16PM +0800, Peter Xu wrote:
> Actually it's notifying IOTLB updates (map, or unmap). Let's be explicit
> on the wording - replacing it with *_notify_iotlb*.

I really don't see the distinction here.  This is notifying of a
change in IOMMU mappings.  We use the IOTLBEntry data type to
represent a single mapping.  There need not be an actual IOTLB (in the
sense of a cache backed by a different data structure) in either
hardware or software here.

>=20
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  hw/i386/intel_iommu.c    |  8 ++++----
>  hw/ppc/spapr_iommu.c     |  2 +-
>  hw/s390x/s390-pci-inst.c |  2 +-
>  include/exec/memory.h    | 12 ++++++------
>  memory.c                 |  8 ++++----
>  5 files changed, 16 insertions(+), 16 deletions(-)
>=20
> diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
> index 3306e6a..609732b 100644
> --- a/hw/i386/intel_iommu.c
> +++ b/hw/i386/intel_iommu.c
> @@ -1205,7 +1205,7 @@ static void vtd_iotlb_domain_invalidate(IntelIOMMUS=
tate *s, uint16_t domain_id)
>  static int vtd_page_invalidate_notify_hook(IOMMUTLBEntry *entry,
>                                             void *private)
>  {
> -    memory_region_notify_iommu((MemoryRegion *)private, *entry);
> +    memory_region_notify_iotlb((MemoryRegion *)private, *entry);
>      return 0;
>  }
> =20
> @@ -1709,7 +1709,7 @@ static bool vtd_process_device_iotlb_desc(IntelIOMM=
UState *s,
>      entry.iova =3D addr;
>      entry.perm =3D IOMMU_NONE;
>      entry.translated_addr =3D 0;
> -    memory_region_notify_iommu(&vtd_dev_as->iommu, entry);
> +    memory_region_notify_iotlb(&vtd_dev_as->iommu, entry);
> =20
>  done:
>      return true;
> @@ -2752,7 +2752,7 @@ static void vtd_address_space_unmap(VTDAddressSpace=
 *as, IOMMUMRNotifier *n)
>                               VTD_PCI_FUNC(as->devfn),
>                               entry.iova, size);
> =20
> -    memory_region_notify_one(n, &entry);
> +    memory_region_notify_iotlb_one(n, &entry);
>  }
> =20
>  static void vtd_address_space_unmap_all(IntelIOMMUState *s)
> @@ -2771,7 +2771,7 @@ static void vtd_address_space_unmap_all(IntelIOMMUS=
tate *s)
> =20
>  static int vtd_replay_hook(IOMMUTLBEntry *entry, void *private)
>  {
> -    memory_region_notify_one((IOMMUMRNotifier *)private, entry);
> +    memory_region_notify_iotlb_one((IOMMUMRNotifier *)private, entry);
>      return 0;
>  }
> =20
> diff --git a/hw/ppc/spapr_iommu.c b/hw/ppc/spapr_iommu.c
> index 5e6e70b..9a34495 100644
> --- a/hw/ppc/spapr_iommu.c
> +++ b/hw/ppc/spapr_iommu.c
> @@ -414,7 +414,7 @@ static target_ulong put_tce_emu(sPAPRTCETable *tcet, =
target_ulong ioba,
>      entry.translated_addr =3D tce & page_mask;
>      entry.addr_mask =3D ~page_mask;
>      entry.perm =3D spapr_tce_iommu_access_flags(tce);
> -    memory_region_notify_iommu(&tcet->iommu, entry);
> +    memory_region_notify_iotlb(&tcet->iommu, entry);
> =20
>      return H_SUCCESS;
>  }
> diff --git a/hw/s390x/s390-pci-inst.c b/hw/s390x/s390-pci-inst.c
> index 314a9cb..566eeda 100644
> --- a/hw/s390x/s390-pci-inst.c
> +++ b/hw/s390x/s390-pci-inst.c
> @@ -635,7 +635,7 @@ int rpcit_service_call(S390CPU *cpu, uint8_t r1, uint=
8_t r2)
>              goto out;
>          }
> =20
> -        memory_region_notify_iommu(mr, entry);
> +        memory_region_notify_iotlb(mr, entry);
>          start +=3D entry.addr_mask + 1;
>      }
> =20
> diff --git a/include/exec/memory.h b/include/exec/memory.h
> index 8d8dcb2..09188a6 100644
> --- a/include/exec/memory.h
> +++ b/include/exec/memory.h
> @@ -673,7 +673,7 @@ static inline bool memory_region_is_iommu(MemoryRegio=
n *mr)
>  uint64_t memory_region_iommu_get_min_page_size(MemoryRegion *mr);
> =20
>  /**
> - * memory_region_notify_iommu: notify a change in an IOMMU translation e=
ntry.
> + * memory_region_notify_iotlb: notify a change in an IOMMU translation e=
ntry.
>   *
>   * The notification type will be decided by entry.perm bits:
>   *
> @@ -689,12 +689,12 @@ uint64_t memory_region_iommu_get_min_page_size(Memo=
ryRegion *mr);
>   *         replaces all old entries for the same virtual I/O address ran=
ge.
>   *         Deleted entries have .@perm =3D=3D 0.
>   */
> -void memory_region_notify_iommu(MemoryRegion *mr,
> +void memory_region_notify_iotlb(MemoryRegion *mr,
>                                  IOMMUTLBEntry entry);
> =20
>  /**
> - * memory_region_notify_one: notify a change in an IOMMU translation
> - *                           entry to a single notifier
> + * memory_region_notify_iotlb_one: notify a change in an IOMMU translati=
on
> + *                                 entry to a single notifier
>   *
>   * This works just like memory_region_notify_iommu(), but it only
>   * notifies a specific notifier, not all of them.
> @@ -704,8 +704,8 @@ void memory_region_notify_iommu(MemoryRegion *mr,
>   *         replaces all old entries for the same virtual I/O address ran=
ge.
>   *         Deleted entries have .@perm =3D=3D 0.
>   */
> -void memory_region_notify_one(IOMMUMRNotifier *notifier,
> -                              IOMMUTLBEntry *entry);
> +void memory_region_notify_iotlb_one(IOMMUMRNotifier *notifier,
> +                                    IOMMUTLBEntry *entry);
> =20
>  /**
>   * memory_region_register_iommu_notifier: register a notifier for change=
s to
> diff --git a/memory.c b/memory.c
> index ffbd020..c6532e4 100644
> --- a/memory.c
> +++ b/memory.c
> @@ -1668,8 +1668,8 @@ void memory_region_unregister_iommu_notifier(Memory=
Region *mr,
>      memory_region_update_iommu_notify_flags(mr);
>  }
> =20
> -void memory_region_notify_one(IOMMUMRNotifier *notifier,
> -                              IOMMUTLBEntry *entry)
> +void memory_region_notify_iotlb_one(IOMMUMRNotifier *notifier,
> +                                    IOMMUTLBEntry *entry)
>  {
>      IOMMUMREventFlags request_flags;
> =20
> @@ -1693,7 +1693,7 @@ void memory_region_notify_one(IOMMUMRNotifier *noti=
fier,
>      }
>  }
> =20
> -void memory_region_notify_iommu(MemoryRegion *mr,
> +void memory_region_notify_iotlb(MemoryRegion *mr,
>                                  IOMMUTLBEntry entry)
>  {
>      IOMMUMRNotifier *iommu_notifier;
> @@ -1701,7 +1701,7 @@ void memory_region_notify_iommu(MemoryRegion *mr,
>      assert(memory_region_is_iommu(mr));
> =20
>      IOMMU_NOTIFIER_FOREACH(iommu_notifier, mr) {
> -        memory_region_notify_one(iommu_notifier, &entry);
> +        memory_region_notify_iotlb_one(iommu_notifier, &entry);
>      }
>  }
> =20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--VSVNCtZB1QZ8vhj+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJZBr/IAAoJEGw4ysog2bOSSXEQAOA00uZRiQufuPCiPGJ2XjsZ
oyX1mc/uQQraiBXzojmn6Ow+lmsR4QO2X3A5ZO/wxM2nwLhw6DYO4hLEy1KI5JmS
z7uEDMXuEeEXX8k+NBucn942IxtE7fM8Bd6jddp6eJ1vqVzAVpI9OZrejkNyg2YK
zYD84r0XBdg24ETCLrzXyucOUg8Fh88WQALFiG8FwuGa7pzqoCL1kGF0Y8ErMInP
dQ6YoBwfntdh5fLmC116jn2ol+l1lYeAeBobKQiQcfczNKrjVnqNNiouE8PlD5Xu
nalWjgonnmFzFgQKMFV+2UjiTJOT9SO5mfYTHg+Ig+5qqfBQS2g6owQoIXVNKsoz
on0DoYgY84PSMC6H4Rc8VDP9qbPmmzvfUASxNTUyyI3guc2ctCkMOT6yyh1Yg03r
VqYsJpZ9HhtYsJEWmja10QolT2lU29Jr7ww4+WOhqN0/q5zJklP11KRHvVtvci2D
nqZry9PxC7BI7u9JLD81U0rjUPaVGGFmMdvHrO9S61qpsEcicypEmJsiFkuc4zJO
XWMTf/+H4yNSKUJm6mkeGR8yV2vhQrZR5dNxhSPUSu278nyv8Mra+J6ZCDmMMwKz
DEc8WaDRzN6FlFGc9MzW5VwlPfNIKr7kIsBA37aC7YykAW0QKzTS7HH0ZX3qe3GL
7kX9stuJ/cK1HIX/mA0c
=+wNv
-----END PGP SIGNATURE-----

--VSVNCtZB1QZ8vhj+--
