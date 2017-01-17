Received: from eggs.gnu.org ([2001:4830:134:3::10]:60967)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1cTYNJ-0002e1-GO
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 13:20:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1cTYNH-0004go-SD
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 13:20:53 -0500
Received: from mail-it0-x230.google.com ([2607:f8b0:4001:c0b::230]:33434)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jcmvbkbc@gmail.com>) id 1cTYNH-0004ge-4t
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 13:20:51 -0500
Received: by mail-it0-x230.google.com with SMTP id d9so28827962itc.0
	for <qemu-devel@nongnu.org>; Tue, 17 Jan 2017 10:20:51 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <f2f54dce-0e3f-2718-4b35-1321f5c2ae11@redhat.com>
References: <CAMo8BfLRP8qUgJAkU3fSwE_H6EmqYmPKO_MhMn7B6WpwGWUudw@mail.gmail.com>
	<001201d26b1b$e5a8ce20$b0fa6a60$@ru>
	<CAMo8BfJKXOhiPQz8GT6hXNNBXKsz-67iKx9ct9tEwukVLWR3QA@mail.gmail.com>
	<001201d26cc6$f023ad00$d06b0700$@ru>
	<CAFEAcA-AMJ33g9hO2k9oGJfDr-Fatk7TY+Sbs_wRC-OfCjWhmQ@mail.gmail.com>
	<001301d26cce$21ad3d30$6507b790$@ru>
	<f2f54dce-0e3f-2718-4b35-1321f5c2ae11@redhat.com>
From: Max Filippov <jcmvbkbc@gmail.com>
Date: Tue, 17 Jan 2017 10:20:49 -0800
Message-ID: <CAMo8Bf+RGjXNXoZpptu6u+Kc5y8j2a0RabxP0ODztRECBFpn-Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] implementing architectural timers using QEMU timers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Pavel Dovgalyuk <dovgaluk@ispras.ru>, Peter Maydell <peter.maydell@linaro.org>, Alex Bligh <alex@alex.org.uk>, qemu-devel <qemu-devel@nongnu.org>, Pavel Dovgaluk <Pavel.Dovgaluk@ispras.ru>, Richard Henderson <rth@twiddle.net>

On Mon, Jan 16, 2017 at 9:19 AM, Paolo Bonzini <pbonzini@redhat.com> wrote:
> On 12/01/2017 13:19, Pavel Dovgalyuk wrote:
>>> From: Peter Maydell [mailto:peter.maydell@linaro.org]
>>> On 12 January 2017 at 11:28, Pavel Dovgalyuk <dovgaluk@ispras.ru> wrote:
>>>>> From: Max Filippov [mailto:jcmvbkbc@gmail.com]
>>>>> Ok, looks like what happens in my case is that instruction that
>>>>> sets CCOMPARE and thus changes remaining icount does not
>>>>> cause exit from the cpu_exec. So merely ending TB on
>>>>> QEMU_CLOCK_VIRTUAL timer update is not enough, I need to
>>>>> throw an exception of some kind? Or does the timer code need
>>>>> to take care of that?
>>>>
>>>> Yes, it seems that you should end the block with an exception,
>>>> to allow icount loop recalculate the timeouts.
>>>
>>> Really? The ARM translate.c doesn't generate an exception.
>>> It just does
>>>  gen_io_end();
>>>  gen_lookup_tb();
>>>
>>> (so we force a lookup of the next TB, but don't throw an
>>> exception of any kind).
>>
>> Maybe I missing something. As far as I understand, changing the virtual timer
>> notifies the iothread and os_host_main_loop_wait kicks the CPU thread.
>>
>> But within that period of time before changing the timer and kicking the thread
>> CPU may proceed some instructions and the timer will be expired if it was set
>> to one of the soonest instructions.
>
> My understanding (which may be wrong!) was that after gen_io_end you
> would exit with TB_EXIT_ICOUNT_EXPIRED and cpu->icount_decr.u16.high =
> -1, but indeed I don't see anything that calls cpu_interrupt in that
> path.
>
> Maybe something like this:
>
> diff --git a/include/exec/gen-icount.h b/include/exec/gen-icount.h
> index 050de59..c20d193 100644
> --- a/include/exec/gen-icount.h
> +++ b/include/exec/gen-icount.h
> @@ -73,6 +73,9 @@ static inline void gen_io_end(void)
>  {
>      TCGv_i32 tmp = tcg_const_i32(0);
>      tcg_gen_st_i32(tmp, cpu_env, -ENV_OFFSET + offsetof(CPUState, can_do_io));
> +    /* Make the next TB exit immediately with TB_EXIT_ICOUNT_EXPIRED.  */
> +    tcg_gen_st16_i32(-1, cpu_env,
> +                     -ENV_OFFSET + offsetof(CPUState, icount_decr.u16.high));
>      tcg_temp_free_i32(tmp);
>  }

With -1 moved into TCG temporary that works for me as well.

-- 
Thanks.
-- Max
