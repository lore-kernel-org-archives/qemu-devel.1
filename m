Received: from eggs.gnu.org ([2001:4830:134:3::10]:38523)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1dZu4Z-0002L5-AD
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 03:16:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1dZu4U-0001d4-8p
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 03:16:03 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35838)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>) id 1dZu4U-0001ck-2H
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 03:15:58 -0400
References: <20170725023611.9169-1-rth@twiddle.net>
	<20170725023611.9169-2-rth@twiddle.net>
From: David Hildenbrand <david@redhat.com>
Message-ID: <cdb09afa-8d5e-1b01-ceaa-8075480be895@redhat.com>
Date: Tue, 25 Jul 2017 09:15:55 +0200
MIME-Version: 1.0
In-Reply-To: <20170725023611.9169-2-rth@twiddle.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 1/4] target/s390x: Add ilen to unwind data
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <rth@twiddle.net>, qemu-devel@nongnu.org


>  
> @@ -5656,6 +5658,7 @@ static const DisasInsn *extract_insn(CPUS390XState *env, DisasContext *s,
>      }
>      s->next_pc = s->pc + ilen;
>      s->ilen = ilen;
> +    tcg_set_insn_param(s->insn_start_idx, 2, ilen);

Ah, that's a nice trick :)

>  
>      /* We can't actually determine the insn format until we've looked up
>         the full insn opcode.  Which we can't do without locating the
> @@ -5890,7 +5893,10 @@ void gen_intermediate_code(CPUState *cs, struct TranslationBlock *tb)
>      gen_tb_start(tb);
>  
>      do {
> -        tcg_gen_insn_start(dc.pc, dc.cc_op);
> +        /* ??? Alternately, delay emitting insn_start until after we
> +           have computed the insn length in extract_insn.  */

Think this is just fine for now and you can drop the comment.

> +        dc.insn_start_idx = tcg_op_buf_count();
> +        tcg_gen_insn_start(dc.pc, dc.cc_op, 0);
>          num_insns++;
>  
>          if (unlikely(cpu_breakpoint_test(cs, dc.pc, BP_ANY))) {
> @@ -5984,4 +5990,5 @@ void restore_state_to_opc(CPUS390XState *env, TranslationBlock *tb,
>      if ((cc_op != CC_OP_DYNAMIC) && (cc_op != CC_OP_STATIC)) {
>          env->cc_op = cc_op;
>      }
> +    env->int_pgm_ilen = data[2];
>  }
> 

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 

Thanks,

David
