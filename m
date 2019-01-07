Received: from eggs.gnu.org ([209.51.188.92]:54604)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1ggUF9-0007nD-2j
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 07:43:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1ggUF8-0008OG-33
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 07:42:59 -0500
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:54156)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1ggUF7-0008N7-RT
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 07:42:58 -0500
Received: by mail-wm1-x344.google.com with SMTP id d15so751293wmb.3
	for <qemu-devel@nongnu.org>; Mon, 07 Jan 2019 04:42:57 -0800 (PST)
References: <20181220111008.24954-1-alex.bennee@linaro.org>
	<20181221193037.GB11197@flamenco>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20181221193037.GB11197@flamenco>
Date: Mon, 07 Jan 2019 12:42:55 +0000
Message-ID: <87k1jgvdtc.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC PATCH] fpu: add compile time check for old
 glibc/libm and fma
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>
Cc: qemu-devel@nongnu.org, laurent.desnogues@gmail.com, Aurelien Jarno <aurelien@aurel32.net>, Peter Maydell <peter.maydell@linaro.org>


Emilio G. Cota <cota@braap.org> writes:

> On Thu, Dec 20, 2018 at 11:10:08 +0000, Alex Benn=C3=A9e wrote:
> (snip)
>> +#if defined(__GLIBC__) && (__GLIBC__ =3D=3D 2 && __GLIBC_MINOR__ <=3D 1=
2)
>> +#define QEMU_HARDFLOAT_USE_FMA 0
>> +#else
>> +#define QEMU_HARDFLOAT_USE_FMA 1
>> +#endif
>> +#else
>> +#define QEMU_HARDFLOAT_USE_FMA 1
>> +#endif
>> +
>>  /*
>>   * QEMU_HARDFLOAT_USE_ISINF chooses whether to use isinf() over
>>   * float{32,64}_is_infinity when !USE_FP.
>> @@ -1551,6 +1570,9 @@ float32_muladd(float32 xa, float32 xb, float32 xc,=
 int flags, float_status *s)
>>      ub.s =3D xb;
>>      uc.s =3D xc;
>>
>> +    if (!QEMU_HARDFLOAT_USE_FMA) {
>> +        goto soft;
>> +    }
>
> I don't think this should be a compile-time check; if the QEMU binary
> is run on a system with a newer, fixed glibc (or any other libc), then
> we'll have disabled fma hardfloat unnecessarily.
>
> What do you think about the following?
>
> Laurent: if you want to test the below, you can pull it from
>    https://github.com/cota/qemu/tree/fma-fix
>
> Thanks,
>
> 		Emilio
> ---
> commit ddeec29a2c33550c5d018aeea05d45a23579ae1b
> Author: Emilio G. Cota <cota@braap.org>
> Date:   Fri Dec 21 14:08:57 2018 -0500
>
>     softfloat: enforce softfloat if the host's FMA is broken
>
>     The added branch is marked as unlikely and therefore its impact
>     on performance (measured with fp-bench) is within the noise range
>     when measured on an Intel(R) Xeon(R) Gold 6142 CPU @ 2.60GHz.
>
>     Laurent Desnogues <laurent.desnogues@gmail.com>
>     Signed-off-by: Emilio G. Cota <cota@braap.org>

I've applied b8cc3928cee7b1d91bf39c86bec4801b9dc612e1 from your tree to
fpu/next although the numbers look a bit odd. I see:

Before:
  143.83 MFlops
  89.34 MFlops

After:
  150.20 MFlops
  85.73 MFlops

On my i7-4770 where as your commit seems to show a big jump in
performance which is odd as this is preventing a bug not enabling FMA.

> +
> +static void __attribute__((constructor)) softfloat_init(void)
> +{
> +    union_float64 ua, ub, uc, ur;
> +
> +    if (QEMU_NO_HARDFLOAT) {
> +        return;
> +    }
> +
> +    /*
> +     * Test that the host's FMA is not obviously broken. For example,
> +     * glibc < 2.23 can perform an incorrect FMA on certain hosts; see
> +     *   https://sourceware.org/bugzilla/show_bug.cgi?id=3D13304
> +     */
> +    ua.s =3D 0x0020000000000001;
> +    ub.s =3D 0x3ca0000000000000;
> +    uc.s =3D 0x0020000000000000;
> +    ur.h =3D fma(ua.h, ub.h, uc.h);
> +    if (ur.s !=3D 0x0020000000000001) {
> +        host_fma_is_broken =3D true;
> +    }
> +}

I'm fine with the cpuid stuff at the bottom of softfloat for now. We can
move it later if the other micro-architectures want to get in on the
detecting features game.

--
Alex Benn=C3=A9e
