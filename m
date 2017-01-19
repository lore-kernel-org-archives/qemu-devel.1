Received: from eggs.gnu.org ([2001:4830:134:3::10]:56096)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <batuzovk@ispras.ru>) id 1cUCOH-00063a-1c
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 08:04:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <batuzovk@ispras.ru>) id 1cUCOD-000507-SL
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 08:04:33 -0500
Received: from bran.ispras.ru ([83.149.199.196]:54159 helo=smtp.ispras.ru)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <batuzovk@ispras.ru>) id 1cUCOD-0004zI-Jo
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 08:04:29 -0500
Date: Thu, 19 Jan 2017 16:04:26 +0300 (MSK)
From: Kirill Batuzov <batuzovk@ispras.ru>
In-Reply-To: <4d351b53-8724-b245-0077-942de1bebd66@twiddle.net>
Message-ID: <alpine.DEB.2.11.1701191515580.1724@bulbul.intra.ispras.ru>
References: <1484644078-21312-1-git-send-email-batuzovk@ispras.ru>
	<1484644078-21312-2-git-send-email-batuzovk@ispras.ru>
	<4d351b53-8724-b245-0077-942de1bebd66@twiddle.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Subject: Re: [Qemu-devel] [PATCH 01/18] tcg: add support for 128bit vector
 type
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <rth@twiddle.net>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>

On Wed, 18 Jan 2017, Richard Henderson wrote:

> On 01/17/2017 01:07 AM, Kirill Batuzov wrote:
> > +static inline TCGv_v128 tcg_global_mem_new_v128(TCGv_ptr reg, intptr_t
> > offset,
> > +                                                const char *name)
> > +{
> > +    int idx = tcg_global_mem_new_internal(TCG_TYPE_V128, reg, offset,
> > name);
> > +    return MAKE_TCGV_V128(idx);
> > +}
> 
> You shouldn't allow a v128 type to be created if the host doesn't support it.

The idea here was to create it either way, but make sure no operation
will ever be issued if host does not support it (tcg_gen_* wrappers take
care of this).

> 
> You may want to treat v128 as a pair of v64 if the host supports that.
> Although there's limited applicability there, since only minor hosts (MIPS,
> Sparc, ia64) have 64-bit-only vector extensions.
> 
> That said, treating v128 as 2 x v64 scales nicely when we add v256.  Which, if
> we've already gone this far, is clearly how avx2 guest support should be
> implemented.
> 
> For hosts that have had no vector support added, you may want to represent
> v128 as 2 x i64, for the purpose of intermediate expansion.
>

I'm not sure about this last part. The host may not have i64, so there
should be another case - 4 x i32. So we'll get 4 cases for v128:

v128
2 x v64
2 x i64
4 x i32

3 cases will need to be added to tcg_temp_new_internal and
tcg_global_new_mem_internal, two of which are rather useless (2 x i64, 4 x i32).
Introduction of v256 will add 4 more cases two of which will be useless
again. This sounds like too much code that serves no purpose to me.

Maybe we can only adapt 2 x v64 (and later 2 x v128 and may be 4 x v64)
cases and just generate v128 temp that'll never be used if none of these
worked?

-- 
Kirill
