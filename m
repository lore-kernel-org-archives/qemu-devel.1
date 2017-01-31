Received: from eggs.gnu.org ([2001:4830:134:3::10]:43026)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cYcjL-0001pj-Ju
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 13:00:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cYcjK-0000aH-Nz
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 13:00:35 -0500
Received: from mail-vk0-x233.google.com ([2607:f8b0:400c:c05::233]:35347)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cYcjK-0000a9-EY
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 13:00:34 -0500
Received: by mail-vk0-x233.google.com with SMTP id x75so242515018vke.2
	for <qemu-devel@nongnu.org>; Tue, 31 Jan 2017 10:00:34 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <87wpdbw2ki.fsf@dusky.pond.sub.org>
References: <1485879287-12548-1-git-send-email-peter.maydell@linaro.org>
	<87wpdbw2ki.fsf@dusky.pond.sub.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 31 Jan 2017 18:00:13 +0000
Message-ID: <CAFEAcA-Ggv2VGszZg0Ld3-1wm=hVe8w=4ZcQ7TDRHf5Puq88ug@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
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
To: Markus Armbruster <armbru@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, QEMU Trivial <qemu-trivial@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, "patches@linaro.org" <patches@linaro.org>

On 31 January 2017 at 17:40, Markus Armbruster <armbru@redhat.com> wrote:
> Peter Maydell <peter.maydell@linaro.org> writes:
>
>> We already require gcc 4.1 or newer (for the atomic
>> support), so the fallback codepaths for older gcc
>> versions than that are now dead code and we can
>> just delete them.
>>
>> NB: clang reports itself as gcc 4.2 (regardless of
>> clang version), so clang won't be using the fallbacks
>> either.
>>
>> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
>> ---
>> For compatibility with clang we should probably try to avoid
>> using QEMU_GNUC_PREREQ() and instead have something in
>> compiler.h that abstracts away whether the test for "does
>> the compiler support feature foo" is via a GCC version
>> check or a clang __has_feature or whatever.
>
> Yes, testing for feature is better than testing a version.
>
> This patch reduces use of QEMU_GNUC_PREREQ roughly by half.  Good.
>
>>
>>
>>  include/qemu/compiler.h   |   8 ---
>>  include/qemu/host-utils.h | 121 ----------------------------------------------
>>  tcg/arm/tcg-target.h      |   7 ---
>>  3 files changed, 136 deletions(-)
>>
>> diff --git a/include/qemu/compiler.h b/include/qemu/compiler.h
>> index 157698b..fc12e49 100644
>> --- a/include/qemu/compiler.h
>> +++ b/include/qemu/compiler.h
>> @@ -24,17 +24,9 @@
>>
>>  #define QEMU_NORETURN __attribute__ ((__noreturn__))
>>
>> -#if QEMU_GNUC_PREREQ(3, 4)
>>  #define QEMU_WARN_UNUSED_RESULT __attribute__((warn_unused_result))
>> -#else
>> -#define QEMU_WARN_UNUSED_RESULT
>> -#endif
>
> Should we inline this macro?

We have attributes which we wrap in QEMU_ macros already
even though they always expand to the same thing:
QEMU_NORETURN and QEMU_ALIGNED. I'm happy to leave these
to follow that pattern. (If you wanted to send a patch
series that uninlined all of those then I wouldn't hugely
object to it, but I think it touches enough files that it's
a separate thing from removing the #if guards that this
patch does.)

thanks
-- PMM
