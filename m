Received: from eggs.gnu.org ([2001:4830:134:3::10]:34950)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1cegpk-0005B8-R0
	for qemu-devel@nongnu.org; Fri, 17 Feb 2017 06:36:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1cegpj-00041N-Uu
	for qemu-devel@nongnu.org; Fri, 17 Feb 2017 06:36:16 -0500
Date: Fri, 17 Feb 2017 11:36:03 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170217113601.GB4941@work-vm>
References: <1487318764-29513-1-git-send-email-pagupta@redhat.com>
	<w51poihqggo.fsf@maestria.local.igalia.com>
	<1323841238.24175066.1487331028566.JavaMail.zimbra@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1323841238.24175066.1487331028566.JavaMail.zimbra@redhat.com>
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
To: Pankaj Gupta <pagupta@redhat.com>
Cc: Alberto Garcia <berto@igalia.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org, kwolf@redhat.com, quintela@redhat.com, mreitz@redhat.com

* Pankaj Gupta (pagupta@redhat.com) wrote:
> 
> Thanks for your comments. I have below query.
> > 
> > On Fri 17 Feb 2017 09:06:04 AM CET, Pankaj Gupta wrote:
> > >  To maintain consistency at all the places use qemu_madvise wrapper
> > >  inplace of madvise call.
> > 
> > >      if (length > 0) {
> > > -        madvise((uint8_t *) t + offset, length, MADV_DONTNEED);
> > > +        qemu_madvise((uint8_t *) t + offset, length, QEMU_MADV_DONTNEED);
> > 
> > This was changed two months ago from qemu_madvise() to madvise(), is
> > there any reason why you want to revert that change? Those two calls are
> > not equivalent, please see commit 2f2c8d6b371cfc6689affb0b7e for an
> > explanation.
> > 
> > > -    if (madvise(start, length, MADV_DONTNEED)) {
> > > +    if (qemu_madvise(start, length, QEMU_MADV_DONTNEED)) {
> > >          error_report("%s MADV_DONTNEED: %s", __func__, strerror(errno));
> 
> I checked history of only change related to 'postcopy'.
> 
> For my linux machine:
> 
> ./config-host.mak
> 
> CONFIG_MADVISE=y
> CONFIG_POSIX_MADVISE=y
> 
> As both these options are set for Linux, every time we call call 'qemu_madvise' ==>"madvise(addr, len, advice);" will 
> be compiled/called. I don't understand why '2f2c8d6b371cfc6689affb0b7e' explicitly changed for :"#ifdef CONFIG_LINUX"
> I think its better to write generic function maybe in a wrapper then to conditionally set something at different places.

No; the problem is that the behaviours are different.
You're right that the current build on Linux defines MADVISE and thus we are safe because qemu_madvise
takes teh CONFIG_MADVISE/madvise route - but we need to be explicit that it's only
the madvise() route that's safe, not any of the calls implemented by 
qemu_madvise, because if in the future someone was to rearrange qemu_madvise
to prefer posix_madvise postcopy would break in a very subtle way.

IMHO it might even be better to remove the definition of QEMU_MADV_DONTNEED altogether
and make a name that wasn't ambiguous between the two, since the posix definition is
so different.

Dave

> int qemu_madvise(void *addr, size_t len, int advice)
> {
>     if (advice == QEMU_MADV_INVALID) {
>         errno = EINVAL;
>         return -1;
>     }
> #if defined(CONFIG_MADVISE)
>     return madvise(addr, len, advice);
> #elif defined(CONFIG_POSIX_MADVISE)
>     return posix_madvise(addr, len, advice);
> #else
>     errno = EINVAL;
>     return -1;
> #endif
> }
> 
> > 
> > And this is the same case.
> > 
> > Berto
> > 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
