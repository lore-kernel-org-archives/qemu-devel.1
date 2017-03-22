Received: from eggs.gnu.org ([2001:4830:134:3::10]:47777)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bobby.prani@gmail.com>) id 1cqhyp-0003pw-Ig
	for qemu-devel@nongnu.org; Wed, 22 Mar 2017 11:15:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bobby.prani@gmail.com>) id 1cqhyo-00070i-Op
	for qemu-devel@nongnu.org; Wed, 22 Mar 2017 11:15:19 -0400
Received: from mail-yw0-x241.google.com ([2607:f8b0:4002:c05::241]:32925)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bobby.prani@gmail.com>)
	id 1cqhyo-00070R-IZ
	for qemu-devel@nongnu.org; Wed, 22 Mar 2017 11:15:18 -0400
Received: by mail-yw0-x241.google.com with SMTP id p77so20577950ywg.0
	for <qemu-devel@nongnu.org>; Wed, 22 Mar 2017 08:15:18 -0700 (PDT)
MIME-Version: 1.0
Sender: bobby.prani@gmail.com
In-Reply-To: <CAFEAcA9ZtayLn-bOPL4=2=w0SS_H0-EYO0UpFzXJSvyueGOHMw@mail.gmail.com>
References: <CAG48ez1tcz7GGsc5+L3EF140NsW=UyNir=0UpuZZYrBn4ZxrSA@mail.gmail.com>
	<CAFEAcA8-GJxpmppZGF5ygSAL4Y81BdvYKqso-XhjR2pbjMLi+A@mail.gmail.com>
	<CAJhHMCA=rwLqLOPq3kMOz9SpV83yrzkK_K6RfPmuyXMU1pXT7g@mail.gmail.com>
	<CAFEAcA9ZtayLn-bOPL4=2=w0SS_H0-EYO0UpFzXJSvyueGOHMw@mail.gmail.com>
From: Pranith Kumar <bobby.prani+qemu@gmail.com>
Date: Wed, 22 Mar 2017 11:14:47 -0400
Message-ID: <CAJhHMCAjG1kfG8-3E8CcWu4V2cWMsR0La6iZ3hq0rbM91+brsA@mail.gmail.com>
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
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Jann Horn <jannh@google.com>, Qemu Developers <qemu-devel@nongnu.org>, Richard Henderson <rth@twiddle.net>

On Wed, Mar 22, 2017 at 11:04 AM, Peter Maydell
<peter.maydell@linaro.org> wrote:
>>
>> How about doing the instruction size check as follows?
>>
>> diff --git a/target/i386/translate.c b/target/i386/translate.c
>> index 72c1b03a2a..94cf3da719 100644
>> --- a/target/i386/translate.c
>> +++ b/target/i386/translate.c
>> @@ -8235,6 +8235,10 @@ static target_ulong disas_insn(CPUX86State
>> *env, DisasContext *s,
>>      default:
>>          goto unknown_op;
>>      }
>> +    if (s->pc - pc_start > 15) {
>> +        s->pc = pc_start;
>> +        goto illegal_op;
>> +    }
>>      return s->pc;
>>   illegal_op:
>>      gen_illegal_opcode(s);
>
> This doesn't look right because it means we'll check
> only after we've emitted all the code to do the
> instruction operation, so the effect will be
> "execute instruction, then take illegal-opcode
> exception".
>

The pc is restored to original address (s->pc = pc_start), so the
exception will overwrite the generated illegal instruction and will be
executed first.

But yes, it's better to follow the architecture manual.

Thanks,
--
Pranith
