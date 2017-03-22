Received: from eggs.gnu.org ([2001:4830:134:3::10]:44640)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cqhoo-0000QK-Ri
	for qemu-devel@nongnu.org; Wed, 22 Mar 2017 11:05:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cqhon-0001ef-Sn
	for qemu-devel@nongnu.org; Wed, 22 Mar 2017 11:04:58 -0400
Received: from mail-wr0-x22d.google.com ([2a00:1450:400c:c0c::22d]:35300)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cqhon-0001eA-Mo
	for qemu-devel@nongnu.org; Wed, 22 Mar 2017 11:04:57 -0400
Received: by mail-wr0-x22d.google.com with SMTP id g10so131232169wrg.2
	for <qemu-devel@nongnu.org>; Wed, 22 Mar 2017 08:04:57 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAJhHMCA=rwLqLOPq3kMOz9SpV83yrzkK_K6RfPmuyXMU1pXT7g@mail.gmail.com>
References: <CAG48ez1tcz7GGsc5+L3EF140NsW=UyNir=0UpuZZYrBn4ZxrSA@mail.gmail.com>
	<CAFEAcA8-GJxpmppZGF5ygSAL4Y81BdvYKqso-XhjR2pbjMLi+A@mail.gmail.com>
	<CAJhHMCA=rwLqLOPq3kMOz9SpV83yrzkK_K6RfPmuyXMU1pXT7g@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 22 Mar 2017 15:04:35 +0000
Message-ID: <CAFEAcA9ZtayLn-bOPL4=2=w0SS_H0-EYO0UpFzXJSvyueGOHMw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [BUG] user-to-root privesc inside VM via bad
 translation caching
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pranith Kumar <bobby.prani+qemu@gmail.com>
Cc: Jann Horn <jannh@google.com>, Qemu Developers <qemu-devel@nongnu.org>

On 22 March 2017 at 14:55, Pranith Kumar <bobby.prani+qemu@gmail.com> wrote:
> On Mon, Mar 20, 2017 at 10:46 AM, Peter Maydell wrote:
>> On 20 March 2017 at 14:36, Jann Horn <jannh@google.com> wrote:
>>> This is an issue in QEMU's system emulation for X86 in TCG mode.
>>> The issue permits an attacker who can execute code in guest ring 3
>>> with normal user privileges to inject code into other processes that
>>> are running in guest ring 3, in particular root-owned processes.
>>
>>> I am sending this to qemu-devel because a QEMU security contact
>>> told me that QEMU does not consider privilege escalation inside a
>>> TCG VM to be a security concern.
>>
>> Correct; it's just a bug. Don't trust TCG QEMU as a security boundary.
>>
>> We should really fix the crossing-a-page-boundary code for x86.
>> I believe we do get it correct for ARM Thumb instructions.
>
> How about doing the instruction size check as follows?
>
> diff --git a/target/i386/translate.c b/target/i386/translate.c
> index 72c1b03a2a..94cf3da719 100644
> --- a/target/i386/translate.c
> +++ b/target/i386/translate.c
> @@ -8235,6 +8235,10 @@ static target_ulong disas_insn(CPUX86State
> *env, DisasContext *s,
>      default:
>          goto unknown_op;
>      }
> +    if (s->pc - pc_start > 15) {
> +        s->pc = pc_start;
> +        goto illegal_op;
> +    }
>      return s->pc;
>   illegal_op:
>      gen_illegal_opcode(s);

This doesn't look right because it means we'll check
only after we've emitted all the code to do the
instruction operation, so the effect will be
"execute instruction, then take illegal-opcode
exception".

We should check what the x86 architecture spec actually
says and implement that.

thanks
-- PMM
