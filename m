Received: from eggs.gnu.org ([2001:4830:134:3::10]:45077)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eJzb3-0001cK-5q
	for qemu-devel@nongnu.org; Wed, 29 Nov 2017 05:28:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eJzb2-0007LM-7p
	for qemu-devel@nongnu.org; Wed, 29 Nov 2017 05:28:05 -0500
Received: from mail-oi0-x22b.google.com ([2607:f8b0:4003:c06::22b]:43550)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eJzb2-0007K0-3O
	for qemu-devel@nongnu.org; Wed, 29 Nov 2017 05:28:04 -0500
Received: by mail-oi0-x22b.google.com with SMTP id f69so2032598oig.10
	for <qemu-devel@nongnu.org>; Wed, 29 Nov 2017 02:28:04 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CAGC02hT7OvR1nbyD=AkOqPvxbNPz957=CPZsUxf1FJ73O8W52g@mail.gmail.com>
References: <CAGC02hTe8SijuwrM0ZGg04=To0GBnPUrC23iKuc-pao65vAAUQ@mail.gmail.com>
	<b36b0c95-4ddc-b818-522c-1bbec52138e8@adacore.com>
	<CAGC02hT7OvR1nbyD=AkOqPvxbNPz957=CPZsUxf1FJ73O8W52g@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 29 Nov 2017 10:27:42 +0000
Message-ID: <CAFEAcA8eDeKBnLW45=fPt3NeApMkvkiJzFEshvep_5qmwZKGXA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [Bug 645662] x87 fpu emulation not accurate enough
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: william lin <wlsaidhi@gmail.com>
Cc: KONRAD Frederic <frederic.konrad@adacore.com>, QEMU Developers <qemu-devel@nongnu.org>

On 29 November 2017 at 09:59, william lin <wlsaidhi@gmail.com> wrote:
> This bug has been around for 7+ years now. Qemu switched to softfloat and
> it did not fix this. I think its most likely caused by Qemu's internal
> representation not being accurate enough or accuracy lost during
> conversion. However this is basically what is given to us in the bug
> report, and I have not been able to make much progress past this point, so
> we are asking for help.

Looking at the bug, it seems like inaccuracies in the results of
some of the transcendental operations (sin, cos, etc). This is
almost certainly the because our implementations of these in
target/i386/fpu_helper.c do this:

void helper_fsin(CPUX86State *env)
{
    double fptemp = floatx80_to_double(env, ST0);

    if ((fptemp > MAXTAN) || (fptemp < -MAXTAN)) {
        env->fpus |= 0x400;
    } else {
        ST0 = double_to_floatx80(env, sin(fptemp));
        env->fpus &= ~0x400;  /* C2 <-- 0 */
        /* the above code is for |arg| < 2**53 only */
    }
}

ie convert the 80-bit value in the emulated FPU to a host double,
call the host libc sin() function and convert the resulting
double to 80-bit.

Fixing this to be bit-for-bit accurate will require that we
write our own transcendental arithmetic functions that can handle
80-bit precision, which is a bit of a hairy task. (Probably all the
functions that call floatx80_to_double() would need to be rewritten.
We currently use this approach for the "complicated" operations
that the x87 provides but which softfloat doesn't: sin, cos,
powers, logs, that sort of thing.)

I was going to suggest that we borrow the code to do this from
bochs, which does seem to have implemented complete software
emulation of these complicated x87 instructions, but unfortunately
the relevant files in bochs are under the softfloat-2b license, which
isn't (by the QEMU project's reading of the license) compatible
with the GPLv2 which we use :-(

thanks
-- PMM
