Received: from eggs.gnu.org ([2001:4830:134:3::10]:42005)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1f1apK-0001OB-2K
	for qemu-devel@nongnu.org; Thu, 29 Mar 2018 12:55:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1f1apG-0002XZ-Uo
	for qemu-devel@nongnu.org; Thu, 29 Mar 2018 12:55:02 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:57728 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lvivier@redhat.com>) id 1f1apG-0002Wb-P1
	for qemu-devel@nongnu.org; Thu, 29 Mar 2018 12:54:58 -0400
References: <20180328133152.24623-1-lvivier@redhat.com>
From: Laurent Vivier <lvivier@redhat.com>
Message-ID: <cb19950a-9b8e-90be-49df-b145900e2958@redhat.com>
Date: Thu, 29 Mar 2018 18:54:47 +0200
MIME-Version: 1.0
In-Reply-To: <20180328133152.24623-1-lvivier@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
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
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Miroslav Rezanina <mrezanin@redhat.com>, Richard Henderson <richard.henderson@linaro.org>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>

Hi,

I think it would be good to have this fix (or something similar) in -rc2.

Without this we can't build QEMU 2.12 PPC64LE for RHEL7 [1]

Any comment?

Thanks,
Laurent

[1] we have bugzilla for RHEL7 GCC,
    https://bugzilla.redhat.com/show_bug.cgi?id=3D1546728
    but as configure provides a way to workaround the problem
    we should also fix configure.

On 28/03/2018 15:31, Laurent Vivier wrote:
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
>=20
