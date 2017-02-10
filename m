Received: from eggs.gnu.org ([2001:4830:134:3::10]:36356)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cc0ra-00065P-Bp
	for qemu-devel@nongnu.org; Thu, 09 Feb 2017 21:23:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cc0rZ-00024c-2z
	for qemu-devel@nongnu.org; Thu, 09 Feb 2017 21:23:06 -0500
Received: from ozlabs.org ([2401:3900:2:1::2]:51499)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgibson@ozlabs.org>) id 1cc0rY-00022v-Lj
	for qemu-devel@nongnu.org; Thu, 09 Feb 2017 21:23:05 -0500
Date: Fri, 10 Feb 2017 12:14:18 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170210011418.GS27610@umbus.fritz.box>
References: <1486456099-7345-1-git-send-email-peterx@redhat.com>
	<1486456099-7345-5-git-send-email-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="R0KbGFzrRdaLlFh/"
Content-Disposition: inline
In-Reply-To: <1486456099-7345-5-git-send-email-peterx@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v7 04/17] intel_iommu: add "caching-mode"
 option
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


--R0KbGFzrRdaLlFh/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 07, 2017 at 04:28:06PM +0800, Peter Xu wrote:
> From: Aviv Ben-David <bd.aviv@gmail.com>
>=20
> This capability asks the guest to invalidate cache before each map operat=
ion.
> We can use this invalidation to trap map operations in the hypervisor.
>=20
> Signed-off-by: Aviv Ben-David <bd.aviv@gmail.com>
> [peterx: using "caching-mode" instead of "cache-mode" to align with spec]
> [peterx: re-write the subject to make it short and clear]
> Reviewed-by: Jason Wang <jasowang@redhat.com>
> Signed-off-by: Peter Xu <peterx@redhat.com>

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

> ---
>  hw/i386/intel_iommu.c          | 5 +++++
>  hw/i386/intel_iommu_internal.h | 1 +
>  include/hw/i386/intel_iommu.h  | 2 ++
>  3 files changed, 8 insertions(+)
>=20
> diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
> index 3270fb9..50251c3 100644
> --- a/hw/i386/intel_iommu.c
> +++ b/hw/i386/intel_iommu.c
> @@ -2115,6 +2115,7 @@ static Property vtd_properties[] =3D {
>      DEFINE_PROP_ON_OFF_AUTO("eim", IntelIOMMUState, intr_eim,
>                              ON_OFF_AUTO_AUTO),
>      DEFINE_PROP_BOOL("x-buggy-eim", IntelIOMMUState, buggy_eim, false),
> +    DEFINE_PROP_BOOL("caching-mode", IntelIOMMUState, caching_mode, FALS=
E),
>      DEFINE_PROP_END_OF_LIST(),
>  };
> =20
> @@ -2496,6 +2497,10 @@ static void vtd_init(IntelIOMMUState *s)
>          s->ecap |=3D VTD_ECAP_DT;
>      }
> =20
> +    if (s->caching_mode) {
> +        s->cap |=3D VTD_CAP_CM;
> +    }
> +
>      vtd_reset_context_cache(s);
>      vtd_reset_iotlb(s);
> =20
> diff --git a/hw/i386/intel_iommu_internal.h b/hw/i386/intel_iommu_interna=
l.h
> index 356f188..4104121 100644
> --- a/hw/i386/intel_iommu_internal.h
> +++ b/hw/i386/intel_iommu_internal.h
> @@ -202,6 +202,7 @@
>  #define VTD_CAP_MAMV                (VTD_MAMV << 48)
>  #define VTD_CAP_PSI                 (1ULL << 39)
>  #define VTD_CAP_SLLPS               ((1ULL << 34) | (1ULL << 35))
> +#define VTD_CAP_CM                  (1ULL << 7)
> =20
>  /* Supported Adjusted Guest Address Widths */
>  #define VTD_CAP_SAGAW_SHIFT         8
> diff --git a/include/hw/i386/intel_iommu.h b/include/hw/i386/intel_iommu.h
> index 405c9d1..fe645aa 100644
> --- a/include/hw/i386/intel_iommu.h
> +++ b/include/hw/i386/intel_iommu.h
> @@ -257,6 +257,8 @@ struct IntelIOMMUState {
>      uint8_t womask[DMAR_REG_SIZE];  /* WO (write only - read returns 0) =
*/
>      uint32_t version;
> =20
> +    bool caching_mode;          /* RO - is cap CM enabled? */
> +
>      dma_addr_t root;                /* Current root table pointer */
>      bool root_extended;             /* Type of root table (extended or n=
ot) */
>      bool dmar_enabled;              /* Set if DMA remapping is enabled */

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--R0KbGFzrRdaLlFh/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJYnRPqAAoJEGw4ysog2bOSmYgP/3uQIdJJjivPPDUAOYFaIBd2
LK5R8UnMox2QNkCAxjobJMEMIXBg+n+dcfLgt2ElN7Fl30mG86MpQDeGexYECJyx
4+AiUBRU7NwJwlBizV8Dz4UpUoqXGIeiDfUSrSbkyWBpTR1unuKWD0TUUro1PWNt
lVybq3bmEQAidXcuADtYqiCTresbSOs/q6p4NhKKOynKqlziLTkzbzuxYcA+R2Kn
OW2MsNFmmmZJ1I6EUTB5eTgNvfYto5V++Zk9pSMHsR7ptWQe2Afa0Thw/ioNP8yv
YodBL8FEc2xvmT1tB3NPNTvuoJUDpNy5BP+hFTIpMnTm3cHA5wHvNsqjZxgLSDos
UfSxTMZEBZ2eeceiPjmDGkV1QXQrAb4qMlbLfI21O6uYdXmGccrlmm7bMWrqGSQZ
b3jYuktOybweAX2IPr/4ZQuj7akgb6Ou9Bz6Z4oAx1aVVAeGx8iXDzzOULpmJf2e
7C4Qcx1Sr6Zk7pxPcNSkghofJqwqQRB8imCe0qqiiTobZlTVQ8/f42DgluKgVwpU
N5hLWChvuQESCnwzCKMz+rF8kGwIwnfTijEQK4zzgP91AWDoYT9CeNCLFQhgkxRX
Pmz61dhKxkuq0yLFczC50F2RD8kZZXYQZcd7iBoEtQMNCpOO7D+QmJtCvQcdVjer
fHUetIASWl6tDAQ+V8rn
=alcg
-----END PGP SIGNATURE-----

--R0KbGFzrRdaLlFh/--
