Received: from eggs.gnu.org ([2001:4830:134:3::10]:34868)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dovgaluk@ispras.ru>) id 1cwS2o-0004yC-Or
	for qemu-devel@nongnu.org; Fri, 07 Apr 2017 07:27:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dovgaluk@ispras.ru>) id 1cwS2k-0007Ff-RP
	for qemu-devel@nongnu.org; Fri, 07 Apr 2017 07:27:10 -0400
Received: from mail.ispras.ru ([83.149.199.45]:44530)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dovgaluk@ispras.ru>) id 1cwS2k-0007FC-Jn
	for qemu-devel@nongnu.org; Fri, 07 Apr 2017 07:27:06 -0400
From: "Pavel Dovgalyuk" <dovgaluk@ispras.ru>
References: <20170403124524.10824-1-alex.bennee@linaro.org>
	<20170403124524.10824-9-alex.bennee@linaro.org>
	<000101d2ad05$9de02580$d9a07080$@ru>
	<66e3fcfe-6caf-bcbb-cb4e-33d2485c6fb8@redhat.com>
In-Reply-To: <66e3fcfe-6caf-bcbb-cb4e-33d2485c6fb8@redhat.com>
Date: Fri, 7 Apr 2017 14:27:07 +0300
Message-ID: <002a01d2af91$e3c84f80$ab58ee80$@ru>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: 7bit
Content-Language: ru
Subject: Re: [Qemu-devel] [RFC PATCH v1 8/9] cpus: don't credit executed
 instructions before they have run
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: 'Paolo Bonzini' <pbonzini@redhat.com>, =?UTF-8?Q?'Alex_Benn=C3=A9e'?= <alex.bennee@linaro.org>, rth@twiddle.net
Cc: peter.maydell@linaro.org, qemu-devel@nongnu.org, mttcg@greensocs.com, fred.konrad@greensocs.com, a.rigo@virtualopensystems.com, cota@braap.org, bobby.prani@gmail.com, nikunj@linux.vnet.ibm.com, 'Peter Crosthwaite' <crosthwaite.peter@gmail.com>

> From: mttcg-request@listserver.greensocs.com [mailto:mttcg-request@listserver.greensocs.com]
> On 04/04/2017 07:37, Pavel Dovgalyuk wrote:
> >> -        icount -= (cpu->icount_decr.u16.low + cpu->icount_extra);
> >> +        /* Take into account what has run */
> >> +        icount += cpu_get_icount_executed(cpu);
> >>      }
> >>      return icount;
> > As far, as I understand, this one will return the same value in iothread
> > until vCPU thread finishes cpu_exec?
> > This value will not jump forward and backward, but still will not allow
> > making execution deterministic.
> >
> > Consider the following scenarios:
> >
> > First:
> > vCPU            iothread
> > access HW       ----
> > ...             access HW in timer
> >
> > Second:
> > vCPU            iothread
> > ...             access HW in timer
> > access HW       ----
> >
> > These scenarios will generate the same order of events in the log.
> > Synchronization checkpoint in iothread will try to write already
> > executed instructions, but it does not have access to current_cpu
> > and the icount value will point to the "past" - it will have less
> > instructions than already executed.
> 
> The actual access should be covered by a lock, but I think you're right
> that the two threads can be nondeterministically off by one instruction,
> even if we make gen_io_start update timers_state.qemu_icount atomically.

Yes. The actual problem is that icount is updated once for the whole TB.
But TB execution is not atomic and machine state is different in different
parts of TB.

Therefore iothread may expose different behavior depending on moment
when it is activated.

Pavel Dovgalyuk
