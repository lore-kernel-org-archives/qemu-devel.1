Received: from eggs.gnu.org ([2001:4830:134:3::10]:34482)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1csprE-0003cR-Ht
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 08:04:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cspr8-0000Y1-G8
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 08:04:16 -0400
Received: from mail-wr0-x22f.google.com ([2a00:1450:400c:c0c::22f]:35658)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cspr8-0000Xl-AU
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 08:04:10 -0400
Received: by mail-wr0-x22f.google.com with SMTP id u1so101724182wra.2
	for <qemu-devel@nongnu.org>; Tue, 28 Mar 2017 05:04:10 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <53da131d-0d11-d471-1848-84e65087029b@weilnetz.de>
References: <20170327201146.1820-1-sw@weilnetz.de>
	<f4b891ea-88c0-7c22-c702-f0ad0740d4e5@redhat.com>
	<53da131d-0d11-d471-1848-84e65087029b@weilnetz.de>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 28 Mar 2017 13:03:48 +0100
Message-ID: <CAFEAcA-82C=7AQeGDoLzoSq3Lsw6FALcgJtPtOesB2tbOB3zQw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH for-2.9] Fix check for target OS support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Weil <sw@weilnetz.de>
Cc: Paolo Bonzini <pbonzini@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>

On 28 March 2017 at 12:53, Stefan Weil <sw@weilnetz.de> wrote:
> Am 28.03.2017 um 10:04 schrieb Paolo Bonzini:
>> On 27/03/2017 22:11, Stefan Weil wrote:
>>> * Support cross compilation with the most common cross prefixes
>>>   for Mingw-w64. Other cross builds are still broken!
>> Can you explain how it's broken?  Why does check_define not work at this
>> point, for cross builds?
>>
>> "../configure --cross-prefix=x86_64-w64-mingw32-" seems to work for me.
>>
>> Paolo
>
> You are right. I was wrong because of this use case:
>
> $ ./configure '--enable-debug' '--cross-prefix=x86_64-w64-mingw32'
>
> ERROR: Unsupported host OS CYGWIN_NT-6.1
>
> So the error message is misleading when I specify a wrong cross prefix
> (it should have been x86_64-w64-mingw32- instead of x86_64-w64-mingw32).

Ah, I see. In the fall-through case we'd then complain that
the compiler didn't work. I think the underlying problem here
is that we use the compiler (for the check_prefix tests) before
the "does this compiler even work" test...

(This only happens in the case where you're doing a cross compile
and the build machine is not a supported QEMU host.)

> With the correct cross prefix, builds work, so cross builds are
> not a critical issue as I thought.
>
> The second issue which remains is calling ./configure --help:
>
> $ ./configure --help
>
> ERROR: Unsupported host OS CYGWIN_NT-6.1

Yeah, we should not complain for --help; I'll see if I can fix that.

> The third issue is the message for deprecated cpus or targets
> which should use "target" instead of "host".

We are not (yet) deprecating any targets, so we don't want to
say "target". What we're deprecating are hosts. (In a cross
compile setup the 'host' (machine being compiled for) isn't the
'build' (machine running the compiler), but I think if
you're advanced enough to be cross-compiling you can deal
with the confusing terminology.)

thanks
-- PMM
