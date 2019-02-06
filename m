Received: from eggs.gnu.org ([209.51.188.92]:39917)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1grTOg-0005AH-6D
	for qemu-devel@nongnu.org; Wed, 06 Feb 2019 15:02:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1grTOe-0002m5-Lz
	for qemu-devel@nongnu.org; Wed, 06 Feb 2019 15:02:14 -0500
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:47349)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1grTOe-0002lR-8v
	for qemu-devel@nongnu.org; Wed, 06 Feb 2019 15:02:12 -0500
Date: Wed, 6 Feb 2019 15:02:09 -0500
From: "Emilio G. Cota" <cota@braap.org>
Message-ID: <20190206200209.GA1562@flamenco>
References: <20190130004811.27372-1-cota@braap.org>
	<20190130004811.27372-4-cota@braap.org>
	<8736p0omt0.fsf@zen.linaroharston>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8736p0omt0.fsf@zen.linaroharston>
Subject: Re: [Qemu-devel] [PATCH v6 03/73] cpu: introduce
 cpu_mutex_lock/unlock
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

On Wed, Feb 06, 2019 at 17:21:15 +0000, Alex Bennée wrote:
> Emilio G. Cota <cota@braap.org> writes:
> > +/*
> > + * Note: we index the bitmap with cpu->cpu_index + 1 so that the logic
> > + * also works during early CPU initialization, when cpu->cpu_index is set to
> > + * UNASSIGNED_CPU_INDEX == -1.
> > + */
> > +static __thread DECLARE_BITMAP(cpu_lock_bitmap,
> > CPU_LOCK_BITMAP_SIZE);
> 
> I'm a little confused by this __thread bitmap. So by being a __thread
> this is a per thread record (like __thread bool iothread_locked) of the
> lock. However the test bellow:
> 
> > +
> > +bool no_cpu_mutex_locked(void)
> > +{
> > +    return bitmap_empty(cpu_lock_bitmap, CPU_LOCK_BITMAP_SIZE);
> > +}
> 
> which is used for asserts implies the only case we care about is
> ensuring one thread doesn't take multiple cpu locks (which seems
> reasonable). The only other test is used by cpu_mutex_locked to see if
> the current thread has locked a given CPU index.
> 
> Given that a thread can only be in two conditions:
> 
>   - no lock held
>   - holding lock for cpu->index
> 
> Why the bitmap?

(snip)

> If I've missed something I think the doc comment needs to be a bit more
> explicit about our locking rules.

The missing bit is that the bitmap is not only used for asserts; by the
end of the series, we sometimes acquire all cpu locks (in CPU_FOREACH order
to avoid deadlock), e.g. in pause_all_vcpus(). Given that this happens
in patch 70, I think your comment here is reasonable.

I'll update the commit message to explain why we add now the
bitmap, even if it in this patch it isn't needed yet.

> <snip>
> >
> > +    /* prevent deadlock with CPU mutex */
> > +    g_assert(no_cpu_mutex_locked());
> > +
> 
> Technically asserts don't prevent this - they are just enforcing the
> locking rules otherwise we would deadlock.

Agreed. With that comment I mean "make sure we're following the
locking order". Will fix.

Thanks,

		E.
