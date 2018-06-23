Received: from eggs.gnu.org ([2001:4830:134:3::10]:46475)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fWgOD-0005yp-Ts
	for qemu-devel@nongnu.org; Sat, 23 Jun 2018 07:07:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fWgOA-0002MM-Nz
	for qemu-devel@nongnu.org; Sat, 23 Jun 2018 07:07:33 -0400
Received: from mail-wm0-x230.google.com ([2a00:1450:400c:c09::230]:33637)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1fWgOA-0002M5-F6
	for qemu-devel@nongnu.org; Sat, 23 Jun 2018 07:07:30 -0400
Received: by mail-wm0-x230.google.com with SMTP id z6-v6so8313084wma.0
	for <qemu-devel@nongnu.org>; Sat, 23 Jun 2018 04:07:30 -0700 (PDT)
References: <20180621184116.910-1-alex.bennee@linaro.org>
	<CAMo8BfJ+Y9didgKKvrWJiuYOd+qUyxpjy75mBaOzspCt5eHZDA@mail.gmail.com>
	<87efgzur9n.fsf@linaro.org>
	<CAMo8BfJ0sCaGt2Bj8H9aGWBUpCK3qMCDKD8BTtVQp2Y6+eXnPQ@mail.gmail.com>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <CAMo8BfJ0sCaGt2Bj8H9aGWBUpCK3qMCDKD8BTtVQp2Y6+eXnPQ@mail.gmail.com>
Date: Sat, 23 Jun 2018 12:07:27 +0100
Message-ID: <87in692234.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] blogposts: add post about the new
 check-tcg infrastructure
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Filippov <jcmvbkbc@gmail.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>


Max Filippov <jcmvbkbc@gmail.com> writes:

> On Fri, Jun 22, 2018 at 2:03 AM, Alex Benn=C3=A9e <alex.bennee@linaro.org=
> wrote:
>>
>> Max Filippov <jcmvbkbc@gmail.com> writes:
>>
>>> On Thu, Jun 21, 2018 at 11:41 AM, Alex Benn=C3=A9e <alex.bennee@linaro.=
org> wrote:
>>>> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>>>> ---
>>>>  _posts/2018-06-21-tcg-testing.md | 129 +++++++++++++++++++++++++++++++
>>>>  1 file changed, 129 insertions(+)
>>>>  create mode 100644 _posts/2018-06-21-tcg-testing.md
>>>>
>>>> diff --git a/_posts/2018-06-21-tcg-testing.md b/_posts/2018-06-21-tcg-=
testing.md
>>>
>>> [...]
>>>
>>>> +The `tests/tcg` directory still contains a number of source files we
>>>> +don't build. Notably the cris, lm32, mips, openrisc and xtensa target=
s have
>>>> +a set of tests that need a system emulator. Now we have the
>>>> +infrastructure for compiling I hope we can get support for system
>>>> +tests added fairly quickly. There will need to be some work to figure
>>>> +out a nice common way to pass results back to the build-system. For
>>>> +linux-user this is simple as all programs can simply return their exit
>>>> +code however for system emulation this is a little more involved.
>>>
>>> xtensa tests pass exit codes to the build system through semihosting ca=
lls.
>>> If any of them fails make check fails as well.
>>
>> I've re-written that section as:
>>
>>   The `tests/tcg` directory still contains a number of source files we
>>   don't build.
>>
>>   The cris and openrisc directories contain user-space tests which just
>>   need the support of a toolchain and the relevant Makefile plumbing to
>>   be added.
>>
>>   The lm32, mips and xtensa targets have a set of tests that need a
>>   system emulator. Aside from adding the compilers as docker images some
>>   additional work is needed to handle the differences between plain
>>   linux-user tests which can simply return an exit code to getting the
>>   results from a qemu-system emulation. Some architectures have
>>   semi-hosting support already for this while others report their test
>>   status over a simple serial link which will need to be parsed and
>>   handled in the `run-%:` test rule.
>>
>> How is that?
>
> 'run-%' goal is only present in xtensa Makefile, other test suites have
> explicit loop in the 'check' goal. Otherwise LGTM.

The TCG tests added a generic run-% rule:

  run-%: %
          $(call run-test, $<, $(QEMU) $<, "$< on $(TARGET_NAME)")

Although individual tests can override it.

>
>> Any chance you could look into what it would take to package up the
>> xtensa toolchain in a docker container?
>
> Can you point me to an example?

Well this was the base attempt:

https://github.com/stsquad/qemu/commit/daee9dc013b13b13e81f720176c5e379c05e=
d0e0

So I guess we need to add the overlay to the image?

>
>> Are they simply tarballs of binaries?
>
> Yes, we have that option:
>
>   https://github.com/foss-xtensa/toolchain/releases
>
> Or they may be built from source.


--
Alex Benn=C3=A9e
