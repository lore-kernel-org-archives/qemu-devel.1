Received: from eggs.gnu.org ([2001:4830:134:3::10]:35236)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1d2ayr-00082F-4O
	for qemu-devel@nongnu.org; Mon, 24 Apr 2017 06:12:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1d2ayp-0006PL-K7
	for qemu-devel@nongnu.org; Mon, 24 Apr 2017 06:12:29 -0400
Received: from mail-wr0-x22f.google.com ([2a00:1450:400c:c0c::22f]:32768)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1d2ayp-0006Op-DA
	for qemu-devel@nongnu.org; Mon, 24 Apr 2017 06:12:27 -0400
Received: by mail-wr0-x22f.google.com with SMTP id w50so65311555wrc.0
	for <qemu-devel@nongnu.org>; Mon, 24 Apr 2017 03:12:26 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <3c22d799-1f28-a220-59d7-4218307748e5@gmx.com>
References: <e1b08f20-77e6-83c8-85e6-b73c645c44c1@gmx.com>
	<CAFEAcA-ycgLSU9aX1Ywd1Pky2bquqefJbsRpNvo4DuaXOyL3SQ@mail.gmail.com>
	<3c22d799-1f28-a220-59d7-4218307748e5@gmx.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 24 Apr 2017 11:12:05 +0100
Message-ID: <CAFEAcA_isLjtq0oZgKTY5J_MStbcENDaWow3kV1bJWpeEBxAzw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] NetBSD maintenance
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kamil Rytarowski <n54@gmx.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 23 April 2017 at 23:45, Kamil Rytarowski <n54@gmx.com> wrote:
> On 23.04.2017 12:19, Peter Maydell wrote:
>> On 23 April 2017 at 00:27, Kamil Rytarowski <n54@gmx.com> wrote:
>>> I noted a call for NetBSD maintainers in the 2.9.0 release notes.
>>>
>>> I'm willing to attach a NetBSD machine to CI cluster and volunteer basic
>>> maintenance. I'm mostly interested in NetBSD as host & as guest as this
>>> is my daily and work driver on my desktop and development machines.
>>
>> Thanks for the offer of assistance. At the moment I have a
>> NetBSD VM set up so I can run the usual make/make check
>> tests that I run on other hosts. So the most immediate
>> requirement is for somebody to investigate and send patches
>> for the bugs which mean it doesn't build at all.
>> My initial investigation suggests that at least one bug is that
>> ivshmem-server uses shm_open but doesn't link -lrt, so
>> some fixes to the build machinery are needed.
>>
>
> I will have a look and try to build qemu from git (master branch).
>
> I also find it surprising that there was a call for CI machines and
> there is no infrastructure for it.

The infrastructure here is "if I have a machine I can ssh
into I have some local scripts which do a build-and-test".
In the case of NetBSD I did manage to get a VM set up after
we applied the patches to print the deprecation warnings,
so that allows me to skip getting somebody else to run a
machine and provide an account on it.

Right now we're in the "get at least something working to
let us test all our platforms" stage; we can try for more
fancy official CI setups later.

>>> As of today NetBSD patches for qemu are maintained in pkgsrc. There are
>>> also at least DragonFly and SunOS (SmartOS) diffs available.
>>> https://github.com/NetBSD/pkgsrc/tree/trunk/emulators/qemu/patches
>>
>> Accumulating patches downstream like this is I think
>> a big part of the problem -- if QEMU has bugs on NetBSD
>> then we need NetBSD users to report the problems and
>> provide us with fixes. Otherwise you get what's happened:
>> we try to build NetBSD with upstream QEMU, find it doesn't
>> even compile, and conclude that obviously nobody's using
>> QEMU on NetBSD because nobody's complained that it doesn't
>> work, so we might as well drop it.
>
> We should maintain buildable and functional version for major BSDs (Net,
> Free, Open, DragonFly), Linux, Darwin and SunOS in pkgsrc. Not
> necessarily every release is verified on each Operating System, but our
> users at some point managed to get it functional on all of them.

Upstream we're definitely going to drop SunOS/Solaris support unless
somebody provides us with a machine we can do build/test on.
DragonFly BSD is in my "let's see if anybody complains" list.
OpenBSD is also in this "let's see" list but it seems more plausible
that somebody will complain (and I have a VM setup for it; it
doesn't pass 'make check' at the moment so the first step there
will be for somebody to investigate and send fixes.)

The motivation here is that we would rather like to get rid of
things like #ifdef __NetBSD__ in our sources (in favour of doing
checks in configure for presence/absence of particular functions
and acting accordingly), and also avoid using "uname" to figure
out our compile target. That's very likely to break platforms
we can't test on, so the idea is to identify which platforms
people do care about, and make sure we are testing them, and
then not worry about breaking anything that we aren't testing.

Also I think it doesn't do our users any favours to claim to
support platform Foo if in fact it doesn't even compile.

>>> Qemu is one of the core tools in NetBSD development and it's used in our
>>> release engineering infrastructure:
>>>
>>> http://releng.netbsd.org/test-results.html
>>
>> Do you use/test the bsd-user code, or just system emulation?
>> I know the FreeBSD folks have extensive patches to the usermode
>> code, but does it work OK on NetBSD hosts, or is it just unused?
>>
>
> I'm afraid that there is no support in qemu usermode on NetBSD right now.

It presumably worked once, since there's a bsd-user/netbsd/ directory.
However if it's broken now then we don't need to try to keep it
working while we land the FreeBSD usermode fixes, so we could
perhaps delete it and reinstate later.

thanks
-- PMM
