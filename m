Received: from eggs.gnu.org ([2001:4830:134:3::10]:53044)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1em1OM-0005o8-PE
	for qemu-devel@nongnu.org; Wed, 14 Feb 2018 13:02:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1em1OE-0006Ax-4n
	for qemu-devel@nongnu.org; Wed, 14 Feb 2018 13:02:50 -0500
Received: from chuckie.co.uk ([82.165.15.123]:60061
	helo=s16892447.onlinehome-server.info)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mark.cave-ayland@ilande.co.uk>)
	id 1em1OD-0006AG-Ml
	for qemu-devel@nongnu.org; Wed, 14 Feb 2018 13:02:41 -0500
References: <4476423.I6xtnU8gSc@wirbelwind>
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Message-ID: <1dbce0e5-6ba9-369a-2ba4-e7f6d5c5d085@ilande.co.uk>
Date: Wed, 14 Feb 2018 18:02:28 +0000
MIME-Version: 1.0
In-Reply-To: <4476423.I6xtnU8gSc@wirbelwind>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] sparc branch to pc+4 issue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: steven.seeger@flightsystems.net, QEMU Developers <qemu-devel@nongnu.org>

On 13/02/18 20:57, Steven Seeger wrote:

> Consider pc==0x100:
> 
> 0x100   b 0x104
> 
> The uncondtional not-annulled branch will go to 0x104, which is the next
> instruction anyway. do_branch() will leave dc->pc and dc->npc both set to
> 0x104. This causes gdb to have a problem when single stepping. It will be
> stuck. QEMU will execute past this somehow, but I'm not sure with what side
> effect. It seems to me the following patch will fix this:
> 
> diff --git a/target/sparc/translate.c b/target/sparc/translate.c
> index 71e0853e43..95ca90b51a 100644
> --- a/target/sparc/translate.c
> +++ b/target/sparc/translate.c
> @@ -1464,6 +1464,7 @@ static void do_branch(DisasContext *dc, int32_t offset,
> uint32_t insn, int cc)
>               dc->npc = dc->pc + 4;
>           } else {
>               dc->pc = dc->npc;
> +            if(target==dc->pc) target += 4;
>               dc->npc = target;
>               tcg_gen_mov_tl(cpu_pc, cpu_npc);
>           }
> 
> I apologize if I am missing something with this assessment.

Hi Steven,

Thanks for the patch! In principle the patch looks good, although sadly 
I don't currently have access to real hardware to verify this. Also 
you'll need to add a Signed-off-by tag in order for your patch to be 
applied (see https://wiki.qemu.org/Contribute/SubmitAPatch for more 
details).


ATB,

Mark.
