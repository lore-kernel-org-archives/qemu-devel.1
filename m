Received: from eggs.gnu.org ([2001:4830:134:3::10]:47666)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1fTj6u-0002JY-55
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 03:25:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1fTj6p-0007Pb-5q
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 03:25:28 -0400
Received: from chuckie.co.uk ([82.165.15.123]:36383
	helo=s16892447.onlinehome-server.info)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mark.cave-ayland@ilande.co.uk>)
	id 1fTj6o-0007NL-Vb
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 03:25:23 -0400
References: <20180614222830.19725-1-mark.cave-ayland@ilande.co.uk>
	<20180614222830.19725-2-mark.cave-ayland@ilande.co.uk>
	<57720c98-3454-218b-6e29-078a9dfd9e53@linaro.org>
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Message-ID: <7e20bf60-709d-7bcb-c433-3ecb1decfb5a@ilande.co.uk>
Date: Fri, 15 Jun 2018 08:25:11 +0100
MIME-Version: 1.0
In-Reply-To: <57720c98-3454-218b-6e29-078a9dfd9e53@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
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
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org, atar4qemu@gmail.com, cota@braap.org

On 14/06/18 23:40, Richard Henderson wrote:

> On 06/14/2018 12:28 PM, Mark Cave-Ayland wrote:
>> @@ -5834,6 +5928,11 @@ static void sparc_tr_tb_stop(DisasContextBase *dcbase, CPUState *cs)
>>               save_npc(dc);
>>               tcg_gen_exit_tb(NULL, 0);
>>           }
>> +    } else if (dc->base.is_jmp == DISAS_EXIT) {
>> +        /* Exit TB */
>> +        save_state(dc);
>> +        gen_op_next_insn();
>> +        tcg_gen_exit_tb(NULL, 0);
>>       }
> 
> This doesn't look reachable, since the IF that goes with this ELSE is
> 
>      if (dc->base.is_jmp != DISAS_NORETURN) {
> 
> I suggest
> 
>      switch (dc->base.is_jmp) {
>      case DISAS_NORETURN:
>         break;
> 
>      case DISAS_TOO_MANY:
>         /* existing block */
>         break;
> 
>      case DISAS_EXIT:
>         /* new code from above */
> 
>      default:
>          g_assert_not_reached();
>      }

Ah sorry my bad - it was getting quite late here.

Okay that works, although I noticed that I had to drop 
gen_op_next_insn() from the above code that was originally inline for it 
to work correctly in sparc_tr_tb_stop(). V4 is on its way shortly.


ATB,

Mark.
