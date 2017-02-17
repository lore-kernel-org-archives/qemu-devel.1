Received: from eggs.gnu.org ([2001:4830:134:3::10]:49817)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pagupta@redhat.com>) id 1cehgf-0001YQ-NR
	for qemu-devel@nongnu.org; Fri, 17 Feb 2017 07:30:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pagupta@redhat.com>) id 1cehgY-0001Gb-SW
	for qemu-devel@nongnu.org; Fri, 17 Feb 2017 07:30:56 -0500
Date: Fri, 17 Feb 2017 07:30:09 -0500 (EST)
From: Pankaj Gupta <pagupta@redhat.com>
Message-ID: <1252732340.24195236.1487334609462.JavaMail.zimbra@redhat.com>
In-Reply-To: <20170217113601.GB4941@work-vm>
References: <1487318764-29513-1-git-send-email-pagupta@redhat.com>
	<w51poihqggo.fsf@maestria.local.igalia.com>
	<1323841238.24175066.1487331028566.JavaMail.zimbra@redhat.com>
	<20170217113601.GB4941@work-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH] block,
 migration: Use qemu_madvise inplace of madvise
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: kwolf@redhat.com, Alberto Garcia <berto@igalia.com>, qemu-block@nongnu.org, quintela@redhat.com, qemu-devel@nongnu.org, mreitz@redhat.com


> 
> * Pankaj Gupta (pagupta@redhat.com) wrote:
> > 
> > Thanks for your comments. I have below query.
> > > 
> > > On Fri 17 Feb 2017 09:06:04 AM CET, Pankaj Gupta wrote:
> > > >  To maintain consistency at all the places use qemu_madvise wrapper
> > > >  inplace of madvise call.
> > > 
> > > >      if (length > 0) {
> > > > -        madvise((uint8_t *) t + offset, length, MADV_DONTNEED);
> > > > +        qemu_madvise((uint8_t *) t + offset, length,
> > > > QEMU_MADV_DONTNEED);
> > > 
> > > This was changed two months ago from qemu_madvise() to madvise(), is
> > > there any reason why you want to revert that change? Those two calls are
> > > not equivalent, please see commit 2f2c8d6b371cfc6689affb0b7e for an
> > > explanation.
> > > 
> > > > -    if (madvise(start, length, MADV_DONTNEED)) {
> > > > +    if (qemu_madvise(start, length, QEMU_MADV_DONTNEED)) {
> > > >          error_report("%s MADV_DONTNEED: %s", __func__,
> > > >          strerror(errno));
> > 
> > I checked history of only change related to 'postcopy'.
> > 
> > For my linux machine:
> > 
> > ./config-host.mak
> > 
> > CONFIG_MADVISE=y
> > CONFIG_POSIX_MADVISE=y
> > 
> > As both these options are set for Linux, every time we call call
> > 'qemu_madvise' ==>"madvise(addr, len, advice);" will
> > be compiled/called. I don't understand why '2f2c8d6b371cfc6689affb0b7e'
> > explicitly changed for :"#ifdef CONFIG_LINUX"
> > I think its better to write generic function maybe in a wrapper then to
> > conditionally set something at different places.
> 
> No; the problem is that the behaviours are different.
> You're right that the current build on Linux defines MADVISE and thus we are
> safe because qemu_madvise
> takes teh CONFIG_MADVISE/madvise route - but we need to be explicit that it's
> only
> the madvise() route that's safe, not any of the calls implemented by
> qemu_madvise, because if in the future someone was to rearrange qemu_madvise
> to prefer posix_madvise postcopy would break in a very subtle way.

Agree. 
We can add comment explaining this?

> 
> IMHO it might even be better to remove the definition of QEMU_MADV_DONTNEED
> altogether
> and make a name that wasn't ambiguous between the two, since the posix
> definition is
> so different.

I think 'posix_madvise' was added for systems which didnot have 'madvise'.
If I look at makefile, first we check what all calls are available and then 
set config option accordingly. We give 'madvise' precedence over 'posix_madvise' 
if both are present. 

For the systems which don't have madvise call 'posix_madvise' is called which as per
discussion is not right thing for 'DONTNEED' option. It will not give desired results.

Either we have to find right alternative or else it is already broken for systems which
don't support madvise.

> 
> Dave
> 
> > int qemu_madvise(void *addr, size_t len, int advice)
> > {
> >     if (advice == QEMU_MADV_INVALID) {
> >         errno = EINVAL;
> >         return -1;
> >     }
> > #if defined(CONFIG_MADVISE)
> >     return madvise(addr, len, advice);
> > #elif defined(CONFIG_POSIX_MADVISE)
> >     return posix_madvise(addr, len, advice);
> > #else
> >     errno = EINVAL;
> >     return -1;
> > #endif
> > }
> > 
> > > 
> > > And this is the same case.
> > > 
> > > Berto
> > > 
> --
> Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
> 
> 
