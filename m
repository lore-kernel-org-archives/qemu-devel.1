Received: from eggs.gnu.org ([2001:4830:134:3::10]:53363)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eBMlO-00016p-GW
	for qemu-devel@nongnu.org; Sun, 05 Nov 2017 10:23:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eBMlN-00067k-NZ
	for qemu-devel@nongnu.org; Sun, 05 Nov 2017 10:23:06 -0500
Received: from mail-it0-x244.google.com ([2607:f8b0:4001:c0b::244]:46937)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eBMlN-00066z-Iq
	for qemu-devel@nongnu.org; Sun, 05 Nov 2017 10:23:05 -0500
Received: by mail-it0-x244.google.com with SMTP id f187so2521364itb.1
	for <qemu-devel@nongnu.org>; Sun, 05 Nov 2017 07:23:05 -0800 (PST)
MIME-Version: 1.0
Sender: philippe.mathieu.daude@gmail.com
In-Reply-To: <1509767121-26925-16-git-send-email-jcmvbkbc@gmail.com>
References: <1509767121-26925-1-git-send-email-jcmvbkbc@gmail.com>
	<1509767121-26925-16-git-send-email-jcmvbkbc@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Date: Sun, 5 Nov 2017 12:23:04 -0300
Message-ID: <CAAdtpL5cr_Pi7_HKsxDRwfkPhYPc6rGU=53AdbW0HoHbm-LrFw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 15/16] target/xtensa: implement const16
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Filippov <jcmvbkbc@gmail.com>, Richard Henderson <rth@twiddle.net>, Aurelien Jarno <aurelien@aurel32.net>
Cc: "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>

Hi Max,

On Sat, Nov 4, 2017 at 12:45 AM, Max Filippov <jcmvbkbc@gmail.com> wrote:
> const16 is an opcode that shifts 16 lower bits of an address register
> to the 16 upper bits and puts its immediate operand into the lower 16
> bits. It is not controlled by an Xtensa option and doesn't have a fixed
> opcode.
>
> Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
> ---
>  target/xtensa/translate.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
>
> diff --git a/target/xtensa/translate.c b/target/xtensa/translate.c
> index a84bbf3bedc3..f249e810d92c 100644
> --- a/target/xtensa/translate.c
> +++ b/target/xtensa/translate.c
> @@ -1526,6 +1526,17 @@ static void translate_clrb_expstate(DisasContext *dc, const uint32_t arg[],
>      tcg_gen_andi_i32(cpu_UR[EXPSTATE], cpu_UR[EXPSTATE], ~(1u << arg[0]));
>  }
>
> +static void translate_const16(DisasContext *dc, const uint32_t arg[],
> +                             const uint32_t par[])
> +{
> +    if (gen_window_check1(dc, arg[0])) {
> +        TCGv_i32 v = tcg_temp_new_i32();
> +
> +        tcg_gen_shli_i32(v, cpu_R[arg[0]], 16);
> +        tcg_gen_ori_i32(cpu_R[arg[0]], v, arg[1] & 0xffff);

this is missing:

             tcg_temp_free_i32(v);

> +    }

however I think this can be simplified in 1 instr on target supporting
deposit32:

    tcg_gen_deposit_i32(cpu_R[arg[0]], cpu_R[arg[1]], cpu_R[arg[0]], 16, 16)

Regards,

Phil.

> +}
> +
>  /* par[0]: privileged, par[1]: check memory access */
>  static void translate_dcache(DisasContext *dc, const uint32_t arg[],
>                               const uint32_t par[])
> @@ -2742,6 +2753,9 @@ static const XtensaOpcodeOps core_ops[] = {
>          .name = "clrb_expstate",
>          .translate = translate_clrb_expstate,
>      }, {
> +        .name = "const16",
> +        .translate = translate_const16,
> +    }, {
>          .name = "depbits",
>          .translate = translate_depbits,
>      }, {
> --
> 2.1.4
>
>
