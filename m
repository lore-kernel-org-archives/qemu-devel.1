Received: from eggs.gnu.org ([209.51.188.92]:41910)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ncopa@alpinelinux.org>) id 1gyGOu-0002jk-Az
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 08:34:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ncopa@alpinelinux.org>) id 1gyGOs-0007l0-U7
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 08:34:32 -0500
Received: from mx1.tetrasec.net ([74.117.190.25]:39924)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ncopa@alpinelinux.org>) id 1gyGOs-0007j5-KJ
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 08:34:30 -0500
Date: Mon, 25 Feb 2019 14:25:17 +0100
From: Natanael Copa <ncopa@alpinelinux.org>
Message-ID: <20190225142517.24367cad@ncopa-desktop.copa.dup.pw>
In-Reply-To: <CAFEAcA_F1yxx8Z_8Pc_QOMZ3i9vJLZ8uRze1fTbGfSDs4NAhLg@mail.gmail.com>
References: <VI1PR0602MB32452A8FD128F63FFAC0CEADA4920@VI1PR0602MB3245.eurprd06.prod.outlook.com>
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
	<20190225132156.477faf18@ncopa-desktop.copa.dup.pw>
	<CAFEAcA_F1yxx8Z_8Pc_QOMZ3i9vJLZ8uRze1fTbGfSDs4NAhLg@mail.gmail.com>
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

On Mon, 25 Feb 2019 13:06:16 +0000
Peter Maydell <peter.maydell@linaro.org> wrote:

> On Mon, 25 Feb 2019 at 12:22, Natanael Copa <ncopa@alpinelinux.org> wrote:
> >
> > On Mon, 25 Feb 2019 10:34:23 +0000
> > Peter Maydell <peter.maydell@linaro.org> wrote:  
> > > The short term fix is to fix your toolchain/compilation
> > > environment options so that it isn't trying to override
> > > the definition of memcpy().  
> >
> > The easiest workaround is to simply disable FORTIY_SOURCE, but that
> > will weaken the security for all implemented string functions, strcpy,
> > memmove etc, so I don't want to do that.
> >
> > Is it only lduw_he_p that needs to be atomic or are the other functions
> > in include/qemu/bswap.h using memcpy also required to be atomic?  
> 
> Hard to say, since we haven't done the "audit all the callers"
> step that Stefan mentioned. If you're going to replace memcpy
> with __builtin_memcpy then the safest thing is to do it for
> all those uses (this will also give you much better generated
> code for performance purposes).

I figured that and that is exactly what I did.

Fernando: Can you please test the binary from
qemu-system-x86_64-3.1.0-r3 from alpine edge? I will backport the fix
if you can confirm it fixes the problem.

Thanks!

-nc

PS. Those issues are pretty hard to track down, so big thanks to
everyone who helped find the exact issue here. You have done a great
work!
