Received: from eggs.gnu.org ([2001:4830:134:3::10]:41985)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aurelien@aurel32.net>) id 1dW7pY-0005R1-27
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 17:08:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aurelien@aurel32.net>) id 1dW7pX-0007M2-2h
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 17:08:55 -0400
Received: from hall.aurel32.net ([2001:bc8:30d7:100::1]:40896)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aurelien@aurel32.net>)
	id 1dW7pW-0007LX-SR
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 17:08:55 -0400
Date: Fri, 14 Jul 2017 23:08:53 +0200
From: Aurelien Jarno <aurelien@aurel32.net>
Message-ID: <20170714210853.ofowponstnf6ncgo@aurel32.net>
References: <20170710204521.2058-1-rth@twiddle.net>
	<20170710204521.2058-3-rth@twiddle.net>
	<fc0ca76b-ecee-1f38-166b-4dcd8d7dcd00@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fc0ca76b-ecee-1f38-166b-4dcd8d7dcd00@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3 2/8] target/s390x: Implement CONVERT
 UNICODE insns
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: Richard Henderson <rth@twiddle.net>, qemu-devel@nongnu.org, david@redhat.com

On 2017-07-11 17:18, Thomas Huth wrote:
> On 10.07.2017 22:45, Richard Henderson wrote:
> > Signed-off-by: Richard Henderson <rth@twiddle.net>
> > ---
> >  target/s390x/helper.h      |   6 +
> >  target/s390x/mem_helper.c  | 310 +++++++++++++++++++++++++++++++++++++++++++++
> >  target/s390x/translate.c   |  43 +++++++
> >  target/s390x/insn-data.def |  13 ++
> >  4 files changed, 372 insertions(+)
> > 
> > diff --git a/target/s390x/helper.h b/target/s390x/helper.h
> > index 23e8d1d..2793cf3 100644
> > --- a/target/s390x/helper.h
> > +++ b/target/s390x/helper.h
> > @@ -107,6 +107,12 @@ DEF_HELPER_2(stfle, i32, env, i64)
> >  DEF_HELPER_FLAGS_2(lpq, TCG_CALL_NO_WG, i64, env, i64)
> >  DEF_HELPER_FLAGS_4(stpq, TCG_CALL_NO_WG, void, env, i64, i64, i64)
> >  DEF_HELPER_4(mvcos, i32, env, i64, i64, i64)
> > +DEF_HELPER_4(cu12, i32, env, i32, i32, i32)
> > +DEF_HELPER_4(cu14, i32, env, i32, i32, i32)
> > +DEF_HELPER_4(cu21, i32, env, i32, i32, i32)
> > +DEF_HELPER_4(cu24, i32, env, i32, i32, i32)
> > +DEF_HELPER_4(cu41, i32, env, i32, i32, i32)
> > +DEF_HELPER_4(cu42, i32, env, i32, i32, i32)
> >  
> >  #ifndef CONFIG_USER_ONLY
> >  DEF_HELPER_3(servc, i32, env, i64, i64)
> > diff --git a/target/s390x/mem_helper.c b/target/s390x/mem_helper.c
> > index 513b402..0b18560 100644
> > --- a/target/s390x/mem_helper.c
> > +++ b/target/s390x/mem_helper.c
> [...]
> > +static inline uint32_t convert_unicode(CPUS390XState *env, uint32_t r1,
> > +                                       uint32_t r2, uint32_t m3, uintptr_t ra,
> > +                                       decode_unicode_fn decode,
> > +                                       encode_unicode_fn encode)
> > +{
> > +    uint64_t dst = get_address(env, r1);
> > +    uint64_t dlen = get_length(env, r1 + 1);
> > +    uint64_t src = get_address(env, r2);
> > +    uint64_t slen = get_length(env, r2 + 1);
> > +    bool enh_check = m3 & 1;
> > +    int cc, i;
> 
> According to the PoP:
> 
> "The R1 and R2 fields [...] must designate an even-
>  numbered register; otherwise, a specification excep-
>  tion is recognized."
> 
> I think you should add such a check for even-numbered registers here.

Actually it should not be done here, but at translation time in
translate.c.

There are a few places where the register number is checked to be even
and later loaded into a temp. I guess that can be replaced by generators
instead?

-- 
Aurelien Jarno                          GPG: 4096R/1DDD8C9B
aurelien@aurel32.net                 http://www.aurel32.net
