Received: from eggs.gnu.org ([2001:4830:134:3::10]:56406)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1euGdp-0005yg-3o
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 06:56:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1euGdn-0006g0-Jw
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 06:56:53 -0500
Received: from mail-ot0-x244.google.com ([2607:f8b0:4003:c0f::244]:46773)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mjc@sifive.com>) id 1euGdn-0006fu-BN
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 06:56:51 -0500
Received: by mail-ot0-x244.google.com with SMTP id g97so8416271otg.13
	for <qemu-devel@nongnu.org>; Fri, 09 Mar 2018 03:56:51 -0800 (PST)
MIME-Version: 1.0
References: <CAHNT7NtB16m=Sn7bWugeOOiqVyeCT4Z7VrXijMDVZBA+tUdgPw@mail.gmail.com>
	<CAFEAcA_rPkjEgNc=uyQ2C+at8Zs28YZVAkOLAZk17JaVyjxuNw@mail.gmail.com>
	<CAHNT7NvZER8r0Jk2K_vLeB53tDS=rcpZg7S3Yy-7OFy=Gt+4CA@mail.gmail.com>
	<4e34d8f0-7dd8-e69a-3a00-7b5e7d635325@amsat.org>
In-Reply-To: <4e34d8f0-7dd8-e69a-3a00-7b5e7d635325@amsat.org>
From: Michael Clark <mjc@sifive.com>
Date: Fri, 09 Mar 2018 11:56:40 +0000
Message-ID: <CAHNT7NvjnwyknSQMpenSPOXJdoLOT6+Rptu9wPoy2j9uUZn24A@mail.gmail.com>
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

On Sat, 10 Mar 2018 at 12:30 AM, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.o=
rg>
wrote:

> Hi Michael,
>
> On 03/09/2018 12:17 PM, Michael Clark wrote:
> > On Fri, 9 Mar 2018 at 11:45 PM, Peter Maydell <peter.maydell@linaro.org=
>
> > wrote:
> >
> >> On 9 March 2018 at 04:22, Michael Clark <mjc@sifive.com> wrote:
> >>> I need to dig into this. I'll need to take the assertions out, or run
> >> with
> >>> tracing to see which fcvt test is triggering this unreachable piece o=
f
> >>> code. FYI. I can look into it.
> >>
> >>>
> >>
> ERROR:/Users/mclark/src/sifive/riscv-qemu/fpu/softfloat.c:1374:round_to_i=
nt_and_pack:
> >>> code should not be reached
> >>> qemu-images/run-tests.sh: line 6: 58437 Abort trap: 6           ${QEM=
U}
> >>> -nographic -machine spike_v1.10 -kernel $i
> >>
> >> This looks like maybe it's the issue Richard Jones sent a patch for ?
> >> https://lists.gnu.org/archive/html/qemu-devel/2018-03/msg01005.html
> >
> >
> > Thanks. Seems I wasn=E2=80=99t on the =E2=80=98cc.
> >
> > We need this patch in our downstream repo... We also need to automate
> > riscv-tests in the riscv.org repo .travis.yml so we can pick these
> things
> > up automatically...
>
> What about upstreaming the QEMU part of your .travis.yml?


We can. It will add overall test coverage as we exercise a lot of the TCG
instrinsics. I=E2=80=99m currently working on dependencies which is having =
the
riscv-toolchains .travis.yml create toolchain packages in Docker when
tagged using the Travis/GitHub deployment Integration.

The riscv-tests repo can then pull the toolchain into a Docker/repo to
build a binary image of the tools which it can then upload using the same
Travis/GitHub deployment integration.

Unfortunately i=E2=80=99m trying to split my time amongst some CI work on t=
he other
riscv.org repos that i=E2=80=99ve not yet got integrated. My toolchain buil=
d recipe
takes 3 hours to make .deb and .rpm multilib toolchain packages on tagging,
which is way beyond the Travis timeouts so i=E2=80=99m exploring some hoste=
d builds
someware, e.g. an AWS instance.

I could just upload binaries manually but we were planning to have this
integrated into GitHub/Travis with tag hooks. We have tested this on some
repositories already, but the toolchain is the main dependency for all of
the other repos to build binary test images that are publicly available.

Currently I have a local set of binaries for testing and it=E2=80=99s adhoc=
. i.e.
not triggered automatically when we create a tag in one of the repos. We
don=E2=80=99t have anyone dedicated to CI so it=E2=80=99s a task I am worki=
ng on when time
is available...

Hopefully we=E2=80=99ll have binary images for the various artefacts on the
Releases section on all of the riscv repos, or maybe SiFive will do this in
its own repos. It=E2=80=99s sorely needed as currently everyone has to buil=
d
everything from scratch. It takes a lot of time and effort to reproduce a
set of test binaries for riscv-tests, riscv-linux, riscv-pk/bbl and
SiFive=E2=80=99s own E and U series SDKs. The git repos are constantly chan=
ging so
the only way at present is to track many repos and rebuild binaries.

It will be great when binaries are included with the GitHub Releases/tags
assuming we use GitHub Releases to host the binaries. I really want to
spend time on this because I think the current CI setup is less than ideal.
I=E2=80=99m frustrated by my own humanity which is by nature to err, which =
means
sometime forgetting to run exhaustive tests on each release. The obvious
solution is to wire the tests into the CI so bots take care of this.

Michael
