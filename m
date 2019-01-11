Received: from eggs.gnu.org ([209.51.188.92]:59455)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ghwQS-0003O3-0B
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 08:00:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ghwQQ-0006Zv-Sb
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 08:00:39 -0500
Received: from mail-ot1-x32b.google.com ([2607:f8b0:4864:20::32b]:33443)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1ghwQQ-0006Wx-BA
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 08:00:38 -0500
Received: by mail-ot1-x32b.google.com with SMTP id i20so13059127otl.0
	for <qemu-devel@nongnu.org>; Fri, 11 Jan 2019 05:00:36 -0800 (PST)
MIME-Version: 1.0
References: <20190108163008.7006-1-peter.maydell@linaro.org>
	<20190108163008.7006-4-peter.maydell@linaro.org>
	<CAFEAcA9xd-MJ7QHgYCyh0D+x_ooXYDCnKYTXELoxz3LbYO4SJw@mail.gmail.com>
	<CAL1e-=gKA9dnfgcJ2QuvbWxjgHya1DfUz4VPRxqakyDVKzH1SA@mail.gmail.com>
In-Reply-To: <CAL1e-=gKA9dnfgcJ2QuvbWxjgHya1DfUz4VPRxqakyDVKzH1SA@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 11 Jan 2019 13:00:24 +0000
Message-ID: <CAFEAcA_Mga7Y1x_eA-HMdTGhC26MZbHJpSyo01XuKFmRG8gzcw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 3/4] accel/tcg: Add cluster number to TCG
 TB hash
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, Eduardo Habkost <ehabkost@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Alistair Francis <alistair@alistair23.me>, Richard Henderson <richard.henderson@linaro.org>, "Emilio G . Cota" <cota@braap.org>, "patches@linaro.org" <patches@linaro.org>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>

On Fri, 11 Jan 2019 at 12:49, Aleksandar Markovic
<aleksandar.m.mail@gmail.com> wrote:
> 1. What would be, in more detail, if possible in layman terms,
> the "bad case" that this series fixes?

I describe this in the cover letter (which also has a link to
a tarball with a test case demonstrating it):
> TCG implicitly assumes that all CPUs are alike, because we have
> a single cache of generated TBs and we don't account for which
> CPU generated the code or is looking for the TB when adding or
> searching for generated TBs. This can go wrong in two situations:
> (1) two CPUs have different physical address spaces (eg CPU 1
> has one lot of RAM/ROM, and CPU 2 has different RAM/ROM): the
> physical address alone is then not sufficient to distinguish
> what code to run
> (2) two CPUs have different features (eg FPU
> vs no FPU): since our TCG frontends bake assumptions into the
> generated code about the presence/absence of features, if a
> CPU with FPU picks up a TB for one generated without an FPU
> it will behave wrongly

What happens is that CPU 1 picks up code that was generated
for CPU 2 and which is not correct for it, and thus does
not behave correctly. (In the test case, an instruction that
should UNDEF on the Cortex-R5F but not on the Cortex-A53 will
either UNDEF on the A53 or fail to UNDEF on the R5F, depending
on which CPU happened to get to the test code first.)

> 2. Let's suppose, hypothetically, and based on your example
> from one of commit messages from this series, that we want to
> support two multicore systems:
>     A. Cluster 1: 1 core with FPU; cluster 2: 3 cores without FPU
>     B. Cluster 1: 2 cores with FPU; cluster 2: 1 core without FPU
> Is there an apparatus that would allow the end user specify these
> and similar cpnfigurations through command line or acsimilar mean
> (so, without QEMU explicitely supporting such core organization,
> but supporting the single core in question, of course)?

The QEMU definition of "cluster" requires that all the CPUs
in the cluster must share (a) the same features (eg FPU)
and (b) the same view of physical memory -- this is what
defines that they are in the same cluster and not different
ones. So you'd model this as four clusters (assuming that
A and B have different views of physical memory. Otherwise
you could put all the with-FPU cores in one cluster and
the without-FPU cores in a second.)

Real hardware might choose to define what it calls a "cluster"
differently, but that doesn't matter.

> 3. Is there a possibility to have two layer clustering sheme,
> instead of one layer? Cluster/subcluster/core instead of
> cluster/core? For MIPS, there is a need for such organization.
> It looks to me 8 bits for cluster id, and 3 bits for subcluster
> id would be sufficient.

My view is that there is no need for the internal "cluster ID"
to match what the hardware happens to do with SMP CPU IDs
and NUMA architecture. What do you think we miss by this?
(Handling of NUMA architecture is a distinct bit of QEMU code,
unrelated to this.)

thanks
-- PMM
