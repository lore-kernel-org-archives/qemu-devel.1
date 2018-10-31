Received: from eggs.gnu.org ([2001:4830:134:3::10]:50550)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gHtW9-0003XL-B9
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 12:38:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gHtW4-0007I4-GE
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 12:38:53 -0400
Date: Wed, 31 Oct 2018 12:38:46 -0400
From: "Emilio G. Cota" <cota@braap.org>
Message-ID: <20181031163846.GC15881@flamenco>
References: <20181025144644.15464-1-cota@braap.org>
	<20181025144644.15464-24-cota@braap.org>
	<8736sm857y.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8736sm857y.fsf@linaro.org>
Subject: Re: [Qemu-devel] [RFC v4 24/71] s390x: convert to cpu_halted
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, David Hildenbrand <david@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Richard Henderson <richard.henderson@linaro.org>, Alexander Graf <agraf@suse.de>, Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>

On Wed, Oct 31, 2018 at 16:13:05 +0000, Alex Bennée wrote:
> > @@ -353,10 +355,12 @@ void s390_cpu_unhalt(S390CPU *cpu)
> >      CPUState *cs = CPU(cpu);
> >      trace_cpu_unhalt(cs->cpu_index);
> >
> > -    if (cs->halted) {
> > -        cs->halted = 0;
> > +    cpu_mutex_lock(cs);
> > +    if (cpu_halted(cs)) {
> > +        cpu_halted_set(cs, 0);
> >          cs->exception_index = -1;
> >      }
> > +    cpu_mutex_unlock(cs);
> 
> I think this locking is superfluous as you already added locking when
> you introduced the helper.

It gives a small perf gain, since it avoids locking & unlocking twice
in a row (cpu_halted and cpu_halted_set both take the lock if needed).

> Otherwise:
> 
> Reviewed-by: Alex Bennée <alex.bennee@linaro.org>

Thanks!

		Emilio
