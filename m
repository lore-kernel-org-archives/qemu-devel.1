Received: from eggs.gnu.org ([2001:4830:134:3::10]:35068)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1fzpV9-0007fq-Db
	for qemu-devel@nongnu.org; Tue, 11 Sep 2018 16:43:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1fzpV5-000580-D4
	for qemu-devel@nongnu.org; Tue, 11 Sep 2018 16:43:11 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:33615)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1fzpV5-00057g-8E
	for qemu-devel@nongnu.org; Tue, 11 Sep 2018 16:43:07 -0400
Date: Tue, 11 Sep 2018 16:43:04 -0400
From: "Emilio G. Cota" <cota@braap.org>
Message-ID: <20180911204304.GA20131@flamenco>
References: <20180910232752.31565-1-cota@braap.org>
	<20180910232752.31565-3-cota@braap.org>
	<f6d7f508-eee6-cc53-248c-9553b68d15f5@twiddle.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f6d7f508-eee6-cc53-248c-9553b68d15f5@twiddle.net>
Subject: Re: [Qemu-devel] [PATCH v2 02/12] util: add atomic64
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <rth@twiddle.net>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Eduardo Habkost <ehabkost@redhat.com>, Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>, Murilo Opsfelder Araujo <muriloo@linux.ibm.com>

On Tue, Sep 11, 2018 at 05:43:38 -0700, Richard Henderson wrote:
> On 09/10/2018 04:27 PM, Emilio G. Cota wrote:
> > +#define GEN_READ(name, type)                    \
> > +    type name(const type *ptr)                  \
> > +    {                                           \
> > +        QemuSpin *lock = addr_to_lock(ptr);     \
> > +        type ret;                               \
> > +                                                \
> > +        qemu_spin_lock(lock);                   \
> > +        ret = *ptr;                             \
> > +        qemu_spin_unlock(lock);                 \
> > +        return ret;                             \
> > +    }
> > +
> > +GEN_READ(atomic_read_i64, int64_t)
> > +GEN_READ(atomic_read_u64, uint64_t)
> 
> Is there really a good reason to have two external
> functions instead of having one of them inline and
> perform a cast?

Not really. I can do a follow-up patch if you want me to.

> Is this any better than using libatomic?

I didn't think of using libatomic. I just checked the source
code and it's quite similar:
- It uses 64 locks instead of 16 ($page_size/$cache_line,
  but these are hard-coded for POSIX as 4096/64, respectively)
- We compute the cacheline size and corresponding padding
  at run-time, which is a little better than the above.
- The locks are implemented as pthread_mutex instead of
  spinlocks. I think spinlocks make more sense here because
  we do not expect huge contention (systems without
  !CONFIG_ATOMIC64 have few cores); for libatomic it makes
  sense to use mutexes because it might be used in many-core
  machines.

So yes, we could have used libatomic. If you feel strongly
about it, I can give it a shot.

Thanks,

		Emilio
