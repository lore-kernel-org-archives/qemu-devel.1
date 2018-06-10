Received: from eggs.gnu.org ([2001:4830:134:3::10]:49966)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fRzd8-0004GM-Tj
	for qemu-devel@nongnu.org; Sun, 10 Jun 2018 08:39:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fRzd7-0004mU-W0
	for qemu-devel@nongnu.org; Sun, 10 Jun 2018 08:39:34 -0400
Received: from mail-ot0-x242.google.com ([2607:f8b0:4003:c0f::242]:39678)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fRzd7-0004kw-Ix
	for qemu-devel@nongnu.org; Sun, 10 Jun 2018 08:39:33 -0400
Received: by mail-ot0-x242.google.com with SMTP id l15-v6so19739488oth.6
	for <qemu-devel@nongnu.org>; Sun, 10 Jun 2018 05:39:33 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8+NuuT_TDkQuh=C9Mo3xod=745fSTjSP7umSUrt8PFBg@mail.gmail.com>
References: <20180610030220.3777-1-richard.henderson@linaro.org>
	<20180610030220.3777-10-richard.henderson@linaro.org>
	<CAFEAcA8+NuuT_TDkQuh=C9Mo3xod=745fSTjSP7umSUrt8PFBg@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sun, 10 Jun 2018 13:39:12 +0100
Message-ID: <CAFEAcA-ugGMyvJDizrDC51co_L5aF=BS0zZ98kvo_VE9JOLGOQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v2 009/108] linux-user: Set up
 infrastructure for table-izing syscalls
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Laurent Vivier <laurent@vivier.eu>

On 10 June 2018 at 13:32, Peter Maydell <peter.maydell@linaro.org> wrote:
> On 10 June 2018 at 04:00, Richard Henderson
> <richard.henderson@linaro.org> wrote:
>> At the same time, split out set_robust_list and get_robust_list.
>> Put them together, along with their block comment, at the top
>> of syscall_table.
>>
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

>> +/* For a given syscall number, return a function implementing it.
>> + * Do this via switch statement instead of table because some targets
>> + * do not begin at 0 and others have a large split in the middle of
>> + * the numbers.  The compiler should be able to produce a dense table.
>> + */

> I was expecting this to be a table lookup, something like
>    return syscalls[num].impl;
>
> where the other entries in the syscalls[num] structs would be
> for instance the strace data we currently have in strace.list.

Ah, I see the comment covers this. I'd still rather we had all
the information related to a syscall in one place, though -- this
way we end up with the ifdefs and so on which determine whether
a syscall is implemented having to be duplicated:
 (a) in the implementation
 (b) in this switch code
 (c) in the handling of strace
It would be cleaner to have a single
#if something
static foo_impl(..) { ... }
static syscall_impl foo = {
    .name = "foo",
    .impl = foo_impl,
    .strace_stuff = ...,
};
register_syscall(foo);
#endif

Hash table?

thanks
-- PMM
