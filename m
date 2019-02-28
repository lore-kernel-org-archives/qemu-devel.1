Received: from eggs.gnu.org ([209.51.188.92]:50248)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gzITC-0007VX-1F
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 04:59:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gzIT4-00055U-1B
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 04:59:08 -0500
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:38311)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gzIT1-00051a-Be
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 04:59:04 -0500
Received: by mail-oi1-x242.google.com with SMTP id q81so16018699oic.5
	for <qemu-devel@nongnu.org>; Thu, 28 Feb 2019 01:58:48 -0800 (PST)
MIME-Version: 1.0
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
	<20190225132156.477faf18@ncopa-desktop.copa.dup.pw>
	<CAFEAcA_F1yxx8Z_8Pc_QOMZ3i9vJLZ8uRze1fTbGfSDs4NAhLg@mail.gmail.com>
In-Reply-To: <CAFEAcA_F1yxx8Z_8Pc_QOMZ3i9vJLZ8uRze1fTbGfSDs4NAhLg@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 28 Feb 2019 09:58:34 +0000
Message-ID: <CAFEAcA9g42CzcV3n-ONQ=sD5O_gPpQGACArtzg7_TJ82Oq7DzQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
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
To: Natanael Copa <ncopa@alpinelinux.org>
Cc: Stefan Hajnoczi <stefanha@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Fernando_Casas_Sch=C3=B6ssow?= <casasfernando@outlook.com>, qemu-devel <qemu-devel@nongnu.org>, Richard Henderson <rth@twiddle.net>

On Mon, 25 Feb 2019 at 13:06, Peter Maydell <peter.maydell@linaro.org> wrote:
>
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

I mentioned this to Richard on IRC the other day, but I think there's
a good argument for making upstream QEMU use __builtin_memcpy in
these helpers:
 * it makes us robust against things like this fortify library
   in the short term (until we fix QEMU to have an equivalent set
   of functions for doing atomic accesses to AddressSpaces)
 * in the longer term it will mean that we don't end up with
   these functions being really badly-performing even if the
   semantics of the out-of-line memcpy() are correct

thanks
-- PMM
