Received: from eggs.gnu.org ([2001:4830:134:3::10]:38186)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gQK21-0007cg-Tb
	for qemu-devel@nongnu.org; Fri, 23 Nov 2018 17:34:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gQK1v-0006j6-AS
	for qemu-devel@nongnu.org; Fri, 23 Nov 2018 17:34:37 -0500
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:45429)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1gQK1u-0006ZE-K5
	for qemu-devel@nongnu.org; Fri, 23 Nov 2018 17:34:30 -0500
Date: Fri, 23 Nov 2018 17:34:25 -0500
From: "Emilio G. Cota" <cota@braap.org>
Message-ID: <20181123223425.GA15767@flamenco>
References: <20181025172057.20414-1-cota@braap.org>
	<20181025172057.20414-14-cota@braap.org>
	<87zhu1ghjr.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87zhu1ghjr.fsf@linaro.org>
Subject: Re: [Qemu-devel] [RFC 13/48] xxhash: add qemu_xxhash8
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>, =?iso-8859-1?Q?Llu=EDs?= Vilanova <vilanova@ac.upc.edu>, Peter Maydell <peter.maydell@linaro.org>, Stefan Hajnoczi <stefanha@gmail.com>

On Thu, Nov 22, 2018 at 17:15:20 +0000, Alex Bennée wrote:
> 
> Emilio G. Cota <cota@braap.org> writes:
> 
> > It will be used for TB hashing soon.
> >
> > Signed-off-by: Emilio G. Cota <cota@braap.org>
> > ---
> >  include/qemu/xxhash.h | 40 +++++++++++++++++++++++++++-------------
> >  1 file changed, 27 insertions(+), 13 deletions(-)
> >
> > diff --git a/include/qemu/xxhash.h b/include/qemu/xxhash.h
> > index fe35dde328..450427eeaa 100644
> > --- a/include/qemu/xxhash.h
> > +++ b/include/qemu/xxhash.h
> > @@ -49,7 +49,8 @@
> >   * contiguous in memory.
> >   */
> >  static inline uint32_t
> > -qemu_xxhash7(uint64_t ab, uint64_t cd, uint32_t e, uint32_t f, uint32_t g)
> > +qemu_xxhash8(uint64_t ab, uint64_t cd, uint32_t e, uint32_t f, uint32_t g,
> > +             uint32_t h)
> 
> As we've expanded to bigger and bigger hashes why are everything after
> cd passed as 32 bit values? Isn't this just generating extra register
> pressure or is the compiler smart enough to figure it out?

The latter -- the compiler does a good job with constant propagation.

> >  {
> >      uint32_t v1 = QEMU_XXHASH_SEED + PRIME32_1 + PRIME32_2;
> >      uint32_t v2 = QEMU_XXHASH_SEED + PRIME32_2;
> > @@ -77,17 +78,24 @@ qemu_xxhash7(uint64_t ab, uint64_t cd, uint32_t e, uint32_t f, uint32_t g)
> >      v4 = rol32(v4, 13);
> >      v4 *= PRIME32_1;
> >
> > -    h32 = rol32(v1, 1) + rol32(v2, 7) + rol32(v3, 12) + rol32(v4, 18);
> > -    h32 += 28;
> > +    v1 += e * PRIME32_2;
> > +    v1 = rol32(v1, 13);
> > +    v1 *= PRIME32_1;
(snip)
> How do we validate we haven't broken the distribution of the original
> xxhash as we've extended it?

We weren't testing for that, so this is a valid concern.

I just added a test to my xxhash repo to compare our version against
the original:
  https://github.com/cota/xxhash/tree/qemu

Turns out that to exactly match the original we just have to swap our
a/b and c/d pairs. I don't see how this could cause a loss of randomness,
but just to be safe I'll send a for-4.0 patch so that our output matches
the original one.

Thanks,

		Emilio
