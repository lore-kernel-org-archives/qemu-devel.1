Received: from eggs.gnu.org ([209.51.188.92]:33324)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gyhWO-00066i-3G
	for qemu-devel@nongnu.org; Tue, 26 Feb 2019 13:32:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gyhWN-0006W0-9Y
	for qemu-devel@nongnu.org; Tue, 26 Feb 2019 13:32:04 -0500
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:43296)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gyhWN-0006Vc-2i
	for qemu-devel@nongnu.org; Tue, 26 Feb 2019 13:32:03 -0500
Received: by mail-ot1-x343.google.com with SMTP id n71so11952112ota.10
	for <qemu-devel@nongnu.org>; Tue, 26 Feb 2019 10:32:02 -0800 (PST)
MIME-Version: 1.0
References: <20190220235017.1060-1-richard.henderson@linaro.org>
	<20190220235017.1060-2-richard.henderson@linaro.org>
In-Reply-To: <20190220235017.1060-2-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 26 Feb 2019 18:31:50 +0000
Message-ID: <CAFEAcA9GW2HGGw1FjFSTOJgOn+eRs-1anQDJ7nb3FnOSNbQesQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 1/2] target/arm: Implement ARMv8.0-SB
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On Wed, 20 Feb 2019 at 23:50, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>


> @@ -9192,6 +9192,17 @@ static void disas_arm_insn(DisasContext *s, unsigned int insn)
>                   */
>                  gen_goto_tb(s, 0, s->pc & ~1);
>                  return;
> +            case 7: /* sb */
> +                if (!dc_isar_feature(aa32_sb, s)) {
> +                    goto illegal_op;
> +                }
> +                /*
> +                 * TODO: There is no speculation barrier opcode
> +                 * for TCG; MB and end the TB instead.
> +                 */
> +                tcg_gen_mb(TCG_MO_ALL | TCG_BAR_SC);
> +                s->base.is_jmp = DISAS_TOO_MANY;

Why do we do the "end the TB" code differently here than we
do for the implementation of ISB in the case immediately
above ?

In the A32 encoding bits [3:0] are "(0)", so we should check that
they're 0 and UNDEF if not.


> +                return;
>              default:
>                  goto illegal_op;
>              }
> @@ -11810,6 +11821,17 @@ static void disas_thumb2_insn(DisasContext *s, uint32_t insn)
>                               */
>                              gen_goto_tb(s, 0, s->pc & ~1);
>                              break;
> +                        case 7: /* sb */
> +                            if (!dc_isar_feature(aa32_sb, s)) {
> +                                goto illegal_op;
> +                            }
> +                            /*
> +                             * TODO: There is no speculation barrier opcode
> +                             * for TCG; MB and end the TB instead.
> +                             */
> +                            tcg_gen_mb(TCG_MO_ALL | TCG_BAR_SC);
> +                            s->base.is_jmp = DISAS_TOO_MANY;

Similarly here: inconsistency about how we end the TB, and
not checking the [3:0] bits for being zero.

(We also I think are not fully decoding some of the other
sbz/sbo fields for insns in this group, but that's more of
an existing bug than a new one.)

> +                            break;
>                          default:
>                              goto illegal_op;
>                          }
> --
> 2.17.2

thanks
-- PMM
