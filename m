Received: from eggs.gnu.org ([2001:4830:134:3::10]:42025)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1e1sNl-0003uX-Hc
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 07:07:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1e1sNk-00083v-HD
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 07:07:29 -0400
Received: from mail-wm0-x22e.google.com ([2a00:1450:400c:c09::22e]:54102)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1e1sNk-00083A-Aq
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 07:07:28 -0400
Received: by mail-wm0-x22e.google.com with SMTP id q132so4152557wmd.2
	for <qemu-devel@nongnu.org>; Tue, 10 Oct 2017 04:07:28 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <87y3oj9ssd.fsf@linaro.org>
References: <CAFEAcA_qCmsekM+bQT8qa7hceSSm2vcoYs-eTzKyH_BOpiVVcw@mail.gmail.com>
	<87zi8z9vng.fsf@linaro.org>
	<CAFEAcA92r=9F=1TTj3YznUSGZR_zzmThfPWvx=ryLjhJFmj__w@mail.gmail.com>
	<87y3oj9ssd.fsf@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 10 Oct 2017 12:07:06 +0100
Message-ID: <CAFEAcA-Z5k1Axb+7y+YZMGCoR2g_DLUe2-0mgZ9RPq6adRQhOg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] tcg/translate-all.c:169: tb_lock: Assertion
 `!have_tb_lock' failed when doing cpu_restore_state in usermode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Richard Henderson <rth@twiddle.net>

On 10 October 2017 at 11:54, Alex Benn=C3=A9e <alex.bennee@linaro.org> wrot=
e:
>
> Peter Maydell <peter.maydell@linaro.org> writes:
>
>> On 10 October 2017 at 10:53, Alex Benn=C3=A9e <alex.bennee@linaro.org> w=
rote:
>>>
>>> Peter Maydell <peter.maydell@linaro.org> writes:
>>>
>>>> Running the test program
>>>> http://people.linaro.org/~peter.maydell/thumb-over-page
>>>> (source at http://people.linaro.org/~peter.maydell/thumb-over-page.c)
>>>> in the usermode emulator:
>>>>  ./build/x86/arm-linux-user/qemu-arm
>>>> ~/linaro/qemu-misc-tests/thumb-over-page
>>>
>>> Does this fail when run via system mode as well?
>>
>> Nope, only usermode. (Makes sense, since the handle_cpu_signal()
>> codepath is only used in usermode emulation.)
>
> But surely system emulation has to deal with the same rolling over a
> page issue. How is it's resolution different?

In system emulation, the attempted load of code is via cpu_lduw_code(),
which in turn calls cpu_lduw_code_ra() passing it a retaddr parameter
of 0. This is then propagated through the softmmu functions until
it eventually reaches tlb_fill(), which then passes it to
cpu_restore_state() as the retaddr.

In usermode, we don't have the softmmu at all, so cpu_lduw_code()
turns into a straightforward host memory access, which is then
caught by the signal handler. The signal handler can't tell
whether it was invoked as a result of translated code or not,
so it just passes the PC of the host memory access to
cpu_restore_state(). cpu_restore_state() ought to check whether
the PC it is passed is within the TCG codegen buffer.

Incidentally cpu_restore_state currently says:
  /* A retaddr of zero is invalid so we really shouldn't have ended
   * up here.

but this isn't true -- it's an expected result for the case where
a zero retaddr was used, and we should deal with that in
cpu_restore_state() rather than making every caller do that test.

thanks
-- PMM
