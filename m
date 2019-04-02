Received: from eggs.gnu.org ([209.51.188.92]:60231)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1hBIt9-0004Jj-UQ
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 08:51:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1hBIt8-0000zg-Ss
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 08:51:39 -0400
Received: from mail-eopbgr810127.outbound.protection.outlook.com
	([40.107.81.127]:60778
	helo=NAM01-BY2-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <amarkovic@wavecomp.com>)
	id 1hBIt8-0000yC-K6
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 08:51:38 -0400
From: Aleksandar Markovic <amarkovic@wavecomp.com>
Date: Tue, 2 Apr 2019 12:51:34 +0000
Message-ID: <BN6PR2201MB1251131A588B0B9576A8E8BEC6560@BN6PR2201MB1251.namprd22.prod.outlook.com>
References: <1554207110-9113-1-git-send-email-mateja.marjanovic@rt-rk.com>,
	<1554207110-9113-2-git-send-email-mateja.marjanovic@rt-rk.com>
In-Reply-To: <1554207110-9113-2-git-send-email-mateja.marjanovic@rt-rk.com>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v2 1/2] target/mips: Make the results of
 DIV_<U|S>.<B|H|W|D> the same as on hardware
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mateja Marjanovic <mateja.marjanovic@rt-rk.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "aurelien@aurel32.net" <aurelien@aurel32.net>, Aleksandar Rikalo <arikalo@wavecomp.com>

> From: Mateja Marjanovic <mateja.marjanovic@rt-rk.com>
> Subject: [PATCH v2 1/2] target/mips: Make the results of DIV_<U|S>.<B|H|W=
|D> the same as on > hardware
>=20
> From: Mateja Marjanovic <Mateja.Marjanovic@rt-rk.com>
>=20
> MSA instructions DIV_<U|S>.<B|H|W|D> when dividing by zero,
> didn't return the same value when executed on a referent hardware
> (FPGA MIPS 64 r6, little endian) and when executed on QEMU, which
> is not a real bug, because the result when dividing by zero is
> UNPREDICTABLE [1] (page 141, 142).
>=20
> [1] MIPS Architecture for Programmers
>     Volume IV-j: The MIPS64 SIMD
>     Architecture Module, Revision 1.12
>=20
> Signed-off-by: Mateja Marjanovic <mateja.marjanovic@rt-rk.com>
> ---

Reviewed-by: Aleksandar Markovic <amarkovic@wavecomp.com>

>  target/mips/msa_helper.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>=20
> diff --git a/target/mips/msa_helper.c b/target/mips/msa_helper.c
> index 655148d..8c77f12 100644
> --- a/target/mips/msa_helper.c
> +++ b/target/mips/msa_helper.c
> @@ -641,14 +641,15 @@ static inline int64_t msa_div_s_df(uint32_t df, int=
64_t arg1, int64_t > arg2)
>      if (arg1 =3D=3D DF_MIN_INT(df) && arg2 =3D=3D -1) {
>          return DF_MIN_INT(df);
>      }
> -    return arg2 ? arg1 / arg2 : 0;
> +    return arg2 ? arg1 / arg2
> +                : arg1 >=3D 0 ? -1 : 1;
>  }
>=20
>  static inline int64_t msa_div_u_df(uint32_t df, int64_t arg1, int64_t ar=
g2)
>  {
>      uint64_t u_arg1 =3D UNSIGNED(arg1, df);
>      uint64_t u_arg2 =3D UNSIGNED(arg2, df);
> -    return u_arg2 ? u_arg1 / u_arg2 : 0;
> +    return arg2 ? u_arg1 / u_arg2 : -1;
>  }
>=20
>  static inline int64_t msa_mod_s_df(uint32_t df, int64_t arg1, int64_t ar=
g2)
> --
> 2.7.4
