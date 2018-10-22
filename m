Received: from eggs.gnu.org ([2001:4830:134:3::10]:49300)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gEhV4-0005nM-UV
	for qemu-devel@nongnu.org; Mon, 22 Oct 2018 17:12:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gEhUz-0003Gh-Gp
	for qemu-devel@nongnu.org; Mon, 22 Oct 2018 17:12:33 -0400
Date: Mon, 22 Oct 2018 17:12:13 -0400
From: "Emilio G. Cota" <cota@braap.org>
Message-ID: <20181022211213.GA10923@flamenco>
References: <20181019010625.25294-1-cota@braap.org>
	<20181019010625.25294-11-cota@braap.org>
	<5c09eee5-1d26-37ff-f4c7-2262c307c40c@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5c09eee5-1d26-37ff-f4c7-2262c307c40c@linaro.org>
Subject: Re: [Qemu-devel] [RFC v3 10/56] ppc: convert to cpu_halted
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, qemu-ppc@nongnu.org, Alexander Graf <agraf@suse.de>, David Gibson <david@gibson.dropbear.id.au>

On Sun, Oct 21, 2018 at 13:56:59 +0100, Richard Henderson wrote:
> On 10/19/18 2:05 AM, Emilio G. Cota wrote:
> > @@ -1088,11 +1088,13 @@ static target_ulong h_cede(PowerPCCPU *cpu, sPAPRMachineState *spapr,
> >  
> >      env->msr |= (1ULL << MSR_EE);
> >      hreg_compute_hflags(env);
> > +    cpu_mutex_lock(cs);
> >      if (!cpu_has_work(cs)) {
> > -        cs->halted = 1;
> > +        cpu_halted_set(cs, 1);
> >          cs->exception_index = EXCP_HLT;
> >          cs->exit_request = 1;
> >      }
> > +    cpu_mutex_unlock(cs);
> >      return H_SUCCESS;
> 
> Why does this one get extra locking?

It's taking into account that later in the series we
expand the CPU lock to cpu_has_work. I've added the
following note to this patch's commit log:

> In hw/ppc/spapr_hcall.c, acquire the lock just once to
> update cpu->halted and call cpu_has_work, since later
> in the series we'll acquire the BQL (if not already held)
> from cpu_has_work.

Thanks,

		Emilio
