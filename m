Received: from eggs.gnu.org ([2001:4830:134:3::10]:42483)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cELfW-0004A5-63
	for qemu-devel@nongnu.org; Tue, 06 Dec 2016 14:44:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cELfS-0005RB-Nt
	for qemu-devel@nongnu.org; Tue, 06 Dec 2016 14:44:50 -0500
Received: from mail-qt0-f194.google.com ([209.85.216.194]:33147)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1cELfS-0005Qx-JM
	for qemu-devel@nongnu.org; Tue, 06 Dec 2016 14:44:46 -0500
Received: by mail-qt0-f194.google.com with SMTP id n6so41668457qtd.0
	for <qemu-devel@nongnu.org>; Tue, 06 Dec 2016 11:44:46 -0800 (PST)
Sender: Richard Henderson <rth7680@gmail.com>
References: <001a113ec6308021110543008630@google.com>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <b7104b2b-eb57-1fcd-7dbd-f0b5138915be@twiddle.net>
Date: Tue, 6 Dec 2016 11:43:41 -0800
MIME-Version: 1.0
In-Reply-To: <001a113ec6308021110543008630@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] x86: Fix eflags tracking for syscall insn
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Doug Evans <dje@google.com>, qemu-devel@nongnu.org, pbonzini@redhat.com

On 12/06/2016 09:13 AM, Doug Evans wrote:
> @@ -7104,6 +7104,10 @@ static target_ulong disas_insn(CPUX86State *env,
> DisasContext *s,
>          gen_update_cc_op(s);
>          gen_jmp_im(pc_start - s->cs_base);
>          gen_helper_syscall(cpu_env, tcg_const_i32(s->pc - pc_start));
> +        /* condition codes are modified only in long mode */
> +        if (s->lma) {
> +            set_cc_op(s, CC_OP_EFLAGS);
> +        }

Since we will definitely end the TranslationBlock here, I'm a bit confused as
to how we get things wrong here.  Is this simply a visual inspection of the
code, or do you have a test case?

In gen_update_cc_op, we store the current version of CC_OP back to ENV.  This
lets helper_syscall (via cpu_compute_eflags) compute the proper value.  We then
store the updated version back via cpu_load_eflags, which sets ENV->CC_OP to
CC_OP_EFLAGS.

So far so good.

The only way I could see things going wrong is if we were to use DC->CC_OP
after the call to the helper.  But since we've (1) synced the value first and
(2) end the TB via gen_eob, I don't see how we would.

If any change is required, I think better would be

+  /* The syscall helper may read and modify EFLAGS.  */
   gen_update_cc_op(s);
+  set_cc_op(s, CC_OP_DYNAMIC);
   gen_jmp_im(pc_start - s->cs_base);
   gen_helper_syscall(cpu_env, tcg_const_i32(s->pc - pc_start));

This will tell subsequent code within the translator that it must re-read
ENV->CC_OP in order to compute the flags.


r~
