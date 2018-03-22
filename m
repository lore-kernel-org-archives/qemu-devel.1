Received: from eggs.gnu.org ([2001:4830:134:3::10]:51035)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1ez1pL-0006Xx-TL
	for qemu-devel@nongnu.org; Thu, 22 Mar 2018 11:08:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1ez1pH-0007DP-Mk
	for qemu-devel@nongnu.org; Thu, 22 Mar 2018 11:08:27 -0400
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:42733)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1ez1pH-0007C7-Gh
	for qemu-devel@nongnu.org; Thu, 22 Mar 2018 11:08:23 -0400
Date: Thu, 22 Mar 2018 11:08:21 -0400
From: "Emilio G. Cota" <cota@braap.org>
Message-ID: <20180322150821.GA10288@flamenco>
References: <1521663109-32262-1-git-send-email-cota@braap.org>
	<1521663109-32262-9-git-send-email-cota@braap.org>
	<67b8c0f8-3fd9-ba7c-a666-d0715b5a3329@linaro.org>
	<20180322055710.GA22376@flamenco>
	<959d13eb-498e-0bd6-2553-1b621a87f1bd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <959d13eb-498e-0bd6-2553-1b621a87f1bd@linaro.org>
Subject: Re: [Qemu-devel] [PATCH v1 08/14] hostfloat: support float32/64
 addition and subtraction
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, Aurelien Jarno <aurelien@aurel32.net>, Peter Maydell <peter.maydell@linaro.org>, Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>, Laurent Vivier <laurent@vivier.eu>, Paolo Bonzini <pbonzini@redhat.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

On Thu, Mar 22, 2018 at 14:41:05 +0800, Richard Henderson wrote:
> On 03/22/2018 01:57 PM, Emilio G. Cota wrote:
> >> Is there any especially good reason you want to not put this code into the
> >> normal softfloat function?  Does it really many any measurable difference at
> >> all to force this code to be inlined into a helper?
(snip)
> Well, not quite.  I meant putting all of the new code into softfloat.c,

I put all this in a separate file because I didn't want to spend time
trying to understand the licensing of softfloat. It isn't clear to
me whether what goes into softfloat.[ch] is only GPL'ed or also BSD'ed.

> and not
> attempting to inline any of it in target/cpu/foo_helper.c.

Unless I've made a mistake, I have not tried to inline anything in
target/*helper*.c

> The best written target helpers currently simply tail-call to softfloat.c.
> There are others that do so after minor argument adjustment.  For these, I have
> had in my plans to rearrange things such that e.g. float32_add is called from
> TCG directly, with no other function calls at all.

Yes, this is definitely worth trying.

> For targets that cannot do that, I simply cannot bring myself to care about the
> final percentage points enough to want to introduce extra macros.

Agreed.

> Another thought re all of the soft_is_normal || soft_is_zero checks that you're
> performing.  I think it would be nice if we could work with
> float*_unpack_canonical so that we don't have to duplicate work.  E.g.
> 
> /* Return true for float_class_normal && float_class_zero.  */
> static inline bool is_finite(FloatClass c) { return c <= float_class_zero; }
> 
> float32 float32_add(float32 a, float32 b, float_status *s)
> {
>   FloatClass a_cls = float32_classify(a);
>   FloatClass b_cls = float32_classify(b);
> 
>   if (is_finite(a_cls) && is_finite(b_cls) && ...) {
>       /* do hardfp thing */
>   }
> 
>   pa = float32_unpack(a, ca, s);
>   pb = float32_unpack(b, cb, s);
>   pr = addsub_floats(pa, pb, s, false);
>   return float32_round_pack(pr, s);
> }
> 
> Where float32_classify produces Normal/Zero/Inf/NaN and might avoid duplicate
> work within float32_unpack.

I'll look into this.

Thanks,

		Emilio
