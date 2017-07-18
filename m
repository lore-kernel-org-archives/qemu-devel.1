Received: from eggs.gnu.org ([2001:4830:134:3::10]:38570)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dXSvI-0002Dp-Mw
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 09:52:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dXSvE-0006B9-O7
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 09:52:24 -0400
Received: from mail-wr0-x233.google.com ([2a00:1450:400c:c0c::233]:35499)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1dXSvE-00069F-Hx
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 09:52:20 -0400
Received: by mail-wr0-x233.google.com with SMTP id w4so29786517wrb.2
	for <qemu-devel@nongnu.org>; Tue, 18 Jul 2017 06:52:20 -0700 (PDT)
References: <20170718061005.29518-1-f4bug@amsat.org>
	<20170718061005.29518-27-f4bug@amsat.org>
	<CAJ+F1C+WsdUp3Vtx+-FZ9g7URSAQuJWb6h7-w6yJXM+4TKQNjA@mail.gmail.com>
	<87bmoi806u.fsf@linaro.org>
	<CAJ+F1CLXojLp2VxET469gBLsaSwCvkQoGODOMyFUs3jUbkdk3A@mail.gmail.com>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <CAJ+F1CLXojLp2VxET469gBLsaSwCvkQoGODOMyFUs3jUbkdk3A@mail.gmail.com>
Date: Tue, 18 Jul 2017 14:52:16 +0100
Message-ID: <878tjl97jj.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 26/29] tests/tcg: use ARRAY_SIZE macro
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@gmail.com>
Cc: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu trival <qemu-trivial@nongnu.org>, QEMU <qemu-devel@nongnu.org>, Richard Henderson <rth@twiddle.net>


Marc-André Lureau <marcandre.lureau@gmail.com> writes:

> Hi
>
> On Tue, Jul 18, 2017 at 4:16 AM, Alex Bennée <alex.bennee@linaro.org> wrote:
>>
>> Marc-André Lureau <marcandre.lureau@gmail.com> writes:
>>
>>> Hi
>>>
>>> On Mon, Jul 17, 2017 at 11:10 PM, Philippe Mathieu-Daudé
>>> <f4bug@amsat.org> wrote:
>>>> Applied using the Coccinelle semantic patch scripts/coccinelle/use_osdep.cocci
>>>>
>>>> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
>>>> ---
>>>>  tests/tcg/alpha/test-cond.c | 2 +-
>>>>  tests/tcg/alpha/test-ovf.c  | 2 +-
>>>>  2 files changed, 2 insertions(+), 2 deletions(-)
>>>>
>>>
>>> I think those do not include osdep.h
>>>
>>> (sigh, tests/tcg would need some love ;)
>>
>> Pranith has had a couple of revs at this:
>>
>>   Subject: [PATCH v5 00/19] Cleanup of TCG tests
>>   Date: Thu,  1 Dec 2016 00:14:14 -0500
>>   Message-Id: <20161201051433.17168-1-bobby.prani@gmail.com>
>>
>> We have the cross-compilers available as a fallback via docker although
>> not every one can seamlessly use it for building stuff. Is getting a
>> working cross-compiler setup too much of a hurdle fore those that want
>> to build cross-arch tests?
>
> Yes, I also did some experiments in cleaning up tests/tcg
> (https://github.com/elmarco/qemu/tree/tcg-tests)
>
> The trouble is I don't see an official/automated way to run tests/tcg
> tests. Which cross-compiler should I use? When I played with this,
> they all had various quirks, on Fedora, Debian or crosstool-ng.

Debian at least have put a lot of work into getting cross-compilers
installed as part of the native distro with good multi-arch support. We
now use plain Debian 9 for most of the QEMU cross compiles - a few older
architectures still need Debian 8 with the emdebian overlay.

> I haven't looked at the docker tests, is this running tests/tcg test
> somehow?

No but as tests/tcg are all pretty simple and have less cross-compile
dependencies than QEMU itself it is fairly trivial to invoke docker to
do a cross-build for you in-place. e.g.:

  docker run --rm -t -u (id -u) -v (pwd):(pwd) -w (pwd) qemu:debian-armhf-cross arm-linux-gnueabihf-gcc tests/tcg/hello-arm.c

This is perhaps a bad example as there is a bit-rot that needs fixing.
The alternative is to mine the users PATH for fairly standard
cross-compile prefixes which work at least on Debian systems. I recently
submitted a patch to RISU that allowed you to use either in its
build-all-arches script:

  https://git.linaro.org/people/peter.maydell/risu.git/tree/build-all-archs

--
Alex Bennée
