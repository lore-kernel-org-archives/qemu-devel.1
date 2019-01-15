Received: from eggs.gnu.org ([209.51.188.92]:46111)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.m.mail@gmail.com>) id 1gjETE-0000l5-S6
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 21:28:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.m.mail@gmail.com>) id 1gjETE-0001aG-3X
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 21:28:52 -0500
Received: from mail-oi1-x22e.google.com ([2607:f8b0:4864:20::22e]:33675)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
	id 1gjETD-0001ZC-SS
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 21:28:52 -0500
Received: by mail-oi1-x22e.google.com with SMTP id c206so1018802oib.0
	for <qemu-devel@nongnu.org>; Mon, 14 Jan 2019 18:28:51 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20190114215225.GA16760@habkost.net>
References: <20190114215225.GA16760@habkost.net>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Tue, 15 Jan 2019 03:28:50 +0100
Message-ID: <CAL1e-=iBx0Dt=S5fyLs8v-XN+2Zmx5hb7StQBJhquUmmdw6uNA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] Meaning of "-smp threads" on mips_malta
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Aleksandar Rikalo <arikalo@wavecomp.com>, Stefan Markovic <smarkovic@wavecomp.com>, Aleksandar Markovic <amarkovic@wavecomp.com>, Aurelien Jarno <aurelien@aurel32.net>, Igor Mammedov <imammedo@redhat.com>

On Monday, January 14, 2019, Eduardo Habkost <ehabkost@redhat.com> wrote:

> Hi,
>
> I'm trying to refactor the SMP topology code in QEMU


>
Eduardo, I truly appreciate your interest in details of Malta
implementations, but before I answer your questions, could you please
outline the motivation and the current concept of your envisioned
refactoring of SMP, so that I have some picture of the whole context?

Sincerely, Aleksandar



>
> and I found
> some suspicious code on mips_malta.c:
>
> static void malta_mips_config(MIPSCPU *cpu)
> {
>     CPUMIPSState *env = &cpu->env;
>     CPUState *cs = CPU(cpu);
>
>     env->mvp->CP0_MVPConf0 |= ((smp_cpus - 1) << CP0MVPC0_PVPE) |
>                          ((smp_cpus * cs->nr_threads - 1) << CP0MVPC0_PTC);
> }
>
>
> The (smp_cpus * cs->nr_threads) expression here doesn't make
> sense to me (because smp_cpus is already supposed to be a
> multiple of smp_threads), and seems to indicate that the code has
> some unusual assumptions about the semantics of the -smp option.
>
> So, I'd like to know: do all the examples below make sense for
> Malta?
>
>  -smp 1
>  -smp 2
>  -smp 2,threads=1
>  -smp 2,threads=2
>  -smp 1,threads=2 [*]
>  -smp 2,threads=3 [*]
>
> The generic -smp parsing code considers the last 2 entries
> above[*] to be invalid.  If they make sense for Malta, we need to
> find a way to fix that.  Replacing "-smp threads=..." with a
> "-cpu" or "-machine" option seems like the best alternative.
>
> --
> Eduardo
>
>
