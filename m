Received: from eggs.gnu.org ([2001:4830:134:3::10]:49023)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1fBonY-0005hB-89
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 17:51:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1fBonW-0001cy-Rw
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 17:51:28 -0400
Received: from mail-ot0-x22f.google.com ([2607:f8b0:4003:c0f::22f]:40613)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mjc@sifive.com>) id 1fBonW-0001bq-Ku
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 17:51:26 -0400
Received: by mail-ot0-x22f.google.com with SMTP id n1-v6so1111106otf.7
	for <qemu-devel@nongnu.org>; Thu, 26 Apr 2018 14:51:26 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_4_K-aGJL4ds3G3p_-Dc1=6OGp9fUaZFuE+PW=UBoSSg@mail.gmail.com>
References: <20180426135755.GI29865@localhost.localdomain>
	<CAFEAcA_4_K-aGJL4ds3G3p_-Dc1=6OGp9fUaZFuE+PW=UBoSSg@mail.gmail.com>
From: Michael Clark <mjc@sifive.com>
Date: Fri, 27 Apr 2018 09:51:25 +1200
Message-ID: <CAHNT7NtRy0PcrnT-=xkX1P7m=L7x6NrXN0r27o6fFHZ3q4vfnQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] Who is running QEMU automated tests, and when?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Eduardo Habkost <ehabkost@redhat.com>, Yash Mankad <ymankad@redhat.com>, Thomas Huth <thuth@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Markus Armbruster <armbru@redhat.com>, Cleber Rosa <crosa@redhat.com>, =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>, Palmer Dabbelt <palmer@sifive.com>, Andrew Waterman <andrew@sifive.com>

On Fri, Apr 27, 2018 at 2:04 AM, Peter Maydell <peter.maydell@linaro.org>
wrote:

> On 26 April 2018 at 14:57, Eduardo Habkost <ehabkost@redhat.com> wrote:
> > Peter, do you have additional tests you run before merging a pull
> > request?  Additional test sets run before tagging a release?
>
> I run make && make check, on a variety of hosts, before merging
> any pull request. That's the only testing I do, and I don't
> do anything more before I do a tag.
>

This is what I do on riscv, however it is not yet automated:

- QEMU upstream `make check` tests are run in Travis and they should all
pass.
- The RISC-V ISA compatibility tests from the `riscv-tests` repository are
  run and currently all of the tests pass.
- Fedora Linux and Debian Linux are used for running self-hosted GCC
bootstraps
  using the latest Linux kernel and GLIBC user-space in the `virt` machine.
  A parallel GCC bootstrap is used for stress testing MTTCG, SMP and the
  interrupt controllers in a multi-core RISC-V virtual machine.
- Linux 4.6.2 with bbl and busybox are used for backward compatibility
testing
  in the `spike_v1.9.1` machine.
- Linux 4.15.0 with bbl and busybox are used for forward compatibility
testing
  in the `spike_v1.10` machine.
- HiFive1 binaries from the `freedom-u-sdk` are used for testing the
  `sifive_e` machine.

I only run the 24-hour type tests if I am changing anything related to
interrupts. We are working on interrupt controller emulation and the SMP
PLIC used by the 'virt' machine was authored by me, however Stefan O'Rear
contributed to the interrupt handling code and I've been very careful to
test that I haven't broken and to fully understand the logic and atomicity
of interrupts. We are working on a new interrupt controller and are
specifically looking at the possibility of adding a GPIO mock that could be
combined with some sort of replay mechanism to test the interrupt
controllers.

We could bring a snapshot of riscv-tests into the QEMU tree however it
would be best if they retained the BSD license so we can share locally
added tests with upstream as upstream is adding tests periodically.

We have recently made changes to the riscv page walker where we have
documented it in such a way that each clause represents a descriprition for
a test case. Our goal is that we would like the code to read similarly to
the RISC-V Privileged ISA specification where possible.

-
https://github.com/riscv/riscv-qemu/blob/qemu-2.13-for-upstream/target/riscv/cpu_helper.c#L210-L243

BTW Andrew Waterman reviewed my update to the page walker and caught a bug.
Linux testing doesn't exercise every dimension of the page permission
checks. We effectively need malware type tests. Multi-core PTE update
atomicity tests will also be interesting. The SiFive verification team have
been working on PMP tests however I am not sure whether these will be made
open source. The RISC-V QEMU PMP code needs testing. It also needs to
implement recent changes to the specification for coarse grain PMPs (4K
granularity) given we use the TLB page size so that PMP can be implemented
with reasonable performance.

We would like to automate all of this and we are working towards that goal.
One of the dependencies for docker tests are the riscv toolchain packages
and we are working on this...

Adding port specific tests, like riscv tests to QEMU not only benefits the
particular port but also exercises a log of generic code such as the TCG,
the IO system, IO mutex, Virt IO and many other shared code paths.
