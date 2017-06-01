Received: from eggs.gnu.org ([2001:4830:134:3::10]:40167)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dGRD8-000815-BD
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 10:36:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dGRD4-0004CF-Bo
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 10:36:26 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34704)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1dGRD4-0004Bv-5f
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 10:36:22 -0400
Date: Thu, 1 Jun 2017 15:36:17 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170601143616.GA2845@work-vm>
References: <1495229390-18909-1-git-send-email-felipe@nutanix.com>
	<d643e698-8093-3e46-91de-551db41f3ec3@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d643e698-8093-3e46-91de-551db41f3ec3@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH] cpus: reset throttle_thread_scheduled
 after sleep
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Jason J. Herne" <jjherne@linux.vnet.ibm.com>
Cc: Felipe Franciosi <felipe@nutanix.com>, Paolo Bonzini <pbonzini@redhat.com>, Malcolm Crossley <malcolm@nutanix.com>, Juan Quintela <quintela@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>

* Jason J. Herne (jjherne@linux.vnet.ibm.com) wrote:
> On 05/19/2017 05:29 PM, Felipe Franciosi wrote:
> > Currently, the throttle_thread_scheduled flag is reset back to 0 before
> > sleeping (as part of the throttling logic). Given that throttle_timer
> > (well, any timer) may tick with a slight delay, it so happens that under
> > heavy throttling (ie. close or on CPU_THROTTLE_PCT_MAX) the tick may
> > schedule a further cpu_throttle_thread() work item after the flag reset,
> > but before the previous sleep completed. This results on the vCPU thread
> > sleeping continuously for potentially several seconds in a row.
> > 
> > The chances of that happening can be drastically minimised by resetting
> > the flag after the sleep.
> > 
> > Signed-off-by: Felipe Franciosi <felipe@nutanix.com>
> > Signed-off-by: Malcolm Crossley <malcolm@nutanix.com>
> > ---
> >  cpus.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/cpus.c b/cpus.c
> > index 516e5cb..f42eebd 100644
> > --- a/cpus.c
> > +++ b/cpus.c
> > @@ -677,9 +677,9 @@ static void cpu_throttle_thread(CPUState *cpu, run_on_cpu_data opaque)
> >      sleeptime_ns = (long)(throttle_ratio * CPU_THROTTLE_TIMESLICE_NS);
> > 
> >      qemu_mutex_unlock_iothread();
> > -    atomic_set(&cpu->throttle_thread_scheduled, 0);
> >      g_usleep(sleeptime_ns / 1000); /* Convert ns to us for usleep call */
> >      qemu_mutex_lock_iothread();
> > +    atomic_set(&cpu->throttle_thread_scheduled, 0);
> >  }
> > 
> >  static void cpu_throttle_timer_tick(void *opaque)
> > 
> 
> This seems to make sense to me.
> 
> Acked-by: Jason J. Herne <jjherne@linux.vnet.ibm.com>
> 
> I'm CC'ing Juan, Amit and David as they are all active in the migration area
> and may have
> opinions on this. Juan and David were also reviewers for the original
> series.

The description is interesting and sounds reasonable; it'll be
interesting to see what difference it makes to the autoconverge
behaviour for those workloads that need this level of throttle.

Dave

> -- 
> -- Jason J. Herne (jjherne@linux.vnet.ibm.com)
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
