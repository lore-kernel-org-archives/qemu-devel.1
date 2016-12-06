Received: from eggs.gnu.org ([2001:4830:134:3::10]:49731)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dje@google.com>) id 1cEONx-0001aV-3B
	for qemu-devel@nongnu.org; Tue, 06 Dec 2016 17:38:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dje@google.com>) id 1cEONt-0001Sq-SU
	for qemu-devel@nongnu.org; Tue, 06 Dec 2016 17:38:53 -0500
Received: from mail-io0-f174.google.com ([209.85.223.174]:35329)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <dje@google.com>) id 1cEONt-0001PU-Mu
	for qemu-devel@nongnu.org; Tue, 06 Dec 2016 17:38:49 -0500
Received: by mail-io0-f174.google.com with SMTP id a124so680489932ioe.2
	for <qemu-devel@nongnu.org>; Tue, 06 Dec 2016 14:38:28 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <b7104b2b-eb57-1fcd-7dbd-f0b5138915be@twiddle.net>
References: <001a113ec6308021110543008630@google.com>
	<b7104b2b-eb57-1fcd-7dbd-f0b5138915be@twiddle.net>
From: Doug Evans <dje@google.com>
Date: Tue, 6 Dec 2016 14:36:46 -0800
Message-ID: <CADPb22RE55fQGf97RWpJ19bAhet7RUYi4BNEk_Y=ZC7SpJ2L0w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH] x86: Fix eflags tracking for syscall insn
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <rth@twiddle.net>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>

On Tue, Dec 6, 2016 at 11:43 AM, Richard Henderson <rth@twiddle.net> wrote:
> On 12/06/2016 09:13 AM, Doug Evans wrote:
>> @@ -7104,6 +7104,10 @@ static target_ulong disas_insn(CPUX86State *env,
>> DisasContext *s,
>>          gen_update_cc_op(s);
>>          gen_jmp_im(pc_start - s->cs_base);
>>          gen_helper_syscall(cpu_env, tcg_const_i32(s->pc - pc_start));
>> +        /* condition codes are modified only in long mode */
>> +        if (s->lma) {
>> +            set_cc_op(s, CC_OP_EFLAGS);
>> +        }
>
> Since we will definitely end the TranslationBlock here, I'm a bit confused as
> to how we get things wrong here.  Is this simply a visual inspection of the
> code, or do you have a test case?

Visual inspection and looking at what other code does.
[eflags handling is very clever, but a bit obscure - I'm sure just a
bit more documentation
would help but I dunno if it's "just me" ...]

> In gen_update_cc_op, we store the current version of CC_OP back to ENV.  This
> lets helper_syscall (via cpu_compute_eflags) compute the proper value.  We then
> store the updated version back via cpu_load_eflags, which sets ENV->CC_OP to
> CC_OP_EFLAGS.
>
> So far so good.
>
> The only way I could see things going wrong is if we were to use DC->CC_OP
> after the call to the helper.  But since we've (1) synced the value first and
> (2) end the TB via gen_eob, I don't see how we would.
>
> If any change is required, I think better would be
>
> +  /* The syscall helper may read and modify EFLAGS.  */
>    gen_update_cc_op(s);
> +  set_cc_op(s, CC_OP_DYNAMIC);
>    gen_jmp_im(pc_start - s->cs_base);
>    gen_helper_syscall(cpu_env, tcg_const_i32(s->pc - pc_start));
>
> This will tell subsequent code within the translator that it must re-read
> ENV->CC_OP in order to compute the flags.

Ah.
