Received: from eggs.gnu.org ([209.51.188.92]:51894)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gyOyv-0001os-N7
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 17:44:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gyOyu-0008Ap-Ro
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 17:44:17 -0500
Date: Mon, 25 Feb 2019 23:44:09 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20190225234409.200a2bb6.cohuck@redhat.com>
In-Reply-To: <83bc9314-cf22-7614-d01d-acf5e745eddb@redhat.com>
References: <20190225200318.16102-1-david@redhat.com>
	<20190225200318.16102-4-david@redhat.com>
	<83bc9314-cf22-7614-d01d-acf5e745eddb@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 3/7] s390x/tcg: Clarify terminology in
 vec_reg_offset()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, Thomas Huth <thuth@redhat.com>, Richard Henderson <rth@twiddle.net>

On Mon, 25 Feb 2019 23:28:27 +0100
David Hildenbrand <david@redhat.com> wrote:

> On 25.02.19 21:03, David Hildenbrand wrote:
> > We will use s390x speak "Element Size" (es) for MO_8 == 0, MO_16 == 1
> > ... Simple rename of variables.
> > 
> > Reviewed-by: Thomas Huth <thuth@redhat.com>
> > Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> > Signed-off-by: David Hildenbrand <david@redhat.com>
> > ---
> >  target/s390x/translate.c | 11 ++++++-----
> >  1 file changed, 6 insertions(+), 5 deletions(-)
> > 
> > diff --git a/target/s390x/translate.c b/target/s390x/translate.c
> > index c646e50eb3..5e3955e4d7 100644
> > --- a/target/s390x/translate.c
> > +++ b/target/s390x/translate.c
> > @@ -145,10 +145,11 @@ void s390x_translate_init(void)
> >      }
> >  }
> >  
> > -static inline int vec_reg_offset(uint8_t reg, uint8_t enr, TCGMemOp size)
> > +static inline int vec_reg_offset(uint8_t reg, uint8_t enr, TCGMemOp es)
> >  {
> > -    const uint8_t es = 1 << size;
> > -    int offs = enr * es;
> > +    /* Convert element size (es) - e.g. MO_U8 - to bytes */  
> 
> s/MO_U8/MO_8/  :(
> 
> Conny, I assume you can fix that up in case there are no other comments.
> Thanks!

Sure, no problem.

> 
> > +    const uint8_t bytes = 1 << es;
> > +    int offs = enr * bytes;
> >  
> >      g_assert(reg < 32);
> >      /*
> > @@ -173,9 +174,9 @@ static inline int vec_reg_offset(uint8_t reg, uint8_t enr, TCGMemOp size)
> >       * the two 8 byte elements have to be loaded separately. Let's force all
> >       * 16 byte operations to handle it in a special way.
> >       */
> > -    g_assert(size <= MO_64);
> > +    g_assert(es <= MO_64);
> >  #ifndef HOST_WORDS_BIGENDIAN
> > -    offs ^= (8 - es);
> > +    offs ^= (8 - bytes);
> >  #endif
> >      return offs + offsetof(CPUS390XState, vregs[reg][0].d);
> >  }
> >   
> 
> 
