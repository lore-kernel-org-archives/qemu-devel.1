Received: from eggs.gnu.org ([2001:4830:134:3::10]:39648)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1f91QS-0005y9-CN
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 00:44:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1f91QO-0003Zx-56
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 00:44:04 -0400
Received: from mail-pf0-x243.google.com ([2607:f8b0:400e:c00::243]:36041)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mjc@sifive.com>) id 1f91QN-0003Zl-Vf
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 00:44:00 -0400
Received: by mail-pf0-x243.google.com with SMTP id g14so2015304pfh.3
	for <qemu-devel@nongnu.org>; Wed, 18 Apr 2018 21:43:59 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 11.3 \(3445.6.18\))
From: Michael Clark <mjc@sifive.com>
In-Reply-To: <CA+ZOyaj_4my=u4-MkAbyoee5ORnRq6nyaU+HhX1K6t2+Cn5RHg@mail.gmail.com>
Date: Thu, 19 Apr 2018 16:43:52 +1200
Content-Transfer-Encoding: quoted-printable
Message-Id: <3EFD5845-5CE7-45F5-AE4C-0C86CAFAA200@sifive.com>
References: <CA+ZOyaj_4my=u4-MkAbyoee5ORnRq6nyaU+HhX1K6t2+Cn5RHg@mail.gmail.com>
Subject: Re: [Qemu-devel] [sw-dev] The problem of write misa on QEMU and BBL
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Zong Li <zongbox@gmail.com>
Cc: Zong Li <zong@andestech.com>, Andrew Waterman <andrew@sifive.com>, Palmer Dabbelt <palmer@sifive.com>, RISC-V SW Dev <sw-dev@groups.riscv.org>, QEMU Developers <qemu-devel@nongnu.org>, Richard Henderson <richard.henderson@linaro.org>

Hi Zong,

> On 19/04/2018, at 2:40 PM, Zong Li <zongbox@gmail.com> wrote:
>=20
> Hi all,
>=20
> For BBL part, in fp_init at machine/minit.c,
> it will clear the D and F bits of misa register, and assertion that
> the bits is cleared.
> But the misa is WARL register, so there is no effect for writing it,
> and the assertion not be true.
> So is there has necessary to do that if toolchain not support D and F =
extension?
>=20
> For QEMU part, when writing misa, it will trigger the illegal
> instruction exception, but I think that the WARL allow write behavior?

QEMU in the riscv-all branch should have WARL behavior.

- https://github.com/riscv/riscv-qemu/commits/riscv-all

There is a bug in upstream. We have submitted patches to fix the issue =
for review on the qemu-devel mailing list. The patch series will be =
submitted for upstream review again shortly. We were holding off on the =
series as we didn=E2=80=99t classify it as a =E2=80=9Ccritical bug=E2=80=9D=
 as QEMU was in soft-freeze for 2.12 and we weren=E2=80=99t able to get =
review in time to include this fix in the 2.12 release.

See =E2=80=9CNo traps on writes to misa,minstret,mcycle"

- https://github.com/riscv/riscv-qemu/commits/qemu-2.13-for-upstream

The history is that there were several unimplemented CSRs that had =
printf followed by exit. Richard Henderson said we should fix this. I =
changed several CSRs to cause illegal instruction traps instead of =
calling exit. That was a mistake as CSRs that don=E2=80=99t support =
write are WARL (Write Any Read Legal). It was certainly better than =
having the simulation exit as a cpu doesn=E2=80=99t typically have a way =
to =E2=80=9Dexit=E2=80=9D like a C program, nevertheless trapping was =
wrong. My mistake. See here for the history:

- =
https://github.com/riscv/riscv-qemu/blob/ff36f2f77ec3e6a6211c63bfe1707ec05=
7b12f7d/target-riscv/op_helper.c

The implementation in the current tree is quite different. We have =
recently made the CSR system more modular so that with minor changes, =
custom CPUs will be able to hook their own control and status registers.

- =
https://github.com/riscv/riscv-qemu/blob/qemu-2.13-for-upstream/target/ris=
cv/csr.c#L780-L867

See these changes:

- =
https://github.com/riscv/riscv-qemu/commit/9d9c1bfef911c520a35bd3f8c0ed2e1=
4cc96bbb7
- =
https://github.com/riscv/riscv-qemu/commit/b5a4cd79ce6c7fbb65fdcf078fb9a83=
91da1d6b1

We know have a flexible system that will allow implementations to hook =
per-cpu control and status registers, and we have predicates that make =
CSRs appear on some processor but not on others. i.e. if misa.S is not =
present, then S-mode s* CSRs will trap. Sometimes WARL is the correct =
behaviour, but sometimes trapping is the correct behaviour i.e. if the =
processor does not implement S-mode.

misa traps on write should only affect bootloaders as Supervisor=E2=80=99s=
 like Linux don=E2=80=99t yet have access to the isa register. It=E2=80=99=
s not a major issuse.

Michael.=
