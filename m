Received: from eggs.gnu.org ([2001:4830:134:3::10]:34110)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cTAwi-0002GH-0n
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 12:19:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cTAwc-0006bL-Er
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 12:19:51 -0500
Received: from mail-lf0-x243.google.com ([2a00:1450:4010:c07::243]:35551)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1cTAwc-0006bB-74
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 12:19:46 -0500
Received: by mail-lf0-x243.google.com with SMTP id v186so13474737lfa.2
	for <qemu-devel@nongnu.org>; Mon, 16 Jan 2017 09:19:46 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
References: <CAMo8BfLRP8qUgJAkU3fSwE_H6EmqYmPKO_MhMn7B6WpwGWUudw@mail.gmail.com>
	<001201d26b1b$e5a8ce20$b0fa6a60$@ru>
	<CAMo8BfJKXOhiPQz8GT6hXNNBXKsz-67iKx9ct9tEwukVLWR3QA@mail.gmail.com>
	<001201d26cc6$f023ad00$d06b0700$@ru>
	<CAFEAcA-AMJ33g9hO2k9oGJfDr-Fatk7TY+Sbs_wRC-OfCjWhmQ@mail.gmail.com>
	<001301d26cce$21ad3d30$6507b790$@ru>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <f2f54dce-0e3f-2718-4b35-1321f5c2ae11@redhat.com>
Date: Mon, 16 Jan 2017 18:19:42 +0100
MIME-Version: 1.0
In-Reply-To: <001301d26cce$21ad3d30$6507b790$@ru>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] implementing architectural timers using QEMU timers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pavel Dovgalyuk <dovgaluk@ispras.ru>, 'Peter Maydell' <peter.maydell@linaro.org>
Cc: 'Alex Bligh' <alex@alex.org.uk>, 'Max Filippov' <jcmvbkbc@gmail.com>, 'qemu-devel' <qemu-devel@nongnu.org>, 'Pavel Dovgaluk' <Pavel.Dovgaluk@ispras.ru>, 'Richard Henderson' <rth@twiddle.net>



On 12/01/2017 13:19, Pavel Dovgalyuk wrote:
>> From: Peter Maydell [mailto:peter.maydell@linaro.org]
>> On 12 January 2017 at 11:28, Pavel Dovgalyuk <dovgaluk@ispras.ru> wrote:
>>>> From: Max Filippov [mailto:jcmvbkbc@gmail.com]
>>>> Ok, looks like what happens in my case is that instruction that
>>>> sets CCOMPARE and thus changes remaining icount does not
>>>> cause exit from the cpu_exec. So merely ending TB on
>>>> QEMU_CLOCK_VIRTUAL timer update is not enough, I need to
>>>> throw an exception of some kind? Or does the timer code need
>>>> to take care of that?
>>>
>>> Yes, it seems that you should end the block with an exception,
>>> to allow icount loop recalculate the timeouts.
>>
>> Really? The ARM translate.c doesn't generate an exception.
>> It just does
>>  gen_io_end();
>>  gen_lookup_tb();
>>
>> (so we force a lookup of the next TB, but don't throw an
>> exception of any kind).
> 
> Maybe I missing something. As far as I understand, changing the virtual timer 
> notifies the iothread and os_host_main_loop_wait kicks the CPU thread.
> 
> But within that period of time before changing the timer and kicking the thread
> CPU may proceed some instructions and the timer will be expired if it was set
> to one of the soonest instructions.

My understanding (which may be wrong!) was that after gen_io_end you 
would exit with TB_EXIT_ICOUNT_EXPIRED and cpu->icount_decr.u16.high = 
-1, but indeed I don't see anything that calls cpu_interrupt in that 
path.

Maybe something like this:

diff --git a/include/exec/gen-icount.h b/include/exec/gen-icount.h
index 050de59..c20d193 100644
--- a/include/exec/gen-icount.h
+++ b/include/exec/gen-icount.h
@@ -73,6 +73,9 @@ static inline void gen_io_end(void)
 {
     TCGv_i32 tmp = tcg_const_i32(0);
     tcg_gen_st_i32(tmp, cpu_env, -ENV_OFFSET + offsetof(CPUState, can_do_io));
+    /* Make the next TB exit immediately with TB_EXIT_ICOUNT_EXPIRED.  */
+    tcg_gen_st16_i32(-1, cpu_env,
+                     -ENV_OFFSET + offsetof(CPUState, icount_decr.u16.high));
     tcg_temp_free_i32(tmp);
 }
 

?

Paolo
