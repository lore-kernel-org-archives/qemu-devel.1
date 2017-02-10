Received: from eggs.gnu.org ([2001:4830:134:3::10]:39490)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cc17q-0000iH-69
	for qemu-devel@nongnu.org; Thu, 09 Feb 2017 21:39:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cc17h-0007bx-Bk
	for qemu-devel@nongnu.org; Thu, 09 Feb 2017 21:39:49 -0500
Received: from ozlabs.org ([103.22.144.67]:49115)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgibson@ozlabs.org>) id 1cc17g-0007aX-VP
	for qemu-devel@nongnu.org; Thu, 09 Feb 2017 21:39:45 -0500
Date: Fri, 10 Feb 2017 13:33:17 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170210023317.GC27610@umbus.fritz.box>
References: <1486456099-7345-1-git-send-email-peterx@redhat.com>
	<1486456099-7345-14-git-send-email-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="0Zc0bQF+fxzVVQOT"
Content-Disposition: inline
In-Reply-To: <1486456099-7345-14-git-send-email-peterx@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v7 13/17] memory: introduce
 memory_region_notify_one()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, tianyu.lan@intel.com, kevin.tian@intel.com, mst@redhat.com, jan.kiszka@siemens.com, jasowang@redhat.com, alex.williamson@redhat.com, bd.aviv@gmail.com


--0Zc0bQF+fxzVVQOT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 07, 2017 at 04:28:15PM +0800, Peter Xu wrote:
> Generalizing the notify logic in memory_region_notify_iommu() into a
> single function. This can be further used in customized replay()
> functions for IOMMUs.
>=20
> Signed-off-by: Peter Xu <peterx@redhat.com>

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

> ---
>  include/exec/memory.h | 15 +++++++++++++++
>  memory.c              | 40 ++++++++++++++++++++++++----------------
>  2 files changed, 39 insertions(+), 16 deletions(-)
>=20
> diff --git a/include/exec/memory.h b/include/exec/memory.h
> index 606ce88..0767888 100644
> --- a/include/exec/memory.h
> +++ b/include/exec/memory.h
> @@ -682,6 +682,21 @@ void memory_region_notify_iommu(MemoryRegion *mr,
>                                  IOMMUTLBEntry entry);
> =20
>  /**
> + * memory_region_notify_one: notify a change in an IOMMU translation
> + *                           entry to a single notifier
> + *
> + * This works just like memory_region_notify_iommu(), but it only
> + * notifies a specific notifier, not all of them.
> + *
> + * @notifier: the notifier to be notified
> + * @entry: the new entry in the IOMMU translation table.  The entry
> + *         replaces all old entries for the same virtual I/O address ran=
ge.
> + *         Deleted entries have .@perm =3D=3D 0.
> + */
> +void memory_region_notify_one(IOMMUNotifier *notifier,
> +                              IOMMUTLBEntry *entry);
> +
> +/**
>   * memory_region_register_iommu_notifier: register a notifier for change=
s to
>   * IOMMU translation entries.
>   *
> diff --git a/memory.c b/memory.c
> index 9e1bb75..7a4f2f9 100644
> --- a/memory.c
> +++ b/memory.c
> @@ -1666,32 +1666,40 @@ void memory_region_unregister_iommu_notifier(Memo=
ryRegion *mr,
>      memory_region_update_iommu_notify_flags(mr);
>  }
> =20
> -void memory_region_notify_iommu(MemoryRegion *mr,
> -                                IOMMUTLBEntry entry)
> +void memory_region_notify_one(IOMMUNotifier *notifier,
> +                              IOMMUTLBEntry *entry)
>  {
> -    IOMMUNotifier *iommu_notifier;
>      IOMMUNotifierFlag request_flags;
> =20
> -    assert(memory_region_is_iommu(mr));
> +    /*
> +     * Skip the notification if the notification does not overlap
> +     * with registered range.
> +     */
> +    if (notifier->start > entry->iova + entry->addr_mask + 1 ||
> +        notifier->end < entry->iova) {
> +        return;
> +    }
> =20
> -    if (entry.perm & IOMMU_RW) {
> +    if (entry->perm & IOMMU_RW) {
>          request_flags =3D IOMMU_NOTIFIER_MAP;
>      } else {
>          request_flags =3D IOMMU_NOTIFIER_UNMAP;
>      }
> =20
> +    if (notifier->notifier_flags & request_flags) {
> +        notifier->notify(notifier, entry);
> +    }
> +}
> +
> +void memory_region_notify_iommu(MemoryRegion *mr,
> +                                IOMMUTLBEntry entry)
> +{
> +    IOMMUNotifier *iommu_notifier;
> +
> +    assert(memory_region_is_iommu(mr));
> +
>      IOMMU_NOTIFIER_FOREACH(iommu_notifier, mr) {
> -        /*
> -         * Skip the notification if the notification does not overlap
> -         * with registered range.
> -         */
> -        if (iommu_notifier->start > entry.iova + entry.addr_mask + 1 ||
> -            iommu_notifier->end < entry.iova) {
> -            continue;
> -        }
> -        if (iommu_notifier->notifier_flags & request_flags) {
> -            iommu_notifier->notify(iommu_notifier, &entry);
> -        }
> +        memory_region_notify_one(iommu_notifier, &entry);
>      }
>  }
> =20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--0Zc0bQF+fxzVVQOT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJYnSZtAAoJEGw4ysog2bOSr1EP/jCkC7PNfEWAeAw4cVL8TMGH
BWlu+qNOW11xWJsXE82YkQFqD3yj2gHcUeAEyp9Unn+7WczXLfSib/sz6vJk8nXT
5oJTMjSyZuKh1O5z/MH6QaZbVWb8YIDqaP8hSoCoYsZ+b8CWZsTFDI6abuuOXYDG
7b+7j8qkde/4ChAuBMnFjsuszc/86iGpzvWolcJgdIeL/wvDfOZiGgOLV7N36HU3
PfcMewTWxdkJCk+6QL8uc2beZVRd1CnF0BTtVicg/t6DmCUy9md8T12UPvxXS3xL
F1W5DKw/h1ySllhZxps1Pa9Kz8G+gjXHRNSiPuNlE4Z7Ai2DKRAv6GGGyRSmQdpz
+BvcDPvRCQ0BJUVMSxlQjhHvxUrTBdyrvpVzOev52UzBy1svbW8TN42i+d2yRBZc
Ul6ED3Ded/+3nX+bOxuHNHIbaVHZm+8YpJkqSFoRVvLPQGoZk4IfrD0yUjH9xV+Z
eaxsK+Sg54WH6a6LJTVz7sJoiY14Tn4dL69P8OgeMCAbH9P4ywwRHkm93XZgZ6LF
91YW/oIuVvHpOZ3AC+bvq8BZk4oaSon2rKiyz1kJDY0ziAasJSh88vpPvKlIQBkV
X8GrGzkOLK6duCOkiSJe98qNs3As8IkDf7jloPxAgx0NIUI+qleeMmvDcSVUc/O2
vn0W9M9F873Tpj9V46Uo
=9zAf
-----END PGP SIGNATURE-----

--0Zc0bQF+fxzVVQOT--
