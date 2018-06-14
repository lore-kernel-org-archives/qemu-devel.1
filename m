Received: from eggs.gnu.org ([2001:4830:134:3::10]:51563)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fTaun-0001Wh-Jk
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 18:40:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fTauk-0004jK-Gq
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 18:40:25 -0400
Received: from mail-pf0-x243.google.com ([2607:f8b0:400e:c00::243]:35284)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fTauk-0004ia-8m
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 18:40:22 -0400
Received: by mail-pf0-x243.google.com with SMTP id c22-v6so3930091pfi.2
	for <qemu-devel@nongnu.org>; Thu, 14 Jun 2018 15:40:22 -0700 (PDT)
References: <20180614222830.19725-1-mark.cave-ayland@ilande.co.uk>
	<20180614222830.19725-2-mark.cave-ayland@ilande.co.uk>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <57720c98-3454-218b-6e29-078a9dfd9e53@linaro.org>
Date: Thu, 14 Jun 2018 12:40:16 -1000
MIME-Version: 1.0
In-Reply-To: <20180614222830.19725-2-mark.cave-ayland@ilande.co.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC PATCH v3 1/1] SPARC64: add icount support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org, atar4qemu@gmail.com, cota@braap.org

On 06/14/2018 12:28 PM, Mark Cave-Ayland wrote:
> @@ -5834,6 +5928,11 @@ static void sparc_tr_tb_stop(DisasContextBase *dcbase, CPUState *cs)
>              save_npc(dc);
>              tcg_gen_exit_tb(NULL, 0);
>          }
> +    } else if (dc->base.is_jmp == DISAS_EXIT) {
> +        /* Exit TB */
> +        save_state(dc);
> +        gen_op_next_insn();
> +        tcg_gen_exit_tb(NULL, 0);
>      }

This doesn't look reachable, since the IF that goes with this ELSE is

    if (dc->base.is_jmp != DISAS_NORETURN) {

I suggest

    switch (dc->base.is_jmp) {
    case DISAS_NORETURN:
       break;

    case DISAS_TOO_MANY:
       /* existing block */
       break;

    case DISAS_EXIT:
       /* new code from above */

    default:
        g_assert_not_reached();
    }


r~
