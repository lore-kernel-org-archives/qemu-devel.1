Received: from eggs.gnu.org ([2001:4830:134:3::10]:50297)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1d7bwx-0003Kx-Mc
	for qemu-devel@nongnu.org; Mon, 08 May 2017 02:15:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1d7bwu-0000KI-FU
	for qemu-devel@nongnu.org; Mon, 08 May 2017 02:15:15 -0400
Received: from ozlabs.org ([103.22.144.67]:57405)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgibson@ozlabs.org>) id 1d7bwt-0000IK-K9
	for qemu-devel@nongnu.org; Mon, 08 May 2017 02:15:12 -0400
Date: Mon, 8 May 2017 16:13:59 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170508061359.GH25748@umbus.fritz.box>
References: <1493977730-20581-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="l06SQqiZYCi8rTKz"
Content-Disposition: inline
In-Reply-To: <1493977730-20581-1-git-send-email-pbonzini@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] ppc: xics: fix compilation with CentOS 6
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, dgibson@redhat.com, stefanha@redhat.com


--l06SQqiZYCi8rTKz
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 05, 2017 at 11:48:50AM +0200, Paolo Bonzini wrote:
> The PowerPCCPU typedef is included twice if a file includes
> both hw/ppc/xics.h and target/ppc/cpu-qom.h.
>=20
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

Applied to ppc-for-2.10, thanks.

> ---
> 	There are other failures but I don't have time to debug them today:
>=20
> 	In file included from /tmp/qemu-test/src/include/hw/ppc/pnv.h:26,
> 	                 from /tmp/qemu-test/src/hw/ppc/pnv.c:31:
> 	/tmp/qemu-test/src/include/hw/ppc/pnv_psi.h:50: error: redefinition of t=
ypedef =E2=80=98PnvPsi=E2=80=99
> 	/tmp/qemu-test/src/include/hw/ppc/pnv_lpc.h:26: note: previous declarati=
on of =E2=80=98PnvPsi=E2=80=99 was here
> 	In file included from /tmp/qemu-test/src/include/hw/ppc/pnv.h:27,
> 	                 from /tmp/qemu-test/src/hw/ppc/pnv.c:31:
> 	/tmp/qemu-test/src/include/hw/ppc/pnv_occ.h:25: error: redefinition of t=
ypedef =E2=80=98PnvPsi=E2=80=99
> 	/tmp/qemu-test/src/include/hw/ppc/pnv_psi.h:50: note: previous declarati=
on of =E2=80=98PnvPsi=E2=80=99 was here
> 	In file included from /tmp/qemu-test/src/hw/ppc/pnv.c:39:
> 	/tmp/qemu-test/src/include/hw/ipmi/ipmi.h:188: error: redefinition of ty=
pedef =E2=80=98IPMIBmc=E2=80=99
> 	/tmp/qemu-test/src/include/hw/ppc/pnv.h:121: note: previous declaration =
of =E2=80=98IPMIBmc=E2=80=99 was here
> 	make[1]: *** [hw/ppc/pnv.o] Error 1
>=20
> 	Please start including Docker-based tests in your pre-pull-request tests.

Um.. is there some doco on how to execute these.  I tried "make
docker-test" and "make docker-image" and they both just seem to hang
at:

umbus:~/src/qemu (ppc-for-2.10)$ make docker-image
  BUILD   travis

strace shows docker blocked on a futex.

>  include/hw/ppc/xics.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/include/hw/ppc/xics.h b/include/hw/ppc/xics.h
> index c215dc7..ce1942b 100644
> --- a/include/hw/ppc/xics.h
> +++ b/include/hw/ppc/xics.h
> @@ -29,6 +29,7 @@
>  #define XICS_H
> =20
>  #include "hw/qdev.h"
> +#include "target/ppc/cpu-qom.h"
> =20
>  #define XICS_IPI        0x2
>  #define XICS_BUID       0x1
> @@ -46,7 +47,6 @@ typedef struct ICSStateClass ICSStateClass;
>  typedef struct ICSState ICSState;
>  typedef struct ICSIRQState ICSIRQState;
>  typedef struct XICSFabric XICSFabric;
> -typedef struct PowerPCCPU PowerPCCPU;
> =20
>  #define TYPE_ICP "icp"
>  #define ICP(obj) OBJECT_CHECK(ICPState, (obj), TYPE_ICP)

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--l06SQqiZYCi8rTKz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJZEAynAAoJEGw4ysog2bOS1R8QAKwV6LYJY4fopdazHgXyA9HX
nG4iIKSrMdVxRx9ubaQKK70XP9bvMMVnHBB2ygxfm9hRWmiTmuwphE0JmCti8YTP
AJHZwNzYU4YdlDokDL8wTQkWck7XG+SAa8hWqgUY6xA9UWd+zPjaiya5a1POG1OB
CoVZxCZezZcCrJewZkNIxL8+Kb/ghO5htVpovQS+qs0Wtxxfejgb3d8A1BrdTFXm
3hSKuiSkDCJ6QwbKB50u9v1ktd2nszmCpLhkElPQiSURjq+BU+czuUsRDIbJstVi
QOiXVTG48gT9vILkFXHoS2JieU7V2aMvo83TG0lGUhUR+kCZLz1T4dj+HLSW/mce
zjh2PKT2nvipWdqn7+HunjHIT/LVYFaC2EFuAf+ektAD3d9DpZq1dtayqCND7sHb
a8A7Wp+TNQGeNIr6Psci4ujMwT9boZM7bOeLGE3cOU5lfR9RdoMkbuWPQSK87W3c
BtEGU13m3AH0LILqV66U4uHR+6797uOFlW6VM79MCt655NjITw3EHy+LPlo8YYHK
47ooIMuuvHcDcrIRMgRMmtMydy0AnqNRNwLu4Zvr6cW7sB9eHV3bI1mT7jvY6noK
vjmBooXwgczdw0nIPSFLhJEm5aOamAAmCBawJaUp/F+rATS1A/nO+XLAvUzHzPWZ
qsspn2JQ5nL7qpW1LZbX
=u1pY
-----END PGP SIGNATURE-----

--l06SQqiZYCi8rTKz--
