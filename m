Received: from eggs.gnu.org ([209.51.188.92]:49588)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hFjaF-0005GC-28
	for qemu-devel@nongnu.org; Sun, 14 Apr 2019 14:10:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hFjSj-0004ez-2N
	for qemu-devel@nongnu.org; Sun, 14 Apr 2019 14:02:41 -0400
Received: from mail-oi1-x230.google.com ([2607:f8b0:4864:20::230]:43798)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hFjSi-0004df-Pz
	for qemu-devel@nongnu.org; Sun, 14 Apr 2019 14:02:41 -0400
Received: by mail-oi1-x230.google.com with SMTP id t81so11932102oig.10
	for <qemu-devel@nongnu.org>; Sun, 14 Apr 2019 11:02:39 -0700 (PDT)
MIME-Version: 1.0
References: <20190411153942.4533-1-peter.maydell@linaro.org>
	<53930e87-3bb1-fdd5-a8fe-8603c0adecc2@linaro.org>
In-Reply-To: <53930e87-3bb1-fdd5-a8fe-8603c0adecc2@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sun, 14 Apr 2019 19:02:28 +0100
Message-ID: <CAFEAcA-dbGvhgTrBKEtx-CPS7f2NJO5X+dj=mdcm+NrkF=uynQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] target/arm: Implement NSACR gating of
 floating point
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>

On Sat, 13 Apr 2019 at 08:07, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> On 4/11/19 5:39 AM, Peter Maydell wrote:
> > +static uint64_t cptr_el2_read(CPUARMState *env, const ARMCPRegInfo *ri)
> > +{
> > +    /*
> > +     * For A-profile AArch32 EL3, if NSACR.CP10
> > +     * is 0 then HCPTR.{TCP11,TCP10} ignore writes and read as 1.
> > +     */
> > +    uint64_t value = env->cp15.cptr_el[2];
> > +
> > +    if (arm_feature(env, ARM_FEATURE_EL3) && !arm_el_is_aa64(env, 3) &&
> > +        !arm_is_secure(env) && !extract32(env->cp15.nsacr, 10, 1)) {
> > +        value &= ~(0x3 << 10);
>
> Read as 1, and yet you're clearing the value?  Cut-n-paste error from CPACR?
> Surely better to do nothing on read, but set on write (to either HCPTR or NSACR).

The spec says the HCPTR bits must "behave as RAO/WI, regardless of
their actual value", which I interpret as being 'we must make
read and write do RAO/WI but preserve whatever the underlying
bit values happen to be'. You're right that I've incorrectly
made it clear the bits rather than set them, though.

> > +static uint64_t cpacr_read(CPUARMState *env, const ARMCPRegInfo *ri)
> > +{
> > +    /*
> > +     * For A-profile AArch32 EL3 (but not M-profile secure mode), if NSACR.CP10
> > +     * is 0 then CPACR.{CP11,CP10} ignore writes and read as 0b00.
> > +     */
> > +    uint64_t value = env->cp15.cpacr_el1;
> > +
> > +    if (arm_feature(env, ARM_FEATURE_EL3) && !arm_el_is_aa64(env, 3) &&
> > +        !arm_is_secure(env) && !extract32(env->cp15.nsacr, 10, 1)) {
> > +        value &= ~(0xf << 20);
> > +    }
>
> This one does do the right thing, but better to clear the bits on write to
> NSACR.  This lets you avoid the change to fp_exception_el, and the missing
> change to sve_exception_el.

There's similar wording for the effect of NSACR on CPACR, so
again I think we need to actually make the bits RAZ/WI
regardless of their underlying value, not just force them
to 0.

thanks
-- PMM
