Received: from eggs.gnu.org ([2001:4830:134:3::10]:44806)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cdMkZ-0004XU-Ol
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 14:57:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cdMkW-00069T-Nl
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 14:57:27 -0500
Received: from mail-qk0-x243.google.com ([2607:f8b0:400d:c09::243]:33983)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1cdMkW-00069L-J9
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 14:57:24 -0500
Received: by mail-qk0-x243.google.com with SMTP id e1so16446859qkh.1
	for <qemu-devel@nongnu.org>; Mon, 13 Feb 2017 11:57:24 -0800 (PST)
Sender: Richard Henderson <rth7680@gmail.com>
References: <20170213121017.12907-1-alex.bennee@linaro.org>
	<20170213121017.12907-13-alex.bennee@linaro.org>
	<0d990570-8318-7bba-c10c-cfe0387fdd1b@twiddle.net>
	<CAJhHMCBN903SJ32oSpOnx-ZFvVGwBFuX2B7=aSffBy2=0F=Jpg@mail.gmail.com>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <5d7c638b-fe9f-c03f-4ba1-60dca3f7811a@twiddle.net>
Date: Tue, 14 Feb 2017 06:57:13 +1100
MIME-Version: 1.0
In-Reply-To: <CAJhHMCBN903SJ32oSpOnx-ZFvVGwBFuX2B7=aSffBy2=0F=Jpg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v12 12/24] tcg: handle EXCP_ATOMIC
 exception for system emulation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pranith Kumar <bobby.prani@gmail.com>
Cc: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, Peter Maydell <peter.maydell@linaro.org>, mttcg@greensocs.com, qemu-devel <qemu-devel@nongnu.org>, =?UTF-8?B?S09OUkFEIEZyw6lkw6lyaWM=?= <fred.konrad@greensocs.com>, alvise rigo <a.rigo@virtualopensystems.com>, "Emilio G. Cota" <cota@braap.org>, nikunj@linux.vnet.ibm.com, Mark Burton <mark.burton@greensocs.com>, Paolo Bonzini <pbonzini@redhat.com>, Jan Kiszka <jan.kiszka@siemens.com>, Sergey Fedorov <serge.fdrv@gmail.com>, Bamvor Zhang Jian <bamvor.zhangjian@linaro.org>, Peter Crosthwaite <crosthwaite.peter@gmail.com>

On 02/14/2017 06:33 AM, Pranith Kumar wrote:
> On Mon, Feb 13, 2017 at 2:19 PM, Richard Henderson <rth@twiddle.net> wrote:
>> On 02/13/2017 11:10 PM, Alex Bennée wrote:
>>>
>>> @@ -239,9 +240,16 @@ static void cpu_exec_step(CPUState *cpu)
>>>                       1 | CF_NOCACHE | CF_IGNORE_ICOUNT);
>>>      tb->orig_tb = NULL;
>>>      tb_unlock();
>>> -    /* execute the generated code */
>>> -    trace_exec_tb_nocache(tb, pc);
>>> -    cpu_tb_exec(cpu, tb);
>>> +
>>> +    cc->cpu_exec_enter(cpu);
>>> +
>>> +    if (sigsetjmp(cpu->jmp_env, 0) == 0) {
>>> +        /* execute the generated code */
>>> +        trace_exec_tb_nocache(tb, pc);
>>> +        cpu_tb_exec(cpu, tb);
>>> +    }
>>
>>
>> I don't understand this, since cpu_tb_exec has its own sigsetjmp.  Where is
>> the exception supposed to come from that escapes?
>
> cpu_exec() has its own sigsetjmp, not cpu_tb_exec(). The exception is
> the debug exception from the generated code. Without this new
> sigsetjmp, it'll jump to cpu_exec() instead of coming back here.

Bah.  Sorry, ENOCOFFEE.

Reviewed-by: Richard Henderson <rth@twiddle.net>


r~
