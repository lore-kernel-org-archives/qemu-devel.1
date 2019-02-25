Received: from eggs.gnu.org ([209.51.188.92]:57189)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ncopa@alpinelinux.org>) id 1gyFO7-0003wO-Ct
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 07:29:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ncopa@alpinelinux.org>) id 1gyFO1-00039z-Ll
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 07:29:35 -0500
Received: from mx1.tetrasec.net ([74.117.190.25]:34458)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ncopa@alpinelinux.org>) id 1gyFO1-00033D-EG
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 07:29:33 -0500
Date: Mon, 25 Feb 2019 13:21:56 +0100
From: Natanael Copa <ncopa@alpinelinux.org>
Message-ID: <20190225132156.477faf18@ncopa-desktop.copa.dup.pw>
In-Reply-To: <CAFEAcA-nfqk9+x1F4nUC0djYRnAgGZL4d9X6rYLBJPvuKCdjbQ@mail.gmail.com>
References: <VI1PR0602MB32452A8FD128F63FFAC0CEADA4920@VI1PR0602MB3245.eurprd06.prod.outlook.com>
	<VI1PR0602MB324516419266A934FE7759C6A47E0@VI1PR0602MB3245.eurprd06.prod.outlook.com>
	<VI1PR0602MB324516419266A934FE7759C6A47E0@VI1PR0602MB3245.eurprd06.prod.outlo>
	<VI1PR0602MB32454C17192EFA863E29CC49A47E0@VI1PR0602MB3245.eurprd06.prod.outlo>
	<VI1PR0602MB324547F72DA9EDEB1613C888A47E0@VI1PR0602MB3245.eurprd06.prod.outlook.com>
	<CAJSP0QUg=cq3tCSLidQ9BR2hxAo3K6gA6LKtpx5Rjb=_6XgJ6Q@mail.gmail.com>
	<28e6b4ed-9afd-3a79-6267-86c7385c23ce@redhat.com>
	<VI1PR0602MB324578F91F1AF9390D03022FA47F0@VI1PR0602MB3245.eurprd06.prod.outlook.com>
	<CAJSP0QWouR43wVi0guTuASP9gc24_CPucbBvtfE5_htkDkmsrQ@mail.gmail.com>
	<20190223165523.1d674224@ncopa-desktop.copa.dup.pw>
	<CAFEAcA8kOEJe-Ax_SFOCa49og-N7gpO-ptsANdvXPhKthrpb8A@mail.gmail.com>
	<20190225112424.2dd535a1@ncopa-desktop.copa.dup.pw>
	<CAFEAcA-nfqk9+x1F4nUC0djYRnAgGZL4d9X6rYLBJPvuKCdjbQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Qemu-block] Guest unresponsive after Virtqueue
 size exceeded error
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Stefan Hajnoczi <stefanha@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, Fernando Casas =?ISO-8859-1?B?U2No9nNzb3c=?= <casasfernando@outlook.com>, qemu-devel <qemu-devel@nongnu.org>, Richard Henderson <rth@twiddle.net>

On Mon, 25 Feb 2019 10:34:23 +0000
Peter Maydell <peter.maydell@linaro.org> wrote:

> On Mon, 25 Feb 2019 at 10:24, Natanael Copa <ncopa@alpinelinux.org> wrote:
> >
> > On Sat, 23 Feb 2019 16:18:15 +0000
> > Peter Maydell <peter.maydell@linaro.org> wrote:
> >  
> > > On Sat, 23 Feb 2019 at 16:05, Natanael Copa <ncopa@alpinelinux.org> wrote:  
> > > > I was thinking of something in the lines of:
> > > >
> > > > typedef volatile uint16_t __attribute__((__may_alias__)) volatile_uint16_t;
> > > > static inline int lduw_he_p(const void *ptr)
> > > > {
> > > >      volatile_uint16_t r = *(volatile_uint16_t*)ptr;
> > > >      return r;
> > > > }  
> > >
> > > This won't correctly handle accesses with unaligned pointers,
> > > I'm afraid. We rely on these functions correctly working
> > > with pointers that are potentially unaligned.  
> >
> > Well, current code does not even handle access with aligned pointers,
> > depending on FORTIFY_SOURCE implementation.  
> 
> It correctly handles aligned and unaligned pointers for the
> API guarantees that the function in QEMU provides, which is
> to say "definitely works on any kind of aligned or unaligned
> pointer, not guaranteed to be atomic". Unfortunately some
> code in QEMU is implicitly assuming it is atomic, which this
> QEMU function does not guarantee -- it just happens to provide
> that most of the time.
> 
> > My thinking here is that we depend on assumption that compiler will
> > remove the memcpy call, so maybe find other way to generate same
> > assembly, while still depend on compiler optimization.  
> 
> > I did some tests and compared the assembly output. The compiler will
> > generate same assembly if volatile is not used. The attribute
> > __may_alias__ does not seem to make any difference. So the following
> > function generates exactly same assembly:
> >
> > static inline int lduw_he_p(const void *ptr)
> > {
> >         uint16_t r = *(uint16_t*)ptr;
> >         return r;
> > }  
> 
> This still is not guaranteed to work on unaligned pointers.
> (For instance it probably won't work on SPARC hosts.)
> More generally there is no way to have a single function
> that is guaranteed to handle unaligned pointers and also
> guaranteed to produce an atomic access on all host architectures
> that we support, because not all host architectures allow
> you to do both with the same instruction sequence. So
> you can't just change this function to make it provide
> atomic access without breaking the other guarantee it is
> providing.

Right, so it is possible that there are other architectures (like
SPARC) that suffer from the same race here as Alpine, because memcpy is
not guaranteed to be atomic.

> The long term fix for this is that we need to separate out
> our APIs so we can have a family of functions that guarantee
> to work on unaligned pointers, and a family that guarantee
> to work atomically, and calling code can use the one that
> provides the semantics it requires.
> 
> The short term fix is to fix your toolchain/compilation
> environment options so that it isn't trying to override
> the definition of memcpy().

The easiest workaround is to simply disable FORTIY_SOURCE, but that
will weaken the security for all implemented string functions, strcpy,
memmove etc, so I don't want to do that.

Is it only lduw_he_p that needs to be atomic or are the other functions
in include/qemu/bswap.h using memcpy also required to be atomic?

I intend to replace memcpy with __builtin_memcpy there.

> 
> thanks
> -- PMM
