Received: from eggs.gnu.org ([2001:4830:134:3::10]:47207)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1cu1zI-0003OX-Uh
	for qemu-devel@nongnu.org; Fri, 31 Mar 2017 15:13:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1cu1zF-0000eS-PL
	for qemu-devel@nongnu.org; Fri, 31 Mar 2017 15:13:32 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40076)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1cu1zF-0000da-H3
	for qemu-devel@nongnu.org; Fri, 31 Mar 2017 15:13:29 -0400
Date: Fri, 31 Mar 2017 20:13:22 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170331191321.GI2408@work-vm>
References: <1490599288-11751-1-git-send-email-peterx@redhat.com>
	<1490599288-11751-6-git-send-email-peterx@redhat.com>
	<aa26e76e-e5fd-c205-8919-6cc927a6d3ce@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aa26e76e-e5fd-c205-8919-6cc927a6d3ce@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 5/5] cpu: throttle: fix throttle time slice
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org, Juan Quintela <quintela@redhat.com>, Richard Henderson <rth@twiddle.net>, jjherne@linux.vnet.ibm.com

Ignoring the details below for a minute, this patch belongs in a separate
series; all the rest of the patches in this set are nice simple ones.

* Paolo Bonzini (pbonzini@redhat.com) wrote:
> 
> 
> On 27/03/2017 09:21, Peter Xu wrote:
> > @@ -641,8 +640,7 @@ static void cpu_throttle_thread(CPUState *cpu, run_on_cpu_data opaque)
> >      }
> >  
> >      pct = (double)cpu_throttle_get_percentage()/100;
> > -    throttle_ratio = pct / (1 - pct);
> > -    sleeptime_ns = (long)(throttle_ratio * CPU_THROTTLE_TIMESLICE_NS);
> 
> Say pct = 0.25, then throttle_ratio = 0.25/0.75 = 1/3.
> 
> > +    sleeptime_ns = (long)((1 - pct) * CPU_THROTTLE_TIMESLICE_NS);
> >  
> >      qemu_mutex_unlock_iothread();
> >      atomic_set(&cpu->throttle_thread_scheduled, 0);
> > @@ -668,7 +666,7 @@ static void cpu_throttle_timer_tick(void *opaque)
> >  
> >      pct = (double)cpu_throttle_get_percentage()/100;
> >      timer_mod(throttle_timer, qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL_RT) +
> > -                                   CPU_THROTTLE_TIMESLICE_NS / (1-pct));
> 
> And the timer is running every 1/0.75 = 4/3 * CPU_THROTTLE_TIMESLICE_NS.
> 
> Of these, 1/3 is spent sleeping (3.33 ms), while 1 (10 ms) is spent not
> sleeping.
> 
> When pct = 0.75, throttle_ratio = 3 and the timer is running every 4 *
> CPU_THROTTLE_TIMESLICE_NS (40 ms).  Of these, 3 slices (30 ms) are spent
> sleeping, while 10 ms are spent not sleeping.
> 
> The rationale _could_ be (I don't remember) that a CPU with a very high
> throttling frequency leaves little time for the migration thread to do
> any work.  So QEMU keeps the "on" phase always the same and lengthens
> the "off" phase, which as you found out can be unsatisfactory.
> 
> However, I think your patch has the opposite problem: the frequency is
> constant, but with high throttling all time reserved for the CPU will be
> lost in overhead.  For example, at 99% throttling you only have 100
> microseconds to wake up, do work and go back to sleep.

Yes, and I'm worried that with the 10ms timeslice it is a lot of overhead,
especially if your timer that wakes you have that much higher resolution than
that.

> So I'm inclined _not_ to take your patch.  One possibility could be to
> do the following:
> 
> - for throttling between 0% and 80%, use the current algorithm.  At 66%,
> the CPU will work for 10 ms and sleep for 40 ms.
> 
> - for throttling above 80% adapt your algorithm to have a variable
> timeslice, going from 50 ms at 66% to 100 ms at 100%.  This way, the CPU
> time will shrink below 10 ms and the sleep time will grow.

It seems odd to have a threshold like that on something that's supposedly
a linear scale.

> It looks like this: http://i.imgur.com/lyFie04.png
> 
> So at 99% the timeslice will be 97.5 ms; the CPU will work for 975 us
> and sleep for the rest (10x more than with just your patch).  But I'm
> not sure it's really worth it.

Can you really run a CPU for 975us ?

Dave

> Paolo
> 
> > +                                   CPU_THROTTLE_TIMESLICE_NS * pct);
> >  }
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
