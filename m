Received: from eggs.gnu.org ([209.51.188.92]:43364)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hDppA-0001NZ-Fv
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 08:26:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hDpp9-0004LI-F9
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 08:26:00 -0400
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:46529)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hDpp8-0004L0-Sr
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 08:25:59 -0400
Received: by mail-ot1-x343.google.com with SMTP id s24so10153553otk.13
	for <qemu-devel@nongnu.org>; Tue, 09 Apr 2019 05:25:58 -0700 (PDT)
MIME-Version: 1.0
References: <20190318112938.8298-1-peter.maydell@linaro.org>
	<6201d9df-07d2-6ed2-64b6-17d436111c13@redhat.com>
In-Reply-To: <6201d9df-07d2-6ed2-64b6-17d436111c13@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 9 Apr 2019 13:25:47 +0100
Message-ID: <CAFEAcA8caDyfuCzMTw5zTCe=qTaA7TvEqF6ePNS1+WUM5FP8YA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH for-4.0] include/qemu/bswap.h: Use
 __builtin_memcpy() in accessor functions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, "patches@linaro.org" <patches@linaro.org>, =?UTF-8?Q?Fernando_Casas_Sch=C3=B6ssow?= <casasfernando@outlook.com>, Richard Henderson <richard.henderson@linaro.org>, Stefan Hajnoczi <stefanha@redhat.com>

On Mon, 18 Mar 2019 at 17:07, Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> On 18/03/19 12:29, Peter Maydell wrote:
> > In the accessor functions ld*_he_p() and st*_he_p() we use memcpy()
> > to perform a load or store to a pointer which might not be aligned
> > for the size of the type. We rely on the compiler to optimize this
> > memcpy() into an efficient load or store instruction where possible.
> > This is required for good performance, but at the moment it is also
> > required for correct operation, because some users of these functions
> > require that the access is atomic if the pointer is aligned, which
> > will only be the case if the compiler has optimized out the memcpy().
> > (The particular example where we discovered this is the virtio
> > vring_avail_idx() which calls virtio_lduw_phys_cached() which
> > eventually ends up calling lduw_he_p().)
> >
> > Unfortunately some compile environments, such as the fortify-source
> > setup used in Alpine Linux, define memcpy() to a wrapper function
> > in a way that inhibits this compiler optimization.
> >
> > The correct long-term fix here is to add a set of functions for
> > doing atomic accesses into AddressSpaces (and to other relevant
> > families of accessor functions like the virtio_*_phys_cached()
> > ones), and make sure that callsites which want atomic behaviour
> > use the correct functions.
> >
> > In the meantime, switch to using __builtin_memcpy() in the
> > bswap.h accessor functions. This will make us robust against things
> > like this fortify library in the short term. In the longer term
> > it will mean that we don't end up with these functions being really
> > badly-performing even if the semantics of the out-of-line memcpy()
> > are correct.
> >
> > Reported-by: Fernando Casas Sch=C3=B6ssow <casasfernando@outlook.com>
> > Signed-off-by: Peter Maydell <peter.maydell@linaro.org>


> Queued, thanks.

Ping? This hasn't hit master yet, and today is the last day
for rc3 which I'm hoping might be the last rc for 4.0...

thanks
-- PMM
