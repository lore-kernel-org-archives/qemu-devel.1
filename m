Received: from eggs.gnu.org ([2001:4830:134:3::10]:58674)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bobby.prani@gmail.com>) id 1cg1iX-0000Ds-F5
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 23:06:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bobby.prani@gmail.com>) id 1cg1iW-0002Rl-GI
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 23:06:21 -0500
Received: from mail-ot0-x242.google.com ([2607:f8b0:4003:c0f::242]:33649)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bobby.prani@gmail.com>)
	id 1cg1iW-0002Rd-AH
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 23:06:20 -0500
Received: by mail-ot0-x242.google.com with SMTP id k4so2254564otc.0
	for <qemu-devel@nongnu.org>; Mon, 20 Feb 2017 20:06:20 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <87d1ecwfca.fsf@linaro.org>
References: <20170220145335.591-1-bobby.prani@gmail.com>
	<87fuj8x2gi.fsf@linaro.org>
	<87k28ko1qw.fsf@gmail.com> <87d1ecwfca.fsf@linaro.org>
From: Pranith Kumar <bobby.prani@gmail.com>
Date: Mon, 20 Feb 2017 23:05:49 -0500
Message-ID: <CAJhHMCDtnNdB8cq8Km44oDsRLerMWh12F=PiP+tFiVZUtk+ORg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] mttcg: Set jmp_env to handle exit from
 tb_gen_code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: qemu-devel <qemu-devel@nongnu.org>, Richard Henderson <rth@twiddle.net>

On Mon, Feb 20, 2017 at 7:35 PM, Alex Benn=C3=A9e <alex.bennee@linaro.org> =
wrote:
>
> Pranith Kumar <bobby.prani@gmail.com> writes:
>
>> Alex Benn=C3=A9e writes:
>>
>>> Pranith Kumar <bobby.prani@gmail.com> writes:
>>>
>>>> tb_gen_code() can exit execution using cpu_exit_loop() when it cannot
>>>> allocate new tb's. To handle this, we need to properly set the jmp_env
>>>> pointer ahead of calling tb_gen_code().
>>>>
>>>> CC:Alex Benn=C3=A9e <alex.bennee@linaro.org>
>>>> CC: Richard Henderson <rth@twiddle.net>
>>>> Signed-off-by: Pranith Kumar <bobby.prani@gmail.com>
>>>> ---
>>>>  cpu-exec.c | 23 +++++++++++------------
>>>>  1 file changed, 11 insertions(+), 12 deletions(-)
>>>>
>>>> diff --git a/cpu-exec.c b/cpu-exec.c
>>>> index 97d79612d9..4b70988b24 100644
>>>> --- a/cpu-exec.c
>>>> +++ b/cpu-exec.c
>>>> @@ -236,23 +236,22 @@ static void cpu_exec_step(CPUState *cpu)
>>>>
>>>>      cpu_get_tb_cpu_state(env, &pc, &cs_base, &flags);
>>>>      tb_lock();
>>>> -    tb =3D tb_gen_code(cpu, pc, cs_base, flags,
>>>> -                     1 | CF_NOCACHE | CF_IGNORE_ICOUNT);
>>>> -    tb->orig_tb =3D NULL;
>>>> -    tb_unlock();
>>>> -
>>>> -    cc->cpu_exec_enter(cpu);
>>>> -
>>>
>>> It occurs to me we are also diverging in our locking pattern from
>>> tb_find which takes mmap_lock first. This is a NOP for system emulation
>>> but needed for user-emulation (for which we can do cpu_exec_step but no=
t
>>> cpu_exec_nocache).
>>
>> Right. So we have to take the mmap_lock() before calling
>> tb_gen_code(). However, this lock is released in the error path before c=
alling
>> cpu_loop_exit() if allocation of a new tb fails. The following is what I=
 have
>> after merging with the previous EXCP_ATOMIC handling patch.
>
> Hmm we are a start/end_exclusive() though so what could we be racing
> against that also wants the mmap_lock()? Could it be held by anything at
> this point as every user needs to be woken up?
>

No, I don't think any other thread holds the mmap/tb lock at this
point. However, we still need to take this lock since the functions we
are calling expect us to hold it and assert otherwise.


--=20
Pranith
