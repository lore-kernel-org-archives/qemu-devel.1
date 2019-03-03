Received: from eggs.gnu.org ([209.51.188.92]:48918)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1h0Y0w-0005ST-00
	for qemu-devel@nongnu.org; Sun, 03 Mar 2019 15:47:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1h0Y0u-0000wO-42
	for qemu-devel@nongnu.org; Sun, 03 Mar 2019 15:47:13 -0500
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:58479)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1h0Y0q-0000oL-G4
	for qemu-devel@nongnu.org; Sun, 03 Mar 2019 15:47:10 -0500
Date: Sun, 3 Mar 2019 15:47:05 -0500
From: "Emilio G. Cota" <cota@braap.org>
Message-ID: <20190303204705.GB12447@flamenco>
References: <20190130004811.27372-1-cota@braap.org>
	<20190130004811.27372-73-cota@braap.org>
	<87y36ql42n.fsf@zen.linaroharston>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87y36ql42n.fsf@zen.linaroharston>
Subject: Re: [Qemu-devel] [PATCH v6 72/73] cpu: add async_run_on_cpu_no_bql
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <richard.henderson@linaro.org>

On Fri, Feb 08, 2019 at 14:58:40 +0000, Alex Bennée wrote:
> 
> Emilio G. Cota <cota@braap.org> writes:
> 
> > Some async jobs do not need the BQL.
> >
> > Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> > Signed-off-by: Emilio G. Cota <cota@braap.org>
(snip)
> So we now have a locking/scheduling hierarchy that goes:
> 
>   - run_on_cpu - synchronously wait until target cpu has done the thing
>   - async_run_on_cpu - schedule work on cpu at some point (soon) resources protected by BQL
>   - async_run_on_cpu_no_bql - as above but only protected by cpu_lock

This one doesn't hold any locks when calling the passed function,
though. The CPU lock is just to serialise the queueing/dequeueing.

>   - async_safe_run_on_cpu - as above but locking (probably) not required as everything else asleep
> 
> So the BQL is only really needed to manipulate data that is shared
> across multiple vCPUs like device emulation or other state shared across
> multiple vCPUS. For all "just do it over there" cases we should be able
> to stick to cpu locks.
> 
> It would be nice if we could expand the documentation in
> multi-thread-tcg.txt to cover this in long form for people trying to
> work out the best thing to use.

I think the documentation in the functions is probably enough -- they
point to each other, so figuring out what to use should be pretty easy.

Besides, these functions aren't MTTCG-only, they're QEMU-wide, so
perhaps their documentation should go in a different file?

Since this can be done later, I'll post a v7 with the other
changes you suggested.

> Reviewed-by: Alex Bennée <alex.bennee@linaro.org>

Thanks!

		Emilio
