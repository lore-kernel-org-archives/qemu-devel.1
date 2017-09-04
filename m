Received: from eggs.gnu.org ([208.118.235.92]:60687)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dojHP-0003a8-V5
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 00:49:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dojGL-0002Dx-VG
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 00:46:35 -0400
Date: Mon, 4 Sep 2017 14:29:45 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170904042945.GA2735@umbus.fritz.box>
References: <1504099475-241036-1-git-send-email-imammedo@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="IS0zKkzwUGydFO0o"
Content-Disposition: inline
In-Reply-To: <1504099475-241036-1-git-send-email-imammedo@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 0/8] ppc: cpu_model handling cleanups
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: qemu-devel@nongnu.org, Alexander Graf <agraf@suse.de>, qemu-ppc@nongnu.org


--IS0zKkzwUGydFO0o
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 30, 2017 at 03:24:27PM +0200, Igor Mammedov wrote:
>=20
> Changelog since v1:
>   - normalize all cpu model names to lower-case
>   - check that all cpu model string is consumed
>     before going to PVR lookup path
>   - add a new optional patch to remove unused junk
>      '[PATCH v2 8/8] ppc: remove non implemented cpu models'
>   - pull in dependency patch from
>       https://lists.gnu.org/archive/html/qemu-devel/2017-08/msg03364.html
>       'ppc: replace cpu_ppc_init() with cpu_generic_init()'
>     so this series won't depend unnecessarily on another series
>=20
> While removing cpu_init() tree-wide, I've stumbled uppon
> PPC way of parsing cpu_model which looked way too complex
> compared to other targets.
>=20
> So here goes cleanups that instead of current inconsistent
> way of dealing with cpu models
>  - mix of case-(in)sensetive lookups and cpu model names
>  - aliases pointing to another aliases
> normalize cpu model names to upper-case and make aliases
> point to cpu moldel names. These changes allow to simplify
> cpu model handling quite a bit and make it look/behave
> a bit more in line with other targets.
> =20
> Patches are not must have for cpu_init() removal but make
> it a little bit easier without need to deal with way of
> conversion of cpu model to cpu type, so pls consider
> merging it early once 2.11 merge window is open if
> patches make any sense.

Patches 1..7 applied to ppc-for-2.11.  Still reading the thread of
comments on patch 8.

>=20
>=20
> repo for testing:
>   https://github.com/imammedo/qemu.git ppc_cpu_model_cleanups_V2
>=20
> CC: David Gibson <david@gibson.dropbear.id.au>
> CC: Alexander Graf <agraf@suse.de>
> CC: qemu-ppc@nongnu.org
>=20
> Igor Mammedov (8):
>   ppc: replace cpu_ppc_init() with cpu_generic_init()
>   ppc: use macros to make cpu type name from string literal
>   ppc: make cpu_model translation to type consistent
>   ppc: make cpu alias point only to real cpu models
>   ppc: replace inter-function cyclic dependency/recurssion with 2 simple
>     lookups
>   ppc: simplify cpu model lookup by PVR
>   ppc: drop caching ObjectClass from PowerPCCPUAlias
>   ppc: remove non implemented cpu models
>=20
>  target/ppc/cpu-models.h     |    3 +-
>  target/ppc/cpu.h            |    6 +-
>  target/ppc/kvm_ppc.h        |    2 +-
>  hw/ppc/e500.c               |    3 +-
>  hw/ppc/mac_newworld.c       |    3 +-
>  hw/ppc/mac_oldworld.c       |    3 +-
>  hw/ppc/ppc440_bamboo.c      |    2 +-
>  hw/ppc/ppc4xx_devs.c        |    2 +-
>  hw/ppc/prep.c               |    5 +-
>  hw/ppc/spapr_cpu_core.c     |   24 +-
>  hw/ppc/virtex_ml507.c       |    2 +-
>  target/ppc/cpu-models.c     | 1023 ++++++++++++-------------------------=
------
>  target/ppc/kvm.c            |    5 +-
>  target/ppc/translate_init.c |  105 ++---
>  14 files changed, 344 insertions(+), 844 deletions(-)
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--IS0zKkzwUGydFO0o
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlms1rYACgkQbDjKyiDZ
s5Jyyw/+LvFaj1SSYuAk4ZgZiMbPDNrluwHdLNj/xEk61xiG5kTr8X5LRpG6Hj6A
fSFh4FUkB0RMtFtYIUcwGBmqE976mUsmGoykqv60FDEaAx2+iDEfjGt+mzWBn5qf
9E5qS8QBrbTAYh2u9YwLz+jM8eC4wHg+Wqsuejb0NOj2FxuO2s+O6YNVK8jSQLiW
HXLhj0MTyIxPkA2aYfjpLQx6deRK9ijxA5vSurZESZKx3mohiaHPuZx1v8RrrbW4
5yLInnypGRH9iBrXwnj5ptn0HALPpvUtHtssJH+R+Fi4bjfEaLnszshfqJKMp0pP
Y2mtz0Y1LwERKFg3VnJr+Y2ieptjqtv3ZG62xPrZYqmfxJNKrodo83TdrRrjd34/
9W3+LBa6lQJiQRiXGQm+rWAjUIw1gC1NdMX8Vey5Kj3t4bMSEaVe5cur68/b0U7+
jECdiomSvqEBzdavV3lavqiByv7YIQgs9NhdwYa5mnwtb2GgYzUPwEtmel4vXSPE
NgCyZbVLQQvYbMSbOFB6iSH2WXP5q3K6P5YGAnqTuTAua28oCaQEXxZl6fzFqg5x
/jpUlkMbape/2aJAT5u1hvXnaSNxJhYn6i40ohQAjdZclxMi7qKKOehY/HkqCugw
bxUFCbLLdBAiad48ZRHwck9llKyLCsW8d6UWuhHhOjMhib8WyHA=
=9uSt
-----END PGP SIGNATURE-----

--IS0zKkzwUGydFO0o--
