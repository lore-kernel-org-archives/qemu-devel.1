Received: from eggs.gnu.org ([209.51.188.92]:36237)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gjn9A-0006oo-H9
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 10:30:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gjn91-0000Mx-Il
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 10:30:26 -0500
Received: from mx1.redhat.com ([209.132.183.28]:59052)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1gjn8z-0000H5-SQ
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 10:30:19 -0500
Date: Wed, 16 Jan 2019 13:30:11 -0200
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20190116153011.GB14807@habkost.net>
References: <20190114215225.GA16760@habkost.net>
	<CAL1e-=iBx0Dt=S5fyLs8v-XN+2Zmx5hb7StQBJhquUmmdw6uNA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL1e-=iBx0Dt=S5fyLs8v-XN+2Zmx5hb7StQBJhquUmmdw6uNA@mail.gmail.com>
Subject: Re: [Qemu-devel] Meaning of "-smp threads" on mips_malta
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Aleksandar Rikalo <arikalo@wavecomp.com>, Stefan Markovic <smarkovic@wavecomp.com>, Aleksandar Markovic <amarkovic@wavecomp.com>, Aurelien Jarno <aurelien@aurel32.net>, Igor Mammedov <imammedo@redhat.com>

On Tue, Jan 15, 2019 at 03:28:50AM +0100, Aleksandar Markovic wrote:
> On Monday, January 14, 2019, Eduardo Habkost <ehabkost@redhat.com> wrote:
> 
> > Hi,
> >
> > I'm trying to refactor the SMP topology code in QEMU
> 
> 
> >
> Eduardo, I truly appreciate your interest in details of Malta
> implementations, but before I answer your questions, could you please
> outline the motivation and the current concept of your envisioned
> refactoring of SMP, so that I have some picture of the whole context?

I don't have any concrete plans right now.  I'm trying to
understand how existing code uses the -smp options, before
deciding what to do.

My goal is to make features like
  "[PATCH v1 0/5] Introduce cpu die topology and enable CPUID.1F for i386"
easier, less intrusive, and less risky.

My current impression is that things will be better if we move
the complex PC-specific topology rules from vl.c to PC-specific
code.  Most of the other architectures seem to have different
assumptions and expectations about -smp/cores/threads.


> 
> Sincerely, Aleksandar
> 
> 
> 
> >
> > and I found
> > some suspicious code on mips_malta.c:
> >
> > static void malta_mips_config(MIPSCPU *cpu)
> > {
> >     CPUMIPSState *env = &cpu->env;
> >     CPUState *cs = CPU(cpu);
> >
> >     env->mvp->CP0_MVPConf0 |= ((smp_cpus - 1) << CP0MVPC0_PVPE) |
> >                          ((smp_cpus * cs->nr_threads - 1) << CP0MVPC0_PTC);
> > }
> >
> >
> > The (smp_cpus * cs->nr_threads) expression here doesn't make
> > sense to me (because smp_cpus is already supposed to be a
> > multiple of smp_threads), and seems to indicate that the code has
> > some unusual assumptions about the semantics of the -smp option.
> >
> > So, I'd like to know: do all the examples below make sense for
> > Malta?
> >
> >  -smp 1
> >  -smp 2
> >  -smp 2,threads=1
> >  -smp 2,threads=2
> >  -smp 1,threads=2 [*]
> >  -smp 2,threads=3 [*]
> >
> > The generic -smp parsing code considers the last 2 entries
> > above[*] to be invalid.  If they make sense for Malta, we need to
> > find a way to fix that.  Replacing "-smp threads=..." with a
> > "-cpu" or "-machine" option seems like the best alternative.
> >
> > --
> > Eduardo
> >
> >

-- 
Eduardo
