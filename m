Received: from eggs.gnu.org ([2001:4830:134:3::10]:39299)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1f70NK-000390-HO
	for qemu-devel@nongnu.org; Fri, 13 Apr 2018 11:12:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1f70NG-0004eW-I1
	for qemu-devel@nongnu.org; Fri, 13 Apr 2018 11:12:30 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:38134 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1f70NF-0004dq-SF
	for qemu-devel@nongnu.org; Fri, 13 Apr 2018 11:12:26 -0400
Date: Fri, 13 Apr 2018 18:12:09 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20180413181055-mutt-send-email-mst@kernel.org>
References: <20180413142336.32163-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180413142336.32163-1-peter.maydell@linaro.org>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH for-2.12] tcg/mips: Handle large offsets
 from target env to tlb_table
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, patches@linaro.org, Richard Henderson <rth@twiddle.net>, Aurelien Jarno <aurelien@aurel32.net>, Yongbok Kim <yongbok.kim@mips.com>

On Fri, Apr 13, 2018 at 03:23:36PM +0100, Peter Maydell wrote:
> The MIPS TCG target makes the assumption that the offset from the
> target env pointer to the tlb_table is less than about 64K. This
> used to be true, but gradual addition of features to the Arm
> target means that it's no longer true there. This results in
> the build-time assertion failing:
>=20
> In file included from /home/pm215/qemu/include/qemu/osdep.h:36:0,
>                  from /home/pm215/qemu/tcg/tcg.c:28:
> /home/pm215/qemu/tcg/mips/tcg-target.inc.c: In function =E2=80=98tcg_ou=
t_tlb_load=E2=80=99:
> /home/pm215/qemu/include/qemu/compiler.h:90:36: error: static assertion=
 failed: "not expecting: offsetof(CPUArchState, tlb_table[NB_MMU_MODES - =
1][1]) > 0x7ff0 + 0x7fff"
>  #define QEMU_BUILD_BUG_MSG(x, msg) _Static_assert(!(x), msg)
>                                     ^
> /home/pm215/qemu/include/qemu/compiler.h:98:30: note: in expansion of m=
acro =E2=80=98QEMU_BUILD_BUG_MSG=E2=80=99
>  #define QEMU_BUILD_BUG_ON(x) QEMU_BUILD_BUG_MSG(x, "not expecting: " #=
x)
>                               ^
> /home/pm215/qemu/tcg/mips/tcg-target.inc.c:1236:9: note: in expansion o=
f macro =E2=80=98QEMU_BUILD_BUG_ON=E2=80=99
>          QEMU_BUILD_BUG_ON(offsetof(CPUArchState,
>          ^
> /home/pm215/qemu/rules.mak:66: recipe for target 'tcg/tcg.o' failed
>=20
> An ideal long term approach would be to rearrange the CPU state
> so that the tlb_table was not so far along it, but this is tricky
> because it would move it from the "not cleared on CPU reset" part
> of the struct to the "cleared on CPU reset" part. As a simple fix
> for the 2.12 release, make the MIPS TCG target handle an arbitrary
> offset by emitting more add instructions. This will mean an extra
> instruction in the fastpath for TCG loads and stores for the
> affected guests (currently just aarch64-softmmu).
>=20
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Acked-by: Michael S. Tsirkin <mst@redhat.com>

> ---
> This is sufficient that on MIPS host we can now at least build
> and run an aarch64 guest kernel. I haven't tried 'make check'
> because the only MIPS system I have access to is way too slow...
>=20
>  tcg/mips/tcg-target.inc.c | 11 ++++-------
>  1 file changed, 4 insertions(+), 7 deletions(-)
>=20
> diff --git a/tcg/mips/tcg-target.inc.c b/tcg/mips/tcg-target.inc.c
> index 4b55ab8856..ca5f1d4894 100644
> --- a/tcg/mips/tcg-target.inc.c
> +++ b/tcg/mips/tcg-target.inc.c
> @@ -1229,13 +1229,10 @@ static void tcg_out_tlb_load(TCGContext *s, TCG=
Reg base, TCGReg addrl,
>      tcg_out_opc_reg(s, ALIAS_PADD, TCG_REG_A0, TCG_REG_A0, TCG_AREG0);
> =20
>      /* Compensate for very large offsets.  */
> -    if (add_off >=3D 0x8000) {
> -        /* Most target env are smaller than 32k; none are larger than =
64k.
> -           Simplify the logic here merely to offset by 0x7ff0, giving =
us a
> -           range just shy of 64k.  Check this assumption.  */
> -        QEMU_BUILD_BUG_ON(offsetof(CPUArchState,
> -                                   tlb_table[NB_MMU_MODES - 1][1])
> -                          > 0x7ff0 + 0x7fff);
> +    while (add_off >=3D 0x8000) {
> +        /* Most target env are smaller than 32k, but a few are larger =
than 64k,
> +         * so handle an arbitrarily large offset.
> +         */
>          tcg_out_opc_imm(s, ALIAS_PADDI, TCG_REG_A0, TCG_REG_A0, 0x7ff0=
);
>          cmp_off -=3D 0x7ff0;
>          add_off -=3D 0x7ff0;
> --=20
> 2.16.2
