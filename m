Received: from eggs.gnu.org ([2001:4830:134:3::10]:40201)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aurelien@aurel32.net>) id 1dFnKV-0007WI-4V
	for qemu-devel@nongnu.org; Tue, 30 May 2017 16:01:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aurelien@aurel32.net>) id 1dFnKU-0004LN-1h
	for qemu-devel@nongnu.org; Tue, 30 May 2017 16:01:23 -0400
Received: from hall.aurel32.net ([2001:bc8:30d7:100::1]:52656)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aurelien@aurel32.net>)
	id 1dFnKT-0004L6-SW
	for qemu-devel@nongnu.org; Tue, 30 May 2017 16:01:22 -0400
Date: Tue, 30 May 2017 22:01:19 +0200
From: Aurelien Jarno <aurelien@aurel32.net>
Message-ID: <20170530200119.j437pdtn36afzew4@aurel32.net>
References: <20170525210508.4910-1-aurelien@aurel32.net>
	<20170525210508.4910-26-aurelien@aurel32.net>
	<c643c6b9-20fb-af8f-2e2f-9a8b6e4c1159@twiddle.net>
	<20170529111718.zmwzwy24fk5mhwgl@aurel32.net>
	<f6104ef5-f9cc-fc1f-553c-d6247cb78dff@twiddle.net>
	<20170530192507.y77widdbdw3q6p3b@aurel32.net>
	<846a7bed-d878-a882-38a6-3c33d70fef26@twiddle.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <846a7bed-d878-a882-38a6-3c33d70fef26@twiddle.net>
Subject: Re: [Qemu-devel] [PATCH 25/26] target/s390x: implement TRANSLATE
 ONE/TWO TO ONE/TWO
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <rth@twiddle.net>
Cc: qemu-devel@nongnu.org, Alexander Graf <agraf@suse.de>

On 2017-05-30 12:42, Richard Henderson wrote:
> On 05/30/2017 12:25 PM, Aurelien Jarno wrote:
> > On 2017-05-30 09:45, Richard Henderson wrote:
> > > On 05/29/2017 04:17 AM, Aurelien Jarno wrote:
> > > > On 2017-05-26 10:10, Richard Henderson wrote:
> > > > > On 05/25/2017 02:05 PM, Aurelien Jarno wrote:
> > > > > > +uint32_t HELPER(trXX)(CPUS390XState *env, uint32_t r1, uint32_t r2,
> > > > > > +                      uint32_t sizes)
> > > > > > +{
> > > > > > +    uintptr_t ra = GETPC();
> > > > > > +    int dsize = (sizes & 1) ? 1 : 2;
> > > > > > +    int ssize = (sizes & 2) ? 1 : 2;
> > > > > > +    uint16_t tst = env->regs[0] & ((1 << (8 * dsize)) - 1);
> > > > > 
> > > > > I think you should pass in tst as an argument.  That way you can pass in an
> > > > > out-of-band value when we implement ETF2 and test field M3 bit 3.
> > > > 
> > > > I don't mind passing r0 as an argument. That said if we want to pass tst
> > > > or bundle the M3 field, it means we need to use TCG instructions to do
> > > > so. I am not sure it brings a lot compare to doing so in the helper
> > > > side.
> > > 
> > > Not at all -- the M3 bit test would be a translation-time check.
> > 
> > I still don't really see the point. On the TCG side it means we need
> > something like that:
> > 
> >      if (m3 & 1) {
> >         tcg_gen_movi_tl(r0, -1);
> >      } else if (dsize == 1) {
> >         tcg_gen_ext8u(r0, regs[0]);
> >      } else if (dsize == 2)
> >         tcg_gen_ext16u(r0, regs[0]);
> >      }
> 
> Yes, exactly.
> 
> > On the helper side we then need to check if the value passed equals -1
> > or not to get m3 instead of directly accessing the value in register 0.
> 
> How's that?  Why would you need to check for -1 at all?  The existing helper
> test works fine, with -1 not matching any value loaded.

Ok, I get your point now, i'll implement that in the next version. 

-- 
Aurelien Jarno                          GPG: 4096R/1DDD8C9B
aurelien@aurel32.net                 http://www.aurel32.net
