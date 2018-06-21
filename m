Received: from eggs.gnu.org ([2001:4830:134:3::10]:56056)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1fW0Uo-0001Il-HA
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 10:23:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1fW0Uk-0006Hk-Ir
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 10:23:34 -0400
Date: Thu, 21 Jun 2018 16:23:24 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20180621162324.5b33b827.cohuck@redhat.com>
In-Reply-To: <051d6c6f-13c9-589e-a8f9-cf1439f3b751@redhat.com>
References: <20180620100825.22476-1-david@redhat.com>
	<20180620100825.22476-6-david@redhat.com>
	<0544e011-e909-6bca-e4ca-5a1caa141f4b@redhat.com>
	<051d6c6f-13c9-589e-a8f9-cf1439f3b751@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 5/7] s390x/tcg: implement SET CLOCK
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>, qemu-s390x@nongnu.org, qemu-devel@nongnu.org, Richard Henderson <rth@twiddle.net>, Alexander Graf <agraf@suse.de>, Christian Borntraeger <borntraeger@de.ibm.com>

On Thu, 21 Jun 2018 16:01:22 +0200
David Hildenbrand <david@redhat.com> wrote:

> On 21.06.2018 15:14, Thomas Huth wrote:
> > On 20.06.2018 12:08, David Hildenbrand wrote:  

> >> +/* Set Clock */
> >> +uint32_t HELPER(sck)(CPUS390XState *env, uint64_t tod_low)
> >> +{
> >> +    S390TODState *td = s390_get_tod();
> >> +    S390TODClass *tdc = S390_TOD_GET_CLASS(td);
> >> +    S390TOD tod = {
> >> +        .high = 0,
> >> +        .low = tod_low,
> >> +    };
> >> +    Error *err = NULL;
> >> +
> >> +    qemu_mutex_lock_iothread();
> >> +    tdc->set(td, &tod, &err);
> >> +    qemu_mutex_unlock_iothread();
> >> +    g_assert(!err);  
> > 
> > I know it currently can't happen, but still, I think it would be nicer
> > to use CC3 to tell the guest that something went wrong with the clock,
> > instead of abort QEMU here.  
> 
> Hmm, I thing I should either use error_abort here or do what you suggest.
> 
> However, CC=3 means "Clock in not-operational state".
> 
> And this implies that also STORE CLOCK and friends will have to fail and
> that we have to present a machine check. Especially, once we would
> implement the TOD-clock steering facility, CC=3 would not apply anymore.
> 
> So instead of faking something that is not architecturally correct, I
> think we really should just quit QEMU, as we expect this to never fail.

I think error_abort is the best way to handle that, then.
