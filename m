Received: from eggs.gnu.org ([2001:4830:134:3::10]:52489)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aurelien@aurel32.net>) id 1dFKHc-0005wk-Dk
	for qemu-devel@nongnu.org; Mon, 29 May 2017 09:00:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aurelien@aurel32.net>) id 1dFKHb-0007qa-AS
	for qemu-devel@nongnu.org; Mon, 29 May 2017 09:00:28 -0400
Received: from hall.aurel32.net ([2001:bc8:30d7:100::1]:40200)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aurelien@aurel32.net>)
	id 1dFKHb-0007qG-3x
	for qemu-devel@nongnu.org; Mon, 29 May 2017 09:00:27 -0400
Date: Mon, 29 May 2017 15:00:23 +0200
From: Aurelien Jarno <aurelien@aurel32.net>
Message-ID: <20170529130023.shiehjlyukyw43ii@aurel32.net>
References: <20170525210508.4910-1-aurelien@aurel32.net>
	<20170525210508.4910-17-aurelien@aurel32.net>
	<4c5d7238-d681-61a6-f793-0c8929b85ce0@twiddle.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4c5d7238-d681-61a6-f793-0c8929b85ce0@twiddle.net>
Subject: Re: [Qemu-devel] [PATCH 16/26] target/s390x: implement COMPARE
 LOGICAL LONG
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

On 2017-05-26 08:32, Richard Henderson wrote:
> On 05/25/2017 02:04 PM, Aurelien Jarno wrote:
> > -        if (srclen) {
> > -            v1 = cpu_ldub_data_ra(env, src, ra);
> > +        if (*srclen) {
> > +            v1 = cpu_ldub_data_ra(env, *src, ra);
> >           }
> > -        if (destlen) {
> > -            v2 = cpu_ldub_data_ra(env, dest, ra);
> > +        if (*destlen) {
> > +            v2 = cpu_ldub_data_ra(env, *dest, ra);
> >           }
> >           if (v1 != v2) {
> > @@ -746,16 +743,55 @@ uint32_t HELPER(clcle)(CPUS390XState *env, uint32_t r1, uint64_t a2,
> >               break;
> >           }
> > -        if (srclen) {
> > -            src++;
> > -            srclen--;
> > +        if (*srclen) {
> > +            *src += 1;
> > +            *srclen -= 1;
> >           }
> > -        if (destlen) {
> > -            dest++;
> > -            destlen--;
> > +        if (*destlen) {
> > +            *dest += 1;
> > +            *destlen -= 1;
> >           }
> >       }
> 
> If you don't access these as pointers in the inner loop like this, the
> compiler will give you better code without needing to force the function to
> be inlined.

I agree that it would allow to drop the inline from the pointers point of
view. That said we still want to the compiler to optimize out the call to
cpu_ldusize_data_ra, check_alignment (both introduced in the CLCLU
patch), or length limit.

My goal of using a common code for clcl/clcle/clclu was mostly to unify
code to having different bugs depending on the function. That could also
have been done using the preprocessor.

-- 
Aurelien Jarno                          GPG: 4096R/1DDD8C9B
aurelien@aurel32.net                 http://www.aurel32.net
