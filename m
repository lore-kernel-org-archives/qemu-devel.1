Received: from eggs.gnu.org ([2001:4830:134:3::10]:36471)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Yongbok.Kim@imgtec.com>) id 1cnRS2-00014p-PD
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 10:59:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Yongbok.Kim@imgtec.com>) id 1cnRRy-0004Za-TG
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 10:59:58 -0400
Received: from mailapp01.imgtec.com ([195.59.15.196]:17943)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Yongbok.Kim@imgtec.com>) id 1cnRRy-0004ZM-Nc
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 10:59:54 -0400
References: <20170304185652.10675-1-f4bug@amsat.org>
	<20170304185652.10675-2-f4bug@amsat.org>
From: Yongbok Kim <yongbok.kim@imgtec.com>
Message-ID: <b1d54aba-5a17-4335-2455-40722826caef@imgtec.com>
Date: Mon, 13 Mar 2017 14:59:53 +0000
MIME-Version: 1.0
In-Reply-To: <20170304185652.10675-2-f4bug@amsat.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 1/5] target-mips: fix compiler warnings
 (clang 5)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Aurelien Jarno <aurelien@aurel32.net>
Cc: qemu-devel@nongnu.org



On 04/03/2017 18:56, Philippe Mathieu-Daud=C3=A9 wrote:
> static code analyzer complain:
>=20
> target/mips/helper.c:453:5: warning: Function call argument is an unini=
tialized value
>     qemu_log_mask(CPU_LOG_MMU,
>     ^~~~~~~~~~~~~~~~~~~~~~~~~~
>=20
> 'physical' and 'prot' are uninitialized if 'ret' is not TLBRET_MATCH.
>=20
> Reported-by: Clang Static Analyzer
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
>  target/mips/helper.c | 16 ++++++++++++----
>  1 file changed, 12 insertions(+), 4 deletions(-)
>=20
> diff --git a/target/mips/helper.c b/target/mips/helper.c
> index d2e77958fd..e359ca3b44 100644
> --- a/target/mips/helper.c
> +++ b/target/mips/helper.c
> @@ -450,10 +450,18 @@ int mips_cpu_handle_mmu_fault(CPUState *cs, vaddr=
 address, int rw,
>      access_type =3D ACCESS_INT;
>      ret =3D get_physical_address(env, &physical, &prot,
>                                 address, rw, access_type);
> -    qemu_log_mask(CPU_LOG_MMU,
> -             "%s address=3D%" VADDR_PRIx " ret %d physical " TARGET_FM=
T_plx
> -             " prot %d\n",
> -             __func__, address, ret, physical, prot);
> +    switch (ret) {
> +    case TLBRET_MATCH:
> +        qemu_log_mask(CPU_LOG_MMU,
> +                      "%s address=3D%" VADDR_PRIx " physical " TARGET_=
FMT_plx
> +                      " prot %d\n", __func__, address, physical, prot)=
;
> +        break;
> +    default:
> +        qemu_log_mask(CPU_LOG_MMU,
> +                      "%s address=3D%" VADDR_PRIx " ret %d\n", __func_=
_, address,
> +                      ret);
> +        break;
> +    }
>      if (ret =3D=3D TLBRET_MATCH) {
>          tlb_set_page(cs, address & TARGET_PAGE_MASK,
>                       physical & TARGET_PAGE_MASK, prot | PAGE_EXEC,
>=20

Reviewed-by: Yongbok Kim <yongbok.kim@imgtec.com>
