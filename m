Received: from eggs.gnu.org ([209.51.188.92]:58003)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1hB0jf-0003yC-Kw
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 13:28:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1hB0je-0001H3-2P
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 13:28:39 -0400
Received: from mail-eopbgr690115.outbound.protection.outlook.com
	([40.107.69.115]:45927
	helo=NAM04-CO1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <amarkovic@wavecomp.com>)
	id 1hB0jd-0001Fv-Mo
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 13:28:38 -0400
From: Aleksandar Markovic <amarkovic@wavecomp.com>
Date: Mon, 1 Apr 2019 17:28:34 +0000
Message-ID: <CY4PR2201MB1254A518F1B7BF965D82E941C6550@CY4PR2201MB1254.namprd22.prod.outlook.com>
References: <1554129501-27175-1-git-send-email-mateja.marjanovic@rt-rk.com>,
	<1554129501-27175-2-git-send-email-mateja.marjanovic@rt-rk.com>
In-Reply-To: <1554129501-27175-2-git-send-email-mateja.marjanovic@rt-rk.com>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH 1/2] target/mips: DIV_<U|S>.<B|H|W|D> MSA
 insturctions fixed
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
> Subject: [PATCH 1/2] target/mips: DIV_<U|S>.<B|H|W|D> MSA insturctions fi=
xed

"insturctions" -> "instructions". Try to find a spell checking tool that wi=
ll help
you avoid such cases in the future, especially since you tend to make the
same mistakes over and over.

The title of the patch (after "target/mips:") should begin with an imperati=
ve.

Also, using the word "fix" here is debatable - there is no wrong behavior o=
f
the emulator, since these cases are "unpredictable", so any result is right=
.
The expression "Make results of division by zero be the same as on the
reference hardware", or similar, would be more appropriate.

>
> From: Mateja Marjanovic <Mateja.Marjanovic@rt-rk.com>
>=20
> In case of dividing integers by zero, the result is unpredictable [1],

Page number(s) is(are) missing.

> but according to the hardware, the result is 1 or -1, depending on

"but according to the hardware," -> "but, if executed on the reference hard=
ware,"

> the sign of the dividend.
>=20
> [1] MIPS=AE Architecture for Programmers
>     Volume IV-j: The MIPS64=AE SIMD
>     Architecture Module, Revision 1.12
>=20
> Signed-off-by: Mateja Marjanovic <mateja.marjanovic@rt-rk.com>
>
> ---
> target/mips/msa_helper.c | 7 +++++--
> 1 file changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/target/mips/msa_helper.c b/target/mips/msa_helper.c
> index 655148d..46a5aac 100644
> --- a/target/mips/msa_helper.c
> +++ b/target/mips/msa_helper.c
> @@ -641,14 +641,17 @@ static inline int64_t msa_div_s_df(uint32_t df, int=
64_t arg1, int64_t arg2)
>      if (arg1 =3D=3D DF_MIN_INT(df) && arg2 =3D=3D -1) {
>          return DF_MIN_INT(df);
>      }
> -    return arg2 ? arg1 / arg2 : 0;
> +    if (arg2 =3D=3D 0) {
> +        return arg1 >=3D 0 ? -1 : 1;
> +    }
> +    return arg1 / arg2;
>  }
>
> static inline int64_t msa_div_u_df(uint32_t df, int64_t arg1, int64_t arg=
2)
> {
>     uint64_t u_arg1 =3D UNSIGNED(arg1, df);
>     uint64_t u_arg2 =3D UNSIGNED(arg2, df);
> -    return u_arg2 ? u_arg1 / u_arg2 : 0;
> +    return arg2 ? u_arg1 / u_arg2 : -1;
> }

Unnecessary inconsistency. For DIV_S.<B|H|W|D>, you use a full
"if" statement, and for DUV_U.<B|H|W|D> a conditional operator.
Use the same in both cases.

Thanks,
Aleksandar

>=20
> static inline int64_t msa_mod_s_df(uint32_t df, int64_t arg1, int64_t arg=
2)
> --
> 2.7.4
