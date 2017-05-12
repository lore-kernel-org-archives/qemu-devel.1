Received: from eggs.gnu.org ([2001:4830:134:3::10]:41048)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aurelien@aurel32.net>) id 1d9G9V-0003nH-0O
	for qemu-devel@nongnu.org; Fri, 12 May 2017 15:23:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aurelien@aurel32.net>) id 1d9G9T-0002H1-Rk
	for qemu-devel@nongnu.org; Fri, 12 May 2017 15:23:01 -0400
Date: Fri, 12 May 2017 21:22:52 +0200
From: Aurelien Jarno <aurelien@aurel32.net>
Message-ID: <20170512192252.hgtpgqfn5vtba362@aurel32.net>
References: <20170512033543.6789-1-f4bug@amsat.org>
	<20170512033543.6789-3-f4bug@amsat.org>
	<f447c23f-f63c-f3bb-a1b9-f63e5aff4063@twiddle.net>
	<20170512182132.jdw4g2pd5gvf2dti@aurel32.net>
	<aaa04be5-78d6-311b-609b-d02f18e9ef96@twiddle.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aaa04be5-78d6-311b-609b-d02f18e9ef96@twiddle.net>
Subject: Re: [Qemu-devel] [PATCH v3 2/5] target/arm: optimize rev16() using
 extract op
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <rth@twiddle.net>
Cc: Philippe =?iso-8859-15?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org

On 2017-05-12 12:05, Richard Henderson wrote:
> On 05/12/2017 11:21 AM, Aurelien Jarno wrote:
> > +    uint64_t mask1 = sf ? 0x00ff00ff00ff00ffull : 0x00ff00ff;
> > +    uint64_t mask2 = sf ? 0xff00ff00ff00ff00ull : 0xff00ff00;
> > +
> > +    tcg_gen_shri_i64(tcg_tmp, tcg_rn, 8);
> > +    tcg_gen_andi_i64(tcg_tmp, tcg_tmp, mask1);
> > +    tcg_gen_shli_i64(tcg_rd, tcg_rn, 8);
> > +    tcg_gen_andi_i64(tcg_rd, tcg_rd, mask2);
> 
> It would probably be better to use a single mask, since they're not free to
> instantiate in a register.  So e.g.
> 
>   TCGv mask = tcg_const_i64(sf ? 0x00ff00ff00ff00ffull : 0x00ff00ff);
>   tcg_gen_shri_i64(tcg_tmp, tcg_rn, 8);
>   tcg_gen_and_i64(tcg_rd, tcg_rn, mask);
>   tcg_gen_and_i64(tcg_tmp, tcg_tmp, mask);
>   tcg_gen_shli_i64(tcg_rd, tcg_rd, 8);

Indeed that improves things a bit for sf=1. For sf=0 though the
constant is never loaded into a register, it is passed to the and
instructions as an immediate.

-- 
Aurelien Jarno                          GPG: 4096R/1DDD8C9B
aurelien@aurel32.net                 http://www.aurel32.net
