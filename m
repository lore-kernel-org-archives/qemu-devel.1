Received: from eggs.gnu.org ([209.51.188.92]:41689)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1guHwk-0002Ru-1z
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 09:25:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1guHwC-0001Io-Cy
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 09:24:34 -0500
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:44791)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1guHwA-0001Gn-Cp
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 09:24:26 -0500
Received: by mail-ot1-x343.google.com with SMTP id g1so10669540otj.11
	for <qemu-devel@nongnu.org>; Thu, 14 Feb 2019 06:24:24 -0800 (PST)
MIME-Version: 1.0
References: <20190205190224.2198-1-alex.bennee@linaro.org>
In-Reply-To: <20190205190224.2198-1-alex.bennee@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 14 Feb 2019 14:24:13 +0000
Message-ID: <CAFEAcA_FdK2HsFto8zBZnoZQWyrnKLtskOz6Sb42n_qBw-qV=Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 0/6] HWCAP_CPUID registers for aarch64
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>

On Tue, 5 Feb 2019 at 20:21, Alex Benn=C3=A9e <alex.bennee@linaro.org> wrot=
e:
>
> Hi,
>
> I've re-spun the cpuid patches with the changes suggested by Peter's
> review. The biggest change is the squashing of bits is now all data
> driven with ARMCPRegUserSpaceInfo being used to control how bits are
> altered for userspace presentation. This includes using glob matching
> to set whole bunches to RAZ.
>
> The testcase isn't as comprehensive as it could be because you need a
> fairly new compiler (binutils) to emit all the various system register
> id's to test. I did look into upgrading debian-arm64-cross with Buster
> but I managed to find a bug in Debian's dependencies which rules out
> upgrading for now.
>
> checkpatch is complaining about the _m macro I used to group together
> words in the masks I defined. I'm not sure adding the spaces makes it
> as readable though.
>
> The following patches need review:
>  patch 0001/target arm relax permission checks for HWCAP_CPUI.patch
>  patch 0002/target arm expose CPUID registers to userspace.patch
>  patch 0003/target arm expose MPIDR_EL1 to userspace.patch
>  patch 0004/target arm expose remaining CPUID registers as RA.patch
>  patch 0006/tests tcg aarch64 userspace system register test.patch

I'll take 1-5 into target-arm.next, but 6 breaks 'make check-tcg'
for me:

  BUILD   aarch64 guest-tests with aarch64-linux-gnu-gcc
cc1: error: invalid feature modifier in =E2=80=98-march=3Darmv8.1-a+sve=E2=
=80=99

I imagine you're assuming a newer binutils than Ubuntu ships.
You should probably go for just encoding the insns rather than using
their names -- binutils should accept "S<op0>_<op1>_<Cn>_<Cm>_<op2>"
as a register name for mrs and msr insn.

It would also be nice to test some of the sysreg cases which
go through your "glob the register name" code path -- I think
at the moment you are only testing the ones which use the
specific-match case ? (Ideally we'd loop through and test that
we could read everything in the defined-to-be-exposed encoding
range, though that would require some slightly tedious preprocessor
macro effort.)

thanks
-- PMM
