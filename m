Received: from eggs.gnu.org ([2001:4830:134:3::10]:45546)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1euHx9-0001kV-JW
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 08:20:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1euHx7-0008BQ-B0
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 08:20:55 -0500
Received: from mail-oi0-x22c.google.com ([2607:f8b0:4003:c06::22c]:35962)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mjc@sifive.com>) id 1euHx7-0008B4-28
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 08:20:53 -0500
Received: by mail-oi0-x22c.google.com with SMTP id u73so6930747oie.3
	for <qemu-devel@nongnu.org>; Fri, 09 Mar 2018 05:20:52 -0800 (PST)
MIME-Version: 1.0
References: <CAHNT7NtB16m=Sn7bWugeOOiqVyeCT4Z7VrXijMDVZBA+tUdgPw@mail.gmail.com>
	<CAFEAcA_rPkjEgNc=uyQ2C+at8Zs28YZVAkOLAZk17JaVyjxuNw@mail.gmail.com>
	<CAHNT7NvZER8r0Jk2K_vLeB53tDS=rcpZg7S3Yy-7OFy=Gt+4CA@mail.gmail.com>
	<4e34d8f0-7dd8-e69a-3a00-7b5e7d635325@amsat.org>
	<CAHNT7NvjnwyknSQMpenSPOXJdoLOT6+Rptu9wPoy2j9uUZn24A@mail.gmail.com>
In-Reply-To: <CAHNT7NvjnwyknSQMpenSPOXJdoLOT6+Rptu9wPoy2j9uUZn24A@mail.gmail.com>
From: Michael Clark <mjc@sifive.com>
Date: Fri, 09 Mar 2018 13:20:41 +0000
Message-ID: <CAHNT7Nv-NNzOG=6-hamQEj+EjEOjT=xfuLaqkZ4bzsES3K32Nw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] Apparently fpu/softfloat.c:1374 is reachable
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Cc: Palmer Dabbelt <palmer@sifive.com>, Peter Maydell <peter.maydell@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>, Richard Henderson <richard.henderson@linaro.org>

BTW I was looking at the IEEE-754 2008 minNum/maxNum code today (the reason
I was running riscv-tests) so that I could forward port the patch to add
IEEE-754 201x minimumNumber/maximumNumber (as there are two pairs of
distinct IEEE-754 functions which have distinct behaviour with respect to
sNaN) and noticed that minNum/maxNum has changed in semantics with respect
to IEEE sNaN for (minNum) but qNaN/sNaN (mininumNumber) semantics aren=E2=
=80=99t
explicitly mentioned anywhere.

>From my perspective we should still be failing our fmin/fmax test-cases
when calling minNum/maxNum as there is no IEEE-754 201x
minimumNumber/maximumNumber function and there is a specific test for qNaN
vs sNaN. i.e. the new softfloat code may have changed previous default
semantics.

I was working on a patch today but gave up for lack of time. It needs some
further analysis as the softfloat code has changed considerably. It seems
one doesn=E2=80=99t explicitly specify the IEEE-754 function, rather pickNa=
N which
has replaced propagateFloat in minNum/maxNum (which previously implemented
IEEE-754 minNum/maxNum) and now has per platform specific magic for NaN
behaviour in pickNaN. The original tests for qNaN only in minNum versus
qNaN and sNaN (anyNaN) have been replaced with anyNaN, which was a surprise
to me, as it now reads like IEEE-754 201x minimumNumber/maximumNumber.

Interestingly the RISC-V ISA Test Suite is comprised of tests crafted
against John Hauser=E2=80=99s original softfloat implementation which is us=
ed
verbatim by Spike (the RISC-V ISA Simulator). Running the RISC-V Test Suite
in this case is useful for testing IEEE semantics, assuming the tests are
accurate, but it seems the pickNaN approach makes it less clear which IEEE
function a port implements.

The observation is that we are now passing the fmin/fmax test but we are
still calling minNum/maxNum not minimumNumber/maximumNumber.

I suspect FP semenatics might have changed for some other ports so watch
out for floating point conformance issues in the upcoming release.

In any case pickNaN kind of magically works for current set of RISC-V
fmin/fmax tests but I wonder about ports that want IEEE-754 2008. To me,
it=E2=80=99s a case of a test passing that I thought should fail, which is =
a
warning sign given there is no mention of minNum/maxNum vs
minimumNumber/maximumNumber.

On Sat, 10 Mar 2018 at 12:56 AM, Michael Clark <mjc@sifive.com> wrote:

> On Sat, 10 Mar 2018 at 12:30 AM, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat=
.org>
> wrote:
>
>> Hi Michael,
>>
>> On 03/09/2018 12:17 PM, Michael Clark wrote:
>> > On Fri, 9 Mar 2018 at 11:45 PM, Peter Maydell <peter.maydell@linaro.or=
g
>> >
>> > wrote:
>> >
>> >> On 9 March 2018 at 04:22, Michael Clark <mjc@sifive.com> wrote:
>> >>> I need to dig into this. I'll need to take the assertions out, or ru=
n
>> >> with
>> >>> tracing to see which fcvt test is triggering this unreachable piece =
of
>> >>> code. FYI. I can look into it.
>> >>
>> >>>
>> >>
>> ERROR:/Users/mclark/src/sifive/riscv-qemu/fpu/softfloat.c:1374:round_to_=
int_and_pack:
>> >>> code should not be reached
>> >>> qemu-images/run-tests.sh: line 6: 58437 Abort trap: 6
>>  ${QEMU}
>> >>> -nographic -machine spike_v1.10 -kernel $i
>> >>
>> >> This looks like maybe it's the issue Richard Jones sent a patch for ?
>> >> https://lists.gnu.org/archive/html/qemu-devel/2018-03/msg01005.html
>> >
>> >
>> > Thanks. Seems I wasn=E2=80=99t on the =E2=80=98cc.
>> >
>> > We need this patch in our downstream repo... We also need to automate
>> > riscv-tests in the riscv.org repo .travis.yml so we can pick these
>> things
>> > up automatically...
>>
>> What about upstreaming the QEMU part of your .travis.yml?
>
>
> We can. It will add overall test coverage as we exercise a lot of the TCG
> instrinsics. I=E2=80=99m currently working on dependencies which is havin=
g the
> riscv-toolchains .travis.yml create toolchain packages in Docker when
> tagged using the Travis/GitHub deployment Integration.
>
> The riscv-tests repo can then pull the toolchain into a Docker/repo to
> build a binary image of the tools which it can then upload using the same
> Travis/GitHub deployment integration.
>
> Unfortunately i=E2=80=99m trying to split my time amongst some CI work on=
 the
> other riscv.org repos that i=E2=80=99ve not yet got integrated. My toolch=
ain
> build recipe takes 3 hours to make .deb and .rpm multilib toolchain
> packages on tagging, which is way beyond the Travis timeouts so i=E2=80=
=99m
> exploring some hosted builds someware, e.g. an AWS instance.
>
> I could just upload binaries manually but we were planning to have this
> integrated into GitHub/Travis with tag hooks. We have tested this on some
> repositories already, but the toolchain is the main dependency for all of
> the other repos to build binary test images that are publicly available.
>
> Currently I have a local set of binaries for testing and it=E2=80=99s adh=
oc. i.e.
> not triggered automatically when we create a tag in one of the repos. We
> don=E2=80=99t have anyone dedicated to CI so it=E2=80=99s a task I am wor=
king on when time
> is available...
>
> Hopefully we=E2=80=99ll have binary images for the various artefacts on t=
he
> Releases section on all of the riscv repos, or maybe SiFive will do this =
in
> its own repos. It=E2=80=99s sorely needed as currently everyone has to bu=
ild
> everything from scratch. It takes a lot of time and effort to reproduce a
> set of test binaries for riscv-tests, riscv-linux, riscv-pk/bbl and
> SiFive=E2=80=99s own E and U series SDKs. The git repos are constantly ch=
anging so
> the only way at present is to track many repos and rebuild binaries.
>
> It will be great when binaries are included with the GitHub Releases/tags
> assuming we use GitHub Releases to host the binaries. I really want to
> spend time on this because I think the current CI setup is less than idea=
l.
> I=E2=80=99m frustrated by my own humanity which is by nature to err, whic=
h means
> sometime forgetting to run exhaustive tests on each release. The obvious
> solution is to wire the tests into the CI so bots take care of this.
>
> Michael
>
