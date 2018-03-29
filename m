Received: from eggs.gnu.org ([2001:4830:134:3::10]:32836)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mrezanin@redhat.com>) id 1f1P3L-0006BN-TC
	for qemu-devel@nongnu.org; Thu, 29 Mar 2018 00:20:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mrezanin@redhat.com>) id 1f1P3H-0006Yn-07
	for qemu-devel@nongnu.org; Thu, 29 Mar 2018 00:20:43 -0400
Received: from 212-4-128-36.cust.selfnet.cz ([212.4.128.36]:38238
	helo=workimage.localdomain) by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mrezanin@redhat.com>) id 1f1P3G-0006WA-Ok
	for qemu-devel@nongnu.org; Thu, 29 Mar 2018 00:20:38 -0400
Date: Thu, 29 Mar 2018 05:45:27 +0200
From: Miroslav Rezanina <mrezanin@redhat.com>
Message-ID: <20180329034527.te57zxf3ylzw4n4g@lws.brq.redhat.com>
References: <20180328133152.24623-1-lvivier@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180328133152.24623-1-lvivier@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] tcg: fix 16-byte vector operations
 detection
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <lvivier@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Richard Henderson <richard.henderson@linaro.org>, Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>

On Wed, Mar 28, 2018 at 03:31:52PM +0200, Laurent Vivier wrote:
> configure tries to detect if the compiler
> supports 16-byte vector operations.
>=20
> As stated in the comment of the detection
> program, there is a problem with the system
> compiler on GCC on Centos 7.
>=20
> This program doesn't actually detect the problem
> with GCC on RHEL7 on PPC64LE (Red Hat 4.8.5-28).
>=20
> This patch updates the test to look more like
> it is in QEMU helpers, and now detects the problem.
>=20
> The error reported is:
>=20
>   CC      ppc64-softmmu/accel/tcg/tcg-runtime-gvec.o
>   ..//accel/tcg/tcg-runtime-gvec.c: In function =E2=80=98helper_gvec_sh=
l8i=E2=80=99:
>   ../accel/tcg/tcg-runtime-gvec.c:558:26: internal compiler error: in e=
mit_move_insn, at expr.c:3495
>            *(vec8 *)(d + i) =3D *(vec8 *)(a + i) << shift;
>                             ^
> Fixes: db43267 "tcg: Add generic vector expanders"
> Signed-off-by: Laurent Vivier <lvivier@redhat.com>
> ---
>  configure | 8 ++++++++
>  1 file changed, 8 insertions(+)
>=20
> diff --git a/configure b/configure
> index 4d0e92c96c..a2301dd0dc 100755
> --- a/configure
> +++ b/configure
> @@ -5054,6 +5054,14 @@ static S2 c2;
>  static S4 c4;
>  static S8 c8;
>  static int i;
> +void helper(void *d, void *a, int shift, int i);
> +void helper(void *d, void *a, int shift, int i)
> +{
> +  *(U1 *)(d + i) =3D *(U1 *)(a + i) << shift;
> +  *(U2 *)(d + i) =3D *(U2 *)(a + i) << shift;
> +  *(U4 *)(d + i) =3D *(U4 *)(a + i) << shift;
> +  *(U8 *)(d + i) =3D *(U8 *)(a + i) << shift;
> +}
>  int main(void)
>  {
>    a1 +=3D b1; a2 +=3D b2; a4 +=3D b4; a8 +=3D b8;
> --=20
> 2.14.3
>=20
>

Build works correctly for RHEL 7 with this patch

Reviewed-by: Miroslav Rezanina <mrezanin@redhat.com>=20
