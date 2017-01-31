Received: from eggs.gnu.org ([2001:4830:134:3::10]:60898)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cYW8e-0000SS-RM
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 05:58:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cYW8e-0001bt-0x
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 05:58:16 -0500
Received: from mail-ua0-x231.google.com ([2607:f8b0:400c:c08::231]:33148)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cYW8d-0001bb-TC
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 05:58:15 -0500
Received: by mail-ua0-x231.google.com with SMTP id i68so269559644uad.0
	for <qemu-devel@nongnu.org>; Tue, 31 Jan 2017 02:58:15 -0800 (PST)
MIME-Version: 1.0
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 31 Jan 2017 10:57:54 +0000
Message-ID: <CAFEAcA9j47hSCHyYh5TzNh5P-V3_ddcmA=XMcini+d8PnqruZA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v8 23/25] target-arm: introduce
 ARM_CP_EXIT_PC
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: MTTCG Devel <mttcg@listserver.greensocs.com>, QEMU Developers <qemu-devel@nongnu.org>, =?UTF-8?B?S09OUkFEIEZyw6lkw6lyaWM=?= <fred.konrad@greensocs.com>, Alvise Rigo <a.rigo@virtualopensystems.com>, "Emilio G. Cota" <cota@braap.org>, Pranith Kumar <bobby.prani@gmail.com>, Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>, Mark Burton <mark.burton@greensocs.com>, Paolo Bonzini <pbonzini@redhat.com>, Jan Kiszka <jan.kiszka@siemens.com>, Fedorov Sergey <serge.fdrv@gmail.com>, Richard Henderson <rth@twiddle.net>, Claudio Fontana <claudio.fontana@huawei.com>, bamvor.zhangjian@linaro.org, "open list:ARM" <qemu-arm@nongnu.org>

On 27 January 2017 at 10:39, Alex Benn=C3=A9e <alex.bennee@linaro.org> wrot=
e:
> Some helpers may trigger an immediate exit of the cpu_loop. If this
> happens the PC need to be rectified to ensure the restart will begin
> on the next instruction.
>
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> ---
>  target/arm/cpu.h           | 3 ++-
>  target/arm/translate-a64.c | 4 ++++
>  target/arm/translate.c     | 4 ++++
>  3 files changed, 10 insertions(+), 1 deletion(-)
>
> diff --git a/target/arm/cpu.h b/target/arm/cpu.h
> index f56a96c675..1b0670ae11 100644
> --- a/target/arm/cpu.h
> +++ b/target/arm/cpu.h
> @@ -1411,7 +1411,8 @@ static inline uint64_t cpreg_to_kvm_id(uint32_t cpr=
egid)
>  #define ARM_CP_NZCV            (ARM_CP_SPECIAL | (3 << 8))
>  #define ARM_CP_CURRENTEL       (ARM_CP_SPECIAL | (4 << 8))
>  #define ARM_CP_DC_ZVA          (ARM_CP_SPECIAL | (5 << 8))
> -#define ARM_LAST_SPECIAL       ARM_CP_DC_ZVA
> +#define ARM_CP_EXIT_PC         (ARM_CP_SPECIAL | (6 << 8))
> +#define ARM_LAST_SPECIAL       ARM_CP_EXIT_PC

There's a comment above this list of defines that documents
what all the flags mean; can you add an entry to it for the
new flag?

>  /* Used only as a terminator for ARMCPRegInfo lists */
>  #define ARM_CP_SENTINEL 0xffff
>  /* Mask of only the flag bits in a type field */
> diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
> index 05162f335e..a3f37d8bec 100644
> --- a/target/arm/translate-a64.c
> +++ b/target/arm/translate-a64.c
> @@ -1561,6 +1561,10 @@ static void handle_sys(DisasContext *s, uint32_t i=
nsn, bool isread,
>          tcg_rt =3D cpu_reg(s, rt);
>          gen_helper_dc_zva(cpu_env, tcg_rt);
>          return;
> +    case ARM_CP_EXIT_PC:
> +        /* The helper may exit the cpu_loop so ensure PC is correct */
> +        gen_a64_set_pc_im(s->pc);
> +        break;

This will work, but it's a little odd because it breaks the
existing invariant that cp helpers never throw exceptions
(except in the access function).

Does single-stepping (of the emulated architectural
debug step, and gdbstub singlestep) work across one of
these instructions?

Should we also set dc->is_jmp to force ending the TB here?

This is probably a question answered in the rest of the series,
but why do we need the helper to be able to longjump out to the
top level? Can't we just have the helper do its work and then
end the TB with tcg_gen_exit_tb(0) so we return to the top level
loop in the normal way?

>      default:
>          break;
>      }
> diff --git a/target/arm/translate.c b/target/arm/translate.c
> index 444a24c2b6..7bd18cd25d 100644
> --- a/target/arm/translate.c
> +++ b/target/arm/translate.c
> @@ -7508,6 +7508,10 @@ static int disas_coproc_insn(DisasContext *s, uint=
32_t insn)
>              gen_set_pc_im(s, s->pc);
>              s->is_jmp =3D DISAS_WFI;
>              return 0;
> +        case ARM_CP_EXIT_PC:
> +            /* The helper may exit the cpu_loop so ensure PC is correct =
*/
> +            gen_set_pc_im(s, s->pc);
> +            break;

Do we also need to gen_set_condexec() ?

>          default:
>              break;
>          }
> --
> 2.11.0

thanks
-- PMM
