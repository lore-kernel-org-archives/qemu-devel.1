Received: from eggs.gnu.org ([2001:4830:134:3::10]:35260)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cYdcz-0005SQ-Ff
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 13:58:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cYdcy-0005PV-Jp
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 13:58:05 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <1485879287-12548-1-git-send-email-peter.maydell@linaro.org>
	<87wpdbw2ki.fsf@dusky.pond.sub.org>
	<CAFEAcA-Ggv2VGszZg0Ld3-1wm=hVe8w=4ZcQ7TDRHf5Puq88ug@mail.gmail.com>
Date: Tue, 31 Jan 2017 19:58:01 +0100
In-Reply-To: <CAFEAcA-Ggv2VGszZg0Ld3-1wm=hVe8w=4ZcQ7TDRHf5Puq88ug@mail.gmail.com>
	(Peter Maydell's message of "Tue, 31 Jan 2017 18:00:13 +0000")
Message-ID: <87fujznjk6.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH] Drop QEMU_GNUC_PREREQ() checks for gcc
 older than 4.1
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Trivial <qemu-trivial@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, "patches@linaro.org" <patches@linaro.org>

Peter Maydell <peter.maydell@linaro.org> writes:

> On 31 January 2017 at 17:40, Markus Armbruster <armbru@redhat.com> wrote:
>> Peter Maydell <peter.maydell@linaro.org> writes:
>>
>>> We already require gcc 4.1 or newer (for the atomic
>>> support), so the fallback codepaths for older gcc
>>> versions than that are now dead code and we can
>>> just delete them.
>>>
>>> NB: clang reports itself as gcc 4.2 (regardless of
>>> clang version), so clang won't be using the fallbacks
>>> either.
>>>
>>> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
>>> ---
>>> For compatibility with clang we should probably try to avoid
>>> using QEMU_GNUC_PREREQ() and instead have something in
>>> compiler.h that abstracts away whether the test for "does
>>> the compiler support feature foo" is via a GCC version
>>> check or a clang __has_feature or whatever.
>>
>> Yes, testing for feature is better than testing a version.
>>
>> This patch reduces use of QEMU_GNUC_PREREQ roughly by half.  Good.
>>
>>>
>>>
>>>  include/qemu/compiler.h   |   8 ---
>>>  include/qemu/host-utils.h | 121 ----------------------------------------------
>>>  tcg/arm/tcg-target.h      |   7 ---
>>>  3 files changed, 136 deletions(-)
>>>
>>> diff --git a/include/qemu/compiler.h b/include/qemu/compiler.h
>>> index 157698b..fc12e49 100644
>>> --- a/include/qemu/compiler.h
>>> +++ b/include/qemu/compiler.h
>>> @@ -24,17 +24,9 @@
>>>
>>>  #define QEMU_NORETURN __attribute__ ((__noreturn__))
>>>
>>> -#if QEMU_GNUC_PREREQ(3, 4)
>>>  #define QEMU_WARN_UNUSED_RESULT __attribute__((warn_unused_result))
>>> -#else
>>> -#define QEMU_WARN_UNUSED_RESULT
>>> -#endif
>>
>> Should we inline this macro?
>
> We have attributes which we wrap in QEMU_ macros already
> even though they always expand to the same thing:
> QEMU_NORETURN and QEMU_ALIGNED.

We also use attributes that are supported by all compilers of interest
without wrapping them in macros.  Just grep for __attribute__.

>                                 I'm happy to leave these
> to follow that pattern. (If you wanted to send a patch
> series that uninlined all of those then I wouldn't hugely
> object to it, but I think it touches enough files that it's
> a separate thing from removing the #if guards that this
> patch does.)

Makes sense.
