Received: from eggs.gnu.org ([2001:4830:134:3::10]:52825)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gUYtx-0002ji-AL
	for qemu-devel@nongnu.org; Wed, 05 Dec 2018 10:15:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gUYfY-0000Aa-Lf
	for qemu-devel@nongnu.org; Wed, 05 Dec 2018 10:01:02 -0500
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:47050)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gUYfY-00009y-6O
	for qemu-devel@nongnu.org; Wed, 05 Dec 2018 10:00:56 -0500
Received: by mail-oi1-x244.google.com with SMTP id x202so17719360oif.13
	for <qemu-devel@nongnu.org>; Wed, 05 Dec 2018 07:00:56 -0800 (PST)
MIME-Version: 1.0
References: <20181120212553.8480-1-aaron@os.amperecomputing.com>
	<20181120212553.8480-8-aaron@os.amperecomputing.com>
	<CAFEAcA92+6NdqpB+L42cu1Ba7qvvHoLkjSDgcEDLvR=iqpd4gg@mail.gmail.com>
	<20181203204452.GB5549@quinoa.localdomain>
	<CAFEAcA900U3amGOGRKGNu+-j9EDhdrZ1U1U5MtoW5BeTo74iOQ@mail.gmail.com>
	<05205391-27bf-c6be-bc71-648eee127c47@linaro.org>
	<20181205130047.GC5549@quinoa.localdomain>
In-Reply-To: <20181205130047.GC5549@quinoa.localdomain>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 5 Dec 2018 15:00:43 +0000
Message-ID: <CAFEAcA8bz20d4LrtEs=iRSJSZ_x5ERU0H0BiYvz4z=+c4v_WvA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v8 07/13] target-arm: Make PMCEID[01]_EL0
 64 bit registers, add PMCEID[23]
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aaron Lindsay <aaron@os.amperecomputing.com>
Cc: Richard Henderson <richard.henderson@linaro.org>, qemu-arm <qemu-arm@nongnu.org>, Alistair Francis <alistair.francis@xilinx.com>, Wei Huang <wei@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, QEMU Developers <qemu-devel@nongnu.org>, Michael Spradling <mspradli@codeaurora.org>, Digant Desai <digantd@codeaurora.org>

On Wed, 5 Dec 2018 at 13:00, Aaron Lindsay <aaron@os.amperecomputing.com> wrote:
>
> On Dec 03 16:57, Richard Henderson wrote:
> > Yes.  It would appear that this feature should be controlled by
> > ID_DFR0.PerfMon.  So,
> >
> >   if (FIELD_EX32(cpu->id_dfr0, ID_DFR0, PERFMON) >= 4)
> >
> > once the appropriate FIELDs are added to cpu.h.
> >
> > Since this test is not used within translate*.c, there is no need to move
> > id_dfr* into ARMISARegisters.  Since these are only aliases, they do not affect
> > migration, and so do not (yet) need to be filled in by kvm.
>
> Sounds reasonable to me. One clarification - do we also need to guard
> against the 0b1111 value for ID_DFR0.PerfMon, which implies an
> implementation-defined, non-PMUv3 PMU, or is it safe to assume no one
> will attempt that flavor in QEMU?

We should check for 0xf, yes, following the recommended check
logic described in the Arm ARM section "Alternative ID scheme used
for the Performance Monitors Extension version". It doesn't
seem likely that we'll end up with the 0xf case but we might
as well avoid the question in advance...

thanks
-- PMM
