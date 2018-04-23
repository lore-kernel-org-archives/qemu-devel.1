Received: from eggs.gnu.org ([2001:4830:134:3::10]:56210)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fAdRF-0003HN-GD
	for qemu-devel@nongnu.org; Mon, 23 Apr 2018 11:31:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fAdRE-0007JS-J5
	for qemu-devel@nongnu.org; Mon, 23 Apr 2018 11:31:33 -0400
Received: from mail-ot0-x231.google.com ([2607:f8b0:4003:c0f::231]:36396)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fAdRE-0007J3-Ds
	for qemu-devel@nongnu.org; Mon, 23 Apr 2018 11:31:32 -0400
Received: by mail-ot0-x231.google.com with SMTP id p2-v6so17661948otf.3
	for <qemu-devel@nongnu.org>; Mon, 23 Apr 2018 08:31:32 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <e749ca16-26bc-b900-d6b3-a06007e6d572@st.com>
References: <20180423075215.4572-1-christophe.lyon@st.com>
	<20180423075215.4572-5-christophe.lyon@st.com>
	<CAFEAcA954r6mp3ouyDS4qDWJusBQaP=MfyOsd+Pd1OTeRsGwBg@mail.gmail.com>
	<e749ca16-26bc-b900-d6b3-a06007e6d572@st.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 23 Apr 2018 16:31:11 +0100
Message-ID: <CAFEAcA8L7n4vrdfe2GL9ASpFLiPdsDs+KfgbAYpacNMQuFHp7w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [ARM/FDPIC v2 4/4] linux-user: ARM-FDPIC: Add
 support for signals for FDPIC targets
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Christophe Lyon <christophe.lyon@st.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Christophe Lyon <christophe.lyon@linaro.org>, Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>

On 23 April 2018 at 15:22, Christophe Lyon <christophe.lyon@st.com> wrote:
> On 23/04/2018 15:05, Peter Maydell wrote:
>>
>> On 23 April 2018 at 08:51, Christophe Lyon <christophe.lyon@st.com> wrote:
>>> @@ -2149,7 +2164,21 @@ setup_return(CPUARMState *env, struct
>>> target_sigaction *ka,
>>>   {
>>>       abi_ulong handler = ka->_sa_handler;
>>>       abi_ulong retcode;
>>> -    int thumb = handler & 1;
>>> +    abi_ulong funcdesc_ptr = 0;
>>> +
>>> +    int thumb;
>>> +    int is_fdpic = ((TaskState *)thread_cpu->opaque)->is_fdpic;
>>> +
>>> +    if (is_fdpic) {
>>> +        /* In FDPIC mode, ka->_sa_handler points to a function
>>> +         * descriptor (FD). The first word contains the address of the
>>> +         * handler. The second word contains the value of the PIC
>>> +         * register (r9).  */
>>> +        funcdesc_ptr = ka->_sa_handler;
>>
>>
>> You already have ka->_sa_handler in the 'handler' local, so you
>> can just use that.
>>
> OK, I thought it was clearer to use a different name.

The other way to structure that would be to put
    handler = ka->_sa_handler;

in an else clause of this if ().

>>> +        get_user_ual(handler, funcdesc_ptr);
>>
>>
>> You need to check whether get_user_ual() returned non-zero
>> (indicating that the descriptor isn't readable) and handle that.
>>
> Ha... I feared that :)
> I noticed that quite a lot of get_user_XXX() calls do not
> check the returned value, and since this patch changes
> void setup_return(), I'm not sure what to do in case of
> read error? Call abort() or is there a global flag
> for this purpose, that I should set and which would
> be checked by the caller?

You need to:
 * make setup_return() return an error indication
   (other code in this file seems to follow the kernel's
   example and have this be a return value that's true on
   an error and false otherwise)
 * have the callers check the error indication, and
   if there was an error do:
     - unlock the user struct
     - call force_sigsegv()

All the callers already have code for doing force_sigsegv,
though they don't yet have a codepath that handles doing
the unlock first. You should be able to just put in
the call to unlock_user_struct(frame, ...) at the existing 'sigsegv:'
labels, because that is guaranteed to be safe on a NULL
host pointer, which is what you'll get in the other
code paths that go to that label. Then you can have
the error check be
    if (setup_return(...)) {
        goto sigsegv;
    }

thanks
-- PMM
