Received: from eggs.gnu.org ([2001:4830:134:3::10]:50075)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1fW06Q-0008VG-U8
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 09:58:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1fW06N-0001Ts-RS
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 09:58:22 -0400
Date: Thu, 21 Jun 2018 15:58:15 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20180621155815.54b17623.cohuck@redhat.com>
In-Reply-To: <8f537d31-91df-99cc-624b-82434dc084ee@redhat.com>
References: <20180620100825.22476-1-david@redhat.com>
	<20180620100825.22476-5-david@redhat.com>
	<8f537d31-91df-99cc-624b-82434dc084ee@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 4/7] s390x/tcg: SET CLOCK COMPARATOR can
 clear CKC interrupts
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: David Hildenbrand <david@redhat.com>, qemu-s390x@nongnu.org, qemu-devel@nongnu.org, Richard Henderson <rth@twiddle.net>, Alexander Graf <agraf@suse.de>, Christian Borntraeger <borntraeger@de.ibm.com>

On Thu, 21 Jun 2018 14:09:28 +0200
Thomas Huth <thuth@redhat.com> wrote:

> On 20.06.2018 12:08, David Hildenbrand wrote:
> > Let's stop the timer and delete any pending CKC IRQ before doing
> > anything else.
> > 
> > Signed-off-by: David Hildenbrand <david@redhat.com>
> > ---
> >  target/s390x/misc_helper.c | 6 ++++++
> >  1 file changed, 6 insertions(+)
> > 
> > diff --git a/target/s390x/misc_helper.c b/target/s390x/misc_helper.c
> > index 6ccbe1fe9a..d5f9f5e1d3 100644
> > --- a/target/s390x/misc_helper.c
> > +++ b/target/s390x/misc_helper.c
> > @@ -158,6 +158,12 @@ void HELPER(sckc)(CPUS390XState *env, uint64_t time)
> >      Error *err = NULL;
> >      S390TOD tod_base;
> >  
> > +    /* stop the timer and remove pending CKC IRQs */
> > +    timer_del(env->tod_timer);
> > +    qemu_mutex_lock_iothread();
> > +    env->pending_int &= ~INTERRUPT_EXT_CLOCK_COMPARATOR;
> > +    qemu_mutex_unlock_iothread();  
> 
> Reviewed-by: Thomas Huth <thuth@redhat.com>
> 
> >      if (time == -1ULL) {  
> 
> I wonder whether that check is still adequate? Is there really a way to
> disable the clock comparator like this? At least I haven't seen it in
> the PoP.

Me neither. It seems to have been in the code since the beginning...

> 
> >          return;
> >      }
> >   
> 
